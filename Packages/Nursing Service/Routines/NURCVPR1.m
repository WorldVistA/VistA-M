NURCVPR1 ;HIRMFO/YH-PATIENT VITALS/MEASUREMENTS REPORT UTILITY ;2/9/99
 ;;4.0;NURSING SERVICE;**23**;Apr 25, 1997
SELECT(J) ;TYPE OF GRAPH FOR REPORT
 N X,I W !
TRYAGN F I=1:1:5 W !,?2,I_"  "_$P($T(GCHART+I),";;",2)
 W !!,?2,"Select a number between 1 and 5: 1  Vital Signs Record// " S X="" R X:DTIME I '$T!(X["^") S J=0 Q
 I X="" S J=1 Q
 I '(X?1N&(X>0&(X<6)))!(X["?") W !!,"Enter the number for the graph you wish to print.",!,"The default is Vital Signs Record.",! G TRYAGN
 W "  ",$P($T(GCHART+X),";;",2) S J=X Q
 Q
WRT1 W !!,?5,$C(7),"This report must be queued to",!!,?8,"SF 511: 132 columns printer or Kyocera or HP Laser printer,",!,?8,"B/P Plotting, Weight chart or Pulse Oximetry/Respiration",!,?10,"Graph: Kyocera or HP Laser printer.",!
 W ?5,"Pain Chart must be queued to a HP Laser printer.",!
 Q
WRT2 I NGRAPH>1 D ^%ZISC W !,$S(NGRAPH=2:"B/P Plotting Chart",NGRAPH=3:"Weight Chart",NGRAPH=4:"Pulse Oximetry/Respiration Graph",1:"")_" must be queued to a Kyocera or HP Laser printer.",!! S NURQUIT=1
 I IOM'>130,NGRAPH=1 D ^%ZISC W !,"This report needs 132 columns",! S NURQUIT=1
 Q
GCHART ;
 ;;Vital Signs Record
 ;;B/P Plotting Chart
 ;;Weight Chart
 ;;Pulse Oximetry/Respiratory Graph
 ;;Pain Chart
