GMRCIEVT ;SLC/JFR - process events and build HL7 message; 6/20/2021 09:23 ; Jan 09, 2025@09:44:47
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,31,121,154,184,189,201**;DEC 27, 1997;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; #7133 GETPAT MPIFRES, #7134 GETICN MPIFXMLI, #2161 HFLNC2, #2164 HLMA, #2271 HLUTIL3, #2701 MPIF001, #3015 VAFCPID, #4648 VAFCTFU2, #10112 VASITE
 ; #2053 DIE, #2056 DIQ, #2171 XUAF4, #2263 XPAR
 ; Reference to $$ADD^DGPROSAD in ICR #7421
 ; Reference to $$CRNRSITE^VAFCCRNR in ICR #7346
 ;
 Q  ;don't start at the top
TRIGR(IEN,ACTN) ;determine what action was taken on IFC and call event point
 ;Input: 
 ; IEN = consult number from file 123
 ; ACT = ien in 40 multiple corresponding to activity
 ;
 ;CLT, GMRC*3.0*184, Do not send a msg back on receipt of a comment from
 ; cerner.  That causes a duplicate entry at cerner.
 N GMRCDQ,GMRCDQ1 S GMRCDQ=0
 S GMRCDQ1=$$NOSND^GMRCIUTL() I GMRCDQ1=1 Q
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
 I ACTYPE=2!(ACTYPE=1) D NW(IEN,ACTN) Q  ;send new order - Added ACTN as parameter.  P189 WTC 6/24/2024
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
NW(GMRCDA,ACTN) ;build new order message for IFC
 ; Input:
 ; GMRCDA = ien from file 123
 ;
 N HL,HLL,SEG,GMRC773,GMRCIQT,GMRCPD,PROXYADD,GMRCDFN,STA,SITE ;
 ;
 S PROXYADD=$$CHKCORR(GMRCDA) Q:'PROXYADD  ;MKN GMRC*3.0*154 Check PT correlation and do proxy add if required, changed to function p189 wtc 12/5/23
 S SEG=1
 K ^TMP("HLS",$J)
 D INIT^HLFNC2("GMRC IFC ORM EVENT",.HL)
 I $G(HL) D  Q  ; if HL array can't be built, log it with an error
 . D LOGMSG^GMRCIUTL(GMRCDA,ACTN,,904) ;MKN GMRC*3.0*154 GMRCACT to ACTN
 D  I $D(GMRCIQT) D NOMPI(GMRCDA,1) Q  ;build PID seg if not a local ICN
 . S GMRCDFN=$P(^GMR(123,+GMRCDA,0),U,2)
 . I '$G(GMRCDFN) S GMRCIQT=1 Q
 . I $$GETICN^MPIF001(GMRCDFN)<1 S GMRCIQT=1 Q
 . I $$IFLOCAL^MPIF001(GMRCDFN) S GMRCIQT=1 Q
 . S ^TMP("HLS",$J,SEG)=$$EN^VAFCPID(GMRCDFN,"1,2,3,4,5,7,8,19")
 . ;
 . ;  If remote site is converted, enhance the PID segment. p184
 . ;
 . I $$CNVTD(GMRCDA)=1 S ^TMP("HLS",$J,SEG)=$$ADD2PID^GMRCIUTL(^TMP("HLS",$J,SEG),GMRCDFN,$P($G(^GMR(123,GMRCDA,"CERNER")),U,3)) ;
 . ;
 . S SEG=SEG+1
 . Q
 S ^TMP("HLS",$J,SEG)=$$NWORC^GMRCISG1(GMRCDA) ; get ORC for new ord
 S SEG=SEG+1
 S ^TMP("HLS",$J,SEG)=$$OBR^GMRCISG1(GMRCDA) ;get OBR segment
 ;
 ;  If remote site is converted, enhance the OBR segment. p184
 ;
 I $$CNVTD(GMRCDA)=1 S ^TMP("HLS",$J,SEG)=$$ADD2OBR^GMRCIUTL(^TMP("HLS",$J,SEG),GMRCDA) ;
 ;
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
 S GMRCPD=$$OBXPD^GMRCISG1(GMRCDA)  ;bl;154 preventing blank line for OBX
 I GMRCPD'="" S ^TMP("HLS",$J,SEG)=GMRCPD ; build prov DX in OBX
 S SEG=SEG+1
 S ^TMP("HLS",$J,SEG)=$$OBXTZ^GMRCISEG ;always send local time zone
 ;
 ;AV/MKN Add NTE segment to HL7 to send UCID file #123, field #80 *121*
 N SEP
 S SEP=HL("FS")
 N UCID S UCID=$$GET1^DIQ(123,GMRCDA,80) S:UCID]"" SEG=SEG+1,^TMP("HLS",$J,SEG)="NTE"_SEP_"P"_SEP_"UCID:"_UCID
 ;AV/MKN End of NTE for UCID *121*
 ;
 S SITE=$P(^GMR(123,GMRCDA,0),U,23) I 'SITE D LOGMSG^GMRCIUTL(IEN,ACTN,"",903) Q  ;no ROUTING FACILITY
 S STA=$$STA^XUAF4(SITE) I '$L(STA) D LOGMSG^GMRCIUTL(IEN,ACTN,"",903) Q  ;can't find station num for that site
 ;
 ;  If patient just proxy added, generate error 205 if not completed yet.  p189 wtc 6/18/2024
 ;
 I $P(PROXYADD,U,2)="ADDED",+$$CHKPROXY^GMRCIUT1(GMRCDA,GMRCDFN,STA)=0 D LOGMSG^GMRCIUTL(IEN,ACTN,"",205) Q  ;
 ;
 ;  Otherwise, set route according to whether destination site is converted (use $$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)) or non-converted (use D LINK^HLUTIL3(STA,.GMRCLINK,"I"))
 ;
 S HLL("LINKS",1)=$$ROUTE(GMRCDA) I '$L(HLL("LINKS",1)) D  Q  ;log error
 . D:'$$EXIST201^GMRCIEV1(GMRCDA,GMRCACT) LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,"",903) ;MKN GMRC*3*154 '$$EXIST201
 S HLP("SUBSCRIBER")="^^^^"_$P(HLL("LINKS",1),U,3) ;MKN GMRC*3*154 Station coming back from $$ROUTE
 D GENERATE^HLMA("GMRC IFC ORM EVENT","GM",1,.GMRC773,,.HLP) ;MKN GMRC*3*154 added 6th parameter that passes to HLP array in GENERATE^HLMA
 N ERR S ERR=$S($P(GMRC773,U,2):904,1:"")
 ;
 D LOGMSG^GMRCIUTL(GMRCDA,1,+GMRC773,ERR)
 Q
 ;
