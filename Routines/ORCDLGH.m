ORCDLGH ; SLC/MKB - Help for Order Dialogs ;4/7/97  10:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**71,68**;Dec 17, 1997
P ; -- pointer
 N DIC,D,DZ S DIC(0)="EQS"
 S DIC=$S(+DOMAIN:$G(^DIC(+DOMAIN,0,"GL")),1:U_$P(DOMAIN,":")),DZ="??"
 S D=$S($D(ORDIALOG(PROMPT,"D")):$P(ORDIALOG(PROMPT,"D"),";"),1:"B")
 S:$D(ORDIALOG(PROMPT,"S")) DIC("S")=ORDIALOG(PROMPT,"S")
 D DQ^DICQ
 Q
 ;
S ; -- set of codes
 N X,I W !!,"Choose from:"
 F I=1:1:$L(DOMAIN,";") S X=$P(DOMAIN,";",I) Q:'$L(X)  W !,?10,$P(X,":"),?20,$P(X,":",2)
 Q
 ;
D ; -- date
R ; -- free text date
 N %DT S %DT=$P(DOMAIN,":",3) S:$L($P(DOMAIN,":")) %DT(0)=$P(DOMAIN,":")
 D HELP^%DTC
 Q
 ;
OLDR ; -- [old help for] free text date
 W !!,"Examples of Valid Dates:"
 W !,"  JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057"
 W !,"  T   (for TODAY)   T+1 (for TOMORROW)   T+2   T+7   etc."
 W !,"  T-1 (for YESTERDAY)   T-3W (for 3 WEEKS AGO) etc."
 ;W !,"  V   (for the NEXT VISIT)   V-1 (for DAY BEFORE NEXT VISIT) etc."
 W !,"If the year is omitted, the current year is assumed."
 I DOMAIN'["R",DOMAIN'["T" W !,"Time may not be entered." Q
 W !,"If only the time is entered, the current date is assumed."
 W !,"The date "_$S(DOMAIN["R":"must",1:"may")_" be followed by a time, such as JAN 20@10, T@10AM, etc."
 W !,"You may enter a time such as NOON, MIDNIGHT, or NOW."
 W !,"You may also enter NOW+3' (for current date and time plus 3 minutes)"
 Q
 ;
F ; -- free text
 W !!,"This response can be free text" I '$L(DOMAIN) W "." Q
 W ", from "_+DOMAIN_"-"_+$P(DOMAIN,":",2)_" characters in length."
 Q
 ;
N ; -- numeric
 W !!,"This response must be a number" I '$L(DOMAIN) W "." Q
 W " between "_+DOMAIN_" and "_+$P(DOMAIN,":",2)
 I $P(DOMAIN,":",3) W ", up to "_+$P(DOMAIN,":",3)_" decimal places"
 W "." Q
 ;
Y ; -- yes/no
 N DOMAIN S DOMAIN="1:YES;2:NO" G S
 Q
