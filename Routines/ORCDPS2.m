ORCDPS2 ;SLC/MKB-Pharmacy dialog utilities ;12/14/2006
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94,116,125,131,243**;Dec 17, 1997;Build 242
 ;
COMPLEX() ; -- Single or complex?
 N X,Y,DIR,DUOUT,DTOUT,COMPLX
 S COMPLX=$S($O(ORDIALOG(PROMPT,"?"),-1)>1:1,$L($G(ORDIALOG($$PTR("DURATION"),1))):1,1:0)
 I $G(ORTYPE)="Q",$O(ORDIALOG(PROMPT,0)),FIRST Q COMPLX
 I $D(ORENEW)!$D(OREWRITE)!$D(ORXFER)!COMPLX Q COMPLX
 I $D(OREDIT) Q:$D(ORCOMPLX)!COMPLX COMPLX G CP1 ;Q if complex or 'first, else ask
 I 'FIRST S Y=$S($D(ORCOMPLX):ORCOMPLX,1:COMPLX) Q Y
CP1 S DIR(0)="YA",DIR("A")="Complex dose? ",DIR("B")="NO"
 S DIR("?")="Enter YES if you wish to enter multiple sets of dosage instructions, a tapering dose, or to limit the duration of a single dose."
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
DOSES ; -- Available common doses
 ;S $P(ORDIALOG(PROMPT,0),U,2)=$S(ORCAT="I":"1:20",1:"1:80")
 S ORDIALOG(PROMPT,"A")="Dose"_$S(ORCAT="I"&$G(ORIV):" or Rate: ",1:": ")
 S $P(ORDIALOG(PROMPT,"?"),",",2)=$S($G(ORIV):" as either a dose amount or infusion rate.",1:" as a dose or amount.")
 I FIRST,'$O(ORDIALOG(PROMPT,0)),$G(ORXFER) D SHOWSIG^ORCMED
 S ORCOMPLX=$$COMPLEX,MULT=+ORCOMPLX I ORCOMPLX="^" S ORQUIT=1 Q
 Q:$G(ORDIALOG(PROMPT,"LIST"))  Q:'$D(ORDOSE)
D1 ; -- Entry from ORCMED,NF^ORCDPS to build list
 N I,J,X,DD,DRUG,DOSE,CONJ,CNT,UD,COST,TEXT
 S (I,CNT)=0,CONJ=$P($G(ORDOSE("MISC")),U,3) S:$L(CONJ) CONJ=" "_CONJ
 F  S I=$O(ORDOSE(I)) Q:I'>0  D
 . S X=ORDOSE(I),DD=+$P(X,U,6),DRUG=ORDOSE("DD",DD)
 . ;  =TotalDose^Units^U/D^Noun^LocalDose^DispDrugIEN^Cost
 . ;DD=Name^Cost^NF^DispUnit^Strength^Units^DoseForm^MaxRefills?
 . S DOSE=$P(X,U,5),UD=$P(X,U,3),COST=$P(X,U,7) Q:'$L(DOSE)
 . I '$P(X,U) S DOSE=DOSE_CONJ_" "_$S($L($P(DRUG,U,5)):$P(DRUG,U,5)_$P(DRUG,U,6),1:$P(DRUG,U))
 . ;I UD S COST="$"_$J(UD*$P(DRUG,U,2),1,3) ;_" per "_UD_" "_$P(X,U,4)
 . S TEXT=DOSE_$S($L(COST):"     $"_COST,1:"")_$S($P(DRUG,U,3):"   (non-formulary)",1:"")
 . S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=DOSE_U_TEXT
 . S ORDIALOG(PROMPT,"LIST","B",TEXT)=DOSE
 . S ORDIALOG(PROMPT,"LIST","D",DOSE)=DD ;default DispDrug
 . S ORDOSE("DD",DD,DOSE)=$P(ORDOSE(I),U,1,6)_U_$P(DRUG,U,5,6)
 . S J=0 F  S J=$O(ORDOSE(I,J)) Q:J'>0  D  ;xref alt forms of dose
 .. S DD=+$P(ORDOSE(I,J),U,6),DRUG=$G(ORDOSE("DD",DD))
 .. S ORDOSE("DD",DD,DOSE)=$P(ORDOSE(I,J),U,1,6)_U_$P(DRUG,U,5,6)
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT
 Q
 ;
