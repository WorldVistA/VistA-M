GMRCIEVT ;SLC/JFR - process events and build HL7 message; 1/27/03 09:23
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,31**;DEC 27, 1997
 ;
 Q  ;don't start at the top
TRIGR(IEN,ACTN) ;determine what action was taken on IFC and call event point
 ;Input: 
 ;  IEN   = consult number from file 123
 ;  ACT   = ien in 40 multiple corresponding to activity
 ;
 N ACTYPE
 S ACTYPE=$P(^GMR(123,IEN,40,ACTN,0),U,2)
 I 'ACTYPE Q
 I ACTYPE=26 Q  ;don't send admin corrections yet...
 ;
 ; check bkgrd job and run if overdue
 I '$D(ZTQUEUED),$$GONOGO^GMRCIBKG D
 . N ZTQUEUED S ZTQUEUED=1 D EN^GMRCIBKG ;remove ZTQUEUED? 
 ;
 I $O(^GMR(123.6,"AC",IEN,ACTN),-1) D  Q  ;earlier pending activities
 . I ACTYPE=22 Q  ; not a trigger or not done here
 . I ACTYPE=6 N GMRCQT D  I $D(GMRCQT) Q
 .. ;complete all transactions if IFC DC'd before request ever sent 
 .. I $O(^GMR(123.6,"AC",IEN,ACTN),-1)'=1 Q  ;new request already sent
 .. S GMRCQT=1
 .. N DA,DIE,DR,GMRCACTS
 .. S GMRCACTS=0
 .. F  S GMRCACTS=$O(^GMR(123.6,"AC",IEN,GMRCACTS)) Q:'GMRCACTS  D
 ... S DIE="^GMR(123.6,",DA=$O(^GMR(123.6,"AC",IEN,GMRCACTS,1,0))
 ... S DR=".06///@" D ^DIE
 . D LOGMSG^GMRCIUTL(IEN,ACTN,"",902) ;msg log entry but no msg sent
 I ACTYPE=2!(ACTYPE=1) D NW(IEN) Q  ;send new order
 I ACTYPE=9!(ACTYPE=14) D RSLT(IEN,ACTN) Q  ;inc report or add'l notes
 I ACTYPE=10,$P(^GMR(123,IEN,40,ACTN,0),U,9) D RSLT(IEN,ACTN) Q  ;comp
 I ACTYPE=12 D RSLT(IEN,ACTN) Q  ;dis-associate result
 I ACTYPE=11 D RESUB^GMRCIEV1(IEN,ACTN) Q  ;ed/resubmit
 I ACTYPE=13 D RSLT(IEN,ACTN) Q  ; addendum added
 I ACTYPE=4 D SF^GMRCIEV1(IEN,ACTN) Q  ; sig finding update
 I ACTYPE=22 Q  ;printed to is not a trigger
 I ACTYPE=17 D FWD^GMRCIEV1(IEN,ACTN) Q  ; forward
 I ACTYPE=25 D FWD2IFC^GMRCIEV1(IEN,ACTN) Q  ; FWD into an IFC service
 D GENUPD(IEN,ACTN) ;all other updates
 Q
NW(GMRCDA) ;build new order message for IFC
 ; Input:
 ;   GMRCDA  = ien from file 123
 ;
 N HL,HLL,SEG,GMRC773,GMRCIQT
 S SEG=1
 K ^TMP("HLS",$J)
 D INIT^HLFNC2("GMRC IFC ORM EVENT",.HL)
 I $G(HL) D  Q  ; if HL array can't be built, log it with an error
 . D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,,904)
 D  I $D(GMRCIQT) D NOMPI(GMRCDA,1) Q  ;build PID seg if not a local ICN
 . N GMRCDFN S GMRCDFN=$P(^GMR(123,+GMRCDA,0),U,2)
 . I '$G(GMRCDFN) S GMRCIQT=1 Q
 . I $$GETICN^MPIF001(GMRCDFN)<1 S GMRCIQT=1 Q
 . I $$IFLOCAL^MPIF001(GMRCDFN) S GMRCIQT=1 Q
 . S ^TMP("HLS",$J,SEG)=$$EN^VAFCPID(GMRCDFN,"1,2,3,4,5,7,8,19")
 . S SEG=SEG+1
 . Q
 S ^TMP("HLS",$J,SEG)=$$NWORC^GMRCISG1(GMRCDA) ; get ORC for new ord
 S SEG=SEG+1
 S ^TMP("HLS",$J,SEG)=$$OBR^GMRCISG1(GMRCDA) ;get OBR segment
 S SEG=SEG+1
 D  ;build reason for request into OBX segment(s)
 . K ^TMP("GMRCRFR",$J)
 . D OBXWP^GMRCISEG(GMRCDA,"NW",1,$NA(^TMP("GMRCRFR",$J)))
 . I '$D(^TMP("GMRCRFR",$J)) Q
 . N I S I=0
 . F  S I=$O(^TMP("GMRCRFR",$J,I)) Q:'I  D
 .. S ^TMP("HLS",$J,SEG)=^TMP("GMRCRFR",$J,I)
 .. S SEG=SEG+1
 . K ^TMP("GMRCRFR",$J)
 . Q
 S ^TMP("HLS",$J,SEG)=$$OBXPD^GMRCISG1(GMRCDA) ; build prov DX in OBX
 S SEG=SEG+1
 S ^TMP("HLS",$J,SEG)=$$OBXTZ^GMRCISEG ;always send local time zone
 S HLL("LINKS",1)=$$ROUTE(GMRCDA) I '$L(HLL("LINKS",1)) D  Q  ;log error
 . D LOGMSG^GMRCIUTL(IEN,ACTN,"",903)
 D GENERATE^HLMA("GMRC IFC ORM EVENT","GM",1,.GMRC773)
 N ERR S ERR=$S($P(GMRC773,U,2):904,1:"")
 D LOGMSG^GMRCIUTL(GMRCDA,1,+GMRC773,ERR)
 Q
 ;
