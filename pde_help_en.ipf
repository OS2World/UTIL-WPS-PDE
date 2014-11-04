:userdoc.
:title. PDE Desktop Environment
:h1. Introduction in PDE v0.06
:p.
:artwork runin name='docs\pde.bmp'.
:font facename='Helv' size='18x14'.
PDE Desktop Environment
:font facename='default' size='0x0'.
:p.
The purpose of the given review - to present abilities of PDE shell
, that users could look and read, what she is and how to use her in work.
:p.
9.09.2003, Vladymyr Sergeyev (stVova)
:h2. What is PDE?
:p.
    :hp4. PDE:ehp4.
It's friendly to the user environment of a desktop for OS/2 and
OS/2-like systems. At present PDE contains the P-Panel (for start
applications and display of the status), the Desktop (where can be links
to the folders and applications), the set of standard utilities and programs, and a set of rules
which make interaction of programs more simple. Users of others
Operational systems and shells will feel like as a house, using
powerful graphically - guided environment given by PDE. PDE works on
family of operational systems OS/2, including OS/2 Warp, OS/2 Merlin, OS/2 WSeB
and eComStation.
:p.
    :hp4. PDE:ehp4. is free software (with open sources), source texts and ready 
executable modules PDE are accessible for download in the Internet; 
they are distributed on conditions of GNU General Public License.
In general, it means that each interested person is free in
use, copying or distributing PDE. If you want to find more about PDE project please visit:
:p.
 :hp2.http&colon.//os2progg.by.ru/pde.:ehp2.
:p.
Questions you can send me via email:
:p.
 :hp2.stVova@ukrpost.com.ua:ehp2.
:p.
    :hp4. PDE:ehp4. has the big flexibility in adjustment, allowing your 
Desktop to look and operate how you want. PDE supports much
national languages for the user interface also allows to change language
hurriedly, without rebooting. Why search in the dictionary translation 
for items of the menu on unfamiliar language if it is possible without problems 
to switch system to thenative?
:p.
    :hp4. PDE:ehp4. is acronimus for PDE Desktop Environment - 
it's means environment for Operational System/2  - for IBM OS/2.
:p.
This note describes PDE v.0.06 which is the freshest
( for 2003) version of PDE.

:h2. The first sight on PDE: the Desktop and the Panel
:p.
     After installation PDE and rebooting the screen of your computer will look,
most likely, as shown in Figure 1.
:p.
:artwork name='docs\image1.bmp'.
:p.
Figure 2 shows an example PDE in work.
:p.
PDE very configurable, therefore your screen can look a little differently.
:p.
Example of the screen PDE.
:artwork name='docs\image3.bmp'.

:h2. PDE and WPS (WorkPlaceShell)
:p.
     PDE can be used as instead of WorkPlaceShell shell, and
together with her. For example, you can use "Desktop" and "WarpCenter"
+ HalfFile and the P-panel.
:p. Figure 3 shows an example of work-together PDE and WPS:
:p.
:artwork name='docs\image6.bmp'.

:h2. The panel
     The long rectangular from below the screen is the panel.
:p.
:artwork name='docs\image4.bmp'.
:p.
The panel can contain set of useful objects, such as:
:ul.
:li. The button of the menu PDE
.br
Pressing this button will show the menu containing all accessible applications and
commands, including command "Close system".
The button of the menu has its' own popup menu;-)
:li. Buttons of applications and folders
.br
These are buttons for start of various programs or opening folders.
:li. Clock, for example.
:eul.
:p. To adjust object, or to remove it from Panel, click the right button on it
and choose the necessary item from popup menu.
To hide the Panel when it is not in use you may click on hide-buttons
(with small arrows) on the ends of the panel.
.br
To add the button of application or folder on the panel, simply drag them from FileHalf window
( the PDE file manager) on the panel and drop.

:h2. A desktop
:p.
     All that is outside of the panel "Desktop" refers to. You can
to place icons of applications or folders on a desktop for fast
access to them (the initial collection of icons is established together with PDE)
, then you can execute a double click on object to use it:
:ul.
:li.if object is the program, this program will be started
:li.if it is a folder (a directory, the catalogue), the File Manager will be started and
will show contents of this folder. Your desktop most likely already has
icon representing the house and signed "Home". A double click on it will
start the File Manager in your home directory.
:eul.:p.
The most simple way to place object on a desktop - to drag
file (folder) from a window of the file manager. As soon as the object is placed on a desktop,
you can move it with the help of the left button of the mouse or a double click
to start on. With the help of the right button of the mouse it is possible to cause
popup menu of the Desktop with which help it is possible, for example to adjust
Desktop by the command "Properties".

