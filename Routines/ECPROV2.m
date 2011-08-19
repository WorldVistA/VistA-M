ECPROV2 ;BIR/MAM-Event Capture Provider Summary (cont'd) ;20 Sep 93
 ;;2.0; EVENT CAPTURE ;**5,47,69**;8 May 96
 ;
 D REASON^ECRUTL ;* Prompt to report Procedure Reasons
 ;
DATE W ! K %DT S %DT="AEX",%DT("A")="Start with Date: " D ^%DT I Y<0 S ECOUT=1 Q
 S ECSD=Y,ECDATE=$$FMTE^XLFDT(ECSD),%DT("A")="End with Date: " D ^%DT I Y<0 S ECOUT=1 Q
 I Y<ECSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S ECED=Y,ECDATE=ECDATE_"^"_$$FMTE^XLFDT(ECED),ECSD=ECSD-.0001,ECED=ECED+.9999
 ;
 ;ALB/ESD - Print report length informational message
 W !,"This report is formatted for 132 column output."
 W ! K IOP,POP,IO("Q"),%ZIS S %ZIS="QM",%ZIS("A")="Select Device: " D ^%ZIS I POP S ECOUT=1 Q
 I $D(IO("Q")) K IO("Q") S ZTDESC="EVENT CAPTURE PROVIDER SUMMARY",ZTRTN="START^ECPROV2",ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL D VAR,^%ZTLOAD,HOME^%ZIS K ZTSK Q
 U IO
START ; entry when queued
 N ECPRV
 K ^TMP($J) S ECINC=0
 S ECPRV=$S(ECD="SOME":1,ECD="ALL":2,1:0) D ^ECPROV3
 K ^TMP($J) I $D(ECGUI) D ^ECKILL Q
 G:$D(ZTQUEUED) END
 Q
VAR ; set ZTSAVE array
 S:'$D(UNIT) UNIT="" S (ZTSAVE("ECD*"),ZTSAVE("ECL*"),ZTSAVE("ECED"),ZTSAVE("ECSD"),ZTSAVE("ECDATE"),ZTSAVE("UNIT*"))=""
 S ZTSAVE("ECRY")=""
 Q
END W @IOF D ^%ZISC W !! D ^ECKILL S:$D(ZTQUEUED) ZTREQ="@"
 Q
