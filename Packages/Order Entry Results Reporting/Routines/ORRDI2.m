ORRDI2 ; SLC/JMH - RDI routine for user interface and data cleanup; 3/24/05 2:31 ;6/30/08  11:06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**232,294**;Dec 17, 1997;Build 27
 ;
SET ;utility to set RDI related parameters
 I '$$PATCH^XPDUTL("OR*3.0*238") D  Q
 . W !,"This menu is locked until patch OR*3.0*238 is installed."
 N QUIT,QUITALL
 W !!,"Sets System wide parameters to control order checking against"
 W !,"  remote data",!
 F  Q:$G(QUIT)!($G(QUITALL))  D
 . N VAL,VALEXT,DIR,DTOUT,Y
 . S VAL=$$GET^XPAR("SYS","OR RDI HAVE HDR")
 . S VALEXT="NO" I VAL=1 S VALEXT="YES"
 . S DIR("A")="HAVE AN HDR"
 . S DIR("B")=VALEXT
 . S DIR("?")="^D HELP1^ORRDI2"
 . S DIR(0)="Y"
 . D ^DIR
 . I $G(Y)="^"!($G(DTOUT)) S QUITALL=1
 . I $G(Y)=1!($G(Y)=0) S QUIT=1 D
 . . D EN^XPAR("SYS","OR RDI HAVE HDR",,Y)
 I $G(QUITALL) Q
 I '$$GET^XPAR("SYS","OR RDI HAVE HDR") Q
 S QUIT=0
 F  Q:$G(QUIT)!($G(QUITALL))  D
 . N VAL,VALEXT,DIR,DTOUT,Y
 . S VAL=$$GET^XPAR("SYS","OR RDI CACHE TIME")
 . S VALEXT=$G(VAL,0)
 . S DIR("A")="CACHE TIME (Minutes)"
 . S DIR("B")=VALEXT
 . S DIR("?")="^D HELP3^ORRDI2"
 . S DIR(0)="N^0:9999:0"
 . D ^DIR
 . I $G(Y)="^"!($G(DTOUT)) S QUITALL=1
 . I $G(Y)>-1 S QUIT=1 D
 . . D EN^XPAR("SYS","OR RDI CACHE TIME",,Y)
 Q
HELP1 ;
 W "Set this to ""YES"" if this system has an HDR system that"
 W !,"  it uses to access remote data."
 Q
HELP3 ;
 W "Set this to the number of minutes that the retrieved data is "
 W !,"  to be considered valid for order checking purposes."
 Q
LIST ;
 W !
 W $$GET^XPAR("SYS","OR RDI HAVE HDR")," "
 W $$GET^XPAR("SYS","OR RDI CACHE TIME")
 Q
CLEANUP ;
 N VAL,NOW,THRESH,DOM,DFN,TIME
 S VAL=$$GET^XPAR("SYS","OR RDI CACHE TIME")
 S NOW=$$NOW^XLFDT
 S THRESH=$$FMADD^XLFDT(NOW,,,-VAL)
 S DFN=0
 F DOM="PSOO","ART" F  S DFN=$O(^XTMP("ORRDI",DOM,DFN)) Q:'DFN  D
 . S TIME=$G(^XTMP("ORRDI",DOM,DFN,0))
 . I TIME<THRESH K ^XTMP("ORRDI",DOM,DFN)
 ;clear out metrics data older than 5 days
 N ORDT,ORDIFF S ORDT=0
 F  S ORDT=$O(^XTMP("ORRDI","METRICS",ORDT)) Q:'ORDT  S ORDIFF=$$FMDIFF^XLFDT($$NOW^XLFDT,ORDT,1) Q:ORDIFF<5  K ^XTMP("ORRDI","METRICS",ORDT)
 ; checking if OUTAGE task crashed or hasn't completed successfully
 I $$DOWNXVAL D
 .I $$FMDIFF^XLFDT($$NOW^XLFDT,$$PINGXVAL,2)>($$PINGPVAL*2) D SPAWN^ORRDI2
 Q
DOWNRPC(ORY) ;can be used in an RPC to check if RDI is in an OUTAGE state (HDR DOWN)
 S ORY=$$DOWNXVAL
 Q
DICNPVAL() ;parameter value for dummy patient ICN
 Q $$GET^XPAR("ALL","ORRDI DUMMY ICN")
