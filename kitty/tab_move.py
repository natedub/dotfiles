from kittens.tui.handler import result_handler
from kittens.tui.loop import debug

from kitty.boss import Boss


def main(args: list[str]):
    pass


@result_handler(no_ui=True)
def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    tab = boss.active_tab
    if tab is None:
        return
    offset = -1
    try:
        offset = int(args[1])
    except (ValueError, IndexError):
        pass
    tabs = boss.active_tab_manager.tabs
    idx = tabs.index(tab)
    target_idx = (idx + offset) % len(tabs)
    boss.goto_tab(target_idx + 1)