GENUPD(GMRCDA,GMRCACT) ;build msg and send upon REC, SC or ADD CMT event
 ;
 ;  If HL7 message goes to Cerner, hold it until the Cerner order number is received.  wtc 8/8/24
 ;
 I '$P(^GMR(123,GMRCDA,0),U,22),$$ISCERNER^GMRCIEVT(GMRCDA) D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,,204) Q  ;
 ;
 N HL,HLL,SEG,GMRC773,GMRCCRNR,GMRCIQT,OBR,PROSTHCS ; P184
 N EDIPI,ICN,PTACCTNO,FS,CS,REPTTN S PTACCTNO=$P($G(^GMR(123,GMRCDA,"CERNER")),U,3) ; p184
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
 . ;
 . ;  If remote site is converted, enhance the PID segment. p184
 . ;
 . I $$CNVTD(GMRCDA)=1 S ^TMP("HLS",$J,SEG)=$$ADD2PID^GMRCIUTL(^TMP("HLS",$J,SEG),GMRCDFN,PTACCTNO) ;
 . S SEG=SEG+1 ;
 . Q
 D  ;build ORC seg based on GMRCACT
 . N ACTVT,OC,OS
 . S ACTVT=$P(^GMR(123,GMRCDA,40,GMRCACT,0),U,2) ; get activity
 . ;set order control for ORC seg:
 . ; v-- IP=cmt RE=adm comp OD=DC OC=cancel SC=sch or receive
 . S OC=$S(ACTVT=20:"IP",ACTVT=10:"RE",ACTVT=6:"OD",ACTVT=19:"OC",1:"SC")
 . ;set order status for ORC seg:
 . ; v-- SC=sch RE=adm comp DC=DC CA=cancel IP=cmt or receive
 . S OS=$S(ACTVT=8:"SC",ACTVT=10:"CM",ACTVT=6:"DC",ACTVT=19:"CA",1:"IP")
 . S ^TMP("HLS",$J,SEG)=$$ORC^GMRCISEG(GMRCDA,OC,OS,GMRCACT)
 . S SEG=SEG+1
 . Q
 ;
 ;  Generate OBR segment if IFC is from converted site.  p184
 ;
 I $$CNVTD(GMRCDA)=1 D  ;
 . ;
 . S OBR=$$OBR^GMRCISG1(GMRCDA) ;
 . S OBR=$$ADD2OBR^GMRCIUTL(OBR,GMRCDA) ;
 . S ^TMP("HLS",$J,SEG)=OBR ;
 . S SEG=SEG+1 ;
 ;
 ;  Determine if order is for Prosthetics - p184 WTC 6/1/22
 ;
 S PROSTHCS=$S($G(OBR)="":0,$P($P(OBR,"|",5),U,2)["PROSTHETICS IFC":1,1:0) ; P184
 ;
 I $L($P(^GMR(123,GMRCDA,0),U,19)) D  ;send sig findings
 . S ^TMP("HLS",$J,SEG)=$$OBXSF^GMRCISEG(GMRCDA)
 . S SEG=SEG+1
 I $O(^GMR(123,GMRCDA,40,GMRCACT,1,0))!($P(^GMR(123,GMRCDA,40,GMRCACT,0),U,2)=21) D  ;load up a comment if there or if IFC from Cerner received.
 . N I
 . K ^TMP("GMRCMT",$J)
 . S GMRCCRNR=$$ISCERNER(GMRCDA) ;MKN 184
 . I $P(^TMP("HLS",$J,SEG-1),"|",2)'["O" D
 .. D:GMRCCRNR&'PROSTHCS CRNROBX^GMRCIEV1(GMRCDA,$NA(^TMP("GMRCMT",$J))) ; p184 - wtc 6/1/22
 .. D:'GMRCCRNR!PROSTHCS OBXWP^GMRCISEG(GMRCDA,"",GMRCACT,$NA(^TMP("GMRCMT",$J))) ; p184 - wtc 6/1/22
 . I $P(^TMP("HLS",$J,SEG-1),"|",2)["O" D
 .. I GMRCCRNR,'PROSTHCS D CRNRNTE^GMRCIEV1(GMRCDA,$NA(^TMP("GMRCMT",$J))) ; p184 - wtc 6/1/22
 .. I 'GMRCCRNR!PROSTHCS N GMRCMT D NTE^GMRCISEG(GMRCDA,GMRCACT,.GMRCMT) I $D(GMRCMT) M ^TMP("GMRCMT",$J)=GMRCMT ; p184 - wtc 6/1/22
 . Q:'$O(^TMP("GMRCMT",$J,0))
 . S I=0 F  S I=$O(^TMP("GMRCMT",$J,I)) Q:'I  D
 .. S ^TMP("HLS",$J,SEG)=^TMP("GMRCMT",$J,I)
 .. S SEG=SEG+1
 . K ^TMP("GMRCMT",$J)
 . Q
 S ^TMP("HLS",$J,SEG)=$$OBXTZ^GMRCISEG ;always include local time zone
 S HLL("LINKS",1)=$$ROUTE(GMRCDA) I '$L(HLL("LINKS",1)) D  Q  ;log error
 . D:'$$EXIST201^GMRCIEV1(GMRCDA,GMRCACT) LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,"",903) ;MKN GMRC*3*154 '$$EXIST201
 S HLP("SUBSCRIBER")="^^^^"_$P(HLL("LINKS",1),U,3) ;MKN GMRC*3*154 Station coming back from $$ROUTE
 ;
 D GENERATE^HLMA("GMRC IFC ORM EVENT","GM",1,.GMRC773,,.HLP) ;MKN GMRC*3*154 added 6th parameter that passes to HLP array in GENERATE^HLMA
 N ERR S ERR=$S($P(GMRC773,U,2):904,1:"") ; if err from HL7, log it
 D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,+GMRC773,ERR)
 Q
 ;
RSLT(GMRCDA,GMRCACT) ;attach or dis-associate results and update
 ;
 ;  If HL7 message goes to Cerner, hold it until the Cerner order number is received.  wtc 8/8/24
 ;
 I '$P(^GMR(123,GMRCDA,0),U,22),$$ISCERNER^GMRCIEVT(GMRCDA) D LOGMSG^GMRCIUTL(GMRCDA,GMRCACT,,204) Q  ;
 ;
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
 . ;
 . ;  If remote site is converted, enhance the PID segment. p184
 . ;
 . I $$CNVTD(GMRCDA)=1 S ^TMP("HLS",$J,SEG)=$$ADD2PID^GMRCIUTL(^TMP("HLS",$J,SEG),GMRCDFN,$P($G(^GMR(123,GMRCDA,"CERNER")),U,3)) ;
 . ;
 . S SEG=SEG+1
 . Q
 D  ;build ORC seg based on GMRCACT
 . N ACTVT,OC,OS
 . S ACTVT=$P(^GMR(123,GMRCDA,40,GMRCACT,0),U,2) ; get activity
 . S OC="RE"
 . S OS=$S(ACTVT=9:"A",ACTVT=12:"IP",1:"CM") ; A=part res CM=comp IP=dis
 . S ^TMP("HLS",$J,SEG)=$$ORC^GMRCISEG(GMRCDA,OC,OS,GMRCACT)
 . S SEG=SEG+1
 ;
 ;  If remote site is converted, add OBR segment. p184
 ;
 I $$CNVTD(GMRCDA)=1 D  ;
 . S ^TMP("HLS",$J,SEG)=$$OBR^GMRCISG1(GMRCDA) ;
 . S ^TMP("HLS",$J,SEG)=$$ADD2OBR^GMRCIUTL(^TMP("HLS",$J,SEG),GMRCDA) ;
 . S SEG=SEG+1
 ;
 I $P(^GMR(123,GMRCDA,40,GMRCACT,0),U,2)'=99 D
 . S ^TMP("HLS",$J,SEG)=$$OBXRSLT^GMRCISEG(GMRCDA,GMRCACT)
 . S SEG=SEG+1
 S ^TMP("HLS",$J,SEG)=$$OBXTZ^GMRCISEG ;always include local time zone
 S HLL("LINKS",1)=$$ROUTE(GMRCDA) I '$L(HLL("LINKS",1)) D  Q  ;log error
 . D:'$$EXIST201^GMRCIEV1(IEN,GMRCACT) LOGMSG^GMRCIUTL(IEN,ACTN,"",903) ;MKN GMRC*3*154 '$$EXIST201
 S HLP("SUBSCRIBER")="^^^^"_$P(HLL("LINKS",1),U,3) ;MKN GMRC*3*154 Station coming back from $$ROUTE
 D GENERATE^HLMA("GMRC IFC ORM EVENT","GM",1,.GMRC773,,.HLP) ;MKN GMRC*3*154 added 6th parameter that passes subscriber to HLP array in GENERATE^HLMA
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
ROUTE(GMRCDA)  ; determine correct routing for IFC msg
 ; Input:
 ; GMRCDA = ien from file 123
 ;
 ; Output:
 ; the logical link to send the message to in format
 ; "GMRC IFC SUBSC^VHAHIN^STATION"
 ;
 N SITE,STA ;
 S SITE=$P(^GMR(123,GMRCDA,0),U,23) I 'SITE Q "" ;no ROUTING FACILITY
 S STA=$$STA^XUAF4(SITE) I '$L(STA) Q "" ;can't find station num for that site
 ;
 ;  Converted site
 ;
 I $$CRNRSITE^VAFCCRNR(STA)=1 Q "GMRC IFC SUBSC^"_$$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)_U_STA ;
 ;
 ;  Non-converted site
 ;
 N GMRCLINK,SUB,DATA ;
 I $$CRNRSITE^VAFCCRNR(STA)'=1 D LINK^HLUTIL3(STA,.GMRCLINK,"I") S SUB=$O(GMRCLINK(0)) I SUB S DATA=GMRCLINK(SUB) Q "GMRC IFC SUBSC^"_DATA_U_STA ;
 ;
 Q "" ;
 ;
