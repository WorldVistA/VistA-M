MHV7B8 ;WAS/GPM - HL7 message builder SECURE MESSAGING ADR^A19 ; [3/23/08 8:18pm]
 ;;1.0;My HealtheVet;**5**;Aug 23, 2005;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
ADRA19(MSGROOT,QRY,ERR,DATAROOT,LEN,HL) ; Build query response
 ;
 ;  Populates the array pointed to by MSGROOT with an ADR^A19 query
 ; response message by calling the appropriate segment builders based
 ; on the type of response ACK/Data or NAK.  Extracted data pointed to
 ; by DATAROOT, errors, hit counts, and query information are used to
 ; build the segments.
 ; An error number in ERR^4 indicates a NAK is needed.
 ; DATAROOT being null indicates a dataless ACK (testing purposes).
 ;
 ;  Input:
 ;     MSGROOT - Global root of message
 ;         QRY - Query parameters
 ;             QRY("MID") - original message control ID
 ;         ERR - Caret delimited error string
 ;               segment^sequence^field^code^ACK type^error text
 ;    DATAROOT - Global root of data array
 ;          HL - HL7 package array variable
 ;
 ;  Output: ADR^A19 message in MSGROOT
 ;         LEN - Length of formatted message
 ;
 N CNT,HIT,EXTIME
 D LOG^MHVUL2("SM ADR-A19 BUILDER","BEGIN","S","TRACE")
 ;
 S HIT=0,EXTIME=""
 I DATAROOT'="" D
 . S HIT=+$P($G(@DATAROOT),"^",1)
 . S EXTIME=$P($G(@DATAROOT),"^",2)
 . Q
 S HIT=HIT_"^"_HIT_"^0"
 ;
 K @MSGROOT
 S CNT=1,@MSGROOT@(CNT)=$$MSA^MHV7BUS($G(QRY("MID")),ERR,.HL),LEN=$L(@MSGROOT@(CNT))
 I $P(ERR,"^",4) S CNT=CNT+1,HIT="0^0^0",@MSGROOT@(CNT)=$$ERR^MHV7BUS(ERR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QRD^MHV7BUS(.QRY,EXTIME,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QRF^MHV7BUS(.QRY,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QAK^MHV7BUS(.QRY,ERR,HIT,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 I $P(ERR,"^",4) S CNT=CNT+1,@MSGROOT@(CNT)=$$PID^MHV7BUS(.QRY,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 ;
 I '$P(ERR,"^",4),HIT>0,DATAROOT'="" D
 . S CNT=CNT+1,@MSGROOT@(CNT)=$$PID(.QRY,DATAROOT,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 . S CNT=CNT+1,@MSGROOT@(CNT)=$$PD1(DATAROOT,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 . S CNT=CNT+1,@MSGROOT@(CNT)=$$PV1(DATAROOT,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 ;
 D LOG^MHVUL2("SM ADR-A19 BUILDER","END","S","TRACE")
 Q
 ;
PID(QRY,DATAROOT,HL) ;
 N PID,T,X,NAME
 S PID(0)="PID"
 ;
 ;Build PID(3)
 D PID3^MHV7BU(.PID,QRY("ICN"),QRY("DFN"),QRY("SSN"))
 ;
 ;Build PID(5)
 D FMTNAME2^MHV7BU(QRY("DFN"),2,.NAME,.HL,"XPN")
 M PID(5,1)=NAME
 ;
 S PID(7,1,1)=$$FMTHL7^XLFDT(@DATAROOT@("DOB"))
 S PID(8)=$$ESCAPE^MHV7U(@DATAROOT@("SEX"),.HL)
 S PID(11,1,1,1)=$$ESCAPE^MHV7U(@DATAROOT@("ADD1"),.HL)
 S X=@DATAROOT@("ADD2")
 S T=@DATAROOT@("ADD3")
 I $L(X)&$L(T) S X=X_" "
 S PID(11,1,2)=$$ESCAPE^MHV7U(X_T,.HL)
 S PID(11,1,3)=$$ESCAPE^MHV7U(@DATAROOT@("CITY"),.HL)
 S PID(11,1,4)=$$ESCAPE^MHV7U(@DATAROOT@("STATE"),.HL)
 S PID(11,1,5)=$$ESCAPE^MHV7U(@DATAROOT@("ZIP"),.HL)
 S PID(11,1,7)="M"                                 ;address type
 S PID(11,1,9)=$$ESCAPE^MHV7U(@DATAROOT@("COUNTY"),.HL)
 S PID(13,1,1)=$$HLPHONE^HLFNC(@DATAROOT@("PHONE"))
 S PID(13,1,4)=$$ESCAPE^MHV7U(@DATAROOT@("E-MAIL"),.HL)
 S PID(14,1,1)=$$HLPHONE^HLFNC(@DATAROOT@("BUS-PHONE"))
 S PID(16,1,2)=$$ESCAPE^MHV7U(@DATAROOT@("MARITAL-STATUS"),.HL)
 S PID(17,1,2)=$$ESCAPE^MHV7U(@DATAROOT@("RELIGION"),.HL)
 S X=@DATAROOT@("BIRTH-CITY")_"^"_@DATAROOT@("BIRTH-STATE")
 S PID(23)=$$ESCAPE^MHV7U(X,.HL)                   ;birth place
 S PID(29,1,1)=$$FMTHL7^XLFDT(@DATAROOT@("DOD"))
 Q $$BLDSEG^MHV7U(.PID,.HL)
 ;
PV1(DATAROOT,HL) ;
 N PV1,NAME,DOC
 S PV1(0)="PV1"
 S PV1(2)="N"         ;Patient class
 S DOC=@DATAROOT@("ATTENDING-PHYSICIAN")
 D FMTNAME^MHV7BU(DOC,.NAME,.HL,"XCN")
 M PV1(7,1)=NAME
 Q $$BLDSEG^MHV7U(.PV1,.HL)
 ;
PD1(DATAROOT,HL) ;
 N PD1,NAME,DOC
 S PD1(0)="PD1"
 S DOC=@DATAROOT@("PRIMARY-CARE-PHYSICIAN")
 D FMTNAME^MHV7BU(DOC,.NAME,.HL,"XCN")
 M PD1(4,1)=NAME
 Q $$BLDSEG^MHV7U(.PD1,.HL)
 ;
