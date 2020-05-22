SDHL7APU ;MS/TG,PH - TMP HL7 Routine;OCT 16, 2018
 ;;5.3;Scheduling;**704,714**;AUG 17, 2018;Build 80
 ;
 ;  Integration Agreements:
 Q
 ;
 ;Helper routine to process SIU^S12 messages from the "TMP VISTA" Subscriber protocol
 ;
MSH(MSH,INP,MSGARY) ;
 S MSGARY("HL7EVENT")=$G(MSH(8,1,2))
 S MSGARY("HLTHISSITE")=+$G(MSH(5,1,1))
 Q
SCH(SCH,INP,MSGARY) ;
 N TM,TMM,CONSDSC,CANCODE
 S SDAPTYP="A|"
 S SDECATID=$G(SCH(6))
 S MSGARY("EVENT")=$G(SCH(6,1,1))  ;if the appointment is canceled check for cancel code and cancel reason, they are required
 S (SDECCR,CANCODE)=$G(SCH(6,1,2))
 I $G(MSGARY("EVENT"))="CANCELED" D
 . Q:$G(SDECCR)=""
 . S SDECCR=$O(^SD(409.2,"B",$G(CANCODE),0))
 . S:(SDECCR)="" SDECCR=11
 . S SDECTYP=$G(SCH(6,1,4))
 ;S SDECNOT=$G(SCH(6,1,5))
 S SDECLEN=$G(SCH(9))
 ;S MSGARY("SDECLENUNITS")=$G(SCH(10))
 S TM=$G(SCH(11,1,4))
 I $G(SDDDT)="" S:$G(SCH(11,1,8))'="" SDDDT=$G(SCH(11,1,8))
 I $G(SDDDT)="" S:$G(SCH(5,1,2))'="" SDDDT=$G(SCH(5,1,2))
 S:$G(TM)'="" SDECSTART=$P(TM,":",1,2)_":00Z"
 ;S INP(11)=$G(SDDDT)
 S SDREQBY=$G(SCH(16,1,1))
 N SCHEMAIL S SCHEMAIL=$$LOW^XLFSTR(SCH(13,1,4))
 S (DUZ,MSGARY("DUZ"))=$O(^VA(200,"ADUPN",$G(SCHEMAIL),""))
 S:$G(DUZ)'>0 (DUZ,MSGARY("DUZ"))=.5
 N SDTYP S SDTYP=$G(SCH(6,1,4))
 I $G(SDTYP)="R" D
 .S (RTCID,SDCHILD)=$G(SCH(7,1,1)),SDPARENT=$G(SCH(24,1,1))
 .S:$G(SDCHILD)="" (RTCID,SDCHILD)=$G(SCH(7,1,4))
 .S SDAPTYP="R|"_$G(SDCHILD)
 .S:$P($G(^SDEC(409.85,$G(SDCHILD),3)),"^",1)>0 SDMTC=1
 .I $G(SDPARENT)>0 S:$P($G(^SDEC(409.85,$G(SDPARENT),3)),"^",1)>0 SDMTC=1
 S:$G(SDTYP)="" SDTYP="A",SDAPTYP="A|"
 S:$G(SDTYP)="A" SDTYP="A",SDAPTYP="A|"
 ;
 Q
SCHNTE(SCHNTE,INP,MSGARY) ; 
 ;
 S SDECNOTE=$G(SCHNTE(3))
 I $G(MSGARY("EVENT"))="CANCELED" S SDECNOT=$G(SCHNTE(3))
 Q
PID(PID,INP,MSGARY) ;
 ;
 S MSGARY("MPI")=$G(PID(3,1,1))
 S DFN=$$GETDFN^MPIF001(MSGARY("MPI"))
 Q
 ;
PV1(PV1,INP,MSGARY) ;
 Q
 ;
OBX(OBX,INP) ;
 Q
 ;
RGS(RGS,CNT,INP) ;
 S:$D(RGS) RGS(CNT,1)=1
 S MSGARY("FACILITYIEN")=$G(RGS(1,3))
 Q
 ;
