VDEFMNU ;INTEGIC/YG & BPOIFO/JG - Edit VDEF parameters & status ; 20 Dec 2005  12:57 PM
 ;;1.0;VDEF;**3**;Dec 28, 2004;
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IA's: #4322 - ^HLCS(870,<link>,0)
 ;       #1373 - Lookup to file #101
 ;       #10063 - $$JOB^%ZTLOAD
 ;
 Q  ; No bozos
 ;
SITE ; Edit Site-Wide Parameters
 N DA,DIC,DIE,DR S DIE=579.5,DA=1,DR=".01;.02;" D ^DIE
 Q
 ;
REQUEST ; Edit Request Queue Parameters
 N DIC,DLAYGO,X,Y,DIE,DA,DR
REQUEST1 K DIC S DIC=579.3,DIC(0)="AQE",DIC("A")="Select Request Queue: "  W ! D ^DIC Q:Y=-1
 K DIC S DIE=579.3,DA=$P(Y,U),DR=".04;.05;.02" D ^DIE
 G REQUEST1
 ;
REQOFF ; Toggle Requestor On/Off
 N DIC,DLAYGO,X,Y,DIE,DA,DR
REQOFF1 K DIC S DIC=579.1,DIC(0)="AQE",DIC("A")="Select Requestor: " W ! D ^DIC Q:Y=-1
 I $$GET1^DIQ(579.1,$P(Y,U)_",",.05,"I")="A" D
 . W !,!,"Inactivating a requestor has a significant effect on the synchronization"
 . W !,"of VistA and remote system(s).  All VDEF requests made while the requestor"
 . W !,"is inactive will be PERMANENTLY lost.  Make sure you really want to"
 . W !,"turn it off.",!
 K DIC S DIE=579.1,DA=$P(Y,U),DR=".05" D ^DIE
 G REQOFF1
 ;
QUEOFF ; Toggle Request Processor Queue on/off
 N DIC,DLAYGO,X,Y,DIE,DA,DR,QUEUE,STAT,TMTASK
QUEOFF1 K DIC S DIC=579.3,DIC(0)="AQE",DIC("A")="Select Request Queue: " W ! D ^DIC Q:Y=-1
 K DIC S QUEUE=$P(Y,U) S DIE=579.3,DA=QUEUE,DR=".09" D ^DIE
 ;
 ; Get the new status of the Request Processor
 S STAT=$$GET1^DIQ(579.3,QUEUE_",",.09,"I")
 ;
 ; Start the Request Processor
 I STAT="R" D REQ^VDEFCONT(QUEUE)
 ;
 ; Stop the Request Processor
 I STAT="S" D
 . S TMTASK=$$GET1^DIQ(579.3,QUEUE_",",.08,"I") S:TMTASK'="" X=$$ASKSTOP^%ZTLOAD(TMTASK)
 . S TMTASK=$$GET1^DIQ(579.3,QUEUE_",",.11,"I") S:TMTASK'="" X=$$ASKSTOP^%ZTLOAD(TMTASK)
 G QUEOFF1
 ;
SCHED ; Schedule processor
 N DIC,DLAYGO,X,Y,SIEN,DIE,DA,DR,QUEUE,STAT,TMTASK,ENTRY
SCHED1 K DIC S DIC=579.3,DIC(0)="AQE",DIC("A")="Select Request Queue: " W ! D ^DIC Q:Y=-1
 K DIC S QUEUE=$P(Y,U) D DISP S DA(1)=QUEUE,DIC="^VDEFHL7(579.3,"_QUEUE_",2,"
 S DIC(0)="AQEL",DIC("A")="Select Entry: " D ^DIC G SCHED1:Y=-1
 S ENTRY=$P(Y,U),DIE=DIC,DA=ENTRY
 S DR=".01;.02;.03;D SCHFORM^VDEFMNU;.04;D SCHFORM^VDEFMNU;.05" D ^DIE
 W ! D DISP
 ;
 ; Now reschedule the processor task back
 S ZTSK=$P(^VDEFHL7(579.3,QUEUE,0),U,8) D ISQED^%ZTLOAD
 ;
 ; If old task not found or not running, start it.
 I $G(ZTSK("E"))'="" D REQ^VDEFCONT(QUEUE) G SCHED1
 I ZTSK(0)=0 D REQ^VDEFCONT(QUEUE) G SCHED1
 ;
 ; Task is scheduled, so reschedule it.
 K ZTDESC,ZTIO,ZTRTN,ZTSAVE S ZTDTH=$H D REQ^%ZTLOAD
 G SCHED1
 ;