CHDOSE ; -- Kill dependent values if inst ORI of dose changes
 N X,PROMPTS,P,NAME,DOSE,DD S X=$G(ORDIALOG(PROMPT,ORI))
 S X=$$UP^XLFSTR(X),ORDIALOG(PROMPT,ORI)=X ;force uppercase
 I X,X'?1.N.E1.A.E K DONE W $C(7),!,"Enter the amount of this drug that the patient is to receive as a dose,",!,"NOT as the number of units per dose." Q
 I $L(X)>60,'$D(ORDIALOG(PROMPT,"LIST","B",X)) K DONE W $C(7),!,"Instructions may not be longer than 60 characters." Q
 I $G(ORESET)'=X D  ;kill dependent values if new/changed dose
 . S PROMPTS="STRENGTH^DRUG NAME^DOSE^DISPENSE DRUG^DAYS SUPPLY^QUANTITY^REFILLS"
 . F P=1:1:$L(PROMPTS,U) S NAME=$P(PROMPTS,U,P) K ORDIALOG($$PTR(NAME),ORI)
 . K ORQTY,ORQTYUNT,ORDRUG,ORDIALOG($$PTR("DISPENSE DRUG"),1)
 . K ^TMP("ORWORD",$J,$$PTR("SIG"))
 S DOSE=$$PTR("DOSE") I $L(X),'$L($G(ORDIALOG(DOSE,ORI))) D  ;set ID
 . S DD=+$G(ORDIALOG(PROMPT,"LIST","D",X))
 . S:DD ORDIALOG(DOSE,ORI)=$TR($G(ORDOSE("DD",DD,X)),"^","&")
 S DD=+$P($G(ORDIALOG(DOSE,ORI)),"&",6)
 I DD,$P($G(ORDOSE("DD",DD)),U,3) D NF^ORCDPS(DD) ;look for FormAlt
 Q
 ;
EXDOSE ; -- Exit Action
 Q:'$O(ORDIALOG(PROMPT,0))  N DRUG,MISC,QUIT,LAST
 S ORDRUG=$$DISPDRUG^ORCDPS,DRUG=$G(ORDOSE("DD",+ORDRUG))
 I ORDRUG D  I $G(QUIT) S ORQUIT=1 Q
 . ;I $P(DRUG,U,10),'$L($P($G(^VA(200,+$G(ORNP),"PS")),U,2)),'$L($P($G(^("PS")),U,3)) W $C(7),!,$P($G(^(0)),U)_" must have a DEA# or VA# to order this drug!" S QUIT=1 Q
 . ;I $P(DRUG,U,10)=1 W $C(7),!,"This order will require a wet signature!"
 . S ORDIALOG($$PTR("DISPENSE DRUG"),1)=ORDRUG
 . D:$G(ORCAT)="O" RESETID^ORCDPS
 . N STR,MED S STR=$P(DRUG,U,5)_$P(DRUG,U,6)
 . I STR'>0 S:'$G(ORDOSE(1)) ORDIALOG($$PTR("DRUG NAME"),1)=$P(DRUG,U) Q
 . S MED=$P($G(^ORD(101.43,+$G(OROI),0)),U)
 . I MED'[STR,ORCAT="O"!'$G(ORDOSE(1)) S ORDIALOG($$PTR("STRENGTH"),1)=STR
 I +ORDRUG'>0,ORCAT="O" W $C(7),!,"Cannot determine dispense drug - some defaults and order checks may not occur!"
EXD1 ; -- Kill dangling conjunction, [re]build Sig, get Qty info
 S LAST=$O(ORDIALOG(PROMPT,"?"),-1) K ORDIALOG($$PTR("AND/THEN"),LAST)
 D ADMIN^ORCDPS3 D:$G(ORTYPE)'="Z" SIG ;[re]build Sig/Text
 I ORDRUG,ORCAT="O" D  ;set Qty info
 . S:$L($P(DRUG,U,4)) ORQTYUNT=$P(DRUG,U,4)
 . S MISC=$$ENDCM^PSJORUTL(+ORDRUG),ORQTY=$P(MISC,U,4)
 . W:$L($P(MISC,U,2)) !!,$P(MISC,U,2),!
 Q
 ;