:h2. FileHalf: PDE file-manager
    :hp4. PDE:ehp4. includes the graphic program for management of files and folders,
"FileHalf". To open new window of FileHalf, twice click on anyone
icon of a folder on a desktop, for example on a folder "Home".
:p.
:artwork name='docs\image2.bmp '.
:p.
:hp2. Management of your files with FileHalf:ehp2.
:p.
     As well as the modern graphic file managers, FileHalf
shows contents of selected folder using the appropriate icons for
files and folders. The double click on a folder opens it (for files of the data
it is started associated application). Click by the right button on a file or
the folder is show a pop up menu. Using it, you can delete or
rename a file, to see and change properties, and many other things.
:p. FileHalf also gives a simple and convenient way of copying of files
between folders. To copy a file from one folder in another, open these
folders in separate FileHalf windows (the command " File\New window ").  Take and drag necessary
file from one window in another with the help of the mouse. You also can
to drag the application or a folder on a desktop (the shortcut will be in that case created
for program or folder), or the P-Panel - then will be created the button of fast
access. For moving keep pressed key Shift in time
of dragging, and for creation of a shortcut - Shift + Control.
:p. FileHalf gives much more tools for manipulation
your files. It also very adjustable so you can easily
change appearance and a way of display of files, associations of documents or icons.
:p. For example, with the help of combinations Control+PageUp and Control+PageDown
it is possible to change zoom scale of viewing the contents of a folder; to add the necessary folder
In bookmarks will help the menu "Edit\Add bookmark " or Control+B; quickly
to start the necessary program - the menu "Quick run", and to go to disks-
"Goto\Disks".

:h2. Access to disks in PDE
:p.
    :hp4. PDE:ehp4.
keeps your disks in a folder "Drives" (which object you will find on
Desktop). The folder contains in a folder " [PDE HOME] \Root\Drives ".
Actually the folder "Disks" contains only objects (links) which specify
on drives roots. These are usual text files which can be edited
with any text editor. I do not know what disk sections will be on
the computer of the user, therefore you will be come to create links to the disks
yourself, on an example.
:p.
For example, for disk C:
:xmp.
[SHORTCUT]
//link: type, object-name, path, parameters
HDD
c&colon.\
:exmp.
:p.
Similarly it is necessary to adjust the menu of the Panel, creating links to applications
and folders.
:p.
 Pay attention, that objects PDE have no anything common with objects of
WorkPlaceShell and unfortunately have no their remarkable property of binding
, but on the other hand damage of system files of initialization is not terrible-
OS2. INI and OS2SYS.INI - PDE it is not depends from them.

:h2. End of work
:p.
     To finish work with PDE, click right button of mouse on a desktop
and choose menu item "Close system". Or click on the menu PDE and choose
"End of work". PDE will request acknowledgement (if it is specified in configuration).
:p.
:artwork name='docs\image5.bmp'.
:p.
If you don't want to see confirmation, in a folder "[PDE HOME]\PDEConf" in a file
"general.cfg" change parameter
.br
askforshutdown=1
.br
On
.br
askforshutdown=0

:h2. Thanks.
:ul.
:li.
:hp2. Sergey Sergeyev :ehp2., my brother. A lot of criticism and ideas, he say
"Make it easier".
:li.
:hp2. Sergey Posokhov:ehp2. The help with support of drag'n'drop on the P-panel.
Efficient remarks.
:li.
To developers:hp2. KDE:ehp2. and:hp2. GNOME:ehp2..
Thanks for icons and another graphics.
:li.
All my:hp2. friends:ehp2. from my native city :hp2.Lutsk:ehp2..
:eul.