SCHFORM W !,"Enter time in military form as HH:MM"
 Q
 ;
DISP ; Display scheduling rules.
 I '$O(^VDEFHL7(579.3,QUEUE,2,0)) W !,"No Scheduling Rules currently defined for this queue"
 E  S SIEN=0 D
 . W !,"Currently defined Scheduling Rules are :"
 . F  S SIEN=$O(^VDEFHL7(579.3,QUEUE,2,SIEN)) Q:'SIEN  D
 .. W !,$$GET1^DIQ(579.32,SIEN_","_QUEUE_",",.01,"E")
 .. W ") On ",$$GET1^DIQ(579.32,SIEN_","_QUEUE_",",.02,"E")
 .. W " the request processor is "
 .. S STAT=$$GET1^DIQ(579.32,SIEN_","_QUEUE_",",.03,"E")
 .. W STAT," from ",$$GET1^DIQ(579.32,SIEN_","_QUEUE_",",.04,"I")
 .. W " to ",$$GET1^DIQ(579.32,SIEN_","_QUEUE_",",.05,"I")
 Q
 ;
CUSTOD ; Edit Custodial Package Status
 N DIC,DLAYGO,X,Y,DIE,DA,DR,PACK
CUSTOD1 K DIC S DIC=579.6,DIC(0)="AQE",DIC("A")="Select Custodial Package: "
 W ! D ^DIC Q:Y=-1  S PACK=$P(Y,U)
 I $P(Y,U,2)="REGISTRATION" D  G CUSTOD1
 . W !,"Registration custodial package can't be edited"
 I $$GET1^DIQ(579.6,PACK_",",.02,"I")="A" D
 . W !!,"Inactivating a custodial package has a significant effect on the"
 . W !,"synchronization of VistA and remote system(s).  All VDEF requests for HL7"
 . W !,"messages associated with this custodial package made while the package is"
 . W !,"inactivated will be PERMANENTLY lost.  Make sure you really want to turn"
 . W !,"this custodial package off.",!
 K DIC S DIE=579.6,DA=PACK,DR=".02" D ^DIE
 G CUSTOD1
 ;
EVENT ; Edit VDEF API Event Status
 N DIC,DLAYGO,X,Y,DIE,DA,DR,EVENT
