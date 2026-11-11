# pyright: reportMissingImports=false
import os

from kittens.tui.handler import result_handler

from kitty.key_encoding import KeyEvent, parse_shortcut

NVIM_FORWARDED_KEYS = {'ctrl+j', 'ctrl+k'}


def main():
    pass


def encode_key_mapping(window, key_mapping):
    mods, key = parse_shortcut(key_mapping)
    event = KeyEvent(
        mods=mods,
        key=key,
        shift=bool(mods & 1),
        alt=bool(mods & 2),
        ctrl=bool(mods & 4),
        super=bool(mods & 8),
        hyper=bool(mods & 16),
        meta=bool(mods & 32),
    ).as_window_system_event()

    return window.encoded_key(event)


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)

    # fzf launched from a shell widget or completion shares the shell's process group, so
    # check every foreground process rather than only the first one
    cmds = {os.path.basename(p['cmdline'][0]) for p in window.child.foreground_processes if p.get('cmdline')}
    keymap = args[2]
    # nvim only gets ctrl+j/k (to cycle through snacks pickers), ctrl+h/l keep moving between panes
    if cmds & {'tmux', 'fzf'} or (cmds & {'nvim'} and keymap in NVIM_FORWARDED_KEYS):
        encoded = encode_key_mapping(window, keymap)
        window.write_to_child(encoded)
    else:
        boss.active_tab.neighboring_window(args[1])
