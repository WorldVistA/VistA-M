MAGQLOG ;WOIFO/RED/SRR/RMP - Log image electronic Sig access ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;;Mar 01, 2002
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; CALL WITH:
 ; MAGIMT = TYPE OF ACCESS
 ; DUZ = USER NO.
 ; MAGO = IMAGE SUBSCRIPT NO.
 ; MAGDFN = PATIENT NO.
 ; MAGCT =
 ; MAGES = ELECTRONIC SIGNATURE
ENTRY(RESULT,MAGIMT,MAGDUZ,MAGO,MAGDFN,MAGCT,MAGES) ;
 N MAGC,MAG1
 I '$D(DUZ) S RESULT="0^INVALID user number" Q
 S MAGDUZ=DUZ
 I '$D(^MAG(2006.95,0)) S RESULT="0^No Log File" Q
 D ESIG(.RESULT,MAGES)
 D:+RESULT ENTRY^MAGLOG($E("ES"_$G(MAGIMT)_"COPY",1,10),MAGDUZ,MAGO,"Copy-WIN",MAGDFN,MAGCT)
 Q
ESIG(RESULT,SIG) ;-- Verify electronic signature
 S X=$$DECRYP^XUSRB1(SIG)
 D HASH^XUSHSHP
 I '$D(DUZ) S RESULT="0^INVALID user number" Q
 S X1=$$GET1^DIQ(200,DUZ,20.4,"I")
 I X1="" S RESULT="0^Missing signature parameters" Q
 I X1'=X S RESULT="0^Invalid signature" Q
 S RESULT="1^Signature verified"
 Q
 ;
