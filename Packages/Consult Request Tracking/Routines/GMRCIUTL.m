GMRCIUTL ;SLC/JFR - UTILITIES FOR INTER-FACILITY CONSULTS ;11/26/01 15:34
 ;;3.0;CONSULT/REQUEST TRACKING;**22,58**;DEC 27, 1997;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ;don't start at the top
 ;
DIV(LOC) ; get the division from a hospital location
 ; Input  -- LOC  HOSPITAL LOCATION file (#44) IEN
 ; Output -- INSTITUTION file (#4) IEN^INSTITUTION file (#4) NAME
 ;
 N GMRCHL,GMRCSTN,GMRCDIV
 S GMRCHL=$P($G(^SC(+LOC,0)),U,15)
 I +GMRCHL D
 . S GMRCSTN=$$SITE^VASITE(,GMRCHL)
 . I $P(GMRCSTN,U)>0,($P(GMRCSTN,U,2)]"") D
 . . S GMRCDIV=$P(GMRCSTN,U)_U_$P(GMRCSTN,U,2)
 I '$G(GMRCDIV) D
 . S GMRCDIV=+$G(DUZ(2))_U_$P($$NS^XUAF4(+$G(DUZ(2))),U)
 Q GMRCDIV
 ;
HLNAME(GMRCWHO)        ;HL7 format a name from a pointer to 200
 Q:'$D(^VA(200,+GMRCWHO,0)) ""
 N GMRC
 S GMRC("FILE")=200
 S GMRC("IENS")=GMRCWHO
 S GMRC("FIELD")=.01
 Q $$HLNAME^XLFNAME(.GMRC,"S")
 ;
UNHLNAME(GMRCNM,GMRCNMC,STD,DEL) ;return regular name from HL7 name
 ;Input:
 ;  GMRCNM  = HL7 formatted name from a message
 ;  GMRCNMC = array to retun name components in (by reference)
 ;  STD     = 1 or 0; 1 = return name given middle family suffix
 ;  DEL     = delimiting character separating name components
 ;
 ;Output:
 ;  GMRCNMC=DREW,NANCY M III MD or NANCY M DREW III MD
 ;  GMRCNMC("FAMILY")=DREW
 ;  GMRCNMC("GIVEN")=NANCY
 ;  GMRCNMC("MIDDLE")=M
 ;  GMRCNM("SUFFIX")=III MD
 ;
 I '$D(DEL) S DEL=U
 S GMRCNMC=GMRCNM
 S GMRCNMC=$$FMNAME^XLFNAME(.GMRCNMC,"CS")
 I $G(STD) S GMRCNMC=$$NAMEFMT^XLFNAME(.GMRCNMC,"G","Dc")
 Q
 ;
TRIMWP(ARRAY,PIECE) ;trim OBX or NTE segments so that only comment remains
 ; Input:
 ;   ARRAY  = the array in which the segments are contained
 ;      ex. ^TMP("GMRCIF",541083753,"OBX",3,3)=3|TX|^COMMENTS^|3|text "
 ;   PIECE  = the piece in the array where the text lives
 ; 
 ; Output:
 ;   trimmed array 
 ;     ex. ^TMP("GMRCIF",541083753,"OBX",3,3)="text"
 ;
 N I S I=0
 F  S I=$O(@(ARRAY)@(I)) Q:'I  D
 . S @(ARRAY)@(I)=$P(@(ARRAY)@(I),"|",PIECE)
 Q
 ;
VALMSG(GMRCPID,GMRCORC) ; determine if message is valid
 ;Input:
 ;  GMRCPID  = PID segment from an IFC HL7 message
 ;  GMRCORC  = ORC segment from an IFC HL7 message
 ;
 ;Output:
 ;  1     = message passes screening on patient, institution and ien
 ;  0^msg = message failed screening
 ;    possible msg values:
 ;        
 ;
 ;
 N GMRCDA,GMRCINST
 Q
 ;
URG(GMRCO) ;return urgency code to send in HL7 msg
 ; Input:
 ;   GMRCO = consult ien from file 123
 ;
 ; Output:
 ;   S   = stat
 ;   R   = routine
 ;   ZT  = today
 ;   Z24 = within 24 hours
 ;   Z48 = within 48 hours
 ;   Z72 = within 72 hours
 ;   ZW  = within 1 week
 ;   ZM  = within 1 month
 ;   ZNA = next available
 ;   ZE  = emergency
 ;
 N URG,PROT,ORURG
 S PROT=$P(^GMR(123,GMRCO,0),U,9)
 S URG=$P($G(^ORD(101,+PROT,0)),U),URG=$P(URG," - ",2)
 I '$L(URG) Q ""
 S ORURG=$S(URG="EMERGENCY":"STAT",URG="NOW":"STAT",URG="OUTPATIENT":"ROUTINE",1:URG)
 S ORURG=$O(^ORD(101.42,"B",ORURG,0))
 I '+ORURG Q ""
 Q $P(^ORD(101.42,ORURG,0),"^",2)
GETSERV(GMRCSRV) ;return local service from IFC service in HL7 msg
 ;Input:
 ;  GMRCSRV = OBR-4 (e.g. 4^CARDIOLOGY^578VA1235)
 ;
 ;Output:
 ;  ien of local service
 N SERV,SENDER,ERROR
 S SERV=$$FIND1^DIC(123.5,"","X",$P(GMRCSRV,U,2))
 I 'SERV S ERROR="-1^ERROR IN SERVICE NAME^701"
 I '$D(ERROR) D
 . S SENDER=$P(GMRCSRV,U,3)
 . S SENDER=+$$IEN^XUAF4($P(SENDER,"VA1235"))
 I '$D(ERROR) D
 . I $O(^GMR(123.5,SERV,"IFCS","B",SENDER,0)) Q
 . S ERROR="-1^IMPROPER SENDING FACILITY^301"
 I '$D(ERROR) D
 . I $P($G(^GMR(123.5,SERV,0)),U,2)'=9 Q
 . S ERROR="-1^SERVICE IS DISABLED^702"
 Q $S($D(ERROR):ERROR,1:SERV)
 ;
GETPROC(GMRCSID) ;return procedure and sercvice ordered by IFC
 ;Input:
 ;  GMRCSID  =OBR-4 from IFC msg  (e.g. "31^EKG^578VA1233" )
 ;
 ;Output:
 ;  string in format  local_proc_ien^service_ien_to perform
 ;
 N GMRCSS,GMRCPR,SENDER,ERROR
 S GMRCPR=$$FIND1^DIC(123.3,"","X",$P(GMRCSID,U,2))
 I 'GMRCPR S ERROR="-1^ERROR IN PROCEDURE NAME^501"
 I '$D(ERROR) D
 . S SENDER=$P(GMRCSID,U,3)
 . S SENDER=+$$IEN^XUAF4($P(SENDER,"VA1233"))
 I '$D(ERROR) D
 . I $O(^GMR(123.3,GMRCPR,"IFCS","B",SENDER,0)) Q
 . S ERROR="-1^IMPROPER SENDING FACILITY^401"
 I '$D(ERROR) D
 . D GETSVC^GMRCPR0(.GMRCSS,GMRCPR)
 . I GMRCSS>1 S ERROR="-1^MULTIPLE SERVICES DEFINED^601" Q
 . S GMRCSS=+GMRCSS(1)
 I '$D(ERROR) D
 . I $P($G(^GMR(123.3,GMRCPR,0)),U,2)'=1 Q
 . S ERROR="-1^PROCEDURE IS INACTIVE^703"
 Q $S($D(ERROR):ERROR,1:GMRCPR_U_GMRCSS)
CODEOI(GMRCDA) ; look at ordered procedure or service and code it for IFC msg
 ;Input:
 ;  GMRCDA = ien from file 123 of consult or procedure to send as IFC
 ;
 ;Output:
 ;  consult:  svc_ien^remote_service_name^station#_VA1235
 ;  proc:     proc_ien^remote_proc_name^station#_VA1233
 ;
 N GMRCPR,GMRCSS,GMRCSIT,GMRCOI
 S GMRCSIT=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 I +$P(^GMR(123,GMRCDA,0),U,8) D  ; it's a procedure
 . S GMRCPR=+$P(^GMR(123,GMRCDA,0),U,8)
 . S GMRCOI=GMRCPR_U_$P(^GMR(123.3,GMRCPR,"IFC"),U,2)_U_GMRCSIT_"VA1233"
 I '$D(GMRCOI) D  ; it's a consult
 . S GMRCSS=$P(^GMR(123,GMRCDA,0),U,5)
 . S GMRCOI=GMRCSS_U_$P(^GMR(123.5,GMRCSS,"IFC"),U,2)_U_GMRCSIT_"VA1235"
 Q GMRCOI
 ;
RESP(GMRCAC,GMRCMID,GMRCOC,GMRCDA,GMRCERR) ;build and send appl ACK/NAK 
 ; Input:
 ;   GMRCAC  = acknowledgement code (AA or AR)
 ;   GMRCMID = message id from original msg
 ;   GMRCOC  = order control from original msg ORC
 ;   GMRCDA  = ien of consult being worked on
 ;   GMRCERR = only defined if an error is found
 ;
 S HLA("HLA",1)=$$MSA^GMRCISEG(GMRCAC,GMRCMID,$G(GMRCERR))
 I $D(GMRCOC) D
 . I GMRCOC="NW" S HLA("HLA",2)=$$ORCRESP^GMRCISG1(GMRCDA,"OK","IP")
 Q
 ;
LOGMSG(GMRCO,GMRCACT,GMRCMSG,GMRCER) ;create or update IFC MESSAGE LOG entry
 ;Input:
 ; GMRC0   = ien from file 123
 ; GMRCACT = ien in 40 multiple from file 123
 ; GMRCMSG = HL7 message ID of message being sent 
 ; GMRCER  = error number if can't transmit immediately
 ;
 N GMRCLG,GMRCERR,FDA
 S GMRCLG=$O(^GMR(123.6,"AC",GMRCO,GMRCACT,1,0))
 I +GMRCLG D  Q  ; update existing incomplete record.
 . S FDA(1,123.6,GMRCLG_",",.01)=$$NOW^XLFDT
 . S FDA(1,123.6,GMRCLG_",",.03)=$G(GMRCMSG)
 . S FDA(1,123.6,GMRCLG_",",.07)=$P(^GMR(123.6,GMRCLG,0),U,7)+1
 . I $G(GMRCER) S FDA(1,123.6,GMRCLG_",",.08)=GMRCER
 . D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 ;
 ; create new record
 S FDA(1,123.6,"+1,",.01)=$$NOW^XLFDT
 S FDA(1,123.6,"+1,",.02)=$P(^GMR(123,GMRCO,0),U,23)
 S FDA(1,123.6,"+1,",.03)=$G(GMRCMSG)
 S FDA(1,123.6,"+1,",.04)=GMRCO
 S FDA(1,123.6,"+1,",.05)=GMRCACT
 S FDA(1,123.6,"+1,",.06)=1
 S FDA(1,123.6,"+1,",.07)=1
 I $G(GMRCER) S FDA(1,123.6,"+1,",.08)=GMRCER
 D UPDATE^DIE("","FDA(1)","GMRCLG","GMRCERR")
 Q
 ;
ERR101 ;Unknown Consult/Procedure request
ERR201 ;Unknown Patient
ERR202 ;Local or unknown MPI identifiers
ERR301 ;Service not matched to receiving facility
ERR401 ;Procedure not matched to receiving facility
ERR501 ;Error in procedure name
ERR601 ;Multiple services matched to procedure
ERR701 ;Error in Service name
ERR702 ;Service is Disabled
ERR703 ;Procedure is Inactive
ERR801 ;Inappropriate action for specified request
ERR802 ;Duplicate, activity not filed
ERR901 ;Unable to update record successfully
ERR902 ;Earlier pending transactions
ERR903 ;HL Logical Link not found
ERR904 ;VistA HL7 unable to send transaction
