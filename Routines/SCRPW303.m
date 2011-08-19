SCRPW303 ; BPFO/JRC - Performance Monitor Report Utils; 30 Jul 2003 ; 4/2/04 7:21am
 ;;5.3;SCHEDULING;**292,313,438**; AUG 13, 1993
 ;
DSS(SCRNARR) ;Set Stop Codes into screen array (prompt is one/many/all)
 ;Input  : SCRNARR - Screen array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("DSS") = User pick all stop codes ?
 ;           1 = Yes (all)     0 = No
 ;         @SCRNARR@("DSS-NTNL") = Only stop codes in national cohort ?
 ;           1 = Yes           0 = No
 ;         @SCRNARR@("DSS",PtrStopCode) = Stop Code Name
 ;         @SCRNARR@("DSS-EXCLUDE",PtrStopCod) = SC Name
 ;Note   : @SCRNARR@("DSS") is initialized (KILLed) on input
 ;       : @SCRNARR@("DSS",PtrStopCode) is only set when the user
 ;         picked individual stop codes (i.e. didn't pick all) OR
 ;         when user selected stop codes by range (i.e. 100,102-300)
 ;       : @SCRNARR@("DSS-EXCLUDE") is only set if the user picked ALL
 ;         stop codes and choose to only use stop codes & credit pairs
 ;         from the national cohort
 ;       : @SCRNARR@("DSS-EXCLUDE") is set when
 ;         @SCRNARR@("DSS-NTNL") equals 1
 ;
 ;Declare variables
 N VAUTSTR,VAUTVB,VAUTNI,DSS,SCANARR,DIC,DIR,Y,X,CODE,ARRY,DIRUT,FLG
 K @SCRNARR@("DSS")
 ;Prompt user wether to use range for stop code selection or not
 S DIR(0)="Y",DIR("B")="No",FLG=0
 S DIR("A")="Would you like to select the Stop Codes by range "
 D ^DIR
 I $D(DIRUT)!$D(DTOUT) Q FLG
 I Y D RANGE(SCRNARR) Q FLG
 ;Get stop code selection using VAUTOMA
 I '$D(@SCRNARR@("DSS"))
 S DIC="^DIC(40.7,"
 S VAUTSTR="Stop Code"
 S VAUTVB="SCANARR"
 S VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 Q 0
 ;Does selection of ALL mean all stop codes in national cohort
 I $G(SCANARR)=1 D
 .N DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT
 .S DIR(0)="Y"
 .S DIR("B")="YES"
 .S DIR("A",1)="By ALL do you mean stop codes from the"
 .S DIR("A")="Performance Monitor national cohort "
 .D ^DIR
 .I $D(DIRUT) K SCANARR Q
 .I Y D NTNLESC(SCRNARR)
 .Q
 I '$D(SCANARR) Q 0
 I $D(@SCRNARR@("DSS")) Q 1
 S @SCRNARR@("DSS-NTNL")=0
 M @SCRNARR@("DSS")=SCANARR
 Q 1
 ;
SORT(SORTARR) ; Set sort order into sort array
 ;Input  : SORTARR - Sort array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SORTARR = Sort1Code^Sort2Code
 ;           Codes: 1 = Division   2 = Clinic
 ;                  3 = Provider   4 = Stop Code
 ;                  5 = Date       6 = Patient
 ;         @SORTARR@("TEXT") = Sort1Text^Sort2Text
 ;Note   : @SORTARR is initialized (KILLed) on input
 ;
 ;Declare variables
 N DIR,X,Y,DIRUT,DIROUT,DTOUT,DUOUT
 K @SORTARR
 ;Get sort level 1
 S DIR(0)="SC^1:DIVISION;2:CLINIC;3:PROVIDER;4:STOP CODE;5:DATE;6:PATIENT"
 S DIR("A")="Select primary sorting criteria"
 D ^DIR
 I $D(DIRUT) Q 0
 S @SORTARR=Y
 S @SORTARR@("TEXT")=$$SRT2TXT(Y)
 ;Get sort level 2
 K DIR,X,Y
 S DIR(0)="SC^1:DIVISION;2:CLINIC;3:PROVIDER;4:STOP CODE;5:DATE;6:PATIENT"
 S DIR("A")="Within "_@SORTARR@("TEXT")_" sort by"
 S DIR("S")="I Y'="_@SORTARR
 D ^DIR
 I $D(DIRUT) K @SORTARR Q 0
 S @SORTARR=@SORTARR_"^"_Y
 S @SORTARR@("TEXT")=@SORTARR@("TEXT")_"^"_$$SRT2TXT(Y)
 Q 1
SRT2TXT(CODE)   ;Convert sort code to sort text
 ;Input  : CODE - Sort code
 ;Output : Text for sort code
 ;
 I CODE=1 Q "division"
 I CODE=2 Q "clinic"
 I CODE=3 Q "provider"
 I CODE=4 Q "stop code"
 I CODE=5 Q "date"
 I CODE=6 Q "patient"
 Q ""
 ;
ROLLUP(SCRNARR,SORTARR) ;Set screen and sort arrays for national rollup
 ;Input  : SCRNARR - Screening array
 ;         SORTARR - Sort array full global reference
 ;Output : None
 ;         Nodes in @SCRNARR are set to denote the following:
 ;           Time limit of 10
 ;           Include all divisions
 ;           Use excluded stop codes from national cohort array
 ;           Count encounters with scanned progress notes
 ;         Nodes in @SORTARR are set to denote the following:
 ;           Primary sort is division
 ;           Secondary sort is date
 ;Note   : @SCRNARR and @SORTARR are initialized (KILLed) on input
 ;
 K @SCRNARR,@SORTARR
 S @SCRNARR@("TLMT")=10
 S @SCRNARR@("DIVISION")=1
 S @SCRNARR@("PROVIDERS")=1
 D NTNLESC(SCRNARR)
 S @SCRNARR@("SCANNED")=1
 S @SORTARR="1^5"
 S @SORTARR@("TEXT")="division^date"
 Q
 ;
NTNLSC(SCRNARR) ;Set inclusion array of stop codes for national reporting
 ;Input  : SCRNARR - Screening array
 ;Output : National list of acceptable stop code & credit pairs
 ;         @SCRNARR@("DSS") = 0
 ;         @SCRNARR@("DSS-NTNL") = 1
 ;         @SCRNARR@("DSS",PtrStopCode) = Stop Code Name
 ;         @SCRNARR@("DSS-PAIR",PtrStopCode,PtrStopCode) = SC Name ^ SC Name
 ;
 N OFF,TEXT,J,CODE,PTR1,TMP,PTR2
 S @SCRNARR@("DSS")=0
 S @SCRNARR@("DSS-NTNL")=1
 F OFF=1:1 S TEXT=$P($T(STOP+OFF),";;",2) Q:TEXT="END"  D
 .F J=1:1:$L(TEXT,"^") S CODE=$P(TEXT,"^",J) D
 ..S TMP=$L(CODE) Q:((TMP'=3)&(TMP'=6))
 ..I TMP=3 D  Q
 ...;Individual stop code
 ...S PTR1=$$SC2PTR(CODE) Q:'PTR1
 ...S @SCRNARR@("DSS",+PTR1)=$P(PTR1,"^",2)
 ..;Credit pair
 ..S PTR1=$$SC2PTR($E(CODE,1,3)) Q:'PTR1
 ..S PTR2=$$SC2PTR($E(CODE,4,6)) Q:'PTR2
 ..S @SCRNARR@("DSS-PAIR",+PTR1,+PTR2)=$P(PTR1,"^",2)_"^"_$P(PTR2,"^",2)
 Q
NTNLESC(SCRNARR) ;Set exclusion array of stop codes for national reporting
 ;Input  : SCRNARR - Screening array
 ;Output : National list of stop codes to be excluded
 ;         @SCRNARR@("DSS") = 0
 ;         @SCRNARR@("DSS-NTNL") = 1
 ;         @SCRNARR@("DSS-EXCLUDE",PtrStopCode) = Stop Code Name
 ;
 N OFF,TEXT,J,CODE,PTR1,TMP,PTR2
 S @SCRNARR@("DSS")=0
 S @SCRNARR@("DSS-NTNL")=1
 F OFF=1:1 S TEXT=$P($T(EXCSTOP+OFF),";;",2) Q:TEXT="END"  D
 .F J=1:1:$L(TEXT,"^") S CODE=$P(TEXT,"^",J) D
 ..S TMP=$L(CODE) Q:((TMP'=3)&(TMP'=6))
 ..I TMP=3 D  Q
 ...;Individual stop code for exclusion
 ...S PTR1=$$SC2PTR(CODE) Q:'PTR1
 ...S @SCRNARR@("DSS-EXCLUDE",+PTR1)=$P(PTR1,"^",2)
 Q
RANGE(SCRNARR) ;Screen array by range
 N DIR,DIRUT,DTOUT,Y,SUB,NODE,CODE,PTR1,J
 S @SCRNARR@("DSS")=0
 S @SCRNARR@("DSS",1)=""
 S @SCRNARR@("DSS-NTNL")=0
 S DIR("A")="Select individual Stop Code or a range of Codes "
 S DIR("?")="This response must be a list or range, e.g., 100,302 or 200-450,800 "
 S DIR(0)="L"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT) Q
 I Y D
 .S FLG=1
 .S SUB="" F  S SUB=$O(Y(SUB)) Q:SUB=""  D
 ..S NODE=(Y(SUB))
 ..F J=1:1:$L(NODE,",") S CODE=$P(NODE,",",J) I CODE D
 ...S PTR1=$$SC2PTR(CODE) Q:'PTR1
 ...S @SCRNARR@("DSS",+PTR1)=$P(PTR1,"^",2)
 Q
