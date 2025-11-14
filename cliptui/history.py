class ClipboardHistory:
    def __init__(self, max_items=50):
        self.items = []
        self.max_items = max_items

    def add(self, text: str):
        if text and (not self.items or text != self.items[0]):
            self.items.insert(0, text)
            if len(self.items) > self.max_items:
                self.items.pop()

    def delete(self, index: int):
        if 0 <= index < len(self.items):
            self.items.pop(index)