SIG ; -- Create ORDIALOG(SIG) from Instructions PROMPT,ORDOSE,ORDRUG,ORCAT
 ;    Return text in ^TMP("ORWORD",$J,SIG,INST)
 ;   [also called from PSJ^ORCSEND1 to build child orders]
 ;
 N ORT,ORSCH,ORDUR,ORID,ORDD,ORCNJ,ORMISC,ORPREP,ORX,ORI,CNT,ORSIG,ORS,DOSE
 S ORT=$$PTR("ROUTE"),ORSCH=$$PTR("SCHEDULE"),ORDUR=$$PTR("DURATION")
 S ORID=$$PTR("DOSE"),ORCNJ=$$PTR("AND/THEN"),ORS=$$PTR("SIG")
 S ORMISC=$G(ORDOSE("MISC")),ORPREP=$P(ORMISC,U,2)
 S ORX=$S(ORCAT="I":"",ORCAT="O"&(+$G(ISIMO)=1):"",$L($P(ORMISC,U)):$P(ORMISC,U)_" ",1:"") ;"TAKE "
 S (CNT,ORI)=0 F  S ORI=$O(ORDIALOG(PROMPT,ORI)) Q:ORI'>0  D
 . S DOSE=$G(ORDIALOG(PROMPT,ORI)) Q:'$L(DOSE)
 . S ORX=ORX_$$DOSE_$$RTE_$$SCH_$$DUR_$$CONJ
 . S CNT=CNT+1,ORSIG(CNT,0)=ORX,ORX=""
 Q:CNT'>0  S ORSIG(0)="^^"_CNT_U_CNT_U_DT_U
 K ^TMP("ORWORD",$J,ORS,1) M ^(1)=ORSIG S ORDIALOG(PROMPT,"FORMAT")="@"
 S ORDIALOG(ORS,1)=$NA(^TMP("ORWORD",$J,ORS,1))
 Q
 ;
PTR(X) ; -- Ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
DOSE() ; -- Dosage
 N X0,Y S X0=$G(ORDIALOG(ORID,ORI)) ;ID string
 S Y=DOSE I ORDRUG,$L(X0) D  ;use local dose if common DispDrug
 . S:$L($P(X0,"&",5)) Y=$P(X0,"&",5) ;unless Outpt w/total dose
 . I ORCAT="O",X0 S Y=$$WORD($P(X0,"&",3))_" "_$P(X0,"&",4) ;u/d
 Q Y
 ;
WORD(X) ; -- Words for number X
 N X1,X2,Y S X1=$P(+X,"."),X2=$P(+X,".",2)
 S Y="" I X1 S Y=$S(X1=1:"ONE",X1=2:"TWO",X1=3:"THREE",X1=4:"FOUR",X1=5:"FIVE",X1=6:"SIX",X1=7:"SEVEN",X1=8:"EIGHT",X1=9:"NINE",X1=10:"TEN",1:X1)
 I X2 S Y=Y_$S($L(Y):" AND ",1:"")_$S(X2=5:"ONE-HALF",X2=33!(X2=34):"ONE-THIRD",X2=25:"ONE-FOURTH",X2=66!(X2=67):"TWO-THIRDS",X2=75:"THREE-FOURTHS",1:"."_X2)
 Q Y
 ;
RTE() ; -- Expansion of route
 N X,X0,Y S X=+$G(ORDIALOG(ORT,ORI)) Q:X'>0 ""
 K ^TMP($J,"ORCDPS2 RTE")
 D ALL^PSS51P2(+X,,,,"ORCDPS2 RTE")
 ;S X0=$G(^PS(51.2,+X,0)),Y=""
 I ORCAT="I"!(+$G(ISIMO)=1) S Y=" "_$S($L(^TMP($J,"ORCDPS2 RTE",+X,1)):^TMP($J,"ORCDPS2 RTE",+X,1),1:^TMP($J,"ORCDPS2 RTE",+X,.01))
 ;I ORCAT="I" S Y=" "_$S($L($P(X0,U,3)):$P(X0,U,3),1:$P(X0,U))
 I ORCAT="O",'+$G(ISIMO) S Y=" "_$S($L(ORPREP):ORPREP_" ",1:"")_$S($L(^TMP($J,"ORCDPS2 RTE",+X,4)):^TMP($J,"ORCDPS2 RTE",+X,4),1:^TMP($J,"ORCDPS2 RTE",+X,.01))
 Q Y
 ;
SCH() ; -- [outpatient] expansion of schedule
 N X,Y S X=$G(ORDIALOG(ORSCH,ORI))
 I $L(X),ORCAT="O",'+$G(ISIMO) D SCH^PSSUTIL1(.X)
 S Y=$S($L(X):" "_X,1:"")
 Q Y
 ;
