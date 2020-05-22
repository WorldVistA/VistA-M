IBCEPTC ;ALB/TMK - EDI PREVIOUSLY TRANSMITTED CLAIMS ; 4/12/05 11:15am
 ;;2.0;INTEGRATED BILLING;**296,320,348,349,547,592,623,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Main entrypoint
 ; IBDT1,IBDT2 = last transmit date range to use
 ; IBSORT = primary sort criteria to use B=BATCH #,I=INS CO NAME
 ; IBFORM = form type to limit selection to U=UB-04,C=CMS-1500,J=J430D, OR A=ALL
 ; IBCRIT = the additional sort criteria needed
 ; IBPTCCAN = whether or not to include cancelled claims
 ; IBRCBFPC = whether or not to include force print @ clearinghouse
 ; ^TMP("IB_PREV_CLAIM_INS",$J) = 1 for specific ins co/null for all
 ;                        ^($J,1,ien)="" for ien of each ins co selected
 ;                        ^($J,2,payer ID,ien)="" if selected
 ; IBREP = format output should be put in R=report,S=Listman
 ;
 N DIR,DIC,X,Y,Z,Z0,Z1,IBHOW,IBACT,IBCT,IBREP,IBCRIT,IBDT1,IBDT2,IBLOC
 N IBFORM,IBOK,IBQUIT,IBSORT,IBY,DTOUT,DUOUT,%ZIS,ZTSAVE,ZTRTN,ZTDESC
 N POP,IBPAYER,EDI,INST,PROF,IBPTCCAN,DIROUT,DIRUT,DTOUT,DUOUT,IBRCBFPC
 ;
 W !!,"*** Please Note ***"
 W ?20,"2 '^' are needed to abort this option (^^)"
 W !?20,"1 '^' brings you back to the previous prompt (^)"
 W !
 ; IB*2.0*547 add new prompt for locally printed vs. transmitted claims
 S DIR(0)="SA^P:Printed;T:Transmitted",DIR("A")="Run report for (P)rinted or (T)ransmitted claims?: ",DIR("B")="Transmitted"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G ENQ
 ; Set a flag here to indicate user wants locally printed claims and use that to control how the rest of the prompts act.
 S IBLOC=$S(Y="T":"",1:1)
 ;
