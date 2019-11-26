ECXUTL6 ;ALB/JRC - Utilities for DSS Extracts ;4/8/19  11:11
 ;;3.0;DSS EXTRACTS;**92,105,112,119,132,154,170,173,174**;Dec 22, 1997;Build 33
 ;
NUTKEY(P,D) ;Generate n&fs feeder key
 ;Required variables
 ;      p  - diet type production diet, standing orders, supplemental
 ;           feedings, or tube feedings.
 ;      d  - diet ien from files 116.2, 118.3, 118, or 118.2
 ;Check input
 I $G(P)=""!'$G(D) Q ""
 ;Init variables
 N PRO,IENS,CODE,DIET
 S (PRO,IENS,CODE,DIET)=0
 S PRO=$O(^ECX(728.45,"B",P,PRO))
 S CODE=D_$S(P="PD":";FH(116.2,",P="SO":";FH(118.3,",P="SF":";FH(118,",P="TF":";FH(118.2,",1:"")
 S DIET=0,DIET=$O(^ECX(728.45,+PRO,1,"B",CODE,DIET))
 S IENS=""_DIET_","_PRO_","_""
 Q $$GET1^DIQ(728.451,IENS,1)
 ;
NUTLOC(P,D,FPD,FDD,FPF,DLT,DFL) ;Define nutrition fields
 ;Required variables
 ;      p  - patient status, inpatient or outpatient
 ;
 ;      d  - diet type production diet, standing orders, supplemental
 ;            feedings, or tube feedings.
 ;    Output: food production division, food delivery division, food
 ;            production facility, food delivery type, delivery feeder
 ;            location
 ;Init variables
 N WARD,TRSVP,CRSVP,OPLOC,MASWARD
 S (CRSVP,TRSVP)=0,(WARD,DLT,DFL,MASWARD)=""
 S OPLOC=""
 ;Check input
 I $G(P)=""!($G(D)="")!'($G(FHDFN)) Q ""
 ;Get food production facility for inpatient, use 115.1.13 (dietetic
 ;ward) field which points 119.6 (nutrition location), field 3 (tray
 ;service point) or field 4 (cafeteria service point), which points to
 ;119.72 (production facility) field 2.
 I P="INP" D
 .N VAHOW
 .K ^UTILITY("VAIP",$J)
 .S DFN=$P($G(^FHPT(FHDFN,0)),U,3)
 .S VAIP("D")=$G(SDATE),VAHOW=2
 .D IN5^VADPT
 .S MASWARD=+^UTILITY("VAIP",$J,5)
 .S WARD=$O(^FH(119.6,"AW",+MASWARD,0))
 .S:+WARD'>0 WARD=""
 .S TRSVP=$$GET1^DIQ(119.6,WARD,3,"I")
 .S CRSVP=$$GET1^DIQ(119.6,WARD,4,"I")
 .;Get divisions
 .D GETDIV
 .Q
 ;
 ;Get food production facility for OP Supplemental feedings,
 ;use 115.1.13 (dietetic
 ;ward) field which points 119.6 (nutrition location), field 3 (tray
 ;service point) or field 4 (cafeteria service point), which points to
 ;119.72 (production facility) field 2.
 I P["OP",D["SF" D
 .S OPLOC=""_$P(^TMP($J,"FH",DATE,FHDFN,NUMBER,"RM"),U,3)_","_""
 .S TRSVP=$$GET1^DIQ(119.6,OPLOC,3,"I")
 .;Get delivery division
 .D GETDIV
 .Q
 ;Get food production facility for OP Standing Orders,
 ;use 115.1.13 (dietetic
 ;ward) field which points 119.6 (nutrition location), field 3 (tray
 ;service point) or field 4 (cafeteria service point), which points to
 ;119.72 (production facility) field 2.
 I P["OP",D["SO" D
 .S OPLOC=""_$P(^TMP($J,"FH",DATE,FHDFN,NUMBER,"RM"),U,3)_","_""
 .S TRSVP=$$GET1^DIQ(119.6,OPLOC,3,"I")
 .;Get delivery division
 .D GETDIV
 .Q
 ;Get food production facility for outpatient recurring meal, use
 ;115.16.2 (outpatient location) which points to file 119.6 (nutrition
 ;location) field 3 (tray service point) or field 4 (cafeteria service
 ;point), which points to 119.72 (production facility) field 2.
 I P["OP",D["RM" D
 .S OPLOC=""_$P(NODE,U,3)_","_"",TRSVP=$$GET1^DIQ(119.6,OPLOC,3,"I")
 .D GETDIV
 .Q
 ;
 ;Get food production facility for outpatient tube feeding, use
 ;115.16.2 (outpatient location) then use 119.6 nutrition location
 ;which points to 119.72 field 2.
 I P["OP",D["TF" D
 .S OPLOC=""_$P(^TMP($J,"FH",DATE,FHDFN,NUMBER,"RM"),U,3)_","_""
 .S TRSVP=$$GET1^DIQ(119.6,OPLOC,3,"I")
 .;Get delivery division
 .D GETDIV
 .Q
 ;
 ;Get food production facility for special meals, use 115.17.2
 ;location field 2 which is a pointer to 119.6 (nutrition location)
 ;which points to 119.72 via field 2 (tray service point) which points
 ;to file 119.71 (production facility) field 2.
 I P["OP",D["SM" D
 .S OPLOC=""_$P(NODE,U,3)_","_""
 .S TRSVP=$$GET1^DIQ(119.6,OPLOC,3,"I")
 .;Get delivery division
 .D GETDIV
 .Q
 ;
 ;Get food production facility for outpatient guest meals, use
 ;115.18.4 (outpatient location) then use 119.6 nutrition location
 ;which points to 119.72 (production facility) field 2.
 I P["OP",D["GM" D
 .S OPLOC=""_$P(NODE,U,5)_","_"",TRSVP=$$GET1^DIQ(119.6,OPLOC,3,"I")
 .S FPF=$$GET1^DIQ(119.72,""_TRSVP_","_"",2,"I")
 .;Get delivery division
 .D GETDIV
 .Q
 ;
 ;Get delivery location type for patients; with inpatients the type of
 ;service needs to be pulled from the admission node, with outpatients
 ;the type of service needs to be pulled from different nodes and use
 ;field 101 of Nutrition Location file (#119.6). Delivery location
 ;types only set for the following meals:
 ;   Inpatient with a production diet
 ;   Outpatient with a recurring meal
 ;   Outpatient with a special meal
 ;   Outpatient with a guest meal
 ;   all other meals are null
 I P="INP",D="PD" D
 .S DLT=$P($G(NODE),U,8)
 I P="OP",((D="RM")!(D="SM")) D
 .S DLT=$E($$GET1^DIQ(119.6,""_$P(NODE,U,3)_","_"",101,"E"),1)
 I P="OP",D="GM" D
 .S DLT=$E($$GET1^DIQ(119.6,""_$P(NODE,U,5)_","_"",101,"E"),1)
 ;
 ;Delivery feeder location
 I DLT="C" D
 .S DFL=$E($$GET1^DIQ(119.6,WARD,4,"E"),1,10)
 .S IEN=$$GET1^DIQ(119.72,+CRSVP,2,"I")
 .S IEN=""_IEN_";FH(119.71,"
 .S FPF=$O(^ECX(728.46,"B",IEN,FPF))
 .S FPF=$E($$GET1^DIQ(728.46,FPF,.01,"E"),1,10)
 I (DLT["T")!(DLT["D") D
 .I P="INP" D
 ..S DFL=$$GET1^DIQ(42,+MASWARD,44,"I")
 .I P="OP" D
 ..S DFL=$O(^FH(119.6,+OPLOC,"L","B",0))
 I (DLT=""),"SFTFSO"[D D
 .S DFL=$S(TRSVP:$$GET1^DIQ(119.6,+WARD,3,"E"),1:$$GET1^DIQ(119.6,+WARD,4,"E"))
 Q 1
 ;
GETDIV ;Get divisions and food production facility
 ;Init variables
 N IEN,SIEN,SVP
 S (FDD,FPF,FPD)=""
 S SVP=$S(TRSVP:TRSVP,CRSVP:CRSVP,1:"")
 S IEN=$$GET1^DIQ(119.72,+SVP,2,"I")
 Q:'IEN
 ;Get delivery division
 S SIEN=""_+SVP_";FH(119.72,"
 S FDD=$O(^ECX(728.46,"B",SIEN,FDD))
 S FDD=""_$$GET1^DIQ(728.46,FDD,1,"I")_","_""
 S FDD=$$GET1^DIQ(4,FDD,99,"E")
 ;Get production division and food production facility
 S IEN=""_IEN_";FH(119.71,"
 S FPF=$O(^ECX(728.46,"B",IEN,FPF))
 S FPD=""_$$GET1^DIQ(728.46,FPF,1,"I")_","_""
 S FPD=$$GET1^DIQ(4,FPD,99,"E")
 S FPF=$E($$GET1^DIQ(728.46,FPF,.01,"E"),1,10)
 Q
 ;
SUR(CRST,STCD,CLINIC) ;Surgery stop codes and clinic (outpatients only)
 ;Quit if not outpatient
 I ECXA="I" Q  ;174 Only set stop code, credit stop, and clinic if patient is an outpatient
 S CLINIC=$S($P(EC0,U,21):$P(EC0,U,21),$P(ECNO,U,2):$P(ECNO,U,2),1:$$GET1^DIQ(137.45,$P(EC0,U,4),2,"I")) ;174 Set clinic to associated clinic or non-OR location or surgical specialty's associated clinic
 ;Next, get stop code from file 728.44, if not found get it from file 44, if not found default to 435 if it's a non-OR procedure, otherwise 429
 S STCD=$P($G(^ECX(728.44,+CLINIC,0)),U,4) S:STCD="" STCD=$$GET1^DIQ(40.7,$$GET1^DIQ(44,+CLINIC,8,"I"),1,"E") S:STCD="" STCD=$S($P(ECNO,U)="Y":435,1:429) ;174
 S CRST=$P($G(^ECX(728.44,+CLINIC,0)),U,5) S:CRST="" CRST=$$GET1^DIQ(40.7,$$GET1^DIQ(44,+CLINIC,2503,"I"),1,"E") ;174 Set credit stop code to value in 728.44 else from file 44
 Q
 ;
SURPODX(PRODX,PODX1,PODX2,PODX3,PODX4,PODX5) ;Get postop diagnosis codes
 ;Init variables
 N CODE,I,PODX
 S (PRODX,PODX1,PODX2,PODX3,PODX4,PODX5)="",CODE=0
 ;Check input
 Q:'$D(DATAOP) 0
 ;Get principal postop dx code
 I $P(DATAOP,U,3)'="" S PRODX=$$CODEC^ICDEX(80,$P(DATAOP,U,3)) ;154
 ;Get other postop dx codes
 S (CODE,I)=0 F  S CODE=$O(^SRO(136,ECD0,4,CODE)) Q:'CODE  Q:I>5  D
 .S I=I+1,PODX="PODX"_I I $P(^SRO(136,ECD0,4,CODE,0),U)'="" S @PODX=$$CODEC^ICDEX(80,$P(^SRO(136,ECD0,4,CODE,0),U)) ;154
 Q 1
 ;
LOINC(ARRAY) ;Get DSS lab test information out of DSS LOINC CODE (#727.29) file
 ;Input
 ;   ARRAY(LOINC-CK) := array of valid LOINC (#727.29 DSS LOINC CODE)
 ;                      entries with their check digit
 ;   or,
 ;   ARRAY("ALL")    := request for all LOINC entries
 ;Output
 ;   ^TMP($J,"EXCUTL6",LOINC-CK)  =
 ;              zero node of file 727.29 pieces 1 thru 4
 ;              piece 1 := LOINC-CK (LOINC-check digit)
 ;              piece 2 := DSS lar test number
 ;              piece 3 := DSS test name
 ;              piece 4 := DSS Reporting units
 ;              piece 5 := LOINC name
 ;              piece 6 := pointer to LAB LOINC (#95.3) code entry
 ;             (delimited by "^")
 ;          -1 := not a valid loinc entry from file 727.29
 ;          -2 := no dss lar test number associated with loinc
 ;
 ;   ^TMP($J,"ECXUTL6",LOINC-CK,WKLD,SPEC/-or-"DEFAULT",LTEST)= 
 ;              piece 1 := WKLD Code (external)
 ;              piece 2 := specimen (external) or "DEFAULT LOINC"
 ;              piece 3 := laboratory test (external)
 ;              piece 4:= local LOINC code external
 ;             (delimited by "^")
 ;
 ;
 I '$D(ARRAY) Q
 K ^TMP($J,"ECXUTL6")
 N LOINCCK,LIEN,SPEC,EC0,WKLD,WKLD0,TA,LRASSV,LOINCPTR,LTEST,LLNC,LLNCP,SPECD
 S LOINCCK=""
 I $D(ARRAY("ALL")) D
 . F  S LOINCCK=$O(^ECX(727.29,"B",LOINCCK)) Q:'LOINCCK  D EXT
 E  D
 . F  S LOINCCK=$O(ARRAY(LOINCCK)) Q:'LOINCCK  D EXT
 Q
 ;
EXT I '$D(^ECX(727.29,"B",LOINCCK)) S ^TMP($J,"ECXUTL6",LOINCCK)=-1_"^no entry in DSS LOINC CODE (#727.29)." Q
 S LIEN=$O(^ECX(727.29,"B",LOINCCK,0))
 I '$P(^ECX(727.29,LIEN,0),U,2) S ^TMP($J,"ECXUTL6",LOINCCK)=-2_"^no dss test number found." Q
 S EC0=^ECX(727.29,LIEN,0)
 S ^TMP($J,"ECXUTL6",LOINCCK)=EC0_"^"
 S LOINCPTR=""
 ;**Lexicon LOINC Code - test whether LEX*2*75 installed.
 ;  Else, get directly from file #95.3
 S X="LEXLR" X ^%ZOSF("TEST") I '$T D
 . I LOINCCK=$$GET1^DIQ(95.3,$P(LOINCCK,"-"),.01) D
 . . S LOINCPTR=$$GET1^DIQ(95.3,$P(LOINCCK,"-"),.01,"I")
 S X="LEXLR" X ^%ZOSF("TEST") I $T D
 . S LOINCPTR=$$CHKCODE^LEXLR(LOINCCK) ;DBIA5547
 ;**
 I LOINCPTR D
 . S ^TMP($J,"ECXUTL6",LOINCCK)=^TMP($J,"ECXUTL6",LOINCCK)_LOINCPTR
 . S WKLD=0 F  S WKLD=$O(^LAM("AI",LOINCPTR,WKLD)) Q:'WKLD  D
 . . S SPEC=0 F  S SPEC=$O(^LAM("AI",LOINCPTR,WKLD,SPEC)) Q:'SPEC  D
 . . . S TA=0
 . . . F  S TA=$O(^LAM(WKLD,5,SPEC,1,TA)) Q:'TA  D
 . . . . S SPECD=^LAM(WKLD,5,SPEC,1,TA,0)
 . . . . S LTEST=$P(SPECD,"^",4)
 . . . . I LTEST,($P($G(^LAB(60,LTEST,64)),"^",2)=WKLD),($$GET1^DIQ(60,LTEST,3,"I")'="N") D
 . . . . . S ^TMP($J,"ECXUTL6",LOINCCK,WKLD,SPEC,LTEST)=$$GET1^DIQ(64,WKLD,.01)_"^"_$$GET1^DIQ(61,SPEC,.01)_"^"_$$GET1^DIQ(60,LTEST,.01)_"^"_LOINCCK
 Q
 ;
INPUTT ;
 N DIC S DIC="^DIC(40.7,",DIC(0)="EMZ",DIC("S")="I '$P(^(0),U,3)&($L($P(^(0),U,2)'=3)) Q"
 D ^DIC K:Y<0 X Q:Y<0
 S X=$S($D(Y(0)):$P(Y(0),U,2),1:"") K:X=""!($L(X)'=3) X K DIC
 Q
 ;
ISASIH(MVMT,TYPE) ;170 Section added to determine if patient is ASIH other facility at movement date/time
 N ASIH,VAIP,DFN
 S ASIH=0
 S:TYPE=2 VAIP("E")=MVMT
 S:TYPE=3 VAIP("D")=$$FMADD^XLFDT($P(^DGPM(MVMT,0),U),,,,-1)
 S DFN=$P($G(^DGPM(MVMT,0)),U,3)
 D IN5^VADPT
 I "^43^45^46^"[("^"_+VAIP(4)_"^") S ASIH=1
 Q ASIH
 ;
NEEDADR(TYPE,MVMT,EXTRACT) ;170 Section added to determine if an admission or discharge record for the ASIH other facility episode of care is needed
 N REC,VAIP,DFN,NEXTMO ;173
 S NEXTMO=$$NEXTMO(ECED) ;173 Get year/month for next month
 S REC=1
 S VAIP("E")=MVMT
 S DFN=$P($G(^DGPM(MVMT,0)),U,3)
 D IN5^VADPT
 I TYPE="TRAN"&(EXTRACT="ADM") I "^43^45^46^"[("^"_$P($G(VAIP(15,3)),U)_"^") S REC=0
 I TYPE="TRAN"&(EXTRACT="MOV") D  ;173
 .I $G(VAIP(16))="" S REC=0 S ^XTMP("ECXMOV",NEXTMO,MVMT)="" Q  ;173 If there isn't a "next" movement, save it for next month
 .I $P($G(VAIP(16,1)),U)'>ECSD S REC=0 Q  ;173 Don't create a record if it's before the extract start date
 .I $P($G(VAIP(16,1)),U)'>ECED I "^43^45^46^"[("^"_$P($G(VAIP(16,3)),U)_"^")!(+$G(VAIP(16,2))'=2) S REC=0 Q  ;173 If next movement in timeframe and it's not continuing ASIH or a discharge then create a record
 .I $P($G(VAIP(16,1)),U)>ECED S REC=0 I $$ECXYM^ECXUTL($P($G(VAIP(16,1)),U))>$$ECXYM^ECXUTL(ECED) S ^XTMP("ECXMOV",NEXTMO,MVMT)="" ;173 If next movement is after extract end date and is in the next month, save it
 I TYPE="DIS" I "^43^45^46^"'[("^"_$P($G(VAIP(15,3)),U)_"^") S REC=0
 Q REC_"^"_$S(REC&(EXTRACT="MOV")&(TYPE="TRAN"):$G(VAIP(16)),REC:MVMT,1:"")
 ;
NEXTMO(DATE) ;173 Given a date, determine the following month and return in year_month format (ex. 201811 for 11/2018)
 N NEXT,DTSTR
 S NEXT=""
 Q:DATE="" NEXT
 S DTSTR=$E(DATE,1,5)_"01" ;Set DTSTR to first of the month
 S DTSTR=$$FMADD^XLFDT(DTSTR,32) ;Get date 32 days from the 1st of the previous month
 S DTSTR=$$FMADD^XLFDT(DTSTR,-($E(DTSTR,6,7))) ;Subtract number of days into next month to get the last day of the previous month
 S DTSTR=$$FMADD^XLFDT(DTSTR,1) ;Add one day to get first day of next month
 S NEXT=$$ECXYM^ECXUTL(DTSTR) ;Convert FM date to year_month format
 Q NEXT
