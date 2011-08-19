ORCDPS ;SLC/MKB-Pharmacy dialog utilities ;02:36 PM  2 Apr 2001
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,38,62,86,94,129**;Dec 17, 1997
 ;
 ; ** Keep for backwards compatibility, just in case:
 ;
CHANGED(TYPE) ; -- Kill dependent values when OI changes
 N PROMPTS,NAME,PTR,P,I
 Q:'$L($G(TYPE))  S PROMPTS=""
 I TYPE="U" S PROMPTS="DISPENSE DRUG^INSTRUCTIONS^ROUTE" K ORSCHED,ORQTY
 I TYPE="O" S PROMPTS="DISPENSE DRUG^INSTRUCTIONS^FREE TEXT^ROUTE^SCHEDULE^DURATION" K ORSCHED,ORQTY
 S:TYPE="IVB" PROMPTS="VOLUME"
 S:TYPE="IVA" PROMPTS="STRENGTH PSIV^UNITS"
 I TYPE="ALL" S PROMPTS="ORDERABLE ITEM^DISPENSE DRUG^INSTRUCTIONS^FREE TEXT^ROUTE^SCHEDULE^DURATION^URGENCY^QUANTITY^REFILLS^ROUTING^SERVICE CONNECTED^VOLUME^STRENGTH PSIV^UNITS^ADDITIVE^INFUSION RATE^WORD PROCESSING 1" K ORSCHED,ORQTY
 S:TYPE="XFR" PROMPTS="DISPENSE DRUG^INSTRUCTIONS^FREE TEXT^DURATION^QUANTITY^REFILLS^ROUTING^START DATE^SERVICE CONNECTED"
 F P=1:1:$L(PROMPTS,U) S NAME=$P(PROMPTS,U,P) D
 . S PTR=$O(^ORD(101.41,"AB","OR GTX "_NAME,0)) Q:'PTR
 . S I=0 F  S I=$O(ORDIALOG(PTR,I)) Q:I'>0  K ORDIALOG(PTR,I)
 . K ORDIALOG(PTR,"LIST")
 Q
 ;
ASKSC() ; -- Return 1 or 0, if SC prompt should be asked
 I $L($T(SC^PSOCP)),$$SC^PSOCP(+ORVP,+$G(ORDRUG)) Q 0 ;exempt from copay
 I $$RXST^IBARXEU(+ORVP)>0 Q 0 ;exempt from copay
 Q 1
 ;
INSTR(OI) ; -- Get allowable instructions and routes
 N PSOI,INSTR,NOUN,I,X,CNT
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),ORLEAD,ORNOUNS,ORSCHED
 S PSOI=+$P($G(^ORD(101.43,+OI,0)),U,2) D START^PSSJORDF(PSOI)
 S:$L($G(^TMP("PSJSCH",$J))) ORSCHED=^($J) ;default schedule
 Q:$P($G(^ORD(100.98,+ORDG,0)),U,3)'="O RX"  ; Don't need nouns for Inpt
 S NOUN=$$PTR^ORCD("OR GTX FREE TEXT"),ORNOUNS="",(I,CNT)=0
 F  S I=$O(^TMP("PSJNOUN",$J,I)) Q:I'>0  S X=$P(^(I),U) I $L(X) S CNT=CNT+1,ORDIALOG(NOUN,"LIST",CNT)=X_U_X,ORDIALOG(NOUN,"LIST","B",X)=X,ORNOUNS=ORNOUNS_$S($L(ORNOUNS):" or ",1:"")_X
 S ORDIALOG(NOUN,"LIST")=CNT_"^1",INSTR=$$PTR^ORCD("OR GTX INSTRUCTIONS")
 S I=$O(^TMP("PSJINS",$J,0)),X=$P($G(^TMP("PSJINS",$J,+I)),U)
 S:$L(X) ORLEAD=$$LOWER^VALM1(X),ORDIALOG(INSTR,"TTL")=ORLEAD_": "
 S ORDIALOG(INSTR,"A")=$S($L($G(ORLEAD)):ORLEAD,1:"Amount")_$S($L(ORNOUNS):" (in "_ORNOUNS_")",1:"")_": "
 Q
 ;
