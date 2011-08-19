RCRCAT1 ;ALB/CMS - AR/RC SEND AR TRANSACTION TO RC ;10/3/97  2:46 PM
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN ;ENTRY POINT FROM RCRCAT
 ;INPUT: PRCABN
 ;OUTPUT:PRCABN,RCOUT,^TMP("RCRCAT",$J,"XM",PRCABN,PRCAEN)
 N DIR,CNT,RCY,PRCA,PRCAT,PRCAEN,RCREF,RCST,SKIP,X,Y
 S (RCST,RCOUT)=0
 I '$D(^PRCA(430,+$G(PRCABN),0)) G ENQ
 K ^TMP("RCRCAT",$J,"XM",PRCABN)
 D BNVAR^RCRCUTL(PRCABN)
 D DEBT^RCRCUTL(PRCABN)
 S RCREF=$$REFST^RCRCUTL(PRCABN)
 D HD
 I '$O(^PRCA(433,"C",PRCABN,0)) D
 . S X="",$P(X,"*",20)="" W !!,X,"  NO TRANSACTION INFORMATION AVAILABLE  ",X
RD . R !!,"Press return to continue: ",X:DTIME S:('$T)!(X="^") RCOUT=1
 . I X["?" W !!,"Press the return key to return to menu." G RD
 . Q
 I RCOUT=1 G ENQ
LOP S (PRCAEN,CNT)=0 F  S PRCAEN=$O(^PRCA(433,"C",PRCABN,PRCAEN)) Q:('PRCAEN)!($G(RCOUT))!($G(SKIP))  D
 .I ($Y+3)>IOSL,CNT D ASK Q:($G(SKIP))!($G(RCOUT))  D HD
 .S X=$G(^PRCA(433,PRCAEN,1))
 .Q:'X
 .S CNT=CNT+1,PRCAT(CNT)=PRCAEN
 .W !,CNT,". ",$S($P(^PRCA(433,PRCAEN,0),"^",4)=1!$P(^(0),"^",10):"(I)",1:""),?8,PRCAEN
 .W ?17,$S($P($G(^PRCA(430.3,+$P(X,"^",2),0)),"^",3)=17:$P($G(^PRCA(433,PRCAEN,5)),"^",2),1:$P($G(^(0)),"^"))
 .W ?52 S Y=+X I Y D D^DIQ W Y
 .W ?65,$J($P(X,"^",5),9,2)
 D ASK
 I $G(RCST)=1 G ENQ
 I '$O(^TMP("RCRCAT",$J,"XM",PRCABN,0)),'$G(RCOUT) D TRP I $G(RCST)=1 K SKIP,RCOUT,PRCAT D HD,LOP
ENQ Q
 ;
ASK ;Ask user to select Tran from list
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,PRCAEN1,RCI,RCY,SEL,X,Y S RCOUT=0
 W ! S DIR("?")="Enter the list number(s) of the transaction(s) to be sent to RC"
 I PRCAEN S DIR("A",1)="Press enter to continue list or "
 S DIR(0)="LO^1:"_CNT,DIR("A")="Select Item #(s) to Transmit " D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G ASKQ
 I 'Y G ASKQ
 S RCY=$G(Y)
 F RCI=1:1:255 S SEL=$P(RCY,",",RCI) Q:'SEL  D
 .S PRCAEN=+$G(PRCAT(SEL)) D SET
ASKQ Q
 ;
TRP ;Display Transaction Profile
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,D0,RCI,RCY,PRCA,PRCABN,PRCAEN,PRCAIO,SEL,X,Y
 W ! S DIR("A")="Do you want to see a Transaction Profile ",RCOUT=0
 S DIR("?")="Enter Yes if you want to see a Transaction Profile "
 D ASK^RCRCACP
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G TRPQ
 I $G(Y)'=1 G TRPQ
 ;
 K DIR W ! S DIR("?")="Enter the list number(s) of the transactions"
 S DIR(0)="LO^1:"_CNT,DIR("A")="Select Item #(s) to View Transaction Profile " D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G TRPQ
 I 'Y G TRPQ
 S RCY=Y,PRCAIO=IO,PRCAIO(0)=IO(0)
 F RCI=1:1:255 S SEL=$P(RCY,",",RCI) Q:('SEL)!(X["^")  S D0=PRCAT(SEL) D
 .W @IOF S X="",$P(X,"=",30)="" W !,X," TRANSACTION PROFILE ",X,!!
 .K DXS D ^PRCATR3 K DXS S X=D0 D ENF^IBOLK
 .R !!,"PRESS <RETURN> TO CONTINUE: ",X:DTIME Q:X["^"
 ;
 S DIR("A")="Do you want to view list again ",RCST=0
 S DIR("?")="Enter yes to see the list of Transactions again"
 D ASK^RCRCACP I $G(Y)=1 S RCST=1 W @IOF
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S RCOUT=1 G TRPQ
TRPQ Q
 ;
SET ;Set the global to send AR Transaction via mail
 ;Also called from RCRCRT
 ;Input: PRCABN,PRCAEN,RCXCNT,PRCA("BNAME"),PRCA("DEBTNM")
 ;Return: TMP("RCRCAT",$J,"XM",PRCABN,PRCAEN,RCXCNT)="DATA"
 ; 
 N CT,DA,DIC,DIQ,DR,PRCAEN1,RC,RCFL,RCLN,RCLN2,RCTR,X,Y
 S DA=PRCAEN,DR=".01:90",DIC="^PRCA(433,",DIQ="RCTR",DIQ(0)="EN" D EN^DIQ1
 S PRCAEN1=$G(^PRCA(433,+$G(PRCAEN),1))
 I ('PRCAEN1)!('$O(RCTR(0))) G SETQ
 S CT=+$G(RCXCNT)
 S CT=CT+1,RC(CT)="BN1^"_PRCA("BNAME")_U_PRCA("DEBTNM")
 S CT=CT+1,RC(CT)="TR1^"_PRCAEN_U_$P(PRCAEN1,U,9)
 S CT=CT+1,RC(CT)="     <TRANSACTION INFORMATION>"
 S CT=CT+1,RC(CT)="BILL #: "_PRCA("BNAME")_"   DEBTOR: "_PRCA("DEBTNM")
 S CT=CT+1,RC(CT)="TYPE: "_$G(RCTR(433,PRCAEN,12,"E"),"UNK")_"   TRAN. NO.: "_$G(RCTR(433,PRCAEN,.01,"E"))
 S CT=CT+1,RC(CT)="DATE: "_$G(RCTR(433,PRCAEN,11,"E"))_"   AMOUNT: $"_$J($G(RCTR(433,PRCAEN,15,"E")),2)
 S CT=CT+1,RC(CT)="STATUS: "_$G(RCTR(433,PRCAEN,4,"E"))_"   CREATED: "_$G(RCTR(433,PRCAEN,19,"E"))
 S CT=CT+1,RC(CT)="     <OTHER TRANSACTION INFORMATION>"
 F X=.01,.03,3,4,5,6,8,10,11,12,14,15,19 K RCTR(433,PRCAEN,X)
 S RCFL=0,RCLN2="" F  S RCFL=$O(RCTR(433,PRCAEN,RCFL)) Q:'RCFL  D
 .I (RCFL=41)!(RCFL=5.02)!(RCFL=5.03) S Y="COM" Q
 .S RCLN=$$GET1^DID(433,RCFL,"","LABEL")_": "_RCTR(433,PRCAEN,RCFL,"E")_"   "
 .I ($L(RCLN)+$L(RCLN2)+3)>80 S CT=CT+1,RC(CT)=RCLN2,RCLN2=RCLN Q
 .S RCLN2=RCLN2_RCLN
 I 'RCFL,RCLN2]"" S CT=CT+1,RC(CT)=RCLN2
 I $G(Y)="COM" D
 .S CT=CT+1,RC(CT)="     <TRANSACTION COMMENT INFORMATION>"
 .S CT=CT+1,RC(CT)="BRIEF COMMENT: "_$G(RCTR(433,PRCAEN,5.02,"E"),"None")
 .S CT=CT+1,RC(CT)="FOLLOW-UP DATE: "_$G(RCTR(433,PRCAEN,5.03,"E"),"None")
 .S CT=CT+1,RC(CT)="COMMENT: "
 .S X=0 F  S X=$O(RCTR(433,PRCAEN,41,X)) Q:'X  D
 ..S CT=CT+1,RC(CT)=RCTR(433,PRCAEN,41,X)
 S RCXCNT=CT
 M ^TMP("RCRCAT",$J,"XM",PRCABN,PRCAEN)=RC
SETQ Q
 ;
HD ;Write Heading
 N I,Y
 W @IOF,!,PRCA("DEBTNM"),!,PRCA("DEBTAD1")
 W:$G(PRCA("DEBTAD2"))]"" !,PRCA("DEBTAD2")
 W !,PRCA("DEBTCT"),", ",PRCA("DEBTST"),"  ",PRCA("DEBTZIP")
 W !,"Phone #: ",$P(PRCA("DEBTADD"),U,7)
 W !!,"Bill #: ",PRCA("BNAME")
 S Y=$P(RCREF,U,1) I Y D D^DIQ
 W:+RCREF ?30,"Referred to ",$P(RCREF,U,2)," on ",Y," for $",$P(RCREF,U,3)
 W !!,"Item",?8,"TR #",?17,"Tran. Type",?52,"Date",?68,"Amount"
 W ! F I=1:1:(IOM-1) W "="
HDQ Q
 ;RCRCAT1
