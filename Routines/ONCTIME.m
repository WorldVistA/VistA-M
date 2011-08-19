ONCTIME ;Hines OIFO/GWB [Timeliness report] ;11/01/10
 ;;2.11;ONCOLOGY;**47,48,51,52**;Mar 07, 1995;Build 13
 ;
TIME ;[Timeliness report]
 K ^TMP("ONC",$J)
 N DIC,SDT,EDT,IEN,CNT,LESCNT,GTRCNT,RPTDATE,DIVISION,ACO
 N COC,NCRPT,BY,DHD,FLDS,FR,L,TO,DIRUT,EMTC,END,START,TIMEPCT,Y
 W @IOF
 W !?3,"Timeliness report",!
 S %DT="AEX",%DT("A")="   Start Date of First Contact: "
 D ^%DT K %DT
 Q:Y<1  S START=Y,SDT=Y-1
 S %DT="AEX",%DT("A")="   End Date of First Contact..: "
 D ^%DT K %DT
 Q:Y<1  S (END,EDT)=Y
 W !
 K DIR
 S DIR("A")="   Analytic cases only"
 S DIR("B")="YES"
 S DIR(0)="Y"
 S DIR("?")=" "
 S DIR("?",1)=" Answer 'YES' if you want only analytic cases (CLASS OF CASE 0-2) counted."
 S DIR("?",2)=" Answer  'NO' if you want all cases (analytic and non-analytic) counted."
 D ^DIR
 I $D(DIRUT) S OUT=1 Q
 S ACO=Y
 W !
 K DIR
 S DIR("A")="   Do you want to print a list of non-compliant cases"
 S DIR("B")="YES"
 S DIR(0)="Y"
 S DIR("?")=" "
 S DIR("?",1)=" Answer 'YES' if you want to include a list of non-compliant cases."
 S DIR("?",2)=" Answer  'NO' if you want to only want the Timeliness Report."
 D ^DIR
 I $D(DIRUT) S OUT=1 Q
 S NCRPT=Y
 W !
 N %ZIS,IOP,POP
 S %ZIS="MQ"
 D ^%ZIS  Q:$G(POP)
 I $D(IO("Q")) D TASK G EXIT
 U IO D COMP D ^%ZISC K %ZIS,IOP G EXIT
 ;
COMP S (CNT,LESCNT,GTRCNT)=0
 F  S SDT=$O(^ONCO(165.5,"AFC",SDT)) Q:(SDT="")!(SDT>EDT)  S IEN=0 F  S IEN=$O(^ONCO(165.5,"AFC",SDT,IEN)) Q:IEN=""  I $$DIV^ONCFUNC(IEN)=DUZ(2) D
 .S COC=$E($$GET1^DIQ(165.5,IEN,.04),1,2)
 .I ACO=1,COC>22 Q
 .S EMTC=$$GET1^DIQ(165.5,IEN,157.1)
 .I (EMTC["Unknown")!(EMTC["NA") Q
 .S CNT=CNT+1
 .I EMTC<7 S LESCNT=LESCNT+1
 .I EMTC>6 S GTRCNT=GTRCNT+1 S ^TMP("ONC",$J,IEN)=""
 I CNT=0 D  D:$E(IOST,1,2)="C-" PAUSE^ONCOPA2A G EXIT
 .W !,?3,"No cases found in this date range.",!
 S TIMEPCT=LESCNT/CNT
 S TIMEPCT=$J(TIMEPCT,3,2)*100_"%"
 S Y=DT D DD^%DT S RPTDATE=Y
 S DIVISION=$P(^DIC(4,DUZ(2),0),U,1)
 S Y=START D DD^%DT S START=Y
 S Y=END D DD^%DT S END=Y
 W !
 W !?3,"TIMELINESS REPORT",?60,RPTDATE
 W !
 W !?3,"Start Date of First Contact.......: ",START
 W !?3,"End Date of First Contact.........: ",END
 W !?3,"Division..........................: ",DIVISION
 W !?3,"Analytic cases only...............: ",$S(ACO=1:"YES",1:"NO")
 W !?3,"Cases Completed within six months.: ",LESCNT
 W !?3,"Cases Completed > six months......: ",GTRCNT
 W !?3,"Pct of 'Completed' cases compliant: ",TIMEPCT
 I $E(IOST,1,2)="C-" W ! D PAUSE^ONCOPA2A
 I $G(NCRPT)=0 G CLOSE
 W @IOF
 S DIC="^ONCO(165.5,",L=0,L(0)=1
 S FLDS="!61;C2;L5,155;C10;L10;""FIRST CONTACT"",90;C23;L10;""COMPLETED"",157.1;C36"
 S BY="90"
 S BY(0)="^TMP(""ONC"",$J,"
 S (FR,TO)=""
 S DHD="TIMELINESS NON-COMPLIANCE REPORT"
 S IOP=ION
 D EN1^DIP
CLOSE D ^%ZISC
 Q
 ;
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="COMP^ONCTIME",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Timeliness Report"
 S ZTSAVE("SDT")="",ZTSAVE("EDT")="",ZTSAVE("START")="",ZTSAVE("END")=""
 S ZTSAVE("ACO")=""
 S ZTSAVE("NCRPT")=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K ZTSK
 Q
 ;
EXIT ;Exit
 K ^TMP("ONC",$J)
 Q
 ;
CLEANUP ;Cleanup
 K OUT,ZTDESC,ZTREQ,ZTRTN
