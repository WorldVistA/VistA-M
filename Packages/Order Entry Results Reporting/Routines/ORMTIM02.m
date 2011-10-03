ORMTIM02 ; JM/SLC-ISC - PERFORM MISC TIME BASED ACTIVITIES ;05/02/06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**253,243**;Dec 17, 1997;Build 242
 ;
 Q
MISC ; Perform misc time based activities
 ;
 D UNSIGNED ; Generate alerts for unsigned orders that have slipped through the cracks
 D INIT^ORWGTASK(0) ; check to run rebuild of cache for graphing
 ;
 Q
 ;
UNSIGNED ; Generate alerts for unsigned orders that were not alerted by CPRS
 ; This happens when CPRS crashes - through network connection drops or other causes
 N ORZPAT,ORZDATE,ORZIEN,ORZSUB,ORZSDATE,%DT,X,Y,ORZTIME,ORZNOW,ORZPURGE
 N ORN,ORBDFN,ORNUM,ORBADUZ,ORBPMSG,ORBPDATA,ORZREC8,ORZSIGDT,ORZSTS,ORZWHEN,ORMARKID
 N MINTIME,XTMPDAYS,XTMPHOUR,MINDAYS
 S ORN=12,ORMARKID="ORMTIME_UNSGNORD"
 ;
 S MINTIME=60 ; Order must be unsigned for 60 Minutes before generating an alert
 S MINDAYS=90 ; Order must have been generated within the last 90 days
 ;
 S XTMPDAYS=10 ; Keep ^XTMP record for 10 days - reset timeframe with each run
 S XTMPHOUR=48 ; Each order that's verified as having generated an alert has a flag set in
 ;               ^XTMP that's kept for 48 hours.  When flag is gone, must recheck alert status
 ;
 S X="T-"_MINDAYS
 D ^%DT S ORZSDATE=9999999-Y
 S %DT="ST",X="NOW" D ^%DT
 S ORZNOW=Y
 S ORZTIME=$$FMADD^XLFDT(ORZNOW,0,0,-MINTIME,0) ; Order must have existed for ORZTIME minutes
 S ORZPURGE=$$FMADD^XLFDT(ORZNOW,XTMPDAYS,0,0,0) ; Purge all marked flags if not run in XTMPDAYS days
 S ^XTMP(ORMARKID,0)=ORZPURGE_U_ORZNOW_U_"Unsigned Orders Reviewed by ORMTIME"
 S ORZPURGE=$$FMADD^XLFDT(ORZNOW,0,XTMPHOUR,0,0) ; Purge each marked flag XTMPHOUR hours after creation
 K MINTIME,MINDAYS,XTMPDAYS,XTMPHOUR,X,Y,%DT ; Kill non-namespaced vars
 S ORZPAT="" F  S ORZPAT=$O(^OR(100,"AS",ORZPAT)) Q:'ORZPAT  D
 . Q:$P(^DPT(+ORZPAT,0),U,21)  ; Quit if test patient
 . S ORZDATE=0 F  S ORZDATE=$O(^OR(100,"AS",ORZPAT,ORZDATE)) Q:'ORZDATE  I ORZDATE<ORZSDATE D
 . . S ORZIEN=0 F  S ORZIEN=$O(^OR(100,"AS",ORZPAT,ORZDATE,ORZIEN)) Q:'ORZIEN  D
 . . . S ORZSUB=0 F  S ORZSUB=$O(^OR(100,"AS",ORZPAT,ORZDATE,ORZIEN,ORZSUB)) Q:'ORZSUB  D
 . . . . I $D(^OR(100,ORZIEN,8,ORZSUB,0)) D
 . . . . . S ORZREC8=^OR(100,ORZIEN,8,ORZSUB,0)
 . . . . . S ORZSIGDT=$P(ORZREC8,U,6) I $L(ORZSIGDT)>0 Q  ; Can't have a sign date/time
 . . . . . S ORZSTS=$P(ORZREC8,U,4) I ORZSTS'=2 Q  ; must be in an unsigned state
 . . . . . S ORZWHEN=$P(ORZREC8,U) I ORZWHEN>ORZTIME Q  ; must have been unsigned for MINTIME
 . . . . . S ORBDFN=+ORZPAT
 . . . . . S ORNUM=ORZIEN_";"_ORZSUB
 . . . . . I $$NEEDALRT($P(ORZREC8,U,3),ORBDFN,ORNUM) D  ; must not have already generated an alert
 . . . . . . S (ORBADUZ,ORBPMSG,ORBPDATA)=""
 . . . . . . D DOALERT^ORB3
 . . . . . . D MARK(ORNUM) ; Alert sent, don't send another one
 D CLEAN
 Q
 ;
NEEDALRT(PROVIDER,DFN,ORNUM) ; Returns true if order needs an alert
 ;
 I $$MARKED(ORNUM) Q 0 ; If already checked, return
 ;
 N RESULT,SUROGATE
 S RESULT=1
 I $$HASALERT(PROVIDER,DFN) S RESULT=0 I 1
 E  D
 . S SUROGATE=$P($$GETSURO^XQALSURO(PROVIDER),U,1)
 . I +SUROGATE,$$HASALERT(SUROGATE,DFN) S RESULT=0
 I 'RESULT D MARK(ORNUM)
 Q RESULT
 ;
HASALERT(USER,PATIENT) ; Returns true if alert exists for user and patient
 N RESULT,ALERTID,DATE
 S RESULT=0,ALERTID="OR,"_PATIENT_",12"
 I $D(^XTV(8992,"AXQAN",ALERTID,USER)) D  ;DBIA# 2689
 . S DATE=$O(^XTV(8992,"AXQAN",ALERTID,USER,0))
 . I $G(DATE)>0 S RESULT=1
 Q RESULT
 ;
MARKED(ORNUM) ; Returns true if the order has been marked as not needing an alert
 I $D(^XTMP(ORMARKID,"A",ORNUM))>0 Q 1
 Q 0
 ; 
MARK(ORNUM) ; Marks an order as already having been alerted
 S ^XTMP(ORMARKID,"A",ORNUM)=""
 S ^XTMP(ORMARKID,"B",ORZPURGE,ORNUM)=""
 Q
CLEAN ; Clean up old entries in ^XTMP
 N IDX,ORNUM
 S IDX=0
 F  S IDX=$O(^XTMP(ORMARKID,"B",IDX)) Q:((+IDX=0)!(IDX>ORZNOW))  D
 . S ORNUM=0
 . F  S ORNUM=$O(^XTMP(ORMARKID,"B",IDX,ORNUM)) Q:+ORNUM=0  D
 . . K ^XTMP(ORMARKID,"A",ORNUM)
 . . K ^XTMP(ORMARKID,"B",IDX,ORNUM)
 Q
