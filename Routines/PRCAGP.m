PRCAGP ;WASH-ISC@ALTOONA,PA/CMS-Print Patient Statement/Letter ;6/19/96  5:07 PM
V ;;4.5;Accounts Receivable;**34**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
PRDT ;ENTRY FROM PRDT^PRCAG
 I $P(^RC(342,1,0),"^",10)<DT W *7,!!,"OPTION OUT OF ORDER!",!!,"WARNING!! The AR Package was last updated on: ",$$SLH^RCFN01($P(^RC(342,1,0),"^",10)),!,"*** Contact IRM Service!",! H 5 Q
 NEW DEB,DIC,HDAT,IOP,X,Y,ZTDESC,ZTRTN,ZTSAVE,%DT
PR W !!,"Enter a date to print the Follow-up Letters",!
 S %DT="AEXP",%DT(0)="-NOW",%DT("A")="Enter a Date to Print: " D ^%DT I Y<1 G PRDTQ
 S HDAT=Y
 ;W !!,"Follow-up Letters for the date selected"
 ;W !,"to print their statement only.",!!
 ;S DIC="^RCD(340,",DIC(0)="AEMNQ",DIC("A")="Select Patient: ",DIC("S")="I $P(^(0),U,1)[""DPT""" D ^DIC I ('$T)!(X["^") G PRDTQ
 S REP=1 ;,DEB=$S(X=""&(Y<1):X,1:Y)
 ;I Y>0,+$E(HDAT,6,7)'=$$PST^RCAMFN01($P(Y,U,2)) W !,"Patient Statement Day is not on date selected!",! G PR
 ;I Y>0,+$$LST^RCFN01(+Y,2)'<HDAT W !,"Patient Statement Printed!" G PR
 ;S DEB=+DEB
PRDTD W !! S %ZIS("B")=$P($G(^RC(342,1,0)),U,8),%ZIS="NQ",IOP="Q" D ^%ZIS G:POP PRDTQ
 I '$D(IO("Q")) W !!,*7,"YOU MUST QUEUE THIS OUTPUT",! G PRDTD
 S ZTRTN="EN^PRCAGS",ZTDESC="Letters",ZTSAVE("DEB")="",ZTSAVE("REP")="",ZTSAVE("HDAT")="" D ^%ZTLOAD
PRDTQ D ^%ZISC Q
