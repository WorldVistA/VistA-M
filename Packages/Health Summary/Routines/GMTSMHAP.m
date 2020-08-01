GMTSMHAP ; SLC/WAT - PRINT/EXTRACT FOR HRMH APPOINTMENT COMPONENT INFO ;Apr 26, 2018@13:31
 ;;2.7;Health Summary;**99,67**;Oct 20, 1995;Build 538
 ;
 ;EXTERNAL CALLS
 ;REMINDER LOCATION LIST ^PXRMD(810.9  5599
 ;^SC("AST"   4482
 ;$$SDAPI^SDAMA301  4433
 ;$$FMTE^XLFDT  10103
 ;
 ;
 Q
 ;
EN ;MAIN
 K ^TMP($J,"GMTS CLIN LIST"),^TMP($J,"GMTS APPT")
 N CLINCNT S CLINCNT=1
 N RMLL,RMLLSTP,RMCLINIC,RMCLNCNT
 N GMTSARR,APCOUNT,PTDFN,APDATE,APPT,GMTSDTTM,CLINAME
 N TAB,LINE,IDX1
 S RMLL=$O(^PXRMD(810.9,"B","VA-MH NO SHOW APPT CLINICS LL",""))
 S RMCLNCNT=0,IDX1=0,RMCLINIC=""
 S TAB="   ",LINE=0
 I $G(RMLL)="" D LLERR Q  ;err and quit if RMLL not found
 F  S IDX1=$O(^PXRMD(810.9,RMLL,40.7,IDX1)) Q:IDX1'>0  D
 .S RMLLSTP=^PXRMD(810.9,RMLL,40.7,IDX1,0)
 .S RMLLSTP=$P($G(RMLLSTP),"^") ;->this is the stop code, now get clinics for this stop code
 .Q:$D(^SC("AST",RMLLSTP))=0
 .F  S RMCLINIC=$O(^SC("AST",RMLLSTP,RMCLINIC)) Q:RMCLINIC=""  D
 ..S ^TMP($J,"GMTS CLIN LIST",RMCLINIC)=RMCLINIC
 I '$D(^TMP($J,"GMTS CLIN LIST")) D CLINERR Q  ;err and quit if no clinics found
 ;CALL SDAPI ONCE FOR ALL CLINICS IN THE LIST
 S GMTSARR(1)=DT ;date filter, can be FROM DATE;TO DATE; DT will get ALL from Today Forward
 S GMTSARR(2)="^TMP($J,""GMTS CLIN LIST"""
 S GMTSARR(3)="R" ;appt status R=scheduled/kept, I=inpatient
 S GMTSARR(4)=DFN
 S GMTSARR("FLDS")="1;2;4;3"
 S GMTSARR("SORT")="P" ;implement sort to order appointments by appointment date
 S APCOUNT=$$SDAPI^SDAMA301(.GMTSARR)
 Q:APCOUNT<0  ;some other error from SD not already accounted for elsewhere
 I APCOUNT>0 D
 . S PTDFN=0 F  S PTDFN=$O(^TMP($J,"SDAMA301",PTDFN)) Q:PTDFN=""  D
 .. S APDATE=0 F  S APDATE=$O(^TMP($J,"SDAMA301",PTDFN,APDATE)) Q:APDATE=""  D
 ... S APPT=$G(^TMP($J,"SDAMA301",PTDFN,APDATE)) ;appointment data
 ... S GMTSDTTM=$P($G(APPT),"^",1) ;appointment date/time
 ... S CLINAME=$P($G(APPT),"^",2),CLINAME=$P(CLINAME,";",2) ;CLINIC NAME
 ... S ^TMP($J,"GMTS APPT",LINE)=$$FMTE^XLFDT(GMTSDTTM,"5ZP")_TAB_$G(CLINAME),LINE=LINE+1
 I APCOUNT'=0 K ^TMP($J,"SDAMA301")
 D:$D(^TMP($J,"GMTS APPT",0))>0 PRINT
 Q
 ;
PRINT ;print
 N LINE S LINE=""
 F  S LINE=$O(^TMP($J,"GMTS APPT",LINE)) D  Q:LINE=""
 .Q:LINE=""
 .D CKP^GMTSUP Q:$D(GMTSQIT)
 .W:LINE=0 ?2,^TMP($J,"GMTS APPT",LINE)
 .W:LINE>0 !,?2,^TMP($J,"GMTS APPT",LINE)
 W !
 Q
 ;
LLERR ;LL not found
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,?2,"Reminder location list not found. Unable to return appointment data.",!
 Q
CLINERR ;no clinics setup for LL
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,?2,"No matching clinics found. Unable to return appointment data.",!
 Q
