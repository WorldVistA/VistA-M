ECLATESH ;ALB/DAN - Possible Late State Home Entries Report ;10/5/17  11:50
 ;;2.0;EVENT CAPTURE;**139**;8 May 96;Build 7
 ;
START ;
 K ^TMP($J,"ECLATESH") ;Clear space for printed report
 D GETRECS
 I $G(ECPTYP)="E" S ^TMP($J,"ECRPT",1)="DSS UNIT^LOCATION^PATIENT^SSN^PROCEDURE DATE/TIME^ENTERED ON DATE/TIME^ENTERED BY^PROCEDURE^VOLUME^PRIMARY PROVIDER" K ^TMP($J,"ECLATESH") Q
 D PRINT
 K ^TMP($J,"ECLATESH") ;Clear space used for printed report
 Q
 ;
GETRECS ;Find records for report
 N CNT,DATE,REC,ECDATA,DSSU,PAT,PDT,IDT,USER,PROC,VOL,PROV,LOC
 S CNT=1
 S DATE=ECSD F  S DATE=$O(^ECH("AC",DATE)) Q:'+DATE!(DATE>ECED)  S REC=0 F  S REC=$O(^ECH("AC",DATE,REC)) Q:'+REC  D
 .I $$GET1^DIQ(721,REC,46,"E")'["LATE" Q  ;Only looking for records with a "l"ate status
 .S CNT=CNT+1
 .D GETS^DIQ(721,REC,"1;2;3;6;8;9;13;47","IE","ECDATA")
 .S DSSU=$G(ECDATA(721,REC_",",6,"E")) ;DSS Unit
 .S PAT=$G(ECDATA(721,REC_",",1,"E")) ;Patient Name
 .S SSN=$$GETSSN^ECRDSSA(REC) ;SSN - 4 digit for printed, 9 for export
 .S PDT=$$FMTE^XLFDT($G(ECDATA(721,REC_",",2,"I")),5) ;Procedure date/time
 .S IDT=$$FMTE^XLFDT($G(ECDATA(721,REC_",",47,"I")),5) ;Import date/time
 .S USER=$G(ECDATA(721,REC_",",13,"E")) ;Entered by
 .S PROC=$$GETPROC^ECRDSSA($G(ECDATA(721,REC_",",8,"I"))) ;Procedure Name
 .S VOL=$G(ECDATA(721,REC_",",9,"E")) ;Volume
 .S PROV=$$GETPROV^ECRDSSA(REC) ;Primary Provider Name
 .S LOC=$G(ECDATA(721,REC_",",3,"E")) ;Location
 .S ^TMP($J,"ECRPT",CNT)=DSSU_U_LOC_U_PAT_U_SSN_U_PDT_U_IDT_U_USER_U_PROC_U_VOL_U_PROV ;Exported fields
 .S ^TMP($J,"ECLATESH",LOC,DSSU,REC)=PAT_U_SSN_U_PDT_U_IDT_U_PROC_U_VOL_U_PROV ;Printed report fields
 .K ECDATA
 Q
 ;
PRINT ;Display results
 N LOC,REC,PAGE,DSSU,TVOL,NODE
 U IO
 I '$D(^TMP($J,"ECLATESH")) W !,"No potentially late entered state home records were found for this date range."
 S LOC="" F  S LOC=$O(^TMP($J,"ECLATESH",LOC)) Q:LOC=""  D
 .D HDR
 .S DSSU="" F  S DSSU=$O(^TMP($J,"ECLATESH",LOC,DSSU)) Q:DSSU=""  D
 ..W !,"DSS Unit: ",DSSU,!
 ..S REC=0 F  S REC=$O(^TMP($J,"ECLATESH",LOC,DSSU,REC)) Q:'+REC  D
 ...S NODE=^TMP($J,"ECLATESH",LOC,DSSU,REC)
 ...W !,$P(NODE,U),?32,$P(NODE,U,2),?38,$P(NODE,U,3),?56,$P(NODE,U,4),?76,$P(NODE,U,5),?85,$J($P(NODE,U,6),5),?93,$P(NODE,U,7) S TVOL=$G(TVOL)+$P(NODE,U,6)
 ...I $Y>(IOSL-4) D HDR
 ..W !,?85,"-----",!,"Total for DSS Unit: ",DSSU,?85,$J(TVOL,5),! S TVOL=0
 Q
 ;
HDR ;
 W @IOF W:$G(PAGE) !
 S PAGE=$G(PAGE)+1
 W ?40,"EVENT CAPTURE POSSIBLE LATE STATE HOME ENTRIES REPORT",?124,"PAGE:",PAGE
 W !,?50,"For Location ",LOC
 W !,?50,"From ",$$FMTE^XLFDT((ECSD+.0001),5)," through ",$$FMTE^XLFDT((ECED-.9999),5)
 W !!,"PATIENT",?32,"SSN",?38,"PROCEDURE",?56,"ENTERED ON",?76,"PROCEDURE",?87,"VOL",?93,"PRIMARY PROVIDER"
 W !,?38,"DATE/TIME",?56,"DATE/TIME"
 W !,$$REPEAT^XLFSTR("-",132)
 Q
 ;
