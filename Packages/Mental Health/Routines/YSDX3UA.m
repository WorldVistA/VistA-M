YSDX3UA ;SLC/DJP/LJA,HIOFO/FT - Utilities for Diagnosis Entry in the MH Medical Record (cont.) ;10/21/11 1:24pm
 ;;5.01;MENTAL HEALTH;**96,60**;Dec 30, 1994;Build 47
 ;
 ;Reference to ^VA(200, supported by DBIA #10060
 ;Reference to ^ICD9( supported by DBIA #5388
 ;Reference to ^ICDCODE APIs supported by DBIA #3990
 ;
 ;
DSMLK ; Called by routine YSDX3
 ; Keyword lookup for DSM
 ; naked reference to ^YSD(627.7,D0,0)
 S DIC("S")="I $P(^(0),U,2)=4" ; Allow DSM-IV selection only
 S DIC(0)="QMZE",DIC="^YSD(627.7,"
 D ^DIC
 K DIC("S")
 Q
 ;
DSMP ; Called by routine YSDX3
 ;D RECORD^YSDX0001("DSMP^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 I '$D(P2) W " ?? " W @IOF G AGAIN^YSDX3
 S S1=$P(^YSD(627.8,P2(X1),1),U),S2=$P(S1,";"),YSY=1
 QUIT
 ;
 ;
ICDLK ; Called from YSDX3A
 ; Lookup on the ICD9 File
 S X=$P(X2," ") G:$P(X2," ",2)="" ICD1
 ; naked reference to ^ICD9(D0,1) for (#10) DESCRIPTION [1F]
 S Q=$C(34),D="S A=$C(32)_^(1) I "
 F I=2:1 S B=$P(X2," ",I) Q:B=""  S:B'[Q D=D_"(A["" "_B_""")&"
 S DIC("S")=$E(D,1,$L(D)-1)
ICD1 ;
 S X=X2,DIC(0)="QMZE",DIC="^ICD9("
 D ^DIC
 K DIC("S")
 QUIT
 ;
ICDP ; Called by routine YSDX3A
 ;D RECORD^YSDX0001("ICDP^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 S S1=$P(^YSD(627.8,P2(X2),1),U),S2=$$ICDDX^ICDCODE($P(S1,";")),S2=$P(S2,U,2),YSY=1 ;ASF 04/10/09
 QUIT
 ;
DXLS D DXLS^YSDX3UA0
 QUIT
 ;
DXLSQ D DXLSQ^YSDX3UA0
 QUIT
 ;
DUPL ; Called by routine YSDX3, YSDX3A
 ; Print out information concerning duplicate entry
 ;D RECORD^YSDX0001("DUPL^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 S W3=$P(^VA(200,$P(^YSD(627.8,W2,0),U,4),0),U)
 N YSDZX
 S Y=$P(^YSD(627.8,W2,0),U,3) D DD^%DT S W4=Y
 I YSAX=1 S YSDXND=$P(^YSD(627.7,S2,0),U),YSDXD=$P(^(0),U)
 I YSAX=3 S YSDXD=$P(^ICD9(S2,0),U) N YSDXZ S YSDZX=$$ICDD^ICDCODE(YSDXD,"YSDZX"),YSDXND=YSDZX(1) ;asf 04/10/09
 S W5=$P(^YSD(627.8,W2,1),U,2)
 I W5="i" K YSDXND,YSDXD,W3,W4,W5 QUIT  ;->
 S W6=$S(W5="v":"VERIFIED",W5="p":"PROVISIONAL",W5="i":"INACTIVE",W5="r":"REFORMULATED",W5="n":"NOT FOUND",W5="ru":"RULE OUT",1:"")
DUPLP ;
 ;D RECORD^YSDX0001("DUPLP^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 I '$D(YSF1) D
 .  W !!,"This diagnosis has been entered as follows:  "
 .  W !!?5,"DIAGNOSIS: ",?15,YSDXND_" "_YSDXD,!?5,"STATUS:"
 .  W ?13,W6,!?5,"BY:",?13,$E(W3,1,25)_" on "_W4,!
 S YSF1=1
 QUIT
 ;
FILE ; Called from routines YSDX3, YSDX3A
 ;D RECORD^YSDX0001("FILE^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 S YSDUZ=$P(^VA(200,DUZ,0),U)
 W !
 S DIE=DIC,DA=YSDA,DR=".02///"_YSDFN_";.03//NOW;.04//"_YSDUZ_";.05///^S X=""`""_DUZ;1///^S X=YSDXDA;5"
 L +@(DIE_"DA)"):DILOCKTM
 I '$T D ERRMSG^YSSITE,DELETE Q
 D ^DIE
 L -@(DIE_"DA)")
 S YSTOUT=$D(DTOUT) I YSTOUT D DELETE QUIT  ;->
 D CHECK QUIT:YSUOUT  ;->
 S C1=$P(^YSD(627.8,YSDA,1),U,2)
 I C1="" W !!?18,"Incomplete information." D DELETE QUIT  ;->
 S C2=$S(C1="v":"A",C1="p":"A",C1="i":"I",C1="r":"I",C1="n":"I",C1="ru":"A",1:"I")
 S DIE="^YSD(627.8,",DA=YSDA,DR="7///^S X=C2;8///NOW"
 L +^YSD(627.8,DA):DILOCKTM
 I '$T D ERRMSG^YSSITE Q
 D ^DIE
 L -^YSD(627.8,DA)
 K DIE
 S YSTOUT=$D(DTOUT) I YSTOUT QUIT  ;->
 D CHECK QUIT:YSUOUT  ;->
 N YSTO S YSTO=0
 I $D(W3) D  Q:YSTO
 .  S DIE="^YSD(627.8,",DA=YSDUPDA
 .  S DR="7///^S X=""I"";8///NOW;9///^S X=""Y"""
 .  L +^YSD(627.8,DA):DILOCKTM
 .  I '$T D ERRMSG^YSSITE S YSTO=1 Q
 .  D ^DIE
 .  L -^YSD(627.8,DA)
 D DXLS,DXLSQ
 S DIE="^YSD(627.8,",DA=YSDA
 S DR="10///^S X=YSDXLX;80"
 L +^YSD(627.8,DA):DILOCKTM
 I '$T D ERRMSG^YSSITE Q
 D ^DIE
 L -^YSD(627.8,DA)
 S YSTOUT=$D(DTOUT) QUIT:YSTOUT  ;->
 D CHECK QUIT:YSUOUT  ;->
FILEQ ;
 ;D RECORD^YSDX0001("FILEQ^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 S %=0
 F  Q:$G(%)  W !!," Do you want to record this diagnosis" S %=1 D
 .  D YN^DICN
 .  I '% W !!,"NO will delete this entry.  YES will file it under the patient's name."
 I %=2!(%=-1) D DELETE
 QUIT
 ;
CHECK ;
 ;D RECORD^YSDX0001("CHECK^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 S YSUOUT=$O(Y(""))]"" I 'YSUOUT QUIT  ;->
 W !!?18,"Incomplete information."
 ;
DELETE ; Called by routine YSDX3UB
 ;D RECORD^YSDX0001("DELETE^YSDX3UA") ;Used for testing.  Inactivated in YSDX0001...
 S DIK="^YSD(627.8,",DA=YSDA
 D ^DIK
 W !!?15,"< This diagnosis deleted. >"
 QUIT
 ;
EOR ;YSDX3UA - Utilities for Diagnosis Entry in the MH Medical Record (cont.) ;4/16/92 11:17
