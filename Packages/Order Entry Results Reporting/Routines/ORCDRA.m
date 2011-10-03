ORCDRA ; SLC/MKB - Utility functions for RA dialogs ;7/23/01  11:47
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8,53,95,141**;Dec 17, 1997
 ;
EN ; -- Entry action for RA OERR EXAM order dialog
 D LAST7:$G(ORTAB)="ORDERS"
ENA N ENT D ITYPE ;enter here for Quick Setup (editor) instead
 S ENT="ALL"_$S($G(ORDIV):"^DIV.`"_ORDIV,1:"")
 S ORBROAD=$$GET^XPAR(ENT,"RA REQUIRE DETAILED",1,"Q")
 Q
 ;
EX ; -- Exit action for RA OERR EXAM order dialog
 K ORBROAD,ORIMTYPE,ORIMLOC,ORMORE,ORDIV
 Q
 ;
LAST7 ; -- Display last 7 days of exams for patient
 N IDT,EXDT,EXAM,STS,Y
 Q:$G(ORTYPE)="Q"  Q:$G(ORACT)="XX"  Q:$G(ORACT)="RN"
 K ^TMP($J,"RAE7") D EN2^RAO7PC1(+ORVP)
 Q:'$O(^TMP($J,"RAE7",+ORVP,0))  S IDT=0 ; no exams
 W !!,"Case #    Exams Over the Last 7 Days   Exam Date   Status of Exam  Imaging Loc.",!,"------    --------------------------   ---------   --------------  ------------"
 F  S IDT=$O(^TMP($J,"RAE7",+ORVP,IDT)) Q:IDT'>0  S EXAM=$G(^(IDT)) D
 . S Y=$P(9999999-$P(IDT,"-"),".") X ^DD("DD")
 . S STS=$P(EXAM,U,3),STS=$S(STS="V":"VERIFIED",STS="R":"RELEASED/UNVER",STS="N":"NO REPORT",STS="P":"PARTIAL",1:"")
 . W !,$E($P(EXAM,U,2),1,9),?10,$E($P(EXAM,U),1,28),?39,Y_" "_STS,?67,$E($P(EXAM,U,5),1,12)
 K ^TMP($J,"RAE7") W !
 Q
 ;
ITYPE ; -- Select Imaging Type for ordering, sets ORIMTYPE
 N XRAY,DA,DG,DG0,ABBREV,CNT,ITYPE,DIC,X,Y,I,NAME,OI,IFN,ORY
 I $G(ORTYPE)="Q" S ORDG=ORDG_U_$G(^ORD(100.98,+ORDG,0)) G ITQ
 I $G(ORIFN) S DG=+$P(^OR(100,+ORIFN,0),U,11),ORDG=DG_U_$G(^ORD(100.98,DG,0)) G ITQ  ; edit
 S XRAY=$O(^ORD(100.98,"B","XRAY",0)),(DA,CNT)=0
 I $G(ORTYPE)="Z",ORDG'=XRAY S ORDG=ORDG_U_$G(^ORD(100.98,+ORDG,0)) G ITQ
 F  S DA=$O(^ORD(100.98,XRAY,1,DA)) Q:DA'>0  S DG=$G(^(DA,0)) D
 . S DG0=$G(^ORD(100.98,DG,0)),ABBREV=$P(DG0,U,3)
 . ;I $D(^ORD(101.43,"S."_ABBREV)) S CNT=CNT+1,ITYPE(ABBREV)=DG_U_DG0
 . I $$ACTIVE(ABBREV) S CNT=CNT+1,ITYPE(ABBREV)=DG_U_DG0
 I 'CNT W $C(7),!!,"No active Imaging Types defined!",! H 3 S ORQUIT=1 Q
 I CNT=1 S I=$O(ITYPE("")),ORDG=ITYPE(I) G ITQ
 W !!,"Select one of the following imaging types:"
 S I="" F  S I=$O(ITYPE(I)) Q:I=""  W !,"   "_$P(ITYPE(I),U,2)
 S DIC="^RA(79.2,",DIC(0)="AEQMZ",DIC("A")="Select IMAGING TYPE: "
 S DIC("S")="I $D(ITYPE($P(^(0),U,3)))" W !
 D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S ORQUIT=1 Q
 S ORDG=ITYPE($P(Y(0),U,3))
ITQ S NAME=$P(ORDG,U,3),OI=$$PTR^ORCD("OR GTX ORDERABLE ITEM")
 S ORDIALOG(OI,"A")=NAME_" Procedure: ",ORDIALOG(OI,"?")="Enter the "_NAME_" procedure to be ordered for this patient"
 S ITYPE=$P(ORDG,U,4),ORIMTYPE=$O(^RA(79.2,"C",ITYPE,0))
 S ORDIALOG(OI,"D")="S."_ITYPE_";C."_ITYPE
 I ORIMTYPE D  ; screen modifiers on ImType
 . N PTR S PTR=$$PTR^ORCD("OR GTX MODIFIERS") Q:'PTR
 . S ORDIALOG(PTR,"S")="I $D(^RAMIS(71.2,""AB"","_ORIMTYPE_",+Y))"
 S ORDIV=$$DIV^ORCDRA1 D EN4^RAO7PC1(ITYPE,"ORY")
 S (IFN,CNT)=0 F  S IFN=$O(ORY(IFN)) Q:IFN'>0  S CNT=CNT+1,ORIMLOC(CNT)=ORY(IFN),ORIMLOC("B",$P(ORY(IFN),U,2))=IFN ; I $P(ORY(IFN),U,3)=ORDIV
 I '$$GET^XPAR("ALL^DIV.`"_ORDIV,"RA SUBMIT PROMPT",1,"Q"),CNT>1 K ORIMLOC ; don't present any choices
 E  S ORIMLOC=CNT_"^1"
 Q
 ;
