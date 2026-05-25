GMRCIACT ;SLC/JFR - PROCESS ACTIONS ON IFC ; Jan 27, 2025@06:03:22
 ;;3.0;CONSULT/REQUEST TRACKING;**22,47,58,66,73,121,154,176,184,193,185,189,201,205**;DEC 27, 1997;Build 3
 ;
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to $$FIND1^DIC in ICR #2051
 ; Reference to ^DIE in ICR #2053
 ; Reference to ^HLMA1 in ICR #2165
 ; Reference to ^MPIF001 in ICR #2701
 ; Reference to ^XLFDT in ICR #10103
 ; Reference to ^XLFNAME in ICR #3065
 ; Reference to ^XUAF4 in ICR #2171
 ; Reference to ^XLFSTR in ICR #10104
 ; Reference to $$ADD^DGPROSAD in ICR #7421
 ;
 Q  ;don't start here!
NW(ARRAY) ;process and file new order
 ;Input:
 ; ARRAY  = name of array containing message parts
 ;
 N GMRCFDA,GMRCORC,GMRCDA,GMRCITM,GMRCITER,GMRCROUT,GMRCFCN,GMRCLAC ;
 K ^TMP("GMRCIN",$J)
 M ^TMP("GMRCIN",$J)=@ARRAY
 S GMRCORC=^TMP("GMRCIN",$J,"ORC")
 D  I $D(GMRCITER) Q  ;Check for order already being on file
 . S GMRCFCN=+$P(GMRCORC,"|",2)
 . S GMRCROUT=$$IEN^XUAF4($P($P(GMRCORC,"|",2),U,2))
 . I '$O(^GMR(123,"AIFC",GMRCROUT,GMRCFCN,0)) Q  ;no dup
 . S GMRCITER=802
 . S GMRCCRNR=$G(GMRCCRNR),GMRCMSGI=$G(GMRCMSGI) D APPACK^GMRCIAC2(0,"AR",GMRCITER,GMRCCRNR,GMRCMSGI,$NA(^TMP("GMRCIN",$J))) ;send app. ack w/ error ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI. P205 WTC 8/22/24
 . K ^TMP("GMRCIN",$J) Q
 I '$D(^TMP("GMRCIN",$J,"PID")) Q  ;prepare reject message (no PID)
 D  ;get patient DFN from ICN in message
 . N PAT,CRNRACCT ; p184
 . S PAT=$$GETDFN^MPIF001(+$P(^TMP("GMRCIN",$J,"PID"),"|",2))
 . I +PAT'>1 S GMRCFDA(.02)="" Q
 . S GMRCFDA(.02)=+PAT
 ;
 ;  Save patient account number in field #502.  Below code shifted out of patient lookup so CRNRACCT set whether patient found or not.  Needed for proxy add code. p189
 ;
 S CRNRACCT=$P(^TMP("GMRCIN",$J,"PID"),"|",18),GMRCFDA(502)=CRNRACCT ; p184, 189
 ;
 ;  Save ordering provider data and placer field 1 from OBR-16 and OBR-19 in fields #507 and 508
 ;
 N OBR16,OBR19,OBR20,OBR27 ; P201 WTC 11.2.23
 I $D(^TMP("GMRCIN",$J,"OBR")) D  ;  P184, 189
 . S OBR16=$P(^("OBR"),"|",16),GMRCFDA(507)=$E(OBR16,1,255) ;
 . S OBR19=$P(^("OBR"),"|",19),GMRCFDA(508)=$E(OBR19,1,255) ; 184V10 WTC 6/28/2022
 . S OBR20=$P(^("OBR"),"|",20) I OBR20'="" S GMRCFDA(511)=$E(OBR20,1) ; 185V2 WTC 4/24/2023
 . S OBR27=$P($P(^("OBR"),"|",27),U,4) I OBR27'="" S GMRCFDA(512)=$E(OBR27,1,30) ; 185V2 WTC 4/24/2023
 ;
 ;  If patient not found and placer is Cerner, call proxy add to create patient.  p189 wtc 4/12/2023
 ;  If ICN is missing from PID segment, generate 206 error and quit processing HL7 message.  p201 wtc 5/8/2024
 ;
 I '$G(GMRCFDA(.02)),$G(CRNRACCT)'="" D  Q:$G(GMRCITER)=206  ;
 . ;
 . ;  Extract EDIPI from PID-3.
 . ;
 . N ICN,EDIPI,RTNCODE,PIECE ;
 . S ICN=$P(^TMP("GMRCIN",$J,"PID"),"|",2) ; P201 WTC 5/6/24
 . S EDIPI="" I $P($P($P(^TMP("GMRCIN",$J,"PID"),"|",3),"~",2),U,4)="EDIPI" S EDIPI=$P($P($P(^("PID"),"|",3),"~",2),U,1) ; P201 WTC 3/21/2024
 . ;
 . ;  ICN missing.  Log error 206 and stop processing HL7 message.
 . ;
 . I ICN="" D  Q  ;
 .. ;
 .. S GMRCITER=206 ;
 .. D ERR206^GMRCIAC3($P(GMRCMSGI,U,1),EDIPI,GMRCFCN,OBR19,$$HL7TFM^XLFDT($P(GMRCORC,"|",15)),$NA(^TMP("GMRCIN",$J))) ; P205 WTC 8/22/24
 .. K ^TMP("GMRCIN",$J) ;
 . ;
 . Q:EDIPI=""  ;  unlikely to happen that both ICN and EDIPI missing from Cerner order.  wtc 5/8/24
 . ;
 . ;  Call proxy add.  If successful, save DFN.  Otherwise, allow 201 error to be generated.
 . ;
 . S RTNCODE=$$ADD^DGPROSAD(EDIPI_"~USDOD~NI~200DOD",$P($$SITE^VASITE(),U,3)) ;  ICR 7421
 . I RTNCODE<0 D FAILPRXY^GMRCIUT1($P(GMRCMSGI,U,1),EDIPI,"",GMRCFCN,OBR19,$P(GMRCORC,"|",15),$P($$SITE^VASITE(),U,3),$P(RTNCODE,U,2)) Q  ; P189 WTC 6/24/24
 . S GMRCFDA(.02)=$P(RTNCODE,U,4) ;
 ;
 I '$G(GMRCFDA(.02)) D  Q  ;reject message, patient is unknown
 . N STA S STA=$P($P(^TMP("GMRCIN",$J,"ORC"),"|",2),U,2)
 . N OBR S OBR=^TMP("GMRCIN",$J,"OBR")
 . D PTERRMSG^GMRCIERR(^TMP("GMRCIN",$J,"PID"),STA,,OBR)
 . S GMRCCRNR=$G(GMRCCRNR),GMRCMSGI=$G(GMRCMSGI) D APPACK^GMRCIAC2(0,"AR",201,GMRCCRNR,GMRCMSGI,$NA(^TMP("GMRCIN",$J))) ; send app. ack w/error ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI. P205 WTC 8/22/24
 . K ^TMP("GMRCIN",$J) Q
 D  ;get ordered item and service
 . S GMRCITM=$P(^TMP("GMRCIN",$J,"OBR"),"|",4)
 . I GMRCITM["VA1233" D  ; proc
 .. N PROC
 .. S PROC=$$GETPROC^GMRCIUTL(GMRCITM)
 .. I +PROC'>0!('$P(PROC,U,2)) S GMRCITER=$P(PROC,U,3) Q
 .. S GMRCFDA(4)=$P(PROC,U)_";GMR(123.3,"
 .. S GMRCFDA(1)=$P(PROC,U,2)
 . I GMRCITM["VA1235" D
 .. N SERV
 .. S SERV=$$GETSERV^GMRCIUTL(GMRCITM) ;consult
 .. I +SERV'>0 S GMRCITER=$P(SERV,U,3)
 .. S GMRCFDA(1)=SERV
 I $D(GMRCITER) D  Q  ;error in procedure or service, reject new order
 . S GMRCCRNR=$G(GMRCCRNR),GMRCMSGI=$G(GMRCMSGI) D APPACK^GMRCIAC2(0,"AR",GMRCITER,GMRCCRNR,GMRCMSGI,$NA(^TMP("GMRCIN",$J))) ; send app. ACK  ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI. P205 WTC 8/22/24
 . K ^TMP("GMRCIN",$J) Q
 ;
 S GMRCFDA(.01)=$$NOW^XLFDT
 S GMRCFDA(3)=$$HL7TFM^XLFDT($P(GMRCORC,"|",15))
 S GMRCFDA(6)=$$FIND1^DIC(101,"","X","GMRCPLACE - ON CALL")
 S GMRCFDA(17)=$$HL7TFM^XLFDT($P($P(GMRCORC,"|",7),U,4)) ;WAT/66 Earliest Date
 D  ;get urgency to file
 . N URG
 . S URG=$$URG^GMRCHL7A($P($P(GMRCORC,"|",7),U,6))
 . ;I GMRCCRNR,URG="STAT" S URG="NEXT AVAILABLE" ;MKN *176
 . I $G(GMRCCRNR) D  ; WTC p201 10/20/23
 .. I URG="STAT" S URG="STAT" ;
 .. I URG="ROUTINE" S URG="ROUTINE" ;
 .. I URG="URGENT"!(URG="U") S URG="STAT" ;
 . S GMRCFDA(5)=$$FIND1^DIC(101,"","X","GMRCURGENCY - "_URG)
 S GMRCFDA(8)=5
 S GMRCFDA(9)=$S($P(GMRCORC,"|",16)["FI":24,1:23),GMRCLAC=GMRCFDA(9)
 S GMRCFDA(14)=$P(^TMP("GMRCIN",$J,"OBR"),"|",18)
 S GMRCFDA(.05)=$$IEN^XUAF4(+$P(GMRCORC,"|",17))
 S GMRCFDA(.06)=GMRCFCN
 S GMRCFDA(.07)=GMRCROUT
 D  ;get and set ordering prov info & entering person info
 . N GMRCOP
 . S GMRCOP=$$FMNAME^XLFNAME($P(GMRCORC,"|",12))
 . Q:'$L(GMRCOP)
 . S GMRCFDA(.126)=GMRCOP
 . Q
 S GMRCFDA(.125)="F"
 I $L($P(GMRCORC,"|",14)) D
 . N GMRCP14 S GMRCP14=$P(GMRCORC,"|",14)
 . S GMRCFDA(.132)=$P(GMRCP14,"B") ; requestor's phone number
 . S GMRCFDA(.133)=$P(GMRCP14,"B",2) ; requestor's dig pager
 S GMRCFDA(13)=$S($D(GMRCFDA(4)):"P",1:"C")
 I $D(^TMP("GMRCIN",$J,"OBX",2)) D
 . N GMRCCSYS,CODINTXT
 . S GMRCFDA(30)=$P($P(^TMP("GMRCIN",$J,"OBX",2,1),"|",5),U,2)
 . S GMRCFDA(30.1)=$P($P(^TMP("GMRCIN",$J,"OBX",2,1),"|",5),U)
 . S GMRCFDA(30.2)=$$HL7TFM^XLFDT($P($P(^TMP("GMRCIN",$J,"OBX",2,1),"|",14),U)) ;date OBX-14 WAT/73
 . S GMRCCSYS=$P($P(^TMP("GMRCIN",$J,"OBX",2,1),"|",5),U,3) ;code system WAT/73
 . S GMRCCSYS=$S($G(GMRCCSYS)="I9C":"ICD",1:"10D")
 . S GMRCFDA(30.3)=GMRCCSYS
 . I $D(GMRCFDA(30.1)) D  ;if dx code exists, ensure that code is removed from dx text
 .. S CODINTXT="("_GMRCFDA(30.1)_")"
 .. I GMRCFDA(30)[CODINTXT D
 ... S GMRCFDA(30)=$E(GMRCFDA(30),0,($L(GMRCFDA(30))-$L(CODINTXT)))
 ... S GMRCFDA(30)=$$TRIM^XLFSTR(GMRCFDA(30),"R")
 ;
 ;BL;121;Adding UCID to FILE #123 FIELD 80
 ;check for NTE segment
 I $D(^TMP("GMRCIN",$J,"NTE")) D
 . N NODE,UCIDNODE
 . S NODE=0
 . F  S NODE=$O(^TMP("GMRCIN",$J,"NTE",NODE))  Q:NODE=""  D
 . . S UCIDNODE=$P(^TMP("GMRCIN",$J,"NTE",NODE),"|",2)
 . . S:UCIDNODE["UCID:" GMRCFDA(80)=$P(UCIDNODE,"UCID:",2)
 ;
 M FDA(1,123,"+1,")=GMRCFDA
 D UPDATE^DIE("","FDA(1)","GMRCDA","GMRCERR")
 I '$D(GMRCDA) D  Q  ;couldn't get new consult #
 . S GMRCCRNR=$G(GMRCCRNR),GMRCMSGI=$G(GMRCMSGI) D APPACK^GMRCIAC2(0,"AR",901,GMRCCRNR,GMRCMSGI,$NA(^TMP("GMRCIN",$J))) ; send app. ACK ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI. P205 WTC 8/22/24
 . K ^TMP("GMRCIN",$J) Q
 K GMRCFDA,FDA
 D  ; file reason for request
 . ;
 . I $G(OBR19)'="" D  ;  Re-sequence reasons for request if needed.  wtc 201 11.2.2023
 .. N IEN S IEN=$O(^GMR(123.7,"C",$$UP^XLFSTR(OBR19),0)) I IEN D RESEQNCE^GMRCIRSN(IEN) Q  ;
 . ;
 . ;  Add FIN to reason for request for Prosthetics orders. p201 wtc 3.21.2024
 . ;
 . I GMRCCRNR,$G(OBR19)'="",OBR19["PROSTHETICS IFC"!(OBR19["PSAS") D  ;
 .. N IDX S IDX=$O(^TMP("GMRCIN",$J,"OBX",1,"A"),-1)+1,^TMP("GMRCIN",$J,"OBX",1,IDX)="1|TX|2000.02^REASON FOR REQUEST^AS4|"_IDX_"|FIN: "_CRNRACCT ;
 . ;
 . D TRIMWP^GMRCIUTL($NA(^TMP("GMRCIN",$J,"OBX",1)),5)
 . D WP^DIE(123,GMRCDA(1)_",",20,"K",$NA(^TMP("GMRCIN",$J,"OBX",1)))
 . Q
 D  ;file activity tracking
 . N GMRCSEG
 . S GMRCSEG("ORC")=GMRCORC
 . S GMRCSEG("OBX",5,1)=^TMP("GMRCIN",$J,"OBX",5,1)
 . D FILEACT^GMRCIAC2(GMRCDA(1),GMRCLAC,,"GMRCSEG",$G(GMRCCRNR),$G(GMRCROUT)) ; P184
 D  ;print SF-513
 . I GMRCLAC=24 Q  ;don't print if part of a FWD to IFC
 . D PRNT^GMRCUTL1("",GMRCDA(1))
 D  ;send notifications
 . I GMRCLAC=24 Q  ;no alerts yet if part of FWD to IFC
 . N GMRCORTX
 . S GMRCORTX="New remotely ordered consult "_$$ORTX^GMRCAU(+GMRCDA(1))
 . D MSG^GMRCP($P(^GMR(123,GMRCDA(1),0),U,2),GMRCORTX,GMRCDA(1),27,,1)
 D  ;send appl ack :-(
 . N GMRCRSLT
 . D RESP^GMRCIUTL("AA",HL("MID"),$P(GMRCORC,"|"),GMRCDA(1))
 . D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.GMRCRSLT)
 K ^TMP("GMRCIN",$J) Q:'GMRCCRNR  ;
 ;
 ;  Check if patient exists on converted VistA.  If not, add the entry.  p189 wtc 6/24/24
 ;
 N RTNCODE,SITE,STA ;
 S SITE=$P(^GMR(123,GMRCDA(1),0),U,23) Q:'SITE  ;no ROUTING FACILITY
 S STA=$$STA^XUAF4(SITE) I '$L(STA) Q  ;can't find station num for that site
 S RTNCODE=$$CHKPROXY^GMRCIUT1(GMRCDA(1),$P(^GMR(123,GMRCDA(1),0),U,2),STA,1) ;
 Q
 ;
DIS(GMRCAR,GMRCCRNR,GMRCMSGI) ;dis-associate a result from a remote request ; MKN GMRC*3.0*154 added GMRCCRNR and GMRCMSGI
 ;Input:
 ; GMRCAR = array name containing message
 ;      e.g.  ^TMP("GMRCIF",$J)
 ; GMRCCRNR = 1 if message came from Cerner
 ; GMRCMSGI = message ID
 ;
 K ^TMP("GMRCID",$J) ;p193
 N GMRCDA,GMRCFDA,FDA,GMRCERR,GMRCORC
 M ^TMP("GMRCID",$J)=@GMRCAR
 S GMRCORC=^TMP("GMRCID",$J,"ORC")
 S GMRCDA=$$GETDA^GMRCIAC2(GMRCORC)
 S GMRCCRNR=$G(GMRCCRNR,0),GMRCMSGI=$G(GMRCMSGI) ;MKN GMRC*3*154
 I '$$LOCKREC^GMRCUTL1(GMRCDA) D  Q  ;couldn't lock record
 . D APPACK^GMRCIAC2(GMRCDA,"AR",901,GMRCCRNR,GMRCMSGI,$NA(^TMP("GMRCIN",$J))) ;send app. ACK ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI. P205 WTC 8/22/24
 . K ^TMP("GMRCID",$J) Q
 ;    v--check to see if a dup transmission
 I $$DUPACT^GMRCIAC2(GMRCDA,12,GMRCORC,^TMP("GMRCID",$J,"OBX",4,1),GMRCCRNR,GMRCMSGI) K ^TMP("GMRCID",$J) Q  ;MKN GMRC*3*154 added CRNR and MSGI ;p193
 ;
 D FILEACT^GMRCIAC2(GMRCDA,12,,$NA(^TMP("GMRCID",$J)),$G(GMRCCRNR),$$GET1^DIQ(123,GMRCDA,.07,"I")) ; act. tracking ; P184
 D FILRES^GMRCIAC2(GMRCDA,^TMP("GMRCID",$J,"OBX",4,1)) ;file results
 K GMRCERR,FDA,GMRCFDA
 I $$STSCHG^GMRCDIS(GMRCDA) S FDA(1,123,GMRCDA_",",8)=6
 S FDA(1,123,GMRCDA_",",9)=12
 D UPDATE^DIE("","FDA(1)",,"GMRCERR") ;file last action and status
 D  ;send notifications
 . I $P(^GMR(123,GMRCDA,12),U,5)="F" Q  ;DIS from placer before IFC
 . N GMRCORTX
 . S GMRCORTX="Remote result removed from "_$$ORTX^GMRCAU(+GMRCDA)
 . D MSG^GMRCP($P(^GMR(123,GMRCDA,0),U,2),GMRCORTX,GMRCDA,63,,1)
 D  ;send appl ACK
 . D APPACK^GMRCIAC2(GMRCDA,"AA") ; send app. ACK and unlock record
 K ^TMP("GMRCID",$J)
 Q
 ;
OTHER(GMRCAR,GMRCCRNR,GMRCMSGI) ;process most IFC actions
 ;will process the receive, schedule, DC, cancel and added comment action
 ;
 ;Input:
 ; GMRCAR = array name containing message
 ;      e.g.  ^TMP("GMRCIF",$J)
 ; GMRCCRNR = 1 if message came from Cerner
 ; GMRCMSGI = message ID
 ;
 N GMRCDA,GMRCFDA,GMRCORC,GMRCLAT,GMRCACT,GMRCROL,FDA
 K ^TMP("GMRCIN",$J)
 M ^TMP("GMRCIN",$J)=@GMRCAR
 ;
 S GMRCORC=^TMP("GMRCIN",$J,"ORC")
 S GMRCDA=$$GETDA^GMRCIAC2(GMRCORC)  ;get ien to work on
 S GMRCROL=$P(^GMR(123,GMRCDA,12),U,5)
 S GMRCCRNR=$G(GMRCCRNR,0),GMRCMSGI=$G(GMRCMSGI) ;MKN GMRC*3*154
 I '$$LOCKREC^GMRCUTL1(GMRCDA) D  Q  ;couldn't lock record
 . D APPACK^GMRCIAC2(GMRCDA,"AR",901,GMRCCRNR,GMRCMSGI,$NA(^TMP("GMRCIN",$J))) ; send app. ACK ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI. P205 WTC 8/22/24
 . K ^TMP("GMRCIN",$J) Q
 ;
 I $P(GMRCORC,"|")'="IP" D  ; status update
 . N GMRCOS S GMRCOS=$P(GMRCORC,"|",5)
 . S GMRCFDA(8)=$S(GMRCOS="IP":6,GMRCOS="SC":8,GMRCOS="CA":13,1:1)
 . ; IP=receive, SC=schedule, CA=cancel, DC=discontinue
 D  ; get last action taken
 . I '$G(GMRCFDA(8)) S (GMRCFDA(9),GMRCLAT)=20 Q
 . ;
 . ;  Set last action taken to STATUS CHANGE (3) if appointment unscheduled and filler is converted site.  p205 wtc 8/20/24
 . ;
 . I GMRCFDA(8)=6 S (GMRCFDA(9),GMRCLAT)=21 Q:'$$CNVTD^GMRCIEVT(GMRCDA)  S:$P($P(GMRCORC,"|",16),U,1)="U" (GMRCFDA(9),GMRCLAT)=3 ; 
 . I GMRCFDA(8)=8 S (GMRCFDA(9),GMRCLAT)=8 Q
 . I GMRCFDA(8)=1 S (GMRCFDA(9),GMRCLAT)=6 Q
 . I GMRCFDA(8)=13 S (GMRCFDA(9),GMRCLAT)=19 Q
 ;                         ^--last action taken
 ;    v-- check to see if a dup transmission
 I $$DUPACT^GMRCIAC2(GMRCDA,GMRCLAT,GMRCORC,,GMRCCRNR,GMRCMSGI) K ^TMP("GMRCIN",$J) Q  ;MKN GMRC*3*154 added GMRCCRNR and GMRCMSGI ;p193
 ;
 M FDA(1,123,GMRCDA_",")=GMRCFDA
 D UPDATE^DIE("","FDA(1)",,"GMRCERR") ;file last action and update status
 K GMRCFDA
 ;
 ;  Add comment that appointment has been cancelled by converted filler site.  wtc p205 8/15/24
 ;
 I $$CNVTD^GMRCIEVT(GMRCDA),$P(GMRCORC,"|")="SC",$P(GMRCORC,"|",5)="IP",GMRCLAT=3 D  ;
 . N OBXIDX S OBXIDX=$O(^TMP("GMRCIN",$J,"OBX",3,"A"),-1) I 'OBXIDX S OBXIDX=0 ;
 . S OBXIDX=OBXIDX+1,^TMP("GMRCIN",$J,"OBX",3,OBXIDX)="3|TX|^COMMENTS^|"_OBXIDX_"|Appointment has been cancelled." ; 
 ;
 D FILEACT^GMRCIAC2(GMRCDA,GMRCLAT,,$NA(^TMP("GMRCIN",$J)),$G(GMRCCRNR),$$GET1^DIQ(123,GMRCDA,.07,"I")) ; P184
 D  ;send notifications
 . N GMRCTX,GMRCNOT,GMRCFL
 . S GMRCFL=1
 . I GMRCLAT=20!(GMRCLAT=8)!(GMRCLAT=21) D
 .. I GMRCLAT=20 D  I '$D(GMRCTX) Q
 ... I $P(^GMR(123,GMRCDA,40,1,0),U,2)'=24 D  Q
 .... S GMRCTX="Comment Added to remote"
 ... N ACT S ACT=1
 ... F  S ACT=$O(^GMR(123,GMRCDA,40,ACT)) Q:'ACT!($D(GMRCTX))  D
 .... I $P(^GMR(123,GMRCDA,40,ACT,0),U,2)=25,$O(^GMR(123,GMRCDA,40,ACT)) D
 ..... S GMRCTX="Comment Added to remote"
 .. I '$D(GMRCTX),GMRCROL="F" Q  ;sch & rec on filler part of FWD 2 IFC
 .. I GMRCLAT=8 S GMRCTX="Scheduled remote"
 .. I GMRCLAT=21 S GMRCTX="Received remote"
 .. S GMRCTX=GMRCTX_" Consult: "_$$ORTX^GMRCAU(+GMRCDA)
 .. S GMRCNOT=63
 . I GMRCLAT=6 D
 .. S GMRCFL=$$DCNOTE^GMRCADC(GMRCDA,.5)
 .. S GMRCTX="Discontinued remote Consult: "_$$ORTX^GMRCAU(+GMRCDA)
 .. S GMRCNOT=23
 . I GMRCLAT=19 D
 .. I GMRCROL="F" Q  ;canc on a filler is part of FWD 2 IFC
 .. S GMRCTX="Cancelled remote Consult: "_$$ORTX^GMRCAU(+GMRCDA)
 .. S GMRCNOT=30
 . I '$D(GMRCNOT) Q  ;don't send any alerts
 . D MSG^GMRCP($P(^GMR(123,GMRCDA,0),U,2),GMRCTX,GMRCDA,GMRCNOT,,GMRCFL)
 ;
 D  ;send appl ACK
 . D APPACK^GMRCIAC2(GMRCDA,"AA") ;send app. ACK and unlock record
 K ^TMP("GMRCIN",$J)
 Q  ;
 ;
