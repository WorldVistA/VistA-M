GMRCIUT1 ;SLC/JFR - UTILITIES FOR INTER-FACILITY CONSULTS ; Jan 27, 2025@06:04:10
 ;;3.0;CONSULT/REQUEST TRACKING;**189,205**;DEC 27, 1997;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ;don't start at the top
 ;
CHKPROXY(GMRCDA,GMRCDFN,STA,DONOTLOG) ;
 ;
 ;  GMRCDA   = Consult, pointer to #123
 ;  GMRCDFN  = Patient, pointer to #2
 ;  STA      = Routing station number
 ;  DONOTLOG = Flag to prevent logging in IFC Message Log (#123.6).  1=DO NOT LOG. [OPTIONAL]
 ;
 ;  Checks success/failure of proxy add.  Returns 1 if all is OK and IFC can be sent, 0^REASON if not.
 ;
 ;pull patient Correlation list
 ;
 N DGKEY,DGOUT,CNT,IDS,CERNERID,CONSULTDFN,RTNCODE,EDIPI ;
 ;
 S DGKEY=GMRCDFN_U_"PI"_U_"USVHA"_U_$P($$SITE^VASITE,"^",3)
 D TFL^VAFCTFU2(.DGOUT,DGKEY)
 ; 
 S CONSULTDFN="",CERNERID="" ;
 S CNT=0 F  S CNT=$O(DGOUT(CNT)) Q:'CNT  S IDS=$G(DGOUT(CNT)) D  ;
 .I $P(IDS,"^",4)="200CRNR" I $P(IDS,"^",2)="PI" S CERNERID=IDS ;
 .I $P(IDS,"^",4)=STA I $P(IDS,"^",2)="PI" I $P(IDS,"^",5)="A"!($P(IDS,"^",5)="C") S CONSULTDFN=IDS ;
 ;
 ;  Destination site is converted.
 ;
 I $$CRNRSITE^VAFCCRNR(STA)=1 D  Q RTNCODE ;
 . I CERNERID'="",CONSULTDFN'="" S RTNCODE=1 Q  ;
 . ;
 . I CERNERID="" S RTNCODE="0^CERNER INCOMPLETE" Q  ;
 . ;
 . I CONSULTDFN="" D  Q  ;
 .. ;
 .. ;  Call proxy add for converted VistA.
 .. ;
 .. S EDIPI=$$EDIPI^GMRCIUTL(GMRCDFN) ;
 .. S RTNCODE=$$ADD^DGPROSAD(EDIPI_"~USDOD~NI~200DOD",STA) ;  ICR 7421
 .. I RTNCODE<0 D  ;  Proxy add failed.
 ... I '$G(DONOTLOG) D LOGMSG^GMRCIUTL(GMRCDA,1,"",205) ;
 ... D FAILPRXY("",EDIPI,GMRCDA,"","","",STA,$P(RTNCODE,U,2)) ; P189 WTC 6/24/24
 ... S RTNCODE="0^CONVERTED VISTA INCOMPLETE" ;
 .. Q:$G(DONOTLOG)  ;
 .. ;
 .. ;  Suppress 201 error if IFC already has a 203 error in the message log.  wtc 11.22.23 p189
 .. ;
 .. N ACTIEN,SUPPRESS,LOGIEN S SUPPRESS=0,ACTIEN=0 F  S ACTIEN=$O(^GMR(123.6,"AC",GMRCDA,ACTIEN)) Q:'ACTIEN  D  Q:SUPPRESS  ;
 ... S LOGIEN=0 F  S LOGIEN=$O(^GMR(123.6,"AC",GMRCDA,ACTIEN,1,LOGIEN)) Q:'LOGIEN  I $P($G(^GMR(123.6,LOGIEN,0)),U,8)=203 S SUPPRESS=1 Q  ;
 .. ;
 .. I 'SUPPRESS D LOGMSG^GMRCIUTL(GMRCDA,1,"",201) ;
 ;
 ;  Destination site is non-converted.
 ;
 I $$CRNRSITE^VAFCCRNR(STA)'=1 D  Q RTNCODE ;
 . I CONSULTDFN'="" S RTNCODE=1 Q  ;
 . ;
 . S RTNCODE="0^NON-CONVERTED VISTA INCOMPLETE" ;
 . D LOGMSG^GMRCIUTL(GMRCDA,1,"",201) ;
 ;
 Q "0^UNKNOWN" ;
 ;
FAILPRXY(MSGID,EDIPI,GMRCDA,CRNRORDR,ORDRDESC,ORDRDATE,STA,REASON) ;
 ;
 ;  Send MailMan message when proxy add fails.
 ;
 ;  MSGID    = HL7 Message ID (MSH-10) [OPTIONAL]
 ;  EDIPI    = Patient's EDIPI [OPTIONAL]
 ;  GMRCDA   = Consult IEN (pointer to #123) [OPTIONAL]
 ;  CRNRORDR = Cerner order number [OPTIONAL]
 ;  ORDRDESC = Ordering description [OPTIONAL]
 ;  ORDRDATE = Ordering date in HL7 format [OPTIONAL]
 ;  STA      = Station where proxy add attempted [OPTIONAL]
 ;  REASON   = Proxy add failure reason [REQUIRED]
 ;
 Q:$G(REASON)=""  ;
 ;
 N XMSUB,XMDUZ,XMTEXT,XMY,GRPIEN,MEM,GRP,N ;
 S GRP="IFC PATIENT ERROR MESSAGES" ;
 S XMSUB="Failed IFC transaction: Proxy Add Failed",XMTEXT="XMTEXT(" ;
 S N=0 ;
 I $G(MSGID)'="" S N=N+1,XMTEXT(N)="Message ID: "_MSGID ;
 I $G(EDIPI)'="" S N=N+1,XMTEXT(N)="EDIPI: "_EDIPI ;
 I $G(GMRCDA)'="" S N=N+1,XMTEXT(N)="Consult Number: "_GMRCDA ;
 I $G(CRNRORDR)'="" S N=N+1,XMTEXT(N)="Cerner Order Number: "_CRNRORDR ;
 I $G(ORDRDESC)'="" S N=N+1,XMTEXT(N)="Order Description: "_ORDRDESC ;
 I $G(ORDRDATE)'="" S N=N+1,XMTEXT(N)="Order Date: "_$$FMTE^XLFDT($$HL7TFM^XLFDT(ORDRDATE)) ;
 I $G(STA)'="" S N=N+1,XMTEXT(N)="Station where proxy add attempted: "_STA ;
 S N=N+1,XMTEXT(N)="Failure Reason: "_REASON ;
 S GRPIEN=$O(^XMB(3.8,"B",GRP,"")) Q:'GRPIEN
 ;Set up XMY for MEMBERS
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,1,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,1,MEM,0),U))=""
 ;Set up XMY for MEMBERS REMOTE
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,6,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,6,MEM,0),U))=""
 Q:'$D(XMY)
 S XMDUZ=GRP
 D XMZ^XMA2 ; call Create Message Module
 D EN1^XMD
 Q  ;
 ;
