IBDFDE21 ;ALB/AAS - AICS Data Entry, process selection lists ; 11/22/99 4:35pm
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**4,38,23**;APR 24, 1997
 ;
% G ^IBDFDE
 ;
SEL(SEL) ; -- Build results array
 N IBDX,DSPTXT,IBQUIT,IBDQL,QCNT,IBDQLFR
 S IBQUIT=0
 ;
 S IBDQL=$$QLFR(.RULE,.QLFR)
 Q:IBQUIT!(IBDQL="^")
 S IBDQLFR=$P(IBDQL,"^",1) D SEL1
 ;
 F QCNT=2:1 S IBDQLFR=$P(IBDQL,"^",QCNT) Q:IBDQLFR=""  D SEL1
 Q
 ;
SEL1 ; -- build selections
 S IBDX=$G(RESULT(0))+1,RESULT(0)=IBDX
 I +SEL=SEL S CHOICE=$$CHOICE^IBDFDE2(SEL)
 I +SEL'=SEL S CHOICE=SEL
 S DISPTXT=$S($P(CHOICE,"^",5)="":$P(CHOICE,"^"),1:$P(CHOICE,"^",5))
 W:+$G(QCNT)<2 "  ",DISPTXT,"   ",$S($P(CHOICE,"^",2)'="":$P(CHOICE,"^",2),$P($G(^IBE(357.6,IBDF("PI"),0)),"^")="GMP INPUT CLINIC COMMON PROBLEMS":$$LEX^IBDFDE1($P(CHOICE,"^",3)),1:$P(CHOICE,"^",3)),"   ",$P(CHOICE,"^",8)_"   ",$P(CHOICE,"^",4)
 ;
 S RESULT(IBDX)=IBDF("PI")_"^"_$P(CHOICE,"^",3)_"^"_DISPTXT_"^"_$P(CHOICE,"^",8)_"^"_$P(CHOICE,"^",6)_"^"_IBDQLFR_"^"_$G(IBDF("IEN"))_"^^"_$P(CHOICE,"^",9)_"^"_$P(CHOICE,"^",2)_"^^"_$P(CHOICE,"^",12)
 S IBDPI(IBDF("PI"),IBDX)=RESULT(IBDX)
 ;
 ; --validate code for active problem list
 I $P($G(^IBE(357.6,IBDF("PI"),0)),"^")="PX INPUT PATIENT ACTIVE PROBLEM" D
 .N X S X=$P(CHOICE,"^",2) Q:X=""
 .I X=799.9 W !,$C(7),IOINHI,"Warning: The ICD9 Diagnosis associated with this problem needs to be updated!",IOINORM Q
 .D TESTICD^IBDFN7
 .I '$D(X) W !,$C(7),IOINHI,"Warning: The ICD9 code associated with this problem is inactive.",IOINORM
 .;I $D(X) W !,"This is a valid icd9 code"
 ;
 ; -- send second and third codes if applicable
 Q:"PRIMARYSECONDARYADD TO PROBLEM LIST"'[IBDQLFR
 N IBDQUAL
 S IBDQUAL=$S(IBDQLFR="PRIMARY":"SECONDARY",1:IBDQLFR)
 N I,IBDXCD,DISPTXT F I=10,11 I $P(CHOICE,"^",I)]"" D
 .S IBDX=$G(RESULT(0))+1,RESULT(0)=IBDX
 .S IBDXCD=$P(CHOICE,"^",I)
 .N X,Y S X=IBDXCD
 .D
 ..I $G(X)="" K X S Y="" Q
 ..S:$E(X,$L(X))'=" " X=X_" " ; use ba xref, add space to end for lookup.
 ..S X=$O(^ICD9("BA",X,0))
 ..I 'X S Y=""
 ..E  S Y=$P(^ICD9(X,0),"^",3)
 .S DISPTXT=Y
 .S RESULT(IBDX)=IBDF("PI")_"^"_IBDXCD_"^"_DISPTXT_"^"_$P(CHOICE,"^",8)_"^"_$P(CHOICE,"^",6)_"^"_IBDQUAL_"^"_$G(IBDF("IEN"))_"^^"_$P(CHOICE,"^",9)
 .S IBDPI(IBDF("PI"),IBDX)=RESULT(IBDX)
 ; 
 ; -- if ans contains - go to modifier routine
 I IBDASK="CPT Procedure Code" D MOD^IBDFDE23
 I IBDASK="Visit Type (EM) Code" D MOD^IBDFDE23
 Q
 ;
