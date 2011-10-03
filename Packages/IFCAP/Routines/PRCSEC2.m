PRCSEC2 ;WISC/DJM-CONTINUATION OF PRCSEC ;4/30/93  3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
CAP(XX) ;FIND OUT NUMBER OF REQUESTS TO APPROVE FOR SUPPLY FUND, TOTAL AMOUNT OF OF REQUESTS, AND CHECK FOR SUFFICIENT $S TO PURCHASE.  INFORM USER OF RESULTS.
 N AA,AB,AC,X1
 N AMT,CT,KS,S,VAR,X,XDA S (CT,AMT,XX)=0,S="-",KS=PRC("SITE")_S_+PRC("CP")_"-0",VAR=$P(KS,S,1,2),SPCP=$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),U,12),SPCP=$S(SPCP=2:1,1:0) Q:'SPCP
 F  S KS=$O(^PRCS(410,"F",VAR_S_$P(KS,S,3))) Q:$P(VAR,S,1,2)'=$P(KS,S,1,2)!(KS="")  S XDA=$O(^PRCS(410,"F",KS,0)) Q:XDA'>0  I $D(^PRCS(410,XDA,0)) D
 .I $D(^PRCS(410,XDA,7)),$P(^(7),U,6)]"" Q
 .I $S('$D(^PRCS(410,XDA,11)):1,'$P(^(11),U,3):1,1:0) Q
 .S X=$P($P(^PRCS(410,XDA,0),U),S,4,5) I +$P(X,S)'=$P(KS,S,2)!($P(X,S,2)'=$P(KS,S,3)) Q
 .S CT=CT+1,AB="PRCSRQ"_"("_CT_")",@AB=XDA I $D(^PRCS(410,XDA,4)) S AC=$S(+$P(^(4),U):$P(^(4),U),$P(^(0),U,2)="A"&($P(^(0),U,4)=1):$P(^(4),U,6),1:0),$P(@AB,U,2)=AC,AMT=AMT+AC
 .Q
 S AA=$P(^PRC(420,PRC("SITE"),0),U,6)
 I AA'>0 W !!,"There are no funds available to approve requests at this time.",!,"Please try later." S XX=2 Q
 W !!,"You have "_CT_" request"_$S(CT:"s",1:"")_" to be approved for SUPPLY FUND.  Estimated $: "_$J(AMT,9,2)_"." S XX=$S(AA-AMT<0:1,1:0)
 W !,"You "_$S(XX:"don't ",1:"")_"have sufficient funds to order "_$S(CT>1:"all ",1:"")_"the request"_$S(CT>1:"s.",1:"."),! Q:'XX
 W !,?5,"The TOTAL dollar CAP available is $"_$J(AA,9,2)_".",!
 W !,?5,"TRANSACTION",?30,"$ AMOUNT TO APPROVE" F X=1:1:CT S X1="PRCSRQ"_"("_X_")" W !,?5,$P(^PRCS(410,$P(@X1,U),0),U),?30,"$"_$J($P(@X1,U,2),9,2)
 W ! Q
OK ;THIS IS WHERE THE SUPPLY FUND CAP INFORMATION IS UPDATED.  THE CONTROL POINT OFFICIAL HAS APPROVED THE TRANSACTION AND THERE ARE SUFFICIENT FUNDS TO PURCHASE THE ITEMS DESIRED.
 Q:'SPCP  N X S PRC("SITE")=$G(PRC("SITE")) D:PRC("SITE")="" STA^PRCSUT D:PRC("SITE")="" W2,W3 Q:PRC("SITE")=""  S X=$G(^PRC(420,PRC("SITE"),0)) D:X="" W1,W3 Q:X=""  S X=$P(X,U,5)+PRCST
 S PRCST1="^"_X D ENTERCAP^PRCFWCAP(PRCST1) I $D(ERROR) D W1,W3 K ERROR
 Q
W1 W !!,"AN ERROR HAS OCCURRED." Q
W2 W !!,"YOUR SITE IS UNDEFINED." Q
W3 W "  PLEASE CONTACT YOUR APPLICATIONS COORDINATOR",!,"TO RESOLVE THIS PROBLEM." Q
PRCB ;The option PRCB CAP EDIT uses this entry point to enter or edit the SUPPLY FUND CAP.
 W !!
 N MESSAGE S MESSAGE=""
 D ESIG^PRCUESIG(DUZ,.MESSAGE)
 I (MESSAGE=0)!(MESSAGE=-3) W !!!,?15,"SIGNATURE CODE FAILURE" Q
 I (MESSAGE=-1)!(MESSAGE=-2) Q
 W !
 N DA,DIE,DR,DATA I $G(PRC("SITE"))="" D STA^PRCSUT I PRC("SITE")="" D W2,W3 Q
 S DA=PRC("SITE"),DIE="^PRC(420,",DR="4R" D ^DIE S DATA=$P(^PRC(420,PRC("SITE"),0),U,4) D ENTERCAP^PRCFWCAP(DATA) I $D(ERROR) D W1,W3 K ERROR Q
 W !!!,?7,"The Supply Fund Cap for your Station is now:  $",$FN(+$P($G(^PRC(420,+DA,0)),"^",3),",",2)
 Q
