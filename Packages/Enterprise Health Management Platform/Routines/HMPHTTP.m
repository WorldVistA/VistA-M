HMPHTTP ;SLC/MKB,ASMR/RRB,CK - HTTP interface;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; %ZTLOAD                      10063
 ; DIR                          10026
 ; VASITE                       10112
 ; XLFCRC                        3156
 ; XLFUTL                        2622
 ; XPAR                          2263
 ; XTHC10                        5515
 ; XUPARAM                       2541
 Q
 ;
EN ; -- manage the background job
 N ZTSK,STS
 S ZTSK=+$G(^XTMP("HMP","ZTSK")),STS=$$STS
 W !,?24,"--- HMP Patient Data Monitor ---"
 W !!,"Task"_$S(ZTSK:" #"_ZTSK,1:"")_" is "_$P(STS,U,2)_".",!
 ;
 I ZTSK,+STS=1!(+STS=2) D:$$STOP  Q
 . N X S X=$$ASKSTOP^%ZTLOAD(ZTSK)
 . W !,$P(X,U,2),!
 ;
 I $$START D
 . W !!,"Starting HMP Patient Data Monitor ... " D QUE
 . I $G(ZTSK) W "task #"_ZTSK_" started.",!
 . E  W !,"ERROR: task NOT created.  Try again later.",!
 . S ^XTMP("HMP","ZTSK")=$G(ZTSK)
 Q
 ;
STS() ; -- get the status of ZTSK
 D STAT^%ZTLOAD
 N Y S Y=+$G(ZTSK(1))_U_$G(ZTSK(2))
 Q Y
 ;
STOP() ; -- stop the task?
 N X,Y,DIR
 S DIR("A")="Do you want to stop the data monitor? ",DIR(0)="YA",DIR("B")="NO"
 S DIR("?",1)="Enter YES to stop or cancel the data monitor; please restart ASAP!"
 S DIR("?",3)="This job must be running in the background for AViVA to be notified"
 S DIR("?")="when new patient data is available.",DIR("?",2)="  "
 D ^DIR S:Y<1 Y=0
 Q Y
 ;
START() ; -- [re]start the task?
 N X,Y,DIR
 S DIR(0)="YA",DIR("B")="YES"
 S DIR("A")="Do you want to "_$S(STS:"re",1:"")_"start the data monitor? "
 S DIR("?",1)="Enter YES to "_$S(STS:"re",1:"")_"start the HMP Patient Data Monitor."
 S DIR("?",3)="This job must be running in the background for AViVA to be notified"
 S DIR("?")="when new patient data is available.",DIR("?",2)="  "
 D ^DIR S:Y<1 Y=0
 Q Y
 ;
QUE ; -- create the background task: returns ZTSK
 N IO,IOP,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSAVE,%ZIS
 S %ZIS="0H",IOP="NULL" D ^%ZIS I POP W !,"Null Device Not Found" Q
 S ZTDESC="HMP new data monitor for AViVA",ZTDTH=$H,ZTIO=""
 S ZTRTN="POKE^HMPHTTP" K ZTSK
 D ^%ZTLOAD
 Q
 ;
POKE ; -- background job to poke the client when new data is available
 ; ^XTMP("HMP",DFN,TYPE,ID) = new data since last update
 N DIV,ID,DFN,DATA,IOP,X,DA,TOKEN,NEW K ZTSTOP,ZTREQ
 S IOP="NULL" D ^%ZIS
 S ID=(+$H)+$P($H,",",2)
 S DFN=0 F  S DFN=$O(^XTMP("HMP",DFN)) Q:DFN<1  I $D(^(DFN))>9 D
 . L +^XTMP("HMP",DFN):5 Q:'$T  ;try again next cycle
 . K DATA M DATA=^XTMP("HMP",DFN)
 . S X=$G(^XTMP("HMP",DFN)) K ^(DFN) S ^(DFN)=X ;clear list, keep subscription
 . L -^XTMP("HMP",DFN)
 . ; add to list for URL
 . S DA=0 F  S DA=$O(^HMP(800000,"ADFN",DFN,DA)) Q:DA<1  D
 .. S TOKEN=DA_"~"_ID,NEW(TOKEN)=""
 .. M ^XTMP("HMPX",TOKEN,DFN)=DATA
 D SEND(.NEW)
 I $$S^%ZTLOAD S ZTSTOP=1,ZTREQ="@" Q
 D HANG S ZTREQ="" ;re-queue
 Q
 ;
SEND(LIST) ; send each list ID to its URL
 N SYS,ID,DA,URL,X
 S SYS=$$SYS^HMPUTILS
 ; DIV=$P($$SITE^VASITE,U,3) ;station#
 S ID="" F  S ID=$O(LIST(ID)) Q:ID=""  D
 . S DA=+ID,URL=$G(^HMP(800000,DA,.1)) Q:URL=""
 . S URL=URL_"?vistaId="_SYS_"&id="_ID
 . S X=$$GETURL^XTHC10(URL,,"HMPX") ;I X>200 = ERROR
 Q
 ;
HANG ; -- wait #seconds
 N X S X=$$GET^XPAR("ALL","HMP TASK WAIT TIME") S:'X X=99
 H X
 Q
 ;
KILL ; -- kill/reset ^HMP(800000) for testing
 K ^HMP(800000)
 S ^HMP(800000,0)="HMP SUBSCRIPTION^800000^^"
 Q
