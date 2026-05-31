#!/bin/bash

# Terminal Color Test Script
# Tests 8, 16, 256, and true colors if supported

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    TERMINAL COLOR TEST SUITE                    ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Function to print color blocks
print_color_block() {
    local fg=$1
    local bg=$2
    local desc=$3
    printf "\e[48;5;%dm\e[38;5;%dm %3d \e[0m" "$bg" "$fg" "$fg"
}

# Test 1: Basic 8/16 ANSI Colors
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. BASIC 8/16 ANSI COLORS (Standard foreground colors)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Foreground colors
for i in {30..37}; do
    printf "\e[%sm %2s \e[0m" "$i" "$i"
done
echo ""
for i in {90..97}; do
    printf "\e[%sm %2s \e[0m" "$i" "$i"
done
echo -e "\n"

# Background colors
echo "Background colors:"
for i in {40..47}; do
    printf "\e[%sm %2s \e[0m" "$i" "$i"
done
echo ""
for i in {100..107}; do
    printf "\e[%sm %2s \e[0m" "$i" "$i"
done
echo -e "\n"

# Test 2: 256 Colors (8-bit)
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2. 256 COLORS (8-bit) - System colors (0-255)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Display 256 colors in a grid
for i in {0..255}; do
    printf "\e[48;5;%dm\e[38;5;15m %3d \e[0m" "$i" "$i"
    if [ $(( (i + 1) % 16 )) -eq 0 ]; then
        echo ""
    fi
done
echo -e "\n"

# Test 3: 256 Color Gradients
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3. 256 COLOR GRADIENTS (Color ranges)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Grayscale (232-255)
echo "Grayscale (232-255):"
for i in {232..255}; do
    printf "\e[48;5;%dm \e[0m" "$i"
done
echo -e "\n"

# Reds (1, 9, 52, 88, 124, 160, 196)
echo "Red spectrum:"
for i in 1 9 52 88 124 160 196; do
    printf "\e[48;5;%dm    \e[0m" "$i"
done
echo -e "\n"

# Greens (2, 10, 22, 28, 34, 40, 46)
echo "Green spectrum:"
for i in 2 10 22 28 34 40 46; do
    printf "\e[48;5;%dm    \e[0m" "$i"
done
echo -e "\n"

# Blues (4, 12, 17, 18, 19, 20, 21)
echo "Blue spectrum:"
for i in 4 12 17 18 19 20 21; do
    printf "\e[48;5;%dm    \e[0m" "$i"
done
echo -e "\n"

# Test 4: True Color (24-bit) - if supported
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4. TRUE COLOR (24-bit) - Gradient test"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if terminal supports true color
if [ "$COLORTERM" = "truecolor" ] || [ "$COLORTERM" = "24bit" ]; then
    # Rainbow gradient
    for i in {0..255}; do
        r=$((i))
        g=$((255 - i))
        b=$((128 + (i % 128)))
        printf "\e[48;2;%d;%d;%dm  \e[0m" "$r" "$g" "$b"
        if [ $(( (i + 1) % 32 )) -eq 0 ]; then
            echo ""
        fi
    done
    echo -e "\n"
else
    echo "⚠ True color (24-bit) not detected. Terminal may not support it."
    echo "  Set COLORTERM=truecolor to enable if your terminal supports it."
    echo -e "\n"
fi

# Test 5: Text Attributes
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5. TEXT ATTRIBUTES (Styles)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -e "\e[1m  Bold text\e[0m"
echo -e "\e[2m  Dim text\e[0m"
echo -e "\e[3m  Italic text\e[0m (may not work everywhere)"
echo -e "\e[4m  Underlined text\e[0m"
echo -e "\e[5m  Blinking text\e[0m (may not work everywhere)"
echo -e "\e[7m  Reverse text\e[0m"
echo -e "\e[8m  Hidden text\e[0m (select to see)"
echo -e "\e[9m  Strikethrough text\e[0m"
echo ""

# Test 6: Color Combinations
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6. COLOR COMBINATIONS (Foreground + Background)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "Black on white:   \e[30;47m  Normal text  \e[0m"
echo "White on black:   \e[97;40m  Normal text  \e[0m"
echo "Red on yellow:    \e[31;103m  Normal text  \e[0m"
echo "Green on purple:  \e[32;45m  Normal text  \e[0m"
echo "Cyan on red:      \e[36;41m  Normal text  \e[0m"
echo ""

# Test 7: Color Blind Friendly Palette
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "7. COLOR BLIND FRIENDLY PALETTE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

colors=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
names=("Black" "Red" "Green" "Yellow" "Blue" "Magenta" "Cyan" "White" 
       "Bright Black" "Bright Red" "Bright Green" "Bright Yellow" 
       "Bright Blue" "Bright Magenta" "Bright Cyan" "Bright White")

for i in "${!colors[@]}"; do
    printf "\e[48;5;%dm\e[38;5;%dm %-15s \e[0m" "${colors[$i]}" "$((255 - ${colors[$i]}))" "${names[$i]}"
    if [ $(( (i + 1) % 2 )) -eq 0 ]; then
        echo ""
    fi
done
echo ""

echo "═══════════════════════════════════════════════════════════════════"
echo "✓ Color test complete!"
echo "═══════════════════════════════════════════════════════════════════"