GENUPD(GMRCDA,GMRCACT) ;build msg and send upon REC, SC or ADD CMT event
 N HL,HLL,SEG,GMRC773,GMRCIQT
 S SEG=1
 K ^TMP("HLS",$J)
 D INIT^HLFNC2("GMRC IFC ORM EVENT",.HL)
 I $G(HL) D  Q  ; if HL array can't be built, log it with an error
 . D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,,904)
 D  I $D(GMRCIQT) D NOMPI(GMRCDA,GMRCACT) Q  ;build PID seg if nat'l ICN
 . N GMRCDFN S GMRCDFN=$P(^GMR(123,+GMRCDA,0),U,2)
 . I '$G(GMRCDFN) S GMRCIQT=1 Q
 . I $$GETICN^MPIF001(GMRCDFN)<1 S GMRCIQT=1 Q
 . I $$IFLOCAL^MPIF001(GMRCDFN) S GMRCIQT=1 Q
 . S ^TMP("HLS",$J,SEG)=$$EN^VAFCPID(GMRCDFN,"1,2,3,4,5,7,8,19")
 . S SEG=SEG+1
 . Q
 D  ;build ORC seg based on GMRCACT
 . N ACTVT,OC,OS
 . S ACTVT=$P(^GMR(123,GMRCDA,40,GMRCACT,0),U,2) ; get activity
 . ;set order control for ORC seg:
 . ;   v-- IP=cmt RE=adm comp OD=DC OC=cancel SC=sch or receive
 . S OC=$S(ACTVT=20:"IP",ACTVT=10:"RE",ACTVT=6:"OD",ACTVT=19:"OC",1:"SC")
 . ;set order status for ORC seg:
 . ;   v-- SC=sch RE=adm comp DC=DC CA=cancel IP=cmt or receive
 . S OS=$S(ACTVT=8:"SC",ACTVT=10:"CM",ACTVT=6:"DC",ACTVT=19:"CA",1:"IP")
 . S ^TMP("HLS",$J,SEG)=$$ORC^GMRCISEG(GMRCDA,OC,OS,GMRCACT)
 . S SEG=SEG+1
 . Q
 I $L($P(^GMR(123,GMRCDA,0),U,19)) D  ;send sig findings
 . S ^TMP("HLS",$J,SEG)=$$OBXSF^GMRCISEG(GMRCDA)
 . S SEG=SEG+1
 I $O(^GMR(123,GMRCDA,40,GMRCACT,1,0)) D  ;load up a comment if there
 . N I
 . K ^TMP("GMRCMT",$J)
 . I $P(^TMP("HLS",$J,SEG-1),"|",2)'["O" D 
 .. D OBXWP^GMRCISEG(GMRCDA,"",GMRCACT,$NA(^TMP("GMRCMT",$J)))
 . I $P(^TMP("HLS",$J,SEG-1),"|",2)["O" D
 .. N GMRCMT
 .. D NTE^GMRCISEG(GMRCDA,GMRCACT,.GMRCMT)
 .. I $D(GMRCMT) M ^TMP("GMRCMT",$J)=GMRCMT
 . Q:'$O(^TMP("GMRCMT",$J,0))
 . S I=0 F  S I=$O(^TMP("GMRCMT",$J,I)) Q:'I  D
 .. S ^TMP("HLS",$J,SEG)=^TMP("GMRCMT",$J,I)
 .. S SEG=SEG+1
 . K ^TMP("GMRCMT",$J)
 . Q
 S ^TMP("HLS",$J,SEG)=$$OBXTZ^GMRCISEG ;always include local time zone
 S HLL("LINKS",1)=$$ROUTE(GMRCDA) I '$L(HLL("LINKS",1)) D  Q  ;log error
 . D LOGMSG^GMRCIUTL(IEN,ACTN,"",903)
 D GENERATE^HLMA("GMRC IFC ORM EVENT","GM",1,.GMRC773)
 N ERR S ERR=$S($P(GMRC773,U,2):904,1:"") ; if err from HL7, log it
 D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,+GMRC773,ERR)
 Q
 ;
