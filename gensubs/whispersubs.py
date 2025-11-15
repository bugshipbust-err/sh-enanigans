import subprocess
import os
import sys
import re


def srt_ready(whisper_output: str) -> str:
    srt_lines = []
    index = 1

    for line in whisper_output.splitlines():
        line = line.strip()
        if not line:
            continue

        # Match whisper.cpp timestamp format
        m = re.match(r'\[(.*?) --> (.*?)\]\s*(.*)', line)
        if not m:
            continue

        start, end, text = m.groups()

        # Convert .mmm → ,mmm for SRT
        start = start.replace('.', ',')
        end   = end.replace('.', ',')

        srt_lines.append(f"{index}")
        srt_lines.append(f"{start} --> {end}")
        srt_lines.append(text)
        srt_lines.append("")   # blank line
        index += 1

    return "\n".join(srt_lines)


def run_whisper(file_path, model, duration, threads):
    whisper_path = "/home/happyuser/whisper.cpp"
    cli_path = whisper_path + '/build/bin/whisper-cli'
    model_path = whisper_path + f'/models/ggml-{model}.en.bin'
    save_path = os.path.dirname(file_path) + "/gen_subs.srt"  # Ensure it's a valid path

    command = [
        cli_path,                       # path to whisper-cli
        '-f', file_path,                # Input file path
        '--duration', str(duration),    # Duration in seconds
        '--threads', str(threads),      # Number of threads
        '--model', model_path,          # Model path
    ]
    
    try:
        # Run the command and capture the output
        result = subprocess.run(command, check=True, capture_output=True, text=True)
        
        # Get the stdout (whisper transcription output) from result
        whisper_output = result.stdout
        
        # Convert to SRT format
        srt_txt = srt_ready(whisper_output)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred: {e.stderr}")
        sys.exit(1)

    # Save the SRT text to a file
    with open(save_path, "w") as file:
        file.write(srt_txt)
        print(f"Subtitles saved to {save_path}")


if __name__ == '__main__':
    if len(sys.argv) != 5:
        print("Usage: python run_whisper.py <file_path> <model> <duration> <threads>")
        sys.exit(1)
    
    file_path = sys.argv[1]
    model = sys.argv[2]
    duration = int(sys.argv[3])
    threads = int(sys.argv[4])
    
    run_whisper(file_path, model, duration, threads)
