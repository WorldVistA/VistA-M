DMSQP ;SFISC/EZ-PRINT SQLI TABLE POINTERS ;10/30/97  16:49
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
EN1 ; in pointers (to this table from others)
 D DT^DICRW S DMQ="" D  D EXIT
 . D OK,ASK:'DMQ,CHK:'DMQ,PR1:'DMQ
 Q
EN2 ; out pointers (from this table out)
 D DT^DICRW S DMQ="" D  D EXIT
 . D OK,ASK:'DMQ,CHK:'DMQ,CHK1:'DMQ,PR2:'DMQ
 Q
OK ; check if okay to run
 I '$O(^DMSQ("S",0)) W !?5,"Sorry, SQLI files are empty.",! S DMQ=1 Q
 I $$WAIT^DMSQT1 D  S DMQ=1 Q
 . W !?5,"Try later.  SQLI is being re-built right now."
 Q
ASK S DIC="1.5215",DIC(0)="QEAM" ; select starting-point table
 D ^DIC K DIC S DMY=+Y S:$D(DTOUT)!$D(DUOUT)!(Y=-1) DMQ=1
 Q
CHK I '$D(^DMSQ("E","F",DMY,"F")) S DMQ=1 W !,?5,"NO POINTERS",!
 Q
CHK1 ; check file access needed for navigation in PR2 report
 I DUZ(0)'="@" F DIFILE=1.5212 D  K DIAC
 . S DIAC="RD" D EN^DIAC S:'% DMQ=1
 D:DMQ 
 . W !!?5,"You need 'Read' access to one SQLI file to run this report."
 . W !?5,"It is file 1.5212."
 . W !!?5,"Contact your system manager to be granted single file access.",!
 Q
PR1 S DIC="1.5216",L=0 ; only foreign keys (screen-out primary)
 S DIS(0)="I '$D(^DMSQ(""E"",""E"",""P"",D0))"
 S DHD="TABLES POINTING TO "_$P(^DMSQ("T",DMY,0),U,1)
 S FLDS="""FROM TABLE: "";S;C5,!E_TABLE;X"
 S FLDS(1)="""VIA FOREIGN KEY: "";C5,E_NAME;X"
 S DMY1=$O(^DMSQ("DM","C",DMY,0))
 S BY(0)="^DMSQ(""E"",""C"",DMY1,",L(0)=1 D EN1^DIP
 Q
PR2 S DIC="1.5216",L=0
 S DHD="TABLES POINTED-TO BY "_$P(^DMSQ("T",DMY,0),U,1)
 S FLDS="""TO TABLE: "";S;C5,E_DOMAIN:,!DM_TABLE;X"
 S FLDS(1)="""VA FOREIGN KEY: "";C5,E_NAME;X"
 S BY(0)="DMSQ(""E"",""F"",DMY,""F"",",L(0)=1 D EN1^DIP
 Q
EXIT K DMY,DMY1,DMQ Q 
