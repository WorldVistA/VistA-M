MAGDHOW4 ;WOIFO/PMK - Capture Consult/GMRC data ; 12 Mar 2013 6:52 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ;
OBR(HLMSTATE,GMRCIEN,SAVEORCSEG,SERVICE) ; build the OBR segment (see OBR^GMRCHL72)
 N ACNUMB,AUTHOR,CPTCODE,CPTNAME,CONPROC,ERROR,I,DEL,DEL2,OBRSEG,SUCCESS
 N PRIORITY,X,Z
 D SET^HLOAPI(.OBRSEG,"OBR",0)
 D SET^HLOAPI(.OBRSEG,1,1) ; OBR-1
 M OBRSEG(2)=SAVEORCSEG(2) ; OBR-2 placer order number
 M OBRSEG(3)=SAVEORCSEG(3) ; OBR-3 filler order number
 ;
 ;
 ; OBR-4 Universal Service Identifier
 S CPTCODE=$$GET1^DIQ(81,CPTIEN,.01)
 S CPTNAME=$$GET1^DIQ(81,CPTIEN,2)
 D SET^HLOAPI(.OBRSEG,CPTCODE,4,1)
 D SET^HLOAPI(.OBRSEG,CPTNAME,4,2)
 D SET^HLOAPI(.OBRSEG,"C4",4,3)
 S CONPROC=$$GET1^DIQ(123,GMRCIEN,13,"I") ; consult/procedure request type
 I CONPROC="C" D  ; consult request
 . D SET^HLOAPI(.OBRSEG,"C"_SERVICE,4,4)
 . D SET^HLOAPI(.OBRSEG,$$GET1^DIQ(123.5,SERVICE,.01),4,5)
 . D SET^HLOAPI(.OBRSEG,"99CON",4,6)
 . Q
 E  D  ; procedure request
 . D SET^HLOAPI(.OBRSEG,"P"_(+$$GET1^DIQ(123,GMRCIEN,4,"I")),4,4)
 . D SET^HLOAPI(.OBRSEG,$$GET1^DIQ(123,GMRCIEN,4),4,5)
 . D SET^HLOAPI(.OBRSEG,"99PROC",4,6)
 . Q
 ;
 S PRIORITY=$G(SAVEORCSEG(7,1,6,1))
 I PRIORITY'=""  D SET^HLOAPI(.OBRSEG,PRIORITY,5) ; OBR-5 priority
 ;
 ; OBR-6 to OBR-15 are not used
 ; 
 M OBRSEG(16)=SAVEORCSEG(12) ; OBR-16 ordering provider
 M OBRSEG(17)=SAVEORCSEG(14) ; OBR-17 call back phone number
 ;
 ; store the accession number
 S ACNUMB=$$GMRCACN^MAGDFCNV(GMRCIEN)
 D SET^HLOAPI(.OBRSEG,ACNUMB,18) ; OBR-18 placer field 1
 ;
 ; store the requested procedure id
 D SET^HLOAPI(.OBRSEG,$P(ACNUMB,"-",3),19) ; OBR-19 placer field 2
 ;
 ; store misc. consult and clinic info in "filler field 1"
 ;   <request type>
 ; ` <place of consult>
 ; ` <clinic ien> _ <clinic name>
 ; ` <requesting service ien> _ <requesting service name> _ VISTA44
 ;  
 S X=$$GET1^DIQ(123,GMRCIEN,13,"I") ; request type
 S Z=$S(X="C":"CONSULT",X="P":"PROCEDURE",1:"UNKNOWN")_"```"
 S X=$$GET1^DIQ(123,GMRCIEN,6,"I") ; place of consult
 I X S $P(Z,"`",2)=$$GET1^DIQ(101,X,1)
 I $D(APTSCHED("CLINIC IEN")),$D(APTSCHED("CLINIC NAME")) D
 . S $P(Z,"`",3)=APTSCHED("CLINIC IEN")_"_"_APTSCHED("CLINIC NAME")
 . Q
 ; from service (requesting service)
 S X=$$GET1^DIQ(123,GMRCIEN,2,"I") ; pointer to ^SC(Z)
 I X S $P(Z,"`",4)=X_"_"_$$GET1^DIQ(44,X,.01)_"_VISTA44"
 D SET^HLOAPI(.OBRSEG,Z,20) ; OBR-20 filler field 1
 ;
 ; store consult and clinic identification info in "filler field 2"
 ;   <itype code> _ <itype name>
 ; ` <service ien> _ <service name>
 ; ` <division station number> _ <division name>
 ; ` <current CPRS GMRC or Appointment Scheduling status>
 ; 
 S Z=ITYPCODE_"_"_ITYPNAME_"```"
 S $P(Z,"`",2)=SERVICE_"_"_$$GET1^DIQ(123.5,SERVICE,.01)
 S $P(Z,"`",3)=DIVISION_"_"_$S(DIVISION:$$GET1^DIQ(4,DIVISION,.01),1:"")
 ; store the current CPRS GMRC or Appointment Scheduling status
 I '$D(FILLER2) S FILLER2="GMRC-"_$$GET1^DIQ(123,GMRCIEN,8) ; GMRC status
 S $P(Z,"`",4)=FILLER2
 ;
 D SET^HLOAPI(.OBRSEG,Z,21) ; OBR-21 filler field 2
 ;
 ; CPRS Attention - HL7 "Result Copies To" field
 S X=$$GET1^DIQ(123,GMRCIEN,7,"I") ; pointer to ^VA(200)
 I X D NAME^MAGDHOW3(X,28,.OBRSEG) ; OBR-28 result copies to
 ;
 ; special code for result message or order message, but not both
 ; 
 I MSGTYPE="ORU" D  ; code for result messages, not orders
 . N AUTHOR
 . D SET^HLOAPI(.OBRSEG,$$FMTHL7^XLFDT(FMDATETM),22) ; OBR-22
 . D SET^HLOAPI(.OBRSEG,$S(ORSTATUS="CM":"F",1:"R"),25) ; OBR-25
 . ; directly call rpc TIU GET DOCUMENTS FOR REQUEST
 . D GETDOCS^TIUSRVLR(.TIUDOC,GMRCIEN_";GMR(123,") ; ICR 3536
 . ; get author of most recent (last) report
 . S I=0 F  S I=$O(@TIUDOC@(I))  Q:'I  S X=@TIUDOC@(I) D
 . . S AUTHOR=$P(X,"^",5)
 . . Q
 . I $D(AUTHOR) D NAME^MAGDHOW3(+AUTHOR,32,.OBRSEG) ; OBR-32
 . Q
 ; 
 E  I MSGTYPE="ORM" D  ; code for order messages, not results
 . M OBRSEG(27)=SAVEORCSEG(7) ; quantity/timing - OBR-27
 . ;
 . ; date and time of scheduled appointment
 . I $D(APTSCHED("FM DATETIME")) D
 . . D SET^HLOAPI(.OBRSEG,$$FMTHL7^XLFDT(APTSCHED("FM DATETIME")),36) ; OBR-36
 . . Q
 . Q
 ;
 ;
 S SUCCESS=$$ADDSEG^HLOAPI(.HLMSTATE,.OBRSEG,.ERROR)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in OBR^"_$T(+0)_" where the ADDSEG^HLOAPI invocation"
 . S MSG(2)="for the OBR segment failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("OBRSEG")=""
 . S VARIABLES("ERROR")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 Q
