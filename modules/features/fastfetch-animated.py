import math
import sys
import time
import subprocess
import signal
import argparse


def parse_hex_color(hex_str):
    hex_str = hex_str.lstrip('#')
    try:
        return tuple(int(hex_str[i:i+2], 16) for i in (0, 2, 4))
    except Exception:
        return (77, 111, 183)


def generate_points(stroke_width, depth):
    local_points = []

    def add_line(p1, p2, color_id):
        dx = p2[0] - p1[0]
        dy = p2[1] - p1[1]
        dz = p2[2] - p1[2]
        dist = math.sqrt(dx*dx + dy*dy + dz*dz)
        steps = int(math.floor(dist * 1.5))  # Density
        if steps == 0:
            local_points.append((p1[0], p1[1], p1[2], color_id))
            return
        for i in range(steps + 1):
            t = i / steps
            local_points.append((
                p1[0] + dx*t,
                p1[1] + dy*t,
                p1[2] + dz*t,
                color_id
            ))

    num_wedges = 6
    # Independent Lambda Rotation
    lambda_rot_x = 0.0
    lambda_rot_y = 180.0 * (math.pi / 180.0)
    lambda_rot_z = 230.0 * (math.pi / 180.0)

    r_center = 14.0

    p_inner_top = (-1.5, 7.0)
    p_outer_left = (-5.0, -7.0)
    p_outer_right = (4.0, -7.0)
    p_crotch = (-3.0, 1.0)

    def make_quad(start, end, w):
        dx = end[0] - start[0]
        dy = end[1] - start[1]
        length = math.sqrt(dx*dx + dy*dy)
        if length == 0:
            return [start, start, start, start]
        nx = -dy / length * (w/2.0)
        ny = dx / length * (w/2.0)
        return [
            (start[0] + nx, start[1] + ny),
            (end[0] + nx, end[1] + ny),
            (end[0] - nx, end[1] - ny),
            (start[0] - nx, start[1] - ny)
        ]

    spine = make_quad(p_inner_top, p_outer_left, stroke_width)
    leg = make_quad(p_crotch, p_outer_right, stroke_width)
    shape_polys = [spine, leg]

    for i in range(num_wedges):
        angle = (i * 60) * math.pi / 180.0

        def transform(p, z_val):
            px = p[0]
            py = p[1]
            pz = z_val

            if lambda_rot_x != 0.0:
                c = math.cos(lambda_rot_x)
                s = math.sin(lambda_rot_x)
                temp_y = py * c - pz * s
                temp_z = py * s + pz * c
                py = temp_y
                pz = temp_z

            if lambda_rot_y != 0.0:
                c = math.cos(lambda_rot_y)
                s = math.sin(lambda_rot_y)
                temp_x = px * c - pz * s
                temp_z = px * s + pz * c
                px = temp_x
                pz = temp_z

            if lambda_rot_z != 0.0:
                c = math.cos(lambda_rot_z)
                s = math.sin(lambda_rot_z)
                temp_x = px * c - py * s
                temp_y = px * s + py * c
                px = temp_x
                py = temp_y

            u = r_center + py
            v = px

            return (
                u * math.cos(angle) - v * math.sin(angle),
                u * math.sin(angle) + v * math.cos(angle),
                pz,
                0 if i % 2 == 0 else 1
            )

        for poly in shape_polys:
            for j in range(len(poly)):
                p_start = poly[j]
                p_end = poly[(j + 1) % len(poly)]

                ts = transform(p_start, -depth)
                te = transform(p_end, -depth)
                add_line(ts[:3], te[:3], ts[3])

                ts2 = transform(p_start, depth)
                te2 = transform(p_end, depth)
                add_line(ts2[:3], te2[:3], ts2[3])

                add_line(ts[:3], ts2[:3], ts[3])

    return local_points


def render_frame(
    angle_x, angle_y, points, logo_width, logo_height, c_dark, c_light
):
    z_buffer = [-float('inf')] * (logo_width * logo_height)
    char_buffer = [None] * (logo_width * logo_height)

    cos_y = math.cos(angle_y)
    sin_y = math.sin(angle_y)
    cos_x = math.cos(angle_x)
    sin_x = math.sin(angle_x)

    dist = 50.0
    r_outer = 24.0

    for px, py, pz, color_id in points:
        x1 = px * cos_y - pz * sin_y
        z1 = px * sin_y + pz * cos_y
        y2 = py * cos_x - z1 * sin_x
        z2 = py * sin_x + z1 * cos_x

        ooz = 1.0 / (z2 + dist)

        scale_x = logo_width * 0.70
        scale_y = logo_height * 0.75

        xp = int(math.floor(logo_width / 2.0 + (x1 * ooz * scale_x * 2.0)))
        yp = int(math.floor(logo_height / 2.0 + (y2 * ooz * scale_y)))

        if 0 <= xp < logo_width and 0 <= yp < logo_height:
            idx = yp * logo_width + xp
            if ooz > z_buffer[idx]:
                z_buffer[idx] = ooz

                lum = (z2 + r_outer) / (r_outer * 2.0)
                palette = ".:-=+*#%@"
                char_idx = int(math.floor(lum * len(palette)))
                char_idx = max(0, min(len(palette) - 1, char_idx))

                char = palette[char_idx]
                color = c_dark if color_id == 0 else c_light
                char_buffer[idx] = (char, color)

    char_grid = []
    for r in range(logo_height):
        char_grid.append(char_buffer[r * logo_width:(r + 1) * logo_width])
    return char_grid