CHOICES(TYPE) ; -- Get list of allowable dispense drugs
 Q:$D(ORDIALOG(PROMPT,"LIST"))  N OI,PSJOI,I,X,Y,ORX,ORY
 S OI=$$VAL^ORCD("MEDICATION"),PSJOI="^^^"_+$P($G(^ORD(101.43,+OI,0)),U,2)
 S ORX=$T(ENDD^PSJORUTL),ORX=$L($P(ORX,";"),",")
 I ORX>3 D ENDD^PSJORUTL(PSJOI,TYPE,.ORY,+ORVP) Q:ORY'>0
 I ORX'>3 D ENDD^PSJORUTL(PSJOI,TYPE,.ORY) Q:ORY'>0
 F I=1:1:ORY S X=$P(ORY(I),U,2),ORY("B",X)=ORY(I) K ORY(I) ; sort
 S I=0,ORX="" W !
 F  S ORX=$O(ORY("B",ORX)) Q:ORX=""  S X=ORY("B",ORX),I=I+1 D
 . S Y=$P(X,U,1,2) I $L($P(X,U,5)),Y'[$P(X,U,5) S Y=Y_" "_$P(X,U,5)
 . S:$P(X,U,4) Y=Y_" (non-formulary)"
 . S:$P(X,U,3) Y=Y_"  $"_$P(X,U,3)_$S($L($P(X,U,5)):" per "_$P(X,U,5),1:"")
 . S ORDIALOG(PROMPT,"LIST",I)=Y,ORDIALOG(PROMPT,"LIST","B",$P(X,U,2))=+X,ORDIALOG(PROMPT,"LIST","D",+X)=I_U_$P(X,U,4)_U_$P(X,U,6)
 S ORDIALOG(PROMPT,"LIST")=ORY_"^1" ; total^list only
 Q
 ;
 ; ** End of old code
 ;
NF(DRUG) ; -- Get alternatives for non-formulary drugs
 ;    [Called from P-S Action for Dose]
 N TYPE,ORY,I,DD,PSOI,ORPSOI,X,Y,DUOUT,DTOUT
 Q:'$G(DRUG)  Q:$G(ORENEW)
 S TYPE=$S($G(ORCAT)="I":"U",1:"O")
 D ENRFA^PSJORUTL(DRUG,TYPE,.ORY)
 S ORPSOI=+$P($G(^ORD(101.43,+$G(OROI),0)),U,2)
 S (I,DD)=0 I ORY F  S DD=$O(ORY(DD)) Q:DD'>0  D  ;build list of choices
 . S PSOI=$P(ORY(DD),U,4,5) Q:PSOI=ORPSOI  Q:$G(ORY("PS",+PSOI))
 . S I=I+1,ORY("B",I)=PSOI,ORY("PS",+PSOI)=I
 I '$P($G(^ORD(101.43,+$G(OROI),"PS")),U,6) D  ;skip if OI is NF
 . W !!,"*** The dispense drug for this dose is not in the formulary! ***"
 . W:'ORY!('I) !,"    There are no formulary alternatives entered for this item."
 . W !,"    Please consult with your pharmacy before ordering this dose."
NF1 Q:'ORY!('I)  D  Q:$G(ORQUIT)  ;Q if no different choices
 . N DIR S DIR(0)="NAO^1:"_ORY
 . S DIR("A")="Select alternative (or <return> to continue): "
 . S I=0 F  S I=$O(ORY("B",I)) Q:I'>0  S DIR("A",I)=$J(I,3)_" "_$P(ORY("B",I),U,2)
 . S DIR("?")="The dispense drug for the selected dose is not in the formulary; you may select an alternative orderable item, or press <return> to continue processing this order."
 . W !,"    Formulary alternative orderable items:"
 . D ^DIR S:$D(DTOUT)!($D(DUOUT)) ORQUIT=1
 I Y D  ; reset OI, doses
 . S PSOI=+ORY("B",Y),X=+$O(^ORD(101.43,"ID",PSOI_";99PSP",0))
 . Q:'X  Q:X=OROI  ;error or same OI
 . S ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1)=X
 . D CHANGED^ORCDPS1("OI"),OI2^ORCDPS1,D1^ORCDPS2 ;get new doses
 . D:$G(ORDIALOG(PROMPT,"LIST")) LIST^ORCD K DONE,ORESET
 . S DIR("A")=ORDIALOG(PROMPT,"A"),(ORI,INST)=1 ;reset if complex
 Q
 ;
