YSKFASIM ;16IT/PTC - SUBSTANCE ABUSE ;9/6/01  10:03
 ;;5.01;MENTAL HEALTH;**73**;Dec 30, 1994
 W @IOF,!,?10,"Addiction Severity Index CaseFinder",!!
DTRANGE ;
 W !
 S (YSKFBDT,YSKFEDT)=0,%DT("A")="Beginning Date for Performance Measure Date Range: ",%DT="AEX" D ^%DT
 G:+Y'>0 EXIT
 S YSKFBDT=+Y_".000001"
ENDDT W ! S %DT("A")="Ending Date for Performance Measure Date Range: " D ^%DT
 G:+Y'>0 EXIT
 S YSKFEDT=+Y_".595959"
 I YSKFEDT<YSKFBDT S YSKF=YSKFBDT,YSKFBDT=YSKFEDT,YSKFEDT=YSKF K YSKF
 ;
 S YSKFTYPE=9
 S YSKFMG="N",YSKFZZ="Y"
 S (YSKFMHSX,YSKFMHFG)=1
MAILG K DIR,Y
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want reports sent to the ASI PERFORMANCE MEASURES Mail group"
 S DIR("?")="If you enter N, the reports will be sent only to your mailbox",DIR("?",1)="If you enter Y, the reports will be sent to you and all in the ASI Performance ",DIR("?",2)="Measures Mail Group" D ^DIR I $D(DIRUT) G DTRANGE
 S YSKFMG=$S(Y=1:"Y",1:"N")
DATA K DIR,Y
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to generate the patient-specific reports"
 S DIR("?")="If you enter N, only the summary report will be generated.",DIR("?",1)="If you enter Y, both the summary and patient-specific reports will be generated." D ^DIR I $D(DIRUT) G MAILG
 S YSKFZZ=$S(Y=1:"Y",1:"N")
 S ZTRTN="ASI^YSKFASIM",YSKFDIS="ASI"
QUEUE ;
 ;S U="^",YSKFSITE=^DD("SITE",1)_U_^DD("SITE")
 S U="^",YSKFSITE=+$P($$SITE^VASITE,U)_U_$$SITE^YSGAF3
 K IOP,ZTIO,ZTSAVE
 S ZTIO="",ZTSAVE("YSKF*")="",ZTDESC="Performance Measure Reports and Data Sets"
 D ^%ZTLOAD
 I '$D(ZTSK) QUIT  ;-->
        W !!,"The ASI Performance Measure Reports has been Tasked, job# ",ZTSK,"...",!
 D ^%ZISC
 Q
ASI ;ASI
 I $D(ZTQUEUED) S ZTREQ="@" K ZTSK
 D ^YSKFASI1
EXIT K YSKFBDT,YSKFEDT,YSKFTYPE,YSKFSITE,^TMP($J),^TMP("XM",$J),^TMP("XN",$J),^TMP("M",$J),YSKFMHFG,^UTILITY($J)
 Q
