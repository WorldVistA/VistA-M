FBAACO4 ;AISC/CMR-ENTER PAYMENT CONTINUED ;5/11/1999
 ;;3.5;FEE BASIS;**4**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBJ=0,FBDA=DA
CORRF I $D(^FBAA(161.25,"AF",FBDA)) F  S FBJ=$O(^FBAA(161.25,"AF",FBDA,FBJ)) Q:'FBJ  S:'$D(FBAR(FBJ)) FBA(FBJ)=""
 S FBJ=0 I $D(^FBAA(161.25,FBDA,0)) S FBJ=$P(^(0),"^",6) I $G(FBJ)]"",(FBJ'=FBDA) S:'$D(FBAR(FBJ)) FBA(FBJ)=""
 S FBDA=0,FBDA=$O(FBA(FBDA)) Q:'FBDA  S FBAR(FBDA)="" K FBA(FBDA) D CORRF
 Q
CHK ;Checks for payments against all linked vendors.
 S FBDA=DA,FBAAOUT=0
 S FBJ=0 F  S FBJ=$O(FBAR(FBJ)) Q:'FBJ  I $D(^FBAAC(DFN,FBJ,"AD")) S FBAACK1=1,DA=FBJ N FBAADT,FBAACPT,FBMOD D EN1^FBAAVS Q:$G(FBAAOUT)  S DIR(0)="E" D ^DIR K DIR Q:'Y
 I '$G(FBAACK1) W !!,"Vendor has no prior payments for this patient",!
 S DA=FBDA Q
CHK1 ;Checks for valid invoice selected from all linked vendors.
 K FBAACK1
 I $D(^FBAAC("C",X)) S FBJ=0 F  S FBJ=$O(FBAR(FBJ)) Q:'FBJ  D  K X(1) I $G(FBAACK1) S FBV=FBJ Q
 .I '$G(FBCNP) I $D(^FBAAC("C",X,DFN,FBJ)) S FBAACK1=1
 .I $G(FBCNP) S X(1)=$O(^FBAAC("C",X,0)) I $D(^FBAAC("C",X,X(1),FBJ)) S FBAACK1=1
 I '$G(FBAACK1) W !,*7,"That number not valid for this vendor!"
 Q
CHK2 ;Checks for duplicate payments on all linked vendors.
 N FBMODL
 S FBMODL=$$MODL^FBAAUTL4("FBMODA","I")
 I $D(^FBAAC("AE",DFN,FBV,FBAADT,FBAACP_$S($G(FBMODL)]"":"-"_FBMODL,1:""))) S FBJ=FBV Q
 S FBJ=0 F  S FBJ=$O(FBAR(FBJ)) Q:$S('FBJ:1,$D(^FBAAC("AE",DFN,FBJ,FBAADT,FBAACP_$S($G(FBMODL)]"":"-"_FBMODL,1:""))):1,1:0)
 Q
