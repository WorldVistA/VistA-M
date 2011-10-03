GMRCIBKM ;SLC/JFR - MONITOR IFC BKG PARAMS ; 2/14/02 21:22
 ;;3.0;CONSULT/REQUEST TRACKING;**22**;DEC 27, 1997
EN ; -- main entry point for GMRC IFC MONITOR BKG JOB
 D REFRESH
 D EN^VALM("GMRC IF MONITOR BKG JOB")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Inter-facility Consults background job parameter display"
 Q
 ;
BLD ; Build list for LM display
 N GMRCBST,GMRCNOW,GMRCBFI,CNT,GMRCBSTE,GMRCBFIE,TXT
 K ^TMP("GMRCBK",$J)
 S GMRCNOW=$$NOW^XLFDT
 S GMRCBST=$$GET^XPAR("SYS","GMRC IFC BACKGROUND START",1)
 S GMRCBSTE=$S($G(GMRCBST):$$FMTE^XLFDT(GMRCBST),1:"Unknown")
 S GMRCBFI=$$GET^XPAR("SYS","GMRC IFC BACKGROUND FINISH",1)
 S GMRCBFIE=$S($G(GMRCBFI):$$FMTE^XLFDT(GMRCBFI),1:"Unknown")
 S ^TMP("GMRCBK",$J,1,0)=""
 I GMRCBST>GMRCNOW S TXT(2)="The IFC background job is delayed until: "
 I '$D(TXT(2)) S TXT(2)="The IFC background job last started:     "
 S ^TMP("GMRCBK",$J,2,0)=TXT(2)_GMRCBSTE
 S TXT(3)="The IFC background job last finished:    "
 S ^TMP("GMRCBK",$J,3,0)=TXT(3)_GMRCBFIE
 S ^TMP("GMRCBK",$J,4,0)=""
 I GMRCBST>GMRCNOW  D  Q
 . S ^TMP("GMRCBK",$J,5,0)="The start parameter for this job has been "
 . S ^TMP("GMRCBK",$J,6,0)="intentionally set to a future date/time."
 . S ^TMP("GMRCBK",$J,7,0)=""
 . S ^TMP("GMRCBK",$J,8,0)="The background job will not start until the "
 . S ^TMP("GMRCBK",$J,9,0)="date/time indicated in this parameter"
 I $$FMDIFF^XLFDT(GMRCBST,GMRCBFI,2)>4500 D  Q
 . S ^TMP("GMRCBK",$J,5,0)="The background job is overdue."
 . S ^TMP("GMRCBK",$J,6,0)="IRMS should review the system for errors"
 . S ^TMP("GMRCBK",$J,7,0)="related to the IFC background job."
 . S ^TMP("GMRCBK",$J,8,0)=" "
 . S ^TMP("GMRCBK",$J,9,0)="If errors can not be resolved, contact NVS"
 . S ^TMP("GMRCBK",$J,10,0)="for assistance."
 I GMRCNOW>GMRCBST,$$FMDIFF^XLFDT(GMRCNOW,GMRCBST,2)>4500 D  Q
 . S ^TMP("GMRCBK",$J,5,0)="The background job is overdue."
 . S ^TMP("GMRCBK",$J,6,0)="IRMS should review the system for errors"
 . S ^TMP("GMRCBK",$J,7,0)="related to the IFC background job."
 . S ^TMP("GMRCBK",$J,8,0)=" "
 . S ^TMP("GMRCBK",$J,9,0)="If errors can not be resolved, contact NVS"
 . S ^TMP("GMRCBK",$J,10,0)="for assistance."
 D  ; all is well
 . S ^TMP("GMRCBK",$J,5,0)="The IFC background job is on schedule or is"
 . S ^TMP("GMRCBK",$J,6,0)="running. "
 . S ^TMP("GMRCBK",$J,7,0)=""
 . S ^TMP("GMRCBK",$J,8,0)="It may be delayed by editing the start time"
 . S ^TMP("GMRCBK",$J,9,0)="to a future date/time using the Edit start "
 . S ^TMP("GMRCBK",$J,10,0)="time action."
 Q
 ;
EDSTRT ; edit the start parameter
 ;
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT,GMRCLATE,GMRCSTRT
 D FULL^VALM1
 S GMRCLATE=$$FMADD^XLFDT($$NOW^XLFDT,4)
 S GMRCSTRT=$$GET^XPAR("SYS","GMRC IFC BACKGROUND START",1)
 S DIR(0)="D0A^"_DT_":"_GMRCLATE_":ETSR"
 S DIR("A",1)=""
 S DIR("A")="Next date/time the IFC background job should run: "
 S DIR("B")=$$FMTE^XLFDT(GMRCSTRT)
 D ^DIR
 I '+Y S VALMBCK="R" Q
 D EN^XPAR("SYS","GMRC IFC BACKGROUND START",1,Y)
 D REFRESH
 Q
 ;
REFRESH ; rebuild list
 D BLD
 S VALMBCK="R",VALMCNT=$O(^TMP("GMRCBK",$J," "),-1)
 S VALMBG=1
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("GMRCBK",$J)
 S VALMBCK="Q"
 Q
 ;
