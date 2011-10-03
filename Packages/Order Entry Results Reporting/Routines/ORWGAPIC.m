ORWGAPIC ; SLC/STAFF - Graph Application Calls - Labs, Meds ;11/1/06  12:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
AA(IEN) ; $$(ien) -> external display of accession area
 Q $P($G(^LRO(68,IEN,0)),U)
 ;
AALAB(TEST) ; $$(lab test) -> accession ien^acc name^acc abbrev
 N AA,DIV
 S TEST=+$G(TEST)
 S DIV=+$G(DUZ(2))
 S AA=+$P($G(^LAB(60,+TEST,8,DIV,0)),U,2)
 I AA Q AA_U_$$ACCLAB(AA)
 S AA=+$P($G(^LAB(60,+TEST,8,+$O(^LAB(60,+TEST,8,0)),0)),U,2)
 I AA Q AA_U_$$ACCLAB(AA)
 Q ""
 ;
ACC(DATA) ; API - get accession areas   - from ORWGAPI
 N CNT,IEN,TMP,RESULT,ZERO
 D RETURN^ORWGAPIW(.TMP,.DATA)
 S CNT=0
 S IEN=0
 F  S IEN=$O(^LRO(68,IEN)) Q:IEN<1  D
 . S ZERO=$G(^LRO(68,IEN,0)) I '$L(ZERO) Q
 . S RESULT="68^"_IEN_U_$P(ZERO,U)_U_$P(ZERO,U,11)
 . D SETUP^ORWGAPIW(.DATA,RESULT,TMP,.CNT)
 Q
 ;
ACCLAB(AA) ; $$(accession ien) -> acc name^acc abbrev
 N ZERO
 S ZERO=$G(^LRO(68,AA,0)) I '$L(ZERO) Q ""
 Q "lab - "_$P(ZERO,U)_U_$P(ZERO,U,11)
 ;
ADDDRUG(IEN) ; $$(additive) -> drug in 50 else ""
 N RESULT K ^TMP($J,"RX")
 I '$G(IEN) Q ""
 D ZERO^PSS52P6(IEN,,,"RX")
 S RESULT=$P($G(^TMP($J,"RX",IEN,1)),U)
 K ^TMP($J,"RX")
 Q RESULT
 ;
BCMAX(DFN) ; $$(dfn) -> 1 if patient has data else 0
 Q $O(^PSB(53.79,"B",+$G(DFN),0))>0
 ;
DC(IEN) ; $$(ien) -> external display of drug class
 N RESULT K ^TMP($J,"RX")
 I '$G(IEN) Q ""
 D IEN^PSN50P65(IEN,,"RX")
 S RESULT=$G(^TMP($J,"RX",IEN,1))
 K ^TMP($J,"RX")
 Q RESULT
 ;
DRGCLASS(DRUG) ; $$(drug) -> drug class^classification
 N RESULT K ^TMP($J,"RX")
 I '$G(DRUG) Q ""
 D DATA^PSS50(DRUG,,,,,"RX")
 S RESULT=+$G(^TMP($J,"RX",DRUG,25))
 K ^TMP($J,"RX")
 Q RESULT_U_"drug - "_$$DC(RESULT)
 ;
DRUG(NUM) ; $$(bcma entry) -> drug in 50 else ""
 N DONE,DRUG,NUM1
 S DONE=0,NUM=+$G(NUM)
 S NUM1=0
 F  S NUM1=$O(^PSB(53.79,NUM,.5,"B",NUM1)) Q:NUM1<1  S DONE=1 Q
 I DONE Q NUM1
 S DRUG=0
 S NUM1=0
 F  S NUM1=$O(^PSB(53.79,NUM,.6,"B",NUM1)) Q:NUM1<1  D  I DONE Q
 . S DRUG=$$ADDDRUG(NUM1)
 . I DRUG S DONE=1
 I DONE Q DRUG
 S DRUG=0
 S NUM1=0
 F  S NUM1=$O(^PSB(53.79,NUM,.7,"B",NUM1)) Q:NUM1<1  D  I DONE Q
 . S DRUG=$$SOLDRUG(NUM1)
 . I DRUG S DONE=1
 I DONE Q DRUG
 Q ""
 ;
DRUGC(VALUES) ; API - get drug classes   - from ORWGAPI
 N CLASS,IEN,NUM,ROOT K VALUES
 S NUM=0
 S ROOT=$$ROOT^PSN50P65(1)
 S CLASS=""
 F  S CLASS=$O(@ROOT@(CLASS)) Q:CLASS=""  D
 . S IEN=0
 . F  S IEN=$O(@ROOT@(CLASS,IEN)) Q:IEN=""  D
 .. S NUM=NUM+1
 .. S VALUES(NUM)="50.605^"_IEN_U_CLASS
 M ^TMP("ORWGRPC",$J)=VALUES K VALUES
 Q
 ;
INSIG(NODE) ; $$(node) -> sig
 N SIG,SUB,VALUES K VALUES
 S SUB=$P($G(NODE),";",2)
 D RXIN(NODE,.VALUES)
 S SIG=""
 I SUB=5 D
 . S SIG="  Give: "_$G(VALUES("MR"))
 . S SIG=SIG_" "_$P($G(VALUES("SCH",1,0)),U)
 . S SIG=SIG_" "_$P($G(VALUES("SCH",1,0)),U,2)
 I SUB="IV" D
 . S SIG="  Give: "_$G(VALUES("DO"))
 . S SIG=SIG_" "_$$EXT^ORWGAPIX($G(VALUES("START")),55.01,.02)
 . S SIG=SIG_" "_$G(VALUES("SCH",1,0))
 Q SIG
 ;
