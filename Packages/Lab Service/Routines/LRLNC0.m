LRLNC0 ;DALOI/CA/FHS-MAP LAB TESTS TO LOINC CODES ;1-OCT-1998
 ;;5.2;LAB SERVICE;**215,232,278,280,399,407**;Sep 27,1994;Build 1
 ;Reference to ^DD supported by IA # 10154
 ;=================================================================
 ; Ask VistA test to map-Lookup in Lab Test file #60
START ;entry point from option LR LOINC MAPPING
 S LREND=0,LRLNC1=1 D TEST
 I $G(LREND) G EXIT
 I '$G(LRNLT) G START
 ;MAP DEFAULT
DEFAULT ;
 N LRNLTX
 Q:'$D(^LAM(+$G(LRNLT),0))#2
 S LRNLTX=LRNLT
 L +^LAM(LRNLTX,9):2 I '$T W !!?5,"Locked by another user",! H 5 Q
 W !
 K DIR S DIR("B")="No"
 S DIR(0)="Y",DIR("A")="Do you want to edit/delete the Default LOINC code"
 S DIR("?")="Enter yes to map/change the default LOINC code."
 D ^DIR K DIR
 L -^LAM(LRNLTX,9)
 I $D(DIRUT) Q
 I $G(LRDFONLY),$D(DIRUT) Q
 I '$G(LRDFONLY),$D(DIRUT) D EXIT G START
 I Y D  D DEFAULT^LRLNCMD
 . Q:'$G(^LAM(LRNLT,9))
 . W !!?5,"Deleting LOINC Default Code",!
 . N DA,DR,X,DIE
 . S DIE="^LAM(",DA=+LRNLT,DR="25///^S X=""@""" D ^DIE
 L -^LAM(LRNLTX,9)
 I $G(LRDFONLY) Q
 I '$P($P($G(^LAB(60,LRIEN,0)),U,5),";",2) Q
ASKSPEC D SPEC
 I $G(LREND) D EXIT G START
 W !!
 S DIR(0)="Y",DIR("A")="Do you want to see possible LOINC code matches"
 S DIR("?")="Enter no if you already know the LOINC code."
 S DIR("B")="No"
 D ^DIR K DIR
 I $D(DIRUT) D EXIT G START
 I 'Y D ENTERLNC^LRLNCC
 I $G(LREND) D EXIT G START
 I '$G(LRCODE) D LOINC
 I $G(LRNO) D EXIT G START
 I $G(LREND) D EXIT G START
 I $G(LRNO) D ENTERLNC^LRLNCC
 I $G(LREND) D EXIT G START
CORRECT W !!
 S DIR(0)="Y",DIR("A")="Is this the correct one"
 S DIR("B")="Yes"
 S DIR("?")="Enter no to select a different code."
 D ^DIR K DIR
 I $D(DIRUT)!($G(LREND)) D EXIT G START
 I 'Y,$G(LRNO) D ENTERLNC^LRLNCC
 I 'Y,'$G(LRNO) D LOINC
 I $G(LRNO) D EXIT G START
 I $G(LREND) D EXIT G START
 D CHKSPEC
 I $G(LRNO) D EXIT G START
 I $G(LRNEXT) G NEXTSP
 I $G(LREND) D EXIT G START
 D LINK
 I $G(LRNEXT) G NEXTSP
 I $G(LREND) D EXIT G START
 D CHECK
 I $G(LRNEXT) G NEXTSP
 I $G(LREND) D EXIT G START
 D MAP
NEXTSP D KILL1
 G ASKSPEC
KILL1 I $G(LRNLT) L -^LAM(LRNLT,9)
 K DA,DIC,DIE,DINUM,DIR,DIRUT,DR,DTOUT,I,LRLNC,LRLNC0,LRLOINC,LRELEC,LRCODE,LRSPEC,LRSPECL,LRSPECN,LRTIME,LRUNTIS,S,Y
 K DD,D0,DLAYGO,LRLNCNAM,LRNO,LRNOP,LRLNC1,LRNEXT,LRODLCD,X
 Q
EXIT I $G(LRNLT) L -^LAM(LRNLT,9)
 K DA,DIC,DIE,DINUM,DIR,DIRUT,DR,DTOUT,I,LRCODE,LRDATA,LREND,LRLNC,LRLNC0,LRLOINC,LRELEC,LRIEN,LRNLT
 K LRSPEC,LRSPECL,LRSPECN,LRTIME,LRTEST,LRUNITS,S,Y
 K DD,DO,DLAYGO,LRLNCNAM,LRNO,LRNOP,LRDEF,LRLNC1,LRNEXT,LROLDCD,X
 QUIT