Q1 ;
 W !
 ;S DIR(0)="SA^C:Claim;B:Batch;L:List",DIR("A")="Select By: (C)laim, (B)atch or see a (L)ist to pick from?: ",DIR("B")="List"
 S DIR(0)="SA^C:Claim;"_$S(IBLOC:"",1:"B:Batch;")_"L:List",DIR("A")="Select By: (C)laim"_$S(IBLOC:"",1:", (B)atch")_" or see a (L)ist to pick from?: ",DIR("B")="List"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G ENQ
 S IBHOW=Y
 I IBLOC=1 W !,"Previously printed claims to a payer that does not accept EDI are omitted."
 I IBHOW="L" G Q1A
 ;
 S IBQUIT=0,IBCT=0
 K ^TMP($J,IBHOW)
 F  D  Q:IBQUIT
 .;I IBHOW="C" S DIR("A")="Select a"_$S(IBCT:"nother",1:"")_" Claim: ",DIR(0)="PA^364:AEMQZ",DIR("S")="I '$P(^(0),U,7),'$O(^IBA(364,""B"",+^(0),Y))"
 . ;JWS;IB*2.0*623;allow previously trans claims in test to be resubmitted if non-production environment "!'$$PROD^XUPROD(1)"
 . ;JWS;2/12/20;IB*2.0*659 removed '$$PROD^XUPROD(1) call in screen, caused Naked ref error
 . I IBHOW="C",IBLOC="" S DIR("A")="Select a"_$S(IBCT:"nother",1:"")_" Claim: ",DIR(0)="PA^364:AEMQZ",DIR("S")="I '$P(^(0),U,7),'$O(^IBA(364,""B"",+^(0),Y))"
 . I IBHOW="C",IBLOC=1 S DIR("A")="Select a"_$S(IBCT:"nother",1:"")_" Locally Printed Claim: ",DIR(0)="PA^399:AEMQZ",DIR("S")="I '$D(^IBA(364,""B"",Y)),$$INSOK^IBCEF4(+$$CURR^IBCEF2(Y))"
 . I IBHOW="B" S DIR("A")="Select a"_$S(IBCT:"nother",1:"")_" Batch: ",DIR(0)="PA^IBA(364.1,:AEMQ^W ""  "",$P(^(0),U,3),"" Claims""",DIR("S")="I '$P(^(0),U,14)"
 . S DIR("?")="^D SELDSP^IBCEPTC(IBHOW)"
 . S:IBCT $P(DIR(0),U)=$P(DIR(0),U)_"O" ; Optional prompt after one is selected
 . D ^DIR K DIR
 . I Y'>0 S IBQUIT=$S(X="^":2,X="^^":3,1:1) Q
 . S IBY=$S(IBHOW="C":+Y,1:""),Y=$S(IBHOW="C":+Y(0),1:Y) S:IBLOC=1 Y=IBY
 . I '$D(^TMP($J,IBHOW,+Y)) S IBCT=IBCT+1,^TMP($J,IBHOW,+Y)=IBY
 ;
 G:IBQUIT=3 ENQ
 G:IBQUIT=2!'$O(^TMP($J,IBHOW,0)) Q1
 S Z=0
 I IBHOW="C" F  S Z=$O(^TMP($J,"C",Z)) Q:'Z  S ^TMP("IB_PREV_CLAIM_SELECT",$J,Z,0)=^TMP($J,"C",Z)
 I IBHOW="B" S (Z,IBCT)=0 F  S Z=$O(^TMP($J,"B",Z)) Q:'Z  D
 . S Z0=0 F  S Z0=$O(^IBA(364,"C",Z,Z0)) Q:'Z0  S Z1=+$G(^IBA(364,Z0,0)) I Z1,'$D(^TMP("IB_PREV_CLAIM_SELECT",$J,Z1,0)) S ^(0)=Z0,IBCT=IBCT+1
 S ^TMP("IB_PREV_CLAIM_SELECT",$J)=IBCT
 D RESUB^IBCEPTC3
 G ENQ
 ;
