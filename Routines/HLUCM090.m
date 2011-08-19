HLUCM090 ;CIOFO-O/LJA - Facility Finder Software ;2/20/2003 - 12:35
 ;;1.6;HEALTH LEVEL SEVEN;**103,114**;Oct 13, 1995
 ;
FACILITY(IEN772) ; Return facility name for REMOTE entries
 ; IMPORTANT!!  Do not call here unless the entry is REMOTE
 ;
 N FACNM
 N FACNM,IEN773,LOCAL,MSH,NO773
 ;
 ; Is FAC a local station number?
 S LOCAL=$P($$SITE^VASITE,U,3)_"~"_$P($$SITE^VASITE,U,2)_"~LOCAL"
 ;
 S IEN772=0,FACNM=""
 F  S IEN772=$O(IEN772(IEN772)) Q:'IEN772!(FACNM]"")  D
 .  S FACNM=$$FACNM(+IEN772)
 ;
 Q $S(FACNM]"":FACNM,1:LOCAL)
 ;
FACNM(IEN772) ; Return FACILITY NAME for one 772 entry...
 N CT,DATA,FACNM,MSH,NO,PROT
 ;
 ; Try to extract from MSH segment in file 773...
 S FACNM=$$MSH773(+IEN772) QUIT:FACNM]"" $$FACDNS(FACNM) ;->
 ;
 ; Try to find MSH in 772...
 S FACNM=$$SEG772(+IEN772) QUIT:FACNM]"" $$FACDNS(FACNM) ;->
 ;
 ; Try to find MSH in 870...
 S FACNM=$$MSH870(+IEN772) QUIT:FACNM]"" $$FACDNS(FACNM) ;->
 ;
 Q ""
 ;
MSH870(IEN772) ; Find facility name from MSH in 870 OUT QUEUE...
 N CT,DATA,IEN772N,LL,MSH,NO,PROT,PROTS
 ;
 ; Look at parent...
 S IEN772N=+$G(^TMP($J,"HLOAD772","X",+IEN772))
 I IEN772N'>0 S IEN772N=+IEN772
 ;
 S PROT=$P($G(^HL(772,+IEN772N,0)),U,10) QUIT:'PROT "" ;->
 S FACNM="",PROTS=0
 F  S PROTS=$O(^ORD(101,+PROT,775,"B",PROTS)) QUIT:'PROTS!(FACNM]"")  D
 .  S LL=$P($G(^ORD(101,+PROTS,770)),U,7) QUIT:'LL  ;->
 .  S MSH="",NO=0,CT=0
 .  F  S NO=$O(^HLCS(870,+LL,2,NO)) Q:MSH]""!('NO)!(CT>10)!(FACNM]"")  D
 .  .  S CT=CT+1
 .  .  S DATA=$G(^HLCS(870,+LL,2,+NO,1,1,0)) QUIT:$E(DATA,1,3)'="MSH"  ;->
 .  .  S MSH=DATA,FACNM=$$MSHXTRCT(MSH,"O")
 Q FACNM
 ;
SEG772(IEN772) ; Try to find SEGment in 772, and extract facility...
 N SEG,WAY
 S WAY=$P($G(^HL(772,+IEN772,0)),U,4) QUIT:WAY']"" "" ;->
 S SEG=$G(^HL(772,+IEN772,"IN",1,0))
 I $E(SEG,1,3)="MSH" QUIT $$MSHXTRCT(SEG,WAY) ;->
 I $E(SEG,1,3)="SPR" QUIT $$SPRXTRCT(IEN772,SEG) ;->
 Q ""
 ;
MSH773(IEN772) ; Try to extract from MSH segment in file 773...
 N FACNM,IEN773,NO773
 S NO773=$$IEN773(IEN772,.IEN773)
 I NO773 S FACNM=$O(IEN773("")) QUIT:FACNM]"" FACNM ;->
 Q ""
 ;
