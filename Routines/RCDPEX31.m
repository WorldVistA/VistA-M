RCDPEX31 ;ALB/TMK - ELECTRONIC EOB EXCEPTION PROCESSING - FILE 344.4 ;10-OCT-02
 ;;4.5;Accounts Receivable;**173,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
UPD ; Try to update the IB EOB file from exception in 344.41
 N RCDA,RCTDA,RCTDA1,RCWHY,Z,DA,DIE,DR
 D FULL^VALM1
 D SEL^RCDPEX3(.RCDA,1)
 S RCDA=$O(RCDA(0)) G:'RCDA UPDQ
 S RCTDA=+RCDA(RCDA),RCTDA1=+$P(RCDA(RCDA),U,2)
 I '$$LOCK(RCTDA,RCTDA1,0) G UPDQ
 I $P($G(^RCY(344.4,RCTDA,1,RCTDA1,0)),U,7)'=2 D  G UPDQ
 . W !,"EEOB cannot be filed in IB"_$S($P($G(^RCY(344.4,RCTDA,1,RCTDA1,0)),U,7)=1:" - the bill # is invalid",1:"")
 . D PAUSE^VALM1
 I RCTDA,RCTDA1 D UPDEOB^RCDPESR2(RCTDA_";"_RCTDA1,4)
 S Z=$P($G(^RCY(344.4,RCTDA,1,RCTDA1,0)),U,2)
 I Z D  ; Update file 344.41 record
 . S DA(1)=RCTDA,DA=RCTDA1,DR=".07///@;.13////1;.02////"_Z,DIE="^RCY(344.4,"_DA(1)_",1," D ^DIE
 W !,"EEOB DETAIL UPDATE ",$S(Z:"WAS SUCCESSFUL",1:"ENCOUNTERED ERRORS")
 S RCWHY(1)="Update IB with EEOB detail",RCWHY(2)="Update EEOB detail was "_$S('Z:"NOT",1:"")_" successful"
 D STORACT(RCTDA,RCTDA1,.RCWHY)
 D PAUSE^VALM1
 D BLD^RCDPEX2
 ;
UPDQ S VALMBCK="R"
 Q
 ;
DEL ; Delete exception conditions from EOB detail list - file 344.4
 N DIR,X,Y,Z,RCDA,RCOK,RCTDA,RCTDA1,RCWHY,DA,DR,DIE,RC0,RC00,RCDIQ,RCE,RCT,RCX,RCWHYTXT,XMDUZ,XMSUBJ,XMZ,XMER,XMBODY,XMTO,RCDIQ1,DTOUT,DUOUT
 D FULL^VALM1
 D SEL^RCDPEX3(.RCDA,1)
 S RCDA=$O(RCDA(""))
 I RCDA="" G DELQ
 S RCTDA=+RCDA(RCDA),RCTDA1=$P(RCDA(RCDA),U,2)
 I '$$LOCK(RCTDA,RCTDA1,0) G DELQ
 W !
 S DIR(0)="YA",DIR("A",1)="This action will mark this EEOB detail record so it no longer appears as an",DIR("A",2)="exception.  A bulletin will be sent to report this action",DIR("A",3)=" "
 S DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE? ",DIR("B")="NO"
 D ^DIR K DIR
 G:Y'=1 DELQ
 S DIR(0)="FA;3:60",DIR("A")="ENTER A REASON FOR THIS ACTION: ",DIR("?",1)="Enter the reason why this EEOB exception is being removed from the",DIR("?")=" exception list (3-60 characters are REQUIRED)"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G DELQ
 S RCWHY(1)="Removal of EEOB detail entry from the exception list",RCWHY(2)="  Reason Entered: "_Y,RCWHYTXT=Y
 S RC0=$G(^RCY(344.4,RCTDA,0)),RC00=$G(^(1,RCTDA1,0))
 ;
 D GETS^DIQ(344.4,RCTDA_",","*","IEN","RCDIQ")
 D GETS^DIQ(344.41,RCTDA1_","_RCTDA_",","*","IEN","RCDIQ1")
 S RCE=0
 D TXT0(RCTDA,.RCDIQ,.RCX,.RCE)
 S RCE=RCE+1,RCX(RCE)="RAW MESSAGE DATA:"
 D TXT00(RCTDA,RCTDA1,.RCDIQ1,.RCX,.RCE)
 S DA=RCTDA1,DA(1)=RCTDA,DR=".07///@;.13////0",DIE="^RCY(344.4,"_DA(1)_",1," D ^DIE
 D STORACT(RCTDA,RCTDA1,.RCWHY)
 ;
 S RCT(1)="The electronic EEOB detail for Trace #: "_$P(RC0,U,2)_" and Seq #"_$P(RC00,U),RCT(2)=" is no longer flagged for an exception condition"
 S RCT(3)="PAYMENT FROM: "_$P(RC0,U,6)_" on "_$$FMTE^XLFDT($P(RC0,U,4),2)
 S RCT(4)=" "
 S RCT(5)="REASON: "_RCWHYTXT
 S RCT(6)="ACTION PERFORMED BY: "_$P($G(^VA(200,+$G(DUZ),0)),U)_"   "_$$FMTE^XLFDT($$NOW^XLFDT,2)
 S RCT(7)=" ",RCE=+$O(RCT(""),-1)
 S Z=0 F  S Z=$O(RCX(Z)) Q:'Z  S RCE=RCE+1,RCT(RCE)=RCX(Z)
 S RCE=RCE+1,RCT(RCE)=" "
 S XMSUBJ="EDI LBOX EEOB DETAIL EXCEPTION REMOVED",XMBODY="RCT",XMDUZ="",XMTO("G.RCDPE PAYMENTS")=""
 D  ;
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 ;
 W !,"A bulletin has been sent to report this action",!
 D PAUSE^VALM1
 D BLD^RCDPEX2
 ;
DELQ I $G(RCTDA),$G(RCTDA1) L -^RCY(344.4,RCTDA,1,RCTDA1,0)
 S VALMBCK="R"
 Q
 ;
TXT0(RCTDA,RCDIQ,RCXM1,RC) ; Append 0-node captioned data to array RCXM1
 ;
 N LINE,DAT,Z,Z0,Z1
 S LINE="",RC=+$G(RC)
 S RC=RC+1,RCXM1(RC)="  **ERA SUMMARY DATA**"
 F Z=.02:.01 D  S Z1=+$O(RCDIQ(344.4,RCTDA_",",Z)) Q:Z1'<1!'Z1
 . I $G(RCDIQ(344.4,RCTDA_",",Z,"E"))="" Q
 . S Z0=$$GET1^DID(344.4,Z,,"LABEL")
 . S DAT=Z0_": "_$G(RCDIQ(344.4,RCTDA_",",Z,"E"))
 . I $L(DAT)>39 S:$L(LINE) RC=RC+1,RCXM1(RC)=LINE S RC=RC+1,RCXM1(RC)=DAT,LINE="" Q
 . I $L(LINE) D  Q:LINE=""  ; Left side exists
 .. I $L(LINE)+$L(DAT)>75 S RC=RC+1,RCXM1(RC)=LINE,LINE=DAT Q
 .. S LINE=LINE_"  "_DAT,RC=RC+1,RCXM1(RC)=LINE,LINE=""
 . S LINE=$E(DAT_$J("",39),1,39)
 I $L(LINE) S RC=RC+1,RCXM1(RC)=LINE
 S:RC RC=RC+1,RCXM1(RC)=" "
 Q
 ;
TXT00(RCTDA,RCTDA1,RCDIQ1,RCXM1,RC) ; Extract 0-node data for file 344.41
 ;
 N RCT,LINE,DAT,Z,Z0,Z1
 S LINE="",RC=+$G(RC)
 S RC=RC+1,RCXM1(RC)="  **EEOB DETAIL DATA**",RCT=RCTDA1_","_RCTDA_","
 F Z=.01:.01 D  S Z1=+$O(RCDIQ1(344.41,RCT,Z)) Q:Z1'<1!'Z1
 . I $G(RCDIQ1(344.41,RCT,Z,"E"))="" Q
 . S Z0=$$GET1^DID(344.41,Z,,"LABEL")
 . S DAT=Z0_": "_$G(RCDIQ1(344.41,RCT,Z,"E"))
 . I $L(DAT)>39 S:$L(LINE) RC=RC+1,RCXM1(RC)=LINE S RC=RC+1,RCXM1(RC)=DAT,LINE="" Q
 . I $L(LINE) D  Q:LINE=""  ; Left side exists
 .. I $L(LINE)+$L(DAT)>75 S RC=RC+1,RCXM1(RC)=LINE,LINE=DAT Q
 .. S LINE=LINE_"  "_DAT,RC=RC+1,RCXM1(RC)=LINE,LINE=""
 . S LINE=$E(DAT_$J("",39),1,39)
 I $L(LINE) S RC=RC+1,RCXM1(RC)=LINE
 S:RC RC=RC+1,RCXM1(RC)=" "
 Q
 ;
TXT2(RCTDA,RCTDA1,RCDIQ2,RCXM1,RC) ; Extract all data for file 344.42
 ;
 N RCT,LINE,DAT,Z,Z0
 S LINE="",RC=+$G(RC)
 S RCT=RCTDA1_","_RCTDA_","
 S Z=0 F  S Z=$O(RCDIQ2(344.42,RCT,Z)) Q:'Z  D
 . I $G(RCDIQ2(344.42,RCT,Z,"E"))="" Q
 . S Z0=$$GET1^DID(344.42,Z,,"LABEL")
 . S DAT=Z0_": "_$G(RCDIQ2(344.42,RCT,Z,"E"))
 . I $L(DAT)>39 S:$L(LINE) RC=RC+1,RCXM1(RC)=LINE S RC=RC+1,RCXM1(RC)=DAT,LINE="" Q
 . I $L(LINE) D  Q:LINE=""  ; Left side exists
 .. I $L(LINE)+$L(DAT)>75 S RC=RC+1,RCXM1(RC)=LINE,LINE=DAT Q
 .. S LINE=LINE_"  "_DAT,RC=RC+1,RCXM1(RC)=LINE,LINE=""
 . S LINE=$E(DAT_$J("",39),1,39)
 I $L(LINE) S RC=RC+1,RCXM1(RC)=LINE
 S:RC RC=RC+1,RCXM1(RC)=" "
 Q
 ;
LOCK(RCTDA,RCTDA1,RCSHH) ; Attempt to lock file entry in file 344.41
 ; Return 1 if successful, 0 if not able to lock
 ; RCSHH = 1 if there should be no direct writes
 ;
 N OK
 S OK=1
 L +^RCY(344.4,RCTDA,1,RCTDA1,0):5
 I '$T D
 . I '$D(DIQUIET),'$G(RCSHH) W !,*7,"Another user is editing this entry ... please try again later" D PAUSE^VALM1
 . S OK=0
 Q OK
 ;
STORACT(RCTDA,RCTDA1,RCWHY) ; Store the detail for the action taken for
 ; the exception record at ^RCY(344.4,RCTDA,1,RCTDA,0)
 ; RCWHY(#) = lines containing the reason/explanation for the action
 ;   RCWHY(1) should contain the description of the action taken
 ;            It will be appended to the first line of the message after
 ;            the date and user who made the change.
 ;
 N RCDA,RCTXT,RC,Z
 S RCDA(1)=RCTDA,RCDA=RCTDA1
 S RCTXT(1)=$$FMTE^XLFDT($$NOW^XLFDT(),2)_" "_$P($G(^VA(200,+DUZ,0)),U)_" "_$G(RCWHY(1))
 S (RC,Z)=1
 F  S Z=$O(RCWHY(Z)) Q:'Z  S RC=RC+1,RCTXT(RC)=" "_RCWHY(Z)
 D WP^DIE(344.41,$$IENS^DILF(.RCDA),2,"A","RCTXT")
 Q
 ;
