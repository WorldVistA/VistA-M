IBTRHLO2 ;ALB/YMG - Create and send 278 inquiry cont. ;02-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
HLSC(IEN,TSTAMP,HLRESLT) ; update entry in 356.22 on successful creation of HL7 message
 ; called from EN^IBTRHLO
 ; IEN - file 356.22 ien
 ; TSTAMP - timestamp of message creation
 ; HLRESLT - return value of GENERATE^HLMA() API call
 ;
 N IBTRFDA,IENS,MSGID
 S MSGID=$P(HLRESLT,U)
 S IENS=IEN_","
 S IBTRFDA(356.22,IENS,.08)="02"
 S IBTRFDA(356.22,IENS,.12)=MSGID
 S IBTRFDA(356.22,IENS,.15)=TSTAMP
 D FILE^DIE(,"IBTRFDA")
 D CLEAN^DILF
 Q
 ;
HLER(IEN,ERRMSG) ; process error on failure to create HL7 message
 ; called from EN^IBTRHLO
 ; IEN - file 356.22 ien
 ; ERRMSG - error message string
 ;
 N IBTRFDA,IENS
 S IENS=IEN_","
 S IBTRFDA(356.22,IENS,.08)="03"
 D FILE^DIE(,"IBTRFDA")
 K IBTRFDA
 S IENS="?+1,"_IEN_","
 S IBTRFDA(356.22101,IENS,.01)=1
 S IBTRFDA(356.22101,IENS,1)=$E(ERRMSG,1,250)
 D UPDATE^DIE(,"IBTRFDA")
 D CLEAN^DILF
 Q
 ;
WP2STR(FILE,FIELD,IENS,LEN) ; convert word-processing field into a single string
 ; FILE - file #
 ; FIELD - WP field #
 ; IENS - ien string of entry to process, including trailing comma
 ; LEN - maximum length of the output string (if not specified - unlimited length)
 ;
 ; returns string containing data from specified WP field
 ;
 N DATA,STOPFLG,STR,STRLEN,Z
 S STR="",LEN=+$G(LEN),STOPFLG=0
 I $G(FILE),$G(FIELD),$G(IENS) D
 .S Z=$$GET1^DIQ(FILE,IENS,FIELD,,"DATA")
 .S Z="" F  S Z=$O(DATA(Z)) Q:Z=""!STOPFLG  D
 ..S:STR'="" STR=STR_" "
 ..S STRLEN=$L(STR)+$L(DATA(Z)) I LEN,STRLEN>LEN S STOPFLG=1
 ..S STR=STR_$S('LEN:DATA(Z),STRLEN'>LEN:DATA(Z),1:$E(DATA(Z),1,LEN-$L(STR)))
 ..Q
 .Q
 Q STR
 ;
