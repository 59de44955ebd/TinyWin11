import os
import sys
from winapp.dlls import kernel32

APP_NAME = 'PyShell'
APP_CLASS = 'Shell_TrayWnd'
APP_VERSION = 1

IS_FROZEN = getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS')
if IS_FROZEN:
    APP_DIR = os.path.dirname(os.path.abspath(__file__))

    # Find ...:\userprofile
    drive_letter = None
    for i in range(ord('C'), ord('W') + 1):
        if os.path.isdir(f'{chr(i)}:\\userprofile'):
            drive_letter = chr(i)
            break
    if drive_letter is None:
        sys.exit()

    PROGS_DIR = f'{drive_letter}:\\programs'
    USERPROFILE_DIR = f'{drive_letter}:\\userprofile'
else:
    APP_DIR = os.path.realpath(os.path.join(os.path.dirname(__file__), '..'))
    PROGS_DIR = os.path.realpath(os.path.join(APP_DIR, 'programs'))
    USERPROFILE_DIR = os.path.join(APP_DIR, 'userprofile')

EXPLORER = os.path.join(PROGS_DIR, 'Explorer++', 'Explorer++.exe')

#BIN_DIR = os.path.join(APP_DIR, 'bin')
BIN_DIR = 'X:\\Windows\\System32'

if not os.path.isdir(USERPROFILE_DIR):
    os.mkdir(USERPROFILE_DIR)

TEMP_DIR = os.path.join(USERPROFILE_DIR, 'Temp')
if not os.path.isdir(TEMP_DIR):
    os.mkdir(TEMP_DIR)

APPDATA_DIR = os.path.join(USERPROFILE_DIR, 'AppData')
if not os.path.isdir(APPDATA_DIR):
    os.mkdir(APPDATA_DIR)

CACHE_DIR = os.path.join(APPDATA_DIR, 'icon_cache')
if not os.path.isdir(CACHE_DIR):
    os.mkdir(CACHE_DIR)

DESKTOP_DIR = os.path.join(USERPROFILE_DIR, 'Desktop')
if not os.path.isdir(DESKTOP_DIR):
    os.mkdir(DESKTOP_DIR)

FONTS_DIR = os.path.join(USERPROFILE_DIR, 'Fonts')

os.environ['APPDATA'] = os.path.join(APPDATA_DIR, 'Roaming')

HOMEDRIVE, HOMEPATH = USERPROFILE_DIR.split('\\', 1)
os.environ['HOMEDRIVE'] = HOMEDRIVE
os.environ['HOMEPATH'] = '\\' + HOMEPATH
os.environ['LOCALAPPDATA'] = os.path.join(APPDATA_DIR, 'Local')
os.environ['PATH'] = f'{HOMEDRIVE}\\bin;' + os.environ['PATH']
os.environ['PROGRAMS'] = PROGS_DIR
os.environ['USERPROFILE'] = USERPROFILE_DIR
os.environ['TEMP'] = TEMP_DIR
os.environ['TMP'] = TEMP_DIR

DESKTOP_WIN_CLASS = 'Progman'
DESKTOP_WIN_TEXT = 'Program Manager'

CMD_ID_USB = 1000
CMD_ID_NETWORK = 1001
CMD_ID_BATTERY = 1002
CMD_ID_KEYBOARD = 1003

CMD_ID_QUICK_START = 2000
CMD_ID_TASKS_START = 3000

STARTMENU_FIRST_ITEM_ID = 4000

OFFSET_ICONIC = 10000

if IS_FROZEN:
    HMOD_RESOURCES = kernel32.GetModuleHandleW(None)
else:
    HMOD_RESOURCES = kernel32.LoadLibraryW(os.path.join(APP_DIR, 'resources.dll'))

HMOD_SHELL32 = kernel32.LoadLibraryW('shell32.dll')
