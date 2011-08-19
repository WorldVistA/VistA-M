PRCNSTAT ;SSI/SEB-Request Status Report ;[ 09/13/96  4:12 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
USR ;  Review a requestor's transactions
 S BY=.01,DIS(0)="I $P(^PRCN(413,D0,0),U,2)=DUZ",WHO="requestor"
 D PRT Q
CMR ;  Review a CMR Official's transactions
 S BY="4.5,.01",DIS(0)="I $P(^PRCN(413,D0,0),U,6)=DUZ",WHO="CMR Official"
 D PRT Q
PPM ;  Print for PPM all transactions
 S BY=".01",WHO="PPM: "
 S DIS(0)="I $P(^PRCN(413,D0,0),U,7)'<6!($P(^(0),U,7)=20)"
 D PRT Q
PRT S DHD="W ?0 D HDR^PRCNSTAT",L="",DIC="^PRCN(413,",FLDS="[PRCNSTAT]"
 S (FR,TO)=""
 D EN1^DIP
 K WHO,DIS,DHD,L,DIC,FLDS,BY,FR,TO,I
 Q
HDR ; Prints a header for the Status Report
 W !,"Equipment Request Status Report by ",WHO," ",$P(^VA(200,DUZ,0),U)
 W !?61,"Date       Status"
 W !,"Transaction #",?18,"Description",?39,"Status",?61
 W "Entered    Date",! F I=1:1:79 W "-"
 Q
