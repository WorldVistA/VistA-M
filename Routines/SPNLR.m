SPNLR ;ISC-SF/GB-SCD REPORTS MAIN CONTROLLER ;1/10/2002
 ;;2.0;Spinal Cord Dysfunction;**3,6,19**;01/02/1997
 ; This routine provides overall control for the local SCD reports.
 ; It expects to be called with the ID of the report to be produced.
ENTRY(RPTID) ;
 N ABORT,FDATE,TDATE,HIUSERS,QLIST
 S ABORT=0
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 D ASK^SPNLR1(RPTID,.FDATE,.TDATE,.QLIST,.HIUSERS,.ABORT) Q:ABORT
 D GETDEV Q:ABORT
 I $D(IO("Q")) D CRE8TASK Q
 D CRE8RPT
 Q
GETDEV ; Ask the user to which device to print the report
 N POP
 S %ZIS="QM"
 D ^%ZIS
 I POP S ABORT=1
 Q
CRE8TASK ;
 N ZTRTN,ZTSAVE,ZTDESC,RDESC,TASKSTAT,DIR,Y
 S RDESC("A")="Patient Listing"
 S RDESC("B")="Breakdown of Patients Rpt"
 S RDESC("C")="Current Inpatients Rpt"
 S RDESC("D")="Follow Up Rpt (Last Seen)"
 S RDESC("E")="Follow Up Rpt (Last Annual Rehab Eval)"
 S RDESC("F")="Patient Health Summary"
 S RDESC("J")="Inpatient/Outpatient Activity Rpt"
 S RDESC("K")="Laboratory Utilization Rpt"
 S RDESC("L")="Pharmacy Utilization Rpt"
 S RDESC("M")="Radiology Utilization Rpt"
 S RDESC("Q")="Specific Inpatient/Outpatient Activity Rpt"
 S RDESC("R")="Specific Laboratory Utilization Rpt"
 S RDESC("S")="Specific Pharmacy Utilization Rpt"
 S ZTRTN="CRE8RPT^SPNLR"
 S ZTSAVE("RPTID")=""
 S ZTSAVE("FDATE")=""
 S ZTSAVE("TDATE")=""
 S ZTSAVE("HIUSERS")=""
 S ZTSAVE("QLIST(")="" ; QLIST is an array
 S ZTSAVE("SPNLTRAM")=""
 S ZTSAVE("SPNLTRM1")=""
 S ZTDESC=RDESC(RPTID)
 S ZTSAVE("^TMP($J,"""_"SPNPRT"_""",")=""
 D ^%ZTLOAD
 S TASKSTAT=Y
 D HOME^%ZIS
 W:TASKSTAT'=-1 !!,$$CENTER^SPNLRU("**** Your task has been queued ****"),!
 S DIR(0)="E" D ^DIR ; Hit return to continue
 Q
CRE8RPT ;
 N ABORT,FACNAME,FACNR,SPNPAGE,PID,XFDATE,XTDATE,PCOUNT,DIR
 U IO
 I RPTID="F" D PRINT^SPNLRF(.QLIST) Q  ; Patient Health Summary
 S (ABORT,PCOUNT,SPNPAGE)=0
 ; Get facility number from the site parameters file
 S FACNR=+$P($G(^SPNL(154.91,1,0)),U,1)
 ; Look up facility name in the institution file
 I $D(^DIC(4,"D",FACNR)) S FACNAME=$P($G(^DIC(4,$O(^DIC(4,"D",FACNR,0)),0)),U,1)
 E  S FACNAME="Your Facility Name Here"
 S XFDATE=$E(FDATE,4,5)_"/"_$E(FDATE,6,7)_"/"_((17+($E(FDATE)))_$E(FDATE,2,3))
 S XTDATE=$E(TDATE,4,5)_"/"_$E(TDATE,6,7)_"/"_((17+($E(TDATE)))_$E(TDATE,2,3))
 K ^TMP("SPN",$J)
 W:IOST["C-" !,"Gathering patient data"
 S PID=0
 F  S PID=$O(^SPNL(154,PID)) Q:(PID="")!('+PID)  D  ; entries are DINUM'd!
 . I '$$EN2^SPNPRTMT(PID) Q  ; Patient fail the filters
 . I $D(SPNLTRAM) Q:$$TRAUMA^SPNLRU1(PID)'>0
 . I IOST["C-" S PCOUNT=PCOUNT+1 W:(PCOUNT#50=0) "."
 . D @("GATHER^SPNLR"_RPTID_"(PID,FDATE,TDATE,HIUSERS,.QLIST)")
 D @("PRINT^SPNLR"_RPTID_"(FACNAME,XFDATE,XTDATE,HIUSERS,.QLIST,.ABORT)")
 I IOST["C-",'ABORT S DIR(0)="E" D ^DIR ; Hit return to continue
 K ^TMP("SPN",$J)
 D ^%ZISC
 K RPTID,FDATE,TDATE,HIUSERS,QLIST
 Q
