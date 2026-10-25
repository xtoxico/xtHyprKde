#!/usr/bin/env python3
"""
Generates high-resolution minimalist Hyprland-style dark wallpaper for xtHyprKde.
"""
import math
from PIL import Image, ImageDraw, ImageFilter

def create_hypr_wallpaper(width=3840, height=2160, output_path="assets/wallpapers/xtHypr_neon.png"):
    # Base image
    img = Image.new("RGBA", (width, height), (15, 15, 23, 255))
    draw = ImageDraw.Draw(img)

    # Vertical gradient
    for y in range(height):
        ratio = y / height
        # Gradient from #0d0d16 to #1a1a2e
        r = int(13 + (26 - 13) * ratio)
        g = int(13 + (26 - 13) * ratio)
        b = int(22 + (46 - 22) * ratio)
        draw.line([(0, y), (width, y)], fill=(r, g, b, 255))

    # Glow layer for soft neon lighting
    glow = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    glow_draw = ImageDraw.Draw(glow)

    cx, cy = width // 2, int(height * 0.48)

    # Neon radial glows in the center
    # Cyan glow (#00f5d4)
    glow_draw.ellipse([cx - 500, cy - 350, cx + 500, cy + 350], fill=(0, 245, 212, 35))
    # Purple/Mauve glow (#cba6f7)
    glow_draw.ellipse([cx - 400, cy - 250, cx + 400, cy + 250], fill=(203, 166, 247, 40))

    glow = glow.filter(ImageFilter.GaussianBlur(120))
    img.alpha_composite(glow)

    # Geometric minimalist shapes in the center
    shape_layer = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(shape_layer)

    # Sleek rotated square / diamond frame (Hyprland style)
    size = 220
    diamond = [
        (cx, cy - size),
        (cx + size, cy),
        (cx, cy + size),
        (cx - size, cy)
    ]
    # Outer diamond with gradient outline
    s_draw.polygon(diamond, outline=(0, 245, 212, 180), width=4)

    # Inner smaller diamond
    isize = 140
    inner_diamond = [
        (cx, cy - isize),
        (cx + isize, cy),
        (cx, cy + isize),
        (cx - isize, cy)
    ]
    s_draw.polygon(inner_diamond, outline=(203, 166, 247, 160), width=3)

    # Center horizontal glowing accent line
    line_w = 400
    s_draw.line([(cx - line_w, cy), (cx - isize - 20, cy)], fill=(0, 245, 212, 140), width=3)
    s_draw.line([(cx + isize + 20, cy), (cx + line_w, cy)], fill=(203, 166, 247, 140), width=3)

    # Ambient subtle bottom terrain / low-poly mountain lines
    points = []
    num_pts = 40
    for i in range(num_pts + 1):
        x = int(i * (width / num_pts))
        wave = math.sin(i * 0.4) * 80 + math.cos(i * 0.8) * 50
        y = int(height * 0.88 + wave)
        points.append((x, y))

    points.append((width, height))
    points.append((0, height))
    s_draw.polygon(points, fill=(18, 18, 29, 180), outline=(0, 245, 212, 40), width=2)

    img.alpha_composite(shape_layer)

    # Save as RGB PNG
    final = img.convert("RGB")
    final.save(output_path, "PNG", quality=95)
    print(f"Wallpaper saved successfully to {output_path}")

if __name__ == "__main__":
    create_hypr_wallpaper()
