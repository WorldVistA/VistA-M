DMSQP2 ;SFISC/EZ-PRINT SQLI'S DD INFORMATION ;10/30/97  17:29
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
EN ; for a single file or number range, show SQLI projection of fields
 S DMQ="" D CHK,CHK1:'DMQ,ASK:'DMQ,ASK1:'DMQ,PRT:'DMQ,EXIT Q
EN1 ; display file numbers below this one (subfiles)
 D INIT,CHK,ASK:'DMQ,ZIS:'DMQ,DN:'DMQ,EXIT Q
EN2 ; display file numbers above
 D INIT,CHK,ASK:'DMQ,ZIS:'DMQ,UP:'DMQ,EXIT Q
EN3 ; file number choices to use in EN, EN1, EN2
 D INIT,CHK,LST:'DMQ,EXIT Q
INIT S DMQ="" D DT^DICRW Q
ZIS D ^%ZIS S:POP DMQ=1 Q
EXIT K DMFN,DMFN1,DMX,DMX1,DMNODE,DMY,DM1,DM2,DMQ Q
CHK ; check for existence of SQLI data in DMSQ global
 I '$O(^DMSQ("S",0)) W !?5,"Sorry, SQLI files are empty.",! S DMQ=1 Q
 I $$WAIT^DMSQT1 D  S DMQ=1 Q
 . W !?5,"Try later.  SQLI is being re-built right now."
 Q
 Q
CHK1 ; check file access needed for navigation in PRT report
 I DUZ(0)'="@" F DIFILE=1.5211,1.5212,1.5214,1.5216 D  K DIAC
 . S DIAC="RD" D EN^DIAC S:'% DMQ=1
 D:DMQ 
 . W !!?5,"You need 'Read' access to four SQLI files to run this report."
 . W !?5,"They are files 1.5211, 1.5212, 1.5214, and 1.5216."
 . W !!?5,"Contact your system manager to be granted single file access.",!
 Q
ASK ; select file numbers
 S DM1=$O(^DMSQ("T","C",0)),DM2=$O(^DMSQ("T","C",99999999999),-1)
 S DIR(0)="NO^"_DM1_":"_DM2_":999999999",DIR("A")="Starting File Number"
 S DIR("?")="Enter the number of the file, e.g. 200 or 1.5215"
 S DIR("B")=.401 D ^DIR S:$D(DIRUT) DMQ=1 K DIR Q:DMQ  S DMFN=Y
 I '$D(^DMSQ("T","C",DMFN)) W !,"SQLI table not found." G ASK
 Q
ASK1 S DIR("B")=DMFN ; default to one file (not a range)
 S DIR(0)="NO^"_DM1_":"_DM2_":999999999",DIR("A")="  Ending File Number"
 S DIR("?")="Optionally enter a larger number for a range, e.g. 1.5217"
 D ^DIR S:$D(DTOUT)!$D(DUOUT) DMQ=1 K DIR Q:DMQ  S DMFN1=Y
 I '$D(^DMSQ("T","C",DMFN1)) D  G ASK1
 . W !!?5,"There isn't a table for the file number you've entered."
 . W !?5,"(The highest possible number is "_DM2_".)",!
 I DMFN1'=DMFN,DMFN1'>DMFN D  G ASK1
 . W !!?5,"Enter a LARGER number to get a range."
 . W !?5,"The highest possible number here is "_DM2_".",!
 Q
PRT ; report
 S DIC="1.5217",L=0,DHD="SQLI PROJECTION OF FIELDS AS COLUMNS"
 S FLDS="INTERNAL(#4);C1;S;X,.01;C15;X,7;C15;X,5;C42;X,""C_COMPUTE: "";C20"
 S FLDS(1)="13;X,""C_FM_EXEC: "";C20,14;C31;X,""C_OUTPUT_FORMAT: "";C20"
 S FLDS(2)="16:.01;X,""OF_DATA_TYPE: "";C23,16:1;X"
 S FLDS(3)="""OF_EXT_EXPR: "";C24,16:3;C37;X,""E_DOMAIN: "";C15,.01:1:.01;X"
 S FLDS(4)="""DM_DATA_TYPE: "";C42,.01:1:1:.01;X"
 S FLDS(5)="""C_WIDTH/C_SCALE: "";C15,2;X,""/"";X,3;X"
 S FLDS(6)="""DM_WIDTH/DM_SCALE: "";C42,.01:1:4;X,""/"";X,.01:1:5;X"
 S BY(0)="^DMSQ(""C"",""D"",",L(0)=3,FR(0,1)=DMFN,TO(0,1)=DMFN1
 S DISPAR(0,1)="^;""SQLI TABLE NAME: "";S2"
 S DISPAR(0,1,"OUT")="S:Y Y=$O(^DMSQ(""T"",""C"",Y,0)) S Y=$P($G(^DMSQ(""T"",Y,0)),U,1)_"" (""_$P($G(^DMSQ(""T"",Y,0)),U,7)_"")"""
 D EN1^DIP Q
DN ; downward
 S DMX=$O(^DMSQ("T","C",DMFN,0)) ; get table ien
 S DMX=$O(^DMSQ("DM","C",DMX,0)) ; get domain ien (dm_table x-ref)
 S DMX=$P(^DMSQ("DM",DMX,0),U,1) ; get domain name
 S DMX1=0 F  S DMX1=$O(^DMSQ("E","B",DMX,DMX1)) Q:(DMQ)!(DMX1'>0)  D
 . S DMNODE=^DMSQ("T",$P(^DMSQ("E",DMX1,0),U,3),0)
 . Q:$P(DMNODE,U,4)  S DMY=$P(DMNODE,U,7)
 . I $Y+2>IOSL D PAGE I $D(DIRUT) S DMQ=1 Q
 . W !?5,DMY,?20,$$EXTERNAL^DILFD(1.5215,6,"",DMY)
 Q
UP ; upward
 S DMX=$O(^DMSQ("T","C",DMFN,0)) ; get table ien
 S DMX1=0 F  S DMX1=$O(^DMSQ("E","F",DMX,"F",DMX1)) Q:(DMQ)!(DMX1'>0)  D
 . S DMY=$P(^DMSQ("T",$P(^DMSQ("DM",$P(^DMSQ("E",DMX1,0),U,2),0),U,4),0),U,7)
 . I $Y+2>IOSL D PAGE I $D(DIRUT) S DMQ=1 Q
 . W !?5,DMY,?20,$$EXTERNAL^DILFD(1.5215,6,"",DMY)
 Q
PAGE I IOST["C-" S DIR(0)="E" D ^DIR K DIR W @IOF
 Q
LST ; list file names and SQLI tables by file number
 S DIC="1.5215",L=0,BY="@INTERNAL(#6);""FILE NUMBER: """
 S FLDS="INTERNAL(#6);""FILE#"";S,6;C15;L30;""FILEMAN FILE NAME"""
 S FLDS(1)=".01;C48;""SQLI TABLE NAME"""
 S DHD="SQLI TABLES BY FILE NUMBER"
 D EN1^DIP Q