IEN773(IEN772,IEN773) ; Find associated 773 entries...
 N DEL,IEN,MSH,RFN,VAL,WAY
 ;
 KILL IEN773
 S IEN773=0
 ;
 S IEN=0
 F  S IEN=$O(^HLMA("B",+IEN772,IEN)) Q:'IEN  D
 .  S VAL=$G(^HLMA(+IEN,0)) QUIT:VAL']""  ;->
 .  S WAY=$P(VAL,U,3) QUIT:WAY']""  ;->
 .  S MSH=$G(^HLMA(+IEN,"MSH",1,0)) QUIT:MSH']""  ;->
 .  S RFN=$$MSHXTRCT(MSH,WAY) QUIT:RFN']""  ;->
 .  S IEN773(RFN,+IEN)=WAY
 .  S IEN773(RFN)=$G(IEN773(RFN))+1
 .  S IEN773=$G(IEN773)+1
 ;
 Q +IEN773
 ;
MSHXTRCT(MSH,WAY) ; Given I/O WAY and MSH segment, return facility
 N DEL,RFN,X
 S DEL=$E(MSH,4)
 S RFN=$P(MSH,DEL,$S(WAY="I":4,WAY="O":6,1:999)) QUIT:RFN']"" "" ;->
 I RFN?3N!(RFN?3N1U.E) S X=$$FRSTANO(RFN) S:X]"" RFN=X
 Q RFN
 ;
SPRXTRCT(IEN772,SPR) ; Given SPR segment, extract facility
 N CHAR,DIV,I773,MSH
 S I773=$O(^HLMA("B",+IEN772,0))
 S MSH=$G(^HLMA(+I773,"MSH",1,0))
 S DIV=$E(MSH,7)
 S:DIV']"" DIV="\"
 Q $P(SPR,DIV,5)
 ;
FRSTANO(STANO) ;
 N IEN,NM
 S IEN=$O(^DIC(4,"D",STANO,0)) QUIT:IEN'>0 "" ;->
 S NM=$P($G(^DIC(4,+IEN,0)),U)
 QUIT NM
 ;
ACCUMFAC ; Create ^TMP(TOTALS,$J,"RFAC") data...
 N INFO,PARENT,TYPE
 ;
 D ACCUMLAT^HLUCM009("RFAC","LR","R",FAC,DATA("PCKG"),START,DATA("PROT"))
 ;
 S TOTCURR=$G(^TMP(TOTALS,$J,"RFAC"))
 D INCR^HLUCM001
 S ^TMP(TOTALS,$J,"RFAC")=TOTCURR
 ;
 Q
 ;