QLFR(RULE,QLFR) ; -- ask Qualifier from array, impose rules
 N I,X,IBDQ,IBDQ1,QCNT,CNT,ANS,IBDI,OVER,X1,X2,NUM
 S IBDQ="",CNT=0
 ;
 ; -- if only 1 qualifier use it
 I RULE=1 S IBDQ=$G(QLFR(+$O(QLFR(0)))) W "  ",IBDQ G QLFRQ
 ;
 S IBDI=0
 F  S IBDI=$O(QLFR(IBDI)) Q:'IBDI  S X=$G(QLFR(IBDI)) I X'="" D
 .S CNT=CNT+1,X(CNT)=X,X2(X)=X
 .I '$D(X1($E(X),1)) S X1($E(X),1)=X Q
 .S NUM=$O(X1($E(X),""),-1) S X1($E(X),NUM+1)=X
 I CNT=1 S IBDQ=$G(X(CNT)) W "  ",IBDQ G QLFRQ
 ;
 I $D(IBNAQLFR) S ANS=1 S IBDQ=X(ANS)  W !,IOINHI,"Using Default Qualifier: "_X(ANS),IOINORM,! Q IBDQ
OVER1 ;
 I CNT<1 G QLFRQ
 W !,IOINHI,"   Select a Qualifier",IOINORM
 I CNT>1 F I=1:1:CNT I X(I)'="" W !?6,I,?10,X(I)
 W !,"   Choose 1-",CNT,": " R ANS:DTIME
 I '$T!($E(ANS,1)="^") S IBDQ="",IBQUIT=1 G QLFRQ
 I ANS="" G OVER1
 S OVER=0
 I $E(ANS,1)="?" D HELP G OVER1
 I ANS=+ANS D  G:OVER OVER1
 .I ANS<1!(ANS>CNT) S OVER=1 Q
 .I $G(X(ANS))="" S OVER=1 Q
 .S IBDQ=X(ANS) W "  ",X(ANS)
 .W !
 I ANS'=+ANS D  G:OVER OVER1
 .S ANS1=ANS,QCNT=0,IBDQ1=""
 .F IBD=1:1 S ANS=$P(ANS1,",",IBD) Q:ANS=""!OVER  D ONEQLFR I 'OVER,IBDQ'="" S QCNT=QCNT+1,$P(IBDQ1,"^",QCNT)=IBDQ
 .S IBDQ=IBDQ1
 .K QCNT,IBDQ1
 ;
QLFRQ Q IBDQ
 ;
ONEQLFR ; -- parse qualifiers
 S ANS=$$UP^XLFSTR(ANS)
 I +ANS=ANS D  Q
 .I $G(X(ANS))="" W !,"'"_ANS_"' IS NOT A VALID SELECTION, RE-ENTER" S OVER=1 Q
 .S IBDQ=X(ANS) W "  ",X(ANS)
 ;
 I $L(ANS)=1,$G(X1(ANS,1))'="",$O(X1(ANS,1))="" S IBDQ=X1(ANS,1) W:ANS=ANS1 $E(X1(ANS,1),2,99) W:ANS'=ANS1 "  ",X1(ANS,1) Q
 I $G(X2(ANS))'="" S IBDQ=X2(ANS) W "  ",X2(ANS) Q
 I $L(ANS)=1,$G(X1(ANS,1))'="",$O(X1(ANS,1)) S OVER=1 W "  Ambiguous answer, enter the number." Q  ;S IBDQ=$$PARTLST("X1",ANS,ANS) W $E(X1(ANS,1),2,99) Q
 S OVER=1
 Q
 ;
