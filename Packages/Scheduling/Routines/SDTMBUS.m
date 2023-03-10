SDTMBUS ;MS/TG/MS/PB - TMP HL7 Routine;JULY 05, 2018
 ;;5.3;Scheduling;**704,773**;May 29, 2018;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Segment builders common to multiple messages.
 ; Message builders with message specific segments will contain
 ; those message specific segment builders.  Examples would be the
 ; RDF for RTB^K13 messages or the PID for the ADR^A19.
 ;
 ; Integration Control Agreements
 ; ICR 4837 reads to GMR(123
 ; DBIA 4557 reads to GMR(123.5
 Q
 ;
MSA(MID,ERROR,HL) ;build MSA segment
 N MSA,ACK
 S ACK=$P(ERROR,"^",5)
 I ACK="NF"!(ACK="") S ACK="AA"
 S MSA(0)="MSA"
 S MSA(1)=ACK                      ;ACK code
 S MSA(2)=HL("MID")                ;message control ID
 S MSA(3)=$P(ERROR,"^",6)           ;text message
 Q $$BLDSEG^SDHL7UL(.MSA,.HL)
 ;
ERR(ERROR,HL) ;build ERR segment
 N ERR
 S ERR(0)="ERR"
 S ERR(1,1,1)=$P(ERROR,"^",1)      ;segment
 S ERR(1,1,2)=$P(ERROR,"^",2)      ;sequence
 S ERR(1,1,3)=$P(ERROR,"^",3)      ;field
 S ERR(1,1,4,1)=$P(ERROR,"^",4)    ;code
 S ERR(1,1,4,2)=$$ESCAPE^SDHL7UL($P(ERROR,"^",6),.HL) ;text
 Q $$BLDSEG^SDHL7UL(.ERR,.HL)
 ;
QAK(HL,ERROR) ;build QAK segment
 N QAK,STATUS
 S STATUS=$P(ERROR,"^",5)
 I STATUS="" S STATUS="OK"
 S QAK(0)="QAK"
 S QAK(1)=HL("MID")                      ;ACK code
 S QAK(2)=STATUS                      ;message control ID
 S QAK(3)=""
 Q $$BLDSEG^SDHL7UL(.QAK,.HL)
 ;  
QPD(QPD,HL) ;build QPD segment
 Q $$BLDSEG^SDHL7UL(.QPD,.HL)
 ;
QRF(QRY,EXTIME,HL) ; Build QRF segment
 N QRF
 M QRF=QRY("QRF")
 S QRF(0)="QRF"
 Q $$BLDSEG^SDHL7UL(.QRF,.HL)
 ;
RDF(RDF,HL) ;  Build RDF segment for DSS Units data
 ;
 ;  Input:
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;
 Q $$BLDSEG^SDHL7UL(.RDF,.HL)
 ;
RDT(MSGROOT,DATAROOT,CNT,LEN,HL,FOUND) ;  Build RDT segments for Consults elements
 ;
 ; Walks data in DATAROOT to populate MSGROOT with RDT segments
 ; sequentially numbered starting at CNT
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;     FOUND - (0/1) Flag to indicate consults returned (1) or not (0)
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 ; POPULATE SEQUENCE NUMBER
 N I,APP,RDT,II,XDT,IEN,DATA,TO,XX,STOP,FS,CC,INST
 S FOUND=0,INST=$$KSP^XUPARAM("INST")
 ;
 S FS="~"
 F CC=1:1 Q:'$D(@DATAROOT@(CC))  D
 . S APP=@DATAROOT@(CC,0)
 . N RDT,TO,XX,XDT,IEN,CONSULTS,DATA,STOPDT,REMOTECS,RMTCNID,RMTCS,CONDT
 . S DATA="RDT"
 . S IEN=$P(^TMP("ORQQCN",$J,"CS",CC,0),U)
 . Q:+IEN=0
 . S CONSULTS=$G(^TMP("ORQQCN",$J,"CS",CC,0))
 . S CONDT=$P(CONSULTS,"^",2),STOPDT=$$FMADD^XLFDT(DT,-730)   ;773 increase Consults lookup from 365 to 730
 . Q:$G(CONDT)<STOPDT  ; 2 years of consults.
 . S DATA=DATA_"|"_"C"_FS_$P(CONSULTS,U)_FS_$$TMCONV^SDTMPHLA($P(CONSULTS,"^",2),INST)_FS_$P(CONSULTS,U,4)_FS_$P(CONSULTS,U,7)
 . D GETS^DIQ(123,+IEN_",",".06;.07;.08;10;17","IE","RDT")
 . S RMTCNID=$G(RDT(123,+IEN_",",".06","I"))
 . S RMTCS=$G(RDT(123,+IEN_",",".07","I"))
 . S:$G(RMTCNID)>0 REMOTECS=RMTCS_","_RMTCNID
 . S XDT=$G(RDT(123,+IEN_",","17","I"))
 . S:$G(XDT)'="" XDT=$$TMCONV^SDTMPHLA(XDT,INST)
 . S TO=+$P($G(^GMR(123,+IEN,0)),U,5)  ;ICR 4837
 . S XX=0,STOP="" F  S XX=$O(^GMR(123.5,TO,688,XX)) Q:XX'>0!(XX>5)  S STOP=$G(STOP)_$P(^GMR(123.5,TO,688,XX,0),U)_","
 . S DATA=DATA_FS_$G(XDT)_FS_STOP_FS_$G(RDT(123,+IEN_",","10","E"))_FS_$G(REMOTECS)_FS_$$UP^XLFSTR($P(CONSULTS,"^",3))
 . F II=1:1:9 S RDT(II)=$P(DATA,II,FS)
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=DATA
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . S FOUND=1
 . Q
 Q
RTCRDT(MSGROOT,DATAROOT,CNT,LEN,HL,FOUND) ;  Build RDT segments for Return to Clinic elements
 ;
 ; Walks data in DATAROOT to populate MSGROOT with RDT segments
 ; sequentially numbered starting at CNT
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;     FOUND - (0/1) Flag to indicate consults returned (1) or not (0)
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 N I,RDT,II,XDT,IEN,DATA,TO,XX,STOP,FS,CC
 S FOUND=0
 ;
 S FS="~"
 S CC=0
 F  S CC=$O(@DATAROOT@(CC)) Q:'CC  D
 . N RDT,TO,XX,XDT,IEN,CONSULTS,DATA,STOPDT,REMOTECS,RMTCNID,RMTCS,CONDT,MRTC,RTCINT,RTCPAR,MULTIRTC,PRVID,PRVNM
 . S DATA="RDT"
 . S IEN=$P(@DATAROOT@(CC),U)
 . Q:+IEN=0
 . S REQDT=$P(@DATAROOT@(CC),U,2)
 . S CLINID=$P(@DATAROOT@(CC),U,3)
 . S CID=$P(@DATAROOT@(CC),U,4)
 . S PRVID=$P(@DATAROOT@(CC),U,5)
 . S CMTS=$P(@DATAROOT@(CC),U,6)
 . S MRTC=$P(@DATAROOT@(CC),U,7)
 . S RTCINT=$P(@DATAROOT@(CC),U,8)
 . S RTCPAR=$P(@DATAROOT@(CC),U,9)
 . S:$L(MRTC)>0 MULTIRTC=$G(MRTC)_","_$G(RTCINT)_","_$G(RTCPAR)
 . I +CLINID D
 . . S CLINNM=$$GET1^DIQ(44,CLINID_",",".01") Q:CLINNM=""
 . . S STOP=$$GET1^DIQ(44,CLINID_",",8,"I")_","_$$GET1^DIQ(44,CLINID_",",2503,"I")
 . I +PRVID D
 . . S PRVNM=$$GET1^DIQ(200,PRVID_",",".01")
 . S STOPDT=$$FMADD^XLFDT(DT,-730)          ;773 increase RTCs lookup from 365 to 730
 . Q:$G(REQDT)<STOPDT  ; 2 years of requests
 . S DATA=DATA_"|"_"R"_FS_IEN_FS_$$TMCONV^SDTMPHLA(REQDT,$$INST^SDTMPHLA(CLINID))_FS_CLINID_FS_$G(CLINNM)_FS_$$TMCONV^SDTMPHLA(CID,$$INST^SDTMPHLA(CLINID))_FS_$G(STOP)_FS_$G(PRVNM)_FS_FS_FS_CMTS_FS_$G(MULTIRTC)
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=DATA
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 Q