TEST W @IOF
 K DIR,LRNLT
 S DIR(0)="PO^60:QENMZ,",DIR("A")="VistA Lab Test to "_$S($D(LRDEL):"Delete/Unmap",1:"Link/Map")_" to LOINC "
 S DIR("?")="Select Lab test you wish to "_$S($D(LRDEL):"delete/unmap",1:"link/map")_" to a LOINC Code"
 D ^DIR K DIR
 I $D(DIRUT)!'Y K DIRUT S LREND=1 K LRDEL Q
 S LRIEN=+Y,LRTEST=$P(Y,U,2)
 L +^LAB(60,LRIEN):2 I '$T W !?4,"Another user is editing this entry",! H 5 Q
 ;Check for RESULT NLT CODE and if not one let enter
 S LRNLT=+$P($G(^LAB(60,LRIEN,64)),U,2)
DIS64 D  Q:$G(LR64DIS)
 . Q:'$G(LRNLT)
 . N LRLNC,LRANS
 . S LRLNC=$P($G(^LAM(LRNLT,9)),U) Q:'LRLNC
 . D GETS^DIQ(64,LRNLT_",",".01;1","E","LRANS")
 . D GETS^DIQ(95.3,LRLNC_",",".01;80","E","LRANS")
 . W !,!?5,$G(LRANS(64,LRNLT_",",.01,"E"))_" "_$G(LRANS(64,LRNLT_",",1,"E"))
 . W !?4,"Default LOINC Already Mapped to:"
 . W !,$G(LRANS(95.3,LRLNC_",",.01,"E"))_"  "_$G(LRANS(95.3,LRLNC_",",80,"E"))
 I '$P($G(^LAB(60,LRIEN,64)),U,2) D
 .W !!,"There is not a RESULT NLT CODE for "_LRTEST,".",!
 .W !,"You must select one now to continue with the mapping of this test!",!
 K DIE,DA,DR S DIE="^LAB(60,",DA=+LRIEN,DR=64.1 D ^DIE K DIE,DA,DR
 L -^LAB(60,LRIEN)
 I $G(X)<1!($D(Y)) S LRNLT="",LREND=1 K LRDEL Q
 I $P($G(^LAB(60,+LRIEN,64)),U,2) D
 . N DIC,DA,DR
 . S DIC="^LAB(60,",DA=+LRIEN,DR=64 W !! W ?5,"IEN: [",DA,"] ",$P(^LAB(60,LRIEN,0),U) S S=$Y D EN^DIQ
 W !
 S LRNLT=$P($G(^LAB(60,LRIEN,64)),U,2)
 I 'LRNLT G TEST
 Q
SPEC ; Ask Specimen- Lookup in Specimen multiple in Lab Test file #60
 W !!
LOOK61 K DIC,DA
 N LRANS
 Q:'$G(LRIEN)
 S DIC=61,DIC(0)="AENMZQ"
 S DIC("A")="Specimen source: "
 D ^DIC
 I $D(DUOUT)!($D(DTOUT))!(Y<1) D  Q
 .K DIC,DA,DTOUT,DUOUT S LREND=1 Q
 Q:$G(LREND)
 S LRSPEC=+Y,LRSPECN=Y(0,0)
 K DA,DIC,DIE,DR
 I '$L($P($G(^LAB(60,LRIEN,0)),U,5)) G OVER
 I '$D(^LAB(60,LRIEN,1)) D
 .S DIC("P")=$P(^DD(60,100,0),"^",2)
 I '$D(^LAB(60,LRIEN,1,LRSPEC)) D  G:$G(LRNOP) LOOK61
 . N DIR
 . W !," Are you sure you want to add this specimen"
 . S DIR(0)="Y" D ^DIR I Y<1 S LRNOP=1 Q
 . K DD,DO
 . S DA(1)=LRIEN,X=LRSPEC,DINUM=X
 . S DIC="^LAB(60,"_DA(1)_",1,"
 . S DIC(0)="LMZ",DLAYGO=60.01
 . D FILE^DICN S LRANS=Y
 ;A DIE call is made to edit fields in subfile
 I $P($G(LRANS),U,3) D
 .S DIE=DIC K DIC
 .S DA=+Y
 .S DR="1:9.3"
 .D ^DIE
 K DIE,DR,DA