Q1A K ^TMP("IB_PREV_CLAIM_INS",$J)
 S DIR(0)="SA^A:All Payers;S:Selected Payers"
 S DIR("A")="Run for (A)ll Payers or (S)elected Payers?: " S DIR("B")="Selected Payers"
 W !!,"PAYER SELECTION:" D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DTOUT)!$D(DUOUT) G Q1
 ;
 I Y="A" S ^TMP("IB_PREV_CLAIM_INS",$J)="" G Q2
 ;
 ; esg - 11/21/05 - patch 320 question
 W !
 S DIR(0)="Y",DIR("A")="   Include all payers with the same electronic Payer ID",DIR("B")="Yes" D ^DIR K DIR
 I $D(DIROUT) G ENQ
 I $D(DIRUT) G Q1A
 S IBPAYER=Y
 W !
 ;
 S ^TMP("IB_PREV_CLAIM_INS",$J)=1
 S IBQUIT=0
 F  D  Q:IBQUIT
 . ; IB*2.0*547 allow lookup by EDI#'s using new cross-ref
 . ;S DIC(0)="AEMQ",DIC=36,DIC("A")="   Select Insurance Company: "
 . S DIC(0)="AEMQn",DIC=36,DIC("A")="   Select Insurance Company: "
 . I $O(^TMP("IB_PREV_CLAIM_INS",$J,1,"")) S DIC("A")="   Select Another Insurance Company: "
 . S DIC("W")="D INSLIST^IBCEMCA(Y)"
 . ;D ^DIC K DIC                   ; lookup
 . N D S D="B^AEI^AEP" D MIX^DIC1 K DIC,D
 . I X="^^" S IBQUIT=2 Q          ; user entered "^^"
 . I +Y'>0 S IBQUIT=1 Q           ; user is done
 . W !
 . S ^TMP("IB_PREV_CLAIM_INS",$J,1,+Y)=""
 . I 'IBPAYER Q
 . S EDI=$$UP^XLFSTR($G(^DIC(36,+Y,3)))
 . S PROF=$P(EDI,U,2),INST=$P(EDI,U,4)
 . I PROF'="",PROF'["PRNT" S ^TMP("IB_PREV_CLAIM_INS",$J,2,PROF,+Y)=""
 . I INST'="",INST'["PRNT" S ^TMP("IB_PREV_CLAIM_INS",$J,2,INST,+Y)=""
 . Q
 ;
 I IBQUIT=2 G ENQ
 ;
 I '$O(^TMP("IB_PREV_CLAIM_INS",$J,1,0)) D  G Q1A
 . W *7,!!?3,"No payers have been selected.  Please try again."
 . Q
 ;
Q2 ;; JWS;IB*2.0*592 US1108 - Dental EDI 837D / form J430D
 ;IA# 10026
 S DIR(0)="SA^C:CMS-1500;U:UB-04;J:J430D;A:All",DIR("B")="All"
 S DIR("A")="Run for (U)B-04, (C)MS-1500, (J)430D or (A)ll: "
 W !!,"BILL FORM TYPE SELECTION:" D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DTOUT)!$D(DUOUT) G Q1A
 S IBFORM=Y
 ;
Q3 S DIR(0)="DA^0:9999999:EPX",DIR("A")="Start with Date "_$S(IBLOC:"First Printed:  ",1:"Last Transmitted: ")
 ;S DIR("?",1)="This is the earliest date on which a batch that you want to include on this",DIR("?",2)=" report was last transmitted. You may choose a maximum date range of 90 days.",DIR("?")=" "
 S DIR("?",1)="This is the earliest date on which a batch that you want to include on this",DIR("?",2)=" report was "_$S(IBLOC=1:"first printed",1:"last transmitted")_". You may choose a maximum date range of 90 days.",DIR("?")=" "
 ;W !!,"LAST BATCH TRANSMIT DATE RANGE SELECTION:" D ^DIR K DIR
 W !!,$S(IBLOC:"FIRST PRINT",1:"LAST BATCH TRANSMIT")_" DATE RANGE SELECTION:" D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DTOUT)!$D(DUOUT) G Q2
 S IBDT1=Y
 S IBDT2=$$FMADD^XLFDT(IBDT1,90) I IBDT2>DT S IBDT2=DT
 S DIR("?",1)="This is the latest date on which a batch that you want to include on this",DIR("?",2)=" report was "_$S(IBLOC:"first printed",1:"last transmitted")_". You may choose a maximum date range of 90 days.",DIR("?")=" "
 S DIR("B")=$$FMTE^XLFDT(IBDT2,2),DIR(0)="DA^"_IBDT1_":"_IBDT2_":EPX"
 S DIR("A")="Go to Date "_$S(IBLOC:"First Printed",1:"Last Transmitted")_":("_$$FMTE^XLFDT(IBDT1,2)_"-"_$$FMTE^XLFDT(IBDT2,2)_"): " D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DTOUT)!$D(DUOUT) G Q3
 S IBDT2=Y
 ;
Q4 ; Additional selection criteria
 S DIR(0)="SAO^1:MRA Secondary Only;2:Primary Claims Only;3:Secondary Claims Only;4:Claims Previously Printed at Clearinghouse"
 S DIR("A",1)="ADDITIONAL SELECTION CRITERIA:",DIR("A",2)=" ",DIR("A",3)="1 - MRA Secondary Only",DIR("A",4)="2 - Primary Claims Only",DIR("A",5)="3 - Secondary Claims Only"
 S DIR("A",6)=$S(IBLOC:"",1:"4 - Claims Sent to Print at Clearinghouse Only"),DIR("A",7)=" ",DIR("A")="Select Additional Limiting Criteria (optional): "
 S DIR("?")="Select one of the listed criteria to further limit the claims to include"
 W ! D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DTOUT)!$D(DUOUT) G Q3
 S IBCRIT=Y
 ;
Q41 ; Ask user if they want to include cancelled claims
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Would you like to include cancelled claims"
 W ! D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DIRUT) G Q4
 S IBPTCCAN=Y
 ; IB*2.0*547 skip next 2 questions if looking for locally printed claims
 I IBLOC S IBSORT=2,IBRCBFPC=0 G Q6
 ;
Q42 ; Include claims that are forced to print at clearinghouse?
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Would you like to include claims Forced to Print at the Clearinghouse"
 W ! D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DIRUT) G Q41
 S IBRCBFPC=Y
 ;
