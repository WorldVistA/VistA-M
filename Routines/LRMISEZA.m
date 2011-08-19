LRMISEZA ;AVAMC/REG/SLC/BA - MICROBIOLOGY INF CONTROL DATA ; 10/9/87  16:18 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;from LRMISEZ
ASK1 F I=0:0 S %=2 W !!,"Will all reports be for a single bacterium" D YN^DICN Q:%'=0  W !,"Do you want all survey data for just one organism?"
 I %<0 S LREND=1 Q
 I %=1 S DIC="61.2",DIC(0)="AEQMOZ",DIC("A")="Select Bacterium: ",DIC("S")="I $P(^(0),U,5)=""B""" D ^DIC K DIC S:X=U LREND=1 Q:X=U  I Y>0 S LRSGL=+Y,LRM("O")="S",LRM("O","S")=LRSGL
SAMPLE F I=0:0 W !!,"Will all reports be by (S)ite/specimen or (C)ollection sample? ",LRSIT(1) R "// ",X:DTIME S:X="" X=LRSIT(1) S:"SC"[X LRSIT(1)=X Q:X="S"!(X="C")!(X=U)  W !,"Select 'S' or 'C', or '^' to exit."
 W ! I X=U S LREND=1 Q
LOS F I=0:0 W !!,"Number of days from patient's admission date to collection date of specimen",! R "to be excluded from all reports.  0// ",X:DTIME S:X="" X=0 Q:X[U!(X?1N.N)  W !,"Enter number of days to exclude."
 W ! I X[U S LREND=1 Q
 S LRLOS=X
AP K LRAP F I=0:0 W !!,"Will all reports require a specific antibiotic pattern" S %=2 D YN^DICN Q:%  W !,"You may restrict all reports to only those that have specific antibiotic",!,"interpretations."
 I %=-1 S LREND=1 Q
 I %=1 S DIC=62.06,DIC(0)="AEMOQZ",DIC("A")="Select Antibiotic: ",DIC("S")="I +$P(^(0),U,2),$L($P(^(0),U,5))" F I=0:0 D ^DIC Q:Y<1  S LRBN=$P(Y(0),U,2) F I=0:0 R !,"Select Interpretation: ",X:DTIME Q:X[U!'$L(X)  S LROK=0 D CHECK Q:LROK
PROMPT K DIC F LRASK="L","O","D","P" D:'(LRASK="O"&($D(LRSGL))) ASK Q:LREND
 Q
ASK S LRPROMPT=$S(LRASK="L":"Location",LRASK="O":"Organism",LRASK="D":"Provider",1:"Patient") W !,"Survey by:  ",LRPROMPT
 F I=0:0 W !,"(A)ll ",LRPROMPT,"s, (S)ingle ",LRPROMPT,", or (N)o ",LRPROMPT," Survey? ",LRM(LRASK) R "// ",X:DTIME S:X="" X=LRM(LRASK) S:"ANS"[X LRM(LRASK)=X Q:X="A"!(X="N")!(X=U)  D:X'="S" INFO1 I X="S" D SINGLE Q
 I X=U S LREND=1 Q
 Q
SINGLE I LRASK="L" K DIC S DIC="44",DIC(0)="AEMOQZ",DIC("A")="Select Location: " D ^DIC K DIC Q:Y<1  S LRM(LRASK,"S")=$P(^SC(+Y,0),U,2) Q
 I LRASK="O" K DIC S DIC="61.2",DIC(0)="AEMOQZ",DIC("A")="Select Organism: ",DIC("S")="I $P(^(0),U,5)=""B""" D ^DIC K DIC Q:Y<1  S LRM(LRASK,"S")=+Y Q
 I LRASK="D" K DIC S DIC="^VA(200,",DIC(0)="AEQMZ",DIC("A")="Select Provider: ",DIC("S")="I $D(^VA(200,""AK.PROVIDER"",$P(^(0),U)))" D ^DIC K DIC Q:Y<1  S LRM(LRASK,"S")=$E($P(^VA(200,+Y,0),U),1,15)_U_+Y Q
 I LRASK="P" K DIC,DFN K DIC S DIC(0)="EMQZ",PNM="" D ^LRDPA Q:LRDFN=-1!($D(DUOUT))!($D(DTOUT))  S LRM(LRASK,"S")=LRDFN
 Q
CHECK I '$D(^LAB(62.06,"AJ",LRBN,X)) W:X'="?" !,"Not an interpretation for this antibiotic." S J=0 W !,"You must use:" F I=0:0 S J=$O(^LAB(62.06,"AJ",LRBN,J)) Q:J=""  W !,?5,J
 I $D(^LAB(62.06,"AJ",LRBN,X)) S LROK=1,LRAP(LRBN)=X
 Q
INFO1 W !,"Select 'A' to obtain a survey grouped by all ",LRPROMPT,"s.",!,"Select 'S' to obtain a survey for only one ",LRPROMPT,".",!,"Select 'N' if you DO NOT want a survey grouped by ",LRPROMPT,".",!,"'^' to exit",!
 Q