CNVTD(GMRCDA) ; had facility been converted
 ; Input:
 ; GMRCDA = ien from file 123
 ;
 ; Output:
 ; 1 = converted site
 ; 0 = not converted or unknown based on missing data
 N SITE,STA
 N DGKEY,DGOUT,CNT,IDS,CONSULTDFN,GMRCDFN
 S CONSULTDFN=""
 S SITE=$P($G(^GMR(123,GMRCDA,0)),U,23) I 'SITE Q 0 ;no ROUTING FACILITY
 S STA=$$STA^XUAF4(SITE)
 I '$L(STA) Q 0 ;can't find station num for that site
 ;
 S GMRCDFN=$P(^GMR(123,GMRCDA,0),U,2)  ;get patient
 I 'GMRCDFN Q 0
 ;
 ;pull patient Correlation list
 S DGKEY=GMRCDFN_U_"PI"_U_"USVHA"_U_$P($$SITE^VASITE,"^",3)
 D TFL^VAFCTFU2(.DGOUT,DGKEY)
 ;
 S CNT=0 F  S CNT=$O(DGOUT(CNT)) Q:'CNT  S IDS=$G(DGOUT(CNT)) I $P(IDS,"^",4)=STA,$P(IDS,"^",5)="C" S CONSULTDFN=IDS Q
 ;
 Q $S(CONSULTDFN]"":1,1:0)
 ; 
 ;MKN GMRC*3.0*154 Start mods - Check PT correlation and do proxy add if required