ACTIVE(DG) ; -- Returns 1 or 0, if active OI's exist for DG
 N X,Y,IDX,ROOT,NOW S Y=0
 G:'$L($G(DG)) ACTQ G:'$D(^ORD(101.43,"S."_DG)) ACTQ
 S IDX="^ORD(101.43,""S."_DG_""")",ROOT=$TR(IDX,")",","),NOW=$$NOW^XLFDT
 F  S IDX=$Q(@IDX) Q:$E(IDX,1,$L(ROOT))'=ROOT  S X=$P(@IDX,U,3) I 'X!(X>NOW) S Y=1 Q  ;at least one active orderable in index
ACTQ Q Y
 ;
COMMON ; -- Build ORDIALOG(PROMPT,"LIST") of Common Procedures
 N CNT,ITYPE,NAME,DA K ORDIALOG(PROMPT,"LIST")
 S:'$D(ORDG) ORDG=$P(^ORD(101.41,+ORDIALOG,0),U,5),ORDG=ORDG_U_$G(^ORD(100.98,+ORDG,0))
 S ITYPE=$P(^ORD(100.98,+ORDG,0),U,3) Q:'$D(^ORD(101.43,"COMMON",ITYPE))
 S NAME="",CNT=0
 F  S NAME=$O(^ORD(101.43,"COMMON",ITYPE,NAME)) Q:NAME=""  S DA=$O(^(NAME,0)),CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=DA_U_NAME
 S ORDIALOG(PROMPT,"LIST")=CNT
 S:CNT $P(ORDIALOG(PROMPT,"?"),";",2)=" select either the number of a common procedure listed above or the name of any "_$$LOW^XLFSTR($P(ORDG,U,2))_" procedure"
 Q
 ;
LIST ; -- List Common Procedures in ORDIALOG(PROMPT,"LIST") for selection
 N NUM,DA,HALF,DIR,Y Q:'$O(ORDIALOG(PROMPT,"LIST",0))
 S HALF=ORDIALOG(PROMPT,"LIST")\2
 I ORDIALOG(PROMPT,"LIST")\2*2'=ORDIALOG(PROMPT,"LIST") S HALF=HALF+1
 W !!,"Common "_$$LOWER^VALM1($P(ORDG,U,2))_" Procedures: "
 S Y=1 F NUM=1:1:HALF D  Q:'+Y
 . S DA=ORDIALOG(PROMPT,"LIST",NUM)
 . W !,$J(NUM,3)_" "_$E($P(ORDIALOG(PROMPT,"LIST",NUM),U,2),1,36)
 . S DA=$G(ORDIALOG(PROMPT,"LIST",NUM+HALF)) Q:'DA
 . W ?40,$J(NUM+HALF,3)_" "_$E($P(ORDIALOG(PROMPT,"LIST",NUM+HALF),U,2),1,36)
 .I (NUM+$G(VALM("TM"))=24)&(NUM'=$S($G(SCR)'=""&($G(ORTAB)="ORDERS"):19,1:20)) S DIR(0)="E" D ^DIR K DIR
 Q
 ;
BROAD(PROC) ; -- Ck PROC type vs ORBROAD
 Q:'ORBROAD  Q:$P($G(^ORD(101.43,+PROC,"RA")),U,2)'="B"
 K DONE W $C(7),!,"You may not select a broad procedure!",!
 Q
 ;
LKP ; -- Special lookup on [common] procedures
 N ORX,I,J,Z,BEG,END K ORMORE
 I X'[",",X'["-" S Y=$$FIND^ORCDLG2("ORDIALOG("_PROMPT_",""LIST"")",X) D:'$L(Y) DIC^ORCDLG2 Q
 S ORX=X F I=1:1:$L(ORX,",") S X=$P(ORX,",",I) I $L(X) D
 . I 'X S ORMORE=+$G(ORMORE)+1,ORMORE(ORMORE)=U_X Q
 . I X'?1.2N,X'?1.N1"-"1.N Q
 . S BEG=+X,END=+$P(X,"-",2) S:'END END=X
 . F J=BEG:1:END S Z=$G(ORDIALOG(PROMPT,"LIST",J)) S:Z ORMORE=+$G(ORMORE)+1,ORMORE(ORMORE)=Z
 D NEXTPROC
 Q
 ;
NEXTPROC ; -- Gets next procedure in ORMORE()
 Q:$G(ORDIALOG(PROMPT,INST))
 N I,X S I=$O(ORMORE(0)) I 'I K ORMORE Q
 S X=$G(ORMORE(I)),ORMORE=ORMORE-1 K ORMORE(I)
 W !!,"For "_$P(ORDIALOG(PROMPT,"A"),":")_" "_$P(X,U,2)_":"
 S:X Y=X,ORDIALOG(PROMPT,INST)=+X,EDITONLY=1
 I 'X S X=$P(X,U,2) D DIC^ORCDLG2 S:Y'>0 ORQUIT=1 S:Y>0 ORDIALOG(PROMPT,INST)=+Y,EDITONLY=1
 Q
