LRLNCMD ;DALOI/CA/FHS-MAP LAB TESTS TO DEFAULT LOINC CODES ;1-MAY-1999
 ;;5.2;LAB SERVICE;**232,278,280,407**;Sep 27,1994;Build 1
 ;=================================================================
 ; Ask VistA test to map-Lookup in Lab Test file #60
START ;entry point from option LR LOINC MAPPING
 Q:$D(LRDFONLY)
 S LREND=0 D TEST
 I $G(LREND) G EXIT
 I '$G(LRNLT) G START
DEFAULT ;ENTRY POINT FROM LRLNC0
 W !
 S DIR(0)="Y",DIR("A")="Do you want to see possible LOINC code matches"
 S DIR("?")="Enter no if you already know the LOINC code."
 S DIR("B")="No"
 D ^DIR K DIR
 I $D(DIRUT),$G(LRLNC1) Q
 I $D(DIRUT) D EXIT G START
 I 'Y D ENTERLNC^LRLNCC
 I $G(LREND),$G(LRLNC1) K LREND Q
 I $G(LREND) D EXIT G START
 I '$G(LRCODE) D LOINC
 I $G(LRNO),$G(LRLNC1) K LREND Q
 I $G(LRNO) D EXIT G START
 I $G(LREND),$G(LRLNC1) K LREND Q
 I $G(LREND) D EXIT G START
 I $G(LRNO) D ENTERLNC^LRLNCC
 I $G(LREND),$G(LRLNC1) K LREND Q
 I $G(LREND) D EXIT G START
CORRECT W !!
 S DIR(0)="Y",DIR("A")="Is this the correct one"
 S DIR("B")="Yes"
 S DIR("?")="Enter no to select a different code."
 D ^DIR K DIR
 I $D(DIRUT)!($G(LREND)),$G(LRLNC1) K LREND Q
 I $D(DIRUT)!($G(LREND)) D EXIT G START
 I 'Y,$G(LRNO) D ENTERLNC^LRLNCC
 I 'Y,'$G(LRNO) D LOINC
 I $G(LRNO) D EXIT G START
 I $G(LREND),$G(LRLNC1) K LREND Q
 I $G(LREND) D EXIT G START
 D LINK
 I $G(LREND),$G(LRLNC1) K LREND Q
 I $G(LREND) D EXIT G START
 D CHECK
 I $G(LREND),$G(LRLNC1) K LREND Q
 I $G(LREND) D EXIT G START
 D MAP
 I $G(LRLNC1) K LRCODE Q
 D EXIT
 G START
EXIT I $G(LRNLT) L -^LAM(LRNLT,9)
 K DA,DIC,DIE,DINUM,DIR,DIRUT,DR,DTOUT,I,LRCODE,LRDATA,LREND,LRLNC,LRLNC0,LRLOINC,LRELEC,LRIEN,LRNLT,LRSPEC,LRSPECL,LRSPECN,LRTIME,LRTEST,LRUNITS,S,Y
 K DD,DO,DLAYGO,LRLNCNAM,LRNO,X,LRNUM,LROLDCD
 QUIT
TEST D TEST^LRLNC0
 Q
LOINC ;Lookup possible LOINC matches in LAB LOINC file #95.3
 D FIND^DIC(95.3,"","80","M",LRTEST,"","","I '$G(^(4))","","LRLOINC","")
CODE ;ask which code to map
 I +LRLOINC("DILIST",0)=0 D  Q
 .W !!,"No matches found."
 .S LRNO=1
 W ! S I=0
 F  S I=$O(LRLOINC("DILIST","ID",I)) Q:'I!$G(LREND)  D
 .I $E(IOST,1,2)="C-",'(I#18) D  Q:$G(LREND)
 ..S DIR(0)="E" D ^DIR
 ..S:$S($G(DIRUT):1,$G(DUOUT):1,1:0) LREND=1
 .W !,I,":",LRLOINC("DILIST","ID",I,80)
 K DIRUT,DUOUT
 W !!
 S DIR(0)="N^1:"_$S($G(LREND):I-2,1:$P(LRLOINC("DILIST",0),U),1:0)
 S DIR("A")="LOINC code to map this test"
 D ^DIR K DIR,LREND
 I $D(DIRUT) S LREND=1 Q
 S LRCODE=LRLOINC("DILIST",1,+Y)
 D DISPL^LRLNCC
 Q
