GMRCIBKG ;SLC/JFR - IFC BACKGROUND ERROR PROCESSOR; 07/02/03 13:54
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,30,35,58**;DEC 27, 1997;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine invokes IA# 3335
 ;
EN ;process file 123.6 and take action
 ;Start background process
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; OK to run?
 I '$$GONOGO Q
 ;
 ; set start param to NOW and run
 D EN^XPAR("SYS","GMRC IFC BACKGROUND START",1,$$NOW^XLFDT)
 ;
 N GMRCLOG,GMRCTIM,GMRCLOG0
 S GMRCLOG=0
 S GMRCTIM=$$FMADD^XLFDT($$NOW^XLFDT,,-1)
 F  S GMRCLOG=$O(^GMR(123.6,GMRCLOG)) Q:'GMRCLOG  D
 . S GMRCLOG0=$G(^GMR(123.6,GMRCLOG,0))
 . ;
 . ;  v-- resend if couldn't update file immediately
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=901 D  Q
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ;  v-- wait at least 1 hour on all other errors
 . I $P(GMRCLOG0,U)>GMRCTIM Q
 . ;  v-- if incomplete activity is now the earliest, resend it
 . I $P(GMRCLOG0,U,6),$P(GMRCLOG0,U,8)=902 D  Q
 .. Q:$O(^GMR(123.6,"AC",$P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)),-1)
 .. D DELALRT(GMRCLOG)
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ; v-- delete complete entries after # in GMRC RETAIN IFC ACTIVITY DAYS
 . I '$P(GMRCLOG0,U,6) D  Q
 .. N DIK,DA,GMRCRETN
 .. S GMRCRETN=$$GET^XPAR("SYS","GMRC RETAIN IFC ACTIVITY DAYS",1)
 .. I 'GMRCRETN S GMRCRETN=7
 .. I $P(GMRCLOG0,U)>$$FMADD^XLFDT(GMRCTIM,(0-GMRCRETN)) Q  ;don't delete
 .. S DIK="^GMR(123.6,",DA=GMRCLOG
 .. D ^DIK ;remove old completed entries
 . ;
 . ;  v-- resend unknown patient errors after 3 hours
 . I $P(GMRCLOG0,U,8)=201,GMRCLOG0<$$FMADD^XLFDT($$NOW^XLFDT,,-3) D  Q
 .. N GMRCSND,GMRCPAR,DOW
 .. S GMRCPAR=$$GET^XPAR("SYS","GMRC IFC SKIP WEEKEND RE-TRANS",1)
 .. S DOW=$$DOW^XLFDT(DT,1)
 .. S GMRCSND=$S('GMRCPAR:1,(+DOW&(DOW<6)):1,1:0)
 .. I GMRCSND D  ;re-send based on parameter and day of week
 ... D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 ... D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5))
 .. I '($P(GMRCLOG0,U,7)#8),GMRCSND D
 ... ;alert CAC's about errors every 24 hrs.
 ... D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 ... D SNDALRT^GMRCIERR(GMRCLOG,"C") ; alert CAC's to patient errors
 ... D  ; send mail to remote CAC group
 .... N GMRCLNK,GMRCIQT,HL,HLECH,HLFS,HLQ,PID,DOM,STA,GMRCLNK,OBR
 .... D INIT^HLFNC2("GMRC IFC ORM EVENT",.HL)
 .... D  I $D(GMRCIQT) Q  ;build PID seg if nat'l ICN
 ..... N GMRCDFN S GMRCDFN=$P(^GMR(123,+$P(GMRCLOG0,U,4),0),U,2)
 ..... I '$G(GMRCDFN) S GMRCIQT=1 Q
 ..... I $$GETICN^MPIF001(GMRCDFN)<1 S GMRCIQT=1 Q
 ..... I $$IFLOCAL^MPIF001(GMRCDFN) S GMRCIQT=1 Q
 ..... S PID=$$EN^VAFCPID(GMRCDFN,"1,2,3,4,5,7,8,19")
 ..... S PID=$P(PID,"|",2,999)
 .... D LINK^HLUTIL3($P(GMRCLOG0,U,2),.GMRCLNK)
 .... S GMRCLNK=$O(GMRCLNK(0)) I 'GMRCLNK Q  ;no link set up
 .... S DOM=$$GET1^DIQ(870,+GMRCLNK,.03)
 .... S STA=$$STA^XUAF4($P(GMRCLOG0,U,2))
 .... S OBR=$E($$OBR^GMRCISG1(+$P(GMRCLOG0,U,4),+$P(GMRCLOG0,U,5)),5,999)
 .... N DIV S DIV=STA,STA=+$$SITE^VASITE
 .... D PTERRMSG^GMRCIERR(PID,STA,DOM,OBR)
 . ;
 . ;  v-- resend local ICN errors after 3 hours
 . I $P(GMRCLOG0,U,8)=202,GMRCLOG0<$$FMADD^XLFDT($$NOW^XLFDT,,-3) D  Q
 .. ;re-send based on parameter and day of week
 .. N GMRCSND,GMRCPAR,DOW
 .. S GMRCPAR=$$GET^XPAR("SYS","GMRC IFC SKIP WEEKEND RE-TRANS",1)
 .. S DOW=$$DOW^XLFDT(DT,1)
 .. S GMRCSND=$S('GMRCPAR:1,(+DOW&(DOW<6)):1,1:0)
 .. I 'GMRCSND Q  ;don't re-send activity
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 .. I '($P(GMRCLOG0,U,7)#8) D  ;alert CAC's about errors every 24 hrs 
 ... D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 ... D SNDALRT^GMRCIERR(GMRCLOG,"C") ; alert CAC's to patient errors
 . ;  v-- re-process implementation errors
 . ;I $P(GMRCLOG0,U,8)>300,$P(GMRCLOG0,U,8)<702 D  Q
 . I $P(GMRCLOG0,U,8)>300,$P(GMRCLOG0,U,8)<704 D  Q
 .. D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 .. D TRIGR^GMRCIEVT($P(GMRCLOG0,U,4),$P(GMRCLOG0,U,5)) ;re-send activity
 . ;  v-- if incomplete and no error, alert tech group
 . I '$P(GMRCLOG0,U,8)!($P(GMRCLOG0,U,8)>902) D  Q
 .. D DELALRT(GMRCLOG) ;delete previous alerts on same transaction
 .. D SNDALRT^GMRCIERR(GMRCLOG,"T")
 . Q
 ;
 ;  v-- set finish param 
 D EN^XPAR("SYS","GMRC IFC BACKGROUND FINISH",1,$$NOW^XLFDT)
 ;  v-- start it again one hour after completing
 D REQUEUE
 Q
 ;
REQUEUE ;task job to start up again one hour after completing
 N ZTRTN,ZTSK,ZTIO,ZTDESC,ZTDTH
 S ZTDESC="IF Consults background error processor"
 S ZTIO=""
 S ZTRTN="EN^GMRCIBKG"
 S ZTDTH=$$FMTH^XLFDT($$FMADD^XLFDT($$NOW^XLFDT,,1))
 D ^%ZTLOAD
 Q
DELALRT(MSGLOG) ;delete obsolete alerts for an entry
 ; Input:
 ;   MSGLOG = ien from file 123.6
 ;
 N XQAID,XQAKILL
 S XQAID="GMRCIFC,trans error,"_MSGLOG,XQAKILL=0
 D DELETEA^XQALERT
 Q
 ;
OVERDUE ; write message for alert to tell IRM job is overdue
 W @IOF
 W !,"The Inter-facility Consults background job is overdue."
 W !,"This is likely due to an error while the job runs. It is suggested"
 W !,"that you check the systems for errors. If the errors are resolved"
 W !,"the background job will catch up and run normally. There is a "
 W !,"remote possibility that the GMRC IFC BACKGROUND... parameters have"
 W !,"been edited and are out of synch."
 S XQAKILL=0
 Q
 ;
GONOGO() ; determine if background job should run or not
 ;Output: 
 ;  1 = go ahead and run
 ;  0 = don't run for some reason
 N GMRCQT
 S GMRCQT=1
 D
 . N GMRCBST,GMRCNOW,GMRCBFI
 . S GMRCBST=$$GET^XPAR("SYS","GMRC IFC BACKGROUND START",1)
 . I 'GMRCBST Q  ; has never run or needs to
 . S GMRCNOW=$$NOW^XLFDT
 . I GMRCBST>GMRCNOW S GMRCQT=0 Q  ;set to future date/time - don't run
 . S GMRCBFI=$$GET^XPAR("SYS","GMRC IFC BACKGROUND FINISH",1)
 . I $$FMDIFF^XLFDT(GMRCNOW,GMRCBFI,2)<3600,GMRCBFI>GMRCBST S GMRCQT=0 Q
 . ;                 ^--ran < 1 hr ago
 . I $$FMDIFF^XLFDT(GMRCBST,GMRCBFI,2)>4500 D  Q
 .. ; >1.5 hrs and job not finishing for some reason, alert techies
 .. N XQA,XQAMSG,XQAROU,XQAID,XQAKILL
 .. S XQAID="GMRC IFC BKG",XQAKILL=0 D DELETEA^XQALERT
 .. S XQA("G.IFC TECH ERRORS")=""
 .. S XQAMSG="IFC Background job overdue."
 .. S XQAID="GMRC IFC BKG"
 .. S XQAROU="OVERDUE^GMRCIBKG"
 .. D SETUP^XQALERT
 .. Q
 . Q
 Q GMRCQT
