LRMLWT ;BPFO/DTG - LAB NTRT LOOP 60 FOR MLTF ;02/10/2016
 ;;5.2;LAB SERVICE;**468**;FEB 10 2016;Build 64
 ;
 ; From option LR NTRT WALK ASSOCIATE
 ;
 ; loop through the 60 file by test 
EN ; starting point for walking from newest test to oldest test in file 60
 ; to associate with the MLTF
 N DIE,DR,DA,DIQ,LRTN,LRARY,LRSPARY,DT,A,B,C,D,PS,LASTTEST,DIR,LRIEN,LRSPEC,LRSN,LRS,LRN,LSITE,LRNT,LRNTI,AR,LXA,LXB
 N LRMLTF,LR64,LR64ER,ER,LRSPERR,LROKS,LRSYSTEM,LRLEC,LRNO,X,Y
 N AA,ALA,ALAC,DIC,I,LRCKD,LRELEC,LRLNC,LRLNC0,LT,SCOUNT
 S U="^" I $G(DT)="" S DT=$$DT^XLFDT
 S B=$$SITE^VASITE,B=$P(B,U,1) I 'B Q  ; not set up
 S PS=$O(^LAB(66.4,"B",B,0)) I PS="" Q  ; 66.4 not set up
ENR S LASTTEST=$$GET1^DIQ(66.4,PS_",",.08)
 I LASTTEST="DONE" W !,*7,"Process Has Been Completed" G QUIT
 D GET664
 I LASTTEST="" S LASTTEST=$O(^LAB(60,"A"),-1) I LASTTEST?1.N S LR64ER=0 D  I LR64ER=1 G SETER
 . L +^LAB(66.4,PS):30 I '$T S LR64ER=1 Q
 . S LASTTEST=LASTTEST+1,DA=PS,DIE="^LAB(66.4,",DR=".08///"_LASTTEST
 . D ^DIE
 . L -^LAB(66.4,PS)
 ;
LOOP ; start the process
 S LRIEN=LASTTEST K LRSPARY
