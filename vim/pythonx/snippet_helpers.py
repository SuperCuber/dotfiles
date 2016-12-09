from subprocess import check_output
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


def command(cmd):
    return str(check_output(cmd, shell=True).strip(), "ascii")


def get_todo_one(header):
    print(TODO_OPTIONS)
    return header + "TODO("


def get_todo_two(text):
    completions = complete(text)
    print(completions)
    return display(completions) + "): "


def get_todo_three():
    return command("date +'%F %T'") + " (" + command("uname -n") + ")"
