RCDPEWL5 ;ALB/TMK - ELECTRONIC EOB WORKLIST ACTIONS ;24-FEB-03
 ;;4.5;Accounts Receivable;**173,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
INIT ; Build receipt preview
 N X,Z,Z1,Z10,Z0,Z2,RCZ
 K ^TMP("RCDPE_EOB_PREVIEW",$J)
 S VALMCNT=0,VALMBG=1
 S Z=0 F  S Z=$O(^RCY(344.49,RCSCR,1,Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 . I $P(Z0,U)\1=+Z0 S Z2=$P(Z0,U,2)
 . I $P($P(Z0,U),".",2) D
 .. S:$P(Z0,U,2)="" $P(Z0,U,2)=Z2
 .. S RCZ=$S(+$P(Z0,U,6)=0:0,+$P(Z0,U,6)<0:-1,$P(Z0,U,7):1,1:2)
 .. S RCZ(RCZ,Z)=Z0
 .. S Z1=0 F  S Z1=$O(^RCY(344.49,RCSCR,1,Z,1,Z1)) Q:'Z1  S Z10=$G(^(Z1,0)) D
 ... I $P(Z10,U,5)=1 S RCZ(RCZ,Z,"ADJ",Z1)="Dec adj $"_$J(0-$P(Z10,U,3),"",2)_" pending - ",RCZ(RCZ,Z,"ADJ",Z1,1)=$J("",4)_$P(Z10,U,9)
 F RCZ=1,2,0,-1 D
 . Q:'$D(RCZ(RCZ))
 . I RCZ=1 D SET("PAYMENTS (LINES FOR RECEIPT):")
 . I RCZ=0,VALMCNT>0 D SET(" ") D SET("ZERO DOLLAR PAYMENTS:")
 . I RCZ=-1,VALMCNT>0 D SET(" ") D SET("LINES WITH NEGATIVE BALANCES STILL NEEDING TO BE DISTRIBUTED:")
 . S Z=0 F  S Z=$O(RCZ(RCZ,Z)) Q:'Z  S Z0=RCZ(RCZ,Z) D
 .. S X=""
 .. S X=$$SETFLD^VALM1($P(Z0,U),X,"LINE #")
 .. S X=$$SETFLD^VALM1($S($P(Z0,U,7):$$BN1^PRCAFN($P(Z0,U,7)),1:$S(RCZ=0:"",1:"[SUSPENSE]")_$S($P(Z0,U,2)["**ADJ"&'$P($P(Z0,U,2),"ADJ",2):"TOTALS MISMATCH ADJ",1:$P(Z0,U,2))),X,"ACCOUNT")
 .. S X=$$SETFLD^VALM1($J(+$P(Z0,U,6),"",2),X,"AMOUNT")
 .. D SET(X)
 .. S Z1=0 F  S Z1=$O(RCZ(RCZ,Z,"ADJ",Z1)) Q:'Z1  D SET($J("",12)_$G(RCZ(RCZ,Z,"ADJ",Z1))) S Z2=0 F  S Z2=$O(RCZ(RCZ,Z,"ADJ",Z1,Z2)) Q:'Z2  D SET($J("",12)_$G(RCZ(RCZ,Z,"ADJ",Z1,Z2)))
 Q
 ;
SET(X) ;
 S VALMCNT=VALMCNT+1
 S ^TMP("RCDPE_EOB_PREVIEW",$J,VALMCNT,0)=X
 Q
 ;
HDR ;
 D HDR^RCDPEWL
 Q
 ;
FNL ;
 K ^TMP("RCDPE_EOB_PREVIEW",$J)
 Q
 ;
RCOMM ; Allow entry of receipt comment to be moved to line on receipt
 N RCEDIT
 D FULL^VALM1
 ;
 I $G(RCSCR("NOEDIT"))=2 D NOTAV^RCDPEWL2 G RCOMMQ
 ;
 D SEL^RCDPEWL2(.RCEDIT)
 G:'RCEDIT RCOMMQ
 ;
RCOMMQ S VALMBCK="R"
 Q
 ;
SUSPERA ; Option entrypoint to select an ERA to be posted to suspense
 N DIC,X,Y,RCERA,RCSCR,DTOUT,DUOUT,DIR
 S DIC(0)="AEMQ",DIC="^RCY(344.4,",DIC("S")="I '$P(^(0),U,8),'$G(^(20))"
 D ^DIC K DIC
 I Y'>0 Q
 S RCERA=+Y
 S DIR(0)="YA",DIR("B")="YES",DIR("A")="DO YOU WANT TO PRINT/VIEW THE ERA FIRST?: " W ! D ^DIR K DIR
 Q:$D(DUOUT)!$D(DTOUT)
 I Y=1 S RCSCR=RCERA D PRERA^RCDPEWL0
 D SUSP(RCERA,0)
 Q
 ;
SUSP(RCERA,LM) ; Function to send receipt to suspense for ERA
 ; RCERA = ien of entry in file 344.4
 ; LM = flag to indicate it was called from list manager protocol
 ;    =  1 if true, 0 if false
 N DIR,X,Y,RC0,RCCOM,RCER,RCPAYTY,RECTDA,RCTRANDA,DIE,DA,DR,Z,DTOUT,DUOUT
 S RC0=$G(^RCY(344.4,RCERA,0))
 I $G(LM) D FULL^VALM1
 I $$HACERA^RCDPEU(RCERA) D  G SUSPQ
 . S DIR(0)="EA",DIR("A")="THIS IS NOT A VALID ACTION FOR AN ERA FROM HAC" W ! D ^DIR K DIR
 S DIR(0)="YA",DIR("B")="NO"
 I $P(RC0,U,5) D
 . S DIR("A",1)="THIS WILL CREATE A RECEIPT THAT WILL MOVE THE FUNDS ($"_$J($P(RC0,U,5),"",2)_")",DIR("A",2)="FOR THIS ENTIRE ERA TO YOUR SUSPENSE ACCOUNT",Z=3
 E  D
 . S DIR("A",1)="THIS WILL CREATE AND POST A RECEIPT FOR $0.00 FOR THIS ERA",Z=2
 S DIR("A",Z+1)=" ",DIR("A",Z+2)="***ALL POSTINGS TO A/R FOR ANY CLAIMS IN THIS ERA MUST BE DONE MANUALLY***",DIR("A",Z+3)=" "
 S DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE?: "
 W ! D ^DIR K DIR
 I Y'=1 D NOACT G SUSPQ
 S DIR("A",1)="ENTER A 1-60 CHARACTER COMMENT TO BE PLACED ON THE RECEIPT: ",DIR("A")=">: ",DIR(0)="FA^1:60",DIR("B")="REF ERA #:"_RCERA_"  FROM "_$E($P(RC0,U,6),1,20) W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) D NOACT G SUSPQ
 S RCCOM=Y
 S RCPAYTY=$S($P(RC0,U,13)="":14,1:4)
 S RECTDA=$$BLDRCPT^RCDPUREC(DT,"",+$O(^RC(341.1,"AC",+RCPAYTY,0)))
 I 'RECTDA D  G SUSPQ
 . S DIR(0)="EA",DIR("A",1)="A PROBLEM WAS ENCOUNTERED ADDING THE RECEIPT",DIR("A")="NO ACTION TAKEN - RETURN TO CONTINUE: " W ! D ^DIR K DIR
 ;
 S RCTRANDA=$$ADDTRAN^RCDPURET(RECTDA)
 S DR=".04////"_(+$P(RC0,U,5))_$S($P(RC0,U,13)'="":";.13////"_$P(RC0,U,13),1:"")_$S(RCCOM'="":";1.02////"_RCCOM,1:"")
 S DA(1)=RECTDA,DA=RCTRANDA,DIE="^RCY(344,"_DA(1)_",1,"
 D ^DIE
 ;
 I $D(^RCY(344.49,RCERA,0)) S DIE="^RCY(344.49,",DA=RCERA,DR=".02////"_RECTDA D ^DIE
 S DIE="^RCY(344.4,",DA=RCERA,DR=".08////"_RECTDA_";20.01///^S X=""NOW"";20.02////"_DUZ D ^DIE
 S Z=+$O(^RCY(344.31,"AERA",RCERA,0))
 S DIE="^RCY(344,",DA=RECTDA,DR=".18////"_RCERA_$S(Z:";.17////"_Z,1:"") D ^DIE
 ;
 D PROCESS^RCDPURE1(RECTDA,1)
 I '$P(RC0,U,5) S DIE="^RCY(344.4,",DA=RCERA,DR=".09////3;.14////1" D ^DIE
 S DIR(0)="E" W ! D ^DIR K DIR
 ;
SUSPQ I $G(LM) S VALMBCK="R"
 Q
 ;
REVIEW ; Enter review information on worklist and turn review display on/off
 ; Assumes RCSCR = ien of the entry in file 344.49
 ;
 N Z,RC,RCDA,RCZ,DIC,DA,DIE,DR,X,Y,DIR,REVCHG,RCUSPREF,RCLSTREV,RCREV
 D FULL^VALM1
 ;
 S REVCHG=""
 S DIR(0)="YA",RC=+$P($G(^TMP($J,"RC_SORTPARM")),U,2)
 S DIR("A",1)="REVIEW DATA DISPLAY IS CURRENTLY TURNED "_$P("OFF^ON",U,RC+1),DIR("A")="DO YOU WANT TO TURN IT "_$P("ON^OFF",U,RC+1)_"?: ",DIR("B")=$S('RC:"YES",1:"NO") W ! D ^DIR K DIR
 I Y=1 S $P(^TMP($J,"RC_SORTPARM"),U,2)=((RC+1)#2),REVCHG=1
 S RCUSPREF=+$O(^RCY(344.49,RCSCR,2,"B",DUZ,0))
 ;
 I 'RCUSPREF D  ; Add the user pref record
 . S RCUSPREF=+$$ADDUSER(RCSCR,DUZ)
 S RCLSTREV=+$P($G(^RCY(344.49,RCSCR,2,RCUSPREF,0)),U,2)
 S DA(1)=RCSCR,DA=RCUSPREF
 I DA,RCLSTREV'=$P($G(^TMP($J,"RC_SORTPARM")),U,2) D  ; Update user pref
 . S DIE="^RCY(344.49,"_DA(1)_",2,",DR=".02////"_+$P($G(^TMP($J,"RC_SORTPARM")),U,2) D ^DIE
 W !
 I '$P(^TMP($J,"RC_SORTPARM"),U,2) G REVIEWQ
 ;
 D SEL^RCDPEWL(.RCDA)
 S RCZ=+$O(RCDA(0)),RCZ=+$G(RCDA(RCZ)) G:'RCZ REVIEWQ
 ;
 S RCREV=0
 I '$O(^RCY(344.49,RCSCR,1,"AC",DUZ,RCZ,0)) D
 . S RCREV=$$NEWREV(RCSCR,RCZ,DUZ)
 E  D
 . N DIR,X,Y
 . S DIR("A")="(A)DD or (E)DIT A REVIEW COMMENT?: ",DIR("B")="ADD",DIR(0)="SA^A:ADD;E:EDIT" W ! D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) Q
 . ;
 . I Y="E" D  Q  ; Edit a review entry entered by same user
 .. N DA,DR,DIE,X,Y
 .. S DA(1)=RCSCR,DA=RCZ,DIC="^RCY(344.49,"_DA(1)_",1,"_DA_",4,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,2)=DUZ" D ^DIC
 .. S RCREV=$S(Y>0:+Y,1:0)
 .. I RCREV S DA(2)=RCSCR,DA(1)=RCZ,DA=RCREV,DIE="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",4,",DR=".03;.04////^S X=$$NOW^XLFDT()" D ^DIE
 . ;
 . S RCREV=$$NEWREV(RCSCR,RCZ,DUZ)
 ;
 I RCREV S DIE("NO^")="",DA(1)=RCSCR,DA=RCZ,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".11R;I X=0 S Y=""@10"";.12////^S X=DUZ;S Y=""@20"";@10;.12///@;@20" D ^DIE K DIE
 D BLD^RCDPEWL1($G(^TMP($J,"RC_SORTPARM")))
 S REVCHG=""
 ;
REVIEWQ I $G(REVCHG) D BLD^RCDPEWL1($G(^TMP($J,"RC_SORTPARM")))
 S VALMBCK="R"
 Q
 ;
NEWREV(RCSCR,RCZ,RCDUZ) ; Enter a new review comment
 ; RCSCR = ien of entry in file 344.49
 ; RCZ = ien of the EEOB (seq #)
 ; RCDUZ =DUZ of user entering the comment
 ; Function returns 0 if no new comment, ien of comment if added
 N DA,X,Y,DIC,DIK,DLAYGO,DO,DD,RCREV,RCNOW
 S RCNOW=$$NOW^XLFDT() W !!,"REVIEW DATE/TIME: "_$$FMTE^XLFDT(RCNOW,"2")
 S DA(2)=RCSCR,DA(1)=RCZ,X=RCNOW,DIC("DR")=".02////"_RCDUZ_";.03",DLAYGO=344.492,DIC(0)="L"
 S DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",4,"
 K DO,DD
 D FILE^DICN K DO,DD,DIC,DLAYGO
 S RCREV=+Y
 I RCREV'>0 S RCREV=0 G NEWREVQ
 I '$O(^RCY(344.49,DA(2),1,DA(1),4,RCREV,0)) S DIK="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",4,",DA=RCREV D ^DIK S RCREV=0 ; No comment - delete entry
 ;
NEWREVQ Q RCREV
 ;
NOACT ;
 N DIR,X,Y
 S DIR(0)="EA",DIR("A")="NO ACTION TAKEN - RETURN TO CONTINUE: " W ! D ^DIR K DIR
 Q
 ;
ADDUSER(RCSCR,RCDUZ) ; Add user record to user preferences multiple in file 344.49 and initialize all preferences
 ; RCSCR = ien of entry in file 344.49
 ; RCDUZ  = the ien of the user
 N DIC,DA,X,Y,DLAYGO,DO,DD
 S Y=+$O(^RCY(344.49,RCSCR,2,"B",RCDUZ,0))
 I Y G ADDUQ
 S DLAYGO=344.492,DA(1)=RCSCR,DIC(0)="L",X=RCDUZ,DIC="^RCY(344.49,"_DA(1)_",2,",DIC("DR")=".02////0;.03////N"
 D FILE^DICN K DIC,DLAYGO
ADDUQ Q $S(Y>0:Y,1:0)
 ;
