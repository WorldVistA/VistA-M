PRCPRPIQ ;WISC/RFJ-print picking ticket end of report               ;07 Feb 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
END ;  come here to print at bottom of picking ticket
 N TEXT,X,Y
 S Y=$P($G(^PRCS(410,+TRANDA,3)),"^",2)
 S DATA(1)="SPECIAL INSTRUCTIONS/COMMENTS:",TEXT=2
 F X=1:1 Q:'$D(^PRCS(410,TRANDA,"RM",X,0))  S DATA(TEXT)=^(0),TEXT=TEXT+1
 F X=1:1 Q:'$D(^PRCS(410,TRANDA,"CO",X,0))  S DATA(TEXT)=^(0),TEXT=TEXT+1
 F X=1:1 S DATA=$P($T(DATA+X),";",3,99) Q:DATA=""  S:DATA["xxxx" DATA=$TR(DATA,"x")_Y S DATA(TEXT)=DATA,TEXT=TEXT+1
 I $Y>(IOSL-TEXT) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H^PRCPRPIR
 W !!,"TOTAL DOLLAR AMOUNT OF TRANSACTION: ",$J(TOTAL,0,2)
 W !!,"INVENTORY AMOUNT OF TRANSACTION (BY ACCOUNT CODE):",! S X="" F %=1:1 S X=$O(ACCT(X)) Q:X=""  W ?((%-1)*20),X," : ",$J(ACCT(X),0,2) I %=4 S %=0 W !
 I $Y>(IOSL-TEXT-1) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H^PRCPRPIR
 W ! S %=0 F  S %=$O(DATA(%)) Q:'%  W !,DATA(%)
 I '$D(PRCPFLAG) D END^PRCPUREP
 Q
 ;
 ;
DATA ;;  print signature at bottom of report
 ;;FUND CERTIFICATION--- THE SUPPLIES LISTED ON THIS REQUEST ARE PROPERLY
 ;;CHARGEABLE TO THE FOLLOWING ALLOTMENTS, THE AVAILABLE BALANCES OF WHICH
 ;;ARE SUFFICIENT TO COVER COST THEREOF, AND FUNDS HAVE BEEN OBLIGATED.
 ;; 
 ;;APPROPRIATION AND ACCOUNTING SYMBOLS: xxxx
 ;; 
 ;;OBLIGATED BY:______________________________            DATE:___________________
 ;; 
 ;;SERVICE SIGNATURE:_________________________            PULLED BY:_______________
 ;; 
 ;;            TITLE:_________________________          VERIFIED BY:_______________
 ;; 
 ;;    DATE RECEIVED:_________________________   DATE TO DELIVER ON:_______________