:h1. Installation and configuration of PDE
:artwork runin name='docs\pde.bmp'.
:font facename='Helv' size='18x14'.
PDE Desktop Environment
:font facename='default' size='0x0'.
:p.
How to establish, adjust and use.
:p.
15.09.2003, Vladymyr Sergeyev (stVova)
:h2. Installation PDE
:hp2. The easeast way to install PDE at present is&colon.:ehp2.
:ol.
:li.Unpack zip archive in C&colon.\PDE
.br
You can place PDE in any other folder but then it is necessary to add in
CONFIG.SYS a line
.br
SET PDE_HOME = [your_folder]
:li.In CONFIG.SYS to change a line with
.br
SET RUNWORKPLACE = on file PDM.EXE
.br
( you will find it in C&colon.\PDE \), thus:
.br
SET RUNWORKPLACE=C&colon.\PDE\PDM.EXE
.br
If you do not want to use PDE "Desktop" instead of WPS Desktop,
and use only the P-panel and File-Manager "FileHalf",
make changes in CONFIG.SYS and reboot is not necessary.
:li.Reboot system
:eol.

:h2. Adjustment PDE
Adjust ALL and FOR YOURSELF.
:p.
Configuration files are stored in a folder [PDE_HOME] \PDEConf and are usual
text files.
:p. In the future the graphic configuration utility will appear.
:h3. General.cfg
:hp2. Some general parameters are stored in this file:ehp2.
:p.
:table cols='16 40'.
:row.
:c. Parameter:
:c. Explanation:
:row.
:c. language
:c. Used language (for example ru_ru from [PDE_HOME] \Languages\ru_ru.nls)
:row.
:c. askforshutdown
:c. To request confirmation on end of work (1/0)
:row.
:c. overwritefiles
:c. To rewrite target files (if exists) at copying (1/0)
:row.
:c. userhome
:c. A path to user home folder
:row.
:c. userdocs
:c. A way to a folder "Documents"
:row.
:c. userdrives
:c. A way to a folder "Disks" PDE
:row.
:c. userstartup
:c. A way to a folder " At start " PDE
:row.
:c. userprograms
:c. A way to the menu of "Program"
:row.
:c. userbookmarks
:c. A way to a folder of "Bookmark"
:etable.