Q5 S DIR("L",1)="Select one of the following: ",DIR("L",2)=" ",DIR("L",3)=$J("",10)_"1         Batch By Last Transmitted Date (Claims within a Batch)",DIR("L",4)=$J("",10)_"2         Current Payer (Insurance Company)"
 S DIR("L",5)=" "
 S DIR(0)="SA^1:Batch By Last Transmitted Date (Claims within a Batch);2:Current Payer (Insurance Company)",DIR("B")="Current Payer"
 S DIR("A")="Sort By: "
 W ! D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DTOUT)!$D(DUOUT) G Q42
 S IBSORT=Y
 ;
Q6 S DIR(0)="SA^R:Report;S:Screen List"
 S DIR("A")="Do you want a (R)eport or a (S)creen List format?: "
 S DIR("B")="Screen List"
 W ! D ^DIR K DIR
 I X="^^" G ENQ
 I $D(DTOUT)!$D(DUOUT) G Q5
 S IBREP=Y
 ; IB *2.0*547 call new SUB-routine for locally printed claims (not in file 364)
 I IBREP="S",IBLOC D LOC^IBCEPTC0 G ENQ
 ;
 I IBREP="S",'IBLOC D LIST^IBCEPTC0 G ENQ
 ;
Q7 ; Select device
 F  S IBACT=0 D DEVSEL(.IBACT) Q:IBACT
 I IBACT=99 G ENQ
 U IO
 ; IB *2.0*547 call new SUB-routine for locally printed claims (not in file 364)
 D:'IBLOC LIST^IBCEPTC0
 D:IBLOC LOC^IBCEPTC0
 ;
ENQ K ^TMP("IB_PREV_CLAIM_INS",$J),^TMP("IB_PREV_CLAIM_SELECT",$J)
 Q
 ;
DEVSEL(IBACT) ;
 N DIR,POP,X,Y,ZTRTN,ZTSAVE
 W !!,"You will need a 132 column printer for this report!"
 S %ZIS="QM" D ^%ZIS I POP S IBACT=99 G DEVSELQ
 I $G(IOM),IOM<132 S IBOK=1 D  I 'IBOK S IBACT=0 G DEVSELQ
 . S DIR(0)="YA",DIR("A",1)="This report requires output to a 132 column device.",DIR("A",2)="The device you have chosen is only set for "_IOM_".",DIR("A")="Are you sure you want to continue?: ",DIR("B")="No"
 . W ! D ^DIR K DIR
 . I Y'=1 S IBOK=0 W !
 I $D(IO("Q")) D  S IBACT=99 G DEVSELQ
 . K IO("Q")
 . S ZTRTN="LIST^IBCEPTC0",ZTSAVE("IBCRIT(")="",ZTSAVE("IB*")="",ZTSAVE("^TMP(""IB_PREV_CLAIM_INS"",$J)")="",ZTSAVE("^TMP(""IB_PREV_CLAIM_INS"",$J,")="",ZTDESC="IB - Previously Transmitted Claims Report"
 . D ^%ZTLOAD K ZTSK D HOME^%ZIS
 S IBACT=1
DEVSELQ Q
 ;
SELDSP(IBHOW) ; Display list of selected claims/batches
 ; IBHOW = "C" for claims   "B" for batches
 N Z,DIR,CT,QUIT
 I '$O(^TMP($J,IBHOW,0)) Q
 S (CT,QUIT)=0
 W !!,$S(IBHOW="C":"Claims",1:"Batches")," Already Selected:"
 S Z=0 F  S Z=$O(^TMP($J,IBHOW,Z)) Q:'Z!QUIT  S Z0=$G(^(Z)) D  Q:QUIT
 . I IBHOW="C" W !,?3,$P($G(^DGCR(399,Z,0)),U) Q
 . W !,?3,$P($G(^IBA(364.1,Z,0)),U),"  ",$P(^(0),U,3)," Claims"
 . S CT=CT+1
 . I '(CT#10),$O(^TMP($J,IBHOW,Z)) S DIR("A")="Press return for more or '^' to exit ",DIR(0)="EA" W ! D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S QUIT=1
 W !
 Q
 ;