LST ; -- List previous selections and selections to choose from.
 N I,CNT,IBQUIT,NUM
 ;
 ; -- list previous selections
 D PREVSEL
 ;
 ; -- list available choices
 S (IBQUIT,CNT)=0
 S NUM=+$$CHOICE^IBDFDE2(0)
 W !!,"Choose from: "
 S I=0 F  S I=$O(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),I)) Q:'I!(IBQUIT)  D
 .S CHOICE=$$CHOICE^IBDFDE2(I)
 .I '$P(CHOICE,"^",7) W !?16,IOINHI,$P(CHOICE,"^"),IOINORM Q
 .S CNT=CNT+1,NUMBER(CNT)=I
 .W !?3,CNT,?7,$S($P(CHOICE,"^",2)'="":$P(CHOICE,"^",2),1:$P(CHOICE,"^",3)),?16,$P(CHOICE,"^",1)
 .I NUM>15,NUM>I,'(CNT#15) D PAUSE^IBDFDE I 'IBQUIT W $C(13),$J("",55),$C(13)
 .;I NUM>15,CNT'=NUM,'(CNT#15) D READ I $G(LISTSEL)<1!($G(LISTSEL)>CNT) K LISTSEL
 .;I $G(LISTSEL) S SEL=NUMBER(LISTSEL)
 Q
 ;
PREVSEL ; -- List previous selections
 N I,CNT
 S CNT=0
 ;
 ; -- list previous selections
 I $D(IBDPI(IBDF("PI")))>1 S I=0 F  S I=$O(IBDPI(IBDF("PI"),I)) Q:'I  D
 .Q:$P(IBDPI(IBDF("PI"),I),"^",7)'=IBDF("IEN")  ; not the same list
 .S CNT=CNT+1
 .W:CNT=1 !!,IOINHI,"   You have previously selected: ",IOINORM
 .W !,?7,$S($P($G(^IBE(357.6,+IBDPI(IBDF("PI"),I),0)),"^")="GMP INPUT CLINIC COMMON PROBLEMS":$$LEX^IBDFDE1($P(IBDPI(IBDF("PI"),I),"^",2)),1:$P(IBDPI(IBDF("PI"),I),"^",2))
 .W ?16,$P(IBDPI(IBDF("PI"),I),"^",3),?50,$P(IBDPI(IBDF("PI"),I),"^",6)
 W !
 Q
 ;
DEFAULT ; -- compute default answer
 N CNT,SEL,NAME,PIECE,SELAST
 S (CNT,SEL,SELAST)=0
 S NAME=$P($G(^IBE(357.6,+IBDF("PI"),0)),"^")
 S PIECE=$S(NAME["INPUT PROCEDURE CODE":2,NAME["INPUT DIAGNOSIS CODE":2,NAME["INPUT VISIT TYPE":2,1:3)
 F  S SEL=$O(IBDPI(IBDF("PI"),SEL)) Q:'SEL  D
 .Q:$P(IBDPI(IBDF("PI"),SEL),"^",7)'=IBDF("IEN")  ; not the same list
 .S CNT=CNT+1,SELAST=SEL
 I $G(SELAST) S DIR("B")=$P(IBDPI(IBDF("PI"),SELAST),"^",PIECE),IBDEFLT(IBDF("PI"))=DIR("B")
 D PREVSEL
 Q
 ;
DEFPROV ; -- find default provider, not on form
 N SEL,IBDX
 S IBDF("PI")=$O(^IBE(357.6,"B","INPUT PROVIDER",0))
 Q:$D(IBDPI(IBDF("PI")))
 S SEL=$G(IBDF("PROVIDER")) I 'SEL S SEL=$$PRDEF^IBDFRPC3(IBDF("CLINIC"))
 Q:'SEL
 S $P(IBDF("PROVIDER PI"),"^",2)=1 ;flag not on form
 S IBDX=$G(IBDSEL(0))+1,IBDSEL(0)=IBDX
 S IBDSEL(IBDX)=IBDF("PI")_"^"_SEL_"^"_$P($G(^VA(200,+SEL,0)),"^")_"^^^PRIMARY^"
 S IBDPI(IBDF("PI"),IBDX)=IBDSEL(IBDX)
 W:'$G(IBDF("PROVIDER")) !!,"No Provider Block on form.  Using Default Provider from Clinic as Primary.",!
 W:$G(IBDF("PROVIDER")) !!,"Using Provider: "
 W "   ",$P(^VA(200,+SEL,0),"^"),"    PRIMARY",!
 Q
 ;
HELP ; -- 
 W !,"You must choose a data qualifier for this item.  Enter a number from 1-",CNT,!,"Or enter the first letter, or enter the full name.  Enter more than one",!,"qualifier separated by commas (ie 1,2 or P,A).",!
 Q
 ;
OTHER(IBDX) ; -- allow input of an additional item
 N I,J,X,Y,DIR,DIRUT,DUOUT,SEL,SELX,NARR,DIC,DIE,DA,DR,GMPTUN,GMPTSUB,GMPTSHOW,XTLKGLB,XTLKHLP,XTLKKSCH,XTLKSAY,IBDLEX,IBDFILE
 ;
 ; -- strip the cpt code if modifiers are added cpt-mod,mod,mod...
 ;
 I IBDX["-" S IBDX=$P(IBDX,"-")
 I $G(IBDF("LEXICON")) D  Q:'$D(IBDLEX)
 .I $D(^LEX)>1 S X="LEXSET" X ^%ZOSF("TEST") I $T D CONFIG^LEXSET("ICD","ICD") S IBDLEX=1
 .I '$D(IBDLEX) S X="GMPTSET" X ^%ZOSF("TEST") I $T D CONFIG^GMPTSET("GMPL","PL1") S IBDLEX=1
 .;D CONFIG^GMPTSET("ICD","ICD") (this is an alternate filter)
 S SELX=-1
 I '$G(IBDF("OTHER")) G OTHQ
 I $L($G(IBDX)) S X=IBDX S DIC(0)="EQMZ"
 S DIC("A")="Select Other "_$G(IBDASK)
 S DIC=$P(IBDF("OTHER"),"^") I $P(IBDF("OTHER"),"^",2)'="" S DIC("S")=$P(IBDF("OTHER"),"^",2,99)
 D ^DIC G OTHQ:+Y<1
 K DIC
 S SEL=Y
 W !!,$C(7),"WARNING: Item selected not from Encounter Form."
 ;
 I IBDF("PI")=$G(IBDF("PROVIDER PI")) W ! S SELX=$P($G(^VA(200,+Y,0)),"^",1)_"^^"_+Y_"^^^^1" G OTHQ
 ;
 W "...Entry of Narrative Required!",!
 S IBDFILE=+IBDF("OTHER")
 S:IBDFILE=81 DIR("B")=$P(Y(0),"^",2)
 ;S:IBDFILE=80 DIR("B")=$P(Y(0),"^",3)
 S:IBDFILE=80 DIR("B")=$S($L($G(^ICD9(+Y,1)))<81:^ICD9(+Y,1),1:$P(Y(0),"^",3))
 S:IBDFILE=357.69 DIR("B")=$P(Y(0),"^",3)
 I IBDFILE>9999999,IBDFILE<10000000 S DIR("B")=$P(Y(0),"^",1)
 S DIR(0)="FO^3:80",DIR("A")="Narrative" D ^DIR K DIR G:$G(DIRUT) OTHQ
 S NARR=Y
 ;
 S SELX=$S((IBDFILE<9999999)&(IBDFILE'=757.01):NARR_"^^"_$P(SEL,"^",2)_"^^^^1",1:NARR_"^^"_$P(SEL,"^",1)_"^^^^1")
OTHQ Q $S(SELX=-1:"",1:SELX)
 ;
PARTLST(ARY,NEXT,ANS) ; -- input has more than one match, prompt for which one
 N I,J,K,N,IBD,ANS2,SEL,CHOICE
 S SEL=0
 S NEXT=$E(NEXT,1,$L(NEXT)-1)_$C($A($E(NEXT,$L(NEXT)))-1)_"~"
 ;
 S J=0,K=NEXT F  S K=$O(@ARY@(K)) Q:$E(K,1,$L(ANS))'=ANS  D
 .S N=0 F  S N=$O(@ARY@(K,N)) Q:'N  D
 ..S J=J+1,IBD(J)=@ARY@(K,N),CHOICE=$$CHOICE^IBDFDE2(IBD(J))
 ..W !?6,J,?10,$S($P(CHOICE,"^",2)'="":$P(CHOICE,"^",2),1:$P(CHOICE,"^",3)),?20,$P(CHOICE,"^",1),?50,"   ",$P(CHOICE,"^",8),"   ",$P(CHOICE,"^",4)
 ;
ASKNUM I J<1 G PARTLQ
 W !,"   Choose 1-",J,": " R ANS2:DTIME
 I '$T!($E(ANS2,1)="^")!(ANS2="") S SEL="" G PARTLQ
 I $E(ANS2,1)="?" W !,"Enter a number from 1 - ",J G ASKNUM
 S ANS2=+ANS2
 I ANS2<1!(ANS2>J) G ASKNUM
 I $G(IBD(ANS2))="" G ASKNUM
 W !
 S SEL=$G(IBD(ANS2))
PARTLQ Q SEL
 ;
READ ; -- get input from list
 N ANS2
 G:CNT<1 READQ
 W !,"   Choose 1-",CNT,": " R ANS2:DTIME
 I '$T!($E(ANS2,1)="^") S IBQUIT=1 G READQ
 I $E(ANS2,1)="?" W !,"Enter a number from 1 - ",CNT," or return to see more." G READ
 S ANS2=+ANS2
 I ANS2<1!(ANS2>CNT) W $C(7),! G READ
 I $G(NUMBER(CNT))="" G READ
 W !
READQ Q
