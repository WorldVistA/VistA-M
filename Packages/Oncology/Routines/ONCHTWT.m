ONCHTWT ;Hines OIFO/GWB - 'COMPUTED-FIELD' expressions ;10/12/11
 ;;2.11;ONCOLOGY;**54**;Mar 07, 1995;Build 10
 ;
HEIGHT ;'COMPUTED-FIELD' EXPRESSION for HEIGHT (160,1011)
 ;Supported by IA #1120 GMRVUTL
 N DFN,GMRVSTR
 I $P(^ONCO(160,D0,0),U,1)["LRT(67," S X="99 (Unknown)" Q 
 S DFN=$P(^ONCO(160,D0,0),";",1)
 S GMRVSTR="HT"
 D EN6^GMRVUTL
 S X=+$P(X,U,8)
 S X=$J(X,0,0)
 I X>97 S X="98 inches or greater" Q
 I X=0 S X="99 (Unknown)" Q
 S X=X_" inches"
 Q
 ;
WEIGHT ;'COMPUTED-FIELD' EXPRESSION for WEIGHT (160,1012)
 ;Supported by IA #1120 GMRVUTL
 N DFN,GMRVSTR
 I $P(^ONCO(160,D0,0),U,1)["LRT(67," S X="999 (Unknown)" Q
 S DFN=$P(^ONCO(160,D0,0),";",1)
 S GMRVSTR="WT"
 D EN6^GMRVUTL
 S X=+$P(X,U,8)
 S X=$J(X,0,0)
 I X=0 S X="999 (Unknown)" Q
 S X=X_" lbs"
 Q
 ;
CLEANUP ;Cleanup
 K D0,X
