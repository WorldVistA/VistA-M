DGPTFM2 ;ALB/DWS - MASTER PROFESSIONAL SERVICE ENTER/EDIT ;6/16/05 8:33am
 ;;5.3;Registration;**517,590,606,635,850,912,1057**;Aug 13, 1993;Build 17
ADD ;ADD CPT RECORD
 N DGZP S DGZP=0 S:'$D(^DGPT(PTF,"C",0)) ^(0)="^45.06D^^"
 S DIC="^DGPT("_PTF_",""C"",",DIC(0)="AELQMXZ",DA(1)=PTF,DLAYGO=45
 D ^DIC K DIC,DLAYGO G ^DGPTFM:Y'>0,^DGPTFM:'$D(^DGPT(PTF,"C",+Y))
 S DGPSM=+Y
 I '$P(Y,U,3) S DIR("A")="Do you want to edit this CPT RECORD DATE/TIME?",DIR(0)="Y",DIR("B")="YES" D ^DIR G ^DGPTFM:'Y!$D(DIRUT)
 D MOB
 I $P(DGZPRF,U,3) F I=1:1:$P(DGZPRF,U,3) S:DGZPRF(I,0)=DGPSM DGZP=I
 K I G:'DGZP ^DGPTFM S X="A,B",DGPSM=0
