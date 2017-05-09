LRMLACM ;BPFO/DTG - LAB ASSOCIATE TEST/SPECIMEN TO MLTF ;02/10/2016
 ;;5.2;LAB SERVICE;**468**;FEB 10 2016;Build 64
 ;
 ; Associate Lab Test/Specimen to MLTF
EN ; entry point for association
 N LR60IEN,LRIEN,LRSPEC,A,B,C,LXB,LXA,LROKS,LRSYSTEM,LRLEC,LRNO,AA,DA,LXC,LXA,LRSPERR,LRMLTF,DIR,DIRUT,DIC,DIQ
 N LR64ER,LRCKD,LRELEC,LRLNC,LRLNC0,LRN,LRSN,LRTNAM,X,Y
 S U="^" I $G(DT)="" S DT=$$DT^XLFDT
ENA K DIR,DIRUT
 S DIR(0)="PO^60:EQZM",DIR("A")="LABORATORY TEST"
 D ^DIR K DIR
 I $D(DIRUT) G OUT
 I Y<1 G OUT
 S (LRIEN)=+Y,LRTNAM=$P(Y,U,2)
 D GET60T
 ; check values
 S LRN=$G(LXA(.01,"E")),LR64ER=0
 ; check test subscript is valid for NTRT
 S AA=$G(LXA(4,"I"))
 I AA="WK"!(AA="BB")!(AA="AU")!(AA="EM") W !," Subscript is "_AA_" Skipping" G ENA
 ; check test type
 S AA=$G(LXA(3,"I"))
 I AA="N"!(AA="D") W !," Test Type is: "_AA_" Skipping" G ENA
 ; check for data name
 I $G(LXA(5,"I"))="" W !," "_LRN_" Missing LOCATION(Data Name) Skipping" G ENA
 I $O(^LAB(60,LRIEN,1,0))="" W !," Test "_LRN_" does NOT have any Specimens associated. Skippping" G ENA
 ;
ENB ; pick up specimen
 K DIR,DIRUT
 S DIR(0)="PO^LAB(60,"_LRIEN_",1,:EQZM",DIR("A")="SPECIMEN for "_LRN
 D ^DIR
 I $D(DIRUT) G OUT:$E(X)="^"
 I Y<1 G ENA
 S LRSPEC=+Y
 S DIQ="LXB",DIQ(0)="IE",DIC=60,DR=100,DA=+LRIEN K LXB,^UTILITY("DIQ1",$J)
 S DR(60.01)=".01;6;1;2;9.2;9.3;13;30;32;33;34;35",DA(60.01)=LRSPEC
 D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LXC M LXC=LXB("60.01",LRSPEC) K LXB
 S LRSN=$G(LXC(.01,"E"))
 ;
ENM ; mltf lookup
 K DIR,DA,DIRUT
 S DIR(0)="PO^66.3:EQZ"
 S DIR("S")="I '$$SCREEN^XTID(66.3,"""",(+Y_"",""))"
 S DIR("B")=$G(LXC(30,"E"))
 D ^DIR
 I Y<1 D  G OUT:$D(DIRUT),ENB
 . I X'="@" Q
 . K DIR,DIRUT
 . S DIR(0)="Y",DIR("A")="Are You Sure You Want To Delete This Entry"
 . S DIR("?")="If you enter yes, the MLTF association with this test/specimen will be removed."
 . S DIR("B")="Yes"
 . D ^DIR
 . I 'Y!($D(DIRUT)) Q
 . I Y=1 D MSD
 . ;
 I $D(DIRUT) G OUT
 I +Y>0&(+Y=$G(LXC(30,"I"))) G ENB
 S LRSPERR=0,LRMLTF=+Y
 ; check specimen type (based on code from LRLNC0 at CHKSPEC
 S LRELEC=$P($G(^LAB(61,LRSPEC,0)),U,9)
 S LRLNC0=$$GET1^DIQ(66.3,LRMLTF,.04,"I")
 S LRLNC=$P(LRLNC0,"-",1),LRCKD=$P(LRLNC0,"-",2)
 S A=0,LRSYSTEM="" F  S A=$O(^LAB(95.3,"B",LRLNC,A)) Q:'A  S B=$G(^LAB(95.3,A,0)),LRSYSTEM=$P(B,U,8),C=$P(B,U,15) I C=LRCKD Q
 ; if not found in 95.3
 I 'A G ENS
 D CHKSPEC G:LROKS=1 ENS
 I $D(DIRUT) G OUT:$E(X)="^"
 I LRNO=1 W !,"TEST: ",LRN,!,"SPECIMEN: ",LRSN,! G ENM
 G ENS
 ;
ENS D MSET I LRSPERR=1 W !,"NOT able to Save" G ENM
 S A=$$GET1^DIQ(60.01,LRSPEC_","_LRIEN,30,"E")
 W !!,"Test/Specimen: ",LRN," / ",LRSN,!,"  Saved With MLTF: ",A,!
 G ENB
 ;
OUT ; exit
 K LR60IEN,LRIEN,LRSPEC,A,B,C,AA,DA,LXB,LXA,LROKS,LRSYSTEM,LRLEC,LRNO,LXC,LXA,LRSPERR,LRMLTF,DIR,DIRUT,DIC,DIQ
 K LR64ER,LRCKD,LRELEC,LRLNC,LRLNC0,LRN,LRSN,LRTNAM,X,Y
 Q
 ;
GET60T ; get top of file 60 test info
 S DA=LRIEN,DIQ="LXB",DIQ(0)="IE",DIC=60,DR=".01;3;4;5;64.1;5;13;131;132;133" D EN^DIQ1
 K LXA M LXA=LXB(60,DA) K LXB
 Q
 ;
CHKSPEC ;Check that specimen of MLTF LOINC code same as specimen of test
 S LROKS=1
 I LRSYSTEM=$G(LRELEC) Q
 I (LRSYSTEM=74!(LRSYSTEM=83)!(LRSYSTEM=114)!(LRSYSTEM=1376))&($G(LRELEC)=74!($G(LRELEC)=83)!($G(LRELEC)=114)!($G(LRELEC)=1376)) Q
 S LROKS=0,LRNO=0
 W !!,"The MLTF LOINC code that you have selected does not have the"
 W !,"same specimen that you chose to test/specimen."
 K DIR,DIRUT
 S DIR(0)="Y",DIR("A")="Are you sure you want to do this"
 S DIR("?")="If you enter yes, the test/specimen will be associated to this MLTF LOINC code."
 S DIR("B")="Yes"
 D ^DIR
 I $D(DIRUT) S LRNO=1 Q
 I Y<1 S LRNO=1
 Q
 ;
MSD ; delete the mltf from the 60 file
 N LRMLTF S LRMLTF="@" D MSET
 K LRMLTF
 Q
 ;
MSET ;save the mltf to the 60 file
 N DA,DR,DIE
 L +^LAB(60,LRIEN,1,LRSPEC):30 I '$T S LRSPERR=1 Q
 S DA(1)=+LRIEN,DA=LRSPEC,DR="30///"_LRMLTF,DIE="^LAB(60,"_DA(1)_",1," D ^DIE
 L -^LAB(60,LRIEN,1,LRSPEC)
 Q
 ;
