# /// script
# dependencies = ["mcp"]
# ///
import json
from mcp.server.fastmcp import FastMCP

CONTEXT_FILE = "/tmp/nvim_context.json"

mcp = FastMCP("nvim-context")


def read_context() -> dict | None:
    try:
        with open(CONTEXT_FILE) as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return None


@mcp.tool()
def get_current_file() -> str:
    """Get the currently active file in Neovim (path, filetype, unsaved changes)"""
    ctx = read_context()
    if not ctx:
        return "Neovim context not available"
    return json.dumps({
        "file": ctx.get("file"),
        "filetype": ctx.get("filetype"),
        "unsaved_changes": ctx.get("unsaved_changes"),
    }, indent=2)


@mcp.tool()
def get_cursor_context() -> str:
    """Get cursor position and surrounding lines from the current Neovim buffer"""
    ctx = read_context()
    if not ctx:
        return "Neovim context not available"
    return json.dumps({
        "file": ctx.get("file"),
        "cursor_line": ctx.get("cursor_line"),
        "cursor_col": ctx.get("cursor_col"),
        "lines_around_cursor": ctx.get("lines_around_cursor"),
    }, indent=2)


@mcp.tool()
def get_open_buffers() -> str:
    """Get list of all open file buffers in Neovim"""
    ctx = read_context()
    if not ctx:
        return "Neovim context not available"
    return json.dumps({"open_buffers": ctx.get("open_buffers", [])}, indent=2)


@mcp.tool()
def get_full_context() -> str:
    """Get complete Neovim context: active file, cursor position, surrounding code, open buffers"""
    ctx = read_context()
    if not ctx:
        return "Neovim context not available"
    return json.dumps(ctx, indent=2)


if __name__ == "__main__":
    mcp.run()