CHKCORR(GMRCDA) ;
 ;
 ;  Returns "1^ADDED" if proxy add succeeded, 1 if patient known to Cerner or site is non-converted and 0 if not. p189 wtc 12/5/23, 4/4/24
 ;
 N CERNERID,CNT,CONSULTDFN,DGKEY,DGOUT,GMRCDFN,IDS,SITE,STA,RTNCODE ;
 S GMRCDFN=$P(^GMR(123,GMRCDA,0),U,2) I 'GMRCDFN Q 0 ;
 ;
 S SITE=$P(^GMR(123,GMRCDA,0),U,23) I 'SITE Q 0 ;no ROUTING FACILITY
 S STA=$$STA^XUAF4(SITE) I '$L(STA) Q 0 ;can't find station num for that site
 ;
 S (CERNERID,CONSULTDFN)=""
 ;pull patient Correlation list
 S DGKEY=GMRCDFN_U_"PI"_U_"USVHA"_U_$P($$SITE^VASITE,"^",3)
 D TFL^VAFCTFU2(.DGOUT,DGKEY)
 ;
 S CNT=0,RTNCODE=0 F  S CNT=$O(DGOUT(CNT)) Q:'CNT  S IDS=$G(DGOUT(CNT)) D  ;
 .I $P(IDS,"^",4)="200CRNR",$P(IDS,"^",2)="PI" S CERNERID=IDS ;
 .I $P(IDS,"^",4)=STA,$P(IDS,"^",2)="PI",$P(IDS,"^",5)="A"!($P(IDS,"^",5)="C") S CONSULTDFN=IDS ;
 ;
 ;  Patient known to filler and filler is non-converted VistA.
 ;
 I CONSULTDFN'="",$$CRNRSITE^VAFCCRNR(STA)'=1 Q 1 ;
 ;
 ;  Filler is Cerner.  Patient known to Cerner and its converted VistA.
 ;
 I CERNERID'="",CONSULTDFN'="",$$CRNRSITE^VAFCCRNR(STA)=1 Q 1 ;
 ;
 ;  Filler is Cerner.  Patient known to Cerner but not its converted VistA.
 ;
 I CERNERID'="",CONSULTDFN="",$$CRNRSITE^VAFCCRNR(STA)=1 D  Q 1 ;  return 1 because response is sent to Cerner not the converted VistA
 . S RTNCODE=$$ADD^DGPROSAD($P(CERNERID,U,1)_"~USDOD~NI~200DOD",STA) ;  ICR 7421
 . I RTNCODE<0 D FAILPRXY^GMRCIUT1("",$P(CERNERID,U,1),GMRCDA,"","","",STA,$P(RTNCODE,U,2)) Q  ; P189 WTC 6/24/24
 ;
 ; if not known to filler, trigger Proxy Add Patient
 ;
 I CONSULTDFN=""!(CERNERID="") S RTNCODE=$$PROXYADD(GMRCDA,GMRCDFN,STA) ;
 Q RTNCODE ;
 ;
