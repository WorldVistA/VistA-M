PSONVAVW ;BHM/MFR - View Non-VA Med - Listmanager ;10/20/06
 ;;7.0;OUTPATIENT PHARMACY;**260**;13 Feb 97;Build 84
 ;Reference to File ^PS(55 supported by DBIA 2228
 ;Reference to $$GET1^DIQ is supported by DBIA 2056
 ;Reference to DEM^VADPT is supported by DBIA 10061
 ;Reference to EN6^GMRVUTL is supported by DBIA 1120
 ;
EN(PSODFN,PSORD) ; - Entry point
 N VALMCNT,VALMHDR
 D EN^VALM("PSO NON-VA MEDS VIEW")
 Q
 ;
HDR      ; - Header
 N LINE1,LINE2,LINE3,WT,WTDT,HT,HTDT,VADM,DFN,PNAME,DOB,SEX,X,VADM,WT,HT,GMRVST,GMRVSTR,DOB,PNAME,SEX
 ;
 K VADM S DFN=PSODFN D DEM^VADPT
 S PNAME=VADM(1)
 S DOB=$S(+VADM(3):$P(VADM(3),"^",2)_" ("_$G(VADM(4))_")",1:"UNKNOWN")
 S SEX=$P(VADM(5),"^",2)
 S (WT,X)="",GMRVSTR="WT" D EN6^GMRVUTL I X'="" S WT=$J($P(X,"^",8)/2.2,6,2),WTDT=$$DT($P(X,"^")\1)
 S (HT,X)="",GMRVSTR="HT" D EN6^GMRVUTL I X'="" S HT=$J($P(X,"^",8)*2.54,6,2),HTDT=$$DT($P(X,"^")\1)
 S LINE1=PNAME S LINE1=$$ALLERGY^PSOPMP1(LINE1,DFN,"")
 S LINE2="  PID: "_$P(VADM(2),"^",2),$E(LINE2,50)="HEIGHT(cm): "_$S(HT'="":HT_" ("_HTDT_")",1:"NOT AVAILABLE")
 S LINE3="  DOB: "_DOB,$E(LINE3,30)="SEX: "_SEX,$E(LINE3,50)="WEIGHT(kg): "_$S(WT'="":WT_" ("_WTDT_")",1:"NOT AVAILABLE")
 ;
 K VALMHDR S VALMHDR(1)=LINE1,VALMHDR(2)=LINE2,VALMHDR(3)=LINE3
 ;
 Q
 ;
INIT ;
 N OINAM,DGNAM,CLNAM,LINE,NMSPC,L,DIWL,DIWR,X,I,OCK,PRV,STR,TXT,K,TXT,XX
 S XX=^PS(55,PSODFN,"NVA",PSORD,0),OINAM=$$GET1^DIQ(50.7,+$P(XX,"^"),.01)
 S DGNAM="" I $P(XX,"^",2) S DGNAM=$$GET1^DIQ(50,+$P(XX,"^",2),.01)
 ;
 S LINE=0,NMSPC="PSONVAVW" K ^TMP(NMSPC,$J)
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Non-VA Med: ",23)_OINAM
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Dispense Drug: ",23)_DGNAM
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Dosage: ",23)_$P(XX,"^",3)
 ;
 K ^UTILITY($J,"W")
 S X=$$SCHED^PSONVNEW($$GET1^DIQ(55.05,PSORD_","_PSODFN,4)),DIWL=1,DIWR=60 D ^DIWP
 F L=1:1 Q:'$D(^UTILITY($J,"W",1,L))  D
 . S X="" S:L=1 X=$J("Schedule: ",23) S $E(X,24)=^UTILITY($J,"W",1,L,0)
 . S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=X
 ;
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Med Route: ",23)_$P(XX,"^",4)
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Status: ",23)_$S('$P(XX,"^",6):"ACTIVE",1:"DISCONTINUED on "_$$DT($P(XX,"^",7)))
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("CPRS Order #: ",23)_$P(XX,"^",8)
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Documented By: ",23)_$$GET1^DIQ(200,+$P(XX,"^",11),.01)
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Documented Date: ",23)_$$DT($P(XX,"^",10))
 S CLNAM=$$GET1^DIQ(44,+$P(XX,"^",12),.01)
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Clinic: ",23)_$S($P(XX,"^",12):$P(XX,"^",12)_" - "_CLNAM,1:"")
 S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=$J("Start Date: ",23)_$$DT($P(XX,"^",9))
 ;
 ; - "Order Checks" fields
 W:$D(^PS(55,PSODFN,"NVA",PSORD,"OCK")) !
 F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",PSORD,"OCK",I)) Q:'I  D
 . S OCK=^PS(55,PSODFN,"NVA",PSORD,"OCK",I,0),STR=$P(OCK,"^"),PRV=+$P(OCK,"^",2)
 . K TXT D TEXT(.TXT,STR,61)
 . D STXT("       Order Check #"_I_": ",.TXT)
 . K TXT
 . F J=0:0 S J=$O(^PS(55,PSODFN,"NVA",PSORD,"OCK",I,"OVR",J)) Q:'J  D
 . . S STR=^PS(55,PSODFN,"NVA",PSORD,"OCK",I,"OVR",J,0)
 . . D TEXT(.TXT,STR,57)
 . D STXT("      Override Reason: ",.TXT)
 . S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)="    Override Provider: "_$S(PRV:$$GET1^DIQ(200,+PRV,.01),1:"")
 ;
 ; - "Statement/Explanation" field
 I $D(^PS(55,PSODFN,"NVA",PSORD,"DSC")) D
 . K TXT
 . F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",PSORD,"DSC",I)) Q:'I  D
 . . S STR=^PS(55,PSODFN,"NVA",PSORD,"DSC",I,0)
 . . D TEXT(.TXT,STR,57)
 . D STXT("Statement/Explanation: ",.TXT)
 ;
 ; - "Comments" field
 I $D(^PS(55,PSODFN,"NVA",PSORD,1)) D
 . K TXT
 . F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",PSORD,1,I)) Q:'I  D
 . . S STR=^PS(55,PSODFN,"NVA",PSORD,1,I,0)
 . . D TEXT(.TXT,STR,57)
 . D STXT("             Comments: ",.TXT)
 ;
 S VALMCNT=LINE
 Q
 ;
TEXT(TEXT,STR,L) ; Formats STR into TEXT array, lines lenght = L
 N J,WORD,K S K=+$O(TEXT(""),-1) S:'K K=1
 F J=1:1:$L(STR," ") D
 . S WORD=$P(STR," ",J) I ($L($G(TEXT(K))_WORD))>L S K=K+1
 . S TEXT(K)=$G(TEXT(K))_WORD_" "
 Q
 ;
STXT(LABEL,TXT) ; Sets text lines
 N K,X
 F K=1:1 Q:'$D(TXT(K))  D
 . S X="" S:K=1 X=LABEL S $E(X,24)=TXT(K)
 . S LINE=LINE+1,^TMP(NMSPC,$J,LINE,0)=X
 Q
 ;
DT(DT) ; - Convert FM Date to MM/DD/YYYY
 I 'DT Q ""
 I '(DT#10000) Q (1700+$E(DT,1,3))
 I '(DT#100) Q $E(DT,4,5)_"/"_(1700+$E(DT,1,3))
 Q $E(DT,4,5)_"/"_$E(DT,6,7)_"/"_(1700+$E(DT,1,3))
 ;
EXIT Q
 ;
HELP Q
