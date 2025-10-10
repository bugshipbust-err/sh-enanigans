echo "pulling bt..."
ssh -t -o StrictHostKeyChecking=no happyuser@192.168.1.96 "bluetoothctl power off"

echo "tying bt..."
"$HOME/.bash_functions/connect_bt.sh"
