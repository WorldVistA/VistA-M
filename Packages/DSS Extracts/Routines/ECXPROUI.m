ECXPROUI ;ALB/DAN - Display unit of issue records from file 420.5 ;3/6/17  15:25
 ;;3.0;DSS EXTRACTS;**166**;Dec 22, 1997;Build 24
 ;
 N ECXPORT,ZTSAVE
 W !!,"This report will list all units of issue that can be used in prosthetics.",!,"The list will include the 2 character name as well as the full name.",!
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1
 I $G(ECXPORT) D  Q  ;If exporting get records and display to screen
 .K ^TMP($J,"ECXPROUI"),^TMP($J,"ECXPORT")
 .D GETUNITS
 .M ^TMP($J,"ECXPORT")=^TMP($J,"ECXPROUI")
 .S ^TMP($J,"ECXPORT",0)="NAME^FULL NAME"
 .D EXPDISP^ECXUTL1
 .K ^TMP($J,"ECXPROUI"),^TMP($J,"ECXPORT")
 .Q
 ;
 D EN^XUTMDEVQ("START^ECXPROUI","Print unit of issue entries from file 420.5",.ZTSAVE)
 Q
 ;
START ;
 K ^TMP($J,"ECXPROUI")
 D GETUNITS
 D PRINT
 K ^TMP($J,"ECXPROUI")
 Q
 ;
GETUNITS ;Get unit of issue
 N CNT,NAME,IEN,NODE
 S CNT=0
 S NAME="" F  S NAME=$O(^PRCD(420.5,"B",NAME)) Q:NAME=""  S IEN=0 F  S IEN=$O(^PRCD(420.5,"B",NAME,IEN)) Q:'+IEN  D
 .Q:$L(NAME)'=2  ;Stop if name isn't in correct form
 .S NODE=$G(^PRCD(420.5,IEN,0)) Q:NODE=""  ;if node doesn't exist, problem with "B" cross reference
 .S CNT=CNT+1,^TMP($J,"ECXPROUI",CNT)=NAME_"^"_$P(NODE,U,2)
 .Q
 Q
 ;
PRINT ;Display results
 N NUM,DATA,PAGE,RDAT,QFLG
 S (PAGE,QFLG)=0,RDAT=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12))
 D HEAD
 S NUM=0 F  S NUM=$O(^TMP($J,"ECXPROUI",NUM)) Q:'+NUM!(QFLG)  D
 .I $Y>($G(IOSL)-4) D HEAD Q:QFLG
 .S DATA=^TMP($J,"ECXPROUI",NUM)
 .W !,$P(DATA,"^"),?5,$P(DATA,"^",2)
 .Q
 Q
 ;
HEAD ;Print header
 N Y,DIR
 I $E(IOST)="C",PAGE>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 W @IOF
 S PAGE=PAGE+1
 W "Unit of Issue List on ",RDAT,?70,"Page: ",PAGE,!
 W !,"NAME",?5,"FULL NAME",!,$$REPEAT^XLFSTR("-",80)
 Q
