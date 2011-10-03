GMRCISG1 ;SLC/JFR - BUILD IFC HL7 SEGMENTS CONT'D ;08/16/10  08:59
 ;;3.0;CONSULT/REQUEST TRACKING;**22,66**;DEC 27, 1997;Build 30
 ;#2171 XUAF4, #10103 XLFDT, #10106 HLFNC, #10112 VASITE, #2541 $$KSP^XUPARAM, #2056(GET1^DIQ)
 ;
 Q  ;can't start here
ORCRESP(GMRCO,GMRCOC,GMRCOS) ;build ORC for app ACK msgs
 ; Input:
 ;  GMRCO   = ien from file 123 of entry responding to
 ;  GMRCOC  = order control to put into segment
 ;  GMRCOS  = HL7 encoded order status to put in message
 ;
 ; Output:
 ;  ORC segment to use in response message
 ;
 N GMRCPCS,SITE
 S GMRCPCS(1)=GMRCOC
 S GMRCPCS(2)=$P(^GMR(123,GMRCO,0),U,22)_U_$$STA^XUAF4($P(^(0),U,23))_"^GMRCIFR"
 S GMRCPCS(3)=GMRCO_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))_"^GMRCIFC"
 S GMRCPCS(5)=$G(GMRCOS)
 S GMRCPCS(17)=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 Q $$BUILD^GMRCISEG("ORC",.GMRCPCS)
 ;
NWORC(GMRCO) ; build ORC seg for a new order
 ; Input:
 ;  GMRCO = ien from file 123 of order to send remotely
 ;
 ; Output:
 ;  ORC segment to send with a new order to remote facility
 ;
 N GMRCPCS,SITE,GMRCPHN,GMRCPAG
 S GMRCPCS(1)="NW"
 S GMRCPCS(2)=GMRCO_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))_U_"GMRCIFR"
 S $P(GMRCPCS(7),U,4)=$$FMTHL7^XLFDT($P(^GMR(123,GMRCO,0),U,24)) ;wat/66
 S $P(GMRCPCS(7),U,6)=$$URG^GMRCIUTL(GMRCO)
 S GMRCPCS(9)=$$FMTHL7^XLFDT(+^GMR(123,GMRCO,0))
 S GMRCPCS(10)=$$HLNAME^GMRCIUTL($P($G(^GMR(123,GMRCO,40,1,0)),U,5))
 S GMRCPCS(12)=$$HLNAME^GMRCIUTL($P(^GMR(123,GMRCO,0),U,14))
 S GMRCPHN=$$GET1^DIQ(200,$P(^GMR(123,GMRCO,0),U,14),.132)
 S GMRCPAG=$$GET1^DIQ(200,$P(^GMR(123,GMRCO,0),U,14),.138)
 S GMRCPCS(14)=$$HLPHONE^HLFNC(GMRCPHN,GMRCPAG)
 S GMRCPCS(15)=$$FMTHL7^XLFDT($P(^GMR(123,GMRCO,0),U,7))
 I $O(^GMR(123,GMRCO,40,1)) D
 . N I,ACTV S I=1
 . F  S I=$O(^GMR(123,GMRCO,40,I)) Q:'I  S ACTV=$P(^(I,0),U,2) D
 .. I ACTV'=25 Q
 .. S GMRCPCS(16)="FI^FORWARD TO IFC^99GMRC"
 S SITE=$$SITE^VASITE
 I +SITE S GMRCPCS(17)=$P(SITE,U,3)_U_$P(SITE,U,2) ;use loc instead? ;-(
 Q $$BUILD^GMRCISEG("ORC",.GMRCPCS)
OBXPD(GMRCO) ; create OBX segment for the prov. dx
 ; Input:
 ;  GMRCO  = ien from file 123 of order to send remotely
 ;
 ; Output:
 ;  OBX segment containing the Provisional Diagnosis
 ;
 Q:'$L($G(^GMR(123,GMRCO,30))) ""
 N GMRCPCS
 S GMRCPCS(1)=2,GMRCPCS(2)=$S($L($G(^GMR(123,GMRCO,30.1))):"CE",1:"TX")
 S GMRCPCS(3)="^PROVISIONAL DIAGNOSIS^",GMRCPCS(4)=1
 S GMRCPCS(11)="O"
 I $L($G(^GMR(123,GMRCO,30.1))) D  Q $$BUILD^GMRCISEG("OBX",.GMRCPCS)
 . ;coded diagnosis
 . S GMRCPCS(5)=$G(^GMR(123,GMRCO,30.1))_U_$G(^(30))_U_"I9C"
 S GMRCPCS(5)=U_$G(^GMR(123,GMRCO,30))_U ;free text dx
 Q $$BUILD^GMRCISEG("OBX",.GMRCPCS)
 ;
OBR(GMRCO,GMRCACT) ; build an OBR seg for new order or resubmit
 ; Input:
 ;  GMRCO   = ien from file 123
 ;  GMRCACT = ien from 40 multiple of action (only on resubmit or fwd)
 ;
 ; Output:
 ;  OBR segment
 ;
 N GMRCPCS,GMRCROL
 S GMRCPCS(1)=1
 S GMRCROL=$P(^GMR(123,GMRCO,12),U,5)
 I GMRCROL="P" D
 . S GMRCPCS(2)=GMRCO_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))_U_"GMRCIFR"
 I $D(GMRCACT) D  ;  resubmit sends filler # too
 . I GMRCROL="P" D
 .. S GMRCPCS(3)=$P(^GMR(123,GMRCO,0),U,22)_U_$$STA^XUAF4($P(^(0),U,23))
 .. S GMRCPCS(3)=GMRCPCS(3)_U_"GMRCIFC"
 . I GMRCROL="F" D
 .. S GMRCPCS(2)=$P(^GMR(123,GMRCO,0),U,22)_U_$$STA^XUAF4($P(^(0),U,23))
 .. S GMRCPCS(2)=GMRCPCS(2)_U_"GMRCIFR"
 .. S GMRCPCS(3)=GMRCO_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))_U_"GMRCIFC"
 I $D(GMRCACT),$P(^GMR(123,GMRCO,40,GMRCACT,0),U,2)=17 D
 . ;FWD uses txt of current svc
 . N SITE,SERVNM,SERV
 . S SITE=$$STA^XUAF4($$KSP^XUPARAM("INST"))_"VA1235"
 . I GMRCROL="F" S SERV=$P(^GMR(123,GMRCO,0),U,5)
 . I GMRCROL="P" S SERV=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,6)
 . S SERVNM=$S(+SERV:$P(^GMR(123.5,SERV,0),U),1:"")
 . S GMRCPCS(4)=SERV_U_SERVNM_U_SITE
 I $D(GMRCACT),$P(^GMR(123,GMRCO,40,GMRCACT,0),U,2)=25 D
 . ;FWD to IFC uses the FORWARDED FROM service name
 . N SITE,SERVNM,SERV
 . S SITE=$$STA^XUAF4($$KSP^XUPARAM("INST"))_"VA1235"
 . S SERV=$P(^GMR(123,GMRCO,40,GMRCACT,0),U,6)
 . I '+SERV Q
 . S SERVNM=$P(^GMR(123.5,SERV,0),U)
 . S GMRCPCS(4)=SERV_U_SERVNM_U_SITE
 I '$D(GMRCPCS(4)) D
 . S GMRCPCS(4)=$$CODEOI^GMRCIUTL(GMRCO) ;get remote service or proc
 I $D(GMRCACT) D  ;resubmit or fwd so use activity fields for msg
 . S GMRCPCS(6)=$$FMTHL7^XLFDT($P(^GMR(123,GMRCO,40,GMRCACT,0),U,3))
 . S GMRCPCS(16)=$$HLNAME^GMRCIUTL($P(^GMR(123,GMRCO,40,GMRCACT,0),U,4))
 I '$D(GMRCACT) D  ; new order being sent
 . S GMRCPCS(6)=$$FMTHL7^XLFDT($P(^GMR(123,GMRCO,0),U,7))
 . S GMRCPCS(16)=$$HLNAME^GMRCIUTL($P(^GMR(123,GMRCO,0),U,14))
 S GMRCPCS(18)=$P(^GMR(123,GMRCO,0),U,18)
 Q $$BUILD^GMRCISEG("OBR",.GMRCPCS)
 ;
