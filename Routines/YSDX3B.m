YSDX3B ;SLC/DJP-Entry of Axis 4 & Axis 5 Diagnoses for the Mental Health Medical Record ;8/29/89  08:51
 ;;5.01;MENTAL HEALTH;**33,43,49**;Dec 30, 1994
 ;D RECORD^YSDX0001("YSDX3B^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 ;
AXIS4 ;  Called by routine YSCEN1, YSDX3
 ;  Entry of Axis 4 information
 ;D RECORD^YSDX0001("AXIS4^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 W !!,"AXIS 4",!,"------"
AX43 ;
 ;D RECORD^YSDX0001("AX43^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 W !!,"Enter PSYCHOSOCIAL STRESSOR:  " R X3:DTIME S YSTOUT='$T,YSUOUT=X3["^" I YSTOUT!YSUOUT S YSQT=1 Q
 Q:X3=""  I X3="?" D AX41 K X3 G AX43
 I X3["??" S XQH="YS-PSYCHOSOCIAL STRESSORS" D EN^XQH K X3 G AX43
 I $L(X3)>60!($L(X3)<1) D AX41 K X3 G AX43
AX42 ;
 ;D RECORD^YSDX0001("AX42^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 W !,"Enter SEVERITY CODE:  " R X4:DTIME S YSTOUT='$T,YSUOUT=X4["^" I YSTOUT!YSUOUT S YSQT=1 Q
 I X4="??" S XQH="YS-AXIS 4" D EN^XQH K X4 G AX42
 I X4'?1N!(X4<0)!(X4>6) D AX4 G AX42
 S X6=$S(X4=1:"NONE",X4=2:"MILD",X4=3:"MODERATE",X4=4:"SEVERE",X4=5:"EXTREME",X4=6:"CATASTROPHIC",X4=0:"INADEQUATE INFORMATION OR NO CHANGE IN CONDITION",1:"") W " "_X6
 S DIC="^YSD(627.8,",DIC(0)="L",X="""N""",DLAYGO=627
 D ^DIC Q:Y'>0  S YSDA=+Y
 S YSDUZ=$P(^VA(200,DUZ,0),U),DIE="^YSD(627.8,",DA=YSDA,DR=".02////"_YSDFN_";.03///^S X=""NOW"";.04///^S X=YSDUZ;.05///^S X=""`""_DUZ;60//^S X=X3;61//^S X=X4"
 L +^YSD(627.8,DA):9999
 K Y
 D ^DIE
 L -^YSD(627.8,DA)
 K DA,DIC,DIE,DR
 S YSTOUT=$D(DTOUT) I YSTOUT!($O(Y(""))]"") S DIK="^YSD(627.8,",DA=YSDA D ^DIK Q:YSTOUT  G AX43
AX4 ;
 ;D RECORD^YSDX0001("AX4^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 W !!,"Enter code indicating overall severity of psychosocial stressor.",! S A1=$P(^DD(627.8,61,0),U,3) F I=1:1:8 S A2=$P(A1,";",I) W !?5,$P(A2,":")_" "_$P(A2,":",2)
 W !!,"Enter ""??"" for additional information on Severity Codes."
 Q
AX41 ;
 ;D RECORD^YSDX0001("AX41^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 W !!,"Enter short narrative (1-60 characters) describing source of stress."
 Q
AXIS5 ;  Called by routines YSCEN1, YSDX3
 ;D RECORD^YSDX0001("AXIS5^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 ;Entry of Axis 5 information
 W !!,"AXIS 5",!,"------",! D GAF^YSDX3UB
AX51 ;
 ;D RECORD^YSDX0001("AX51^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 W !!,"Enter RATING OF CURRENT FUNCTIONING:  " R X5:DTIME S YSTOUT='$T,YSUOUT=X5["^" I YSTOUT!YSUOUT S YSQT=1 Q
 Q:X5=""  I X5="?" D AX5 K X5 G AX51
 I X5["??" S XQH="YS-GAF SCALE" D EN^XQH K X5 G AX51
 I X5>100!(X5<1)!(X5'?.N) D AX5 K X5 G AX51
 K DD,DO,DA,DINUM
 S X="NOW",%DT="TR" D ^%DT S X=Y
 S DIC="^YSD(627.8,",DIC(0)="L",DLAYGO=627.8 D FILE^DICN S YSDA=+Y
 D PATSTAT
 S DIE="^YSD(627.8,",DA=YSDA,DR=".02////"_YSDFN_";.03///^S X=""NOW"";.04///^S X=YSDUZ;.05////"_DUZ_";66////"_YSSTAT_";65///^S X=X5"
 L +^YSD(627.8,DA):9999
 D ^DIE
 L -^YSD(627.8,DA)
 K DA,DIC,DIE,DR
 D EN^YSGAFOBX(YSDA)
 S YSTOUT=$D(DTOUT),YSUOUT=$O(Y(""))]"" I YSTOUT!YSUOUT S DIK="^YSD(627.8,",DA=YSDA D ^DIK Q
 Q
GAFQ ;
 ;D RECORD^YSDX0001("GAF1^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 S:'$D(YSGAF) G5=0 W !!,"Highest GAF past year: ",G5 W:$D(G11) " (dtd ",G11,")" W "//  " R G7:DTIME S YSTOUT='$T,YSUOUT=G7["^" G:G7="" AX51 I YSTOUT!YSUOUT S YSQT=1 Q
 I G7="??" S XQH="YS-GAF SCALE" D EN^XQH K X7 G GAFQ
 I G7["?" D GAF2 K G7 G GAFQ
 I G7>100!(G7<1)!(G7?.E1"."1N.N) D GAF3 K G7 G GAFQ
 S %DT="AEX",X="N",%DT("A")="As of: " D ^%DT K %DT("A") S G8=$P(Y,"."),G9=(G8-1),YSOLD=G9_"."_$P(Y,".",2) D GAFUP
AX5 W !!,"Enter rating of current functioning as indicated on GAF Scale (100-1).",!,"Enter ""??"" for additional information on the GAF Scale.",!
 Q
GAF2 ;
 ;D RECORD^YSDX0001("GAF2^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 W !!,"Default shown is the highest recorded GAF Scale for this patient during ",!,"the past year.  To change, enter a HIGHER number.",!,"Enter ""??"" for additional information on the GAF Scale.",! Q
GAF3 ;
 W " ??",!,"Type a number (1-100) relevant to the GAF Scale." Q
GAFUP ;
 ;D RECORD^YSDX0001("GAFUP^YSDX3B") ;Used for testing.  Inactivated in YSDX0001...
 ;S DIC="^YSD(627.8,",DIC(0)="L",X=YSOLD,DLAYGO=627 D ^DIC Q:Y'>0  S YSDA=+Y
 K DD,DO,DA,DINUM
 S X="NOW",%DT="TR" D ^%DT S X=Y
 S DIC="^YSD(627.8,",DIC(0)="L",DLAYGO=627.8 D FILE^DICN S YSDA=+Y
 D PATSTAT
 S DIE="^YSD(627.8,",DA=YSDA,DR=".02////"_YSDFN_";.03///^S X=YSOLD;.04///^S X=YSDUZ;.05///^S X=""`""_DUZ;66////"_YSSTAT_";65///^S X=G7"
 L +^YSD(627.8,DA):9999
 D ^DIE
 L -^YSD(627.8,DA)
 K DA,DIC,DIE,DR
 D EN^YSGAFOBX(YSDA)
 Q
 ;
PATSTAT ;
 K VAIP
 S YSSTAT=""
 D IN5^VADPT
 S YSSTAT=VAIP(1)
 I YSSTAT S YSSTAT="I" Q
 S YSSTAT="O"
 Q
