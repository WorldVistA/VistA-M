QANBENE0 ;HISC/GJC-SPECIAL INCIDENTS INVOL. A BENEFICIARY ;4/13/93  08:24
 ;;2.0;Incident Reporting;**18,26,28,29**;08/07/1992
 ;
EN1 ;/*** Catagorize incidents ***/
 K DIR S DIR(0)="FAO^1:1^K:""ACDINO""'[X X",DIR("A")="Select Ward type (A/C/D/I/N/O): "
 S DIR("?",1)="Enter ""A"" to generate separate reports for Domiciliaries, NHCU'S, "
 S DIR("?",2)="Inpatients and Outpatients."
 S DIR("?",3)="Enter ""C"" to generate a report of combined data for Domiciliaries, NHCU'S, "
 S DIR("?",4)="Inpatients and Outpatients."
 S DIR("?",5)="Enter ""D"" for Domiciliary, ""I"" for Inpatients other than Domiciliary or "
 S DIR("?")="NHCU, ""N"" for NHCU units, or ""O"" for Outpatients."
 D ^DIR K DIR
 I $D(DIRUT) D KILL Q
 S QANFLG("WARD")=Y
TASK ;Call to %ZTLOAD
 S Y=DT X ^DD("DD") S TODAY=Y
 K IOP,%ZIS S %ZIS("A")="Print on device: ",%ZIS="MQ" W ! D ^%ZIS W !!
 G:POP KILL
 I $D(IO("Q")) S ZTRTN="START^QANBENE0",ZTDESC="Generate Special Incident Reports For A Beneficiary." D QLOOP,^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!"),! G EXIT
START ;IO requests
 U IO
 I QANFLG("WARD")="A" S QANFLG("WARD A")="D^I^N^O"
 I $D(QANFLG("WARD A")),(QANFLG("WARD A")="D^I^N^O") F QAN=1:1:$L(QANFLG("WARD A"),"^") Q:QANQUIT  S QANFLG("WARD")=$P(QANFLG("WARD A"),"^",QAN) Q:QANFLG("WARD")']""  D
 . W @IOF
 . S PAGE=0
 . K ^TMP("QANBEN",$J),QANCOUNT
 . D GO D:'QANQUIT HDH^QANBENE3 Q:QANQUIT
 G:QANQUIT EXIT
 I '$D(QANFLG("WARD A")) D GO
 I $D(^TMP("QANBEN",$J,"NOBEN")) D PRNOBEN
EXIT ;
 W ! D ^%ZISC,HOME^%ZIS
KILL ;Kill and quit.
 K %ZIS,D,DIC,DIRUT,I,PAGE,POP
 K QAN,QAN742,QAN7424,QANAA,QANAB,QANBB,QANBENE,QANCC,QANCONT
 K QANCOUNT,QANDATE,QAN1DIV,QANDIV,QANDTH,QANDV,QANDVFLG
 K QANFLG,QANHEAD,QANHLOC,QANINPT,QANLBL,QANLP,QANLWLT
 K QANPTTY,QANQUIT,QANSLEV,QANSTAT,QANTAB,QANUPLT,QANWARD
 K QANINVST,QANSITE,QANSWCH,QANWHICH
 K QAQNBEG,QAQNEND
 K TODAY,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 D K^QAQDATE
 K ^TMP("QANBEN",$J)
 Q
GO ;Set up variables.
 S QANOWARD=0
 S QANLP=QANLWLT
 F  S QANLP=$O(^QA(742.4,"BDT",QANLP)) Q:QANLP'>0!(QANLP>QANUPLT)  D
 . S QANLP(1)=0
 . F  S QANLP(1)=$O(^QA(742.4,"BDT",QANLP,QANLP(1))) Q:QANLP(1)'>0  D
 . . I $G(^QA(742.4,QANLP(1),0))]"" D LGIC I QANQUIT  S QANQUIT=0 Q
 . . S QANLP(2)=0
 . . F  S QANLP(2)=$O(^QA(742,"BCS",QANLP(1),QANLP(2))) Q:QANLP(2)'>0  D
 . . . I $G(^QA(742,QANLP(2),0)) D LGIC1
 . . . I QANQUIT S QANQUIT=0 Q
 . . . S ^TMP("QANBEN",$J,"BEN",QANDIV,QANWARD,QANLP(1),QANLP(2))=""
 S QANHEAD(3)=$S(QANFLG("WARD")="I":"INPATIENTS",QANFLG("WARD")="D":"DOMICILIARY",QANFLG("WARD")="N":"NHCU",QANFLG("WARD")="O":"OUTPATIENTS",1:"ALL INCIDENTS REGARDLESS OF LOCATION")
 I $G(QANDVFLG)'=1 D HDR
 D EN1^QANBENE1
 Q
LGIC ;Set up valid incidents
 S QAN7424=^QA(742.4,QANLP(1),0),QAN("INC")=$P(QAN7424,U,2)
 I QAN("INC")'<200 S QANQUIT=1 Q  ;Quit if NOT a National incident.
 D VALID^QANBENE I 'QANSWCH S QANQUIT=1 Q  ;Quit if NOT a valid incident
 S QANSTAT=+$P(QAN7424,U,8),QANBENE=+$P(QAN7424,U,17)
 I 'QANBENE!(QANFLG("IR STAT")'[QANSTAT) S QANQUIT=1 Q
 S QANDIV=$P(QAN7424,U,22)
 I $G(QANDIV)']"" S QANDIV=0
 I $G(QAN1DIV)]"" I QAN1DIV'=QANDIV S QANQUIT=1 Q
 I '$D(^QA(740,1,"QAN2","B",QANDIV)) S QANDIV=0
 I $G(QANDVFLG)'=1 S QANDIV=0
 Q
