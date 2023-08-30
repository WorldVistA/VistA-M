IBCEOB0 ;ALB/TMP/PJH - 835 EDI EOB MSG PROCESSING ; 8/24/10 7:23pm
 ;;2.0;INTEGRATED BILLING;**135,280,155,431,488,516,633,727**;21-MAR-94;Build 34
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
LINE() ;Extract Provider Line Reference from 42 record
 N SUB,NODE,VAL
 S VAL="",SUB=IBA1 ; from loop in UPD3611^IBCEOB
 ;IB*2.0*516/TAZ - Quit when another RT 40 is encountered to prevent group of
 ;mismatched procedures
 F  S SUB=$O(@IBFILE@(SUB)) Q:SUB=""  D  Q:(+NODE>42)!(+NODE=40)
 .S NODE=$G(@IBFILE@(SUB,0))
 .S:NODE["RAW DATA" NODE=$P(NODE," ",3,99)
 .;Q:+NODE'=42  S VAL=$P(NODE,U,5)  ;WCJ;IB727;sometimes (always) only the first 42 record has piece 5 so grab the last one that is there.
 .Q:+NODE'=42
 .S:$P(NODE,U,5)]"" VAL=$P(NODE,U,5)
 Q VAL
 ;
30(IB0,IBEOB,IBOK) ; Process record type 30 for EOB
 ; IB0 = the record being processed
 ; IBEOB = the ien of the EOB entry in file 361.1
 ; IBOK = Returned as 1 if record filed OK, 0 if error occurred
 ;
 N A
 S A="3;4.01;0;1;1^5;4.02;0;1;1^6;4.03;1;0;0^7;4.05;1;0;0^8;4.06;1;0;0^9;4.07;1;0;0^10;4.08;1;0;0^11;4.09;1;0;0^12;4.1;1;0;0^13;4.11;1;0;0^14;4.19;0;1;1"
 ;
 S IBOK=$$STORE^IBCEOB1(A,IB0,IBEOB)
 I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad MEDICARE Inpt Adjudication data"
Q30 Q
 ;
40(IB0,IBEOB,IBOK) ; Process record type 40 for EOB
 ; IB0 = the record being processed
 ; IBEOB = the ien of the EOB entry in file 361.1
 ; IBOK = Returned as 1 if record filed OK, 0 if error occurred
 ;
 ; IBZDATA is also assumed to exist or if not, it is created in FINDLN
 ;
 N A,LEVEL,IBSEQ,IBDA,IBPC,IBLREF,IBIFN,Q,X,Y,DA,DD,DO,DIC,DLAYGO,PLREF,ERRCOD
 K ^TMP($J,40) ; the entry # for corresponding 41, 42, and 45 records
 ;
 S IBIFN=+$G(^IBM(361.1,IBEOB,0))
 L +^IBM(361.1,IBEOB,15):0 I $T S IBSEQ=+$O(^IBM(361.1,IBEOB,15," "),-1)+1
 I '$G(IBSEQ) S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Record lock failure - could not acquire next service line number" G Q40
 ;
 ; Update the 40 record data a little bit (pieces 3/4/16)
 I $P(IB0,U,21)="NU" S $P(IB0,U,4)=$P(IB0,U,3),$P(IB0,U,3)=""
 S $P(IB0,U,16)=$S(+$P(IB0,U,16):$P(IB0,U,16)/100,1:+$P(IB0,U,18)/100)
 I $P(IB0,U,4)?1.N S $P(IB0,U,4)=+$P(IB0,U,4)
 ;
 ; Find the line item from original bill for this adjustment
 S PLREF=$S('HIPAA:$P(IB0,U,22),1:$$LINE()) ; old format from 40 record, new format from 42
 S ERRCOD=0
 S IBLREF=+$$FINDLN^IBCEOB1(IB0,IBEOB,.IBZDATA,+PLREF,.ERRCOD)
 I 'IBLREF D  G Q40
 . N Z,Z0,CT,ETEXT
 . S EFLAG=0,ETEXT=""
 . ;;S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Service line detail could not be matched to a billed item"
 . S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)=" "
 . S ETEXT=$P("Revenue Code^Procedure Code^Amount of Units^Charge Amount^Procedure Code Modifier",U,+ERRCOD)
 . I ETEXT="" S ETEXT="Data"
 . S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)=$$ERRTXT(ETEXT,IBEOB) ; IB*2.0*633
 . S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)=" "
 . D DET40^IBCEOB00(IB0,.Z0,ERRCOD)
 . S CT=+$O(^TMP(IBEGBL,$J,""),-1),Z=0 F  S Z=$O(Z0(Z)) Q:'Z  S CT=CT+1,^TMP(IBEGBL,$J,CT)=Z0(Z)
 ;
 S DIC="^IBM(361.1,"_IBEOB_",15,",DIC(0)="L",DLAYGO=361.115,DA(1)=IBEOB
 S X=IBSEQ
 S DIC("DR")=".12////"_+IBLREF_$S($P(IBLREF,U,2)="":"",1:";.15////"_$P(IBLREF,U,2))_";.16////"_$$DATE^IBCEU($P(IB0,U,19))_$S($P(IB0,U,20):";.17////"_$$DATE^IBCEU($P(IB0,U,20)),1:"")
 D FILE^DICN K DIC,DO,DD,DLAYGO ;Add a new LINE LEVEL ADJUSTMENT ('SVC')
 I Y<0 S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not add a LINE LEVEL ADJUSTMENT ("_IBSEQ_")" G Q40
 ;
 L -^IBM(361.1,IBEOB,15)
 ;
 S LEVEL=15.1,LEVEL(0)=+Y,LEVEL(1)=IBEOB,LEVEL("DIE")="^IBM(361.1,"_IBEOB_",15,"
 S A="3;.04;0;0;0^4;.1;0;0;0^9;.09;0;0;0^17;.03;1;0;0^18;.11;0;1;D2^21;.18;0;0;0"
 I '$P(IB0,U,18),$P(IB0,U,16) S $P(A,U,5)="16;.11;0;1;1"
 I $$STORE^IBCEOB1(A,IB0,IBEOB,.LEVEL) S ^TMP($J,40)=LEVEL(0),IBOK=1
 I '$G(IBOK) S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Bad data for line level adjustment "_IBSEQ G Q40
 ;
 ; Store modifiers in multiple
 S DIC="^IBM(361.1,"_IBEOB_",15,"_LEVEL(0)_",2,",DIC(0)="L",DLAYGO=361.1152,DA(2)=IBEOB,DA(1)=LEVEL(0)
 F Q=5:1:8 S X=$P(IB0,U,Q) I X'="" D FILE^DICN K DO,DD I Y<0 S IBOK=0 Q
 K DLAYGO,DIC,DR,DA
 I '$G(IBOK) S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not file modifier data for line level adjustment "_IBSEQ G Q40
