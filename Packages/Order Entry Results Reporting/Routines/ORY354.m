ORY354 ;DJE-Search for anticoag patients with blank notes ;06/20/13  09:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**354**;Jun 20, 2013;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 ;
 I $G(DUZ)="" W "Your DUZ is not defined.",! Q
 N ZTDESC,ZTIO,ZTRTN,ZTSK,ZTSAVE
TASK S ZTRTN="EN^ORY354",ZTIO=""
 S ZTDESC="Check for anticoag patients with blank notes"
 D ^%ZTLOAD
 W !!,"The check for anticoag patients with blank notes is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
 ;
EN ; -- tasked entry point
 S:$D(ZTQUEUED) ZTREQ="@"
 N CREAT,EXPR,DFN,DOCTYPE,SIGDT,NOTEID,COUNTER
 D NOW^%DTC S CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0) K ^XTMP("ORY354")
 S COUNTER=0,DFN=0 F  S DFN=$O(^ORAM(103,DFN)) Q:'DFN  D  ;loop anticoag patients
 . S SIGDT=0 F  S SIGDT=$O(^TIU(8925,"APTP",DFN,SIGDT)) Q:'SIGDT  D  ;loop signed notes index
 .. S NOTEID=0 F  S NOTEID=$O(^TIU(8925,"APTP",DFN,SIGDT,NOTEID)) Q:'NOTEID  D
 ... I $D(^TIU(8925,NOTEID,"TEXT")) Q  ;Not empty, quit
 ... I $G(^TIU(8925,NOTEID,0))="" Q  ;Bad index, quit
 ... ;set node to NAME^NOTE TITLE^NOTE DATE
 ... S COUNTER=COUNTER+1,^XTMP("ORY354",COUNTER)=$P(^DPT(DFN,0),U)_"^"_$$PNAME^TIULC1(+^TIU(8925,NOTEID,0))_"^"_$$FMTE^XLFDT($P(^TIU(8925,NOTEID,13),U),"D")
 I $D(^XTMP("ORY354")) S ^XTMP("ORY354",0)=EXPR_"^"_CREAT
 D SEND
 K ZTQUEUED,ZTREQ Q
SEND ;Send message
 K ORMSG,XMY N OCNT,COUNTER,XMDUZ,XMSUB,XMTEXT,REC
 S XMDUZ="CPRS, SEARCH",XMSUB="ANTICOAG PATIENTS WITH BLANK NOTES",XMTEXT="ORMSG(",XMY(DUZ)=""
 S ORMSG(1,0)="  The check for  anticoag patients with blank notes is complete."
 S ORMSG(2,0)=" ",ORMSG(3,0)="  Here is the list of the affected patients: ",ORMSG(4,0)=" "
 S NOTEID=0,ORMSG(5,0)="Patient                        Note Title                     Note Date",OCNT=5
 I '$D(^XTMP("ORY354")) S ORMSG(6,0)="No notes found."
 S OCNT=5,COUNTER=0 F  S COUNTER=$O(^XTMP("ORY354",COUNTER)) Q:'COUNTER  D
 . S REC=^XTMP("ORY354",COUNTER) S OCNT=OCNT+1,ORMSG(OCNT,0)=$$BUF30($P(REC,U,1))_" "_$$BUF30($P(REC,U,2))_" "_$P(REC,U,3)
 D ^XMD
 Q
BUF30(X) ;Buffer and limit text to 30 characters
 S $P(X," ",30)=" " ;add 30 spaces to end of text
 Q $E(X,1,30) ;return first 30 characters of text
