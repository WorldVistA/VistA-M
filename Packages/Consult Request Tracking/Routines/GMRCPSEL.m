GMRCPSEL ;SLC/DCM - Select Range Of Items From List ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
SEL ;Entry point into select option
 I '$D(^TMP("GMRCR",$J,"CS","AD")) W !,"No Consult Orders Exist To Select From.",! S GMRCSEL="",GMRCQUIT=1 Q
 I '$O(^TMP("GMRCR",$J,"CS","AD")),BLK=1 S GMRCSEL=BLK Q
 S GMRCSEL="" W !,"Choose No. 1-"_BLK_": " R X:DTIME S:X="^^" DIROUT=1 I '$T!(X["^") S (DTOUT,GMRCQUT)=1 Q
 I X["?" D SELHELP G SEL
 I X="" S GMRCQUT=1 Q
 I $S(X'?.N1",".N.E:1,X<0:1,X>BLK:1,1:0) D SELHELP G SEL
 S GMRCSEL=X
 Q
SELHELP ;Help to select a valid entry
 W !,"Select a request by typing the number in the left column and pressing <ENTER>",!,"or by selecting a range of numbers in the left column, separated by commas.",!
 Q