RSLT(GMRCDA,GMRCACT) ;attach or dis-associate results and update
 N HL,HLL,SEG,GMRC773,GMRCIQT
 S SEG=1
 K ^TMP("HLS",$J)
 D INIT^HLFNC2("GMRC IFC ORM EVENT",.HL)
 I $G(HL) D  Q  ; if HL array can't be built, log it with an error
 . D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,,904)
 D  I $D(GMRCIQT) D NOMPI(GMRCDA,GMRCACT) Q  ;build PID seg if nat'l ICN
 . N GMRCDFN S GMRCDFN=$P(^GMR(123,+GMRCDA,0),U,2)
 . I '$G(GMRCDFN) S GMRCIQT=1 Q
 . I $$GETICN^MPIF001(GMRCDFN)<1 S GMRCIQT=1 Q
 . I $$IFLOCAL^MPIF001(GMRCDFN) S GMRCIQT=1 Q
 . S ^TMP("HLS",$J,SEG)=$$EN^VAFCPID(GMRCDFN,"1,2,3,4,5,7,8,19")
 . S SEG=SEG+1
 . Q
 D  ;build ORC seg based on GMRCACT
 . N ACTVT,OC,OS
 . S ACTVT=$P(^GMR(123,GMRCDA,40,GMRCACT,0),U,2) ; get activity
 . S OC="RE"
 . S OS=$S(ACTVT=9:"A",ACTVT=12:"IP",1:"CM") ; A=part res CM=comp IP=dis
 . S ^TMP("HLS",$J,SEG)=$$ORC^GMRCISEG(GMRCDA,OC,OS,GMRCACT)
 . S SEG=SEG+1
 I $P(^GMR(123,GMRCDA,40,GMRCACT,0),U,2)'=99 D
 . S ^TMP("HLS",$J,SEG)=$$OBXRSLT^GMRCISEG(GMRCDA,GMRCACT)
 . S SEG=SEG+1
 S ^TMP("HLS",$J,SEG)=$$OBXTZ^GMRCISEG ;always include local time zone
 S HLL("LINKS",1)=$$ROUTE(GMRCDA) I '$L(HLL("LINKS",1)) D  Q  ;log error
 . D LOGMSG^GMRCIUTL(IEN,ACTN,"",903)
 D GENERATE^HLMA("GMRC IFC ORM EVENT","GM",1,.GMRC773)
 N ERR S ERR=$S($P(GMRC773,U,2):904,1:"") ; if err from HL7, log it
 D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,+GMRC773,ERR)
 Q
 ;
NOMPI(GMRCIEN,GMRCACTV) ;process MPI exception
 N GMRCDFN
 S GMRCDFN=$P(^GMR(123,GMRCIEN,0),U,2)
 D PTMPIER^GMRCIERR(GMRCDFN) ; send msg to local group for ICN problem
 D LOGMSG^GMRCIUTL(GMRCIEN,GMRCACTV,,202) ;put inc. entry in MSG log
 Q
 ;
ROUTE(GMRCDA) ; determine correct routing for IFC msg
 ; Input:
 ;  GMRCDA = ien from file 123
 ;
 ; Output:
 ;   the logical link to send the message to in format
 ;     "GMRC IFC SUBSC^VHAHIN"
 ;
 N SITE,GMRCLINK,STA
 S SITE=$P(^GMR(123,GMRCDA,0),U,23) I 'SITE Q "" ;no ROUTING FACILITY
 S STA=$$STA^XUAF4(SITE)
 I '$L(STA) Q "" ;can't find station num for that site
 D LINK^HLUTIL3(STA,.GMRCLINK,"I")
 S GMRCLINK=$O(GMRCLINK(0)) I 'GMRCLINK Q "" ; no link for that site
 S GMRCLINK=GMRCLINK(GMRCLINK) I '$L(GMRCLINK) Q "" ;no link name
 Q "GMRC IFC SUBSC^"_GMRCLINK