DISPDRUG() ; -- Get Dispense Drug from dose selection(s) [from EXDOSE^ORCDPS2]
 ;       Expects PROMPT, ORDIALOG(), ORDOSE()
 ;
 N DD,FORM,I,DOSE,X,ORID,OK,STR,ORX,HALFOK
 S DD=$G(ORDIALOG($$PTR("DISPENSE DRUG"),1)) I DD Q DD ;already have
 S DD="",FORM="1.N.""."".N."" ""1"""_$P($G(ORDOSE(1)),U,2)_""""
 S I=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  D  Q:DD="^"
 . S DOSE=$G(ORDIALOG(PROMPT,I)),X=""
 . S:$L(DOSE) X=$G(ORDIALOG(PROMPT,"LIST","D",DOSE))
 . I X="" S DD=$S($G(ORCAT)="I":"^",'$G(ORDOSE(1)):"^",DOSE'?@FORM:"^",1:0) Q
 . S:DD="" DD=X I X'=DD S DD=$S($G(ORCAT)="I":"^",1:0) Q
 Q:DD DD Q:DD="^" "" ;all same, or not possible
 S ORID=$$PTR("DOSE"),DD=0 F  S DD=$O(ORDOSE("DD",DD)) Q:DD'>0  D
 . S OK=1,STR=+$P($G(ORDOSE("DD",DD)),U,5),HALFOK=+$P($G(ORDOSE("DD",DD)),U,11)
 . S I=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  D  Q:'OK
 .. S DOSE=$G(ORDIALOG(PROMPT,I))
 .. I '$G(ORDOSE(1)) D  Q  ;local doses
 ... S X=$G(ORDOSE("DD",DD,DOSE)) I X="" S OK=0 K ORX(DD) Q
 ... S ORX(DD,I)=DOSE,ORX(DD)=""
 .. S X=+$G(ORDIALOG(ORID,I)) S:X'>0 X=+DOSE S X=X/STR
 .. I (X?1.N)!(HALFOK&(X?.N.1".5")) S ORX(DD,I)=X S:X>$G(ORX(DD)) ORX(DD)=X Q
 .. K ORX(DD) S OK=0
 I '$G(ORDOSE(1)) S DD=$O(ORX(0)) Q DD ;first one
 S DD="",X=99999,I=0 F  S I=$O(ORX(I)) Q:I'>0  I ORX(I)<X S X=ORX(I),DD=I
 Q DD
 ;
ID() ; -- Return ID string for dose instance INST
 N INSTR,DD,DOSE,ID
 S INSTR=$$PTR("INSTRUCTIONS"),DOSE=$G(ORDIALOG(INSTR,INST)),(DD,ID)=""
 S:$L(DOSE) DD=+$G(ORDIALOG(INSTR,"LIST","D",DOSE))
 S:DD ID=$TR($G(ORDOSE("DD",DD,DOSE)),"^","&")
 Q ID
 ;
RESETID ; -- Reset ORDIALOG(DOSE) nodes for new ORDRUG
 ;    From EXDOSE^ORCDPS2: Expects PROMPT, DRUG
 ;
 Q:$G(ORCAT)'="O"  N I,ORID,STR,UNT,DOSE,X,FORM
 S ORID=$$PTR("DOSE"),STR=+$P(DRUG,U,5),UNT=$P(DRUG,U,6)
 S FORM="1.N.""."".N."" ""1"""_UNT_""""
 S I=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  D
 . S DOSE=$G(ORDIALOG(PROMPT,I)),X=$G(ORDOSE("DD",+ORDRUG,DOSE))
 . I '$L(X),STR,DOSE?@FORM D
 .. N UD,NOUN S UD=+DOSE/STR,NOUN=$P($G(ORDOSE(1)),U,4)
 .. I UD>1,$E(NOUN,$L(NOUN))'="S" S NOUN=NOUN_"S"
 .. S X=+DOSE_"&"_UNT_"&"_UD_"&"_NOUN_"&"_DOSE_"&"_+ORDRUG_"&"_STR_"&"_UNT
 . S:$L(X) ORDIALOG(ORID,I)=$TR(X,"^","&") Q
 Q
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
