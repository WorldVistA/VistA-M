IBDFDE4 ;ALB/AAS - AICS Manual Data Entry, process multiple choice fields ; 29-APR-96IOIN
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% G ^IBDFDE
 ;
MULT(RESULT,IBDF) ; -- Procedure
 ; -- Manual Data entry routine for Multiple Choice Fields
 ;    Input :  Result := call by reference, used to output results
 ;             IBDF("IEN")    := pointer to hand print file (359.94)
 ;             IBDF("PI")     := pointer to input package interface
 ;             IBDF("DFN")    := pointer to patient
 ;             IBDF("CLINIC") := pointer to hospital location
 ;
 ;    output:  Result(n)  $p1 := pointer to package interface
 ;
 N I,J,X,Y,ANS,DISPTXT,HDR,DIR,DIRUT,DUOUT,DTOUT,IBDX,QLFR,CHOICE,OVER
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S (IBQUIT,OVER)=0,(ANS,QLFR)=""
 I $G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),0))="" D
 .D OBJLST^IBDFRPC1(.CHOICE,.IBDF)
 .M ^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"))=CHOICE
 .K CHOICE
 .D COMPLST^IBDFDE5
 I +$G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),0))<1 G MULTQ
 S IBDASK=$P($P($G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),0)),"^",3),":")
 I '$D(^TMP("IBD-ASK",$J,IBDFMIEN,IBDASK)) S ^TMP("IBD-ASK",$J,IBDFMIEN,$$UP^XLFSTR(IBDASK),IBDF("IBDF"))=""
 S RULE=+$P($G(^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"),0)),"^",4)
 ;
OVER ; -- ask or re-ask for selection(s) from list
 IF RULE=0 S DIR("?",1)="Any Number of "_$G(IOINHI)_IBDASK_$G(IOINORM)_" allowed (including zero)."
 IF RULE=1 S DIR("?",1)="Exactly one "_$G(IOINHI)_IBDASK_$G(IOINORM)_" Required."
 IF RULE=2 S DIR("?",1)="At most one "_$G(IOINHI)_IBDASK_$G(IOINORM)_" allowed."
 IF RULE=3 S DIR("?")="At least 1 (1 or more) "_$G(IOINHI)_IBDASK_$G(IOINORM)_" Required."
 ;
 S DIR("?",2)=""
 S DIR("?")="Select an item from the form, enter by name or number.  Enter '??' to see the choices.  When editing, press enter to accept, '@' to delete, or enter a new selection."
 ;
 S DIR("??")="^D LST^IBDFDE41"
 ;
 S DIR(0)="FO^1:40^I $D(X),X="" "" K X W !!,$G(IOINHI),""Spacebar Return Not allowed!"",$G(IOINORM)"
 I IBDASK[":" S $P(DIR(0),"^")="FOA"
 S DIR("A")="Select "_$G(IBDASK)
 D ^DIR K DIR
 I $G(IBDEFLT(IBDF("PI")))'="",Y=IBDEFLT(IBDF("PI")) S Y="" ; on re-edit, accepting last entry same as entering nothing.
 S ANS=$$UP^XLFSTR(Y)
 I ANS="",$D(DIRUT),$G(IBDEFLT(IBDF("PI")))'="",$G(SELAST) K IBDPI(IBDF("PI"),SELAST),IBDSEL(SELAST) W "  Deleted!" ;user type "@" at prompt
 I ANS="" D CHK^IBDFDE42 G MCOVER
 I ANS["^",ANS'="^" D  G MCOVER
 .S GOTO=$$UP^XLFSTR($P(ANS,"^",2))
 .I GOTO="?"!(GOTO="??") X "W !!,""Valid Blocks to Jump to: "" S IBDX=0 F  S IBDX=$O(^TMP(""IBD-ASK"",$J,IBDFMIEN,IBDX)) Q:IBDX=""""  W !,?6,IBDX" S OVER=1 Q
 .S X=$O(^TMP("IBD-ASK",$J,IBDFMIEN,GOTO))
 .I X'="",X[GOTO W $E(X,$L(GOTO)+1,$L(X)) S IBDF("GOTO")=+$O(^TMP("IBD-ASK",$J,IBDFMIEN,X,""))-1,IBDREDIT=1 Q
 .S IBQUIT=1
 I $D(DIRUT) S IBQUIT=1 G MULTQ
 S SELECT=0
 ;
 ;
 ; -- first check for exact code matches
 I $G(NUMBER(ANS)) S SELECT=$G(NUMBER(ANS)) D SEL^IBDFDE41(SELECT),CHK^IBDFDE42 G MCOVER
 ;
 ; -- check for exact text matches
 S ARRAY="^TMP(""IBD-LTEXT"",$J,IBDFMIEN,IBDF(""PI""),IBDF(""IEN""))"
 I $G(@ARRAY@(ANS,1)),'$O(@ARRAY@(ANS,1)) S SELECT=@ARRAY@(ANS,1)  D SEL^IBDFDE41(SELECT),CHK^IBDFDE42 G MCOVER
 I $G(@ARRAY@(ANS,1)) D  I $G(SELECT) D SEL^IBDFDE41(SELECT),CHK^IBDFDE42 G MCOVER
 .; -- more than one description the same
 .S SELECT=$$PARTLST^IBDFDE41(ARRAY,ANS,ANS)
 ;
 ; -- next check for paritial text answers
 S NEXT=$O(@ARRAY@(ANS)) D  I SELECT D SEL^IBDFDE41(SELECT),CHK^IBDFDE42 G MCOVER
 .Q:NEXT=""!($E(NEXT,1,$L(ANS))'=ANS)
 .I $O(@ARRAY@(NEXT,1)) S SELECT=$$PARTLST^IBDFDE41(ARRAY,NEXT,ANS) Q
 .S NEXT1=$O(@ARRAY@(NEXT)) I $E(NEXT1,1,$L(ANS))=ANS S SELECT=$$PARTLST^IBDFDE41(ARRAY,NEXT,ANS) Q  ;Not Unique answer
 .W $E(NEXT,($L(ANS)+1),$L(NEXT))
 .S SELECT=$G(@ARRAY@(NEXT,1))
 ;
 I ANS'="" W " ??  ",$C(7),"Not Found" G OVER
 ;
MCOVER ;
 G:OVER OVER
 ;
MULTQ ;
 K ^TMP("IBD-LST",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"))
 K ^TMP("IBD-LTEXT",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"))
 K ^TMP("IBD-LCODE",$J,IBDFMIEN,IBDF("PI"),IBDF("IEN"))
 K ^TMP("IB",$J,"INTERFACES")
 K IBDF("OTHER"),ASKOTHER
 Q
 ;
ASKYN(DIR) ; -- input dir
 N ANS,X
 D ^DIR
 I $G(IBDREDIT),Y=$G(DIR("B")) S ANS=DIR("B") G ASKYNQ
 K DIR
 S ANS=$$UP^XLFSTR(Y)
 I ANS="" G ASKYNQ
 I ANS["^",ANS'="^" D  G ASKYNQ
 .S GOTO=$$UP^XLFSTR($P(ANS,"^",2))
 .S X=$O(^TMP("IBD-ASK",$J,IBDFMIEN,GOTO))
 .;I GOTO="?"!(GOTO="??") X "W !!,""Valid Blocks to Jump to: "" S IBDX=0 F  S IBDX=$O(^TMP(""IBD-ASK"",$J,IBDFMIEN,IBDX)) Q:IBDX=""""  W !,?6,IBDX" S OVER=1 Q
 .I X'="",X[GOTO W $E(X,$L(GOTO)+1,$L(X)) S IBDF("GOTO")=+$O(^TMP("IBD-ASK",$J,IBDFMIEN,X,""))-1,IBDREDIT=1 Q
 .S IBQUIT=1
 I $D(DIRUT) S IBQUIT=1
ASKYNQ Q $G(ANS)
 ;
 Q
TEST ;
 S IBDFMIEN=9999
 S IBDF("APPT")=2970331.1014
 S IBDF("CLINIC")=300
 S IBDF("DFN")=7169761
 S IBDF("FORM")=33154
 S IBDF("FRMDEF")=747
 S IBDF("IBDF")=9
 S IBDF("IEN")=213
 S IBDF("TYPE")="MC"
 S IBDF("PI")=92
 D MULT(.RESULT,.IBDF)
 Q
