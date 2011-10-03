ORWCSP ; ALB/MJK - Background Consult Report Print Driver ;1/24/95  15:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10**;Dec 17, 1997
PRINT(ORY,ORIO,DFN,ORID)        ; -- print report entry point
 ;  RPC: ORWCS PRINT REPORT
 ;  See RPC definition for details on input and output parameters
 ;
 IF '$$CHK() G PRINTQ
 ; -- task job
 N TASKDATA
 S TASKDATA("DESC")="Consult Report Print"
 S TASKDATA("RTN")="DEQUE^ORWCSP"
 D TASK(.ORY,.ORIO,.DFN,.ORID,.TASKDATA)
PRINTQ Q
 ;
TASK(ORY,ORIO,DFN,ORID,TASKDATA) ;
 ;
 N ZTDTH,ZTRTN,ZTSK,ZTDESC,ZTSAVE
 S ZTIO=ORIO,ZTDTH=$H
 S ZTDESC=TASKDATA("DESC")
 S ZTRTN=TASKDATA("RTN")
 S ZTSAVE("DFN")="",ZTSAVE("ORID")="",ZTSAVE("DUZ(")=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 . S ORY="0^Report queued. (Task #"_ZTSK_")"
 E  D
 . S ORY="99^Task Rejected."
TASKQ Q
 ;
CHK() ; -- do checks for required data
 ; -- this check assumes all parameters in PRINT call are available
 ;
 N OROK,FALSE,TRUE,ORRPT
 S FALSE=0,TRUE=1
 ;
 IF $G(ORIO)']"" S OROK=FALSE,ORY="1^No device selected." G CHKQ
 ;
 IF '$G(ORID) S OROK=FALSE,ORY="2^No report specified." G CHKQ
 ;
 IF '$D(^DPT(+$G(DFN),0)) S OROK=FALSE,ORY="6^Patient specified is not valid." G CHKQ
 ;
 S OROK=TRUE
CHKQ Q OROK
 ;
DEQUE ; -- logic to print queued consult report
 N ROOT,HDRDATA
 ;
 ; -- retrieve report text
 D RPT^ORWCS(.ROOT,.DFN,.ORID)
 ;
 ; -- print report text
 S HDRDATA("TITLE")="Consult Report"
 S HDRDATA("DFN")=DFN
 D OUTPUT(.ROOT,.HDRDATA)
DEQUEQ Q
 ;
OUTPUT(ROOT,HDRDATA) ; -- generic print report
 N I
 D INIT(.HDRDATA)
 D HDR(.HDRDATA)
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  D
 . S HDRDATA("LCNT")=HDRDATA("LCNT")+1
 . IF IOSL<(HDRDATA("LCNT")+5) D HDR(.HDRDATA)
 . W !,@ROOT@(I,0)
 Q
 ;
INIT(HDRDATA) ; -- init generic header data
 N DFN0,DFN,X,VA
 S DFN=$G(HDRDATA("DFN"))
 S HDRDATA("PAGE")=0
 S HDRDATA("LCNT")=0
 ; -- set up patient variables
 S DFN0=$G(^DPT(DFN,0)),HDRDATA("NAME")=$P(DFN0,U)
 D PID^VADPT6 S HDRDATA("PID")=VA("PID")
 S X=$P(DFN0,U,3),HDRDATA("DOB")=$$FMTE^XLFDT(X,"D")
 Q
 ;
HDR(ORY) ; -- print generic header
 N LINE
 S ORY("PAGE")=ORY("PAGE")+1,ORY("LCNT")=5
 S $P(LINE,"-",80)=""
 ;
 W @IOF
 W !,ORY("TITLE"),?71,"Page: ",ORY("PAGE")
 W !,"Name: ",ORY("NAME"),?37,"ID: ",ORY("PID"),?56,"DOB: ",ORY("DOB")
 W !,LINE,!
 Q
 ;
