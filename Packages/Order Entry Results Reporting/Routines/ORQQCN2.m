ORQQCN2 ; slc/REV - Functions for GUI consult actions ;10/02/13  06:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,125,131,149,215,242,280,350**;Dec 17, 1997;Build 77
 ;
 ; DBIA 2426  SERV1^GMRCASV  ^TMP("GMRCSLIST,$J)
 ; DBIA 4576  $$VALID^GMRCAU
 ;
CMT(ORERR,ORIEN,ORCOM,ORALRT,ORALTO,ORDATE) ;Add comment to existing consult without changing status
 ;ORIEN - IEN of consult from File 123
 ;ORERR - return array for results/errors
 ;ORCOM is the comments array to be added
 ;     passed in as ORCOM(1)="Xxxx Xxxxx...",ORCOM(2)="Xxxx Xx Xxx...", ORCOM(3)="Xxxxx Xxx Xx...", etc.
 ;ORALRT - should alerts be sent to anyone?
 ;ORALTO - array of alert recipient IENs
 N ORAD,ORDUZ,ORNP,X
 S ORERR=0,ORAD=$S($D(ORDATE):ORDATE,1:$$NOW^XLFDT),ORNP=""
 I '$D(ORCOM) S ORERR="1^Comments required - no action taken" Q
 I '$D(^GMR(123,ORIEN)) S ORERR="1^No such consult" Q
 I $G(ORALRT)=1 D
 .F I=1:1  S X=$P(ORALTO,";",I) Q:X=""  S ORDUZ(X)=""
 D CMT^GMRCGUIB(ORIEN,.ORCOM,.ORDUZ,ORAD,DUZ)
 Q
 ;
SCH(ORERR,ORIEN,ORNP,ORDATE,ORALRT,ORALTO,ORCOM) ;Schedule consult and change status
 ;ORERR - return array for results/errors
 ;ORIEN - IEN of consult from File 123
 ;ORNP - Provider who Scheduled consult
 ;ORDATE - Date/Time Consult was scheduled.
 ;ORALRT - should alerts be sent to anyone?
 ;ORALTO - array of alert recipient IENs
 ;ORCOM is the comments array to be added
 ;     passed in as ORCOM(1)="Xxxx Xxxxx...",ORCOM(2)="Xxxx Xx Xxx...", ORCOM(3)="Xxxxx Xxx Xx...", etc.
 N ORAD,ORDUZ,X
 S ORERR=0,ORAD=$S($D(ORDATE):ORDATE,1:$$NOW^XLFDT)
 S:+$G(ORNP)=0 ORNP=DUZ
 I '$D(^GMR(123,ORIEN)) S ORERR="1^No such consult" Q
 I $G(ORALRT)=1 D
 .F I=1:1  S X=$P(ORALTO,";",I) Q:X=""  S ORDUZ(X)=""
 S ORERR=$$SCH^GMRCGUIB(ORIEN,ORNP,ORAD,.ORDUZ,.ORCOM)
 Q
 ;
SVCTREE(Y,PURPOSE) ;Returns list of consult service for current
 ;  context, screening for inactive, groupers, and tracking
 ; PURPOSE: Display=0, Forward=1, Order=1
 N GMRCTO,GMRCDG,GMRCSVC,GMRCOI
  S GMRCTO=PURPOSE,GMRCDG=1
 D SERV1^GMRCASV
 S GMRCSVC=0
 I '$D(^TMP("GMRCSLIST",$J)) S Y(1)="-1^No services found" Q  ;DBIA 2426
 F I=1:1  S GMRCSVC=$O(^TMP("GMRCSLIST",$J,GMRCSVC)) Q:+GMRCSVC=0  D
 . S Y(I)=^TMP("GMRCSLIST",$J,GMRCSVC)
 . S GMRCOI=$O(^ORD(101.43,"ID",$P(Y(I),U,1)_";99CON",0))
 . S Y(I)=Y(I)_U_GMRCOI
 Q
 ;
SVCSYN(ORROOT,ORSTRT,ORWHY,ORSYN,ORIEN) ;;return CSLT services for GUI
 ;Input:
 ; ORROOT - passed in as the array to return results in
 ; ORSTRT- service to begin building from
 ; ORWHY - 0 for display, 1 for forwarding or ordering
 ; ORSYN - Boolean: 1=return synonyms, 0=do not
 ; ORIEN - Consult IEN (file 123) (OPTIONAL)
 ;Output: Array formatted as follows-
 ;      svc ien^svc name or syn^parent^has children^svc usage^orderable item
 N ORSVC,I,X,OI
 S:+$G(ORSTRT)=0 ORSTRT=1
 S:$G(ORWHY)="" ORWHY=1
 S:$G(ORSYN)="" ORSYN=1
 S ORROOT=$NA(^TMP("ORCSLT",$J))
 D GUI^GMRCASV1(ORROOT,ORSTRT,ORWHY,ORSYN,$G(ORIEN))
 S ORSVC=0
 I '$D(@ORROOT) S @ORROOT@(1)="-1^No services found" Q
 F I=1:1  S ORSVC=$O(@ORROOT@(ORSVC)) Q:+ORSVC=0  D
 . S X=@ORROOT@(ORSVC)
 . S OI=$O(^ORD(101.43,"ID",$P(X,U,1)_";99CON",0))
 . I +OI>0 S @ORROOT@(ORSVC)=X_U_OI
 Q
STATUS(Y) ; Returns a list of statuses currently in use
 ;
 N GMRCORST
 S GMRCORST=0,Y(999)="999^OTHER^"
 F  S GMRCORST=$O(^ORD(100.01,GMRCORST)) Q:'+GMRCORST  D
 . I '$D(^GMR(123.1,"AC",GMRCORST)) S Y(999)=Y(999)_GMRCORST_"," Q
 . Q:$$SCREEN^XTID(100.01,,GMRCORST_",")  ;inactive VUID
 . S Y(GMRCORST)=GMRCORST_U_$P(^ORD(100.01,GMRCORST,0),U,1)
 Q
 ;
MEDRSLT(ORY,GMRCO) ;Returns Medicine results plus TIU results
 S ORY=$NA(^TMP("ORRSLT",$J))
 D RT^GMRCGUIA(GMRCO,ORY)
 Q
 ;
SHOW513(ORY,GMRCO)  ;CONSULTS SF513 DISPLAY IN GUI
 D GUI^GMRCP5(.ORY,GMRCO)
 Q
PRT513(Y,GMRCO,GMRCCHT,GMRCDEV) ; Print SF513 to VistA device from GUI
 N ORSTATUS
 D EN^GMRCP5(GMRCO,GMRCCHT,GMRCDEV,.ORSTATUS)
 S Y=ORSTATUS
 Q
WPRT513(ORY,GMRCO,GMRCCHT) ;Print SF513 to Windows device from GUI
 N ZTQUEUED,ORHFS,ORSUB,ORIO,ORSTATUS,ROOT,ORHANDLE
 N IOM,IOSL,IOST,IOF,IOT,IOS
 S (ORSUB,ROOT)="ORDATA",ORIO="OR WINDOWS HFS",ORHANDLE="ORQQCN2"
 S ORY=$NA(^TMP(ORSUB,$J,1))
 S ORHFS=$$HFS^ORWRP()
 D HFSOPEN^ORWRP(ORHANDLE,ORHFS,"W")
 I POP D  Q
 . I $D(ROOT) D SETITEM^ORWRP(.ROOT,"ERROR: Unable to open HFS file for SF513 print")
 D IOVAR^ORWRP(.ORIO,,,"P-WINHFS80")
 N $ETRAP,$ESTACK
 S $ETRAP="D ERR^ORWRP Q"
 U IO
 D PRNT^GMRCP5A(GMRCO,0,0,GMRCCHT,0)
 D HFSCLOSE^ORWRP(ORHANDLE,ORHFS)
 Q
SIGFIND(Y,ORIEN,ORFL,ORCOM,ORALRT,ORALTO,ORDATE) ;Significant findings
 S Y=$$SFILE^GMRCGUIB(ORIEN,4,ORFL,"",DUZ,.ORCOM,ORALRT,ORALTO,ORDATE) ; "4"=SIG FIND ACTION
 Q
ADMCOMPL(Y,ORIEN,ORFL,ORCOM,ORRESP,ORALRT,ORALTO,ORDATE) ; Admin users
 ; Administrative complete action
 S Y=$$SFILE^GMRCGUIB(ORIEN,10,ORFL,ORRESP,DUZ,.ORCOM,ORALRT,ORALTO,ORDATE) ; "10"=Admin Complete
 Q
SVCLIST(ORY,FROM,DIR) ; Return a set of consult services in long list format
 ; .ORY=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT,Y,ORTMP,ORSVC,ORSTR
 S I=0,CNT=44,ORSVC=""
 D SVCTREE^ORQQCN2(.Y,1)
 F I=1:1  S ORSVC=$P($G(Y(I)),U,2) Q:ORSVC=""  D
 . S ORTMP(ORSVC)=Y(I)
 F I=1:1  Q:I=CNT  S FROM=$O(ORTMP(FROM),DIR) Q:FROM=""  D
 . S ORSTR=ORTMP(FROM)
 . S ORY(I)=ORSTR
 Q
GETCTXT(Y,ORUSER) ; Returns current view context for user
 S Y=$$GET^XPAR("ALL","ORCH CONTEXT CONSULTS",1)
 Q
SAVECTXT(Y,ORCTXT) ; Save new view preferences for user
 N TMP
 S TMP=$$GET^XPAR(DUZ_";VA(200,","ORCH CONTEXT CONSULTS",1)
 I TMP'="" D  Q
 . D CHG^XPAR(DUZ_";VA(200,","ORCH CONTEXT CONSULTS",1,ORCTXT)
 D ADD^XPAR(DUZ_";VA(200,","ORCH CONTEXT CONSULTS",1,ORCTXT)
 Q
 ;
DEFRFREQ(ORY,ORSVC,ORDFN,RESOLVE) ;Return default reason for request for service
 ; ORSVC=pointer to file 123.5
 ; ORDFN=patient, if RESOLVE=1
 ; RESOLVE=1 to resolve boilerplate, 0 to not resolve
 Q:+$G(ORSVC)=0
 I +RESOLVE,(+$G(ORDFN)=0) Q
 S ORY=$NA(^TMP("ORREQ",$J))
 S:$G(RESOLVE)="" RESOLVE=0
 D GETDEF^GMRCDRFR(.ORY,ORSVC,ORDFN,RESOLVE)
 K @ORY@(0)
 Q
EDITDRFR(ORY,ORSVC) ; Allow editing of reason for request?
 S ORY=$$REAF^GMRCDRFR(ORSVC)
 Q
SVCIEN(ORY,ORIEN) ;Given orderable item file entry, return IEN in 123.5, OR -1 IF INACTIVE IN 101.43
 N X1
 I '$D(^ORD(101.43,ORIEN)) S ORY=-1 Q
 S X1=$G(^ORD(101.43,ORIEN,.1))
 I +X1,+X1<$$NOW^XLFDT S ORY=-1 Q
 S ORY=$P($$USID^ORWDXC(ORIEN),U,4)
 Q
PROVDX(ORY,ORIEN) ;Return provisional dx prompting info for service
 S ORY=$$PROVDX^GMRCUTL1(ORIEN)
 Q
PREREQ(ORY,ORSVC,ORDFN) ;Returns prequisites for ordering
 Q:(+$G(ORSVC)=0)!(+$G(ORDFN)=0)
 S ORY=$NA(^TMP("ORPREREQ",$J))
 D PREREQ^GMRCUTL1(.ORY,ORSVC,ORDFN,0)  ;0=RESOLVE OBJECTS
 K @ORY@(0)
 Q
UNRSLVD(ORY,ORDFN) ;Returns true if unresolved consults for user/pt
 ;S ORY=0
 ;Q:+$$GET^XPAR("ALL","ORWOR SHOW CONSULTS",1,"I")=0
 ;S ORY=+$$ANYPENDG^GMRCTIU(ORDFN,DUZ)   ;DBIA #3473
 ;Q
 S $P(ORY,U,1)=+$$ANYPENDG^GMRCTIU(ORDFN,DUZ)   ;DBIA #3473
 S $P(ORY,U,2)=+$$GET^XPAR("ALL","ORWOR SHOW CONSULTS",1,"I")
 Q
ISPROSVC(ORY,GMRCIEN) ; IS THIS SERVICE PART OF CONSULTS-PROSTHETICS INTERFACE, wat/OR*3*280
 ;GMRCIEN - IEN of selected service
 I $G(^GMR(123.5,$G(GMRCIEN),"INT"))=1 S ORY=1
 Q
VALID(ORY,GMRCIEN,ORDUZ,ORIFC) ;Return users update authority for a consult
 ;ORIFC - If received, will include check for IFC Coordinator
 I +$G(GMRCIEN)=0 S ORY="-1^Consult Service Required" Q
 I +$G(ORDUZ)=0 S ORDUZ=DUZ
 I $G(ORIFC)="" S ORIFC=0
 S ORY=$$VALID^GMRCAU(GMRCIEN,,ORDUZ,,ORIFC)   ;DBIA #4576
 I ORY="" S ORY=0
 Q