Q40 Q
 ;
41(IB0,IBEOB,IBOK) ; Process record type 41 for EOB
 ; IB0 = the record being processed
 ; IBEOB = the ien of the EOB entry in file 361.1
 ; IBOK = Returned as 1 if record filed OK, 0 if error occurred
 ;
 N DA,DR,DIE,X,Y,Z,Z0,CT
 I '$G(^TMP($J,40)) D  G Q41
 . S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Service line adjustment (EEOB Record 41) has no matching service line"
 . D DET4X^IBCEOB00(41,IB0,.Z0)
 . S CT=+$O(^TMP(IBEGBL,$J,""),-1),Z=0 F  S Z=$O(Z0(Z)) Q:'Z  S CT=CT+1,^TMP(IBEGBL,$J,CT)=Z0(Z)
 ;
 S DR="",IBOK=1
 S DA=+^TMP($J,40),DA(1)=IBEOB
 S DIE="^IBM(361.1,"_DA(1)_",15,"
 I +$P(IB0,U,3) S DR=".13///"_$$DOLLAR^IBCEOB($P(IB0,U,3))
 I +$P(IB0,U,4) S DR=DR_$S(DR="":"",1:";")_".14///"_$$DOLLAR^IBCEOB($P(IB0,U,4))
 I DR'="" D ^DIE S IBOK=($D(Y)=0)
 I '$G(IBOK) S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Mismatched data for service line adjustment-2 (EEOB Record 41)"
 ;
 ; For Medicare MRA's only:
 ; If the Allowed Amount field is present, then we need to file an
 ; adjustment:  Group code PR, Reason code AAA, Amount, Quantity, and
 ; Reason Text.  This is data normally found on the 45 record, so we're
 ; going to create our own "45" record and file it.
 ;
 I $P($G(^IBM(361.1,IBEOB,0)),U,4)=1,+$P(IB0,U,3) D
 . N IB45,IBSAV40
 . S IB45=45_U_$P(IB0,U,2)_U_"PR"_U_"AAA"_U_$P(IB0,U,3)_U_"0000000001"
 . S IB45=IB45_U_"Allowed Amount"
 . S IBSAV40=$G(^TMP($J,40))
 . D 45(IB45,IBEOB,.IBOK)
 . S ^TMP($J,40)=IBSAV40
 . I '$G(IBOK) S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not file the PR-AAA adjustment for the Allowed Amount at line "_+^TMP($J,40)
 . Q
 ;
Q41 Q
 ;
