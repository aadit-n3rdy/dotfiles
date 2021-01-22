#!/usr/bin/env bash
set -euo pipefail

nitrogen --restore &
picom &

blueman-applet &
