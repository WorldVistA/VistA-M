LRACM4 ;SLC/DCM - INIT CUM REPORTS CONT. ; 9/10/87  09:55 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
DEL ;from LRACM
 K ^LRO(68,"AC") D MOR S I=0 F  S I=$O(^LAB(64.5,1,3,I)) Q:I<1  S ^(0)=$P(^(I,0),U,1,3)
DEL1 W !!,"Each day has a different set of patients for which cumulatives are printed.",!,"Your next response will be a beginning date for combining these sets of",!,"patients into the next cumulative (ending date is today).  "
 W !,"A cumulative will be printed for each patient that originally",!,"had a cumulative during this time period.  The potential for duplicates",!,"is high because of patient movement within the time period."
 S %DT="AE",%DT("A")="Select BEGINNING DATE FOR COMBINED CUMULATIVE: " D ^%DT G:Y<1 OUT S $P(^LAB(64.5,1,0),U,3)=Y
 S LRDTX=0 F  S LRDTX=$O(^LRO(69,LRDTX)) Q:LRDTX<1!(LRDTX'<Y)  W " ",LRDTX K ^LRO(69,LRDTX,1,"AR")
 K LRDTX Q
MOR W !!,"Re-cross referencing just the ""AC"" index will recapture the pointers to",!,"^LR from ^LRO(68,""AC""; thus, all data back to a given date (date of going",!,"live with cum) that is still on the system can be reprinted.",!
 F I=0:0 R !,"Do you want to re-cross reference the ""AC"" X-ref from a certain date" S %=1 D YN^DICN Q:%>0  W !,"You must answer 'Y'es or 'N'o."
 I %=1 D ^LRACFIX
 Q
OUT W !!,$C(7),"NO COMBINING HAS OCCURRED!" Q
