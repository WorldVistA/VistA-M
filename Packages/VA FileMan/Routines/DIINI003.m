DIINI003 ;VEN/TOAD-DI (FILEMAN MENU INIT) ; 05-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"OPT",1354,"U")
 ;;=AUDIT MENU
 ;;^UTILITY(U,$J,"OPT",1355,0)
 ;;=DIAUDITED FIELDS^List Fields Being Audited^^R^^^^^^^^MSC FILEMAN^^
 ;;^UTILITY(U,$J,"OPT",1355,1,0)
 ;;=^^2^2^3130126^
 ;;^UTILITY(U,$J,"OPT",1355,1,1,0)
 ;;=This options lists all the fields that are being audited. One can see all
 ;;^UTILITY(U,$J,"OPT",1355,1,2,0)
 ;;=the fields or just those in a particular file range.
 ;;^UTILITY(U,$J,"OPT",1355,25)
 ;;=1^DIAU
 ;;^UTILITY(U,$J,"OPT",1355,"U")
 ;;=LIST FIELDS BEING AUDITED
 ;;^UTILITY(U,$J,"OPT",1357,0)
 ;;=DIAUDIT PURGE DATA^Data Audit Trail Purge^^R^^^^^^^^MSC FILEMAN^^
 ;;^UTILITY(U,$J,"OPT",1357,1,0)
 ;;=^^4^4^3130126^
 ;;^UTILITY(U,$J,"OPT",1357,1,1,0)
 ;;=This option purges all or part of the data-audit trail for a particular
 ;;^UTILITY(U,$J,"OPT",1357,1,2,0)
 ;;=file. Either all of the data audits may be purged or part of the data
 ;;^UTILITY(U,$J,"OPT",1357,1,3,0)
 ;;=audits may be deleted based on a field in the audit file, e.g., date,
 ;;^UTILITY(U,$J,"OPT",1357,1,4,0)
 ;;=user, field.
 ;;^UTILITY(U,$J,"OPT",1357,25)
 ;;=3^DIAU
 ;;^UTILITY(U,$J,"OPT",1357,99.1)
 ;;=56123,39787
 ;;^UTILITY(U,$J,"OPT",1357,"U")
 ;;=DATA AUDIT TRAIL PURGE
 ;;^UTILITY(U,$J,"OPT",1358,0)
 ;;=DIAUDIT PURGE DD^DD Audit Trail Purge^^R^^^^^^^^MSC FILEMAN^^
 ;;^UTILITY(U,$J,"OPT",1358,1,0)
 ;;=^^3^3^3130126^
 ;;^UTILITY(U,$J,"OPT",1358,1,1,0)
 ;;=This option purges all or part of the DD audit trail for a particular
 ;;^UTILITY(U,$J,"OPT",1358,1,2,0)
 ;;=file. Either all of the DD audits may be purged or part of it may be
 ;;^UTILITY(U,$J,"OPT",1358,1,3,0)
 ;;=deleted based on a field in the audit file, e.g., date, user, field.
 ;;^UTILITY(U,$J,"OPT",1358,25)
 ;;=5^DIAU
 ;;^UTILITY(U,$J,"OPT",1358,"U")
 ;;=DD AUDIT TRAIL PURGE
 ;;^UTILITY(U,$J,"OPT",1359,0)
 ;;=DIOTHER^Other Options^^M^^^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1359,1,0)
 ;;=^^3^3^2960724^^^^
 ;;^UTILITY(U,$J,"OPT",1359,1,1,0)
 ;;=This menu contains a series of menus which lead to enhancements in current
 ;;^UTILITY(U,$J,"OPT",1359,1,2,0)
 ;;=and coming versions.  These include auditing, filegrams, and FileMan 
 ;;^UTILITY(U,$J,"OPT",1359,1,3,0)
 ;;=management.
 ;;^UTILITY(U,$J,"OPT",1359,10,0)
 ;;=^19.01PI^9^9
 ;;^UTILITY(U,$J,"OPT",1359,10,1,0)
 ;;=1349^^5
 ;;^UTILITY(U,$J,"OPT",1359,10,1,"^")
 ;;=DI MGMT MENU
 ;;^UTILITY(U,$J,"OPT",1359,10,2,0)
 ;;=1354^^2
 ;;^UTILITY(U,$J,"OPT",1359,10,2,"^")
 ;;=DIAUDIT
 ;;^UTILITY(U,$J,"OPT",1359,10,3,0)
 ;;=1334^^4
 ;;^UTILITY(U,$J,"OPT",1359,10,3,"^")
 ;;=DISTATISTICS
 ;;^UTILITY(U,$J,"OPT",1359,10,4,0)
 ;;=1368^^1
 ;;^UTILITY(U,$J,"OPT",1359,10,4,"^")
 ;;=DIFG
 ;;^UTILITY(U,$J,"OPT",1359,10,5,0)
 ;;=1361^^3
 ;;^UTILITY(U,$J,"OPT",1359,10,5,"^")
 ;;=DDS SCREEN MENU
 ;;^UTILITY(U,$J,"OPT",1359,10,6,0)
 ;;=1380^^6
 ;;^UTILITY(U,$J,"OPT",1359,10,6,"^")
 ;;=DDXP EXPORT MENU
 ;;^UTILITY(U,$J,"OPT",1359,10,7,0)
 ;;=1381^^7
 ;;^UTILITY(U,$J,"OPT",1359,10,7,"^")
 ;;=DIAX EXTRACT MENU
 ;;^UTILITY(U,$J,"OPT",1359,10,8,0)
 ;;=1393^^9
 ;;^UTILITY(U,$J,"OPT",1359,10,8,"^")
 ;;=DDBROWSER
 ;;^UTILITY(U,$J,"OPT",1359,10,9,0)
 ;;=7716^^8
 ;;^UTILITY(U,$J,"OPT",1359,10,9,"^")
 ;;=DDMP IMPORT
 ;;^UTILITY(U,$J,"OPT",1359,99)
 ;;=59229,43587
 ;;^UTILITY(U,$J,"OPT",1359,"U")
 ;;=OTHER OPTIONS
 ;;^UTILITY(U,$J,"OPT",1360,0)
 ;;=DDS EDIT/CREATE A FORM^Edit/Create a Form^^R^^^^^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1360,1,0)
 ;;=^^2^2^2940630^
 ;;^UTILITY(U,$J,"OPT",1360,1,1,0)
 ;;=An option for editing and creating ScreenMan Forms.  This option calls the
 ;;^UTILITY(U,$J,"OPT",1360,1,2,0)
 ;;=Form Editor.
 ;;^UTILITY(U,$J,"OPT",1360,20)
 ;;=
 ;;^UTILITY(U,$J,"OPT",1360,25)
 ;;=DDGF
 ;;^UTILITY(U,$J,"OPT",1360,99)
 ;;=54872,31063
 ;;^UTILITY(U,$J,"OPT",1360,"U")
 ;;=EDIT/CREATE A FORM
 ;;^UTILITY(U,$J,"OPT",1361,0)
 ;;=DDS SCREEN MENU^ScreenMan^^M^^XUSCREENMAN^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1361,10,0)
 ;;=^19.01PI^4^4
 ;;^UTILITY(U,$J,"OPT",1361,10,1,0)
 ;;=1360^^1^Enter/Edit Screen Definition
 ;;^UTILITY(U,$J,"OPT",1361,10,1,"^")
 ;;=DDS EDIT/CREATE A FORM
 ;;^UTILITY(U,$J,"OPT",1361,10,2,0)
 ;;=1374^^2
 ;;^UTILITY(U,$J,"OPT",1361,10,2,"^")
 ;;=DDS RUN A FORM
 ;;^UTILITY(U,$J,"OPT",1361,10,3,0)
 ;;=1394^^3
 ;;^UTILITY(U,$J,"OPT",1361,10,3,"^")
 ;;=DDS DELETE A FORM
 ;;^UTILITY(U,$J,"OPT",1361,10,4,0)
 ;;=1395^^4
 ;;^UTILITY(U,$J,"OPT",1361,10,4,"^")
 ;;=DDS PURGE UNUSED BLOCKS
 ;;^UTILITY(U,$J,"OPT",1361,99)
 ;;=57909,41932
 ;;^UTILITY(U,$J,"OPT",1361,"U")
 ;;=SCREENMAN
 ;;^UTILITY(U,$J,"OPT",1362,0)
 ;;=DIFG CREATE^Create/Edit Filegram Template^^A^^XUFILEGRAM^^^^^^^^1^^
 ;;^UTILITY(U,$J,"OPT",1362,1,0)
 ;;=^^4^4^2900124^
 ;;^UTILITY(U,$J,"OPT",1362,1,1,0)
 ;;=Use this option to create a filegram template or edit an existing
 ;;^UTILITY(U,$J,"OPT",1362,1,2,0)
 ;;=filegram template.  This option is the first step in developing a
 ;;^UTILITY(U,$J,"OPT",1362,1,3,0)
 ;;=filegram and is very important since there won't be filegrams without
 ;;^UTILITY(U,$J,"OPT",1362,1,4,0)
 ;;=this template.
 ;;^UTILITY(U,$J,"OPT",1362,20)
 ;;=S DI=1 D EN^DIFGO
 ;;^UTILITY(U,$J,"OPT",1362,"U")
 ;;=CREATE/EDIT FILEGRAM TEMPLATE
 ;;^UTILITY(U,$J,"OPT",1363,0)
 ;;=DIFG DISPLAY^Display Filegram Template^^A^^XUFILEGRAM^^^^^^^^1^^
 ;;^UTILITY(U,$J,"OPT",1363,1,0)
 ;;=^^2^2^2900124^
 ;;^UTILITY(U,$J,"OPT",1363,1,1,0)
 ;;=Use this option to display the filegram template in a two-column
 ;;^UTILITY(U,$J,"OPT",1363,1,2,0)
 ;;=format (similar to FileMan's Inquire to File Entries option).
 ;;^UTILITY(U,$J,"OPT",1363,20)
 ;;=S DI=2 D EN^DIFGO
 ;;^UTILITY(U,$J,"OPT",1363,"U")
 ;;=DISPLAY FILEGRAM TEMPLATE
 ;;^UTILITY(U,$J,"OPT",1364,0)
 ;;=DIFG GENERATE^Generate Filegram^^A^^XUFILEGRAM^^^^^^^^1^^
 ;;^UTILITY(U,$J,"OPT",1364,1,0)
 ;;=^^3^3^2900124^
 ;;^UTILITY(U,$J,"OPT",1364,1,1,0)
 ;;=Use this option to generate a filegram into a MailMan message after
 ;;^UTILITY(U,$J,"OPT",1364,1,2,0)
 ;;=selecting the file, filegram template and an entry.  It's a good idea
 ;;^UTILITY(U,$J,"OPT",1364,1,3,0)
 ;;=to know that information before using this option.
 ;;^UTILITY(U,$J,"OPT",1364,20)
 ;;=S DI=3 D EN^DIFGO
 ;;^UTILITY(U,$J,"OPT",1364,"U")
 ;;=GENERATE FILEGRAM
 ;;^UTILITY(U,$J,"OPT",1365,0)
 ;;=DIFG VIEW^View Filegram^^A^^^^^^^^^^1^^
 ;;^UTILITY(U,$J,"OPT",1365,1,0)
 ;;=^^1^1^2900124^
 ;;^UTILITY(U,$J,"OPT",1365,1,1,0)
 ;;=Use this option to view the filegram in filegram format.
 ;;^UTILITY(U,$J,"OPT",1365,20)
 ;;=S DI=4 D EN^DIFGO
 ;;^UTILITY(U,$J,"OPT",1365,"U")
 ;;=VIEW FILEGRAM
 ;;^UTILITY(U,$J,"OPT",1366,0)
 ;;=DIFG SPECIFIERS^Specifiers^^A^^XUFILEGRAM^^^^^^^^1^^
 ;;^UTILITY(U,$J,"OPT",1366,1,0)
 ;;=^^6^6^2900124^
 ;;^UTILITY(U,$J,"OPT",1366,1,1,0)
 ;;=Use this option to identify a particular field in the file as a
 ;;^UTILITY(U,$J,"OPT",1366,1,2,0)
 ;;=reference point for FileMan to use when installing the filegram.
 ;;^UTILITY(U,$J,"OPT",1366,1,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",1366,1,4,0)
 ;;=Specifiers can be compared to FileMan's identifier, unlike identifiers
 ;;^UTILITY(U,$J,"OPT",1366,1,5,0)
 ;;=which are used for interaction purposes...specifiers are used for
 ;;^UTILITY(U,$J,"OPT",1366,1,6,0)
 ;;=transaction purposes.
 ;;^UTILITY(U,$J,"OPT",1366,20)
 ;;=S DI=5 D EN^DIFGO
 ;;^UTILITY(U,$J,"OPT",1366,"U")
 ;;=SPECIFIERS
 ;;^UTILITY(U,$J,"OPT",1367,0)
 ;;=DIFG INSTALL^Install/Verify Filegram^^A^^XUFILEGRAM^^^^^^^^1^^
 ;;^UTILITY(U,$J,"OPT",1367,1,0)
 ;;=^^2^2^2900124^^
 ;;^UTILITY(U,$J,"OPT",1367,1,1,0)
 ;;=Use this option to install the filegram in a FileMan file
 ;;^UTILITY(U,$J,"OPT",1367,1,2,0)
 ;;=from a MailMan message format.  A message of verification should return.
 ;;^UTILITY(U,$J,"OPT",1367,20)
 ;;=S DI=6 D EN^DIFGO
 ;;^UTILITY(U,$J,"OPT",1367,"U")
 ;;=INSTALL/VERIFY FILEGRAM
 ;;^UTILITY(U,$J,"OPT",1368,0)
 ;;=DIFG^Filegrams^^M^^XUFILEGRAM^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1368,1,0)
 ;;=^^1^1^2900124^^^
 ;;^UTILITY(U,$J,"OPT",1368,1,1,0)
 ;;=This is a menu of the Filegram options.
 ;;^UTILITY(U,$J,"OPT",1368,10,0)
 ;;=^19.01PI^6^6
 ;;^UTILITY(U,$J,"OPT",1368,10,1,0)
 ;;=1362^^1
 ;;^UTILITY(U,$J,"OPT",1368,10,1,"^")
 ;;=DIFG CREATE
 ;;^UTILITY(U,$J,"OPT",1368,10,2,0)
 ;;=1363^^2
 ;;^UTILITY(U,$J,"OPT",1368,10,2,"^")
 ;;=DIFG DISPLAY
 ;;^UTILITY(U,$J,"OPT",1368,10,3,0)
 ;;=1364^^3
 ;;^UTILITY(U,$J,"OPT",1368,10,3,"^")
 ;;=DIFG GENERATE
 ;;^UTILITY(U,$J,"OPT",1368,10,4,0)
 ;;=1365^^4
 ;;^UTILITY(U,$J,"OPT",1368,10,4,"^")
 ;;=DIFG VIEW
 ;;^UTILITY(U,$J,"OPT",1368,10,5,0)
 ;;=1366^^5
 ;;^UTILITY(U,$J,"OPT",1368,10,5,"^")
 ;;=DIFG SPECIFIERS
 ;;^UTILITY(U,$J,"OPT",1368,10,6,0)
 ;;=1367^^6
 ;;^UTILITY(U,$J,"OPT",1368,10,6,"^")
 ;;=DIFG INSTALL
 ;;^UTILITY(U,$J,"OPT",1368,99)
 ;;=57909,41931
 ;;^UTILITY(U,$J,"OPT",1368,99.1)
 ;;=54674,36753
 ;;^UTILITY(U,$J,"OPT",1368,"U")
 ;;=FILEGRAMS
 ;;^UTILITY(U,$J,"OPT",1369,0)
 ;;=DIFIELD CHECK^Mandatory/Required Field Check^^A^^^^^^^^^^1
 ;;^UTILITY(U,$J,"OPT",1369,1,0)
 ;;=^^1^1^2901205^
 ;;^UTILITY(U,$J,"OPT",1369,1,1,0)
 ;;=Kernel option to emulate the VA FileMan option to check fields for required data.
 ;;^UTILITY(U,$J,"OPT",1369,20)
 ;;=S DI=10 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1369,"U")
 ;;=MANDATORY/REQUIRED FIELD CHECK
 ;;^UTILITY(U,$J,"OPT",1370,0)
 ;;=DIAUDIT TURN ON/OFF^Turn Data Audit On/Off^^R^^^^^^^^MSC FILEMAN
 ;;^UTILITY(U,$J,"OPT",1370,1,0)
 ;;=^^4^4^3130126^