:h3. Associations.cfg
:hp2. The file contains data files associations for FileHalf:ehp2.
:p.
The file consists of recordings the following format:
:table cols='22 44'.
:row.
:c. extension
:c. Type of files
:row.
:c. Drive&colon.\Path\Program
:c. The program for opening the given type of files
:row.
:c. Folder\picture.bmp
:c. An icon for type of files. A base folder " [PDE_HOME] \Bitmaps\FileTypes "
:row.
:c. An empty line
:c.
:etable.
:p.
:h3. Pdm.cfg
:hp2. The file contains configuration of the Desktop:ehp2.
:p.
You can adjust all parameters, chosen Desktop pop up menu item "Properties"
:table cols='16 40'.
:row.
:c.iconsize
:c. The size of icons
:row.
:c.desktopcolor
:c. The first color of the Desktop (at a gradient - the top color)
:row.
:c.secondcolor
:c. The second color, matters, if the gradient is included
:row.
:c.wallpaper
:c. A way to a file of wall-paper (.BMP) (a full way or from [PDE_HOME] \)
:row.
:c.wallpaperstyle
:c. A way of accommodation of wall-paper: center, tile, stretch, vgradient,
lefttop, righttop, leftbottom, rightbottom
:row.
:c.screensaver
:c. A way to the screen saver program (a full way or from [PDE_HOME] \)
:etable.
:h3. Desktop.progs
:hp2. All objects of the Desktop are stored in this file:ehp2.
:p.
Format of records:
:table cols='16 48'.
:row.
:c. Type of object
:c. FOLDER\APP (directory\program)
:row.
:c. An icon
:c. A way to .ICO\.BMP to a file from the catalogue [PDE_HOME] \
:row.
:c. X-coordinate
:c.object left
:row.
:c. Y-coordinate
:c.object top
:row.
:c. A full name
:c. A way to a target file, including [Disk:] \ [Folders] \ [Name]
:row.
:c. Folder
:c. A folder (catalogue) of accommodation
:row.
:c. Parameters
:c. Parameters of start (if the program)
:row.
:c. Type of session
:c. Type of the program (OS/2 PM, VIO, DOS.) (0 - automatic detection)
:etable.
:h3. Deskhalf.cfg
:hp2. The file contains configuration of P-Panel:ehp2.
:p.
:table cols='16 40'.
:row.
:c.color1
:c. Color of the ï-panel
:row.
:c.color2
:c. Color of the menu
:row.
:c.size
:c. The size of buttons
:row.
:c.bottom
:c. A position from a bottom of the screen
:row.
:c.dynamicsize
:c. The dynamic size (yes/no)
:row.
:c.ontop
:c. To float from above (yes/no)
:etable.
Also it contains figures for buttons of the menu.
:h3. Ppanel.progs
:hp2. All buttons P-Panel are stored in this file.:ehp2.
:p.
Format of recordings:
:table cols='16 40'.
:row.
:c. Type of object
:c. FOLDER\APP (directory or program)
:row.
:c. An icon
:c. A way to .BMP to a file from the catalogue [PDE_HOME] \Bitmaps\Deskhalf\
:row.
:c. A full name
:c. A way to a target file, including [Disk:] \ [Folders] \ [Name]
:row.
:c. A folder
:c. Working folder
:row.
:c. Parameters
:c. Parameters of start (if the program)
:etable.
:h3. FileHalf.cfg
:hp2. The file contains configuration of FileHalf:ehp2.
:p.
The program remembers some parameters during work.
:table cols='20 44'.
:row.
:c. FileListColor
:c. Color of a background of the list of files and folders
:row.
:c. FileListIconSize
:c. The size of icons of files and folders
:row.
:c. ToolbarColor
:c. Color of the panel of buttons
:row.
:c. ToolbarSize
:c. The size of buttons of the panel
:row.
:c. ShowInfoPanel
:c. To show the Info-panel (1/0)
:row.
:c. ShowStatus
:c. To show a line of the status
:row.
:c. ShowButtons
:c. To show the panel of buttons
:row.
:c. ViewType
:c. Type of viewing (icons\tiles\small)
:row.
:c. Figures on buttons
:c...................
:row.
:c. FindUtil
:c. the search utility (full way, or from [PDE_HOME] \)
:row.
:c. TextUtil
:c. the program for "Viewing" (F3)
:row.
:c. Archiver
:c. the archiver
:etable.
:h3. Openwith.cfg
:hp2. Programs for item of FileHalf menu "Open with":ehp2.
:p.
Format of recordings the following:
:table cols='16'.
:row.
:c. Caption of item of the menu
:row.
:c. A full way to program
:etable.
:h3. Quickrun.cfg
:hp2. Programs for the FileHalf menu "Quick run" :ehp2.
:p.
Format of recordings the following:
:table cols='16'.
:row.
:c. Caption of item of the menu
:row.
:c. A full way to program
:etable.
:h3.pswd.cfg
:hp2.Security:ehp2.
If you want that at start, PDE request
login and password create a file "pswd.cfg" with such contents:
:table cols='16 35'.
:row.
:c. login
:c. A login name
:row.
:c. password
:c. The password for an input (entrance) in system
:etable.
If the user will not know the password he can only reload system.
:p.
About that OS/2 it not load in a text mode
, it is necessary to take care separately (RTFM OS/2 FAQ).

:h2.Quick start
:p.
     It looks like you downloaded zip-archive. Unpack it in any folder,
