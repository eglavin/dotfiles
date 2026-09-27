def enabled_items(items, active_tags):
    """Keep items without `tags`, and items with at least one tag in active_tags."""
    active = set(active_tags)
    return [item for item in items if not item.get("tags") or active.intersection(item["tags"])]


class FilterModule:
    def filters(self):
        return {"enabled_items": enabled_items}