ED G HELP^DGPTUTL1:X'["A"&(X'["B")&(X'["a")&(X'["b") K DA
 S DGJUMP=X,DGPRD=+DGZPRF(DGZP),X1="^801"
 I X["A"!(X["a") D  L -^DGPT(PTF) I FLAG D MOB,REQ^DGPTFM3 G EXIT
 .S DA(1)=PTF,DIE="^DGPT("_PTF_",""C"",",(DA,REC)=DGZPRF(DGZP,0)
 .S DR=".01;.02;.03;.05;.09////0",DIC(0)="AELQZ" Q:'$$LOCK
 .D FMDIE S FLAG=$D(Y)>9!$D(DOUT)!'$D(DA) Q:$D(Y)>9!'$D(DA)
 .S DGPRD=+^DGPT(PTF,"C",DGZPRF(DGZP,0),0) Q:+DGZPRF(DGZP)=DGPRD
 .S DGI=0 F  S DGI=$O(^DGCPT(46,"C",PTF,DGI)) Q:DGI'>0  D  Q:$D(Y)>9!'$D(DA)
 ..Q:+^DGCPT(46,DGI,1)'=+DGZPRF(DGZP)  Q:$D(^(9))
 ..S DR=".14////"_DGPRD,(DA,REC)=DGI,DIE="^DGCPT(46," D FMDIE
 ..I $D(Y)>9!'$D(DA) S FLAG=1
 ..;ADD IMPDATE check to see if Edit on date changed coding system
 . I $P(DGZPRF(DGZP),U)<IMPDATE,DGPRD'<IMPDATE D EN^DDIOL("Primary Diagnosis changing from ICD-9 to ICD-10. You must edit the Diagnosis.") S DGJUMP="B"
 . I $P(DGZPRF(DGZP),U)'<IMPDATE,DGPRD<IMPDATE D EN^DDIOL("Primary Diagnosis changing from ICD-10 to ICD-9. You must edit the Diagnosis.") S DGJUMP="B"
 .S $P(DGZPRF(DGZP),U)=DGPRD
JUMP I DGJUMP["B"!(DGJUMP["b") S DGI=0 D CL^SDCO21(DFN,DGPRD,"",.SDCLY) D
 .F  S DGI=$O(^DGCPT(46,"C",PTF,DGI)) Q:DGI'>0  I +^DGCPT(46,DGI,1)=+DGZPRF(DGZP),'$G(^(9)) D  I $D(DUOUT) Q:'DGDIAG  K DUOUT S DGI=0
 ..S (DA,REC)=DGI,DR=".01;",DIE="^DGCPT(46," D GETINFO^DGPTFM21
 .Q:$D(DUOUT)
 .F  D  D ^DIC S A=0 Q:Y'>0  D SED Q:$D(DUOUT)
 ..S DA=PTF,DIC="^DGCPT(46,",DIC(0)="AELMQZ",DLAYGO=46
 ..S DIC("S")="D EN6^DGPTFJC I 'DGER"
 I $D(DUOUT),$G(DGDIAG) K DUOUT G JUMP
 I $D(DUOUT),$G(DGJUMP)["A"!($G(DGJUMP)["a") S X=DGJUMP K DUOUT G ED
 K DR,DIE,DIC,DA,DGI,DGJUMP,DGPRD,DLAYGO,XREF
 D REQ^DGPTFM3,MOB H:RFL 2 K RFL
 G ^DGPTFM:'$D(DGZPRF(DGZP,0)),^DGPTFM:'$D(^DGPT(PTF,"C",DGZPRF(DGZP,0)))
SET D MOB:'$D(DGZPRF) S:'$D(DGZP) DGZP=1 I $G(DGZPRF(DGZP,0))="" K DGZPRF(DGZP) G NEXP
WRT G ^DGPTFM:'$D(^DGPT(PTF,"C",DGZPRF(DGZP,0),0)) S J=DGZP W @IOF,HEAD,?68
 N DGNUM S Z="<"_DGZP_">" W @DGVI,Z,@DGVO
 W !,?30,"Initial Date Of Service: ",$$EXTERNAL^DILFD(45,14,,$G(DGIDTS))  ; DG*5.3*1057
 W !! S Y=+DGZPRF(J),Z="A"
 D D^DGPTUTL,Z^DGPTFM5 W ?5,"CPT Record Date/Time: ",Y
 I $P(DGZPRF(J),U,8)'="" W ?55,"Visit Service Category: ",$P(DGZPRF(J),U,8)
 I $P(DGZPRF(J),U,2) W !,?5,"Referring or Ordering Provider: " D
 .S L=$P(DGZPRF(J),U,2) D PRV^DGPTFM
 W !,?5,"Rendering Provider: " S L=$P(DGZPRF(J),U,3) D PRV^DGPTFM
 I $P(DGZPRF(J),U,5) W !,?5,"Rendering Location: ",$P($G(^SC($P(DGZPRF(J),U,5),0)),U)
 W !! S Z="B" D Z^DGPTFM5 W "  Procedures:   "
 F K=$P(DGZPRF,U,2):1 Q:'$D(DGZPRF(J,K))  I '$D(DGZPRF(J,K,9)) D
 .W ?5 D CPT^DGPTUTL1 W ! Q:$Y>16
 F I=1:1:(IOSL-$Y-5) W !
 K I,J,K,L,Z S DGNUM=$S($D(DGZPRF(DGZP+1)):DGZP+1,1:"MAS")
 G 801^DGPTFJC:DGST
 S DIR("A")="Enter <RET> to continue, A-B to edit, 'I' to add an 801,"
 S DIR("A")=DIR("A")_$C(10,13)_"the number of an 801 screen, ?? to list 801 screens,"
 S DIR("A")=DIR("A")_$C(10,13)_"'S' for Send to PCE,"
 S DIR("A")=DIR("A")_" '^N' for screen N, or '^' to abort:"
 S DIR("?")="^D HELP^DGPTUTL1"
 S DIR(0)="F^OU",DIR("B")=DGNUM,DIR("??")="^D DISP^DGPTUTL1" D ^DIR
 K DIR G:$D(DIRUT) Q^DGPTF:X="^"
 I X?1"^".E S DGPTSCRN=801 G ^DGPTFJ
 I X="MAS" S DGZP=1 G ^DGPTFM
 G ADD:X="I"!(X="i"),HELP^DGPTUTL1:X["?"
 I X?1N.N,$D(DGZPRF(X)) S DGZP=X G SET
 I X["A"!(X["B")!(X["a")!(X["b") G ED
 I X="S"!(X="s") D PCE G WRT
 D HELP^DGPTUTL1 R !!,"Enter <RET>: ",X:DTIME G WRT
PCE L +^DGPT(PTF):2
 I '$T W !,"CPT Record is being edited by another user" H 2 Q
 D ICDINFO^DGAPI(DFN,PTF),XREF^DGPTFM21
 S RES=$$DATA2PCE^DGAPI1(DFN,PTF,DGZP)
 I RES=1 L -^DGPT(PTF) W !,"PTF Record sent to PCE" H 2 Q
 W @IOF
 ;F I=1:1 Q:'$D(^TMP("DGPAPI",$J,"DIERR",$J,1,"TEXT",I))  W !,^(I)
 W !,"The PTF Record may not have been filed in PCE due to errors."
 W !,"Press return to continue." R X:DTIME
 L -^DGPT(PTF) Q
NEXP S DGZP=DGZP+1
 I '$D(DGZPRF(DGZP)) W:DGZP=2 !,"NO PROF. SERVICES TO EDIT." G EXIT
 G SET
EXIT K DGPSM H 2 S DGZP=1 G ^DGPTFM
DEL ;DELETE A CPT RECORD
 I '$P(DGZPRF,U,3) G NOPROC
ASK S DIR("A")="Select 801 record to Delete"
 S DIR(0)="NO^1:"_$P(DGZPRF,U,3),DIR("??")="^D DISP^DGPTUTL1"
 D ^DIR K DIR G ^DGPTFM:$D(DIRUT),^DGPTFM:'Y,^DGPTFM:'$D(^DGPT(PTF,"C",DGZPRF(Y,0),0)) S DGZP=Y,Y=+^(0) D D^DGPTUTL
 S DIR("A")="Are you sure you want to delete the entire 801 for "_Y
 S DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G ^DGPTFM:'Y,^DGPTFM:'$$LOCK
 ;patch DG*5.3*912 modifies where the date is being set for deletion. This allows multiple cpt codes to be deleted from 801 in the ptf
 S DGI=0
 F  S DGI=$O(^DGCPT(46,"C",PTF,DGI)) Q:DGI'>0  D:+^DGCPT(46,DGI,1)=+DGZPRF(DGZP)&'$G(^(9))
 .D NOW^%DTC S (DA,REC)=DGI,DIE="^DGCPT(46,",DR="1////^S X=%" D FMDIE
 S DR=".09////1",DIE="^DGPT("_PTF_",""C"",",DA=DGZPRF(DGZP,0)
 S DA(1)=PTF D ^DIE L -^DGPT(PTF)
 W !!,"CPT Records....Deleted" H 2
 K DIK,DA,DGI,DGPROC,DGPSM,DGPNUM,Y D MOB G ^DGPTFM
NOPROC  W !!,*7,"No procedures to delete",! H 3 G ^DGPTFM
N ;ADD CPT CODES TO CPT RECORD
 I '$P(DGZPRF,U,3) W !!,"There are no 801 records that can be added to.",*7 H 2 G ^DGPTFM
P1 S DIR("A")="Add to 801 record ",DIR(0)="NO^1:"_$P(DGZPRF,U,3)
 S DIR("??")="^D DISP^DGPTUTL1"
 D ^DIR K DIR G ^DGPTFM:'Y
 S DGZP=Y,DGI=0,DGPRD=+DGZPRF(DGZP) D CL^SDCO21(DFN,DGPRD,"",.SDCLY)
 S DA=PTF,DIC="^DGCPT(46,",DIC(0)="AELQMZ",DLAYGO=46,DIC("S")="D EN6^DGPTFJC I 'DGER"
 D ^DIC K DIC,DLAYGO D:Y>0 SED,MOB,REQ^DGPTFM3 K DGPRD,Y
 D PCE^DGPTFQWK G ^DGPTFM
DC ;DELETE A CPT PROCEDURE
 I $E($G(ANS),2,99)>0 S DGPZ=+$E(ANS,2,99) G QQ
 S DIR("A")="Select 801 record to Delete a CPT code in"
 S DIR(0)="NO^1:"_$P(DGZPRF,U,3),DIR("??")="^D DISP^DGPTUTL1"
 D ^DIR K DIR G ^DGPTFM:$D(DIRUT),^DGPTFM:'Y,^DGPTFM:'$D(^DGPT(PTF,"C",DGZPRF(Y,0),0)) S DGZP=Y,Y=+^(0) D D^DGPTUTL
 F PS2=1:1 Q:'$D(DGZPRF(DGZP,PS2))  S PS2(PS2)=DGZP_"^"_PS2
 S PS2=PS2-1
QQ S DIR("A")="Select CPT code to Delete <1 - "_PS2_">",DIR(0)="NO^^K:X<1!(X>"_PS2_") X" D ^DIR K DIR G ^DGPTFM:$D(DIRUT),^DGPTFM:'Y
QQA S A1=Y,DGZP=+PS2(A1),CPT=+DGZPRF(DGZP,$P(PS2(A1),U,2))
 S DIR("A")="Are you sure you want to delete CPT code '"
 I $D(^ICPT(CPT)) D
 .S N=$$CPT^ICPTCOD(CPT,$$GETDATE^ICDGTDRG(PTF))
 .S N=$S(N>0:$P(N,U,2,99),1:"")
 .S DIR("A")=DIR("A")_$P(N,U)_" "_$P(N,U,2)_"'"
 E  S DIR("A")=DIR("A")_CPT_"  UNKNOWN"
 S DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G ^DGPTFM:'Y
 G ^DGPTFM:'$$LOCK
QEL D NOW^%DTC S DA=DGZPRF(DGZP,$P(PS2(A1),U,2),0),DR="1////^S X=%"
 S REC=DGZPRF(DGZP,0)
 S DIE="^DGCPT(46," D FMDIE K A1,DR W !!,"CPT Code....Deleted"
 I '$D(DGZPRF(DGZP,2)) S DR=".09////1",DIE="^DGPT("_PTF_",""C"",",DA=DGZPRF(DGZP,0),DA(1)=PTF D ^DIE
 I $D(DGZPRF(DGZP,2)) D PCE^DGPTFQWK
 L -^DGPT(PTF) W:$X>70 ! D MOB H 2 G ^DGPTFM
F D MOB S DGZP=$S($E($G(ANS),2,99):+$E($G(ANS),2,99),1:1) G SET
MOB S (H,I,N)=0 K DGZPRF F M=1:1:6 S:$D(SDCLY(M)) N=N+1
 F I2=1:1 S H=$O(^DGPT(PTF,"C","B",H)) Q:H'>0  D
 .F  S I=$O(^DGPT(PTF,"C","B",H,I)) Q:I'>0  D
 ..S DGZPRF(I2)=^DGPT(PTF,"C",I,0),DGZPRF(I2,0)=I,(K,K1)=0,F=1 D
 ...F  S K=$O(^DGCPT(46,"C",PTF,K)),L=N+1\2+3 Q:K'>0  I +DGZPRF(I2)=+$G(^DGCPT(46,K,1)),'$G(^DGCPT(46,K,9)) D
 ....S K1=K1+1,DGZPRF(I2,K1)=^(0),DGZPRF(I2,K1,0)=K,F=0
 ....F M=2,3,5,6,7,15,16,17,18 S:$P(DGZPRF(I2,K1),U,M) L=L+1
 ....S DGZPRF(I2,K1,1)=L
 ...I F,$G(DGPSM)'=DGZPRF(I2,0) K DGZPRF(I2) S I2=I2-1
 S DGZPRF="1^1^"_(I2-1) K F,I,K,K1,N Q
SED S DR=".14////"_DGPRD_";.16////"_PTF_";",(DA,REC)=+Y,DIE="^DGCPT(46," D GETINFO^DGPTFM21 Q
FMDIE ;Prompt user for questions and file answers (using DIE)
 D ^DIE Q:$D(Y)>9  S RES=$$DELVFILE^DGAPI1(DFN,PTF,DGZP) K DIE,REC Q
LOCK() L +^DGPT(PTF):2 I  Q 1
ERR W !,"CPT Record is being edited by another user" K DIE,REC H 2 Q 0
