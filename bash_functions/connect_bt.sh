# --- Connect Bluetooth device ---
conbt() {
    DEVICE="A6:6E:50:49:93:A0"

    echo "Starting Bluetooth service..."
    sudo systemctl start bluetooth
    sleep 2

    echo "Unblocking and powering on Bluetooth..."
    rfkill unblock bluetooth
    bluetoothctl power on

    echo "Connecting to device: $DEVICE"
    bluetoothctl connect "$DEVICE"

    echo "Done."
}

# --- Host a directory over HTTP ---
hostdir() {
    # Usage: hostdir [directory] [port]
    local dir="${1:-$(pwd)}"
    local port="${2:-8080}"

    echo "Hosting directory: $dir"
    echo "Accessible on: http://$(hostname -I | awk '{print $1}'):${port}"
    echo "Press Ctrl+C to stop the server."

    python3 -m http.server "$port" --directory "$dir"
}
