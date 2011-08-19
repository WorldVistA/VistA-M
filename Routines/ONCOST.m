ONCOST ;Hines OIFO/GWB Select ACCESSION YEAR time frame ;9/28/93
 ;;2.11;ONCOLOGY;**1,5,23,44,49**;Mar 07, 1995;Build 38
 ;
TF ;Select time frame
 N DIRUT K DIR
 S DIR("A")="     Select ACCESSION YEAR time frame"
 S DIR(0)="SO^1:All years;2:Range of years;3:One year"
 D ^DIR K DIR Q:$D(DIRUT)
Y S TF=Y
 S BYR=$O(^ONCO(165.5,"AY",0))
 S EYR=$O(^ONCO(165.5,"AY",""),-1)
 D AL:TF=1,RG:TF=2,AN:TF=3 G:(Y[U)!(Y="") EXIT
 I $D(ONCOT) S ONCOS("AF")=1
EXIT K DIR,BYR,EYR,TF,Y1,Y2,YR
 Q
 ;
AL ;All years
 S ONCOS("YR")="ALL"
 Q
 ;
RG ;Range of years
 N DIRUT,LY
 W !!?5,"Select range of years in format (YYYY-YYYY) e.g. 2006-2007",!
ST K DIR
 S DIR(0)="L^"_BYR_":"_EYR
 S DIR("A")="     Select range of years"
 D ^DIR Q:$D(DIRUT)
 S LY=$L(Y,","),Y1=$P(Y,","),Y2=$P(Y,",",LY-1)
 S ONCOS("YR")=Y1_U_Y2
 Q
 ;
AN ;One year
 N DIRUT
 W !
 S YR=$E(DT,1)+17_$E(DT,2,3)
 K DIR
 S DIR("A")="     Select ACCESSION YEAR"
 S DIR("B")=$S(YR=BYR:YR,1:YR-1)
 S DIR(0)="N^"_BYR_":"_EYR
 D ^DIR Q:$D(DIRUT)
 G AN:Y>YR,AN:Y'?1.N S ONCOS("YR")=Y_U_Y
 Q
