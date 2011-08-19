GMRCPC ;SLC/DCM,dee,MA - List Manager Routine: Collect and display consults by service and status ;4/18/01  10:29
 ;;3.0;CONSULT/REQUEST TRACKING;**1,7,21,23,22**;DEC 27, 1997
 ; Patch #21 added clean-up KILL for ^TMP("GMRCTOT",$J)
 ; Patch #23 add a KILL for GMRCSVNM
EN ;GMRC List Manager Routine -- main entry point for GMRC PENDING CONSULTS
 K GMRCSVC,GMRCSVCP
 I $D(GMRCEACT),$L(GMRCEACT) D  I '$D(^GMR(123.5,$G(GMRCSVC),0)) D EXIT Q
 .S GMRCSVCP=GMRCEACT
 .S GMRCSVC=$O(^GMR(123.5,"B",GMRCSVCP,0))
 .Q:'$D(^GMR(123.5,$G(GMRCSVC),0))
 .;Build service array
 .S GMRCDG=GMRCSVC
 .D SERV1^GMRCASV
 .S GMRCDT1="ALL"
 .S GMRCDT2=0
 .D LISTDATE^GMRCSTU1(GMRCDT1,GMRCDT2,.GMRCEDT1,.GMRCEDT2)
 ;If no service ask for one
 I '$L($G(GMRCSVC)) D EN^GMRCSTLM I $D(GMRCQUT) D EXIT Q
 ;Quit if no array of services
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 D EXIT Q
 ;
 D EN^VALM("GMRC PENDING CONSULTS")
 ;
HDR ; -- header code
 Q:$D(GMRCQUT)!'$D(GMRCCT)
 S VALMHDR(1)="To Service:  "_GMRCHEAD
 S VALMHDR(2)="From: "_$G(GMRCEDT1)_"   To: "_$G(GMRCEDT2)
 I $G(GMRCCTRL)=1 S VALMCAP="     "_VALMCAP
 Q
 ;
INIT ; -- init variables and list array
 ;This entry is not used ENORLM^GMRCSTLM is used instead.
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K CNT,CTRLCOL,GMRCCT,GMRCQUT,GMRCSVC,GMRCSVCP,VALMHDR,GMRCCOMP
 K GMRCEDT1,GMRCEDT2,GMRCSVNM
 K GMRCHEAD,GMRCCTRL,GMRCSTAT,GMRCARRN
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J),^TMP("GMRCR",$J,"CP"),^TMP("GMRCRINDEX",$J),^TMP("GMRCTOT",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
CWIDTH(GMRCCTRL) ;Prints a message about how wide the report is.
 N WIDTH
 S WIDTH=92
 I GMRCCTRL#100\10 D
 .I GMRCCTRL#100\10=1 S WIDTH=WIDTH+5
 .E  S WIDTH=WIDTH+10
 I GMRCCTRL#1000\100 S WIDTH=WIDTH-6
 Q WIDTH
 ;
PWIDTH(GMRCCTRL) ;Prints a message about how wide the report is.
 W !!,"This print out is "_$$CWIDTH(GMRCCTRL)_" columns wide."
 Q
 ;
PRNTONLY(GMRCCTRL) ;Option to just send the report to a device.
 N GMRCQUT,RETURN,GMRCDG,GMRCSTAT,VALMBCK
 N GMRCDT1,GMRCDT2,GMRCEDT1,GMRCEDT2
 ;Get the statuses
 S GMRCSTAT=$$STS^GMRCPC1
 I $D(GMRCQUT) D EXIT Q
 ;Get the service and date range.
 D EN^GMRCSTLM
 I $D(GMRCQUT) D EXIT Q
 ;Quit if no array of services
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 D EXIT Q
 I '($D(GMRCCTRL)#2) S GMRCCTRL=0 ;default to just the list
 D PWIDTH(GMRCCTRL)
 ;Get the device
 D PRNTASK^GMRCSTU
 I $D(GMRCQUT) D EXIT Q
 ;Save some things if the report is queued
 I $D(IO("Q")) D
 .S ZTSAVE("GMRCSTAT")=""
 .S ZTSAVE("GMRCCTRL")=""
 ;Create the report if not queued
 E  D ENOR^GMRCSTLM(.RETURN,GMRCDG,GMRCDT1,GMRCDT2,GMRCSTAT,GMRCCTRL,"CP")
 ;Print the report
 D PRNTIT^GMRCSTU("CP","PRNTQ^GMRCPC","CONSULT/REQUEST PACKAGE PRINT SERVICE CONSULTS BY STATUS FROM OPTION")
 D EXIT
 Q
 ;
PRNTQ ;Print Queued report from ^TMP global then kill off ^TMP & ^XTMP
 ;Create the report
 N RETURN,INDEX
 D ENOR^GMRCSTLM(.RETURN,GMRCDG,GMRCDT1,GMRCDT2,GMRCSTAT,GMRCCTRL,"CP")
 U IO
 S INDEX=""
 F  S INDEX=$O(^TMP("GMRCR",$J,TMPNAME,INDEX)) Q:INDEX=""  W ^TMP("GMRCR",$J,TMPNAME,INDEX,0),!
 K ^TMP("GMRCR",$J,TMPNAME),^XTMP("GMRCR",J,DOLLARH,"PRINT"),J,DOLLARH
 D ^%ZISC
 D EXIT
 Q
 ;