INST870(IEN772,INST) ;
 N INST870,LINK
 S LINK=$$LINK(IEN772) QUIT:LINK'>0 "" ;->
 S INST870=+$P($G(^HLCS(870,+LINK,0)),U,2)
 QUIT $S(INST870>0&(INST870'=INST):"R",1:"L")
 ;
MAIL870(IEN772) ;
 N LINK,MAIL
 S LINK=$$LINK(IEN772) QUIT:LINK'>0 "" ;->
 S MAIL=$P($G(^HLCS(870,+LINK,0)),U,3)
 QUIT $S(MAIL=1:"R",1:"L")
 ;
LINK(IEN772) ;
 N IEN773,LINK
 S LINK=$P($G(^HL(772,IEN772,0)),U,11)
 I LINK'>0 D
 .  S IEN773=$O(^HLMA("B",IEN772,0)) QUIT:IEN773'>0  ;->
 .  S LINK=$P($G(^HLMA(+IEN773,0)),U,7)
 QUIT LINK
 ;
PRINTDBG ; Print data in ^TMP($J,"HLUCMSTORE")
 N CHAR,CT,IEN772,IEN773,IOINHI,IOINORM,LP,PAUSE,PRINT
 N S1,S2,SKIP,ST,STOP,VAL
 I $G(JOBN)']"" N JOBN S JOBN=$J
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S LP=$NA(^TMP(JOBN,"HLUCMSTORE")),ST=$P(LP,")")_","
 ;
 R !!,"Print T nodes(Y/N): No// ",ANS:999 Q:ANS[U  ;->
 S SKIP=$S(ANS=""!(ANS="N"):"",1:"T")
 ;
 R !!,"Print X nodes(Y/N): No// ",ANS:999 Q:ANS[U  ;->
 S SKIP=SKIP_$S(ANS=""!(ANS="N"):"",1:"X")
 ;
 R !!,"Print U nodes(Y/N): Yes// ",ANS:999 Q:ANS[U  ;->
 S SKIP=SKIP_$S(ANS=""!(ANS="Y"):"U",1:"")
 ;
 S CT=0,PAUSE=1,STOP=0
 F  S LP=$Q(@LP) Q:LP'[ST!(STOP)  D
 .  S X=$E($TR($P(LP,",",3),"""","")_" ") I SKIP'[X QUIT  ;->
 .  S DATA=$P(LP,ST,2,99)_"=",PX=$L(DATA),DATA=IOINHI_DATA_IOINORM_@LP
 .  F  D  Q:DATA']""  Q:STOP
 .  .  S PRINT=$E(DATA,1,77),DATA=$E(DATA,78,999)
 .  .  I DATA]"" S DATA=$$REPEAT^XLFSTR(" ",PX)_DATA
 .  .  W !,PRINT
 .  QUIT:'PAUSE  ;->
 .  S CT=CT+1 QUIT:CT<22  ;->
 .  W " ",IOINHI,"<",IOINORM
 .  R X:999 S:X[U STOP=1 S:X=" " PAUSE=0
 .  S CT=0
 QUIT
 ;
PRINT1 ;
 N DATA,L1,L2,L3,L4,L5,LAST,TOT,TOT1,TOT2,TOT3,TYP
PRINT2 I $G(GBL)']"" N GBL S GBL="^TMP("""_SUB_""","_JOBN_")"
 S (TOT,TOT1,TOT2,TOT3)=0
 I $O(@GBL@(""))']"" D  QUIT  ;->
 .  S X=$$BTE^HLCSMON("No data found.  Press RETURN to continue...  ",1)
 S X=$$BTE^HLCSMON("About to print ^TMP("""_$G(SUB)_""",$J) data report.  Press RETURN...",1)
 W !!," Total   Total   Total  Main"
 W !,"#Chars   #Msgs    #Sec  Sort Sub1 Sub2 Sub3"
 W !,$$REPEAT^XLFSTR("=",IOM)
 S L1=""
 F  S L1=$O(@GBL@(L1)) Q:L1']""  D
 .  S (TOT1,TOT2,TOT3)=0
 .  S L2=""
 .  F  S L2=$O(@GBL@(L1,L2)) Q:L2']""  D
 .  .  S L3=""
 .  .  F  S L3=$O(@GBL@(L1,L2,L3)) Q:L3']""  D
 .  .  .  S L4=""
 .  .  .  F  S L4=$O(@GBL@(L1,L2,L3,L4)) Q:L4']""  D
 .  .  .  .  S TOT=$G(@GBL@(L1,L2,L3,L4))
 .  .  .  .  W !,$J(+TOT,6),?8,$J($P(TOT,U,2),6),?16,$J($P(TOT,U,3),6)
 .  .  .  .  W ?24,L1,?29,L2,?34,L3,?39,$S($L(L4)<42:L4,1:$E(L4,1,40)_"~")
 .  .  .  .  I L1="NMSP",L2'="IO" QUIT  ;->
 .  .  .  .  S TOT1=TOT1+$P(TOT,U),TOT2=TOT2+$P(TOT,U,2),TOT3=TOT3+$P(TOT,U,3)
 .  .  .  I L1="NMSP" S X=$O(@GBL@(L1,L2,L3)) I X]"",L3'=X W:WAY=1 !
 .  .  I L1="NMSP" S X=$O(@GBL@(L1,L2)) I X]"",L2'=X W:WAY=1 !
 .  I WAY=1 W !,$$REPEAT^XLFSTR("-",IOM),!,$J(TOT1,6),?8,$J(TOT2,6),?16,$J(TOT3,6),!
 Q
 ;
FACDNS(FAC) ; Return STA#~STA-NAME~DNS if remote...
 N FACNM,LOCAL
 ;
 ; Is FAC a local station number?
 S LOCAL=$P($$SITE^VASITE,U,3)_"~"_$P($$SITE^VASITE,U,2)_"~LOCAL"
 I +FAC=+LOCAL QUIT LOCAL ;->
 ;
 ; FAC not a station number, or not local...
 S FACNM=$$FACFROM(FAC)
 ;
 I +FACNM'>0 QUIT LOCAL ;-> No site number found...
 I +FACNM=+LOCAL QUIT LOCAL ;-> Local site number...
 ;
 QUIT:FACNM]"" FACNM ;->
 ;
 Q LOCAL
 ;
FACFROM(FAC) ; Find STA#~STA-NAME~DNS if remote...
 N D,DIC,FACNM,STANO,X,Y
 ;
 QUIT:$G(FAC)']"" "" ;-> If no station number...
 ;
 ; Initial build of facility conversions...
 D:'$D(^TMP($J,"HL4")) BLDHL4
 ;
 ; If facility is in facility conversion in ^TMP($J,"HL4")...
 S FACNM=$G(^TMP($J,"HL4",FAC)) QUIT:FACNM]"" FACNM ;->
 ;
 ; Try to look up.  (See Integration Agreement# 10090)
 ;
 ; Pure station number lookup if leading 3 station number digits...
 ; Otherwise, use the FACility name...
 S DIC="^DIC(4,",DIC(0)="FMO",D="B^D",X=$S(+FAC?3N:+FAC,1:FAC)
 D MIX^DIC1
 ;
 D FACVAR
 ;
 ; Success...
 I FACNM]"" D  QUIT FACNM ;->
 .  S FACNM=STANO_"~"_FACNM_"~DNS"
 .  S ^TMP($J,"HL4",FAC)=FACNM
 ;
 ; Failed lookup...
 I FACNM']"",+FAC'?3N QUIT "" ;-> Lookup on alpha facility name
 I FACNM']"",+FAC=FAC QUIT "" ;-> Lookup on pure 3 digit station #
 ;
 ; Failed on lookup on ###, so try ###A...
 KILL D,DIC,X,Y
 S DIC="^DIC(4,",DIC(0)="FMO",D="B^D",X=FAC
 ;
 D FACVAR
 ;
 ; Success...
 I FACNM]"" D  QUIT FACNM ;->
 .  S FACNM=STANO_"~"_FACNM_"~DNS"
 .  S ^TMP($J,"HL4",FAC)=FACNM
 ;
 Q ""
 ;
FACVAR ; Set up variables...
 N DIC,X
 S FACNO=+$G(Y),FACNM=$P($G(Y),U,2),STANO="" ; HL*1.6*114
 QUIT:FACNO'>0  ;->
 S DIC=4,DR="99",DA=+FACNO,DIQ="DATA(",DIQ(0)="E"
 D EN^DIQ1
 S STANO=$G(DATA(4,+FACNO,99,"E"))
 Q
 ;
BLDHL4 ; Build facility conversions...
 N I,T F I=2:1 S T=$T(BLDHL4+I) Q:T'[";;"  S T=$P(T,";;",2,99),^TMP($J,"HL4",$P(T,U))=$P(T,U,2)
 ;;200M^200M~MPI~DNS
 ;;AUSTIN^200~AUSTIN~DNS
 Q
 ;
EOR ;HLUCM090 - Facility Finder Software ;2/20/2003 - 12:35
