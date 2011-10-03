PRCPUTRS ;WISC/RFJ-transaction history file selection               ;07 Jul 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SELECT(PRCPINPT)   ;  select transaction register entry for inventory point
 N DA,PIECES,PRCPFLAG,X,Y
 D INFOHELP
 ;
 F  D  Q:$G(PRCPFLAG)
 .   W !,"Select TRANSACTION REGISTER entry: "
 .   R X:DTIME S:'$T X="^" I X["^" S X="^",PRCPFLAG=1 Q
 .   I X="" S PRCPFLAG=1 Q
 .   I X["?" D HELP(""),INFOHELP Q
 .   S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .   ;  lookup by trans id
 .   I "RUACSPE"[$E(X),$D(^PRCP(445.2,"T",PRCPINPT,X)) S DA=$$SHOW("^PRCP(445.2,""T"","_PRCPINPT_","""_X_""",") S:DA PRCPFLAG=1 Q
 .   I $E($O(^PRCP(445.2,"T",PRCPINPT,X)))=$E(X) D HELP(X),INFOHELP Q
 .   ;
 .   ;  lookup by voucher number
 .   I $D(^PRCP(445.2,"V",X)) S DA=$$SHOW("^PRCP(445.2,""V"","""_X_""",") S:DA PRCPFLAG=1 Q
 .   ;
 .   ;  lookup by transaction number
 .   S PIECES=$L(X,"-")
 .   I $L($P(X,"-",PIECES))=4 D
 .   .   I PIECES=5 Q
 .   .   I PIECES=4 S X=PRC("SITE")_"-"_X
 .   .   I PIECES=3 S X=PRC("SITE")_"-"_PRC("FY")_"-"_X Q
 .   .   I PIECES=2 S X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_X
 .   I $L(X,"-")=1 S X=PRC("SITE")_"-"_X
 .   I $D(^PRCP(445.2,"C",X)) S DA=$$SHOW("^PRCP(445.2,""C"","""_X_""",") S:DA PRCPFLAG=1 Q
 .   W ?65,"invalid entry"
 S X=$G(^PRCP(445.2,+$G(DA),0))
 I X'="" S Y=$P(X,"^",3) W !,"selected: ",$P(X,"^",2),?20,$P(X,"^",19),?40,$P(X,"^",15),?50,$E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3),?60,"IM#",$P(X,"^",5),?70,$E($$DESCR^PRCPUX1(PRCPINPT,+$P(X,"^",5)),1,9)
 Q +$G(DA)
 ;
 ;
SHOW(GLOBAL) ;  present list of matches to user
 N DA,DATA,ENDLINE,LINE,PRCPFLAG,SELECTDA,STARTLIN,Y
 K ^TMP($J,"PRCPUTRS")
 S LINE=0,DA=0
 F  D  Q:$G(PRCPFLAG)
 .   S STARTLIN=LINE+1 F  S DA=$O(@(GLOBAL_DA_")")) Q:'DA  I $P($G(^PRCP(445.2,DA,0)),"^")=PRCPINPT S LINE=LINE+1,^TMP($J,"PRCPUTRS",LINE)=DA Q:LINE#15=0
 .   I '$D(^TMP($J,"PRCPUTRS",STARTLIN)) S PRCPFLAG=1 Q
 .   ;  one entry only
 .   I LINE=1 S SELECTDA=^TMP($J,"PRCPUTRS",1),PRCPFLAG=1 Q
 .   ;
 .   W !!?2,"ENTRY",?10,"TRANID",?20,"TRANSACTION",?40,"VOUCHER",?50,"DATE",?60,"ITEM"
 .   F ENDLINE=STARTLIN:1 Q:'$D(^TMP($J,"PRCPUTRS",ENDLINE))  S DATA=$G(^PRCP(445.2,+^TMP($J,"PRCPUTRS",ENDLINE),0)) I DATA'="" D
 .   .   S Y=$P(DATA,"^",3)
 .   .   W !?2,ENDLINE,?10,$P(DATA,"^",2),?20,$P(DATA,"^",19),?40,$P(DATA,"^",15),?50,$E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3),?60,"IM#",$P(DATA,"^",5),?70,$E($$DESCR^PRCPUX1(PRCPINPT,+$P(DATA,"^",5)),1,9)
 .   I 'DA W !?2,"--- end of list ---"
 .   ;
 .   W !!,"Select an ENTRY from the list (from 1 to ",ENDLINE-1,"): "
 .   R X:DTIME I '$T!(X["^") S PRCPFLAG=1 Q
 .   I $D(^TMP($J,"PRCPUTRS",+X)) S SELECTDA=^(+X),PRCPFLAG=1 Q
 .   ;
 .   ;  entire list displayed
 .   I 'DA S PRCPFLAG=1
 K ^TMP($J,"PRCPUTRS")
 Q +$G(SELECTDA)
 ;
 ;
INFOHELP ;  display info help text
 N HELP
 S HELP(1)="You may lookup entries in the TRANSACTION REGISTER file by selecting:    A) the transaction register id (A123 or RC456, etc);  B) the transaction number which is the 2237, issue book, or purchase order number"
 S HELP(2)="(460-94-2-120-0010 or 120-0010 if its the same quarter and year or purchase order G12345);  C) the voucher number (I400001)."
 W ! D DISPLAY^PRCPUX2(2,76,.HELP)
 Q
 ;
 ;
HELP(Y) ;  display help (if Y="" ask start with)
 N DATA,DIR,LINE,PRCPFLAG,TRANID,X
 I Y="" D  I Y'="A",Y'="R",Y'="RC",Y'="C",Y'="U",Y'="P",Y'="S",Y'="E" Q
 .   S DIR(0)="S0^A:adjustment;RC:receipt;R:distribution regular;C:distribution call-in;E:distribution emergency;U:usage;P:physical count;S:case cart/instrument kit assembly or disassembly;"
 .   S DIR("A")="  Start HELP with entry type",DIR("B")="adjustment"
 .   D ^DIR
 ;
 ;  show tranid entries
 S TRANID=Y F LINE=1:1 S TRANID=$O(^PRCP(445.2,"T",PRCPINPT,TRANID)) Q:TRANID=""  D  I LINE#15=0 D P^PRCPUREP Q:$G(PRCPFLAG)
 .   S DATA=$G(^PRCP(445.2,+$O(^PRCP(445.2,"T",PRCPINPT,TRANID,0)),0)),Y=$P(DATA,"^",3)
 .   W !?2,"tranid:",?10,$P(DATA,"^",2),?20,$P(DATA,"^",19),?40,$P(DATA,"^",15),?50,$E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3)
 Q
