TIUMOBJ ;XAN/AJB - MEDICATION OBJECT ;Aug 29, 2025@06:54:59
 ;;1.0;TEXT INTEGRATION UTILITIES;**365,372**;Jun 20, 1997;Build 5
 ;
 ; Reference to ^DIM in ICR #10016
 ; Reference to ^DPT( in ICR #10035
 ; Reference to PEN^PSO5241 in ICR #4821
 ; Reference to RX^PSO52API in ICR #4820
 ; Reference to OCL^PSOORRL in ICR #2400
 ; Reference to DRGIEN^PSS50P7 in ICR #4662
 ; Reference to *^PSS55 in ICR #4826
 ; Reference to *^XLFDT in ICR #10103
 ; Reference to *^XLFSTR in ICR #10104
 ;
 ; Required Parameter
 ; DFN                 Patient IEN
 ;
 ; Optional Parameters
 ; TARGET              Return Location of data [default "OUTPUT"]
 ;                     Global TARGET must be ^TMP with at least one subscript
 ; A  (active)         0 Active and recently expired meds [default]
 ;                     1 Active meds only
 ;                     2 Recently expired meds only
 ; D  (detailed)       0 Standard med info [default]
 ;                     1 Detailed med info
 ; M  (meds)           0 Inpatient or Outpatient meds only, based on patient status [default]
 ;                     1 Inpatient, outpatient & clinic meds
 ;                     2/"I" Inpatient meds only
 ;                     3/"O" Outpatient meds only
 ;                     4/"C" Clinic meds only
 ;                     5/"CI" Clinic and inpatient meds only
 ;                     6/"CO" Clinic and outpatient meds only
 ;                     7/"NVA" Non-VA only
 ; O  (onelist)        0 Separate based on type [default]
 ;                     1 Combines meds into one list per type
 ; SC (sort by class)  0 Sort meds alphabetically [default]
 ;                     1 Sort by class, alphabetically
 ;                     2 Sort by class with class in header
 ; SU (supplies)       0 Exclude supplies
 ;                     1 Include supplies [default]
 ; MR (med rec)        0 Exclude TIUDATE for OCL^PSOORRL call - pass 0 for temporary workaround so older meds will be included
 ;                     1 Include TIUDATE (if set) [default] (PSI noted for excluding old but active Non-VA meds when date is included)
 ; Global Variable
 ; TIUDATE             # of days to search from today [Med Reconciliation TIU*1.0*238 & PSO*7.0*294] - independent start/end dates for INP/OUT meds
 ;                     OCL^PSOQ0496 for med rec was not updated to include IND text - deprecated by pharm. and no longer used
 ;                     Met with PBM 05/07/2025 - awaiting decision on their fix - if addressed in PSOQ0496, will need to add that back
 ;                                               if addressed in PSOORRL, MR parameter may be removed/set to 1 via TIU MED LM (in *372)
 Q
LIST(DFN,TARGET,A,D,M,O,SC,SU,MR) ;
 ; validate target, default to OUTPUT if needed
 N IB,IE,OB,OE,P,VIEW,X S DFN=+$G(DFN),TARGET=$G(TARGET,"OUTPUT"),TARGET=$S(TARGET[""""""!(TARGET[U&(TARGET'["^TMP(")):"OUTPUT",1:TARGET)
 ; DIM checks syntax, ensures valid TARGET
 S X="S TEST="_TARGET D ^DIM S TARGET=$S('$D(X):"OUTPUT",1:TARGET)
 ; validate patient
 I 'DFN!(DFN&('$D(^DPT(DFN)))) D ADD(.TARGET,$S('DFN:"No Patient ID",1:"Patient DFN invalid")) Q "~@"_$NA(@TARGET)
 K @TARGET,^TMP("PS",$J)
 ; verify/set routine parameters in P(parameter)
 F X="A","D","M","O","SC","SU","MR" D
 . S:X="A" A=$S(+$G(A)'<0&(+$G(A)<3):+$G(A),1:0)
 . S:X="D" D=$S(+$G(D)'<0&(+$G(D)<2):+$G(D),1:0)
 . S:X="M" M=$$UP($G(M)),M=$S(M="I":2,M="O":3,M="C":4,M="CI"!(M="IC"):5,M="CO"!(M="OC"):6,M="NVA":7,+$G(M)'<0&(+$G(M)<8):+$G(M),1:0)
 . S:X="O" O=$S(+$G(O)'<0&(+$G(O)<2):+$G(O),1:0)
 . S:X="SC" SC=$S(+$G(SC)'<0&(+$G(SC)<3):+$G(SC),1:0)
 . S:X="SU" SU=$S($G(SU)="":1,+$G(SU)=0:0,1:1)
 . S:X="MR" MR=$S($G(MR)="":1,+$G(MR)=0:0,1:1)
 . S P(X)=@(X) K @(X) K:X="MR" X
 ; TIUDATE setup - supports separate OUT & INP starting/ending date values
 S TIUDATE=$G(TIUDATE) F X="IB","IE","OB","OE" S (@(X),P(X))="" K:X="OE" X
 S:P("MR")&($P(TIUDATE,U)) (OB,P("OB"))=$$FMADD^XLFDT(DT,-TIUDATE)
 S:$P(TIUDATE,U,2) (OE,P("OE"))=$$FMADD^XLFDT(DT,-$P(TIUDATE,U,2))
 S:P("MR")&($P(TIUDATE,U,3)) (IB,P("IB"))=$$FMADD^XLFDT(DT,-$P(TIUDATE,U,3))
 S:$P(TIUDATE,U,4) (IE,P("IE"))=$$FMADD^XLFDT(DT,-$P(TIUDATE,U,4))
 S:OB&('OE) (OE,P("OE"))=DT S:IB&('IE) (IE,P("IE"))=DT
 ; additional parameters/data
 S P("AS")="^ACTIVE^REFILL^HOLD^PROVIDER HOLD^ON CALL^ACTIVE (S)^ACTIVE/PARKED^"
 S P("PS")="^NON-VERIFIED^DRUG INTERACTIONS^INCOMPLETE^PENDING^"
 ; sort order of inpatient/outpatient determined by patient status
 S P("INP")=($G(^DPT(DFN,.1))'=""),P("SORT","I")=$S(P("INP"):2,1:3),P("SORT","O")=$S(P("INP"):3,1:2)
 ; flag for any drug with unknown class, evaluated in TITLE output
 S P("UNK")=0
 ; variables that exist after OCL^PSOORRL
 N %H,BDT1,D0,DILOCKTM,DNORIG,DIQ2,DISYS,DRG,GP,IEN,LOC,LSTDS,LSTFD,LSTRD,ND2P5,ND8
 N POP,PSGDT,PSJOI,PSJOINM,PSJST,PSJST2,PSJSTP,PSSTMP2,RNWDT,SG,X3,X4
 ; dfn, out begin dt, out end dt, view, inp begin dt, inp end dt
 S VIEW=0 D OCL^PSOORRL(DFN,OB,OE,VIEW,IB,IE) G EX:'$D(^TMP("PS",$J))
 N INDEX,MEDS,OCL M OCL=^TMP("PS",$J) K ^TMP("PS",$J)
 S INDEX=0 F  S INDEX=$O(OCL(INDEX)) Q:'INDEX  D
 . N MED S MED("NAME")=$TR($P(OCL(INDEX,0),U,2),"""","") Q:MED("NAME")=""
 . ; TIU*238 & PSO*7.0*294 (Med Reconciliation)
 . Q:$P(OCL(INDEX,0),U,9)["DISCONTINUED"&(OB!(IB))
 . S:$P(OCL(INDEX,0),U,9)="ACTIVE/SUSP" $P(OCL(INDEX,0),U,9)="ACTIVE (S)"
 . S MED("STATUS")=$P(OCL(INDEX,0),U,9)
 . S MED("ORDER #")=+OCL(INDEX,0)
 . S MED("CLINIC")=($G(OCL(INDEX,"CLINIC",0))>0)
 . S MED("FILE")=$TR($P(OCL(INDEX,0),U),MED("ORDER #"),"")
 . S MED("TYPE")=$P(MED("FILE"),";",2) Q:MED("TYPE")=""
 . ; sort order:  clinic=1, in/outpatient (based on patient status)=2/3, 4=Non-VA Meds
 . S MED("SORT")=$S(MED("CLINIC"):1,MED("FILE")="N;O":4,MED("TYPE")="I":P("SORT","I"),MED("TYPE")="O":P("SORT","O"))
 . ; sort=type_status
 . S MED("SORT")=MED("SORT")_$S(P("O")!(P("AS")[MED("STATUS")):1,P("PS")[MED("STATUS"):2,1:3)
 . ; add prefix if needed
 . S:MED("FILE")="N;O" $P(OCL(INDEX,0),U,2)="Non-VA "_$P(OCL(INDEX,0),U,2)
 . ;    all       active/pending                                              inactive
 . Q:$S('P("A"):0,P("A")=1&(P("AS")'[MED("STATUS")&(P("PS")'[MED("STATUS"))):1,P("A")=2&(P("AS")[MED("STATUS")!(P("PS")[MED("STATUS"))):1,1:0)
 . ; in/outpatient                                                 all        inpatient                                          outpatient
 . Q:$S(P("M")=0:$S(MED("CLINIC"):1,P("SORT",MED("TYPE"))=2:0,1:1),P("M")=1:0,P("M")=2:$S(MED("CLINIC"):1,MED("TYPE")="I":0,1:1),P("M")=3:$S(MED("CLINIC"):1,MED("TYPE")="O":0,1:1),1:0)
 . ; non-VA meds (only)                 clinic meds                            & inpatient                        & outpatient
 . Q:$S(P("M")=7&(MED("FILE")'="N;O"):1,P("M")'<4&(P("M")'>6):$S(MED("CLINIC"):0,P("M")=5:$S(MED("TYPE")="I":0,1:1),P("M")=6:$S(MED("TYPE")="O":0,1:1),1:1),1:0)
 . ; get med class, needed for sorting by class or to exclude supplies
 . I P("SC")!('P("SU")) D CLASS(.MED,DFN)
 . ; drug class unknown, set flag
 . I P("SC"),'P("UNK"),MED("CLASS")="" S P("UNK")=1
 . ; exclude supplies
 . I 'P("SU"),MED("CLASS")["XA",MED("DEA")["S" Q
 . M OCL(INDEX)=MED
 . ; use xstr to eliminiate inactive duplicates
 . N XSTR S XSTR=$TR($$ADDMED(.TARGET,.OCL,.P,"","",INDEX,1),"""","") I $L(XSTR)>99 S XSTR=$E(XSTR,1,30)_"_"_$L(XSTR)
 . D  ; check if inactive duplicate
 . . Q:P("AS")[MED("STATUS")!(P("PS")[MED("STATUS"))
 . . ; set subscripts=MEDS(type_status,class,xstr)
 . . N SUBS S SUBS="MEDS("_MED("SORT")_","""_$S(P("SC")&($G(MED("CLASS"))'=""):MED("CLASS"),1:" ")_""","""_XSTR_""")"
 . . I $O(@SUBS@(0)) D  Q:$O(@SUBS@(0))
 . . . N IEN S IEN=$O(@SUBS@(0)) Q:'IEN
 . . . ; compare issue/start date, keep newer
 . . . I $P(OCL(INDEX,0),U,15)'<@SUBS@(IEN) K @SUBS@(IEN)
 . ; MEDS(type_status,class,xstr,index)=issue/start date
 . S MEDS(MED("SORT"),$S(P("SC")&($G(MED("CLASS"))'=""):MED("CLASS"),1:" "),XSTR,INDEX)=$P(OCL(INDEX,0),U,15)
EX D TITLE^TIUMOBJ1(.TARGET,.P,$D(MEDS))
 I '$D(MEDS) D ADD(.TARGET,"No Medications Found"),ADD(.TARGET," ")
 I $D(MEDS) D OUTPUT(.TARGET,.MEDS,.OCL,.P)
 K TIUDATE ; Med Reconciliation
 Q "~@"_$NA(@TARGET)
CLASS(MED,DFN) ;
 N DATA S DATA=$$MEDCLASS(MED("NAME")) I +DATA S MED("CLASS")=$P(DATA,U,2),MED("DEA")=$P(DATA,U,3) Q
 S (MED("CLASS"),MED("DEA"),MED("IEN"),MED("ORIDX"))=""
 ; prescription file #52
 I MED("FILE")="R;O" D
 . D RX^PSO52API(DFN,"TIUMEDOBJ",MED("ORDER #"),"","0,O")
 . S MED("IEN")=+$G(^TMP($J,"TIUMEDOBJ",DFN,MED("ORDER #"),6))
 . S MED("ORIDX")=+$G(^TMP($J,"TIUMEDOBJ",DFN,MED("ORDER #"),"OI"))
 ; pending outpatient order file #52.41
 I MED("FILE")="P;O" D
 . D PEN^PSO5241(DFN,"TIUMEDOBJ",MED("ORDER #"))
 . S MED("IEN")=+$G(^TMP($J,"TIUMEDOBJ",DFN,MED("ORDER #"),11))
 . S MED("ORIDX")=+$G(^TMP($J,"TIUMEDOBJ",DFN,MED("ORDER #"),8))
 ; pending inpatient order file #53.1
 I MED("FILE")="P;I" D
 . S MED("ORIDX")=$P($G(^PS(53.1,MED("ORDER #"),.2)),U)
 . Q:$P($G(^PS(53.1,MED("ORDER #"),1,0)),U,4)'=1
 . N IEN S IEN=$O(^PS(53.1,MED("ORDER #"),1,0)) Q:'IEN
 . S MED("IEN")=$P($G(^PS(53.1,MED("ORDER #"),1,IEN,0)),U)
 ; unit dose order file #55, subfile #55.06
 I MED("FILE")="U;I" D
 . D PSS431^PSS55(DFN,MED("ORDER #"),"","","TIUMEDOBJ")
 . Q:+$G(^TMP($J,"TIUMEDOBJ",MED("ORDER #"),"DDRUG",0))'=1
 . N IEN S IEN=$O(^TMP($J,"TIUMEDOBJ",MED("ORDER #"),"DDRUG",0)) Q:'IEN
 . S MED("IEN")=$G(^TMP($J,"TIUMEDOBJ",MED("ORDER #"),"DDRUG",IEN,.01))
 . S MED("IEN")=+MED("IEN"),MED("ORIDX")=+$G(^TMP($J,"TIUMEDOBJ",MED("ORDER #"),108))
 ; IV order file #55, subfile #55.01
 I MED("FILE")="V;I" D
 . N X3 D PSS436^PSS55(DFN,MED("ORDER #"),"TIUMEDOBJ")
 . S MED("ORIDX")=+$G(^TMP($J,"TIUMEDOBJ",MED("ORDER #"),130))
 . Q:^TMP($J,"TIUMEDOBJ",MED("ORDER #"),"ADD",0)'=1
 . N IEN S IEN=$O(^TMP($J,"TIUMEDOBJ",MED("ORDER #"),"ADD",0)) Q:'IEN
 . S IEN=+$G(^TMP($J,"TIUMEDOBJ",MED("ORDER #"),"ADD",IEN,.01)) Q:'IEN
 . K ^TMP($J,"DRGIEN_TIUMEDOBJ") D ZERO^PSS52P6(IEN,"","","DRGIEN_TIUMEDOBJ")
 . S MED("IEN")=+$G(^TMP($J,"DRGIEN_TIUMEDOBJ",IEN,1))
 . K ^TMP($J,"DRGIEN_TIUMEDOBJ")
 S DATA=$$MEDCLASS(,MED("IEN")) I +DATA S MED("CLASS")=$P(DATA,U,2),MED("DEA")=$P(DATA,U,3) Q
 ; order # or no orderable item #
 Q:MED("IEN")!('MED("ORIDX"))
 ; orderable item(s), file #50.7
 K ^TMP($J,"DRGIEN_TIUMEDOBJ") D DRGIEN^PSS50P7(MED("ORIDX"),"","DRGIEN_TIUMEDOBJ")
 N IEN S IEN=0 F  S IEN=$O(^TMP($J,"DRGIEN_TIUMEDOBJ",IEN)) Q:'IEN  D  Q:+DATA
 . S DATA=$$MEDCLASS(,IEN) I +DATA S MED("CLASS")=$P(DATA,U,2),MED("DEA")=$P(DATA,U,3)
 K ^TMP($J,"DRGIEN_TIUMEDOBJ")
 Q
MEDCLASS(NAME,IEN) ;
 N CLASS,DEA K ^TMP($J,"TIUMEDOBJ") S IEN=$G(IEN),NAME=$G(NAME)
 ; drug file #50
 D ZERO^PSS50(IEN,NAME,"","","","TIUMEDOBJ")
 S IEN=+$O(^TMP($J,"TIUMEDOBJ",0)),CLASS=$G(^TMP($J,"TIUMEDOBJ",IEN,2)),DEA=$G(^TMP($J,"TIUMEDOBJ",IEN,3))
 K ^TMP($J,"TIUMEDOBJ")
 Q IEN_U_CLASS_U_DEA
OUTPUT(TARGET,MEDS,OCL,P) ;
 N CLASS,COL,CNT,SORT,UL,XSTR S (SORT,UL)="",$P(UL,"=",80)="="
 ; set column start/widths for standard and detailed output
 I 'P("D") D
 . S COL(1,"W")=60,COL(0)=1,COL(1)=6,COL(2)=68
 . I P("O"),'P("M"),'P("SC") S CNT="",COL(1)=1,COL(1,"W")=58 ; onelist
 I P("D") D
 . S COL(1,"W")=44,COL(2,"W")=12
 . S COL(0)=1,COL(1)=6,COL(2)=53,COL(3)=66
 ; start formatting output
 F  S SORT=$O(MEDS(SORT)) Q:'SORT  D
 . N LN,STATUS S STATUS=$E(SORT,2),STATUS=$S(STATUS=1:"Active ",STATUS=2:"Pending ",STATUS=3:"Inactive ")
 . N TYPE S TYPE=$E(SORT),TYPE=$S(TYPE=1:"Clinic",TYPE=4:"Non-VA",1:$S(P("INP"):$S(TYPE=2:"Inpatient",TYPE=3:"Outpatient"),1:$S(TYPE=3:"Inpatient",TYPE=2:"Outpatient")))
 . S CNT("CLASS")=0
 . ; set header by class
 . I 'P("D") D
 . . Q:P("O")&('P("M"))&('P("SC"))  ; onelist
 . . S LN=$S('P("O"):STATUS,1:"")_TYPE_" Medications"_$S(P("M")=4:" and Infusions",1:"")_$S(P("SC"):" (By Drug Class)",1:"")
 . . S LN=$$SETSTR("Status",$$SETSTR(LN,"",COL(1),$L(LN)),COL(2),6)
 . I P("D") D
 . . I TYPE="Outpatient" D ADD(.TARGET,$$SETSTR("Issue Date","",COL(3),10)),ADD(.TARGET,$$SETSTR("Status",$$SETSTR("Last Fill","",COL(3),9),COL(2),6))
 . . E  D ADD(.TARGET,$$SETSTR("Start Date","",COL(3),10))
 . . S LN=$S('P("O"):STATUS,1:"")_TYPE_" Medications"_$S(P("M")=4:" and Infusions",1:"")_$S(P("SC"):" (By Class)",1:""),LN=$$SETSTR(LN,"",COL(1),$L(LN))
 . . I TYPE="Outpatient" S LN=$$SETSTR("Expiration",$$SETSTR("Refills",LN,COL(2),7),COL(3),10)
 . . E  S LN=$$SETSTR("Stop Date",$$SETSTR("Status",LN,COL(2),6),COL(3),9)
 . ; add class header/underline
 . D:$G(LN)'="" ADD(.TARGET,LN),ADD(.TARGET,$$SETSTR(UL,"",2,78))
 . ; begin meds by class
 . S CLASS="" F  S CLASS=$O(MEDS(SORT,CLASS)) Q:CLASS=""  D
 . . ; sorting by class
 . . I P("SC") D
 . . . I CLASS=" "!(P("SC")=2) N X S X=" Drug Class: "_$S(CLASS=" ":"Unknown ",P("SC")=2:CLASS_" ") D ADD(.TARGET,$$SETSTR(X,$$SETSTR(UL,"",6,$S(P("D"):46,1:61)),16,$L(X)))
 . . ; begin meds by xstr
 . . S XSTR="" F  S XSTR=$O(MEDS(SORT,CLASS,XSTR)) Q:XSTR=""  D
 . . . ; begin meds by index
 . . . N INDEX S INDEX=0 F  S INDEX=$O(MEDS(SORT,CLASS,XSTR,INDEX)) Q:'INDEX  D
 . . . . S CNT("CLASS")=CNT("CLASS")+1,CNT(SORT,CLASS)=$G(CNT(SORT,CLASS))+1,CNT("TOTAL")=$G(CNT("TOTAL"))+1
 . . . . ; add the med to output
 . . . . D ADDMED(.TARGET,.OCL,.P,.COL,$S(P("SC"):CNT("CLASS"),1:CNT(SORT,CLASS)),INDEX,0)
 . . I P("SC") D:$O(MEDS(SORT,CLASS))'="" ADD(.TARGET," ")
 . . I P("SC")=1,$O(MEDS(SORT,CLASS))'="" D ADD(.TARGET,$$SETSTR(UL,"",4,$S(P("D"):43,1:61)))
 . D:$O(MEDS(SORT))'="" ADD(.TARGET," ")
 I CNT("TOTAL")'=CNT("CLASS") D ADD(.TARGET," "),ADD(.TARGET,CNT("TOTAL")_" Total Medications")
 D ADD(.TARGET," ")
 Q
ADDMED(TARGET,OCL,P,COL,CNT,INDEX,XSTR) ;
 N DATA,IND,REP,TEMP,TIUFT,TYPE,X,Y S DATA=$$TRIM^XLFSTR($P(OCL(INDEX,0),U,2))
 S REP("^^")=" ",TYPE=$S(OCL(INDEX,"TYPE")="O":"OP",+$O(OCL(INDEX,"A",0))!(+$O(OCL(INDEX,"B",0))):"IV",1:"UD")
 ; set desired data nodes for output
 I TYPE="IV" D
 . I 'XSTR,P("D") D
 . . S DATA(1)=DATA,DATA(2)=$$TRIM^XLFSTR($TR($$REPLACE^XLFSTR($$NODE(.OCL,INDEX,"A")_U_$S($O(OCL(INDEX,"B",0)):"in",1:"")_U_$$NODE(.OCL,INDEX,"B")_U_$P(OCL(INDEX,0),U,3),.REP),U," "))
 . . S DATA(3)=$TR($$REPLACE^XLFSTR($$NODE(.OCL,INDEX,"SIO;MDR;SCH"),.REP),U," ")
 . S DATA=$TR($$REPLACE^XLFSTR(DATA_U_$$NODE(.OCL,INDEX,"A")_U_$S($O(OCL(INDEX,"B",0)):"in",1:"")_U_$$NODE(.OCL,INDEX,"B")_U_$P(OCL(INDEX,0),U,3)_U_$$NODE(.OCL,INDEX,"SIO;MDR;SCH"),.REP),U," ")
 I TYPE="UD" D
 . I 'XSTR,P("D") D
 . . S DATA(1)=DATA,DATA(2)=$S($P(OCL(INDEX,0),U,6)'="":"Give: "_$P(OCL(INDEX,0),U,6),$P(OCL(INDEX,0),U,7)'="":"Give: "_$P(OCL(INDEX,0),U,7),1:$$NODE(.OCL,INDEX,"SIG"))
 . . S DATA(2)=$TR($$REPLACE^XLFSTR($$TRIM^XLFSTR(DATA(2))_U_$$NODE(.OCL,INDEX,"MDR;SCH"),.REP),U," ")
 . . S DATA(3)=$TR($$REPLACE^XLFSTR($$NODE(.OCL,INDEX,"SIO"),.REP),U," ")
 . S DATA=DATA_U_$S($P(OCL(INDEX,0),U,6)'="":$P(OCL(INDEX,0),U,6),$P(OCL(INDEX,0),U,7)'="":$P(OCL(INDEX,0),U,7),1:$$NODE(.OCL,INDEX,"SIG"))
 . S DATA=$TR($$REPLACE^XLFSTR(DATA_U_$$NODE(.OCL,INDEX,"MDR;SCH")_U_$$NODE(.OCL,INDEX,"SIO"),.REP),U," ")
 I TYPE="OP" D
 . I P("D") S:$P(OCL(INDEX,0),U,12)'="" DATA=DATA_" Qty: "_$P(OCL(INDEX,0),U,12) S:$P(OCL(INDEX,0),U,11)'="" DATA=DATA_" for "_$P(OCL(INDEX,0),U,11)_" days"
 . N TEMP S TEMP=$$NODE(.OCL,INDEX,"SIG") S:TEMP'="" DATA=DATA_U_$S(P("D"):"Sig: ",1:"")_TEMP S:TEMP="" DATA=DATA_U_$$NODE(.OCL,INDEX,"SIO;MDR;SCH") S DATA=$TR($$REPLACE^XLFSTR(DATA,.REP),U," ")
 ; return xstr
 S DATA=$$TRIM^XLFSTR(DATA) Q:XSTR DATA
 S IND=$G(OCL(INDEX,"IND",0))
 ; wrap data for detailed output, put in TIUFT
 I 'XSTR,P("D") S (X,Y)=0 F  S X=$O(DATA(X)) Q:'X  D WRAP^TIUFLD(DATA(X),COL(1,"W")) D  I '$O(DATA(X)) K TIUFT M TIUFT=TEMP
 . S Y=$O(TEMP(""),-1) N X S X=0 F  S X=$O(TIUFT(X)) Q:'X  S TEMP(X+Y)=TIUFT(X) K TIUFT(X)
 ; wrap data for standard output
 N SORT S SORT=$E(OCL(INDEX,"SORT")) D:'$D(TIUFT) WRAP^TIUFLD(DATA,COL(1,"W"))
 ; detailed ouput requires minimum of 2 or 3 (outpatient) lines, set null if needed
 I P("D") F TIUFT=1:1:$S(SORT=P("SORT","O"):3,1:2) I $G(TIUFT(TIUFT))="" S TIUFT(TIUFT)=""
 ; begin wrap data output
 S (IND(0),X)=0 F  S X=$O(TIUFT(X)) Q:'X  D
 . S:X>1 CNT=""
 . ; for 2nd or 3rd line, detailed output, null, add indication & set flag
 . I X=2!(X=3),'IND(0),IND'="",P("D"),TIUFT(X)="" S IND(0)=1,TEMP="Indication: "_IND D
 . . K TIUFT D WRAP^TIUFLD(TEMP,COL(1,"W")) S Y=0 F  S Y=$O(TIUFT(Y)) Q:'Y  S TEMP(X+(Y-1))=TIUFT(Y) K TIUFT(Y)
 . . S Y=0 F  S Y=$O(TEMP(Y)) Q:'Y  S TIUFT(Y)=$$SETSTR(TEMP(Y),"",$S(Y=X:1,1:3),$L(TEMP(Y)))
 . ; add number/count for med if needed
 . S DATA=$$SETSTR($S(CNT:CNT_")",1:""),"",COL(0),$L($S(CNT:CNT_")",1:"")))
 . ; add med to data
 . S DATA=$$SETSTR(TIUFT(X),DATA,$S(X=1!(IND(0)):COL(1),1:COL(1)+2),$L(TIUFT(X)))
 . ; add status, wrap if needed
 . I X=1 N Y S Y=$P(OCL(INDEX,0),U,9) S:$L(Y)<13 DATA=$$SETSTR(Y,DATA,COL(2),$L(Y)) D:$L(Y)>12
 . . S DATA=$$SETSTR($P(Y," "),DATA,COL(2),$L($P(Y," ")))
 . . S TIUFT(2)=$$SETSTR($P(Y," ",2),$S($G(TIUFT(2))="":"",1:TIUFT(2)),COL(2)-7,$L($P(Y," ",2)))
 . ; detailed output
 . I P("D") D
 . . I X=1,$P(OCL(INDEX,0),U,15)  N X S X=$S(SORT=P("SORT","O"):"Issue: ",1:"Start: ")_$$FMTE^XLFDT($P($P(OCL(INDEX,0),U,15),"."),"2Z"),DATA=$$SETSTR(X,DATA,COL(3),$L(X))
 . . I X=2,SORT=P("SORT","O") N X S X="Refills: "_+$P(OCL(INDEX,0),U,5) S DATA=$$SETSTR(X,DATA,COL(2),$L(X)) D
 . . . I $P(OCL(INDEX,0),U,10) S X="Last : "_$$FMTE^XLFDT($P($P(OCL(INDEX,0),U,10),"."),"2Z") S DATA=$$SETSTR(X,DATA,COL(3),$L(X))
 . . ; standard output
 . . I X=2,SORT'=P("SORT","O"),$P(OCL(INDEX,0),U,4) N X S X="Stop : "_$$FMTE^XLFDT($P($P(OCL(INDEX,0),U,4),"."),"2Z"),DATA=$$SETSTR(X,DATA,COL(3),$L(X))
 . . I X=3,SORT=P("SORT","O"),$P(OCL(INDEX,0),U,4) N X S X="Expr : "_$$FMTE^XLFDT($P($P(OCL(INDEX,0),U,4),"."),"2Z"),DATA=$$SETSTR(X,DATA,COL(3),$L(X))
 . ; add data to output
 . D:DATA'="" ADD(.TARGET,$$TRIM^XLFSTR(DATA,"R"))
 ; add indication if needed
 I 'IND(0),IND'="" S TEMP="Indication: "_IND K TIUFT D WRAP^TIUFLD(TEMP,COL(1,"W")) D
 . S X=0 F  S X=$O(TIUFT(X)) Q:'X  D ADD(.TARGET,$$SETSTR(TIUFT(X),"",$S(X=1:COL(1),1:COL(1)+2),$L(TIUFT(X))))
 Q
ADD(TARGET,DATA) ;
 S @TARGET@(($O(@TARGET@(""),-1)+1),0)=DATA
 Q
NODE(OCL,IDX,NODES) ;
 N DATA,NODE,X,Y S DATA="" F X=1:1:$L(NODES,";") S NODE=$P(NODES,";",X),Y=0 F  S Y=$O(OCL(IDX,NODE,Y)) Q:'Y  S DATA=DATA_$S(DATA="":"",1:U)_$$TRIM^XLFSTR(OCL(IDX,NODE,Y,0))
 Q DATA
SETSTR(S,V,X,L) ;
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
