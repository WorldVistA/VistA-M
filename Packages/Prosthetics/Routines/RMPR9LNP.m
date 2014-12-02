RMPR9LNP ;Hines OIFO/HNC - REMOTE PROCEDURE, LIST NPPD DATA ;9/8/03  07:23
 ;;3.0;PROSTHETICS;**71,77,90,75,60,143,150,168**;Feb 09, 1996;Build 43
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to $$CSI^ICDEX   supported by ICR #5747
 ;
 ;    HNC - Sept 2, 2003 - patch 77 remove the " for Excel CSV
 ;    HNC - Feb 14, 2005 - patch 90 add flex field to GUI display
 ;    HNC - Nov 15, 2005 - patch 75 add 2 additional flex field to gui
 ;    RRA - March 20, 2008 - patch 143 added " back for excel CSV
 ;
 ;RESULTS passed to broker in ^TMP($J,
 ;delimited by "^"
 ;piece 1 = ENTRY DATE
 ;piece 2 = PATIENT NAME  IF OEF/OIF <!> PRECEDES THE NAME
 ;piece 3 = PSAS HCPCS with * if hcpcs has Calculation Flag
 ;piece 4 = QTY
 ;piece 5 = VENDOR
 ;piece 6 = INITIAL ACTION DATE
 ;piece 7 = TOTAL COST
 ;piece 8 = DESCRIPTION
 ;piece 9 = INITIATOR
 ;piece 10 = NPPD LINE BEFORE GROUPER
 ;piece 11 = STATION
 ;piece 12 = GROUPER NUMBER
 ;piece 13 = FORM REQUESTED ON
 ;piece 14 = TYPE OF TRANSACTION
 ;piece 15 = SSN
 ;piece 16 = IEN TO FILE 660
 ;piece 17 = HCPCS SHORT DESCRIPTION
 ;piece 18 = SOURCE
 ;piece 19 = Optional Flex Field
 ;piece 20 = Optional Flex Field
 ;piece 21 = Optional Flex Field
 Q
 ;
EN(RESULT,DATE1,DATE2,FLEXF,FLEX2,FLEX3) ;broker entry point
 ;
 K ^TMP($J)
 I '$D(DATE1)!('$D(DATE2)) G EXIT
 S DATE=DATE1-1
 F  S DATE=$O(^RMPR(660,"B",DATE)) Q:(DATE="")!($P(DATE,".",1)>DATE2)  D
 .S RMPRB=0
 .F  S RMPRB=$O(^RMPR(660,"B",DATE,RMPRB)) Q:RMPRB=""  D
 ..I $P(^RMPR(660,RMPRB,0),U,15)["*" Q:$P($G(^RMPR(660,RMPRB,"HSTV1")),U,3)=""
 ..S PHCPCS=$P($G(^RMPR(660,RMPRB,1)),U,4)
 ..Q:PHCPCS=""
 ..Q:PHCPCS'>0
 ..S HDES=$P(^RMPR(661.1,PHCPCS,0),U,2)
 ..S TYPE=$P($G(^RMPR(660,RMPRB,0)),U,4)
 ..I "X5"'[TYPE S LINE=$P(^RMPR(661.1,PHCPCS,0),U,7)
 ..I "X5"[TYPE S LINE=$P(^RMPR(661.1,PHCPCS,0),U,6)
 ..S CAL=$P(^RMPR(661.1,PHCPCS,0),U,8)
 ..I CAL'="" S CAL="*"
 ..S DFN=$P(^RMPR(660,RMPRB,0),U,2)
 ..D DEM^VADPT,SVC^VADPT
 ..S RMPROEOI=$S(VASV(11)>0:"<!>",VASV(12)>0:"<!>",VASV(13)>0:"<!>",1:0)
 ..D DATA
 S RESULT=$NA(^TMP($J))
 K DATE,DFN,HDES,LINE,PHCPCS,RMPRB,RMPRFLD,TYPE,B
 Q
 ;
DATA ;
 ;
 ; ICD10 Changes - Determine Active Coding System
 N RMPRCSI
 S RMPRCSI=$$SINFO^ICDEX("DIAG",DATE) ; Coding System Info
 ;
 S B=RMPRB
 S RMPRFLD=".01;.02;4.5;5;7;8;8.3;11;12;14;24;27;68"
 ;
 ; Process user selected fields
 I FLEXF'="" S RMPRFLD=RMPRFLD_";"_FLEXF
 I FLEX2'="" S RMPRFLD=RMPRFLD_";"_FLEX2
 I FLEX3'="" S RMPRFLD=RMPRFLD_";"_FLEX3
 ;
 I FLEXF=8.7!(FLEX2=8.7)!(FLEX3=8.7) D
 .I (";"_RMPRFLD_";")'[(";"_8.8_";") S RMPRFLD=RMPRFLD_";"_8.8
 ;
 D GETS^DIQ(660,B,RMPRFLD,"","RMXM")
 S RMPRPTNM=$G(RMXM(660,B_",",.02))
 I RMPROEOI["<" S RMPRPTNM=RMPROEOI_RMPRPTNM
 S $P(^TMP($J,B),U,1)=$G(RMXM(660,B_",",.01))
 S $P(^TMP($J,B),U,2)=RMPRPTNM
 S $P(^TMP($J,B),U,3)=$G(RMXM(660,B_",",4.5))_CAL
 S $P(^TMP($J,B),U,4)=$G(RMXM(660,B_",",5))
 S $P(^TMP($J,B),U,5)=$G(RMXM(660,B_",",7))
 S $P(^TMP($J,B),U,6)=$G(RMXM(660,B_",",8.3))
 S $P(^TMP($J,B),U,7)=$G(RMXM(660,B_",",14))
 S $P(^TMP($J,B),U,8)=$G(RMXM(660,B_",",24))
 S $P(^TMP($J,B),U,9)=$G(RMXM(660,B_",",27))
 S $P(^TMP($J,B),U,10)=LINE
 S $P(^TMP($J,B),U,11)=$G(RMXM(660,B_",",8))
 S $P(^TMP($J,B),U,12)=$G(RMXM(660,B_",",68))
 S $P(^TMP($J,B),U,13)=$G(RMXM(660,B_",",11))
 S $P(^TMP($J,B),U,14)=TYPE
 S $P(^TMP($J,B),U,15)=$P(VADM(2),U,2)
 S $P(^TMP($J,B),U,16)=B
 S $P(^TMP($J,B),U,17)=HDES
 S $P(^TMP($J,B),U,18)=$E($G(RMXM(660,B_",",12)),0,1)
 ;
 ; Process user selected fields
 I FLEXF'="" D
 .; Check if PROVISIONAL DIAGNOSIS (#8.7) was selected 
 .I FLEXF=8.7 D  Q
 ..; If ICD-9 era get #8.7 from #660
 ..I +RMPRCSI=1,($G(RMXM(660,B_",",FLEXF))'="") S $P(^TMP($J,B),U,19)=$G(RMXM(660,B_",",FLEXF)) Q
 ..; If ICD-10 era get "short description" (i.e. DIAGNOSIS) from #80
 ..I +RMPRCSI=30,($G(RMXM(660,B_",",FLEXF))'="")  D  Q
 ...S $P(^TMP($J,B),U,19)=$$ICDSD(RMXM(660,B_",",8.8),DATE,+RMPRCSI)
 ..; If Provisional Diagnosis was blank
 ..S $P(^TMP($J,B),U,19)=""
 .; Check if SUSPENSE ICD (#8.8) was selected
 .I FLEXF=8.8 D  Q
 ..I $G(RMXM(660,B_",",FLEXF))'="" D ICDCS(FLEXF,19,RMPRB_",") Q
 ..S $P(^TMP($J,B),U,19)=""
 .; User specified a field other than 8.7 or 8.8
 .I FLEXF'="" S $P(^TMP($J,B),U,19)=$G(RMXM(660,B_",",FLEXF))
 ; User didn't specify a field for 1st choice
 I FLEXF="" S $P(^TMP($J,B),U,19)=""
 ;
 ; Process 2nd user selected field
 I FLEX2'="" D
 .; Check if PROVISIONAL DIAGNOSIS (#8.7) was selected 
 .I FLEX2=8.7 D  Q
 ..; If ICD-9 era get #8.7 from #660
 ..I +RMPRCSI=1,($G(RMXM(660,B_",",FLEX2))'="") S $P(^TMP($J,B),U,20)=$G(RMXM(660,B_",",FLEX2)) Q
 ..; If ICD-10 era get "short description" (i.e. DIAGNOSIS) from #80
 ..I +RMPRCSI=30,($G(RMXM(660,B_",",FLEX2))'="")  D  Q
 ...S $P(^TMP($J,B),U,20)=$$ICDSD(RMXM(660,B_",",8.8),DATE,+RMPRCSI)
 ..; If Provisional Diagnosis was blank
 ..S $P(^TMP($J,B),U,20)=""
 .; Check if SUSPENSE ICD (#8.8) was selected
 .I FLEX2=8.8 D  Q
 ..I $G(RMXM(660,B_",",FLEX2))'="" D ICDCS(FLEX2,20,RMPRB_",") Q
 ..S $P(^TMP($J,B),U,20)=""
 .; User specified a field other than 8.7 or 8.8
 .I FLEX2'="" S $P(^TMP($J,B),U,20)=$G(RMXM(660,B_",",FLEX2))
 ; User didn't specify a field for 2nd choice
 I FLEX2="" S $P(^TMP($J,B),U,20)=""
 ;
 ; Process 3rd user selected field
 I FLEX3'="" D
 .; Check if PROVISIONAL DIAGNOSIS (#8.7) was selected 
 .I FLEX3=8.7 D  Q
 ..; If ICD-9 era get #8.7 from #660
 ..I +RMPRCSI=1,($G(RMXM(660,B_",",FLEX3))'="") S $P(^TMP($J,B),U,21)=$G(RMXM(660,B_",",FLEX3)) Q
 ..; If ICD-10 era get "short description" (i.e. DIAGNOSIS) from #80
 ..I +RMPRCSI=30,($G(RMXM(660,B_",",FLEX3))'="")  D  Q
 ...S $P(^TMP($J,B),U,21)=$$ICDSD(RMXM(660,B_",",8.8),DATE,+RMPRCSI)
 ..; If Provisional Diagnosis was blank
 ..S $P(^TMP($J,B),U,21)=""
 .; Check if SUSPENSE ICD (#8.8) was selected
 .I FLEX3=8.8 D  Q
 ..I $G(RMXM(660,B_",",FLEX3))'="" D ICDCS(FLEX3,21,RMPRB_",") Q
 ..S $P(^TMP($J,B),U,21)=""
 .; User specified a field other than 8.7 or 8.8
 .I FLEX3'="" S $P(^TMP($J,B),U,21)=$G(RMXM(660,B_",",FLEX3))
 ; User didn't specify a field for 2nd choice
 I FLEX3="" S $P(^TMP($J,B),U,21)=""
 ;
 K RMXM,VADM,CAL
 Q
 ;
 ; Return Short Description (i.e. DIAGNOSIS) from #80
ICDSD(RMPRICD,DATE,RMPRCSI) ; Retrieve ICD Short Description from DIAGNOSIS field in #80
 Q:RMPRICD="" ""
 Q:DATE="" ""
 Q:RMPRCSI="" ""
 S RMPRICD=$$ICDDX^ICDEX(RMPRICD,DATE,RMPRCSI,"E") ; Supported by ICR 5747
 ; If API failed, return error message
 I +RMPRICD<0 D  Q RMPRICD
 .S RMPRICD=$P(RMPRICD,U,2)
 ; Return Short Description
 S RMPRICD=$P(RMPRICD,U,4)
 Q RMPRICD
 ;
 ; Determine code set for ICD code and update appropriate return array piece
ICDCS(RMPRFNUM,RMPRANUM,RMPRIENS) ;
 ; RMPRFNUM = User Specified Field Number
 ; RMPRANUM = Array number to update
 ; RMPRIENS = #660 IEN
 N RMPRACS
 S RMPRACS=""
 ; Get ICD IEN from #660
 S RMPRACS=$$GET1^DIQ(660,RMPRIENS,8.8,"I",,)
 ; Determine Code Set for ICD code
 S RMPRACS=$$CSI^ICDEX(80,RMPRACS)
 ; Retrieve Info for Code Set
 S RMPRACS=$$SINFO^ICDEX(RMPRACS)
 ; Convert Code Set to external numerical value.  ICD-9 = 9, ICD-10 = 10 etc.
 S RMPRACS=$P($P(RMPRACS,U,2),"-",2)
 ; Update appropriate piece of return array
 S $P(^TMP($J,B),U,RMPRANUM)=$G(RMXM(660,B_",",RMPRFNUM))_"~"_RMPRACS
 Q
 ;
EXIT ;common exit point
 Q
 ;END
