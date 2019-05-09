GMRCCCR1 ;MJ - Receive HL7 Message for HCP ;3/21/18 09:00
 ;;3.0;CONSULT/REQUEST TRACKING;**99,106,112**;JUN 1, 2018;Build 28
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10106 HLADDR^HLFNC
 ;
 ; MJ - 05/24/2018 patch 106 changes to add - GETADD function
 ; MJ - 03/22/2019 patch 112 changes to fix control character issue in messages - CCONTROL function
 ;
 Q
 ;
GETADD(INSP) ;
 ; INSP contains internal value of insurance plan for this patient (IN1 segment)
 N ADDLN1,ADDLN2,ADDLN3,ADDCITY,ADDST,ADDZIP,VADD,VCSZ,X
 S ADDLN1=$$GET1^DIQ(36,INSP_",",.111)
 S ADDLN2=$$GET1^DIQ(36,INSP_",",.112)
 S ADDLN3=$$GET1^DIQ(36,INSP_",",.113)
 S ADDCITY=$$GET1^DIQ(36,INSP_",",.114)
 S ADDST=$$GET1^DIQ(36,INSP_",",.115,"I") ; S:ADDST ADDST=ADDST_"~"_$$GET1^DIQ(36,INSP_",",.115)
 S ADDZIP=$$GET1^DIQ(36,INSP_",",.116)
 S VADD=ADDLN1_"^"_ADDLN2,VCSZ=ADDCITY_"^"_ADDST_"^"_ADDZIP
 S X=$$HLADDR^HLFNC(VADD,VCSZ)
 S:X]"" $P(X,"^",7)="M" ; address type = 'mailing'
 Q X
 ; end patch 106 mod
 ;
CCONTROL(GMRCDA) ; patch 112
 ; remove control characters from data before building OBR segment
 ;
 S YY=0 F  S YY=$O(^GMR(123,GMRCDA,40,YY)) Q:YY'>0  D
 .S XX=0 F  S XX=$O(^GMR(123,GMRCDA,40,YY,1,XX)) Q:XX'>0  D
 ..K NODE
 .. ;S TESTSTRING=$C(13)
 ..S NODE=$G(^GMR(123,GMRCDA,40,YY,1,XX,0))
 ..I $G(NODE)[$C(13,10,10) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(13,10,10)," ") ; <cr><lf><lf>
 ..I $G(NODE)[$C(13,10) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(13,10)," ") ; <cr><lf>
 ..I $G(NODE)[$C(13) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(13)," ") ; TERM char
 ..I $G(NODE)[$C(1) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(1)," ") ; SOH
 ..I $G(NODE)[$C(2) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(2)," ") ; STX
 ..I $G(NODE)[$C(3) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(3)," ") ; ETX
 ..I $G(NODE)[$C(4) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(4)," ") ; EOT
 ..I $G(NODE)[$C(5) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(5)," ") ; ENQ
 ..I $G(NODE)[$C(6) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(6)," ") ; ACK
 ..I $G(NODE)[$C(21) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(21)," ") ; NAK
 ..I $G(NODE)[$C(23) S ^GMR(123,GMRCDA,40,YY,1,XX,0)=$TR(^GMR(123,GMRCDA,40,YY,1,XX,0),$C(23)," ") ; ETB
 ..;I $C(13,10,10)[$G(NODE) W !,XX," ",NODE
 ..K NODE ;,TESTSTRING
 K XX,YY
 Q