for example "C&colon.\PDE\".
.br
Add to CONFIG.SYS variable "SET PDE_HOME=[Your_Folder_With_PDE]".
:p.
Change in CONFIG.SYS variable "SET RUNWORKPLACE" to
[Your_Folder_With_PDE]\pdm.exe
(this is desktop manager of PDE).
.br
For example, "SET RUNWORKPLACE=C&colon.\PDE\PDM.EXE"
:p.
Reboot. (Don't need, if PDE in folder "C&colon.\PDE").
:p.
Adjust Desktop and PDE localization in popup-menu command "Properties".
.br
Objects on Desktop saves in file "\PDEConf\desktop.progs",
delete non needed or add new (you can also add by drag'n'drop
from FileHalf window). You can only place links to the folders and programs
on Desktop.
.br
Menu item "Reload config" - will force program to load new settings.
:p.
Adjust P-panel. Delete non needed buttons from their popup-menu. Add new
by drag'n'drop from FileHalf window. Edit file "deskhalf.cfg".
:p.
Adjust associations for data-files: file "associations.cfg".
They need for file-manager.
:p.
Adjust file-manager "FileHalf". In genegal, it will work without any
adjustments, but. You don't need bookmarks, "Qouick run" and "Open with" lists
, and others FileHalf's features? Adjust it and use.
.br
His look FileHalf save when you close it's window, bookmarks adds from menu
, other adjustments in files: filehalf.cfg, quickrun.cfg, openwith.cfg.
:p.
Wishes: read documentation.
:p.

:h1. PDE FAQ
:artwork runin name='docs\pde.bmp'.
:font facename='Helv' size='18x14'.
PDE Desktop Environment
:font facename='default' size='0x0'.
:p.
Frequently Asked Questions.
:p.
13.09.2003, Vladymyr Sergeyev (stVova)

:h2. Frequently asked questions about PDE.
:p.
Q&colon.:hp2. I have installed PDE and any of programs does not work. What to do?:ehp2.
:p.
A&colon. To read the documentation (after that all, as a rule, clears up).
.br
If you have installed PDE not in a folder
C&colon.\PDE \ it is necessary in CONFIG.SYS
to add variable PDE_HOME
.br
For example&colon.
SET PDE_HOME=D&colon.\Programs\PDE and to reload the computer.
:p.
Q&colon.:hp2. All shell - Ukrainian. I want the native language!:ehp2.
:p.
A&colon. Language of the interface is set in a config file
[PDE_HOME] \PDE_Conf\general.cfg in a variable
Language. To default Language=en_en
.br
The most simple way to change language - through the menu command of the Desktop
"Properties". In a dialog box "Desktop - Properties" change value "File of localization".
.br
Files of localization are in a folder [PDE_HOME] \Languages\. Find among
them native and establish the appropriate value.
.br
For example, for Ukrainian the file refers to ua_ua.nls, then
Language=ua_ua.
.br
For the P-Panel choose the command "Reload" from contextual menu of the P-button.
New window of FileHalf will use a new language settings.
:p.
Q&colon.:hp2. All this cool. But how many operative memory (RAM) eats PDE?:ehp2.
:p.
A&colon.
.br
Desktop (pdm.exe) - 900Kb + the size of a wallpaper file.
.br
The P-panel (deskhalf.exe) - 1.2Mb (+/-icons).
.br
FileHalf (filehalf.exe) - 1.2Mb the first window, all subsequent 800-900Kb
( + icons).
:p.
Q&colon.:hp2. I want, that my domestic folder (Home) was C&colon.\MyHome_SweetHome:ehp2.
:p.
A&colon. Without problems. In a file [PDE_HOME] \PDE_Conf\general.cfg establish
the necessary value for a variable "userhome".
.br
For example: homedir=C&colon.\MyHome_SweetHome
:p.
Q&colon.:hp2. How at start PDE to start other programs?:ehp2.
:p.
A&colon. Create for the necessary programs in a folder [PDE_HOME] \Root\StartUp
objects (links). Or use file Startup.cmd for start programs at start of system.
:p.
Q&colon.:hp2. As far as I understand, you port KDE shell from Linux?:ehp2.
:p.
A&colon. No. PDE is native the PM-programs written from scratch. I only used
the graphic created by KDE Team and GNOME Team. For what many thanks.
:p.
Q&colon.:hp2. On what versions OS/2 works PDE?:ehp2.
:p.
A&colon. Practically on all: OS/2 Warp 3.0, OS/2 Merlin 4.0, WSeb 4.5, MCP/ACP
, eComStation.
:p.
Q&colon.:hp2. PDE it is based on the same objective model (SOM), as WorkPlaceShell?:ehp2.
:p.
A&colon. No, PDE does not use SOM-model. On the one hand it, probably, big
lack. But on another...
:p.
Q&colon.:hp2. What for all this is necessary! Would engage in much more important affairs, for example,
Open Office or Mozilla?:ehp2.
:p.
A&colon. First, I (stVova) beginning to write the user shell for _myself_.
I has bothered to be reconciled with immeasurable duplication of windows on the Desktop, and when
one window hangs, others fall with it has bothered to be at war with file associations.
.br
In result - quite good PDE shell has appeared. 
So good, that I have decided to show her to people. 
Somebody like it, somebody - no.
:p.
Q&colon.:hp2. I have changed something in files of a configuration PDE. 
Do I must to reboot  that changes have come into force?:ehp2.
:p.
A&colon. No.
.br
The P-panel will load new adjustments if to choose the command "Reload" from
pop up menu of the P-button.
.br
FileHalf loads adjustments at opening new window.
And old windows of FileHalf remain with old adjustments;-)
.br
The pop up menu of Desktop  has the command "Reload settings".
:p.
Q&colon.:hp2. In a folder PDE "Disks" there are no right drives!:ehp2.
:p.
A&colon. In a folder "Disks" shortcuts (links) for disks are located only.
These are text files. Look, as them are and make shortcuts for your drives.
:euserdoc.