SC2PTR(CODE)    ;Get pointer to stop code
 ;Input  : CODE - Stop code
 ;Output : Pointer #40.7 ^ Name (#.01)
 ;
 N NODE,PTR
 S PTR=+$O(^DIC(40.7,"C",CODE,0)) I 'PTR Q "0^INVALID STOP CODE"
 S NODE=$G(^DIC(40.7,PTR,0))
 Q PTR_"^"_$P(NODE,"^",1)
 ;
STOP ;List of acceptable stop codes and credit pairs
 ;;END
 ;
EXCSTOP ;Exclusion list of stop codes
 ;;104^105^106^107^108^109^115^116^117^120^126^127^128^144^145
 ;;146^149^150^151^152^153^154^155^165^166^167^168^169^174^190
 ;;202^205^206^207^208^212^213^214^290^291^292^293^294^295^296
 ;;321^327^328^329^333^334^370^417^421^422^423^429^430^431^435
 ;;450^451^452^453^454^455^456^458^459^460^461^462^463^464^465
 ;;466^467^468^469^470^471^472^473^474^475^476^477^478^479^481
 ;;482^483^484^485^505^506^510^513^516^519^521^522^523^525^535
 ;;538^545^547^550^553^554^557^558^559^560^561^563^564^565^566
 ;;573^574^575^577^578^590^602^603^604^606^607^608^610^650^651
 ;;652^653^654^655^656^657^660^670^680^681^682^690^691^701^702
 ;;703^704^705^706^707^708^709^710^711^725^730^731^900^999
 ;;END
 ;
