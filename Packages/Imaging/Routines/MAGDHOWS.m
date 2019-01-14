MAGDHOWS ;WOIFO/PMK,DAC - Capture Consult/GMRC data ;07 Jun 2018 2:35 PM
 ;;3.0;IMAGING;**138,174,208**;Mar 19, 2002;Build 6
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
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #10103 reference $$HTFN^XLFDT function call
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Controlled IA #4110 to read REQUEST/CONSULTATION file (#123)
 ; Supported IA #10040 to read HOSPITAL LOCATION file (#44)
 ;
 ; Called from PROTOCOL called MAGD APPOINTMENT (^ORD(101,...))
 ; through the scheduling package
 ;
 N %,AFTERSTS,APTSCHED,CLINIC,CONSULTM,CUTOFF,DATETIME
 N DFN,FILLER2,FMDATE,FMDATETM
 N GMRCIEN,HIT,I,IREQ,MSGTYPE
 N ORCTRL,ORSTATUS,SDAMDFN,SENDIT,SERVICE,SS,STATUS,UNKNOWN,X,Y,Z
 ;
 Q:$P($G(SDATA("AFTER","STATUS")),"^",3)=""  ; Not a valid appointment
 ;
 ;
 S FMDATETM=$$NOW^XLFDT(),FMDATE=FMDATETM\1
 S CUTOFF=$$HTFM^XLFDT($H-90) ; cutoff date is 90 days ago
 S DFN=$P(SDATA,"^",2),DATETIME=$P(SDATA,"^",3),CLINIC=$P(SDATA,"^",4)
 S APTSCHED("CLINIC IEN")=CLINIC,APTSCHED("FM DATETIME")=DATETIME
 S APTSCHED("CLINIC NAME")=$S(CLINIC:$$GET1^DIQ(44,CLINIC,.01),1:"")
 S AFTERSTS=SDATA("AFTER","STATUS"),X=$P(AFTERSTS,"^",3)
 ; appointment management transactions from ^SD(409.63)
 S FILLER2="" D  Q:FILLER2=""
 . I X["CHECK IN" S FILLER2="SDAM-CHECKIN" Q
 . I X["CHECKED IN" S FILLER2="SDAM-CHECKIN" Q
 . I X["CHECK OUT" S FILLER2="SDAM-CHECKOUT" Q
 . I X["CHECKED OUT" S FILLER2="SDAM-CHECKOUT" Q
 . I X["AUTO RE-" S FILLER2="SDAM-SCHEDULED" Q
 . I X["AUTO-RE" S FILLER2="SDAM-SCHEDULED" Q
 . I X["ACTION REQUIRED" S FILLER2="SDAM-SCHEDULED" Q
 . I X["ACT REQ" S FILLER2="SDAM-SCHEDULED" Q
 . I X["NON-COUNT" S FILLER2="SDAM-SCHEDULED" Q
 . I X["CANCELLED" S FILLER2="SDAM-CANCELLED" Q
 . I X["NO-SHOW" S FILLER2="SDAM-CANCELLED" Q
 . I X["DELETED" S FILLER2="SDAM-CANCELLED" Q
 . I X["FUTURE" S FILLER2="SDAM-FUTURE" Q
 . I X["NO ACTION TAKEN" S FILLER2="SDAM-SCHEDULED" Q
 . I X["NO ACT TAKN" S FILLER2="SDAM-SCHEDULED" Q
 . I X["INPATIENT" S FILLER2="SDAM-SCHEDULED" Q
 . ;
 . W !!,"Unexpected Status: """,X,""" in protocol MAGD APPOINTMENT."
 . W !,"Please notify Customer Support"
 . W !!,"Press <Enter> to continue: " R X:$G(DTIME,300)
 . Q
 ;
 ; find the associated consult or procedure request using SD*5.3*478
 S GMRCIEN="" F I=1:1 D  Q:GMRCIEN  Q:'SDAMDFN
 . S SS=I_","_DATETIME_","_CLINIC
 . S SDAMDFN=$$GET1^DIQ(44.003,SS,.01,"I")
 . I SDAMDFN=DFN S GMRCIEN=$$GET1^DIQ(44.003,SS,688,"I")
 . Q
 ;
 I GMRCIEN D  ; consult linked to appointment
 . N GMRCSTATUS ; P174 DAC - link appointments only to active consults, ignore the rest
 . N CPINVOCATION ; P208 PMK 4/18/2018
 . I $$CPORDER^MAGDHOWP(GMRCIEN)="2,UNFINISHED" Q  ; don't generate HL7 for new CP orders - P208 PMK 4/24/18
 . S CPINVOCATION=0 ; Clinical Procedures exam HL7 flag (set to 1 in MAGDHOWP) P208 PMK 4/18/18
 . S GMRCSTATUS=$$GET1^DIQ(123,GMRCIEN,8,"E")
 . I "^ACTIVE^PENDING^RENEWED^SCHEDULED^"[("^"_GMRCSTATUS_"^") D
 . . S SERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . . D MSGSETUP^MAGDHOW1(GMRCIEN,SERVICE,"XO","SC",.APTSCHED)
 . . Q
 . Q
 Q
