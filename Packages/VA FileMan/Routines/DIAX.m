DIAX ;SFISC/DCM-EXTRACT OPTIONS ;12/8/98  07:55
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
0 S DIK="^DOPT(""DIAX""," G OPT:$D(^DOPT("DIAX",9))
 S ^(0)="EXTRACT OPTION^1.01^" K ^("B")
 F I=1:1:9 S ^DOPT("DIAX",I,0)=$P($T(@I),";;",2)
 D IXALL^DIK
OPT W ! S DIC=DIK,DIC(0)="AEQIZ" D ^DIC K DIC,DIK
 I Y'<0 S DI=+Y K Y D EN G 0
 W ! K %,DIC,DIK,DI,DA,I,J,X,Y,DIAX Q
 ;
EN S DIAX=1
 D @DI
 Q
 ;
1 ;;SELECT ENTRIES TO EXTRACT
 G 1^DIAR
 ;
2 ;;ADD/DELETE SELECTED ENTRIES
 S DIAR=2 G ENTE^DIARB
 ;
3 ;;PRINT SELECTED ENTRIES
 S DIAR=3 G OUT^DIARA
 ;
5 ;;CREATE EXTRACT TEMPLATE
 W !!,"This option lets you build a template where you specify fields to extract",!,"and their corresponding mapping in the destination file."
 W !!,"For more detailed description of requirements on the destination file,",!,"please see your VA FileMan User Manual."
 S DI=1 G EN^DIFGO
 ;
4 ;;MODIFY DESTINATION FILE
 W !!,"This option allows you to build a file which will store data extracted from",!,"other files.  When creating fields in the destination file, all data types"
 W !,"are selectable.  However, only a few data types are acceptable for receiving",!,"extracted data."
 W !!,"Please see your User Manual for more guidance on building the destination file."
 D 41 G Q:'$D(DIAXDIC)
 D 61,Q
 Q
41 ;
 G ^DICATT
61 ;
 Q:$P(@(^DIC(DIAXDIC,0,"GL")_"0)"),U,4)
 K DIR S DIR("A")="ARCHIVE FILE",DIR(0)="YO",DIR("??")="^W !?5,""'YES' will not allow modifications or deletions of data or data dictionary"",!?5,""'NO'  will place no restrictions on the file"""
 S DIR("B")=$S($P($G(^DD(DIAXDIC,0,"DI")),U)["Y":"YES",1:"NO")
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S (DIARCH,DIE)=$S(Y:"Y",1:"N")
62 ;
 D FLAG(DIAXDIC,DIE,DIARCH)
 K DIAXDIC,DIE,DIARCH
 Q
H6 W !!?5,"'YES' will not allow editing or deleting existing file entries or adding",!?11,"new file entries"
 W !?5,"'NO'  will place no restrictions on the file"
 Q
6 ;;UPDATE DESTINATION FILE
 N DIAR,DIARC,DIARP,DIARB,DIE,DA,DR,DTOUT,DIAXFNO,%ZIS,POP,ZTRTN,ZTSAVE
 S DIAR=6 D FILE^DIARU G Q:'$D(DIARC)
 N DIARP,DIE,DA,DR
 W !!,"You MUST enter an EXTRACT template name.  This EXTRACT template will be used",!,"to populate your destination file."
 S DIE="^DIAR(1.11,",DA=DIARC,DR="3;I X=""^"" S Y="";S DIARP=X;S DIAXFNO=+$P(^DIPT(DIARP,0),U,9);17////^S X=DIAXFNO" D ^DIE G UNLK:$D(DTOUT)!'$D(DIARP)
 S DIARB=+$P(^DIAR(1.11,DIARC,0),U,3)
 D EN^DIAXM I $G(DIERR) G UNLK
 W $C(7),!,"If entries cannot be moved to the destination file, an exception report",!,"will be printed.",!!,"Select a device where to print the exception report."
 W !!,"QUEUEING to this device will queue the Update process."
 N %ZIS,POP,ZTRTN,ZTSAVE,DIAXIOP
 S %ZIS="Q",%ZIS("A")="EXCEPTION REPORT DEVICE: ",%ZIS("B")="" D ^%ZIS G UNLK:POP S DIAXIOP=ION
 I $D(IO("Q")) S ZTRTN="DQ^DIAXU",(ZTSAVE("DIARP"),ZTSAVE("DIARB"),ZTSAVE("DIARC"))="",ZTSAVE("DIAXIOP")="",ZTIO="" D ^%ZTLOAD G UNLK
 D DIAX^DIAXU
 Q
 ;
7 ;;PURGE EXTRACTED ENTRIES
 S DIAR=90 G ENTD^DIARA
 ;
8 ;;CANCEL EXTRACT SELECTION
 S DIAR=99 G ENTC^DIARA
 ;
9 ;;VALIDATE EXTRACT TEMPLATE
 N X,DIC,Y
 S DIC="^DIPT(",DIC(0)="ASQEM",DIC("A")="Select EXTRACT TEMPLATE: ",DIC("S")="I $P(^(0),U,8)=2"
 D ^DIC Q:Y'>0
 S DIARP=+Y,DIAR=""
 D EN^DIAXM
 D Q G 9
 ;
UNLK N DIAR S DIAR=""
 D UPDATE^DIARU
Q D Q^DIARB
 Q
 ;
FLAG(DIC,DIE,DIARCH) ;
 Q:'DIC  Q:'$D(^DD(DIC,0))
 S $P(^DD(DIC,0,"DI"),U)=DIARCH,$P(^DD(DIC,0,"DI"),U,2)=DIE
 Q
