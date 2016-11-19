def tidy(lst):
    return list(sorted(lst.split()))


TODO_OPTIONS = tidy("todo test implement fix confirm finish change add remove")


def display(opts):
    if len(opts) == 1:
        return opts[0]
    elif not opts:
        return ""
    else:
        return "(" + " | ".join(opts) + ")"


def complete(t):
    return [ opt[len(t):] for opt in TODO_OPTIONS if opt.startswith(t) ]


def get_todo_one(header):
    print(TODO_OPTIONS)
    return header + "TODO("


def get_todo_two(text):
    completions = complete(text)
    print(completions)
    return display(completions) + "): "

