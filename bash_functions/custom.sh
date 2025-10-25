# --- ptron controls ---
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

pullbt(){
    echo "pulling bt..."
    ssh -t -o StrictHostKeyChecking=no happyuser@192.168.1.96 "bluetoothctl power off"

    echo "tying bt..."
    conbt
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


# DNS fall-backs helpers
use_pihole(){
    CON_NAME="Airtel_Ravi Kumar"
    PIHOLE_DNS="192.168.1.8"

    echo "[+] Switching to Pi-hole DNS ($PIHOLE_DNS)..."
    nmcli con mod "$CON_NAME" ipv4.dns "$PIHOLE_DNS"
    nmcli con mod "$CON_NAME" ipv4.ignore-auto-dns yes
    sleep 1
    nmcli con down "$CON_NAME"
    sleep 1
    nmcli con up "$CON_NAME"
    echo "[+] Done. Now using Pi-hole."
}

use_default() {
    CON_NAME="Airtel_Ravi Kumar"
    PIHOLE_DNS="192.168.1.8"
    
    echo "[+] Reverting to automatic/default DNS..."
    nmcli con mod "$CON_NAME" ipv4.ignore-auto-dns no
    nmcli con mod "$CON_NAME" ipv4.dns ""
    sleep 1
    nmcli con down "$CON_NAME"
    sleep 1
    nmcli con up "$CON_NAME"
    echo "[+] Done. Back to default."
}

show_status() {
    echo "[i] Current DNS:"
    nmcli dev show | grep DNS
}