PROXYADD(GMRCDA,GMRCDFN,STA) ;
 ;
 ;  Adds patient to Cerner or non-converted VistA.  Returns "1^ADDED" if successful and 0 if not. p189 wtc 12/5/23
 ;
 N CONSULTDFN,MPIDATA,PATARR
 S CONSULTDFN=0
 D GETPAT^MPIFRES(GMRCDFN,.PATARR)
 S PATARR(1,"preferredFacilityNumber")=STA
 S PATARR(1,"AddType")="ADDPREFTF"
 D GETICN^MPIFXMLI(.MPIDATA,.PATARR) I +MPIDATA("ICN")>0 S CONSULTDFN=+MPIDATA("ICN")
 ;
 ;  If proxy add failed, generate 203 error if IFC to Cerner or 201 error otherwise.
 ;
 I +CONSULTDFN=0 D  Q 0 ;
 . I $$CRNRSITE^VAFCCRNR(STA)=1 D LOGMSG^GMRCIUTL(GMRCDA,1,"",203) Q  ; 
 . I $$CRNRSITE^VAFCCRNR(STA)'=1 D LOGMSG^GMRCIUTL(GMRCDA,1,"",201) Q  ;
 Q "1^ADDED" ;
 ;
ISCERNER(IEN) ;Is consult going to Cerner?
 ;Input:
 ;  IEN = file #123
 ;Output:
 ;    1 = Cerner IFC
 ;    0 = Error - see piece 2 for message 
 ;
 ;N GMRCCNV,GMRCDFN,GMRCKEY,GMRCN,GMRCSITE,GMRCTFL,GMRCX,STA ; p184 WTC 5/1/22
 N GMRCSITE,STA ; P 201 WTC 1/8/25
 S GMRCSITE=$P(^GMR(123,IEN,0),U,23) I 'GMRCSITE Q "0^No ROUTING FACILITY found" Q
 S STA=$$STA^XUAF4(GMRCSITE) I '$L(STA) Q "0^Station not found" ;can't find station num for that site  - p184 WTC 5/1/22
 Q $$CRNRSITE^VAFCCRNR(STA) ; P201 WTC 1/8/25
 ;S GMRCDFN=$$GET1^DIQ(123,IEN_",",.02,"I") I 'GMRCDFN Q "0^No PATIENT file IEN found in consult #"_IEN
 ;S GMRCKEY=GMRCDFN_U_"PI"_U_"USVHA"_U_$P($$SITE^VASITE,"^",3)
 ;D TFL^VAFCTFU2(.GMRCTFL,GMRCKEY)
 ;S (GMRCCNV,GMRCN)=0 F  S GMRCN=$O(GMRCTFL(GMRCN)) Q:'GMRCN  S GMRCX=GMRCTFL(GMRCN) D
 ;. I $P(GMRCX,U,4)=STA,$P(GMRCX,U,5)="C" S GMRCCNV=1 Q  ; p184 WTC 5/1/22
 ;It is going to Cerner=converted site.
 ;Q GMRCCNV
 ;
LOC(GMRCLOC,GMRCIENS) ;DETERMINE LOCATION
 N LOCNAME
 I '$D(^GMR(123,$P(GMRCIENS,",",2),40,$P(GMRCIENS,",",1),3)) D SITE Q GMRCLOC
 S LOCNAME=^GMR(123,$P(GMRCIENS,",",2),40,$P(GMRCIENS,",",1),3)
 S LOCNAME=$P(LOCNAME,U,3)
 S LOCNAME=$P(^DIC(4,LOCNAME,0),U,1)
 Q LOCNAME
SITE ;SET LOCAL SITE
 S GMRCLOC=$P($$SITE^VASITE,U,2)
 Q
 ;
