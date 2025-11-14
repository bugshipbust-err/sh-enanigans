from textual.app import App, ComposeResult
from textual.widgets import Static, ListView, ListItem
from textual.reactive import reactive
from textual import events

from clipboard import get_clipboard_text, set_clipboard_text
from history import ClipboardHistory

import asyncio


class ClipboardApp(App):
    CSS = """
    Screen {
        layout: vertical;
        padding: 1 2;
    }
    #title {
        color: green;
        text-style: bold;
        padding-bottom: 1;
    }
    """

    current_text = reactive("")
    history = ClipboardHistory()

    def compose(self) -> ComposeResult:
        yield Static("CLIPTUI — Clipboard Manager", id="title")
        self.list_view = ListView()
        yield self.list_view

    async def watch_current_text(self, new_value: str):
        """Whenever clipboard changes, update UI."""
        self.history.add(new_value)
        self.refresh_list()

    def refresh_list(self):
        self.list_view.clear()
        for item in self.history.items:
            # Show first 80 chars
            preview = item.replace("\n", " ")[:80]
            self.list_view.append(ListItem(Static(preview)))

    async def on_mount(self):
        """Start polling clipboard every 300ms."""
        self.set_interval(0.3, self.poll_clipboard)

    def poll_clipboard(self):
        new_text = get_clipboard_text()
        if new_text != self.current_text:
            self.current_text = new_text

    async def on_key(self, event: events.Key):
        # ENTER → copy selected item
        if event.key == "enter":
            idx = self.list_view.index
            if 0 <= idx < len(self.history.items):
                set_clipboard_text(self.history.items[idx])
        # d → delete item
        elif event.key == "d":
            idx = self.list_view.index
            self.history.delete(idx)
            self.refresh_list()


if __name__ == "__main__":
    ClipboardApp().run()