LAB(ORVALUE,NODE,ITEM) ; from ORWGAPI3
 D LRPXRM^LRPXAPI(.ORVALUE,NODE,ITEM,"VSC")
 Q
 ;
LABNAME(Y) ; $$(item ien) -> item name
 I $P(Y,";")="A",$P(Y,";",2)="S" Q $P(Y,".",2,99)
 Q $$ITEMNM^LRPXAPIU(Y)
 ;
LABSUM(ORDATA,DFN,DATE1,DATE2,ORSUB) ; from ORWGAPID
 D EN^LR7OSUM(.ORDATA,DFN,DATE1,DATE2,,80,.ORSUB)
 Q
 ;
LRDFN(DFN) ; $$(dfn) -> lrdfn
 Q $$LRDFN^LRPXAPIU(DFN)
 ;
LRIDT(LRDT) ;  $$(date) -> inverse date
 Q $$LRIDT^LRPXAPIU(LRDT)
 ;
NVASIG(NODE) ;  $$(node) -> sig on non-va drug
 N RESULTS,SIG K RESULTS
 I '$L(NODE) Q ""
 D RXNVA(NODE,.RESULTS)
 S SIG=RESULTS("DOSAGE")
 S SIG=SIG_" "_RESULTS("MEDICATION ROUTE")
 S SIG=SIG_" "_RESULTS("SCHEDULE")
 Q SIG
 ;
NVAX(DFN) ; $$(dfn) -> 1 if patient has data else 0
 Q $L($O(^PXRMINDX("55NVA","PI",+$G(DFN),"")))>0
 ;
POINAME(IEN) ; $$(poi entry) - > name and dosage form else ""
 N NAME,RESULT K ^TMP($J,"RX")
 I '$G(IEN) Q ""
 D ZERO^PSS50P7(IEN,,,"RX")
 S NAME=$P($G(^TMP($J,"RX",IEN,.01)),U)
 K ^TMP($J,"RX")
 I NAME'=" " Q NAME
 Q ""
 ;
RXIN(NODE,ORVALUE) ; from ORWGAPI3
 D OEL^PSJPXRM1(NODE,.ORVALUE)
 Q
 ;
RXNUM(DFN,RXIEN) ; $$(dfn,prescription ien) -> rx#
 N RXNUM K ^TMP($J,"RX")
 S RXIEN=+$G(RXIEN)
 D RX^PSO52API(DFN,"RX",RXIEN,,0)
 S RXNUM=$G(^TMP($J,"RX",DFN,RXIEN,.01))
 I $L(RXNUM) S RXNUM=" RX#: "_+RXNUM
 K ^TMP($J,"RX")
 Q RXNUM
 ;
RXNVA(NODE,ORVALUE,XSTART,XSTOP) ; from ORWGAPI1, ORWGAPI3, ORWGAPID
 S XSTART=1,XSTOP=1
 D NVA^PSOPXRM1(NODE,.ORVALUE)
 I '$G(ORVALUE("START DATE")) D
 . S ORVALUE("START DATE")=$G(ORVALUE("DOCUMENTED DATE"))
 . S XSTART=0
 I '$G(ORVALUE("DISCONTINUED DATE")) D
 . S XSTOP=0
 Q
 ;
RXOUT(NODE,ORVALUE) ; from ORWGAPI3
 D PSRX^PSOPXRM1(NODE,.ORVALUE)
 Q
 ;
SIG(DFN,RXIEN) ; $$(dfn,prescription ien) -> sig
 N LNUM,SIG K ^TMP($J,"RX")
 S RXIEN=+$G(RXIEN)
 D RX^PSO52API(DFN,"RX",RXIEN,,"M",,)
 S SIG=""
 S LNUM=0
 F  S LNUM=$O(^TMP($J,"RX",DFN,RXIEN,"M",LNUM)) Q:LNUM<1  D
 . S SIG=SIG_$G(^TMP($J,"RX",DFN,RXIEN,"M",LNUM,0))_" "
 I $L(SIG) S SIG="  Sig: "_$$LOW^ORWGAPIX(SIG)
 K ^TMP($J,"RX")
 Q SIG
 ;
SOLDRUG(IEN) ; $$(iv solution) -> drug in 50 else ""
 N RESULT K ^TMP($J,"RX")
 I '$G(IEN) Q ""
 D ZERO^PSS52P7(IEN,,,"RX")
 S RESULT=$P($G(^TMP($J,"RX",IEN,1)),U)
 K ^TMP($J,"RX")
 Q RESULT
 ;
TESTSPEC(DATA) ;  from ORWGAPI
 N CNT,LINE,TEST,TMP,SPEC
 D RETURN^ORWGAPIW(.TMP,.DATA)
 S CNT=0
 S TEST=0
 F  S TEST=$O(^LAB(60,TEST)) Q:TEST<1  D
 . S SPEC=0
 . F  S SPEC=$O(^LAB(60,TEST,1,SPEC)) Q:SPEC<1  D
 .. S CNT=CNT+1
 .. S LINE=TEST_U_$G(^LAB(60,TEST,1,SPEC,0))
 .. I $P(LINE,U,3)[$C(34) S $P(LINE,U,3)=$$TRIM^ORWGAPIX($P(LINE,U,3),"LR",$C(34))
 .. I $P(LINE,U,4)[$C(34) S $P(LINE,U,4)=$$TRIM^ORWGAPIX($P(LINE,U,4),"LR",$C(34))
 .. I TMP S ^TMP(DATA,$J,CNT)=LINE Q
 .. S DATA(CNT)=LINE
 Q
 ;