HDR ;Header generator.
 S PAGE=PAGE+1 W @IOF,!?69,TODAY,!?69,"Page: ",PAGE,!!
 W ?(IOM-$L(QANHEAD(0))\2),QANHEAD(0),!,?(IOM-$L(QANHEAD(1))\2),QANHEAD(1),!
 W !?(IOM-$L(QANHEAD(2))\2),QANHEAD(2),!
 W !?(IOM-$L(QANHEAD(3))\2),QANHEAD(3)
 I $G(QANDVFLG)=1,($G(QANHEAD(4))]"") W !?(IOM-$L(QANHEAD(4))\2),QANHEAD(4)
 W !!?QANTAB(5),"Total",?QANTAB(6),"Resulted in"
 W !?QANTAB(2),"Incident",?QANTAB(4),"Severity",?QANTAB(5),"Number",?QANTAB(6),"Investigation",!?QANTAB(2),"--------",?QANTAB(4),"--------",?QANTAB(5),"------",?QANTAB(6),"-------------"
 I QANCONT,$D(QANLBL) W !!?QANTAB(2),QANLBL_" (cont)"
 Q
LGIC1 ;Sorting wards into categories.
 Q:$D(^QA(742,"BPRS",-1,QANLP(2)))  ;Quit if a deleted patient
 S QAN742=^QA(742,QANLP(2),0)
 S QANPTTY=+$P(QAN742,U,5),QANWARD=+$P(QAN742,U,6),QANSLEV=+$P(QAN742,U,10)
 I $G(QANWARD)'>0 D
 . S QANINUM=$P(QAN7424,U) ;Incident number
 . S QANWHY="No ward entered for Incident." ;why excluded from report
 . D NOBEN
 . S QANQUIT=1 Q
 I '$D(^SC(QANWARD)) D
 . S QANINUM=$P(QAN7424,U) ;Incident number
 . S QANWHY="Ward has no valid Hospital Location." ;why excluded
 . D NOBEN
 . S QANQUIT=1 Q
 D WARD
 Q
QLOOP ;Save variables for %ZTLOAD.
 F I="^TMP(""QANBEN"",$J,","PAGE","TODAY","QAN*","QAQ*" S ZTSAVE(I)=""
 Q
WARD ;determine if record should be included in report
 S QANWARD=$G(^SC(QANWARD,42)) D
 . I $G(QANWARD)']"" S QANWARD="O" Q
 . I $G(QANWARD) S QANWARD=$P(^DIC(42,QANWARD,0),U,3)
 . I $G(QANWARD)]"" S QANWARD=$S($G(QANWARD)="D":"D",$G(QANWARD)="NH":"N",1:"I") Q
 . I $G(QANWARD)']"" S QANWARD="O"
 S QANXXX=$S(QANFLG("WARD")="C":1,QANFLG("WARD")="A":1,QANFLG("WARD")=QANWARD:1,$G(QANFLG("WARD A")):1,1:0)
 I QANXXX<1 S QANQUIT=1 Q
 Q
TALLY ;create and increment globals for report
 S QANCOUNT("SLEV",QANAA,QANLBL,QANSLEV)=$G(QANCOUNT("SLEV",QANAA,QANLBL,QANSLEV))+1
 I $G(QANINVST)>1 S QANCOUNT("INV",QANAA,QANLBL,QANSLEV)=$G(QANCOUNT("INV",QANAA,QANLBL,QANSLEV))+1
 Q
NOBEN ;process those records without valid ward information for exception
 ;report
 S QANOWARD=QANOWARD+1
 S ^TMP("QANBEN",$J,"NOBEN",QANOWARD)=QANINUM_"^"_QANWHY
 Q
PRNOBEN ;print list of records excluded from report
 I '$D(^TMP("QANBEN",$J,"NOBEN")) Q
 D HDH2
 W !!!?25,"EXCEPTION REPORT"
 W !?10,"The following records were excluded from this report."
 W !?10,"_____________________________________________________"
 W !!?5,"Incident Number",?35,"Reason for Exclusion"
 W !?5,"---------------",?35,"--------------------"
 S QANE=0
 F  S QANE=$O(^TMP("QANBEN",$J,"NOBEN",QANE)) Q:QANE'>0  D
 . S QANLINE=^TMP("QANBEN",$J,"NOBEN",QANE)
 . D:$Y>(IOSL-4) HDH^QANBENE2 Q:QANQUIT
 . W !?6,$P(QANLINE,U),?32,$P(QANLINE,U,2)
 W !!!?25,"End of Report."
 Q
HDH2 ;header for exception report
 W @IOF
 W !?(IOM-$L(QANHEAD(0))\2),QANHEAD(0)
 W !?(IOM-$L(QANHEAD(1))\2),QANHEAD(1)
 W !!?(IOM-$L(QANHEAD(2))\2),QANHEAD(2)
 Q
