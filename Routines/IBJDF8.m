IBJDF8 ;ALB/RRG - AR PRODUCTIVITY REPORT ;29-AUG-00
 ;;2.0;INTEGRATED BILLING;**123,159,192**;21-MAR-94
 ;
EN ; - Option entry point.
 S (IBPNI,IBTDATE,IBFDATE,IBT,IBF,IBSPT,IBRPT,IBSEL,IBCLERK)=""
 ;
TDATE ; - Determine date range of transactions.
 ; 
 S DIR(0)="DA^:DT:EX"
 S DIR("A")="FROM Transaction Date: "
 S DIR("T")=300,DIR("L")=""
 S (DIR("?"),DIR("??"))="^S IBOFF=1 D HELP^IBJDF8H"
 W ! D ^DIR K DIR G:Y=""!(X="^") ENQ
 S IBFDATE=Y,IBF=Y(0)
 ;
 S DIR(0)="DA^"_IBFDATE_":DT:EX"
 S DIR("A")="  TO Transaction Date: "
 S DIR("T")=300,DIR("L")=""
 S (DIR("?"),DIR("??"))="^S IBOFF=11 D HELP^IBJDF8H"
 W ! D ^DIR K DIR G:Y=""!(X="^") ENQ
 S IBTDATE=Y,IBT=Y(0)
 ;
CLERK ; - Get All/Specific Clerks
 D ALSP^IBJD("Clerks^Clerk","^IBE(351.73,",.IBCLERK)
 I IBCLERK["^" G ENQ
 ;
TYPE ; - Determine type of report -Detail or Summary.
 ;
 D DS^IBJD G ENQ:IBRPT["^",SUMM:IBRPT="S"
 ;
DETOPT ; - Detail print options.
 ;
 ; - Determine if Clerk name or Clerk identifier should print
 W ! S IBPNI=""
 S DIR(0)="SA^N:NAME;I:IDENTIFIER;",DIR("T")=DTIME
 S DIR("A")="Do you wish to print with Clerk (N)ame or (I)dentifier? "
 S DIR("?")="^S IBOFF=21 D HELP^IBJDF8H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBPNI=Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 K IBOPT F X=1:1:14 S IBOPT(X)=$$CAT(X)
 S IBPRT="Choose transaction type(s) to print: "
 S IBSEL=$$MLTP^IBJD(IBPRT,.IBOPT,1) I 'IBSEL G ENQ
 S IBSEL=","_IBSEL
 ;
 ; - Assign Tran types from 430.3 to user-selected transaction types
 S IBTT="" D
 . I IBSEL=",1,2,3,4,5,6,7,8,9,10,11,12,13," S IBTT="ALL" Q
 . F I=2:1 S II=$P(IBSEL,",",I) Q:'II  D
 . . S IBTT=$S(IBTT'="":IBTT_$$CATT(II)_"|",1:"|"_$$CATT(II)_"|")
 ;
SUMM ; - Summary print options
 ;
 W ! S DIR(0)="Y",DIR("B")="YES",DIR("T")=DTIME
 S DIR("A")="Do you want to print the summary by Clerk"
 S DIR("?")="^S IBOFF=27 D HELP^IBJDF8H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSPT=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 I IBSPT=1 D
 . Q:IBPNI'=""
 . S DIR(0)="SA^N:NAME;I:IDENTIFIER;",DIR("T")=DTIME
 . S DIR("A")="Do you wish to print with Clerk (N)ame or (I)dentifier? "
 . S DIR("?")="^S IBOFF=21 D HELP^IBJDF8H"
 . D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 . S IBPNI=Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ;
DEV ; - Select a device.
 W !!,"This report requires a ",$S(IBRPT="S":80,1:132)," column printer."
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDF8",ZTDESC="IB - AR PRODUCTIVITY REPORT"
 .S ZTSAVE("IB*")="" D ^%ZTLOAD
 .I $G(ZTSK) W !!,"This job has been queued. The task no. is ",ZTSK,"."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ D ST^IBJDF81 ;                   Compile and print the report.
 ;
ENQ K DIROUT,DTOUT,DUOUT,DIRUT,I
 K IBOFF,IBSNA,IBPLN,IBRPT,POP,X,ZTDESC,ZTRTN,ZTSAVE,Y,%ZIS,IBSPT,IBPNI
 K IBSEL,IBTT,II,IBF,IBT,IBFDATE,IBTDATE,IBCLERK,IBPRT,IBOPT
 Q
 ;
CAT(X) ; - Return transaction type
 Q $S(X]"":$P($T(CAT1+X),";;",2),1:"")
 ;
CATT(X) ; - Return transaction type from 430.3 for user-selected transaction type
 Q $S(X]"":$P($T(CAT1+X),";;",3),1:"")
 ;
CAT1 ; - Transaction types
 ;;COMMENT;;45
 ;;AUDIT;;0
 ;;PAYMENT;;2|34
 ;;REFUND;;41
 ;;DEC.ADJ./CONTR;;35
 ;;DEC.ADJ./NON-CONTR;;35
 ;;WRITE-OFF;;23|8
 ;;WAIVED;;10|11
 ;;SUSPENDED;;40
 ;;COMPROMISED;;9|29
 ;;REPAYMENT PLAN;;25
 ;;EXEMPTION;;14
 ;;OTHER;;1|3|4|5|6|7|12|13|15|16|17|18|19|20|21|22|24|26|27|28|30|31|32|33|36|37|38|39|42|43|44|46|47|48|49
 ;;ALL OF THE ABOVE;;0
 ;