RESP(GMRCAC,GMRCMID,GMRCOC,GMRCDA,GMRCERR,GMRCMSG) ;
 ;
 ;  Send ACK or NAK to Cerner followed by rejection comment. P205 wtc 8/15/24
 ;
 ; Input:
 ;   GMRCAC  = acknowledgement code (AA or AR)
 ;   GMRCMID = message id from original msg
 ;   GMRCOC  = order control from original msg ORC
 ;   GMRCDA  = ien of consult being worked on
 ;   GMRCERR = only defined if an error is found
 ;   GMRCMSG = name of array where incoming HL7 stored
 ;
 N HLA S HLA("HLA",1)=$$MSA^GMRCISEG(GMRCAC,GMRCMID,$G(GMRCERR))
 ;
 ;  Generate PID segment for Cerner orders.  Insert EDIPI and patient account number.  p184
 ;
 N DFN,PID,EDIPI,ICN,PTACCTNO,FS,CS,REPTTN,SEGNUM,PTACCTNO,GMRCRSLT ;
 S SEGNUM=1 ;
 I $G(GMRCDA) D  ;
 . S DFN=$P(^GMR(123,GMRCDA,0),U,2),PTACCTNO=$P($G(^GMR(123,GMRCDA,"CERNER")),U,3) ;
 . I PTACCTNO'="" D  ;
 .. S HLECH=HL("ECH"),PID=$$EN^VAFCPID(DFN,"1,2,3,7,8,19"),PID=$$ADD2PID^GMRCIUTL(PID,DFN,PTACCTNO) ;
 .. S SEGNUM=SEGNUM+1,HLA("HLA",SEGNUM)=PID ;
 ;
 I $D(GMRCOC) D
 . I GMRCOC="NW" S SEGNUM=SEGNUM+1,HLA("HLA",SEGNUM)=$$ORCRESP^GMRCISG1(GMRCDA,"OK","IP")
 ;
 ;  Generate OBR segment for Cerner orders.  p184
 ;
 I $G(GMRCDA) S SEGNUM=SEGNUM+1,HLA("HLA",SEGNUM)=$$OBR^GMRCISG1(GMRCDA),HLA("HLA",SEGNUM)=$$ADD2OBR^GMRCIUTL(HLA("HLA",SEGNUM),GMRCDA) ;
 ;
 ;  Send ACK/NAK to Cerner.
 ;
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.GMRCRSLT) ;-(
 ;
 Q:GMRCAC="AA"  ;
 ;
 ;  Send rejection comment along with original order message.
 ;
 N HL,HLL,HLP,ERRTEXT,OBR,IDX,STA,I ;
 ;
 D INIT^HLFNC2("GMRC IFC ORM EVENT",.HL)
 ;
 K ^TMP("GMRCIUT1",$J) M ^TMP("GMRCIUT1",$J)=@GMRCMSG ;
 ;
 K ^TMP("HLS",$J) S SEGNUM=1,^TMP("HLS",$J,SEGNUM)="PID|"_^TMP("GMRCIUT1",$J,"PID") ;
 S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="ORC|"_^TMP("GMRCIUT1",$J,"ORC") ;
 ;
 ;  Change order control and status to "add comment" (IP/IP).  WTC 10/21/24
 ;
 S $P(^TMP("HLS",$J,SEGNUM),"|",2)="IP",$P(^TMP("HLS",$J,SEGNUM),"|",6)="IP" ;
 ;
 S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBR|"_^TMP("GMRCIUT1",$J,"OBR"),OBR="OBR|"_^TMP("GMRCIUT1",$J,"OBR") ;
 ;
 S IDX=0 F  S IDX=$O(^TMP("GMRCIUT1",$J,"OBX",1,IDX)) Q:'IDX  S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|"_^TMP("GMRCIUT1",$J,"OBX",1,IDX) ;
 ;
 S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|3|TX|^COMMENTS^|1| ||||||P" ;
 S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|3|TX|^COMMENTS^|2|Activity Type: Order Rejected||||||P" ;
 S ERRTEXT="ERR"_GMRCERR_"^GMRCIUTL" ;
 S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|3|TX|^COMMENTS^|3|Rejection Reason: "_GMRCERR_" - "_$P($T(@ERRTEXT),";",2)_"||||||P" ;
 S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|3|TX|^COMMENTS^|4|Entered At Location: "_$P($$SITE^VASITE(),U,2)_"||||||P" ;
 S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|3|TX|^COMMENTS^|5|"_$$FMTE^XLFDT($$NOW^XLFDT())_"||||||P" ;
 ;
 S IDX=0 F I=6:1 S IDX=$O(^TMP("GMRCIUT1",$J,"OBX",3,IDX)) Q:'IDX  S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|3|TX|^COMMENTS^|"_I_"|"_^TMP("GMRCIUT1",$J,"OBX",3,IDX) ;
 ;
 S IDX=0 F  S IDX=$O(^TMP("GMRCIUT1",$J,"OBX",5,IDX)) Q:'IDX  S SEGNUM=SEGNUM+1,^TMP("HLS",$J,SEGNUM)="OBX|"_^TMP("GMRCIUT1",$J,"OBX",5,IDX) ;
 ;
 S STA=$P($P(OBR,"|",3),"^",2) ;
 S HLL("LINKS",1)="GMRC IFC SUBSC^"_$$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)_U_STA ;
 S HLP("SUBSCRIBER")="^^^^"_$P(HLL("LINKS",1),U,3) ;
 D GENERATE^HLMA("GMRC IFC ORM EVENT","GM",1,,,.HLP) ;
 ;
 ;  Save message in HL7 repository.
 ;
 N ERR ;
 K ^TMP("GMRCIUT1",$J) F IDX=1:1 Q:'$D(^TMP("HLS",$J,IDX))  S ^TMP("GMRCIUT1",$J,IDX,0)=^TMP("HLS",$J,IDX) ;
 S ERR=$$SAVEHL7X^EHMHL7("GMRCIUT1","IFC","VISTA-"_$$STA^XUAF4($$KSP^XUPARAM("INST")),"CERNER-"_$P($P(OBR,"|",3),"^",2),"|","^",$E(HL("ECH"),2)) ;
 ;
 K ^TMP("GMRCIUT1",$J) ;
 Q
 ;