AIS(AIS,CNT,INP,MSGARY) ;
 S:$D(AIS) AIS(CNT,1)=1
 Q
 ;
AISNTE(AISNTE,CNT,INP) ;
 S:$D(AISNTE) AISNTE(CNT,1)=1
 Q
 ;
AIG(AIG,CNT,INP) ;
 S:$D(AIG) AIG(CNT,1)=1
 Q
 ;
AIGNTE(AIGNTE,CNT,INP) ;
 S:$D(AIGNTE) AIGNTE(CNT,1)=1
 Q
 ;
AIL(AIL,CNT,INP,MSGARY) ;
 ;
 S:$D(AIL) AIL(CNT,1)=1
 N STCREC
 S STCREC=""
 S INP(6)=$G(AIL(1,3,1,1))
 S (SDCL)=$G(AIL(1,3,1,1))
 S:$G(AIL(2,3,1,1))'="" SDCL2=$G(AIL(2,3,1,1))
 S:$G(SDCL2)=$G(SDCL) SDCL3=1
 S INP(4)=$$NAME^XUAF4(+$G(AIL(1,3,1,4)))
 ;CLINIC STOP CODE
 D GETSTC^SDECCON(.STCREC,$P($G(SDCL),U,1))
  I $G(AIL(1,4,1,2))="C" D
 .N XSDDDT,GMRDA
 .S GMRDA=$G(AIL(1,4,1,1)) S:$$LOW^XLFSTR($G(GMRDA))="undefined" GMRDA=""
 .S XSDDDT=$$GET1^DIQ(123,$G(GMRDA)_",",17,"I") S SDDDT=$$FMTE^XLFDT(XSDDDT)
 .S SDAPTYP="C|"_$G(GMRDA)
 .S:$G(GMRDA)=""!($G(GMRDA)'>0) SDAPTYP="A|"  ;PB - Oct 24, Patch 714, put in to set SDAPTYP as a walkin - stops any looping issues
 S:$G(AIL(1,3,1,4))=$G(AIL(2,3,1,4)) INTRA=1
 I $G(AIL(1,4,1,2))="A" S SDAPTYP="A|"
 I $G(AIL(1,4,1,2))="R" S SDAPTYP="R|"_$G(AIL(1,4,1,4))
 Q
AILNTE(AILNTE,CNT,INP) ;
 S:$D(AILNTE) AILNTE(CNT,1)=1
 S AILNTE=$G(AILNTE(1,3,2))
 I AILNTE="" S AILNTE=$G(AILNTE(1,3))
 Q
 ;
AIP(AIP,CNT,INP,MSGARY) ;
 S:$D(AIP) AIP(CNT,1)=1
 S MSGARY("PROVIEN")=$G(AIP(1,3))
 Q
 ;
AIPNTE(AIPNTE,CNT,INP,MSGARY) ;
 S:$D(AIPNTE) AIPNTE(CNT,1)=1
 Q 
 ;
CHKCHILD ;
 N MTC,FIRST
 K RTCCLIN
 I $P($G(SDAPTYP),"|",1)="R" D  ; if rtc check to see if the child is actually a parent
 .I $G(SDPARENT)="" S:$G(SCH(24,1,1))'="" SDPARENT=$G(SCH(24,1,1))
 .I $G(SDPARENT)="" S:$G(SCH(23,1,1))'="" SDPARENT=$G(SCH(23,1,1))
 .;I $G(SDCHILD)=$G(SDPARENT) 
 .S:$G(SDPARENT)>0 MTC=$P($G(^SDEC(409.85,+$G(SDPARENT),3)),"^",3),SDMRTC=$S(MTC>0:"1",1:0)
 .Q:$G(MTC)=0  ; Not a multi RTC
 .S:$G(SDCL)>0 RTCCLIN=$P(^SDEC(409.85,$G(SDPARENT),0),"^",9)
 .S DUZ=$G(MSGARY("DUZ"))
 .Q:$G(RTCCLIN)'=SDCL
 .N X12,X13 S (X12,X13)=0 F  S X12=$O(^SDEC(409.85,$G(SDPARENT),2,X12)) Q:X12'>0  S X13=X12
 .Q:$G(X13)=MTC!($G(X13)>MTC)
 .I $G(MTC)>0 F I=1:1:MTC Q:I>MTC  D
 ..S:INP(3)="" INP(3)=DT S INP(25)=SDPARENT,INP(6)=$P(^SDEC(409.85,SDPARENT,0),"^",9),RTN=0
 ..S INP(5)="RTC",INP(1)="",INP(14)="YES",INP(15)=$P($G(^SDEC(409.85,SDPARENT,3)),"^",2),INP(16)=I
 ..D ARSET^SDHLAPT1(.RTN,.INP)
 ..I I=1 S:$P($G(RTN),"^",2)>0 FCHILD=$P(RTN,"^",2)
 .Q
 Q
VALIDMSG(MSGROOT,QRY,XMT,ERR)   ;Validate message
 ;
 ;  Messages handled: SIU^S12
 ;
 ;  SIU query messages must contain QPD and RCP segments
 ;  Any additional segments are ignored
 ;
 ;  Input:
 ;    MSGROOT - Root of array holding message
 ;        XMT - Transmission parameters
 ;
 ; Output:
 ;      
 ;        XMT - Transmission parameters
 ;        ERR - segment^sequence^field^code^ACK type^error text
 ;
 N MSH,QPD,REQID,REQTYPE,QTAG,QNAME,RDF
 N SEGTYPE,CNT
 K QRY,ERR
 S ERR=""
 ;
 Q 1
 ;
PARSESEG(SEG,DATA,HL) ;Generic segment parser
 ;This procedure parses a single HL7 segment and builds an array
 ;subscripted by the field number containing the data for that field.
 ; Does not handle segments that span nodes
 ;
 ;  Input:
 ;     SEG - HL7 segment to parse
 ;      HL - HL7 environment array
 ;
 ;  Output:
 ;    Function value - field data array [SUB1:field, SUB2:repetition,
 ;                                SUB3:component, SUB4:sub-component]
 ;
 N CMP     ;component subscript
 N CMPVAL  ;component value
 N FLD     ;field subscript
 N FLDVAL  ;field value
 N REP     ;repetition subscript
 N REPVAL  ;repetition value
 N SUB     ;sub-component subscript
 N SUBVAL  ;sub-component value
 N FS      ;field separator
 N CS      ;component separator
 N RS      ;repetition separator
 N SS      ;sub-component separator
 ;
 K DATA
 S FS=HL("FS")
 S CS=$E(HL("ECH"))
 S RS=$E(HL("ECH"),2)
 S SS=$E(HL("ECH"),4)
 ;
 S DATA(0)=$P(SEG,FS)
 S SEG=$P(SEG,FS,2,9999)
 ;
 F FLD=1:1:$L(SEG,FS) D
 . S FLDVAL=$P(SEG,FS,FLD)
 . F REP=1:1:$L(FLDVAL,RS) D
 . . S REPVAL=$P(FLDVAL,RS,REP)
 . . I REPVAL[CS F CMP=1:1:$L(REPVAL,CS) D
 . . . S CMPVAL=$P(REPVAL,CS,CMP)
 . . . I CMPVAL[SS F SUB=1:1:$L(CMPVAL,SS) D
 . . . . S SUBVAL=$P(CMPVAL,SS,SUB)
 . . . . I SUBVAL'="" S DATA(FLD,REP,CMP,SUB)=SUBVAL
 . . . I '$D(DATA(FLD,REP,CMP)),CMPVAL'="" S DATA(FLD,REP,CMP)=CMPVAL
 . . I '$D(DATA(FLD,REP)),REPVAL'="",FLDVAL[RS S DATA(FLD,REP)=REPVAL
 . I '$D(DATA(FLD)),FLDVAL'="" S DATA(FLD)=FLDVAL
 Q
 ;
PARSEMSG(MSGROOT,HL) ; Message Parser
 ; Does not handle segments that span nodes
 ; Does not handle extremely long segments (uses a local)
 ; Does not handle long fields (segment parser doesn't)
 ;
 N SEG,CNT,DATA,MSG
 F CNT=1:1 Q:'$D(@MSGROOT@(CNT))  M SEG=@MSGROOT@(CNT) D
 . D PARSESEG(SEG(0),.DATA,.HL)
 . K @MSGROOT@(CNT)
 . I DATA(0)'="" M @MSGROOT@(CNT)=DATA
 . Q:'$D(SEG(1))
 . Q
 Q
 ;
SEND() ;
 Q
ACKIN ;
 Q
INP ; set up the INP array for calling ARSET^SDECAR2 to update the RTC orders
 ; Need to add code to add the rtcparent to the HL7 message and to parse it out. 
 N NODE3,INTV,NUMAPT,ORDATE,SDCHILD,SDPARENT
 K INP
 S:$G(MSGARY("PROVIEN"))>0 INP(10)=$$GET1^DIQ(200,$G(MSGARY("PROVIEN"))_",",.01,"E")
 ;
 S SDPARENT=$G(SCH(24,1,1))
 S PCE="" S PCE=$P($G(^DPT($G(DFN),"ENR")),U,1) I PCE'="" D
 .S INP(13)=$$GET1^DIQ(27.11,PCE,.07,"E")
 S:$G(SDMRTC)'="" INP(14)=$S(SDMRTC=1:"YES",SDMRTC=0:"NO",1:"")
 ;I $G(SDPARENT)'="" S SDPARENT=$G(MSGARY("SDPARENT"))
 I +$G(SDPARENT)>0 S NODE3=$G(^SDEC(409.85,+SDPARENT,3)),INTV=$P(NODE3,"^",2)
 S INP(1)=$P(SDAPTYP,"|") ;If a new RTC order this will be null so it will be added to the file. If this is not null, an update happens
 S INP(2)=$G(DFN)
 D NOW^%DTC S NOW=$$HTFM^XLFDT($H),INP(3)=$$FMTE^XLFDT(NOW)
 ;NEEDS THE TEXT INSTITUTION NAME
 S INP(4)=$$NAME^XUAF4(+$G(DUZ(2))) ;Required, DUZ(2) is the signed on users division they are signed into, +DUZ(2) is the parent station number
 S INP(5)="APPT"
 S INP(6)=$G(SDCL)
 S INP(7)="" ;null for TMP appointments or can we get this from the original RTC order?
 S INP(8)="FUTURE"
 N X11 S X11=$P($G(SDAPTYP),"|") S:$G(X11)="" X11="A"
 S INP(9)=$S(X11="A":"PATIENT",1:"PROVIDER") ;request by provider or patient. RTC orders and consults will always be PROVIDER otherwise it is PATIENT
 S:$G(MSGARY("PROVIEN"))>0 INP(10)=$$GET1^DIQ(200,$G(MSGARY("PROVIEN"))_",",.01,"E") ;Provider name - needs to be in lastname,firstname middle initial.
 S SDDDT=$G(SCH(5,1,2))
 S:$G(SDDDT)="" SDDDT=$G(SCH(11,1,8))
 S:$G(SDDDT)="" SDDDT=$P($G(SDECSTART),"T",1) ; Clinically Indicate Date for first appointment in the sequence, each of the remaining appointments have to be calculated
 S INP(11)=$G(SDDDT)
 S INP(12)=$G(SDECNOTE) ; RTC comments these are different than the comments that are stored in in file 44 appointment multiple. 
 S PCE="" S PCE=$P($G(^DPT(DFN,"ENR")),U,1) I PCE'="" D
 .S INP(13)=$$GET1^DIQ(27.11,PCE,.07,"E")
 S INP(14)=""
 S:$G(SDMRTC)'="" INP(14)=$S(SDMRTC=1:"YES",SDMRTC=0:"NO",1:"NO")  ; SDMRTC=1:YES
 S INP(15)=$G(INTV) ;If MRTC, the interval in days between appointments
 S INP(16)=$G(AIL(1,4,1,4)) ;If MRTC, the appointment number for this appointment
 S INP(17)="" ;null for TMP
 N SCXX S SCXX=$S($G(SDPARENT)>0:$$GET1^DIQ(409.85,SDPARENT_",",15,"I"),1:0)
 S INP(18)=$S($G(SCXX)=1:"YES",1:"NO")  ;is this service connected? we can get this from the parent
 S SCPERC=0
 S SCPERC=$P(^DPT($G(INP(2)),.3),"^",2)
 S INP(19)=SCPERC
 S INP(22)="9"
 S INP(23)="NEW"
 S:$G(SDCHILD)=$G(SDPARENT) SDPARENT=""
 S INP(25)=$G(SDPARENT)
 S:$G(SDPARENT)>0 INP(28)=$P($G(^SDEC(409.85,+SDPARENT,7)),U,1)  ; this is the CPRS order number
 S:$G(INP(28))>0 INP(26)=$P($G(^SDEC(409.85,+SDPARENT,7)),U,2)
 Q
ARSET(X) ; set the appointment requests into 409.85
 Q
 S STOP=0
 I $G(X)'>0 Q STOP
 I $G(^SDEC(409.85,X,0))="" Q STOP
 I $G(^SDEC(409.85,X,3),"^")=1 D  ; it is a multiple appointment rtc order
 .S INTV=$P(^SDEC(409.85,X,3),"^",2),NUMAPT=$P(^SDEC(409.85,X,3),"^",3)
 Q
LOADMSG(MSGROOT) ; Load HL7 message into temporary global for processing
 ;
 ;This subroutine assumes that all VistA HL7 environment variables are
 ;properly initialized and will produce a fatal error if they aren't.
 ;
 N CNT,SEG
 K @MSGROOT
 F SEG=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0
 . S @MSGROOT@(SEG,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  S @MSGROOT@(SEG,CNT)=HLNODE(CNT)
 . Q
 Q 
LOADXMT(HL,XMT) ;Set HL dependent XMT values
 ;
 ; The HL array and variables are expected to be defined.  If not,
 ; message processing will fail.  These references should not be
 ; wrapped in $G, as null values will simply postpone the failure to
 ; a point that will be harder to diagnose.  Except HL("APAT") which
 ; is not defined on synchronous calls.
 ;
 ;  Integration Agreements:
 ;         1373 : Reference to PROTOCOL file #101
 ;
 N SUBPROT,RESPIEN,RESP0
 ;S HL("EID")=$$FIND1^DIC(101,,,"TMP QBP-Q13 Event Driver")
 ;S HL("EIDS")=$$FIND1^DIC(101,,,"TMP QBP-Q13 Subscriber")
 S HL("EID")=$$FIND1^DIC(101,,,"SD TMP S12 SERVER EVENT DRIVER")
 S HL("EIDS")=$$FIND1^DIC(101,,,"SD TMP S12 CLIENT SUBSCRIBER")
 ;S HLL("LINKS",1)="SD IFS SUBSCRIBER^TMP_SEND"
 S XMT("MID")=HL("MID")                ;Message ID
 S XMT("MODE")="A"                        ;Response mode
 I $G(HL("APAT"))="" S XMT("MODE")="S"    ;Synchronous mode
 S XMT("MESSAGE TYPE")=HL("MTN")          ;Message type
 S XMT("EVENT TYPE")=HL("ETN")            ;Event type
 S XMT("DELIM")=HL("FS")_HL("ECH")        ;HL Delimiters
 ;S XMT("DELIM")="~^\&"
 S XMT("MAX SIZE")=0                      ;Default size unlimited
 ;
 ; Map response protocol and builder
 S SUBPROT=$P(^ORD(101,HL("EIDS"),0),"^")
 Q
ERRLKP(ERRTXT) ;
 N ERTXI,ERTX1,ERTX2,X,XSP,ERTXT
 S ERTXT=ERRTXT
 S XSP=0
 F ERTXI=1:1 S X=$P($TEXT(ERRS+ERTXI),";;",2) Q:X=""  Q:XSP  D
 . S ERTX1=$P(X,"^",1)
 . S ERTX2=$P(X,"^",2)
 . I ERTX1'="",ERTX2'="" I ERTXT[ERTX1 S ERTXT=ERTX2,XSP=1
 . Q
 Q ERTXT
CONVTIME(TIME,INST) ;Intrinsic Function. Convert XML time to FileMan format
 ;714 - PB if the clinic's division has a time zone in file 4 use it, otherwise default to the site time zone
 N XZ,XOUT,XOUT1
 S XZ=0 I $G(TIME)["Z" S XZ=1 ;Zulu time (GMT)
 S XOUT1=$TR(TIME,"TZ -:","")
 S:$G(INST)'>0 INST=$$KSP^XUPARAM("INST")
 S XOUT=$$HL7TFM^XLFDT(XOUT1)
 I XZ=1 S OFFSET=$P($$UTC^DIUTC(XOUT,,$G(INST),,1),"^",3),XOUT=$$FMADD^XLFDT(XOUT,,OFFSET)
 K %DT(0),INST
 Q XOUT
CHKAPT(RET,DFN,CLINID) ;
 N XX,STATUS
 Q:$G(DFN)'>0
 Q:$G(CLINID)'>0
 Q:'$D(^DPT(DFN,0))
 Q:'$D(^SC(CLINID,0))
 S RET=0,STATUS=0
 S XX=0 F  S XX=$O(^SDEC(409.85,"SCC",DFN,CLINID,XX)) Q:XX'>0  D
 . Q:$G(STATUS)=1
 . S:$P($G(^SDEC(409.85,XX,"SDAPT")),"^")'="" STATUS=1
 . S:$P(^SDEC(409.85,XX,0),"^",17)="O" STATUS=1,RET=XX
 Q RET
STRIP(SDECZ) ;Replace control characters with spaces
 N SDECI
 F SDECI=1:1:$L(SDECZ) I (32>$A($E(SDECZ,SDECI))) S SDECZ=$E(SDECZ,1,SDECI-1)_" "_$E(SDECZ,SDECI+1,999)
 Q SDECZ
 ; 
RESLKUP(CLINID) ;
 ;uses the CLINID to lookup the clinic in the SDEC RESOURCE FILE
 N STOP,XX
 K RET,RET1
 S RET=0
 I $G(CLINID)'>0 S RET="0^Invalid Clinic ID" Q
 I '$D(^SC(CLINID,0)) S RET="0^Clinic is not in the Hospital Location file" Q
 S (STOP,XX)=0 F  S XX=$O(^SDEC(409.831,"ALOC",CLINID,XX)) Q:XX'>0  D
 . Q:$G(STOP)=1
 . I $P($G(^SDEC(409.831,XX,0)),"^",11)["SC(" S STOP=1,RET=XX
 S RET1=RET
 Q RET1
GETAPT(URL,SDCL,SDECSTART) ;
 N STOP,SNODE,CNODE,XX
 S STOP=0
 Q:$L(URL)'>0  ;if no url, nothing to do here
 Q:$L(SDCL)'>0  ;SDCL is required
 Q:'$D(^SC(SDCL,0))  ;Clinic doesn't exist
 Q:'$D(^SC(SDCL,"S",SDECSTART))  ; Appointment doesnt' exist
 S XX=0 F  S XX=$O(^SC(SDCL,"S",SDECSTART,1,XX)) Q:XX'>0  D  ;Get the correct appointment node for the patient
 .I $P(^SC(SDCL,"S",SDECSTART,1,XX,0),"^")=DFN D
 . . S SNODE=$G(^SC(SDCL,"S",SDECSTART,1,XX,0))
 . . S CNODE=$P($G(^SC(SDCL,"S",SDECSTART,1,XX,"CONS")),"^")
 . . S ^SC(SDCL,"S",SDECSTART,1,XX,"URL")=$G(URL)
 . . S STOP=1
 Q STOP
CHKLL(X) ;check setup of Logical Link
 ;input value:   X = institution number or name
 ;return value:  1 = setup OK
 ;               0 = LL setup incorrect
 N HLRESLT
 D LINK^HLUTIL3(X,.HLRESLT)
 S X=+$O(HLRESLT(0)) Q:'X 0
 ;
 Q $$LLOK^HLCSLM(X)
SENDERR(ERR)  ; Send for unsuccessful response
 K @MSGROOT
 N HLA
 D INIT^HLFNC2(EIN,.HL)
 S HL("FS")="|",HL("ECH")="^~\&"
 S CNT=1,@MSGROOT@(CNT)=$$MSA^SDTMBUS($G(HL("MID")),ERR,.HL),LEN=$L(@MSGROOT@(CNT))
 F IX=1:1:CNT S HLA("HLS",IX)=$G(@MSGROOT@(IX))
 M HLA("HLA")=HLA("HLS")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.MYRESULT)
 K @MSGROOT
 Q
DUZ ; send error nak back if user not on system
 S ERR="MSA^1^^100^AE^SCHEDULER NOT AUTHORIZED ON THIS VISTA"
 D SENDERR^SDHL7APU(ERR)
 K @MSGROOT
 Q
ERRS ;
 ;;already has appt at^Patient already has an appt at that datetime
 ;;already has appt at^Patient already has an appt
 ;;SDEC07 Error: This RTC request has been closed^This RTC request has been closed
 ;;SDEC07 Error: Invalid Start Time^Invalid Start Time
 ;;SDEC07 Error: Invalid End Time^Invalid End Time
 ;;SDEC07: Patient ID required.^Patient ID required
 ;;SDEC07 Error: Invalid Patient ID^Invalid Patient ID
 ;;Patient is being edited. Try again later.^Patient is being edited.
 ;;SDEC07 Error: Invalid Resource ID^Invalid Resource ID
 ;;SDEC07 Error: Unable to add appointment -- invalid Resource entry.^Unable to add appt - invalid Resource entry
 ;;SDEC07 Error: Appointment length must be between 5 - 120.^Appointment length must be between 5 - 120
 ;;SDEC07 Error: Invalid appointment request type.^Invalid appointment request type
 ;;THAT TIME IS NOT WITHIN SCHEDULED PERIOD^That time not within scheduled period
 ;;SDEC07 Error: Invalid clinic ID.^Invalid clinic ID
 ;;is an inactive clinic.^Clinic is inactive
 ;;Another user is working with this patient's record.  Please try again later^Patient record locked
 ;;SDEC07 Error: Unable to add appointment to SDEC APPOINTMENT file.^Can't add appointment to SDEC APPOINTMENT file
 ;;Invalid Clinic ID - Cannot determine if Overbook is allowed.^Cannot determine if Overbook is allowed.
 ;;Invalid Appointment Date.^Invalid Appointment Date.
 ;;SDEC08: Invalid Appointment ID^Invalid Appointment ID
 ;;Error adding date to file 44: Clinic^Error adding date to file 44
 ;;SDEC08: Invalid status type^Invalid status type
 ;;Another user is working with this patient's record.  Please try again later^Patient record locked
 ;;Invalid Appointment ID.^Invalid Appointment ID
 ;;Appointment is not Cancelled.^Appointment is not Cancelled
 ;;Cancelled by patient appointment cannot be uncancelled.^Cannot be uncancelled
 ;;FileMan add toS DPT error: Patient=^FileMan add toS DPT error
 ;;Another user is working with this patient's record.  Please try again later^Patient record locked
