require('treesitter-context').setup {
    enable = true,
    throttle = true,
    max_lines = 0,
    patterns = {
        "class",
        "function",
        "method",
        "for",
        "while",
        "if",
        "table",
        "comment"
    },
    highlight = {
        "Normal",
        "Comment",
    },
}

