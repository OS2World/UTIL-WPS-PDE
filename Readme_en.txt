     PDE Desktop Environment
     ____________________________________________

    English "Readme" for PDE desktop 0.06 (http://os2progg.by.ru/pde)

    Please, read this document before using "PDE desktop".
You also should read "Introducing to PDE" (introducing_en.htm) and
PDE FAQ list (pde_faq_en.htm) (or pde_help_en.inf)

                                           Thanks, stVova, 24/07/2003-8/09/2003


    1. General info.

    PDE is the shell replainsment for OS/2 and eCS operating systems. It 
designed to not conflict with your WPS, including any of the WPS-enhancers, 
such as XWorkPlace, Nice, CandyBarZ, eStyler/2 etc.
    I haven't problems with CandyBarZ, and  author of Nice - Sergey Posokhov
informed me, that PDE is good with Nice.
    PDE can be used as hole shell or as separate components, but providing some
smaller functionality (for now).
    PDE was named such because it is the Desktop Environment (second and third 
words). The first word has no translation from Cyryllic but means OS/2
Operating System on Russian programmers' jargon. So let it be "PDE desktop" for
English-speaking people.

    2. Installing.

    When installed, PDE gives you another desktop, launch-panel and file-
manager. PDE is no depends of the OS2.INI and OS2SYS.INI files.
    The simplest way to install current version of "PDE desktop" is:
  + unpack it to C:\PDE (*)
  + in your CONFIG.SYS change line of 
    SET RUNWORKPLACE= to the file PDM.EXE
    (you will find it in C:\PDE\), so your line will be
    SET RUNWORKPLACE=C:\PDE\PDM.EXE
  + reboot

(*) You can place PDE in any folder you like, but than you need to add to
CONFIG.SYS line SET PDE_HOME=[your_folder]
    After rebooting you will need to config PDE for yourself.

    3. Configuration.

    All "PDE desktop" setting is stored in directory [PDE_HOME]\PDEConf\ and
are simple text files with "cfg" extension were:

//this is comment line

and

Key=Value

so you can simple edit them.

    I now working on  GUI configuration program for PDE and it will come soon.
Here is the description for .CFG files:
  general.cfg  - general for all PDE programs settings, language, for example.
  pdm.cfg      - desktop settings.
  filehalf.cfg - settings for FileHalf, file manager of PDE.
  deskhalf.cfg - launch panel (we name it P-panel) settings.

  desktop.progs and ppanel.progs - here specified items on Desktop and P-Panel.

  quickrun.cfg - programs for FileHalf's "Quickrun" menu.

  openwith.cfg - programs for FileHalf's "Open with" menu item.

  associations.cfg - I think, the major one. Here specified file types 
                     associations for FileHalf.

    4. Known problems.

First of all, my English (and my Russian to). I know it not perfect, so sorry,
I'm neither Russian no Englishman, I'm Ukrainian.
The second one - users don't like first to read documentation and then ask
"why this don't work, or buggy?"
:-)
Sometimes PDE don't set right working directory for the programs and this is
realy problem for old applications (such as DoomII, Quake, :-( ).
P-Panel can sometimes froze, when you swith to it from window list.
FileHalf can go out when see properties of files&folders on CD-ROM.

    5. Feedback.
    Feel free to mail me, I like to receive mail. (stVova@ukrpost.com.ua)
If you find bug, have suggestion, ideas etc. Especially, if you are the talent
programmer, designer and want to join. If translated PDE on your own language
or made cool background or icon-set. If you want your own programs be added
and so on.
