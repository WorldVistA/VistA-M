FHSYSP ; HISC/REL - Site Parameter Edit ;3/20/95  07:53
 ;;5.5;DIETETICS;**2,5**;Jan 28, 2005;Build 53
 S DA=1,DIE="^FH(119.9,"
 I '$D(^FH(119.9,DA,0)) S DR=".01///"_DA D ^DIE
 W ! S DR="3;22;4;S:X="""" Y=9;5:8;40:49;9:13;50:59;14:18;25:39;100//Y;I X'=""Y"" S Y="""";99" D ^DIE G KIL
EN1 ; Display Selected Lab Tests
 W ! S L=0,DIC="^FH(119.9,",FLDS="[FHSYP1]",BY="@SITE"
 S (FR,TO)=1,DHD="SELECTED LABORATORY TESTS" D EN1^DIP,RSET Q
EN2 ; Display Selected Drug Classifications
 W ! S L=0,DIC="^FH(119.9,",FLDS="[FHSYP2]",BY="@SITE"
 S (FR,TO)=1,DHD="SELECTED DRUG CLASSIFICATIONS" D EN1^DIP,RSET Q
EN3 ; Clinical Site Parameters
 S DA=1,DIE="^FH(119.9,",DR="[FHSITEC1]" W ! D ^DIE G KIL
RSET K %ZIS S IOP="" D ^%ZIS
KIL G KILL^XUSCLEAN
TIM ; Convert to printable time
 I $L(X)>6!($L(X)<2) G ERR
 I X'["A",X'["P" G ERR
 S:$L(X)<4 X=$E(X,1,$L(X)-1)_"00"_$E(X,$L(X))
 I X[":",X?1.2N1":"2N1"A"!(X?1.2N1":"2N1"P") S X=+$P(X,":",1)_$P(X,":",2) G 1
 I X'[":",X?3.4N1"A"!(X?3.4N1"P") G 1
ERR W *7,"  Enter time as 8:15A or 12:30P" K X Q
1 I X#100>59!(X>1259)!(X<1) G ERR
 I X<1000 S:$E(X,1) X="0"_X
 S X=+$E(X,1,2)_":"_$E(X,3,4)_$S(X["A":"A",1:"P") Q
MIL ; Check for AM or PM
 S X1=$P(X,":",1)_$P(X,":",2),X1=+X1
 I X["P",X1<1200 S X1=X1+1200
 I X["A",X1>1200 S X1=X1-1200
 Q
MIP ; Get the printable time
 S Z=$S(Y<1200:"A",1:"P") I Z="P",Y>1259 S Y=Y-1200
 S Y=$E("000"_Y,$L(Y),$L(Y)+3),Y=+$E(Y,1,2)_":"_$E(Y,3,4)_Z Q
