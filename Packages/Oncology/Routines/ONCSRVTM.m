ONCSRVTM ;Hines OIFO/RVD - SERVER ROUTINE FOR TIMELINESS REPORTS ; 05/16/13
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 ;
TIME ;[Timeliness report server]
 K ^TMP($J,"ONCSRV"),^TMP($J,"ONCSRV1"),^TMP($J,"ONCPRT")
 N DIC,SDT,EDT,IEN,ONCCNT,ONCLES,ONCMOR,RPTDATE,DIVISION,ACO,ONCDIV,ONCDVCNT
 N COC,NCRPT,EMTC,END,START,TIMEPCT,Y,ONCLM,ONCII,ONCJJ
 S START=$P(XMRGONC1,"*",2),END=$P(XMRGONC1,"*",3),ACO=$S($P(XMRGONC1,"*",4)="YES":1,1:0)
 S NCRPT=$S($P(XMRGONC1,"*",5)="YES":1,1:0)
 S Y=DT D DD^%DT S RPTDATE=Y
 S X=START D ^%DT S ONCSTART=Y
 S X=END D ^%DT S ONCEND=Y
 ;
COMP S (ONCCNT,ONCLES,ONCMOR)=0,SDT=ONCSTART-1
 N ONCMON,ONCPID
 F  S SDT=$O(^ONCO(165.5,"AFC",SDT)) Q:(SDT="")!(SDT>ONCEND)  S IEN=0 F  S IEN=$O(^ONCO(165.5,"AFC",SDT,IEN)) Q:IEN'>0  D
 .S ONCDIV=$P(^DIC(4,$$DIV^ONCFUNC(IEN),0),U,1)
 .S ONCPID=$$GET1^DIQ(165.5,IEN,61)
 .S ONCMON=$$GET1^DIQ(165.5,IEN,157.1)
 .S COC=$E($$GET1^DIQ(165.5,IEN,.04),1,2)
 .S (ONCDT1,X)=$$GET1^DIQ(165.5,IEN,155) D ^%DT S ONC1CT=Y
 .S (ONCDTC,X)=$$GET1^DIQ(165.5,IEN,90) D ^%DT S ONCCPLT=Y
 .S ^TMP($J,"ONCSRV",ONCDIV)=""
 .I ACO=1,COC>22 Q
 .S EMTC=$$GET1^DIQ(165.5,IEN,157.1)
 .I (EMTC["Unknown")!(EMTC["NA") Q
 .S ONCCNT=ONCCNT+1
 .I EMTC<7 D
 ..I '$D(^TMP($J,"ONCSRV1",ONCDIV,"LES")) S ^TMP($J,"ONCSRV1",ONCDIV,"LES")=0
 ..S ^TMP($J,"ONCSRV1",ONCDIV,"LES")=^TMP($J,"ONCSRV1",ONCDIV,"LES")+1
 .I EMTC>6 D
 ..I '$D(^TMP($J,"ONCSRV1",ONCDIV,"MOR")) S ^TMP($J,"ONCSRV1",ONCDIV,"MOR")=0
 ..S ^TMP($J,"ONCSRV1",ONCDIV,"MOR")=^TMP($J,"ONCSRV1",ONCDIV,"MOR")+1
 ..S ^TMP($J,"ONCSRV",ONCDIV,ONCCPLT,IEN)=ONCPID_"     "_ONCDT1_"      "_ONCDTC_"        "_ONCMON
 .I '$D(^TMP($J,"ONCSRV1",ONCDIV,"CNT")) S ^TMP($J,"ONCSRV1",ONCDIV,"CNT")=0
 .S ^TMP($J,"ONCSRV1",ONCDIV,"CNT")=^TMP($J,"ONCSRV1",ONCDIV,"CNT")+1
 S I=0
 ;S ^TMP($J,"ONCPRT",0)=""
 I ONCCNT=0,'$D(^TMP($J,"ONCSRV1","NOCASE")) S ^TMP($J,"ONCPRT",I+1)="No cases found." D MAIL G EXIT
 ;
 ;initialize variables
 S (ONCD,ONCDIV,ONCOLDV)=""
 F  S ONCDIV=$O(^TMP($J,"ONCSRV",ONCDIV)) D:ONCDIV'=ONCOLDV TOT Q:ONCDIV=""  S (ONCDVCNT,LESCNT,GTRCNT)=0 D HEAD D
 .Q:NCRPT=0
 .S ONCOLDV=ONCDIV
 .F ONCII=0:0 S ONCII=$O(^TMP($J,"ONCSRV",ONCDIV,ONCII)) Q:ONCII'>0  D
 ..F ONCJJ=0:0 S ONCJJ=$O(^TMP($J,"ONCSRV",ONCDIV,ONCII,ONCJJ)) Q:ONCJJ'>0  S ONCD=$G(^(ONCJJ)) D
 ...S I=I+1
 ...S ^TMP($J,"ONCPRT",I)=ONCD
 ...S ONCDVCNT=ONCDVCNT+1
 D MAIL
 G EXIT
 Q
 ;
TOT ;total of each Division
 Q:ONCOLDV=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="COUNT = "_ONCDVCNT
 S ONCDVCNT=0
 Q
 ;
HEAD ;print header
 Q:'$D(^TMP($J,"ONCSRV1",ONCDIV,"CNT"))
 S (ONCLESS,ONCMORE)=0
 S:$D(^TMP($J,"ONCSRV1",ONCDIV,"LES")) ONCLESS=$G(^TMP($J,"ONCSRV1",ONCDIV,"LES"))
 S:$D(^TMP($J,"ONCSRV1",ONCDIV,"MOR")) ONCMORE=$G(^TMP($J,"ONCSRV1",ONCDIV,"MOR"))
 S I=I+1
 S ONCTPCT=""
 I $D(^TMP($J,"ONCSRV1",ONCDIV,"LES"))&($D(^TMP($J,"ONCSRV1",ONCDIV,"CNT"))) D
 .S ONCTPCT=^TMP($J,"ONCSRV1",ONCDIV,"LES")/^TMP($J,"ONCSRV1",ONCDIV,"CNT")
 .S ONCTPCT=$J(ONCTPCT,3,2)*100_"%"
 S ^TMP($J,"ONCPRT",I)="",I=I+1
 S ^TMP($J,"ONCPRT",I)="TIMELINESS NON-COMPLIANCE REPORT for: "_ONCDIV_"         RUN DATE: "_RPTDATE
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="Start Date of First Contact.......: "_START
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="End Date of First Contact.........: "_END
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="Division..........................: "_ONCDIV
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="Analytic cases only...............: "_$S(ACO=1:"YES",1:"NO")
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="Cases Completed within six months.: "_ONCLESS
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="Cases Completed > six months......: "_ONCMORE
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="Pct of 'Completed' cases compliant: "_ONCTPCT
 S I=I+1
 S ^TMP($J,"ONCPRT",I)=""
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="",I=I+1
 Q:NCRPT=0
 S ^TMP($J,"ONCPRT",I)="PID#     FIRST CONTACT    COMPLETED         ELAPSED MONTHS TO COMPLETION"
 S I=I+1
 S ^TMP($J,"ONCPRT",I)="----     -------------    ---------         ----------------------------",I=I+1
 Q
 ;
MAIL ;email report to Oncology
 S XMDUZ=.5
 D REC^ONCSRV  ;get recipients
 S XMSUB="Oncology Timeliness Report "_START_" to "_END
 S XMTEXT="^TMP($J,""ONCPRT"","
 D ^XMD
 K XMTEXT
 Q
 ;
DIV ;process each division
 S TIMEPCT=LESCNT/CNT
 S TIMEPCT=$J(TIMEPCT,3,2)*100_"%"
 S DIVISION=$P(^DIC(4,ONCDIV,0),U,1)
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
 I $G(NCRPT)=0 Q
 W @IOF
PRT S DIC="^ONCO(165.5,",L=0,L(0)=1
 S FLDS="!61;C2;L5,155;C10;L10;""FIRST CONTACT"",90;C23;L10;""COMPLETED"",157.1;C36"
 S BY="90"
 S BY(0)="^TMP($J,""ONCSRV"",I,"
 S (FR,TO)=""
 S DHD="TIMELINESS NON-COMPLIANCE REPORT for "_DIVISION
 S IOP=ION
 D EN1^DIP
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
 K ^TMP($J,"ONCSRV"),^TMP($J,"ONCPRT"),^TMP($J,"ONCSRV1")
 Q
