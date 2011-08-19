RCDPEX ;ALB/TMK - ELECTRONIC EOB EXCEPTION PROCESSING - FILE 344.5 ;10-OCT-02
 ;;4.5;Accounts Receivable;**173,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
UPD ; Update (File) ERA msgs manually from EOB exception list for file 344.5
 N RCDA,RCOK,RCTDA,ZTSK,RCTSK,RCTYP,RCU,RC0
 D FULL^VALM1
 D SEL(.RCDA,1)
 S RCDA=$O(RCDA(""))
 I RCDA="" G UPDQ
 S RCTDA=+RCDA(RCDA)
 I '$$LOCK(RCTDA) G UPDQ
 S RC0=$G(^RCY(344.5,RCTDA,0))
 ;
 I RC0="" D  G UPDQ
 . W !,*7,"ERA #",RCDA," is no longer in exception file" S RCOK=""
 . D PAUSE^VALM1
 I $P(RC0,U,5) S RCOK=1 D  G:'RCOK UPDQ
 . N ZTSK
 . S ZTSK=$P(RC0,U,5) D STAT^%ZTLOAD Q:ZTSK(0)=0  ;Task not scheduled
 . I "12"[ZTSK(1) W *7,!,"This record has already been scheduled for update.  Task # is: ",$P(RC0,U,5) S RCOK="" D PAUSE^VALM1
 ;
 S RCTYP=$P(RC0,U,2)
 S RCU=$S(RCTYP="835ERA":"NEWERA^RCDPESR2("_RCTDA_",1)",RCTYP="835XFR":"FILEEOB^RCDPESR5("_RCTDA_")",1:"")
 I RCU="" W !,*7,"This message has an invalid 'type' - can't update" D PAUSE^VALM1 G UPDQ
 S RCTSK=$$TASK(RCU,RCTDA)
 I RCTSK W !,"File update has been tasked (#",RCTSK,")"
 I 'RCTSK W !,*7,"File update could not be tasked.  Please try again later!!!"
 D PAUSE^VALM1
 ;
 D BLD^RCDPEX1
UPDQ I $G(RCTDA) L -^RCY(344.5,RCTDA,0)
 S VALMBCK="R"
 Q
 ;
VP ; View/Print ERA Messages - File 344.5
 N DHD,DIC,FLDS,BY,FR,TO,DIR,Y,L,RCDA,RCTDA,RCRAW,POP
 D FULL^VALM1,SEL(.RCDA,1)
 S RCDA=$O(RCDA(""))
 G:'RCDA VPQ
 S RCTDA=$G(RCDA(RCDA))
 S DIR(0)="YA",DIR("A")="DO YOU WANT TO INCLUDE DATA THE WAY IT WAS RECEIVED (RAW DATA)?: ",DIR("B")="N" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G VPQ
 S RCRAW=+Y
 ; Ask device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 S %ZIS="QM" D ^%ZIS G:POP VPQ
 I $D(IO("Q")) D  G VPQ
 . S ZTRTN="VPOUT^RCDPEX",ZTDESC="AR - Print EEOB Exception Message"
 . S ZTSAVE("RCTDA")="",ZTSAVE("RCRAW")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
VPOUT ; Entrypoint for queued job
 N Z,Z0,RCSTOP,RCPG,RCXM,RCXM1,RC,RCZ,RCTDAC
 K ^TMP($J,"RCRAW"),^TMP($J,"RCOUT")
 S RCTDAC=RCTDA_","
 ;
 D GETS^DIQ(344.5,RCTDAC,"*","IEN","RCZ")
 D TXTDE(RCTDA,.RCZ,1,.RCXM,.RC)
 ;
 I $O(^RCY(344.5,RCTDA,"EX",0)) D
 . S RC=RC+1,RCXM(RC)="**EXCEPTION MESSAGES**"
 . D TXTDE(RCTDA,.RCZ,5,.RCXM,.RC)
 ;
 K ^TMP("RCSAVE",$J)
 M ^TMP("RCSAVE",$J)=^RCY(344.5,RCTDA,2)
 S Z=0 F  S Z=$O(^TMP("RCSAVE",$J,Z)) Q:'Z  I $P($G(^(Z,0)),U)["835" K ^(0) Q  ; Get rid of header node
 D DISP^RCDPESR0("^TMP(""RCSAVE"",$J)","^TMP($J,""RCRAW"")",1,"^TMP($J,""RCOUT"")",75) ; Get formatted 'raw' data
 K ^TMP("RCSAVE",$J)
 I $G(RCRAW) D
 . S RC=$O(^TMP($J,"RCOUT",""),-1)+1,^TMP($J,"RCOUT",RC)=" "
 . S RC=RC+1,^TMP($J,"RCOUT",RC)="**RAW DATA**"
 . S Z=0 F  S Z=$O(^RCY(344.5,RCTDA,2,Z)) Q:'Z  D
 .. F Z0=1:80:$L($G(^RCY(344.5,RCTDA,2,Z,0))) S RC=RC+1,^TMP($J,"RCOUT",RC)=$E($G(^RCY(344.5,RCTDA,2,Z,0)),Z0,Z0+79)
 ;
 S (RCPG,RCSTOP,Z)=0
 F  S Z=$O(RCXM(Z)) Q:'Z  S ^TMP($J,"RCOUT",Z-999)=RCXM(Z)
 S Z=""
 F  S Z=$O(^TMP($J,"RCOUT",Z)) Q:'Z  D  Q:RCSTOP
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W !,"***TASK STOPPED BY USER***" Q
 . I 'RCPG!(($Y+5)>IOSL) D  I RCSTOP Q
 .. D:RCPG ASK(.RCSTOP) I RCSTOP Q
 .. D HDR(RCTDA,.RCPG)
 . W !,$G(^TMP($J,"RCOUT",Z))
 I 'RCSTOP,RCPG D ASK(.RCSTOP)
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 ;
VPQ K ^TMP($J,"RCRAW"),^TMP($J,"RCOUT")
 S VALMBCK="R"
 Q
 ;
SEL(RCDA,ONE) ; Select entry(s) from list
 ; RCDA = array returned if selections made
 ;    RCDA(n)=ien of bill selected in file 344.5
 ; ONE = if set to 1, only one selection can be made at a time
 N RC
 K RCDA
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S RCDA=0 F  S RCDA=$O(VALMY(RCDA)) Q:'RCDA  S RC=$G(^TMP("RCDPEX-EOBDX",$J,RCDA)),RCDA(RCDA)=+$P(RC,U,2)
 Q
 ;
 ;
DEL ; Delete messages from messages list - file 344.5
 N RCDA,RCOK,RCTDA,RCTDAC,RCTYP,RCU,RC0,DIR,RCT,RCE,RCDIQ,RCX,Z,X,Y,XMSUBJ,XMTO,XMBODY,XMDUZ,XMZ
 D FULL^VALM1
 S RCTDA=0
 D SEL(.RCDA,1)
 S RCDA=$O(RCDA(""))
 I RCDA="" G DELQ
 W !
 S DIR(0)="YA",DIR("A",1)="This action will PERMANENTLY delete an EDI Lockbox message from your system",DIR("A",2)="A bulletin will be sent to report the deletion",DIR("A",3)=" "
 S DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE? ",DIR("B")="NO"
 D ^DIR K DIR
 G:Y'=1 DELQ
 S RCTDA=+RCDA(RCDA),RCTDAC=RCTDA_","
 I '$$LOCK(RCTDA) G DELQ
 S RC0=$G(^RCY(344.5,RCTDA,0))
 ;
 I $P(RC0,U,5) S RCOK=1 D  G:'RCOK DELQ
 . N ZTSK
 . S ZTSK=$P(RC0,U,5) D STAT^%ZTLOAD Q:ZTSK(0)=0  ;Task not scheduled
 . I "12"[ZTSK(1) W *7,!,"This message is currently scheduled for update.  Task # is: ",$P(RC0,U,11) S RCOK="" D PAUSE^VALM1
 ;
 S DIR(0)="YA",DIR("A",1)=" ",DIR("A",2)="",$P(DIR("A",2),"*",54)="",DIR("A",3)="* This EDI Lockbox message is about to be PERMANENTLY deleted!! *",DIR("A",4)=DIR("A",2),DIR("A",5)=" "
 S DIR("A")="ARE YOU STILL SURE YOU WANT TO CONTINUE? ",DIR("B")="NO"
 W ! D ^DIR W ! K DIR
 I Y'=1 W !!,"Nothing deleted" D PAUSE^VALM1 G DELQ
 ;
 D GETS^DIQ(344.5,RCTDAC,"*","IEN","RCDIQ")
 S RCE=0
 D TXTDE(RCTDA,.RCDIQ,1,.RCX,.RCE)
 S RCE=RCE+1,RCX(RCE)="RAW MESSAGE DATA:"
 D TXTDE(RCTDA,.RCDIQ,2,.RCX,.RCE)
 D DELMSG(RCTDA)
 I $D(^RCY(344.5,RCTDA)) D  G DELQ
 . W !,"Message not deleted - problem with delete" D PAUSE^VALM1
 ;
 I $P(RC0,U,2)["XFR",'$P(RC0,U,14) D
 . S DIR(0)="YA"
 . S DIR("A")="ARE YOU DELETING THIS BECAUSE THE EEOB DOES NOT BELONG TO YOUR SITE?: ",DIR("B")="YES",DIR("?")="IF YOU RESPOND YES TO THIS QUESTION, A REJECT MESSAGE WILL BE SENT BACK TO",DIR("?",1)=" THE SENDING SITE FOR THIS EEOB"
 .  W ! D ^DIR K DIR
 . Q:Y'=1
 . D SENDACK^RCDPESR5(RCTDA,0) ; Send reject notice
 S RCT(1)="Electronic EDI Lockbox message "_$P(RC0,U)_" has been deleted"
 S RCT(2)=" "
 S RCT(3)="DELETED BY: "_$P($G(^VA(200,+$G(DUZ),0)),U)_"   "_$$FMTE^XLFDT($$NOW^XLFDT,2)
 S RCT(4)=" ",RCE=+$O(RCT(""),-1)
 S Z=0 F  S Z=$O(RCX(Z)) Q:'Z  S RCE=RCE+1,RCT(RCE)=RCX(Z)
 S RCE=RCE+1,RCT(RCE)=" "
 S XMSUBJ="EDI LBOX MESSAGE DELETED",XMBODY="RCT",XMDUZ="",XMTO("G.RCDPE PAYMENTS")=""
 D SENDMSG^XMXAPI(.5,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 ;
 W !,"A bulletin has been sent to report this deletion",!
 D PAUSE^VALM1
 ;
 D BLD^RCDPEX1
DELQ L -^RCY(344.5,RCTDA,0)
 S VALMBCK="R"
 Q
 ;
DELMSG(RCTDA) ; Delete message from temporary message holding file 344.5
 ;
 N DIK,DA,Y S DIK="^RCY(344.5,",DA=RCTDA D ^DIK
 Q
 ;
TASK(RCRTN,RCTDA) ; Schedule the task to update data base from message
 ; RCRTN = routine to task
 ; RCTDA = internal entry of message in file 344.5
 ;
 N ZTSK,ZTDESC,ZTIO,ZTDTH,ZTSAVE,DA,DR,DIE
 S ZTIO="",ZTDTH=$H,ZTDESC="UPDATE DATA BASE FROM EEOB EXCEPTION PROCESSING",ZTSAVE("RC*")="",ZTRTN=RCRTN
 D ^%ZTLOAD
 I $G(ZTSK),$G(^RCY(344.5,RCTDA,0)) D
 . S DIE="^RCY(344.5,",DR=".05////"_ZTSK_";.04////1;.08////0",DA=RCTDA D ^DIE
 Q $G(ZTSK)
 ;
LOCK(RCTDA) ; Attempt to lock message file entry RCTDA in file 344.5
 ; Return 1 if successful, 0 if not able to lock
 ;
 N OK
 S OK=1
 L +^RCY(344.5,RCTDA,0):5
 I '$T D
 . I '$D(DIQUIET) W !,*7,"Another user is editing this entry ... please try again later" D PAUSE^VALM1
 . S OK=0
 Q OK
 ;
HDR(RCTDA,RCPG) ;Prints report heading
 ; RCTDA = ien of file 344.5
 ; RCPG = page # last printed
 N Z
 I RCPG!($E(IOST,1,2)="C-") W @IOF,*13
 I 'RCPG D
 . N RCX,RCZ
 . D TXT0(RCTDA,.RCZ,.RCX,0) ; Get 0-node captioned fields
 . S Z=0 F  S Z=$O(RCX(Z)) Q:'Z  S ^TMP($J,"RCHDR_EX",Z)=RCX(Z)
 S RCPG=RCPG+1
 W !,?15,"EDI LBOX - EEOB EXCEPTIONS - EEOB DETAIL",?55,$$FMTE^XLFDT(DT,2),?70,"Page: ",RCPG,!
 S Z=0 F  S Z=$O(^TMP($J,"RCHDR_EX",Z)) Q:'Z  W !,$G(^(Z))
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
ASK(RCSTOP) ; Ask to stop
 ; RCSTOP: passed by ref, flag to stop processing
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ; ***
 ; *** Entrypoints TXT* assume these parameter definitions ***
 ; ***
 ; FUNCTIONs returns RCXM1 and RCCT if passed by reference
 ; RCTDA = ien, file 344.5
 ; RCXM1 = the array returned with text, captioned
 ; RCCT = # of lines already in array (optional)
 ; RCDIQ = the array returned from GETS^DIQ
 ; ***
 ;
TXT0(RCTDA,RCDIQ,RCXM1,RCCT) ; Append 0-node captioned data to array RCXM1
 ; See above for parameter definitions
 ;
 N RCZ,RCTDAC,LINE,DAT,Z,Z0
 S LINE="",RCCT=+$G(RCCT),RCTDAC=RCTDA_","
 S Z=0 F  S Z=$O(RCDIQ(344.5,RCTDAC,Z)) Q:'Z!(Z'<1)  D
 . S Z0=$$GET1^DID(344.5,Z,,"LABEL")
 . S DAT=Z0_": "_$G(RCDIQ(344.5,RCTDAC,Z,"E"))
 . I $L(DAT)>39 S:$L(LINE) RCCT=RCCT+1,RCXM1(RCCT)=LINE S RCCT=RCCT+1,RCXM1(RCCT)=DAT,LINE="" Q
 . I $L(LINE) D  Q:LINE=""  ; Left side exists
 .. I $L(LINE)+$L(DAT)>75 S RCCT=RCCT+1,RCXM1(RCCT)=LINE,LINE=DAT Q
 .. S LINE=LINE_"  "_DAT,RCCT=RCCT+1,RCXM1(RCCT)=LINE,LINE=""
 . S LINE=$E(DAT_$J("",39),1,39)
 I $L(LINE) S RCCT=RCCT+1,RCXM1(RCCT)=LINE
 S:RCCT RCCT=RCCT+1,RCXM1(RCCT)=" "
 Q
 ;
TXTDE(RCTDA,RCDIQ,RCNODE,RCXM1,RCCT) ; Append display data to array RCXM1
 ; See above for parameter definitions
 ; RCNODE = the WP field # to return
 ;
 N RCCT1,LINE,Z,RCTDAC
 S LINE="",RCCT=+$G(RCCT),RCCT1=RCCT
 S RCTDAC=RCTDA_","
 S Z=0 F  S Z=$O(RCDIQ(344.5,RCTDAC,RCNODE,Z)) Q:'Z  D
 . S RCCT=RCCT+1,RCXM1(RCCT)=$G(RCDIQ(344.5,RCTDAC,RCNODE,Z))
 S:RCCT'=RCCT1 RCCT=RCCT+1,RCXM1(RCCT)=" "
 Q
 ;
