RCDPEX5 ;ALB/TMK,DWA - ELECTRONIC EOB EXCEPTION PROCESSING - FILE 344.5 ;8 Aug 2018 21:44:13
 ;;4.5;Accounts Receivable;**332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
UPD ; Update (File) ERA msgs manually from DUPLICATE exception list for file 344.5
 N RC0,RCDA,RCLKBXDA,RCOK,RCTSK,RCTYP,RCU,ZTSK
 D FULL^VALM1
 D SEL(.RCDA,1)
 S RCDA=$O(RCDA(""))
 I RCDA="" G UPDQ
 S RCLKBXDA=+RCDA(RCDA)
 S RC0=$G(^RCY(344.5,RCLKBXDA,0))
 I RC0="" D  G UPDQ
 . W !,$C(7)_"ERA #"_RCDA_" is no longer in exception file" S RCOK=0
 . D PAUSE^VALM1
 ;
 I '$$LOCK(RCLKBXDA) D  G UPDQ
 . W !,$C(7)_"Could not Lock ERA #"_RCDA_"  to file it." S RCOK=0
 . D PAUSE^VALM1
 ;
 S RC0=$G(^RCY(344.5,RCLKBXDA,0))
 I RC0="" D  G UPDQ
 . W !,$C(7)_"ERA #"_RCDA_" is no longer in exception file" S RCOK=0
 . D PAUSE^VALM1
 I $P(RC0,U,5) S RCOK=1 D  G:'RCOK UPDQ
 . N ZTSK
 . S ZTSK=$P(RC0,U,5) D STAT^%ZTLOAD Q:ZTSK(0)=0  ;Task not scheduled
 . I "12"[ZTSK(1) W !,$C(7)_"This record has already been scheduled for update. Task # is: "_$P(RC0,U,5) S RCOK="" D PAUSE^VALM1
 ;
 S RCTYP=$P(RC0,U,2)
 S RCU=$S(RCTYP="835ERA":"NEWERA^RCDPESR2("_RCLKBXDA_",1)",RCTYP="835XFR":"FILEEOB^RCDPESR5("_RCLKBXDA_")",1:"")
 I RCU="" W !,$C(7)_"This message has an invalid 'type' - can't update" D PAUSE^VALM1 G UPDQ
 S RCTSK=$$TASK(RCU,RCLKBXDA)
 I RCTSK W !,"File update has been tasked (#"_RCTSK_")"
 I 'RCTSK W !,$C(7)_"File update could not be tasked. Please try again later!"
 D PAUSE^VALM1
 ;
 D BLD^RCDPEX1("DUPLICATE ERA")
UPDQ ; fall through or GOTO from above 
 I $G(RCLKBXDA) L -^RCY(344.5,RCLKBXDA)
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
 N Z,Z0,RCSTOP,RCPG,RCXM,RCXM1,RC,RCZ,RCTDAC,RCV5
 K ^TMP($J,"RCRAW"),^TMP($J,"RCOUT")
 S RCTDAC=RCTDA_",",RCV5=0
 ;
 D GETS^DIQ(344.5,RCTDAC,"*","IEN","RCZ")
 D TXTDE^RCDPEX(RCTDA,.RCZ,1,.RCXM,.RC)
 ;
 I $O(^RCY(344.5,RCTDA,"EX",0)) D
 . S RC=RC+1,RCXM(RC)="**EXCEPTION MESSAGES**"
 . D TXTDE^RCDPEX(RCTDA,.RCZ,5,.RCXM,.RC)
 ;
 K ^TMP("RCSAVE",$J)
 M ^TMP("RCSAVE",$J)=^RCY(344.5,RCTDA,2)
 I +$P($G(^TMP("RCSAVE",$J,1,0)),U,16)>0 S RCV5=1
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
 .. D:RCPG ASK^RCDPEX(.RCSTOP) I RCSTOP Q
 .. D HDR(RCTDA,.RCPG)
 . W !,$G(^TMP($J,"RCOUT",Z))
 I 'RCSTOP,RCPG D ASK^RCDPEX(.RCSTOP)
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
 ; RCDA(n)=ien of bill selected in file 344.5
 ; ONE = if set to 1, only one selection can be made at a time
 N RC
 K RCDA
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S RCDA=0 F  S RCDA=$O(VALMY(RCDA)) Q:'RCDA  S RC=$G(^TMP("RCDPEX-EOBDX",$J,RCDA)),RCDA(RCDA)=+$P(RC,U,2)
 Q
 ;
DEL ; RCDPEX DELETE DUP MESSAGE option
 ; Delete messages from messages list - file 344.5
 N DIR,RC0,RCDA,RCDIQ,RCE,RCLKBXDA,RCOK,RCPAYTP,RCT,RCTYP,RCU,RCX,Z
 D FULL^VALM1
 S RCLKBXDA=0
 D SEL(.RCDA,1)
 S RCDA=$O(RCDA(""))
 I RCDA="" G DELQ
 S RCLKBXDA=+RCDA(RCDA),RCLKBXDA("iens")=RCLKBXDA_","
 S RCPAYTP=$$PAYTYP^RCDPEX(RCLKBXDA)
 S DIR(0)="YA",DIR("A",1)="This action will PERMANENTLY delete an EDI Lockbox message from your system",DIR("A",2)="A bulletin will be sent to report the deletion",DIR("A",3)=" "
 S DIR("A")="Are you sure you want to continue? ",DIR("B")="NO"
 W ! D ^DIR K DIR
 G:Y'=1 DELQ
 I '$$LOCK(RCLKBXDA) D  G DELQ
 . K DIR
 . S DIR(0)="EA",DIR("A",1)=" ",DIR("A",2)="Unable to lock the EDI LOCKBOX MESSAGE for deletion."
 . S DIR("A")="Press ENTER: " D ^DIR
 S RC0=$G(^RCY(344.5,RCLKBXDA,0))
 ;
 I $P(RC0,U,5) S RCOK=1 D  G:'RCOK DELQ
 . N ZTSK
 . S ZTSK=$P(RC0,U,5) D STAT^%ZTLOAD Q:ZTSK(0)=0  ;Task not scheduled
 . I "12"[ZTSK(1) W !,$C(7)_"This Lockbox message is scheduled for update. Task # is: "_$P(RC0,U,11) S RCOK="" D PAUSE^VALM1
 ;
 S DIR(0)="YA",DIR("A",1)=" ",DIR("A",2)="",$P(DIR("A",2),"*",66)="",DIR("A",3)="* This EDI Lockbox message is about to be PERMANENTLY deleted!! *",DIR("A",4)=DIR("A",2),DIR("A",5)=" "
 S DIR("A")="Are you STILL sure you want to continue? ",DIR("B")="NO"
 W ! D ^DIR W ! K DIR
 I Y'=1 W !!,"Nothing deleted" D PAUSE^VALM1 G DELQ
 ;
 D SNDMLMN(RCLKBXDA),LKBXDEL(RCLKBXDA)
 I $D(^RCY(344.5,RCLKBXDA)) D  G DELQ
 . W !,"EDI Lockbox message not deleted - problem with deletion." D PAUSE^VALM1
 ;
 W !,"A MailMan message has been sent to report this deletion.",!
 D PAUSE^VALM1,BLD^RCDPEX1("DUPLICATE ERA")
 ;
DELQ ; fall through or GOTO here
 L -^RCY(344.5,RCLKBXDA,0)
 S VALMBCK="R"
 Q
 ;
SNDMLMN(RCLKBXDA) ; send MailMan message about RCLKBXDA entry in 344.5
 N J,LN,RCDPDATA,X,XMINSTR,XMTO,XMZ,Y
 K ^TMP($J,"RCMMSG")  ; mail text storage
 S DR=".01:.04;.07:.15"
 D DIQ3445^RCDPEX1(RCLKBXDA,DR)  ; returns RCDPDATA array
 ; create MailMan text
 S LN=1,^TMP($J,"RCMMSG",LN,0)="An EDI LOCKBOX MESSAGE was deleted "_$$FMTE^XLFDT($$NOW^XLFDT)
 S LN=LN+1,^TMP($J,"RCMMSG",LN,0)="The user: "_$$GET1^DIQ(200,DUZ_",",.01)_"  (User #"_DUZ_")"
 S LN=LN+1,^TMP($J,"RCMMSG",LN,0)=" ",LN=LN+1,^TMP($J,"RCMMSG",LN,0)="Deleted Lockbox Message Information: "
 ; add data and field labels to message
 F J=.01:.01:.04,.07:.01:.15 D
 . S X=$G(RCDPDATA(344.5,RCLKBXDA,J,"E")) Q:X=""  ; skip null fields
 . S LN=LN+1,^TMP($J,"RCMMSG",LN,0)=" > "_$$GET1^DID(344.5,J,"","LABEL")_": "_X
 ; send as a priority message
 S XMTO(DUZ)="",XMTO("G.RCDPE PAYMENTS MGMT")="",XMINSTR("FLAGS")="P"
 D SENDMSG^XMXAPI(DUZ,"EDI LOCKBOX MESSAGE DELETION",$NA(^TMP($J,"RCMMSG")),.XMTO,.XMINSTR,.XMZ)
 I '$G(ZTSK),$E(IOST,1,2)="C-",$G(XMZ) W !,"MailMan message #"_XMZ_" sent."
 K ^TMP($J,"RCMMSG")
 Q
 ;
LKBXDEL(RCLKBXDA) ;Delete entry from AR EDI LOCKBOX MESSAGES file
 N DA,DIC,DIK,X,Y S DIK="^RCY(344.5,",DA=RCLKBXDA D ^DIK
 Q
 ;
TASK(RCRTN,RCLKBXDA) ;function, Schedule the task to update data base from message
 ; RCRTN - routine to task
 ; RCLKBXDA - IEN in file 344.5
 ; returns: TaskMan task #
 N ZTSK,ZTDESC,ZTIO,ZTDTH,ZTSAVE,DA,DR,DIE
 S ZTIO="",ZTDTH=$H,ZTDESC="UPDATE DATA BASE FROM EEOB EXCEPTION PROCESSING",ZTSAVE("RC*")="",ZTRTN=RCRTN
 D ^%ZTLOAD
 I $G(ZTSK),$G(^RCY(344.5,RCLKBXDA,0)) D
 . S DIE="^RCY(344.5,",DR=".05///"_ZTSK_";.04///1;.08///0",DA=RCLKBXDA D ^DIE
 Q $G(ZTSK)
 ;
LOCK(RCLKBXDA) ; Boolean function, lock entry RCLKBXDA in file 344.5
 ; Return 1 if successful, else zero
 Q:'($G(RCLKBXDA)>0) "^no 344.5 IEN to lock"  ; error message is also false
 N LCK L +^RCY(344.5,RCLKBXDA,0):DILOCKTM S LCK=$T
 Q LCK
 ;
HDR(RCTDA,RCPG) ;Prints report heading
 ; RCTDA = ien of file 344.5
 ; RCPG = page # last printed
 N Z
 I RCPG!($E(IOST,1,2)="C-") W @IOF,*13
 I 'RCPG D
 . N RCX,RCZ
 . D TXT0^RCDPEX(RCTDA,.RCZ,.RCX,0) ; Get 0-node captioned fields
 . S Z=0 F  S Z=$O(RCX(Z)) Q:'Z  S ^TMP($J,"RCHDR_EX",Z)=RCX(Z)
 S RCPG=RCPG+1
 W !,?15,"EDI LBOX - DUPLICATE ERA - EEOB DETAIL",?55,$$FMTE^XLFDT(DT,2),?70,"Page: ",RCPG,!
 S Z=0 F  S Z=$O(^TMP($J,"RCHDR_EX",Z)) Q:'Z  W !,$G(^(Z))
 W !,$TR($J("",IOM)," ","=")
 Q
