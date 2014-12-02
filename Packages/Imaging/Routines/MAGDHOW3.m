MAGDHOW3 ;WOIFO/PMK - Capture Consult/GMRC data ; 12 Mar 2013 6:52 PM
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
ORC(HLMSTATE,GMRCIEN,SAVEORCSEG) ; build the ORC segment (see ORC^GMRCHL7)
 N ACNUMB,ERROR,ORCSEG,ORDERENTERER,ORDERNUMBER,ORDERPLACER,PRIORITY,SUCCESS,X
 D SET^HLOAPI(.ORCSEG,"ORC",0)
 D SET^HLOAPI(.ORCSEG,ORCTRL,1) ; ORC-1 order control
 S ORDERNUMBER=$$GET1^DIQ(123,GMRCIEN,.03,"I") ; oe/rr file number
 D SET^HLOAPI(.ORCSEG,$$STATNUMB^MAGDFCNV()_"-OR-"_ORDERNUMBER,2) ; ORC-2 placer order number
 S ACNUMB=$$GMRCACN^MAGDFCNV(GMRCIEN)
 D SET^HLOAPI(.ORCSEG,ACNUMB,3) ; ORC-3 filler order number
 ;
 D SET^HLOAPI(.ORCSEG,ORSTATUS,5) ; ORC-5 order status
 ; ORC-6 not used
 ;
 ; store date and time of scheduled appointment for order messages, not results
 I MSGTYPE="ORM",$D(APTSCHED("FM DATETIME")) D
 . D SET^HLOAPI(.ORCSEG,$$FMTHL7^XLFDT(APTSCHED("FM DATETIME")),7,4) ; ORC-7 start date/time
 . Q
 S PRIORITY=$$GET1^DIQ(123,GMRCIEN,5),PRIORITY=$P(PRIORITY," - ",2) ; urgency
 S PRIORITY=$S(PRIORITY="EMERGENCY":"STAT",PRIORITY="NOW":"STAT",PRIORITY="OUTPATIENT":"ROUTINE",1:PRIORITY)
 I PRIORITY'="" D  ; convert to HL7 priority
 . N URGENCY
 . S URGENCY=$$FIND1^DIC(101.42,,"B",PRIORITY)
 . S PRIORITY=$S(URGENCY:$$GET1^DIQ(101.42,URGENCY,2,"E"),1:"")
 . Q
 D SET^HLOAPI(.ORCSEG,PRIORITY,7,6) ; ORC-7 priority
 ; ORC-8 not used
 D SET^HLOAPI(.ORCSEG,$$FMTHL7^XLFDT(FMDATETM),9) ; ORC-9 date/time of transaction
 S ORDERENTERER=$$GET1^DIQ(100,ORDERNUMBER,3,"I") ; Order file - who entered
 D NAME^MAGDHOW3(ORDERENTERER,10,.ORCSEG) ; ORC-10 entered by
 ; ORC-11 not used
 S ORDERPLACER=$$GET1^DIQ(123,GMRCIEN,10,"I") ; sending provider
 D NAME^MAGDHOW3(ORDERPLACER,12,.ORCSEG) ; ORC-12 ordering provider
 S X=$$GET1^DIQ(200,ORDERENTERER,29) ; service/section
 D SET^HLOAPI(.ORCSEG,X,13) ; ORC-13 enterer's location
 D PHONE^MAGDHOW3(ORDERPLACER,14,.ORCSEG) ; ORC-14 call back phone number(s)
 S X=$$GET1^DIQ(123,GMRCIEN,3,"I") ; date of request
 D SET^HLOAPI(.ORCSEG,$$FMTHL7^XLFDT(X),15) ; ORC-15 order effective date/time
 ; ORC-16 not used
 S X=$$GET1^DIQ(200,ORDERPLACER,29,"I") ; ordering provider's service/section
 ; entering organization (abbreviation, name, coding system)
 D SET^HLOAPI(.ORCSEG,$$GET1^DIQ(49,X,1),17,1)
 D SET^HLOAPI(.ORCSEG,$$GET1^DIQ(49,X,.01),17,2)
 D SET^HLOAPI(.ORCSEG,"VISTA49",17,3)
 ;
 M SAVEORCSEG=ORCSEG ; save some of the ORC fields for the OBR segment
 S SUCCESS=$$ADDSEG^HLOAPI(.HLMSTATE,.ORCSEG,.ERROR)
 I 'SUCCESS D
 . N MSG,SUBJECT,VARIABLES
 . S SUBJECT="VistA Imaging Clinical Specialty (CPRS) HL7 Generation"
 . S MSG(1)="An error occurred in ORC^"_$T(+0)_" where the ADDSEG^HLOAPI invocation"
 . S MSG(2)="for the ORC segment failed.  The error message is as follows:"
 . S MSG(3)=""""_SUCCESS_""""
 . S VARIABLES("HLMSTATE")=""
 . S VARIABLES("ORCSEG")=""
 . S VARIABLES("ERROR")=""
 . D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 . Q
 Q
 ;