EVENT1 K DIC S DIC("W")="N Z,DESC S Z=^(0),DESC=$G(^(1)) W:$P(Z,U,9)'="""" DESC_""   ""_""Status: ""_$S($P(Z,U,11)=""A"":""ACTIVE"",1:""INACTIVE""),!,?8,""Pkg: ""_$P($G(^DIC(9.4,$P($G(^VDEFHL7(579.6,$P(Z,U,9),0),-1),U),0)),U)"
 S DIC=577,DIC(0)="AQES",DIC("A")="Select VDEF API Event: "
 W ! D ^DIC Q:Y=-1  S EVENT=$P(Y,U)
 I $$GET1^DIQ(577,EVENT_",",.2,"I")="A" D
 . W !!,"Inactivating a VDEF API event will cause all requests for that"
 . W !,"API to be PERMANENTLY lost.  Make sure you really want to turn"
 . W !,"this API event off.",!
 K DIC S DIE=577,DA=EVENT,DR=".2" D ^DIE
 G EVENT1
 ;
REPORT ; Display VDEF status/parameters
 N LL,LLN,SUBS,LINX,TNN,TNF,IEN,NZ,VDI,VDJ,VDK,VDA,PROT,STATS,%H,Y
REPORT1 W @IOF,?22,"VDEF Status - " S %H=$H D YX^%DTC W Y
 W !,"Logical Link Status" K LINX
 S VDI=0 F  S VDI=$O(^VDEFHL7(577,VDI)) Q:VDI=""  D
 . K RES S PROT=$P($G(^VDEFHL7(577,VDI,0)),U,7) Q:PROT=""
 . D GETS^DIQ(101,PROT_",","775*","I","RES")
 . S VDJ=0 F  S VDJ=$O(RES(101.0775,VDJ)) Q:VDJ=""  D
 .. S SUBS=RES(101.0775,VDJ,.01,"I")
 .. I SUBS S LLN=$$GET1^DIQ(101,SUBS_",",770.7,"E") I LLN'="" S LINX(LLN)=1
 S LLN=0 F  S LLN=$O(LINX(LLN)) Q:LLN=""  D
 . W !?2,LLN,": " S LL=$O(^HLCS(870,"B",LLN,"")) Q:LL=""
 . N ZTSK S ZTSK=$P($G(^HLCS(870,LL,0)),U,12)
 . I ZTSK'="" D STAT^%ZTLOAD W:$G(ZTSK(1))=2 "running task #",ZTSK K ZTSK
 . E  W "stopped or caught up"
 W !!,"Requestor Status"
 S IEN=0 F  S IEN=$O(^VDEFHL7(579.1,IEN)) Q:'IEN  D
 . S NZ=^VDEFHL7(579.1,IEN,0) W !?2,$P(NZ,U),": "
 . W $S($P(NZ,U,5)="A":"Activated",1:"Inactivated")
 . W ?32,"Dest.: ",$P(^VDEFHL7(579.2,$P(NZ,U,3),0),U)
 . W ?52,"Req. Queue: ",$P(^VDEFHL7(579.3,$P(NZ,U,4),0),U,1)
 W !!,"Request Processor Status"
 S IEN=0 F  S IEN=$O(^VDEFHL7(579.3,IEN)) Q:'IEN  D
 . S NZ=^VDEFHL7(579.3,IEN,0) W !?2,$P(NZ,U),": "
 . W $S($P(NZ,U,9)="R":"Running",1:"Suspended")
 . N ZTSK S TNN=$P(NZ,U,11),ZTSK=TNN D STAT^%ZTLOAD
 . W !?2,"Current Task # [Proc]: ",TNN
 . W " ["_$$CNV^XLFUTL($$JOB^%ZTLOAD(TNN),16)_"]"
 . W "  Task status: "
 . I 'ZTSK(0) W "Undefined"
 . E  W $S(ZTSK(1)=0:"Undefined",ZTSK(1)=1:"Active-Pending",ZTSK(1)=2:"Active-Running",ZTSK(1)=3:"Finished",ZTSK(1)=4:"Available",ZTSK(1)=5:"Interrupted",1:"Unknown")
 . S NZ=$G(^VDEFHL7(579.3,IEN,1,0))
 . I NZ="" W !?2,"No requests in the queue"
 . E  W !?2,"Requests waiting for purge: ",$P(NZ,U,4),"      Last request#: ",$P(NZ,U,3)
 . S STATS="" W !?2
 . F STAT="C","Q","E" D
 .. S (VDJ,VDK)=0 F VDJ=0:1:100+(STAT="Q"*900) S VDK=$O(^VDEFHL7(579.3,"C",STAT,IEN,VDK)) Q:VDK=""
 .. W $S(STAT="C":"Checked Out",STAT="Q":"  Queued Up",STAT="E":"  Errored Out")
 .. W $S(VDJ<(100+(STAT="Q"*900)):"("_VDJ_")",1:"(> "_(100+(STAT="Q"*900))_")")
 ;
 ; Loop added for dashboard monitoring
 R !!,"Hit <return/enter> to continue or '^' to terminate: ",VDA:5
 Q:VDA="^"  G REPORT1
