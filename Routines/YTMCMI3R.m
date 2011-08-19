YTMCMI3R ;ALB/ASF-MCMI3 REPORT ;9/3/02  15:57
 ;;5.01;MENTAL HEALTH;**76**;Dec 30, 1994
REPT ;reports
 S (YSTOUT,YSUOUT)=""
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=58-A\2,L2=L1+A+4 S:A<9 A=9
 D DTA^YTREPT
 W !,?(72-$L(X)\2),X,!
 W !?40,$S(YSVFLAG'=0:"*** Invalid Profile *** "_YSVFLAG,1:"Valid Profile")
 W:YSINPT?1A !,"Patient entered as an ",$S(YSINPT="I":"Inpatient",1:"Outpatient"),"." W:YSINPT="" !,"No setting entered, patient assumed to be outpatient."
 W !,"Duration of recent Axis I episode: "
 W:YSDUR?1N $P("Cannot Categorize^Less than 1 week^1-4 weeks^1-3 months^3-12 months^Periodic; 1-3 years^Coninuous; 1-3 years^Periodic; 3-7 years^Continuous 3-7 years^More than 7 years",U,YSDUR+1)
 W !
 F I=2:1:28 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=2 !,"Modifying Indices"
 . W:I=5 !,"Clinical Personality Patterns"
 . W:I=16 !,"Severe Personality Pathology"
 . W:I=19 !,"Clinical Syndromes"
 . W:I=26 !,"Severe Clinical Syndromes"
 . S YSSID=$P(^YTT(601,YSTEST,"S",I,0),U,2)
 . W !,$P(YSSID," ")
 . W ?5,$J($P(R,U,I),3),"  ",$J($P(S,U,I),3)," "
 . D CHART
 . W ?53,$P(YSSID," ",2,99)
 D NOTEWOR
 Q
CHART ;
 N X
 S X=$P(S,U,I)
 W $E("***************************************************************",1,$J(X/3,0,0))
 Q
NOTEWOR ;note worthy responses
 D RD^YTMCMI3
 W !!?10,"*** Noteworthy Responses ***"
 F I=1,4,11,37,55,74,75,107,130,149,10,18,27,48,63,69,92,99,105,161,165,167,174,9,14,22,30,34,77,83,87,96,116,124,134,24,44,112,128,142,150,151,154,171,81,132,121,143,155,163 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=1 !!,"Health Preoccupation"
 . W:I=10 !!,"Interpersonal Alienation"
 . W:I=9 !!,"Emotional Dyscontrol"
 . W:I=24 !!,"Self-Destructive Potential"
 . W:I=81 !!,"Childhood Abuse"
 . W:I=121 !!,"Eating Disorder"
 . Q:$E(X,I)'="T"
 . W !,$J(I,3,0),". ",^YTT(601,YSTEST,"Q",I,"T",1,0)
 . W:$D(^YTT(601,YSTEST,"Q",I,"T",2,0)) !?5,^YTT(601,YSTEST,"Q",I,"T",2,0)
 Q
