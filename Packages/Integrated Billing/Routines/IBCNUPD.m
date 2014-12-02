IBCNUPD ;ALB/TAZ - UPDATE SUBCRIBER INFO FOR SELECTED PATIENTS ; 07 Mar 2013  14:44 PM
 ;;2.0;INTEGRATED BILLING;**497,506**;21-MAR-94;Build 74
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Call at tags only
 Q
 ;
 ;
EN ; Entry Point for TaskMan.  The routine should be called at label TASK since it will take awhile to complete.
 ;
 N DFN,FILE,INS,IBREL,IBVAL,IENS,FIELD,DATA,DA,DR,DIE,EXPDT,X,Y
 K ^TMP($J,"IBCNUPD")
 S DFN=0
 S FILE=2.312
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . K ^UTILITY("VAPA",$J),^UTILITY("VADM",$J)
 . S INS=0
 . F  S INS=$O(^DPT(DFN,.312,INS)) Q:'INS  D
 .. I '$D(^DPT(DFN,.312,INS,0)) Q  ;Don't process bad nodes.
 .. S IENS=INS_","_DFN_","
 .. S EXPDT=+$$GET1^DIQ(FILE,IENS,3,"I")
 .. I EXPDT,EXPDT<DT Q  ;insurance expiration date exists and it's a past date which means inactive policy
 .. I $$GET1^DIQ(FILE,IENS,4.03)'="SELF" Q
 .. S IBREL=$$GET1^DIQ(FILE,IENS,4.03,"I")
 .. F FIELD=7.01,3.01,3.02,3.05,3.06,3.07,3.08,3.09,3.1,3.11,3.12 D      ; IB*2.0*497 (vd)
 ... S DATA=$$GET1^DIQ(FILE,IENS,FIELD) I DATA'="" Q
 ... S IBVAL=$$PIDEF^IBCNSP1(IBREL,FIELD,DFN,0) I IBVAL="" Q
 ... S DIE="^DPT("_DFN_",.312,"
 ... S DA(1)=DFN,DA=INS
 ... S DR=FIELD_"///^S X=IBVAL"
 ... D ^DIE
 ;Send completion message
 D MAIL
 ;
ENQ Q
 ;
OPT ; Enter from the option
 W !,$$TASK()
OPTQ ;
 Q
 ;
TASK(IBQ) ;Set up task to run the option
 N X,Y,IDT,XDT,TSK,MSG,DTOUT,DUOUT
 ;
 ;If option is queued, set up queue date/time and bypass prompt
 I $G(IBQ) D  G TASK1
 . S X="T+1@2100"
 . S %DT="FR"
 . D ^%DT
 ;
 W !,"*************************** IMPORTANT!! ********************************"
 W !,"This option will scan through the entire Patient File for patients with "
 W !,"insurance where the relationship to insured is self.  Certain fields in "
 W !,"Insurance Type sub-file will be updated to match the patient data if it "
 W !,"does not already exist.  This will take awhile and must be queued to run"
 W !,"in the background when there are few users on the system. The default is"
 W !,"Tomorrow at 9:00 p.m."
 W !
 ;
 ;Set Date and Time
 K %DT
 S %DT="AEFR"
 S %DT("A")="Enter date/time to queue the option: "
 S %DT("B")="T+1@2100"
 S %DT(0)="NOW"  ; prevent past date/time being entered
 D ^%DT
 I $D(DTOUT)!$D(DUOUT)!(Y<0) S MSG="Task Aborted. Option NOT scheduled." G TASKQ
 ;
TASK1 ;bypass for queued task
 S IDT=Y D DD^%DT S XDT=Y
 ;
 ;Check if task already scheduled for date/time
 S TSK=$$GETTASK(IDT)
 I TSK D  G TASKQ
 . S Y=$P(TSK,U,2) D DD^%DT
 . S MSG=" Task (#"_+TSK_") already scheduled to run on "_Y
 ;
 ;Schedule the task
 S TSK=$$SCHED(IDT)
 ;
 ;Check for scheduling problem
 I 'TSK S MSG=" Task Could Not Be Scheduled" G TASKQ
 ;
 ;Send successful schedule message
 S MSG=" Update Subscriber Information Scheduled for "_XDT
 ;
TASKQ ;
 Q MSG
 ;
GETTASK(IDT) ;
 N TASK,TASKNO,TDT,XUSUCI,Y,ZTSK0
 ;
 ;Retrieve UCI
 X ^%ZOSF("UCI") S XUSUCI=Y
 ;       
 S (TASK,TDT)=0,TASKNO=""
 F  S TASK=$O(^%ZTSK(TASK)) Q:'TASK  D  Q:TASKNO
 .I $G(^%ZTSK(TASK,.03))["IBCN SUBSCRIBER UPDATE" D
 ..S ZTSK0=$G(^%ZTSK(TASK,0))
 ..;
 ..;Exclude tasks scheduled by TaskMan
 ..Q:ZTSK0["ZTSK^XQ1"
 ..;
 ..;Exclude tasks in other ucis
 ..Q:(($P(ZTSK0,U,11)_","_$P(ZTSK0,U,12))'=XUSUCI)
 ..;
 ..;Check for correct date and time
 ..S TDT=$$HTFM^XLFDT($P(ZTSK0,"^",6))
 ..;I TDT=IDT S TASKNO=TASK
 Q TASKNO_U_TDT
 ;
 ;Schedule Task
 ;
SCHED(ZTDTH) ;
 N ZTRTN,ZTDESC,ZTIO,ZTSK
 S ZTRTN="EN^IBCNUPD"
 S ZTDESC="IBCN SUBSCRIBER UPDATE"
 S ZTIO=""
 D ^%ZTLOAD
 Q ZTSK
 ;
MAIL ;Send completion message
 NEW XMDUZ,XMSUBJ,XMBODY,MSG,XMTO,DA,DIE,DR
 S XMDUZ=DUZ,XMSUBJ="Subscriber Update Has Completed",XMBODY="MSG"
 S MSG(1)="The Subscriber Update Option has completed at "
 S MSG(2)=" "
 S MSG(3)="     "_$$SITE^VASITE
 ;
 ; recipients of message
 S XMTO(DUZ)=""
 S XMTO("G.PATCHES")=""
 S XMTO("G.IB EDI")=""
 S XMTO("G.IB EDI SUPERVISOR")=""
 ;
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 ;
 Q
