import subprocess


def get_clipboard_text() -> str:
    try:
        out = subprocess.check_output(
                ["wl-paste", "--no-newline"],
                stderr=subprocess.DEVNULL
                )
        return out.decode("utf-8", errors="replace")
    except Exception:
        return ""


def set_clipboard_text(text: str):
    try:
        subprocess.run(
                ["wl-copy"],
                input=text.encode("utf-8"),
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
                )
    except Exception:
        pass

