GMRCCCR1 ;MJ - Receive HL7 Message for HCP ;3/21/18 09:00
 ;;3.0;CONSULT/REQUEST TRACKING;**99,106**;JUN 1, 2018;Build 10
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10106 HLADDR^HLFNC
 ;
 ; MJ - 5/24/2018 patch 106 changes to add - GETADD function
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
