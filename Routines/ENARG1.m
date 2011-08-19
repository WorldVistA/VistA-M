ENARG1 ;(WIRMFO)/JED/DH/SAB-ARCHIVE DATA DICTIONARY ;4.24.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 ;EXPECTS VARIABLES ENFR,ENTO,ENSEL,ENRT,ENSH,ENSHN,S
 ;CALLED BY ENARG ;CALLS ENARG2,ENARG21,ENARG22,ENARG23
 Q
G W !!,"Now searching data base" D G^ENARG2
 W !,J," Records were found meeting the archive criteria"
 I J=0 W !!,*7,"No data to archive!!    <cr> to continue" R ENR:DTIME S %=2,ENERR="UNACCEPTABLE ARCHIVE DATA." G G2
G1 W !!,"Is it O.K. to accept these data " S %=1 D YN^DICN G:%<0 G1
 I %=0 D  G G1
 . W !!,"ACCEPTING will assign a formal reference number used for transfer to the",!,"archival medium, build the archive global, and delete archived entries from",!,"the actual production file."
 . W !!,"Not ACCEPTING will delete the list of file entries to be archived that was",!,"just built and leave your data base unchanged."
G2 I %'=1 S Z=$P(^ENAR("6919."_ENRT,0),"^",1,2) K ^ENAR("6919."_ENRT) S $P(^ENAR("6919."_ENRT,0),"^",1,4)=Z D OUT Q
 L +^ENG(6919,0):60 S $P(^ENAR("6919."_ENRT,0),"^",3)=J_"^"_J,%DT="XT",X="N" D ^%DT S ENID=ENSTA_"."_Y,Z=$P(^ENG(6919,0),"^",3)
G3 S Z=Z+1 G:$D(^ENG(6919,Z,0)) G3 S $P(^ENG(6919,0),"^",3)=Z,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 S ENGL(1)=ENRT_"^"_ENFR_"^"_ENTO_"^"_ENPARAM_"^"_J_"^^^"_1,ENDA=Z
 S $P(^ENG(6919,Z,0),"^",1)=ENID,^(1)=ENGL(1),^ENG(6919,"B",ENID,Z)="",ENB=$C(34)_ENID_$C(34),^ENAR("6919."_ENRT,-1)="^ENG(6919,""B"","_ENB_","_Z_")"
 L -^ENG(6919,0) S ENEMP="PROG.MODE" I $D(DUZ),DUZ>0 S ENEMP=$P($P(^VA(200,DUZ,0),U),",")
 S ^ENG(6919,Z,2,0)="^6919.01DA^1^1",^ENG(6919,Z,2,1,0)=Y_"^1^"_ENEMP
 W !!,"The identification reference, ",ENID," has been entered",!,"into the Engineering Archive File."
G4 W !!,"Would you like to add a description of the archive medium and perhaps its",!,"location" S %=1 D YN^DICN I %<1 W !,"Please answer Yes or No.",*7 G G4
 I %=1,$E(IOST)'="P" S DJDN=Z,DJSC="ENAR" D EN^ENJ
 I $D(%),%=1,$E(IOST)="P" S DIE=6919,DA=ENDA,DR="6;7" D ^DIE K DIC,DA,DR
 I '$D(^%ZOSF("LOAD"))!('$D(^%ZOSF("SAVE"))) S ENERR="YOUR %ZOSF GLOBAL NODES FOR LOADING AND SAVING A ROUTINE ARE NOT SET UP.",%=2 G G2
 W !!,"Transferring data dictionary"
 S ENA=^%ZOSF("LOAD") F J=3:1 S X=$P($T(ROU+ENRT),";",J) Q:X=""  S Y=$P(X,"Y",1)_"X"_$P(X,"Y",2),XCNP=0,DIF="^ENAR("_ENGBL_",-1,"""_Y_"""," X ENA S ^ENAR(ENGBL,-1,Y,XCNP,0)="$"
 S ^ENAR(ENGBL,-1,"INIT")="W !!,""Initializing data dictionary for this archival file."",! S ENB=^(""INIT2""),ENC=^(""INIT3"") X ^(""INIT1""),ENA W !! D @(""^ENARX""_ENRT_""1"")"
 S ^ENAR(ENGBL,-1,"INIT1")="S ENA=""S X=0 F I=1:1 S X=$O(^ENAR(""_ENGBL_"",-1,X)) Q:X=""""""""  S XCN=0 X ENC,ENB W !,""""Routine """",X,"""" filed."""""""
 S ^ENAR(ENGBL,-1,"INIT2")=^%ZOSF("SAVE")
 S ^ENAR(ENGBL,-1,"INIT3")="S DIE=""^ENAR(""_ENGBL_"",-1,""""""_X_"""""","""
 ;
 W !,"Now extracting data from your files, this could take a while..."
 S (ENI,ENJ,I,J)=0,ENSTART=$P($H,",",2)
 D @(ENRT_"^ENARG2"_ENRT),@("OUT^ENARG2"_ENRT)
 W !,"Elapsed time: ",$J($P($H,",",2)-ENSTART/60,6,2)," minutes."
 K ENSTART
 Q
 ;
OUT K %,DJN,DJSC,ENA,ENB,ENEMP,ENFR,ENID,ENPARAM,ENSHOP,ENTO,J,X,Y,Z,K Q
 ;;
ROU ;;41
 ;;ENARY11;ENARY12;ENARY13;ENARY14;ENARY101;ENARY102
 ;;ENARY21;ENARY22;ENARY23;ENARY24;ENARY201;ENARY202;ENARY203
 ;;ENARY31;ENARY32;ENARY33;ENARY34;ENARY301;ENARY302;ENARY303
 ;;ENARY41;ENARY42;ENARY43;ENARY44;ENARY401;ENARY402;ENARY403;ENARY404
 ;;ENARY51;ENARY52;ENARY53;ENARY54;ENARY501;ENARY502;ENARY503;ENARY504
 ;;