LINK ;Link the code with file 64
 S LRNLT=+$P(^LAM(LRNLT,0),U,2)
LR64 ;
 K DIC,DA
 W !!
 S DIC=64,DIC(0)="ENMZ",X=LRNLT
 D ^DIC
 I Y=-1!($D(DTOUT))!($D(DUOUT)) K DTOUT,DUOUT S LREND=1 Q
 S LRNLT=+Y
 Q
CHECK ;Check to see if already mapped to a LOINC code
 Q:'$P($G(^LAM(LRNLT,9)),U)
 D SHOWPRE
 I $D(DIRUT)!'Y S LREND=1 Q
 ;DELETE EXISTING DEFAULT MAPPING
 S DA=LRNLT
 S DIE="^LAM(",DR="25////@"
 D ^DIE
 K DA,DIE
 Q
MAP ;DIE call to add DEFAULT LOINC CODE
 I '$D(LRDFONLY)  S LRDATA=$P(^LAB(60,LRIEN,0),U,12) ;DATA NAME
 I '$L(LRDATA) S LRDATA=$P(^LAB(60,LRIEN,0),U,4)
 S LRTIME=$P(^LAB(95.3,LRCODE,0),U,7) ;TIME ASPECT
 S LRUNITS=$P(^LAB(95.3,LRCODE,0),U,14) ;UNITS
 L +^LAM(LRNLT):1 I '$T W !,"Another user is editing this record!!" H 5 Q
 S DIE="^LAM(",DA=LRNLT,DR="25////"_LRCODE_";25.2////"_LRTIME_";25.3////"_LRUNITS_";25.4////"_LRDATA_";25.5////"_$S($D(LRDFONLY):"@",1:LRIEN)
 D ^DIE
 L -^LAM(LRNLT)
MAP2 ;HERE SHOW WHAT WAS MAPPED
 Q:'$D(^LAM(+$G(LRNLT),0))#2
 W !!
 W !,"NLT: ",$P($G(^LAM(LRNLT,0)),U)
 W !,"WKLD CODE: ",$P($G(^LAM(LRNLT,0)),U,2)
 K DIC,DR
 S DIC="^LAM(",DA=LRNLT
 S S=$Y
 D EN^DIQ
 Q
SHOWPRE ;DISPLAY LOINC CODE ALREADY MAPPED TO NLT
 S LROLDCD=$P(^LAM(LRNLT,9),U)
 W !!,"This test is already mapped to:"
 W !,"Default LOINC code: ",LROLDCD_"-"_$P(^LAB(95.3,+$G(LROLDCD),0),U,15),"  ",$G(^LAB(95.3,LROLDCD,80))
 W !!
 S DIR(0)="Y",DIR("A")="Do you want to "_$S($D(LRDEL):"delete",1:"change")_" this default mapping",DIR("B")="NO"
 S:'$D(LRDEL) DIR("?")="If you enter yes, the current default LOINC code will be overwritten with the default LOINC code that you have chosen."
 S:$D(LRDEL) DIR("?")="If you enter yes, the current default LOINC code will be deleted."
 D ^DIR K DIR
 Q 
DELETE ;DELETE/UNMAP DEFAULT LOINC CODE
 S LREND=0,LRDEL=1 D TEST
 I $G(LREND) G EXIT
 D CHECK
 K LRDEL
 G EXIT
 Q
 Q