DUR() ; -- Duration
 N X,Y S X=$G(ORDIALOG(ORDUR,ORI)),Y=""
 I X S Y=" FOR "_$$UP^XLFSTR(X)_$S(+X=X:" DAYS",1:"")
 Q Y
 ;
CONJ() ; -- Conjunction
 N X,Y S X=$G(ORDIALOG(ORCNJ,ORI))
 S:$L(X)>1 X=$E(X) S:X="E" S="X"
 S Y=$S(X="T":", THEN",X="X":" EXCEPT",X="A":" AND",1:"")
 Q Y
 ;
DOSETEXT        ; -- Reset dose text in ORDIALOG(INSTR) for backdoor orders
 ;    [Called from ORMPS1 - uses ORCAT,PSOI,ORVP,DRUG,INSTR,DOSE]
 ;
 N ORTYPE,ORDOSE,CONJ,ORDRUG,DRUG0,STRG,ORI,LDOSE,X,PROMPT
 S ORTYPE=$S($G(ORCAT)="I":"U",1:"O")
 D DOSE^PSSORUTL(.ORDOSE,+PSOI,ORTYPE,+ORVP)
 S CONJ=$P($G(ORDOSE("MISC")),U,3) S:$L(CONJ) CONJ=" "_CONJ
 S ORDRUG=+$G(ORDIALOG(DRUG,1)),DRUG0=$G(ORDOSE("DD",ORDRUG))
 S STRG=$P(DRUG0,U,5)_$P(DRUG0,U,6)
 I '$G(ORDOSE(1)) S ORI=0 F  S ORI=$O(ORDIALOG(INSTR,ORI)) Q:ORI'>0  D
 . S LDOSE=$G(ORDIALOG(INSTR,ORI)),X=$G(ORDIALOG(DOSE,ORI)) Q:'$L(X)
 . S:'X ORDIALOG(INSTR,ORI)=LDOSE_CONJ_" "_$S(STRG:STRG,1:$P(DRUG0,U))
 ; -build Sig/Text if not defined
 I '$D(ORDIALOG(+$$PTR("SIG"),1)) S PROMPT=INSTR D SIG
 Q
 ;
PI ; -- Include Pt Instructions w/Sig in Outpt order?
 N X,Y,DIR,DUOUT,DTOUT,DIRUT,ORTX,ORMAX,I,CNT
 I $G(ORCAT)'="O" D CLEARWP Q  ;!'$O(ORDOSE("PI",0))
 Q:$G(ORENEW)  S I=0,ORMAX=57
 I $G(OREDIT)!$G(OREWRITE),$O(^TMP("ORWORD",$J,PROMPT,INST,0)) K ORDOSE("PI") S I=0 F  S I=$O(^TMP("ORWORD",$J,PROMPT,INST,I)) Q:I<1  S ORDOSE("PI",I)=$G(^(I,0))
 I '$O(ORDOSE("PI",0)) D CLEARWP Q
 F  S I=$O(ORDOSE("PI",I)) Q:I'>0  S X=ORDOSE("PI",I) D TXT^ORCHTAB
 S DIR(0)="YA",DIR("A")="Include Patient Instructions in Sig? "
 S DIR("?")="Enter NO if you do not want these instructions included in the sig for this order",DIR("B")=$S($D(^TMP("ORWORD",$J,PROMPT)):"YES",1:"NO")
 W ! S I=0 F  S I=$O(ORTX(I)) Q:I'>0  W !,$S(I=1:"Patient Instructions: ",1:"                      ")_ORTX(I)
 D ^DIR I $D(DUOUT)!$D(DTOUT) S ORQUIT=1 Q
 I Y D  Q  ;save text
 . K ^TMP("ORWORD",$J,PROMPT,INST) S CNT=0
 . S I=0 F  S I=$O(ORDOSE("PI",I)) Q:I'>0  S ^TMP("ORWORD",$J,PROMPT,INST,I,0)=ORDOSE("PI",I),CNT=CNT+1
 . S ^TMP("ORWORD",$J,PROMPT,INST,0)="^^"_CNT_U_CNT_U_DT_U
 . S ORDIALOG(PROMPT,INST)="^TMP(""ORWORD"","_$J_","_PROMPT_","_INST_")"
 I Y'>0 K ORDIALOG(PROMPT,INST),^TMP("ORWORD",$J,PROMPT,INST)
 Q
 ;
CLEARWP ; -- Clear INST of wp field PROMPT
 K ORDIALOG(PROMPT,INST),^TMP("ORWORD",$J,PROMPT,INST)
 Q
