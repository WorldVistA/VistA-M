ECXTPR ;ALB/DAN - List of current test patients ;3/30/17  11:49
 ;;3.0;DSS EXTRACTS;**166**;Dec 22, 1997;Build 24
 ;
 N ECXPORT,ZTSAVE
 W !!,"** NOTE: This report can take a while to generate.  If you're not exporting the",!,"report, it's suggested that you queue it to run in the background.",!
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1
 I $G(ECXPORT) D  Q  ;If exporting get records and display to screen
 .K ^TMP($J,"ECXTPR"),^TMP($J,"ECXPORT")
 .D GETPTS
 .M ^TMP($J,"ECXPORT")=^TMP($J,"ECXTPR")
 .S ^TMP($J,"ECXPORT",0)="NAME^SSN^TEST PATIENT INDICATOR^DSS TEST PATIENT"
 .D EXPDISP^ECXUTL1
 .K ^TMP($J,"ECXTPR"),^TMP($J,"ECXPORT")
 .Q
 ;
 D EN^XUTMDEVQ("START^ECXTPR","Print list of test patients",.ZTSAVE)
 Q
 ;
START ;
 K ^TMP($J,"ECXTPR")
 D GETPTS
 D PRINT
 K ^TMP($J,"ECXTPR")
 Q
 ;
GETPTS ;Find test patients
 N NAME,IEN,SSN,CNT,VTP,DTP
 S CNT=0
 S NAME="" F  S NAME=$O(^DPT("B",NAME)) Q:NAME=""  S IEN=0 F  S IEN=$O(^DPT("B",NAME,IEN)) Q:'+IEN  D
 .S SSN=$$GET1^DIQ(2,IEN,.09)
 .S VTP=$$TESTPAT^VADPT(IEN)
 .S DTP=$$SSN^ECXUTL5(SSN)
 .I 'DTP!($E(NAME,1,2)="ZZ") S CNT=CNT+1 S ^TMP($J,"ECXTPR",CNT)=NAME_"^"_SSN_"^"_$S(VTP:"Y",1:"N")_"^"_$S('DTP:"Y",1:"N")
 .Q
 Q
 ;
PRINT ;Display results
 N NUM,DATA,PAGE,RDAT,QFLG
 S (PAGE,QFLG)=0,RDAT=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12))
 D HEAD
 S NUM=0 F  S NUM=$O(^TMP($J,"ECXTPR",NUM)) Q:'+NUM!(QFLG)  D
 .I $Y>($G(IOSL)-4) D HEAD Q:QFLG
 .S DATA=^TMP($J,"ECXTPR",NUM)
 .W !,$P(DATA,"^"),?32,$P(DATA,"^",2),?48,$P(DATA,"^",3),?62,$P(DATA,"^",4)
 .Q
 Q
 ;
HEAD ;Print header
 N Y,DIR
 I $E(IOST)="C",PAGE>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 W @IOF
 S PAGE=PAGE+1
 W "Test Patient List on ",RDAT,?70,"Page: ",PAGE,!
 W !,"NAME",?32,"SSN",?43,"TEST PATIENT",?57,"DSS TEST PAT",!,?43,"INDICATOR",?57,"INDICATOR",!,$$REPEAT^XLFSTR("-",80)
 Q