L1 S LRIEN=$O(^LAB(60,LRIEN),-1) I LRIEN="" S LRIEN="DONE" G LOUT
 D GET60T
 S LRN=$G(LXA(.01,"E")),LR64ER=0
 ; check test subscript is valid for NTRT
 S AA=$G(LXA(4,"I"))
 I AA="WK" S LR64ER=0 D LSET G:LR64ER=1 SETER G L1
 I AA="BB" D LSET G:LR64ER=1 SETER G L1
 ; check test type
 S AA=$G(LXA(3,"I"))
 I AA="N"!(AA="D") D LSET G:LR64ER=1 SETER G L1
 ; check for data name
 I $G(LXA(5,"I"))="" D LSET G:LR64ER=1 SETER G L1
 ;
 ; loop ^LAB(60 specimen level
 S LT=0,LRS=0
 D Q1 I LRS<1 D  S LR64ER=0 D LSET G:LR64ER=1 SETER G ENR
 . I SCOUNT<1 W !!,*7," *** This Test ( ",LRN," [",LRIEN,"]) Does Not Have any Specimens",!!
 G L2
L2 ;loop through specimens
 K DIR,DIRUT
 S DIR("A")="Enter The Number For The Specimen to Associate With The MLTF"
 S DIR(0)="SO^",ALAC=0
 F I=1:1:LRS S ALA=$G(LRSPARY(I)) I ALA'="" S ALAC=ALAC+1 S:ALAC>1 DIR(0)=DIR(0)_";" S DIR(0)=DIR(0)_I_":"_LRSPARY(I)
 W !!,"TEST: "_LRN
 W !,"SPECIMEN(s)",!
 D ^DIR
 I $D(DIRUT) G QUIT:$E(X)="^"
 I Y'?1.N G LX
 S A=$G(LRSPARY(Y)) I A="" W !,*7,"Number out of Range" G L2
 S LRSPEC=$P($P(A,"[",2),"]",1),LRSN=$P(A," ",1) I LRSPEC'?1.N W !,*7,"Specimen not found" G L2
L2M ; come here to ask MLTF
 K DIR,DA,DIRUT
 S DIR(0)="PO^66.3:EQZ"
 S DIR("S")="I '$$SCREEN^XTID(66.3,"""",(+Y_"",""))"
 D ^DIR
 I $D(DIRUT) G QUIT:$E(X)="^"
 I +Y'>0 G LX:LRS<2,L2Q
 S LRSPERR=0,LRMLTF=+Y
 ; check specimen type (based on code from LRLNC0 at CHKSPEC
 S LRELEC=$P($G(^LAB(61,LRSPEC,0)),U,9)
 S LRLNC0=$$GET1^DIQ(66.3,LRMLTF,.04,"I")
 S LRLNC=$P(LRLNC0,"-",1),LRCKD=$P(LRLNC0,"-",2)
 S A=0,LRSYSTEM="" F  S A=$O(^LAB(95.3,"B",LRLNC,A)) Q:'A  S B=$G(^LAB(95.3,A,0)),LRSYSTEM=$P(B,U,8),C=$P(B,U,15) I C=LRCKD Q
 ; if not found in 95.3
 I 'A G L2S
 D CHKSPEC G:LROKS=1 L2S
 I $D(DIRUT) G QUIT:$E(X)="^"
 I LRNO=1  W !,"TEST: ",LRN,!,"SPECIMEN: ",LRSN,! G L2M
 G L2S
 ;
L2S D MSET I LRSPERR=1 G SETER
 S A=$$GET1^DIQ(60.01,LT_","_LRIEN,30,"E")
 W !,LRSN,": Saved With MLTF ",A,!
 S LT=0,LRS=0 K LRSPARY D Q1 I LRS<1 D  S LR64ER=0 D LSET G:LR64ER=1 SETER G ENR
 . I SCOUNT<1 W !!,*7," *** This Test ( ",LRN," [",LRIEN,"] Does Not Have any Specimens",!! R X:10
 G L2
 ;
L2Q ; ask to see additional specimens
 K DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do You Wish to Evaluate Additional Specimens? "
 D ^DIR
 I $D(DIRUT) G QUIT:$E(X)="^"
 I Y=1 S LT=0,LRS=0 K LRSPARY D Q1 W:LRS<1 *7,"   No More Specimens To Check For This Test" G:LRS<1 LX G L2
 G LX
LX ;
 K DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do You Wish to go to The Next Test?"
 D ^DIR
 I $D(DIRUT) G QUIT:$E(X)="^"
 I Y=1 S LR64ER=0 D LSET G:LR64ER=1 SETER G ENR
 K DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do You Wish to Exit?" D ^DIR
 G QUIT:$D(DIRUT) I Y=1 K DIR,DIRUT S LR64ER=0 D  G:LRNO=1 QUIT G SETER:LR64ER=1,QUIT
 . S LRNO=0,DIR(0)="Y",DIR("B")="YES",DIR("A")="Do You Wish to Skip This Test on Re-Start?" D ^DIR
 . I $D(DIRUT) S LRNO=1 Q
 . I Y=1 D LSET
 G ENR
 ;
Q1 ; pick up spcimens from test
 S SCOUNT=0
Q1A S LT=$O(^LAB(60,LRIEN,1,LT)) I 'LT Q
 S SCOUNT=SCOUNT+1
 S B=$$GET1^DIQ(60.01,LT_","_LRIEN,30,"I") I B'="" G Q1A
 S A=$$GET1^DIQ(60.01,LT_","_LRIEN,.01,"E")
 S LRS=LRS+1,LRSPARY(LRS)=A_" ["_LT_"]" ;LT_"-"_A
 G Q1A
 ;
QUIT ;
 K DIE,DR,DA,DIQ,LRTN,LRARY,LRSPARY,A,B,C,D,PS,LASTTEST,DIR,LRIEN,LRSPEC,LRSN,LRS,LRN,LSITE,LRNT,LRNTI,AR,LXA,LXB
 K LRMLTF,LR64,LR64ER,ER,LRSPERR,LROKS,LRSYSTEM,LRLEC,LRNO
 K AA,ALA,ALAC,DIC,I,LRCKD,LRELEC,LRLNC,LRLNC0,LT,SCOUNT,X,Y
 Q
 ;
LOUT D LSET G:LR64ER=1 SETER
 I LRIEN="DONE" G QUIT
 K LRSPARY
 G ENR
 ;
LSET ;put the last ien in 66.4 .08
 N DA,DIE,DR
 S DA=PS
 L +^LAB(66.4,DA):30 I '$T S LR64ER=1 Q
 S DIE="^LAB(66.4,",DR=".08///"_LRIEN D ^DIE
 L -^LAB(66.4,DA)
 Q
 ;
SETER ; come here if not able to open files and quit
 W !,*7,"unable to open file... EXITING " R X:10 G QUIT
 ;
MSET ;save the mltf to the 60 file
 N DA,DR,DIE
 L +^LAB(60,LRIEN,1,LRSPEC):30 I '$T S LRSPERR=1 Q
 S DA(1)=+LRIEN,DA=LRSPEC,DR="30///"_LRMLTF,DIE="^LAB(60,"_DA(1)_",1," D ^DIE
 L -^LAB(60,LRIEN,1,LRSPEC)
 Q
 ;
GET664 ; get file 66.4 info
 S LSITE=$$SITE^VASITE,LSITE=$P(LSITE,U,1)
 S LRNT=$O(^LAB(66.4,"B",LSITE,0))
 D GETS^DIQ(66.4,LRNT_",","**","IE","AR")
 M LRNTI=AR("66.4",LRNT_",") K AR
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
