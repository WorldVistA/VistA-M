MAGDHOWS ;WOIFO/PMK,DAC - Capture Consult/GMRC data ; 25 Ocy 2016 12:41 PM
 ;;3.0;IMAGING;**138,174**;Mar 19, 2002;Build 30
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
 . S GMRCSTATUS=$$GET1^DIQ(123,GMRCIEN,8,"E")
 . I "^ACTIVE^PENDING^RENEWED^SCHEDULED^"[("^"_GMRCSTATUS_"^") D
 . . S SERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . . D MSGSETUP^MAGDHOW1(GMRCIEN,SERVICE,"XO","SC",.APTSCHED)
 . . Q
 . Q
 Q
