PRCFAC01 ;WISC@ALTOONA/CTB-CONTINUATION OF OBLIGATION PROCESSING ;7/21/93  13:51
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;DISPLAY CONTROL POINT OFFICIALS BALANCES
 W !!,"Net Cost of Order: ",?30,"$",$J($P(PO(0),U,16),10,2) D CPBAL I $D(PRCF("NOBAL")) K PRCF("NOBAL") G V1
V1 I $P(PRC("PARAM"),"^",17)="Y" W !!?15,"Fiscal Status of Funds for Control Point" W !,"Status of Funds Balance: ",?30,"$",$J($P(^PRC(420,PRC("SITE"),1,+$P(PO(0),U,3),0),U,7),10,2),!,"Estimated Balance:",?30,"$",$J($P(^(0),U,8),10,2)
 W ! S %A="OK to Continue" S %=1,%B="" D ^PRCFYN I %'=1 D MSG G OUT3
 ;IF CP IS GENERAL POST FUND OR SUPPLY FUND, NO CODE SHEET IS GENERATED
 G:+$P(PCP,"^",2)>0 NC
 S P("DELDATE")=$P(PO(0),U,10),P("PODATE")=DT,PRCFA("SYS")="",PRCFA("REF")=$P($P(PO(0),"-",2),"^") I $P(^PRC(442,PRCFA("PODA"),1),"^",15)'="" S P("PODATE")=$P(^(1),"^",15)
 S Y=P("PODATE") D D^PRCFQ S %DT="AEX",%DT("A")="Select Obligation Processing Date: ",%DT("B")=Y
 W ! D ^%DT I Y<0 D MSG G OUT3
 S PDATE=Y
 S PRCFA("TTDATE")=$E(PDATE,4,7)_$E(PDATE,2,3),PRCFA("TT")="921.00" K PDATE D TT^PRCFAC I '% D MSG G OUT3
 D NEWCS^PRCFAC I '$D(DA) D MSG G OUT3
 S PRC("CP")=+$P(PO(0),"^",3) D ^PRCFALD
 S PRCFA("SC")="" Q:'$D(^PRC(442,+PO,1))  S PRCFA("SC")=$S($D(^PRC(440,$P(^PRC(442,+PO,1),U,1),2)):$P(^(2),U,4),1:"")
 I PRCFA("SC")="",$P(^PRC(442,PRCFA("PODA"),1),"^",7)'="" S PRCFA("SC")=$P(^PRCD(420.8,$P(^PRC(442,PRCFA("PODA"),1),"^",7),0),"^",3)
 S X1=$P(PO(0),U,5),X=$S(X1="":"",$L(X1)>4:X1,1:X1_"00") K X1
 S ^PRCF(423,DA,1)=PRCFA("YALD")_U_$E(P("DELDATE"),4,5)_U_PRCFA("SC")_U_$E(P("DELDATE"),4,7)_$E(P("DELDATE"),2,3)_U_$P($P(PO(0),U,3)," ",1)_U_X_U_U_$P(PO(0),U,6)_U_($P(PO(0),U,7)*100)
 S $P(^PRCF(423,DA,1),"^",10)=$S(+$P(PO(0),U,8)>0:$P(PO(0),U,8),1:"$"),$P(^(1),U,11)=$S(+$P(PO(0),U,9)>0:$P(PO(0),U,9)*100,1:""),$P(^(1),"^",16)="$",$P(^("TRANS"),"^")=""
 I PRCFA("EDIT")["921.00" D ^PRCFA921 G XM
 S PRCFA("EDIT")=$P(^PRCD(420.4,PRCFA("TTDA"),0),U,3),Y(0)=^(0),^PRCF(423,DA,0)=$P(^PRCF(423,DA,0),U,1,2)_U_$P(Y(0),U,3)_U_$P(Y(0),U,1)_U_$P(^(0),U,5,99) K Y
 S DIE="^PRCF(423,",DR=PRCFA("EDIT"),PRCFA("CSDA")=DA D ^DIE I $D(Y)'=0 D WAIT^PRCFYN,DEL,OUT3 G ^PRCFAC0
XM D ^PRCFACXM I $D(PRCFDEL)!$D(PRCFA("CSHOLD")) K PRCFDEL,PRCFA("CSHOLD") D MSG G ^PRCFAC0
 S PRCOPODA=PRCFA("PODA") D WAIT^DICD,NEW^PRCOEDI
 K PRCOPODA,IO("Q")
NC I $D(PRCFA("PODA")) D ^PRCFAC02
 D OUT3 G ^PRCFAC0
OUT3 K %,AMT,C1,C,CSDA,D0,DA,DI,DIC,DEL,E,I,J,K,N1,N2,PCP,PO,PODA,PRCFA,PRCQ,PTYPE,T,T1,TIME,TRDA,Y,Z,Z5,ZX Q
MSG S X="  No Further Processing is being taken on this obligation.*" D MSG^PRCFQ Q
 Q
SA ;LOOKUP FOR INVALID BOC
 S %A="Invalid BOC number, OK to use anyway",%B="Answer 'NO' if you do yot wish to use this BOC."
 S %=2 D ^PRCFYN I %'=1 K X Q
 S X=ZC K ZC Q
DEL ;KILL THE CODE SHEET AND CROSS REFERENCES
 D DEL^PRCFACXM Q
OUT W !,"No data posted to Control Point Files",$C(7) R X:3 Q
 Q
CPBAL S:'$D(PQT) PQT=PRC("QTR") S X=$G(^PRC(420,PRC("SITE"),1,+PCP,4,PRC("FY"),0))
 I X="" S X="No Control Point balances available at this time.*" D MSG^PRCFQ S PRCF("NOBAL")="" Q
 S PRCS("C")=$P(X,"^",PQT+1),PRCS("O")=$P(X,"^",PQT+5)
 W !!?15,"CPA Balances",!,"Uncommitted Balance: ",?30,"$"_$J(PRCS("C"),10,2),!,"Unobligated Balance: ",?30,"$"_$J(PRCS("O"),10,2) W !,"Committed, Not Obligated: ",?30,"$"_$J((PRCS("O")-PRCS("C")),10,2) K PRCS
 Q
