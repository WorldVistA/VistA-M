PRCSDIC ;WISC/CTB/KMB-INTERCEPT FOR DIC LOOKUP INTO FILE 410 ;3-19-91/17:13
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;INTERCEPT ROUTINE LOOKUP INTO FILE 410
 N I,D,X1,X2 S:$D(X3) D=X3
 K DUOUT,DTOUT S U="^" I $D(D),D'="H",D=+D K D
 S Y=-1 S:'$D(DIC) DIC=410 S:'$D(DIC(0)) DIC(0)="EMQZ"
 F I=1:1 Q:DIC(0)'["A"  S DIC(0)=$P(DIC(0),"A")_$P(DIC(0),"A",2,99) ;STRIP "A" FROM DIC(0) STRING IF NECESSARY
 F I=1:1 Q:DIC(0)'["M"  S DIC(0)=$P(DIC(0),"M")_$P(DIC(0),"M",2,99) ;STRIP "M" FROM DIC(0) STRING IF NECESSARY
 W !,$S($D(DIC("A")):DIC("A"),1:"Select CONTROL POINT ACTIVITY TRANSACTION NUMBER: ") R X:DTIME I '$T!(X="")!($E(X)="^") S Y=-1 Q
 I X=" " D ^DIC Q:+Y>0  G ER
CHECK ;
 I $D(X3),X?1."?" W !,"Please enter number using an alpha character",!,"and 2-16 alphanumerics,as in 'A1234B'",!! G V
 I $D(X3),X'?1."?",X'?1U.UNP W !!,"Incorrect format - please re-enter number",!! G V
 I $E(X)="." S X="The first character may not be a '.'.*" D MSG^PRCFQ G ER
 I "V.v.W.w.P.p.T.t.C.c."[$E(X,1,2) S X1=$P(X,"."),X=$P(X,".",2,99) I X'?1."?" S:$A(X1)>90 X1=$C($A(X1)-32) S X1=$F("VWPTC",X1)-1 S:$D(D)[0 D="" S:X1>0 X2="E^J^D^H^AN",D=$S(D="":$P(X2,"^",X1),1:D_"^"_$P(X2,U,X1)) K X1,X2
 I $D(PRCSID),PRCSID=1,X?4N S D="F1",DIC(0)=DIC(0)_"M" D MIX^DIC1 Q:+Y>0  G ER
 I X'?1."?",$D(D)'[0,D]"",D'["^" D IX^DIC Q:+Y>0  G ER
 I X'?1."?",$D(D)'[0,D]"",D["^" S:DIC(0)'["M" DIC(0)=DIC(0)_"M" D MIX^DIC1 Q:+Y>0  G ER
 I $E(X,1,8)?3N1"-"2N1"-"1N S DIC(0)=DIC(0)_"M" D ^DIC Q:+Y>0  G ER
 I X?3N1"-"2N D STA G ER
 I X?2N1"-"4N S D="B3" D IX^DIC Q:+Y>0  G ER
 I X?4N S D="B2^AN^F1",DIC(0)=DIC(0)_"M" D MIX^DIC1 Q:+Y>0  G ER
 I $D(PRC("SITE")),X=PRC("SITE") D STA G ER
 I $D(PRC("SITE")),X=(PRC("SITE")_"-") D STA G ER
 I $L(X)=1,X'="?" W !! S X="Single Character Lookups have been prohibited." D MSG^PRCFQ R X:3 S X="?"
 I X'?1."?" S:DIC(0)'["M" DIC(0)=DIC(0)_"M" S D="AN^D^E^H^J^I^C" D MIX^DIC1 Q:Y>0  G ER
 I '$D(X3),$D(PRC("SITE")),$D(PRC("FY")),$D(PRC("QTR")),$D(PRC("CP")) S X1=X,X2="(STA # - FY - QTR - FCP)",X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," "),D="B" D X,IX^DIC Q:Y>0  G ER
 I '$D(X3),$D(PRC("SITE")),$D(PRC("FY")),$D(PRC("QTR")) S X1=X,X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR"),D="B",X2="(STA # - FY - QTR)" D X,IX^DIC Q:Y>0  G ER
 I '$D(X3),$D(PRC("CP")) S X1=X,X=$P(PRC("CP")," "),D="AN",X2="(CONTROL POINT)" D X,IX^DIC Q:Y>0  G ER
 I X?1."?" D QM
ER I $D(DTOUT),DTOUT,$S('$D(X1):1,X1'?1."?":1,1:0) G V
 G:X="^" V
 I $D(X3) W !!,"Please enter a number using an alpha character",!,"and 2-16 alphanumerics, as in 'ADP1'.",!
 E  F I=1:1 W ! Q:$P($T(TEXT+I),";",3)="XXX"  W $P($T(TEXT+I),";",3)
 G V
QM W !!,"Attempting lookup in transaction file.",$C(7) Q
X I $D(X1),X1?1."?" D QM
 W !!,"Attempting lookup using "_X_"   "_$S($D(X2):X2,1:""),!
 Q
STA W ! S X="Station number or SN-FY alone are no longer allowed for lookup.*" D MSG^PRCFQ R X:3 S X="?",X1="NO?" G ER
TEXT ;;
 ;;
 ;;Please answer with any of the following:
 ;;
 ;;   TRANSACTION NUMBER - (Station-FY-QTR-Control Point-Sequence Number)
 ;;                           or a fragment of the number.  NOTE:
 ;;                           STATION NUMBER or SN-FY alone are not enough
 ;;PURCHASE ORDER NUMBER - e.g. A01234
 ;;          VENDOR NAME
 ;;     TEMPORARY NUMBER - E.G. ADP1
 ;;      SEQUENCE NUMBER - Last 4 numbers of Transaction Number
 ;;    WORK ORDER NUMBER
 ;;           SORT GROUP
 ;;
 ;;To go directly to the Vendor, Control Point, Purchase Order, Work Order
 ;;or Temporary Transaction cross reference, you may enter:
 ;;'V.', 'C.', 'P.', 'W.' or 'T.' followed by the lookup value. - E.G. V.IBM
 ;;XXX