PRVDATA(IEN,FILE) ; get provider data
 ; IEN - ien for the entry
 ; FILE - file number IEN is for
 ;
 ; returns the following string:
 ;  name ^ address line 1 ^ address line 2 ^ city ^ state (file 5 ien) ^ zip ^ NPI
 ;
 N DATA,IENS,NPI,RES,Z
 S RES=""
 I $G(IEN),$G(FILE) D
 .S IENS=IEN_","
 .I FILE=4 D  ; pointer to file 4
 ..D GETS^DIQ(FILE,IENS,".01;4.01:4.05;100","IE","DATA")
 ..S NPI=$P($$NPI^XUSNPI("Organization_ID",IEN),U) S:NPI<1 NPI=""
 ..S RES=$G(DATA(FILE,IENS,100,"E")) I RES="" S RES=$G(DATA(FILE,IENS,.01,"E"))
 ..S RES=RES_U_$G(DATA(FILE,IENS,4.01,"E"))_U_$G(DATA(FILE,IENS,4.02,"E"))_U_$G(DATA(FILE,IENS,4.03,"E"))
 ..S RES=RES_U_$G(DATA(FILE,IENS,4.04,"I"))_U_$G(DATA(FILE,IENS,4.05,"E"))_U_NPI
 ..Q
 .I FILE=200 D  ; pointer to file 200
 ..D GETS^DIQ(FILE,IENS,".01;.111:.116","IE","DATA")
 ..S NPI=$P($$NPI^XUSNPI("Individual_ID",IEN),U) S:NPI<1 NPI=""
 ..S RES=$G(DATA(FILE,IENS,.01,"E"))_U_$G(DATA(FILE,IENS,.111,"E"))
 ..S Z=$G(DATA(FILE,IENS,.113,"E")) ; addr. line 3
 ..S RES=RES_U_$G(DATA(FILE,IENS,.112,"E"))_$S(Z'="":" "_Z,1:"")_U_$G(DATA(FILE,IENS,.114,"E"))
 ..S RES=RES_U_$G(DATA(FILE,IENS,.115,"I"))_U_$TR($G(DATA(FILE,IENS,.116,"E")),"-")_U_NPI
 ..Q
 .I FILE=355.93 D  ; pointer to file 355.93
 ..D GETS^DIQ(FILE,IENS,".01;.05:.08;.1","IE","DATA")
 ..S NPI=$$NPIGET^IBCEP81(IEN)
 ..S RES=$G(DATA(FILE,IENS,.01,"E"))_U_$G(DATA(FILE,IENS,.05,"E"))_U_$G(DATA(FILE,IENS,.1,"E"))
 ..S RES=RES_U_$G(DATA(FILE,IENS,.06,"E"))_U_$G(DATA(FILE,IENS,.07,"I"))_U_$TR($G(DATA(FILE,IENS,.08,"E")),"-")_U_NPI
 ..Q
 .Q
 ; check address integrity, line 1 and city are required
 ; if either is missing, don't return any of the address fields
 I $P(RES,U,2)=""!($P(RES,U,4)="") S $P(RES,U,2,6)="^^^^"
 Q RES
 ;
PCODECNV(CODE) ; provider code conversion between NM1 and PRV X12 segments
 ; CODE - code to convert
 ; returns converted code (NM1 -> PRV), or null if no match found
 N I,NM1STR,PRVSTR,RES
 S NM1STR="71^72^73^AAJ^DD^DK^DN^P3^SJ"
 S PRVSTR="AT^OP^OT^AD^AS^OR^RF^PC^PE"
 S RES=""
 F I=1:1:9 S:$P(NM1STR,U,I)=CODE RES=$P(PRVSTR,U,I) Q:RES'=""
 Q RES
 ;
NTE ; create NTE segment
 N MSG,NTE
 S MSG=$$WP2STR(356.22,12,IBTRIEN_",",264)
 I MSG="" Q
 S NTE="NTE"_HLFS_HLFS_HLFS_$$ENCHL7^IBCNEHLQ(MSG)_HLFS_"MSG 2000E"
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=NTE
 Q
 ;
ZHS ; create ZHS segment
 N QUAL,VALUE,ZHS
 S ZHS="ZHS"_HLFS_"HSD 2000E"  ;ZHS.1 = LOOP ID
 S QUAL=$$GET1^DIQ(365.016,+$P(NODE4,U)_",",.01)
 S VALUE=$P(NODE4,U,2)
 I QUAL'="",VALUE'="" S $P(ZHS,HLFS,3)=QUAL,$P(ZHS,HLFS,4)=VALUE  ;ZHS.2=4.01, ZHS.3=4.02 
 S QUAL=$P(NODE4,U,3)
 S VALUE=$P(NODE4,U,4)
 I QUAL'="",VALUE'="" S $P(ZHS,HLFS,5)=QUAL  ;ZHS.4=4.03
 I VALUE'="" S $P(ZHS,HLFS,6)=VALUE  ;ZHS.5=4.04
 S QUAL=$$GET1^DIQ(365.015,+$P(NODE4,U,5)_",",.01)
 S VALUE=$P(NODE4,U,6)
 I QUAL'="",VALUE'="" S $P(ZHS,HLFS,7)=QUAL,$P(ZHS,HLFS,8)=VALUE ;ZHS.6=4.05, ZHS.7=4.06
 S $P(ZHS,HLFS,9)=$$GET1^DIQ(365.025,+$P(NODE4,U,7)_",",.01) ;ZHS.8=4.07
 S $P(ZHS,HLFS,10)=$$GET1^DIQ(356.007,+$P(NODE4,U,8)_",",.01) ;ZHS.9=4.08
 I $TR($P(ZHS,HLFS,3,99),HLFS)="" Q
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=ZHS
 Q