OVER ;Check to see if linked to file 64.061.  If not, then let enter link.
 I '$P($G(^LAB(61,LRSPEC,0)),U,9) D
 .W !!,"There is not a LEDI HL7 code for "_LRSPECN,"."
 .W !,"You must select one now to continue with the mapping of this test and specimen!",!
 I '$P($G(^LAB(61,LRSPEC,0)),U,10) D  G:$G(LRNOP) LOOK61
 .W !!,"There is not a TIME ASPECT for "_LRSPECN,".",!
 .K DIE,DR,DA S DA=LRSPEC,DIE="^LAB(61,",DR=".09:.0961"
 .D ^DIE
 .S:$D(DIRUT) LRNOP=1
 S LRELEC=$P($G(^LAB(61,LRSPEC,0)),U,9)
 I 'LRELEC G SPEC
 S LRSPECL=$P(^LAB(64.061,LRELEC,0),U,2)
 Q
LOINC ;Lookup possible LOINC matches in LAB LOINC file #95.3
 D FIND^DIC(95.3,"","80","M",LRTEST,"","","I $P(^(0),U,8)=$G(LRELEC)!(LRELEC=74!(LRELEC=83)!(LRELEC=114)!(LRELEC=1376)&(""SER PLAS BLD""[$P(^(80),"":"",4)))","","LRLOINC","")
CODE ;ask which code to map
 D CODE^LRLNCC
 Q
LINK ;Link the code with file 64
 S LRDATA=$P(^LAB(60,LRIEN,0),U,12) ;DATA NAME
 I '$L(LRDATA) S LRDATA=$P($G(^LAB(60,+$G(LRIEN),0)),U,4) ;Set to subscript of test.
 S LRTIME=$P(^LAB(95.3,LRCODE,0),U,7) ;TIME ASPECT
 S LRUNITS=$P(^LAB(95.3,LRCODE,0),U,14) ;UNITS
 S LRNLT=+$P(^LAM(LRNLT,0),U,2)
LR64 ;
 K DIC,DA
 W !!
 S DIC=64,DIC(0)="ENMZ",X=LRNLT
 D ^DIC
 I Y<1 D EXIT S LREND=1 Q
 I $D(DTOUT)!($D(DUOUT)) K DTOUT,DUOUT D EXIT S LREND=1 Q
 I 'Y S LRNEXT=1 Q
 S LRNLT=+Y
 Q
CHECK ;Check to see if already mapped to a LOINC code
 I $D(^LAM(LRNLT,5,LRSPEC,1,"B",LRTIME)) D SHOWPRE I $D(DIRUT) D EXIT S LREND=1 Q
 I Y<1 S LRNEXT=1
 Q
MAP ;DIE call to add data name,time aspect,units, LOINC code, and lab test fields
 L +^LAM(LRNLT,5):1 I '$T W !,"Another user is editing this record" H 5 Q
 I '$D(^LAM(LRNLT,5,0)) D
 .S DIC("P")=$P(^DD(64,20,0),"^",2)
 I '$D(^LAM(LRNLT,5,LRSPEC)) D
 .K DD,DO
 .S DA(1)=LRNLT,DA=LRSPEC
 .S DIC="^LAM("_DA(1)_",5,",DIC(0)="L",DLAYGO=64,X=LRSPEC,DINUM=X
 .D FILE^DICN
 I '$D(^LAM(LRNLT,5,LRSPEC,1,0)) D
 .S DIC("P")=$P(^DD(64.01,30,0),"^",2)
 S DA(2)=LRNLT,DA(1)=LRSPEC,X=LRTIME,DINUM=X
 S DIC="^LAM("_DA(2)_",5,"_DA(1)_",1,"
 I '$D(^LAM(LRNLT,5,LRSPEC,1,LRTIME)) D
 .K DD,DO
 .S DIC(0)="L",DLAYGO=64
 .D FILE^DICN
 S DA=LRTIME
 K DIE,DR S DIE=DIC K DIC
 S DR="1////"_LRUNITS_";2////"_LRDATA_";3////"_LRIEN_";4////"_LRCODE
 D ^DIE
 L -^LAM(LRNLT,5)
 ;HERE SHOW WHAT WAS MAPPED
 W @IOF
 W !!
 W !,"NLT: ",$P($G(^LAM(LRNLT,0)),U)
 W !,"WKLD CODE: ",$P($G(^LAM(LRNLT,0)),U,2)
 W !,"SPECIMEN: ",$P($G(^LAB(61,LRSPEC,0)),U)
 K DIC,DR
 S DIC=DIE
 S S=$Y
 D EN^DIQ
