IBDFDE2 ;ALB/AAS - AICS Data Entry, process selection lists ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**4**;APR 24, 1997
 ;
% G ^IBDFDE
 ;
CHOICE(I) ; -- return ^tmp(ibd-lst,ibdfmien,ibdf(pi),ibdf(ien),i)
 Q $G(^TMP("IBD-LST",$J,+$G(IBDFMIEN),+$G(IBDF("PI")),+$G(IBDF("IEN")),+$G(I)))
 ;
LIST(RESULT,IBDF,IBDASK) ; -- Procedure
 ; -- Manual Data entry routine for Visit Type input
 ;    Input :  Result := call by reference, used to output results
 ;             IBDF("IEN")    := pointer to selection list (357.2)
 ;             IBDF("PI")     := pointer to input package interface
 ;             IBDF("DFN")    := pointer to patient (required for dynamic lists only)
 ;             IBDF("CLINIC") := pointer to hospital location (required for dyamic lists only)
 ;
 ;    Output:  Selections for input in IBDFDE1 (and eventually IBDFRPC4)
 ;             RESULT(0)      := count of selections (including previous)
 ;             RESULT(n)  $p1 := package interface
 ;                        $p2 := Code to send (usually ien) 
 ;                        $p3 := Text to send (from form or additional text) 
 ;                        $p4 := Header to send (from form) (optional)
 ;                        $p5 := Clinical lexicon pointer (from 357.2) (optional)
 ;                        $p6 := qualifier (optional)
 ;                        $p7 := ien of list (in 357.2)
 ;                       $p10 := external value (optional)
 ;
 N I,J,X,Y,CHOICE,RULE,ROW,QLFR,TEXT,TEXTU,CODE,NUMBER,OVER,SELECT,ANS,DISPTXT,HDR,NEXT,NEXT1,PICK,DA,DR,DIE,DIC,DIR,DIRUT,DUOUT,DTOUT,IBDEFLT,CNTH,OVER,IBDP,SELAST,IOINHI,IOINORM,ARRAY,VAR
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S IBQUIT=0,ANS=""
 I IBDF("TYPE")="MC" D MULT^IBDFDE4(.RESULT,.IBDF) G VSTQ
 ;
 ; -- check required variables
 I '$D(IBDFMIEN)!('$D(IBDF("PI")))!('$D(IBDF("IEN"))) W !!,"Required variables not defined for this list:",!,"Form =",$G(IBDFMIEN),!,"Interface = ",$G(IBDF("PI")),!,"List = ",$G(IBDF("IEN")) G VSTQ
 ;
 S VAR="^TMP(""IBD-LST"",$J,"_+$G(IBDFMIEN)_","_+$G(IBDF("PI"))_","_+$G(IBDF("IEN"))_")"
 I $$CHOICE(0)="" D OBJLST^IBDFRPC1(VAR,.IBDF) D COMPLST^IBDFDE5
 ;
 I '$D(^TMP("IBD-ASK",$J,IBDFMIEN,IBDASK)),$G(IBDF("IBDF")) S ^TMP("IBD-ASK",$J,IBDFMIEN,$$UP^XLFSTR(IBDASK),IBDF("IBDF"))=""
 ;
 I +$$CHOICE(0)<1,+$G(IBDF("PROVIDER PI"))'=IBDF("PI") G VSTQ ;list is empty, don't ask, unless its provider
 ;
 ; -- look at zero node, find qualifiers and selection rule
 D RULES^IBDFDE22
 ;
 I $G(IBDREDIT) S ANS=" " D CHK^IBDFDE22 S ANS="" G:'OVER VSTQ N IBDREDIT
 ;
 ; -- set dir("b")
 I $D(IBDPI(IBDF("PI")))>1 D DEFAULT^IBDFDE21
 ;
OVER ; -- ask or re-ask for selection(s) from list
 S OVER=0
 S CNTH=1,I=0 F  S I=$O(RULE(I)) Q:'I  D
 . IF RULE(I)=0 S DIR("?",CNTH)="Any Number of "_$G(IOINHI)_QLFR(I)_$S(QLFR(I)'="":" ",1:"")_IBDASK_$G(IOINORM)_" allowed (including zero)." S CNTH=CNTH+1 Q
 . IF RULE(I)=1 S DIR("?",CNTH)="Exactly one "_IOINHI_QLFR(I)_$S(QLFR(I)'="":" ",1:"")_IBDASK_$G(IOINORM)_" Required." S CNTH=CNTH+1 Q
 . IF RULE(I)=2 S DIR("?",CNTH)="At most one "_$G(IOINHI)_QLFR(I)_$S(QLFR(I)'="":" ",1:"")_IBDASK_$G(IOINORM)_" allowed." S CNTH=CNTH+1 Q
 . IF RULE(I)=3 S DIR("?",CNTH)="At least 1 (1 or more) "_$G(IOINHI)_QLFR(I)_$S(QLFR(I)'="":" ",1:"")_IBDASK_$G(IOINORM)_" Required." S CNTH=CNTH+1 Q
 ;
 S DIR("?",CNTH)="",CNTH=CNTH+1
 S DIR("?")="Select an item from the form, enter by name or number.  Enter '??' to see the list of items on the form.  When editing, press enter to accept, '@' to delete, or enter a new selection."
 I $G(IBDF("OTHER")) S DIR("?")=DIR("?")_"  Or enter an item written on the form."
 ;
 S DIR("??")="^D LST^IBDFDE21"
 ;
 ; -- default provider is 1st provider
 I +$G(IBDF("PROVIDER PI"))=IBDF("PI") D  I $G(SELECT) D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 K IBNAQLFR G VSTOVER
 .S SELECT=0
 .I $G(IBDF("PROVIDER")) Q
 .I '$G(IBDREDIT),'$D(IBDPI(IBDF("PI"))),+$$CHOICE(0)=1,+$$PRDEF^IBDFRPC3(IBDF("CLINIC")) S ANS=" ",SELECT=1 W !!,IOINHI,"Using Default Provider : "_IBDPTPRI,IOINORM S IBNAQLFR=1 Q
 .Q:$P(IBDF("PROVIDER PI"),"^",2)  ;not on form don't ask if not default
 .Q:$D(IBDPI(IBDF("PI")))  ;one already select
 .I $$PRDEF^IBDFRPC3(IBDF("CLINIC")) S DIR("B")=$P($$CHOICE(1),"^")
 ;
 S DIR(0)="FO^1:40^I $D(X),X="" "" K X W !!,$G(IOINHI),""Spacebar Return Not allowed!"",$G(IOINORM)"
 S DIR("A")="Select "_$G(IBDASK)
 I $G(^TMP("IBD-PI-CNT",$J,IBDF("PI")))>1 S DIR("A")=DIR("A")_" (Page "_IBDF("PAGE")_")"
 D ^DIR K DIR
 I $G(IBDEFLT(IBDF("PI")))'="",Y=IBDEFLT(IBDF("PI")) S Y="" ; on re-edit, accepting last entry same as entering nothing.
 S ANS=$$UP^XLFSTR(Y)
 I ANS="",$D(DIRUT),$G(IBDEFLT(IBDF("PI")))'="",$G(SELAST) K IBDPI(IBDF("PI"),SELAST),IBDSEL(SELAST) W "  Deleted!" ;user type "@" at prompt
 I ANS="" D CHK^IBDFDE22 G VSTOVER
 I ANS["^",ANS'="^" D  G VSTOVER
 .S GOTO=$$UP^XLFSTR($P(ANS,"^",2))
 .I GOTO="?"!(GOTO="??") X "W !!,""Valid Blocks to Jump to: "" S IBDX=0 F  S IBDX=$O(^TMP(""IBD-ASK"",$J,IBDFMIEN,IBDX)) Q:IBDX=""""  W !,?6,IBDX" S OVER=1 Q
 .S X=$O(^TMP("IBD-ASK",$J,IBDFMIEN,GOTO))
 .I X'="",X[GOTO W $E(X,$L(GOTO)+1,$L(X)) S IBDF("GOTO")=+$O(^TMP("IBD-ASK",$J,IBDFMIEN,X,""))-1,IBDREDIT=1 Q
 .S IBQUIT=1
 I $D(DIRUT) S IBQUIT=1 G VSTQ
 S SELECT=0
 ;
 ; -- first check for exact code matches
 I $G(NUMBER(ANS)) S SELECT=$G(NUMBER(ANS)) D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 G VSTOVER
 ;
 S ARRAY="^TMP(""IBD-LCODE"",$J,IBDFMIEN,IBDF(""PI""),IBDF(""IEN""))"
 I $G(@ARRAY@(" "_ANS,1)),'$O(@ARRAY@(" "_ANS,1)) S SELECT=@ARRAY@(" "_ANS,1) D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 G VSTOVER
 I $G(@ARRAY@(" "_ANS,1)) D  I $G(SELECT) D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 G VSTOVER
 .; -- more than one code the same number
 .S SELECT=$$PARTLST^IBDFDE21(ARRAY," "_ANS," "_ANS)
 ;
 ; -- next check for paritial code answers
 S ANS1=" "_ANS
 S NEXT=$O(@ARRAY@(ANS1)) D  I SELECT D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 G VSTOVER
 .Q:NEXT=""!($E(NEXT,1,$L(ANS1))'=ANS1)
 .I $O(@ARRAY@(NEXT,1)) S SELECT=$$PARTLST^IBDFDE21(ARRAY,NEXT,ANS1) Q
 .S NEXT1=$O(@ARRAY@(NEXT)) I $E(NEXT1,1,$L(ANS1))=ANS1 S SELECT=$$PARTLST^IBDFDE21(ARRAY,NEXT,ANS1) Q  ;Not Unique answer
 .W $E(NEXT,($L(ANS1)+1),$L(NEXT))
 .S SELECT=$G(@ARRAY@(NEXT,1))
 ;
 ; -- check for exact text matches
 S ARRAY="^TMP(""IBD-LTEXT"",$J,IBDFMIEN,IBDF(""PI""),IBDF(""IEN""))"
 I $G(@ARRAY@(ANS,1)),'$O(@ARRAY@(ANS,1)) S SELECT=@ARRAY@(ANS,1)  D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 G VSTOVER
 I $G(@ARRAY@(ANS,1)) D  I $G(SELECT) D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 G VSTOVER
 .; -- more than one description the same
 .S SELECT=$$PARTLST^IBDFDE21(ARRAY,ANS,ANS)
 ;
 ; -- next check for paritial text answers
 S NEXT=$O(@ARRAY@(ANS)) D  I SELECT D SEL^IBDFDE21(SELECT),CHK^IBDFDE22 G VSTOVER
 .Q:NEXT=""!($E(NEXT,1,$L(ANS))'=ANS)
 .I $O(@ARRAY@(NEXT,1)) S SELECT=$$PARTLST^IBDFDE21(ARRAY,NEXT,ANS) Q
 .S NEXT1=$O(@ARRAY@(NEXT)) I $E(NEXT1,1,$L(ANS))=ANS S SELECT=$$PARTLST^IBDFDE21(ARRAY,NEXT,ANS) Q  ;Not Unique answer
 .W $E(NEXT,($L(ANS)+1),$L(NEXT))
 .S SELECT=$G(@ARRAY@(NEXT,1))
 ;
 I ANS'="" S SEL=$$OTHER^IBDFDE21(ANS) I SEL'="" D SEL^IBDFDE21(SEL),CHK^IBDFDE22 G VSTOVER
 I ANS'="" W " ??  ",$C(7),"Not Found" G OVER
 ;
VSTOVER K SELAST G:OVER OVER
 I $G(ASKOTHER) F  S SEL=$$OTHER^IBDFDE21("") Q:SEL=""  D SEL^IBDFDE21(SEL),CHK^IBDFDE22 Q:'$G(ASKOTHER)
 ;
VSTQ ; -- kill array for dynamic lists
 I $P($G(^IBE(357.6,IBDF("PI"),0)),"^",14) S:IBDF("PI")'=$G(IBDF("PROVIDER PI")) IBDF("DYNAMIC")=1 K ^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI")),^TMP("IBD-LTEXT",$J,IBDFMIEN,IBDF("PI")),^TMP("IBD-LCODE",$J,IBDFMIEN,IBDF("PI"))
 K ^TMP("IB",$J,"INTERFACES")
 K IBDF("OTHER"),ASKOTHER
 Q
