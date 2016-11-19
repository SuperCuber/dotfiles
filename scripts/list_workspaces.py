#!/usr/bin/env python
import i3ipc
import sys

focused_ws = " <span foreground='#00ff54'>%s</span> "
urgent_ws = " <span foreground='#ff0054'>%s</span> "

unfocused_ws = " %s "

def buildWorkspaceLine(workspaces):
    workspaceLine = ''
    numWorkspaces = len(workspaces)
    wsnum = 1

    for ws in workspaces:
        divider = '|'
        if wsnum == numWorkspaces:
            divider = ''

        if ws['focused']:
            workspaceLine += (focused_ws + divider) % ws.name
        elif ws['urgent']:
            workspaceLine += (urgent_ws + divider) % ws.name
        else:
            workspaceLine += (unfocused_ws + divider) % ws.name
    wsnum += 1
    return workspaceLine[:-1]

def printData(data):
    sys.stdout.flush()
    sys.stdout.write("%s" % data)
    sys.stdout.flush()

i3 = i3ipc.Connection()

# start off by printing current state
workspaces = i3.get_workspaces()
workspaceLine = buildWorkspaceLine(workspaces)
printData(workspaceLine)

def showWorkspaces(i3, e):
    if not e.change in [ 'init', 'focus', 'empty', 'rename', 'urgent' ]:
        return 

    workspaces = i3.get_workspaces()
    workspaceLine = buildWorkspaceLine(workspaces)
    printData(workspaceLine)


i3.on('workspace', showWorkspaces)
i3.main()