FAILPVAL() ;parameter value for failure threshold
 Q $$GET^XPAR("ALL","ORRDI FAIL THRESH")
SUCCPVAL() ;parameter value for success threshold
 Q $$GET^XPAR("ALL","ORRDI SUCCEED THRESH")
PINGPVAL() ;parameter value for ping frequency
 Q $$GET^XPAR("ALL","ORRDI PING FREQ")
DOWNXVAL() ;xtmp value for OUTAGE state
 Q $G(^XTMP("ORRDI","OUTAGE INFO","DOWN"))
FAILXVAL() ;xtmp value for number of failed reads
 Q $G(^XTMP("ORRDI","OUTAGE INFO","FAILURES"))
SUCCXVAL() ;xtmp value for number of successful reads
 Q $G(^XTMP("ORRDI","OUTAGE INFO","SUCCEEDS"))
PINGXVAL() ;xtmp value for last ping time
 Q $G(^XTMP("ORRDI","OUTAGE INFO","DOWN","LAST PING"))
LDPTTVAL(DFN) ;tmp value for if the local data only message has been shown to the user during ordering session
 Q $G(^TMP($J,"ORRDI",DFN))
SPAWN ;subroutine to spawn the DOWNTSK task
 K ^XTMP("ORRDI","ART"),^XTMP("ORRDI","PSOO")
 N ZTDESC,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDTH
 S ZTDESC="RDI TASK TO CHECK IF HDR IS UP"
 S ZTRTN="DOWNTSK^ORRDI2"
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT+.000001
 D ^%ZTLOAD
 Q
DOWNTSK ;subroutine to check if HDR is back up
 S ^XTMP("ORRDI","OUTAGE LOG",$$NOW^XLFDT)="GOING DOWN"
 F  Q:(($$SUCCXVAL'<$$SUCCPVAL)!('$$DOWNXVAL))  D
 .N WAIT,RSLT
 .S WAIT=$$FMDIFF^XLFDT($$NOW^XLFDT,$$PINGXVAL,2)
 .S WAIT=$$PINGPVAL-WAIT
 .;wait until the proper # of seconds has expired before retrying
 .I WAIT>0 H WAIT
 .S ^XTMP("ORRDI","OUTAGE INFO","DOWN","LAST PING")=$$NOW^XLFDT
 .;send dummy message
 .S RSLT=$$TESTCALL
 .;if successful increment success counter
 .I RSLT S ^XTMP("ORRDI","OUTAGE INFO","SUCCEEDS")=1+$$SUCCXVAL
 .;if failure set success counter to 0
 .I 'RSLT S ^XTMP("ORRDI","OUTAGE INFO","SUCCEEDS")=0
 K ^XTMP("ORRDI","OUTAGE INFO")
 S ^XTMP("ORRDI","OUTAGE LOG",$$NOW^XLFDT)="BACK UP"
 Q
TCOLD() ;call to send a test call to CDS...returns 1 if successful, 0 if not
 N ORREQ,ORXML,ORRET,XML
 S ORREQ="/isAlive"
 S ORXML=$$GETREST^XOBWLIB("CDS WEB SERVICE","CDS SERVER")
 S ORRET=$$GET^XOBWLIB(ORXML,ORREQ,.ORERR,0)
 I 'ORRET Q 0
 While (ORXML.HttpResponse.Data.AtEnd = 0) {S XML=ORXML.HttpResponse.Data.Read(100)}
 Q:XML="true" 1
 Q 0
TESTCALL() ;call to send a test call to CDS...returns 1 if successful, 0 if not
 N ORREQ,ORXML,ORRET
 I $L($G(^XTMP("ORRDI","TESTREQ")))'>0 Q $$TCOLD() ;USES isAlive IF NO TEST REQUEST IS PRESENT
 S ORREQ=$G(^XTMP("ORRDI","TESTREQ"))
 S ORXML=$$GETREST^XOBWLIB("CDS WEB SERVICE","CDS SERVER")
 S ORRET=$$GET^XOBWLIB(ORXML,ORREQ,.ORERR,0)
 I 'ORRET Q 0
 K ^TMP($J,"ORRDI")
 D PARSE^ORRDI1(ORXML.HttpResponse.Data)
 I $L($$MSGERR^ORRDI1)>0 K ^TMP($J,"ORRDI") Q 0
 K ^TMP($J,"ORRDI")
 Q 1