INDEX60 ;Stores LOINC code in Laboratory Test file (#60) so know what tests are mapped.
 Q:'$L($P($G(^LAB(60,LRIEN,0)),U,5))  ;set only atomic tests
 N LRDA,LRFDA,LRERR
 I '$G(^LAB(60,LRIEN,1,LRSPEC,0)) D
 . K LRFDA,LRDA
 . S LRFDA(1,60.01,"+1,"_LRIEN_",",.01)=LRSPEC
 . S LRDA(1)=LRSPEC
 . D UPDATE^DIE("","LRFDA(1)","LRDA","LRERR")
 Q:$D(LRERR)
 K LRFDA
 S LRFDA(2,60.01,LRSPEC_","_LRIEN_",",95.3)=LRCODE
 D FILE^DIE("","LRFDA(2)","LRERR")
 Q
SHOWPRE ;DISPLAY LOINC CODE ALREADY MAPPED TO NLT
 S LRLNC=$P($G(^LAM(LRNLT,5,LRSPEC,1,LRTIME,1)),U)
 W !!,"This test and specimen is already mapped to:"
 W !,"LOINC code: ",LRLNC,"  ",$G(^LAB(95.3,+LRLNC,80))
 W !
 K DIR S DIR("B")="No"
 S DIR(0)="Y",DIR("A")="Do you want to change this mapping"
 S DIR("?")="If you enter yes, the current LOINC code will be overwritten with the LOINC code that you have chosen."
 D ^DIR K DIR
 Q 
CHKSPEC ;Check that specimen of LOINC code same as specimen of test
 I LRLNC0(8)=$G(LRELEC) Q
 I (LRLNC0(8)=74!(LRLNC0(8)=83)!(LRLNC0(8)=114)!(LRLNC0(8)=1376))&($G(LRELEC)=74!($G(LRELEC)=83)!($G(LRELEC)=114)!($G(LRELEC)=1376)) Q
 W !!,"The LOINC code that you have selected does not have the"
 W !,"same specimen that you chose to map."
 S DIR(0)="Y",DIR("A")="Are you sure you want to do this"
 S DIR("?")="If you enter yes, the test will be mapped to this LOINC code."
 S DIR("B")="Yes"
 D ^DIR K DIR
 I $D(DIRUT) S LREND=1 Q
 I Y<1 S LRNO=1
 Q
6206 ;LOINC mapping ANTIMICROBIAL [^LAB(62.060)]
 W !!
 D EXITMI
 S (LRDEL,LRDFONLY)=1
 S DIR(0)="PO^62.06:QENMZ",DIR("A")="Select Antimicrobial "
 S DIR("?")="Select Antimicrobial Susceptibility Drug"
 D ^DIR K DIR
 I $D(DIRUT)!(Y<1) K DIRUT D EXITMI Q
 S LRIEN=Y,LRTEST=$P(Y(0),U,2)
 L +^LAB(62.06,LRIEN):2 I '$T W !?4,"Being edited by another user" H 5 G 6206
 ;Display Mapped code
 S (LRNLTX,LRNLT)=+$P($G(^LAB(62.06,+LRIEN,64)),U)
 I LRNLT D
 . N LR64DIS
 . S LR64DIS=1 D DIS64
 D
 . N DIE,DA,DR
 . S DIE="^LAB(62.06,",DIC=DIE,DA=+LRIEN,DR=64 D ^DIE
 L -^LAB(62.06,LRIEN)
 I '$G(^LAB(62.06,+LRIEN,64))!($D(DTOUT))!($D(DUOUT)) G 6206
 S LRDATA="LAB(62.06,"_+LRIEN_",",LRIEN=+LRIEN
 S LRNLT=$P($G(^LAB(62.06,+LRIEN,64)),U)
 I LRNLT S LRTEST=$$GET1^DIQ(64,LRNLT_",",.01,"ERR","ANS")
 I LRNLT W ! D DEFAULT
 G 6206
 Q
EXITMI ;Clean up 6206 variables.
 K ANS,DA,DIC,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,ERR,LRANS,LRDATA,LRDEF,LRDFONLY,LRNLT,LRNLTX,LRIEN,LRTEST
 K LRDEL,LRDFONLY,X,Y
 Q
