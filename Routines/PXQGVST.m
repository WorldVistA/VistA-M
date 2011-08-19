PXQGVST ;ISL/JVS - GATHER ENCOUNTERS ;8/29/96  10:32
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**4**;Aug 12, 1996
 ;
 ;
 ;
VISITLST(DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--GATHER VISITS
 ;
 ; DFN     = Patient Identification entry number         (required)
 ; BEGINDT = Begining date of date range-INTERNAL FORMAT (optional)
 ; ENDDT   = Ending date of date range-INTERNAL FORMAT   (optional)
 ; HLOC    = Hospital Location (pointer to file#44)      (optional)
 ; SCREEN  = Code as related to field 15003              (required)
 ;         
 ;         ..'A'=ANCILLARY
 ;         ..'P'=PRIMARY
 ;         ..'O'=OCCASION OF SERIVCE
 ;         ..'S'=STOP CODES
 ;         ..'X'=All three above plus the 'NULL' Encounters (DEFAULT)
 ;
 ;         ..'E'=Historical Encounters ('XE' for all historical visits)
 ;
 ; APPOINT
 ;         ..-1
 ;         ..0
 ;         ..1
 ; OUTPUT:
 ; >0   = VISIT IEN
 ; =0   = User selected to add a visit
 ; -1   = No visit selected
 ; -2^"TEXT"   = error of some kind^mesage about error
 ;
 ;
 ;--Validate A PATIENT visit is sent in
 I $G(DFN)<1 Q -2_"^"_"NO PATIENT"
 I '$D(^AUPNPAT(DFN)) Q -2_"^"_"NO SUCH PATIENT"
 ;
 ;
 N STOP
 I $G(HLOC) D  Q:$G(STOP) -2_"^"_"NO SUCH HOSPITAL LOCATION"
 .I '$D(^SC(HLOC)) S STOP=1
 ;
 ;--NEW variables
 N IEN,INDATEI,INDATEE,PXBC,PXBCC,VST,PXBI,SCRN,SCRN1,ENDDTT,BEGINDTT
 N PXBHIGH,PXBCNT,PXBWIN,PXBSAVE,PXBDT,DEL,NOD0,NOD150,UID,STATUS
 N HLOCE,HLOCI,VAL,VAR,GROUP2
 S (PXBC,PXBCC)=0
 ;--KILL variables
 K ^TMP("PXBU",$J),^UTILITY("DIQ1",$J),^TMP("PXBKY",$J),^TMP("PXBSAM",$J),^TMP("PXBSKY",$J),GROUP
 ;--CREATE tmp global
 ;-SET UP SCREEN
 I $D(SCREEN) D
 .S PXBI="" F PXBI=1:1:$L(SCREEN) S SCRN($E(SCREEN,PXBI))=""
 .I '$D(SCRN) S SCRN("X")=""
 I $D(^AUPNVSIT("AA",DFN)) D
 .I $G(ENDDT) S ENDDTT=9999999-$P(ENDDT,".",1) S:ENDDT["." ENDDTT=ENDDTT_((ENDDT#1)-(.0001)) S:ENDDT'["." ENDDTT=(ENDDTT)-(.0001) S ENDDT=ENDDTT
 .I $G(BEGINDT) S BEGINDTT=9999999-$P(BEGINDT,".",1) S:BEGINDT["." BEGINDTT=BEGINDTT_(BEGINDT#1) S:BEGINDT'["." BEGINDTT=BEGINDTT_".999999" S BEGINDT=BEGINDTT
 .I '$G(BEGINDT) S BEGINDT=999999999
 .S PXBDT=$S($G(ENDDT):ENDDT,1:"")
 .F  S PXBDT=$O(^AUPNVSIT("AA",DFN,PXBDT)) Q:PXBDT>BEGINDT  Q:PXBDT'>0  D
 ..S IEN=0 F  S IEN=$O(^AUPNVSIT("AA",DFN,PXBDT,IEN)) Q:IEN=""  D
 ...;
 ...;-----SCREEN-------
 ...;----BRING IN ALL NODES
 ...S NOD0=$G(^AUPNVSIT(IEN,0)),NOD150=$G(^AUPNVSIT(IEN,150))
 ...;--SCREEN BASED ON PARAMETER
 ...S SCRN1=$P(NOD150,"^",3)
 ...I SCRN1="",'$D(SCRN("X")) Q
 ...I $D(SCRN("X")) G CON
 ...I SCRN1="A",'$D(SCRN("A")) Q
 ...I SCRN1="O",'$D(SCRN("O")) Q
 ...I SCRN1="P",'$D(SCRN("P")) Q
 ...I SCRN1="S",'$D(SCRN("S")) Q
 ...I SCRN1="C",'$D(SCRN("C")) Q
CON ...;--CONTINUE
END ...;---END OF SCREENS-----
 ...S PXBC=PXBC+1
 ...S ^TMP("PXBU",$J,"VST",IEN)=""
 K SCRN,SCRN1
 ;
 ;
A ;--Set array with the VISITS from the visits
 N DIQ,PRIME,PRIMI,PXBDT,VSTDTE,VSTDTI,GROUP,CATE,CATI,GROUP1
 N APP,DISP,HIST
 I $D(^TMP("PXBU",$J,"VST")) D
 .S IEN=0 F  S IEN=$O(^TMP("PXBU",$J,"VST",IEN)) Q:IEN'>0  D
 ..S DIC=9000010,DR=".01;.07;.22;15003;15001",DA=IEN,DIQ(0)="EI" D EN^DIQ1
 ..S VSTDTE=$G(^UTILITY("DIQ1",$J,9000010,DA,.01,"E"))
 ..S VSTDTE=$P(VSTDTE,"@",1)_"   "_$P($P(VSTDTE,"@",2),":",1,2)
 ..S VSTDTI=$G(^UTILITY("DIQ1",$J,9000010,DA,.01,"I"))
 ..S CATE=$G(^UTILITY("DIQ1",$J,9000010,DA,.07,"E"))
 ..S CATI=$G(^UTILITY("DIQ1",$J,9000010,DA,.07,"I"))
 ..S HLOCE=$G(^UTILITY("DIQ1",$J,9000010,DA,.22,"E"))
 ..S HLOCI=$G(^UTILITY("DIQ1",$J,9000010,DA,.22,"I"))
 ..S PRIME=$G(^UTILITY("DIQ1",$J,9000010,DA,15003,"E"))
 ..S PRIMI=$G(^UTILITY("DIQ1",$J,9000010,DA,15003,"I"))
 ..S UID=$G(^UTILITY("DIQ1",$J,9000010,DA,15001,"E"))
 ..I $$VSTAPPT^PXUTL1(DFN,$P(^AUPNVSIT(IEN,0),"^",1),$P(^AUPNVSIT(IEN,0),"^",22),IEN) S APP="APP"
 ..I $$DISPOSIT^PXUTL1(DFN,$P(^AUPNVSIT(IEN,0),"^",1),IEN) S DISP="DIS"
 ..I $P(^AUPNVSIT(IEN,0),"^",7)="E" S HIST="HIS"
 ..S STATUS=$P($$STATUS^SDPCE(IEN),"^",2)
 ..S GROUP=VSTDTE_"^"_VSTDTI_"^"_HLOCE_"^"_HLOCI_"^"_PRIME_"^"_PRIMI_"^"_UID_"^"_STATUS
 ..S GROUP1=IEN_"^"_VSTDTI_"^"_HLOCI_"^"_CATI_"^"_PRIMI_"^"_$G(APP)_"^"_$G(DISP)_"^"_$G(HIST)
 ..S GROUP2=IEN_"^"_VSTDTI_"^"_HLOCI_"^"_$P($G(^AUPNVSIT(IEN,0)),"^",23)_"^"_$P($G(^AUPNVSIT(IEN,0)),"^",24)_"^"_$P($G(^AUPNVSIT(IEN,812)),"^",2)_"^"_$P($G(^AUPNVSIT(IEN,812)),"^",3)
 ..K APP,DISP,HIST
 ..S ^TMP("PXBVSTG",$J,VSTDTI,IEN)=$S($G(PXQINT):GROUP1,$G(PXQSOR):GROUP2,1:GROUP)
 K DIC,DR,DA
 ;
 ;
B ;--ADD Line Numbers
 I $D(^TMP("PXBVSTG",$J)) D
 .S PXBCC=PXBC+1,VST="" F  S VST=$O(^TMP("PXBVSTG",$J,VST)) Q:VST=""  D
 ..S IEN=0 F  S IEN=$O(^TMP("PXBVSTG",$J,VST,IEN)) Q:IEN=""  S PXBCC=PXBCC-1 D
 ...S ^TMP("PXBKY",$J,VST,PXBCC)=$G(^TMP("PXBVSTG",$J,VST,IEN))
 ...S ^TMP("PXBSAM",$J,PXBCC)=$G(^TMP("PXBVSTG",$J,VST,IEN))
 ...S ^TMP("PXBSKY",$J,PXBCC,IEN)=""
 ;
F ;--FINISH UP THE VARIABLES
 K ^TMP("PXBU",$J),^UTILITY("DIQ1",$J)
 S PXBCNT=+$G(PXBC)
 D DISP^PXQGVST1
 Q VAL
 ;