def get_fastfetch_info():
    try:
        res = subprocess.run(
            ["fastfetch", "-l", "none"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if res.returncode == 0:
            return [line.rstrip() for line in res.stdout.splitlines()]
    except Exception:
        pass
    return ["Fastfetch could not be run. Check if fastfetch is installed."]


def sigint_handler(sig, frame):
    sys.stdout.write("\033[?25h\033[?7h\n")
    sys.stdout.flush()
    sys.exit(0)


signal.signal(signal.SIGINT, sigint_handler)


def main():
    parser = argparse.ArgumentParser(
        description=(
            "Fastfetch with a 3D animated NixOS logo "
            "(inspired by fem.gg)"
        )
    )
    parser.add_argument(
        "-d", "--duration", type=float, default=1.5,
        help="Duration to animate in seconds (default: 1.5, 0=infinite)"
    )
    parser.add_argument(
        "-l", "--loop", action="store_true",
        help="Loop the animation indefinitely (same as -d 0)"
    )
    parser.add_argument(
        "--logo-width", type=int, default=44,
        help="Width of the logo in character columns (default: 44)"
    )
    parser.add_argument(
        "--logo-height", type=int, default=27,
        help="Height of the logo in character lines (default: 22)"
    )
    parser.add_argument(
        "-t", "--thickness", type=float, default=2.5,
        help="Thickness of the NixOS logo lines (default: 2.5)"
    )
    parser.add_argument(
        "--depth", type=float, default=2.0,
        help="Depth/thickness of the 3D projection (default: 2.0)"
    )
    parser.add_argument(
        "--color-dark", type=str, default="#4d6fb7",
        help="Hex color code for the dark blue parts (default: #4d6fb7)"
    )
    parser.add_argument(
        "--color-light", type=str, default="#77b6e1",
        help="Hex color code for the light blue parts (default: #77b6e1)"
    )
    parser.add_argument(
        "--speed", type=float, default=2.0,
        help="Multiplier for the speed of rotation (default: 1.0)"
    )
    parser.add_argument(
        "--fps", type=int, default=60,
        help="Target frames per second (default: 30)"
    )
    args = parser.parse_args()

    duration = 0.0 if args.loop else args.duration
    logo_width = args.logo_width
    logo_height = args.logo_height

    c_dark = parse_hex_color(args.color_dark)
    c_light = parse_hex_color(args.color_light)

    points = generate_points(args.thickness, args.depth)
    sys_info = get_fastfetch_info()

    # Hide cursor and disable line wrap
    sys.stdout.write("\033[?25l\033[?7l")
    sys.stdout.flush()

    angle_x = 0.0
    angle_y = 0.0

    last_lines_count = 0
    start_time = time.time()
    frame_delay = 1.0 / args.fps

    try:
        while True:
            char_grid = render_frame(
                angle_x, angle_y, points,
                logo_width, logo_height,
                c_dark, c_light
            )

            lines = []
            max_lines = max(logo_height, len(sys_info))
            for i in range(max_lines):
                logo_part = ""
                if i < logo_height:
                    for j in range(logo_width):
                        pixel = char_grid[i][j]
                        if pixel is None:
                            logo_part += " "
                        else:
                            char, color = pixel
                            r_c, g_c, b_c = color
                            logo_part += (
                                f"\033[38;2;{r_c};{g_c};{b_c}m"
                                f"{char}\033[0m"
                            )
                else:
                    logo_part = " " * logo_width

                sep = "  "
                info_part = sys_info[i] if i < len(sys_info) else ""
                lines.append(logo_part + sep + info_part)

            if last_lines_count > 0:
                sys.stdout.write(f"\033[{last_lines_count}A")

            sys.stdout.write("\n".join(lines) + "\n")
            sys.stdout.flush()

            last_lines_count = len(lines)

            if duration > 0.0 and (time.time() - start_time) >= duration:
                break

            angle_y += 0.03 * args.speed
            angle_x += 0.005 * args.speed

            time.sleep(frame_delay)

    except KeyboardInterrupt:
        pass
    finally:
        # Restore cursor and line wrap on exit
        sys.stdout.write("\033[?25h\033[?7h\n")
        sys.stdout.flush()


if __name__ == "__main__":
    main()