42(IB0,IBEOB,IBOK) ; Process record type 42 for EOB 
 ; IB0 = the record being processed
 ; IBEOB = the ien of the EOB entry in file 361.1
 ; IBOK = Returned as 1 if record filed OK, 0 if error occurred
 ;
 N DO,DD,DLAYGO,DIC,DA,X,Y,Z,Z0,CT
 S IBOK=0
 I '$G(^TMP($J,40)) D  G Q42
 . S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Service line adjustment (EEOB Record 42) has no matching service line"
 . D DET4X^IBCEOB00(42,IB0,.Z0)
 . S CT=+$O(^TMP(IBEGBL,$J,""),-1),Z=0 F  S Z=$O(Z0(Z)) Q:'Z  S CT=CT+1,^TMP(IBEGBL,$J,CT)=Z0(Z)
 ;
 K DO,DD,DLAYGO
 S IBOK=1
 S DA(1)=+^TMP($J,40),DA(2)=IBEOB
 S X=+$O(^IBM(361.1,DA(2),15,DA(1),4," "),-1)+1,DIC="^IBM(361.1,"_DA(2)_",15,"_DA(1)_",4,",DIC(0)="L",DLAYGO=361.1154
 S DIC("DR")=$S($P(IB0,U,3)'="":".02////"_$P(IB0,U,3),1:"")
 I $P(IB0,U,4)'="" S:$L(DIC("DR")) DIC("DR")=DIC("DR")_";" S DIC("DR")=DIC("DR")_".03////"_$TR($P(IB0,U,4),";"," ")
 D FILE^DICN K DO,DD,DLAYGO
 I Y'>0 S IBOK=0
 I '$G(IBOK) S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Mismatched data for service line adjustment-3 (EEOB Record 42)"
 ;
 ; For Medicare MRA's only:
 ; Process and store the line level remark code as an LQ kludge line
 ; level adjustment.
 ;
 I $P($G(^IBM(361.1,IBEOB,0)),U,4)=1,$P(IB0,U,3)'="" D
 . N IB45,IBSAV40
 . S IB45=45_U_$P(IB0,U,2)_U_"LQ"_U_$P(IB0,U,3)_U_0_U_0_U_$P(IB0,U,4)
 . S IBSAV40=$G(^TMP($J,40))
 . D 45(IB45,IBEOB,.IBOK)
 . S ^TMP($J,40)=IBSAV40
 . I '$G(IBOK) S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not file the LQ-remark code adjustment at line "_+^TMP($J,40)
 . Q
Q42 Q
 ;
45(IB0,IBEOB,IBOK) ; Process record type 45 for EOB 
 ; IB0 = the record being processed
 ; IBEOB = the ien of the EOB entry in file 361.1
 ; IBOK = Returned as 1 if record filed OK, 0 if error occurred
 ;
 N IBDA,LEVEL,A,Z0,CT,Z
 I '$G(^TMP($J,40)) D  G Q45
 . S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Service line adjustment (EEOB Record 45) has no matching service line"
 . D DET4X^IBCEOB00(45,IB0,.Z0)
 . S CT=+$O(^TMP(IBEGBL,$J,""),-1),Z=0 F  S Z=$O(Z0(Z)) Q:'Z  S CT=CT+1,^TMP(IBEGBL,$J,CT)=Z0(Z)
 ;
 I $P(IB0,U,3)'="" S $P(^TMP($J,40),U,2)=$P(IB0,U,3)
 I $P(IB0,U,3)="" S $P(IB0,U,3)=$P(^TMP($J,40),U,2)
 I $P(IB0,U,3)="" S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Service line adjustment (EEOB Record 45) is missing its group code" G Q45
 ;
 S IBDA(2)=+^TMP($J,40)
 S IBDA(1)=+$O(^IBM(361.1,IBEOB,15,IBDA(2),1,"B",$P(IB0,U,3),0))
 ;
 I 'IBDA(1) D  ;Needs a new entry at group level
 . N X,Y,DA,DD,DO,DIC,DLAYGO
 . S DIC="^IBM(361.1,"_IBEOB_",15,"_IBDA(2)_",1,",DIC(0)="L",DLAYGO=361.1151,DA(2)=IBEOB,DA(1)=IBDA(2)
 . S DIC("P")=$$GETSPEC^IBEFUNC(361.115,1)
 . S X=$P(IB0,U,3)
 . D FILE^DICN K DIC,DO,DD,DLAYGO
 . I Y<0 K IBDA S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not add adjustment group code ("_$P(IB0,U,3)_") at line adjustment "_+^TMP($J,40) Q
 . S IBDA(1)=+Y
 ;
 ;Add a new entry at the reason code level
 I $G(IBDA(1)) D
 . S DIC="^IBM(361.1,"_IBEOB_",15,"_IBDA(2)_",1,"_IBDA(1)_",1,",DIC(0)="L",DLAYGO=361.11511,DA(1)=IBDA(1),DA(2)=IBDA(2),DA(3)=IBEOB
 . S DIC("P")=$$GETSPEC^IBEFUNC(361.1151,1)
 . S X=$P(IB0,U,4)
 . D FILE^DICN K DIC,DO,DD,DLAYGO
 . I Y<0 K IBDA S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not add reason code ("_$P(IB0,U,4)_") for adjustment group code ("_$P(IB0,U,3)_") at line adjustment "_+^TMP($J,40) Q
 . S IBDA=+Y
 ;
 I $G(IBDA) D
 . S LEVEL=15,LEVEL("DIE")="^IBM(361.1,"_IBEOB_",15,"_IBDA(2)_",1,"_IBDA(1)_",1,"
 . S LEVEL(0)=IBDA,LEVEL(1)=IBDA(1),LEVEL(2)=IBDA(2),LEVEL(3)=IBEOB
 . S A="5;.02;1;0;0^6;.03;0;1;1^7;.04;0;1;0"
 . S IBOK=$$STORE^IBCEOB1(A,IB0,IBEOB,.LEVEL)
 . I 'IBOK S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Mismatched data for reason code ("_$P(IB0,U,4)_"), adjustment group code ("_$P(IB0,U,3)_") at line adjustment "_+^TMP($J,40) Q
 ;
Q45 Q
 ;
46(IB0,IBEOB,IBOK) ; Process record type 46 for EOB 
 ; IB0 = the record being processed
 ; IBEOB = the ien of the EOB entry in file 361.1
 ; IBOK = Returned as 1 if record filed OK, 0 if error occurred
 ;
 S IBOK=0
 N AGC,IBDA,LEVEL,A,Z0,CT,Z
 I '$G(^TMP($J,40)) D  G Q46
 . S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Service line adjustment (EEOB Record 46) has no matching service line"
 . D DET4X^IBCEOB00(46,IB0,.Z0)
 . ;S CT=+$O(^TMP(IBEGBL,$J,""),-1),Z=0 F  S Z=$O(Z0(Z)) Q:'Z  S CT=CT+1,^TMP(IBEGBL,$J,CT)=Z0(Z)
 ;
 S AGC=$P(^TMP($J,40),U,2)
 I AGC="" S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Service line adjustment (EEOB Record 46) is missing its group code" G Q46
 ;
 S IBDA(2)=+^TMP($J,40)
 S IBDA(1)=+$O(^IBM(361.1,IBEOB,15,IBDA(2),1,"B",AGC,0))
 ;
 ;
 ;Add a new entry at the Payer Policy level
 I $G(IBDA(1)) D
 . S DIC="^IBM(361.1,"_IBEOB_",15,"_IBDA(2)_",1,"_IBDA(1)_",2,",DIC(0)="L",DLAYGO=361.11511,DA(1)=IBDA(1),DA(2)=IBDA(2),DA(3)=IBEOB
 . S DIC("P")=$$GETSPEC^IBEFUNC(361.1151,1)
 . S X=$P(IB0,U,3)
 . D FILE^DICN K DIC,DO,DD,DLAYGO
 . I Y<0 K IBDA S ^TMP(IBEGBL,$J,+$O(^TMP(IBEGBL,$J,""),-1)+1)="Could not add payer policy ("_$P(IB0,U,4)_") for adjustment group code ("_$P(IB0,U,3)_") at line adjustment "_+^TMP($J,40) Q
 . S IBDA=+Y,IBOK=1
 ;
Q46 Q
 ;
 ; IB*2.0*633 - Begin modified code block
ERRTXT(X,IBEOB) ; Set error text based on circumstances
 ; Input - X = Standard Error message passed in
 ;         IB0 
 ; Returns modified error message text
 N RETURN
 S RETURN="Mismatched "_X_":"
 I '$$EBILL(IBEOB) S RETURN="Claim was not Billed Electronically:"
 Q RETURN
 ;
EBILL(IBEOB) ; Check If EOB was billed electronically
 ; Input : IBEOB = Internal entry number from file 361.1
 ; Returns : 1 - Billed electronically
 ;           0 - Not billed electronically
 N IEN399,IEN364,STATUS
 S IEN399=$$GET1^DIQ(361.1,IBEOB_",",.01,"I")
 S IEN364=$O(^IBA(364,"B",+IEN399,0))
 I 'IEN364 Q 0 ; No EDI TRANSMIT BILL
 ;
 S STATUS=$$GET1^DIQ(364,IEN364,.03,"I")
 I STATUS="E"!(STATUS="C") Q 0 ; Error or canceled
 Q 1
 ; IB*2.0*633 - End modified code block