ORCTST() ;build ORC for testing imp.
 ;Input:
 ;
 ;Output:
 ; ORC segment used to test IFC implementation
 ;
 N GMRCPCS,SITE,GMRCRP
 S GMRCPCS(1)="NW"
 S GMRCPCS(2)="TST1234"_U_$$STA^XUAF4($$KSP^XUPARAM("INST"))_"^GMRCIFR"
 S GMRCPCS(9)=$$FMTHL7^XLFDT($$NOW^XLFDT)
 S GMRCPCS(10)="PUBLIC^JOHN^Q"
 S GMRCPCS(16)="T^TESTING^99GMRC"
 Q $$BUILD^GMRCISEG("ORC",.GMRCPCS)
 ;
 ;
OBRTST(GMRCOI,GMRCTYP) ; build OBR seg for testing imp.
 ; Input:
 ;  GMRCOI   = ien from file 123.5 or 123.3
 ;  GMRCTYP = "P" or "C"   (procedure or consult service)
 ;
 ; Output:
 ;  OBR segment used to test implementation
 ;
 N GMRCPCS,SITE
 S SITE=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S GMRCPCS(1)=1
 S GMRCPCS(2)="TST1234"_U_SITE_"^GMRCIFR"
 I GMRCTYP="C" D
 . N SERV
 . S SERV=$P(^GMR(123.5,GMRCOI,"IFC"),U,2)
 . S GMRCPCS(4)=GMRCOI_U_SERV_U_SITE_"VA1235"
 I GMRCTYP="P" D
 . N PROC
 . S PROC=$P(^GMR(123.3,GMRCOI,"IFC"),U,2)
 . S GMRCPCS(4)=GMRCOI_U_PROC_U_SITE_"VA1233"
 Q $$BUILD^GMRCISEG("OBR",.GMRCPCS)
 ;