NAME(IEN,FIELD,ORCSEG) ; return person's name in HL7 format
 N DGNAME,I,X
 S DGNAME("FILE")=200,DGNAME("IENS")=IEN,DGNAME("FIELD")=.01
 S X=$$HLNAME^XLFNAME(.DGNAME,"","^")
 D SET^HLOAPI(.ORCSEG,IEN,FIELD,1)
 F I=1:1:$L(X,"^") D SET^HLOAPI(.ORCSEG,$P(X,"^",I),FIELD,I+1)
 Q
 ;
PHONE(IEN,FIELD,SEGMENT) ; call back phone number(s)
 N FNUMBER,EQTYPE,I,MAGOUT,MAGERR,NUMBER,USECODE,X,REP
 S REP=0 ; HL7 repetition
 F I=1:1 S X=$T(PHONES+I) Q:"END"[$P(X,";;",2)  D
 . S FNUMBER=$P(X,";",4),USECODE=$P(X,";",5),EQTYPE=$P(X,";",6)
 . S NUMBER=$$GET1^DIQ(200,IEN,FNUMBER)
 . D PHONE1(.REP,FIELD,.SEGMENT,NUMBER,USECODE,EQTYPE)
 . Q
 ; check VISITED FROM subfile (#8910) to get PHONE AT SITE field (#5)
 D GETS^DIQ(200,IEN_",","8910*","E","MAGOUT","MAGERR")
 S I="" F  S I=$O(MAGOUT("200.06",I)) Q:I=""  D
 . S NUMBER=MAGOUT("200.06",I,5,"E")
 . D PHONE1(.REP,FIELD,.SEGMENT,NUMBER,"WPN","PN")
 Q
 ;
PHONE1(REP,FIELD,SEGMENT,NUMBER,USECODE,EQTYPE) ; store phone info
 I NUMBER'="" D
 . S REP=REP+1
 . D SET^HLOAPI(.SEGMENT,NUMBER,FIELD,1,1,REP)
 . D SET^HLOAPI(.SEGMENT,USECODE,FIELD,2,1,REP)
 . D SET^HLOAPI(.SEGMENT,EQTYPE,FIELD,3,1,REP)
 . Q
 Q
 ;
PHONES ;; field name ; field number ; HL7 Use Code ; HL7 Equipment Type
 ;;PHONE (HOME);.131;PRN;PH
 ;;OFFICE PHONE;.132;WPN;PH
 ;;PHONE #3;.133;WPN;PN
 ;;PHONE #4;.134;WPN;PN
 ;;COMMERCIAL PHONE;.135;WPN;PN
 ;;FAX NUMBER;.136;WPN;FX
 ;;VOICE PAGER;.137;WPN;BP
 ;;DIGITAL PAGER;.138;BPM;BP
 ;;END
 ;
