GMRCST ;SLC/DCM,dee - Statistics on how long to complete consult/requests for a service ;11/15/02 07:39
 ;;3.0;CONSULT/REQUEST TRACKING;**1,7,29**;DEC 27, 1997
EN ; -- main entry point for GMRC REQUEST COMPLETE STAT
 K GMRCSVC,GMRCSVCP
 I $D(GMRCEACT),$L(GMRCEACT) D  I '$D(^GMR(123.5,$G(GMRCSVC),0)) D EXIT Q
 .S GMRCSVCP=GMRCEACT
 .S GMRCSVC=$O(^GMR(123.5,"B",GMRCSVCP,0))
 .Q:'$D(^GMR(123.5,$G(GMRCSVC),0))
 .;Build service array
 .S GMRCDG=GMRCSVC
 .D SERV1^GMRCASV
 .;Set date range to ALL
 .S GMRCDT1="ALL"
 .S GMRCDT2=0
 .D LISTDATE^GMRCSTU1(GMRCDT1,GMRCDT2,.GMRCEDT1,.GMRCEDT2)
 ;If no service ask for one
 I '$L($G(GMRCSVC)) D EN^GMRCSTU I $D(GMRCQUT) D EXIT Q
 ;Quit if no array of services
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 D EXIT Q
 ;
 D ODT^GMRCSTU Q:$D(GMRCQUT)
 D EN^VALM("GMRC REQUEST COMPLETE STAT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Number Of Days To Complete A Consult For Services Statistics."
 S VALMHDR(2)="FROM: "_$G(GMRCEDT1)_"   TO: "_$G(GMRCEDT2)
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=$G(GMRCCT),VALMBCK="R"
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("GMRCR",$J,"PRL"),^TMP("GMRCSVC",$J)
 K GMRCCT,GMRCSVC,GMRCEDT1,GMRCEDT2
 Q
 ;
EXPND ; -- expand code
 Q
 ;
PRNTONLY ;Option to just send the report to a device.
 ;Get the service and date range.
 N GMRCQUT,RETURN,GMRCDG,VALMBCK
 N GMRCDT1,GMRCDT2,GMRCEDT1,GMRCEDT2
 D EN^GMRCSTU
 I $D(GMRCQUT) D EXIT Q
 ;Quit if no array of services
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 D EXIT Q
 ;Get the device
 D PRNTASK^GMRCSTU
 I $D(GMRCQUT) D EXIT Q
 ;Create the report if not queued
 I '$D(IO("Q")) D ENOR^GMRCSTU(.RETURN,GMRCDG,GMRCDT1,GMRCDT2)
 ;Print the report
 D PRNTIT^GMRCSTU("PRL","PRNTQ^GMRCST","CONSULT/REQUEST PACKAGE PRINT COMPLETION TIME STATISTICS FROM OPTION")
 D EXIT
 Q
 ;
PRNTQ ;Print Queued report from ^TMP global then kill off ^TMP & ^XTMP
 ;Create the report
 N RETURN,INDEX
 D ENOR^GMRCSTU(.RETURN,GMRCDG,GMRCDT1,GMRCDT2)
 U IO
 S INDEX=""
 F  S INDEX=$O(^TMP("GMRCR",$J,TMPNAME,INDEX)) Q:INDEX=""  W ^TMP("GMRCR",$J,TMPNAME,INDEX,0),!
 K ^TMP("GMRCR",$J,TMPNAME),^XTMP("GMRCR",J,DOLLARH,"PRINT"),J,DOLLARH
 D ^%ZISC
 D EXIT
 Q
 ;
