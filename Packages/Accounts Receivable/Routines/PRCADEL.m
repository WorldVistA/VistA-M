PRCADEL ;SF-ISC/YJK-PRINT DELINQUENT REPORTS ;6/8/93  1:59 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;THIS PRINTS THE DELINQUENT ACCOUNTS IN A/R FILE
EN1 ;This prints Delinquent accounts between 31 and 90 days
 S PRCAFT="31",PRCALAST="90" D DIP Q
EN2 ;This prints Delinquent accounts between 91 and 180 days
 S PRCAFT="91",PRCALAST="180" D DIP Q
EN3 ;This prints Delinquent accounts between 181 and 365 days
 S PRCAFT="181",PRCALAST="365" D DIP Q
EN4 ;This prints Delinquent accounts more than 365 days
 S PRCAFT="366",PRCALAST="",PRCAHDR="OVER 365 DAYS DELINQUENT ACCOUNTS RECEIVABLE" D DIP1 Q
EN5 ;This prints all Delinquent accounts
 S PRCAFT="31",PRCALAST="",PRCAHDR="ALL DELINQUENT ACCOUNTS RECEIVABLE" D DIP1 Q
DIP S PRCAHDR=PRCAFT_" - "_PRCALAST_" DAYS DELINQUENT ACCOUNTS RECEIVABLE"
DIP1 W !!,"Select a Category range to print.",!
 S FR="102,?,"_PRCAFT_",",TO="102,?,"_PRCALAST_",",DHD=PRCAHDR
SET S L=0,DIC="^PRCA(430,",BY="@CURRENT STATUS:STATUS NUMBER,+CATEGORY;S2,DELINQUENT DAYS,BILL NO.",FLDS="[PRCAD DELINQ]" D EN1^DIP
END K PRCA,PRCAHDR,PRCAFT,PRCALAST,DIC,DHD,BY,FR,TO,L,FLDS Q
ACT(Y) ;Return date of last activity
 NEW BN0,X,Z,LST
 I $G(Y)="" S Y=-1 G ACTQ
 S BN0=$G(^PRCA(430,Y,0)) I BN0']"" S Y=-1 G ACTQ
 I "^220^102^110^104^112^107^113^240^230^205^"'[("^"_$P($G(^PRCA(430.3,+$P(BN0,"^",8),0)),"^",3)_"^") S Y=-1 G ACTQ
 S Z=0 F X=0:0 S X=$O(^PRCA(433,"C",Y,X)) Q:'X  I $P($G(^PRCA(433,X,1)),"^",2)'=$O(^PRCA(430.3,"AC",13,0)) S Z=$S(+$P($G(^PRCA(433,X,1)),"^",9):$P(^(1),"^",9),1:+$G(^PRCA(433,X,1)))
 S LST(9999999-Z)=""
 S Z=$G(^PRCA(430,Y,6)) F X=3:-1:1 I $P(Z,"^",X) S LST(9999999-$P(Z,"^",X))="" Q
 S LST(9999999-$P(BN0,U,10))="",LST(9999999-$P(BN0,"^",14))=""
 S Z=9999999-$O(LST(0)) S:'Z Z=2910101
 S Y=Z
ACTQ Q $P(Y,".")
LAST ;Print last activity
 NEW DIC,FLDS,FR,TO,L,%DT,END
 S %DT("A")="Show Outstanding Bills with 'Last Activty' Before: ",%DT="EA" D ^%DT G:Y<0 Q1 S END=X_"^"_Y
 S X1=DT,X2=Y D ^%DTC I X<180 W *7,!!,"WARNING: You picked a date less than 180 days ago!",!
 S DHD="Report of AR Last Activity before "_$$SLH^RCFN01($P(END,"^",2)),DIC="^PRCA(430,",FR="?,T-10000",TO="?,"_$P(END,"^"),L=0,(BY,FLDS)="[PRCA LAST ACTIVITY]" D EN1^DIP
Q1 Q
