ECREDIT ;ALB/CMD - Event Capture Edit Log Report ;Nov 16, 2022@13:37:55
 ;;2.0;EVENT CAPTURE;**159**;8 May 96;Build 61
 ;
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ; Reference to ^%DTC in ICR #10000
 ; Reference to ^XLFDT in ICR #10103
 ; Reference to GETS^DIQ in ICR #2056
 ;
EN ;Main entry point for report
 N %H,ECRDT
 S %H=$H D YX^%DTC S ECRDT=Y
 K ^TMP($J,"ECREDIT"),^TMP($J,"ECRPT")
 D GETREC(ECSORT)
 D PRINT K ^TMP($J,"ECREDIT")
 I ECPTYP="E" D  Q
 .S ^TMP($J,"ECRPT",1)="LOCATION^DSS UNIT(IEN #)^PATIENT^SSN^PROCEDURE^DATE OF PROCEDURE^PROVIDER NAME^ENTERED OR EDITED BY STAFF NAME"
 .K ^TMP($J,"ECREDIT")
 Q
 ;
GETREC(SORT) ; Loop through "ADT" xref of EVENT CAPTURE PATIENT (#721) file and find records to put on report
 ;  Input:
 ;    SORT - sort type
 ;
 ;  Output: none
 ;
 N ECNT   ;record cnt
 N ECL     ;location cnt
 N ECD     ;DSS unit cnt
 N ECDFN   ;DFN
 N ECLOCF  ;Location IEN
 N ECDSSF  ;DSS unit IEN
 N ECDT    ;date index
 N ECREC   ;"0" node
 N ECIEN   ;IEN of file 721
 N NUNIT,NLOC
 S ECNT=0
 ;put locations and units into ien subscripted arrays
 S JJ="" F  S JJ=$O(ECLOC(JJ)) Q:JJ=""  D
 .S NLOC($P(ECLOC(JJ),"^",1))=$P(ECLOC(JJ),"^",2)
 S JJ="" F  S JJ=$O(ECDSSU(JJ)) Q:JJ=""  D
 .S NUNIT($P(ECDSSU(JJ),"^",1))=$P(ECDSSU(JJ),"^",2)
 S ECDT=ECSD-.0001,ECED=ECED+.9999
 F  S ECDT=$O(^ECH("AC",ECDT)) Q:'ECDT  Q:ECDT>ECED  D
 . S ECIEN="" F  S ECIEN=$O(^ECH("AC",ECDT,ECIEN)) Q:'ECIEN  D
 .. S ECREC=$G(^ECH(ECIEN,0))
 .. S ECLOCF=$P(ECREC,U,4),ECDSSF=$P(ECREC,U,7)
 .. I '$D(NLOC(ECLOCF))!('$D(NUNIT(ECDSSF))) Q
 .. D BLDTMP(ECIEN,SORT,.ECNT)
 Q
 ;
BLDTMP(ECIEN,ECSRT,ECCNT) ;add record to list
 ;  Input:
 ;    ECIEN - IEN in the EVENT CAPTURE PATIENT (#721) file
 ;    ECSRT - sort type "D" or "U"
 ;    ECCNT - record counter
 ;
 ;  Output:
 ;    ^TMP($J,"ECREDIT",location,DSS unit,sort,count)
 ;
 N ECLOCA,ECDSS,ECIENS,ECPRCDT,ECUSER,ECPAT,ECERR,ECPROCDT,ECPROC,ECPROV,ECSSN,ECREC,ECKEY
 I +$G(ECIEN)>0 D
 .S ECCNT=+$G(ECCNT)+1
 .S ECIENS=ECIEN_","
 .S ECREC=""
 .D GETS^DIQ(721,ECIENS,"1;2;3;6;8;10;13","IE","ECREC","ECERR")
 .S ECLOCA=$G(ECREC(721,ECIENS,3,"E")) ;Location
 .S ECDSS=+$G(ECREC(721,ECIENS,6,"I")) ;DSS unit
 .S ECPRCDT=+$G(ECREC(721,ECIENS,2,"I")) ;Procedure date/time
 .S ECPROCDT=$$FMTE^XLFDT(ECPRCDT,"5DZ") ;Procedure date
 .S ECUSER=ECREC(721,ECIENS,13,"E") ;Entered/edit by
 .S ECPAT=$E($G(ECREC(721,ECIENS,1,"E")),1,30) ;Patient name
 .S ECSSN=$E($$GETSSN^ECRDSSA(ECIEN),1,10) ;ssn
 .S ECPROC=$E($$GETPROC^ECRDSSA($G(ECREC(721,ECIENS,8,"I"))),1,5) ;Proc. Code
 .S ECPROV=$E($$GETPROV^ECRDSSA(ECIEN),1,30) ;Provider
 .S ECREC=ECPAT_U_ECSSN_U_ECPROC_U_ECPROCDT_U_ECPROV_U_ECUSER
 .S ECKEY=$S(ECSRT="D":ECPRCDT,1:ECUSER)
 .S ^TMP($J,"ECREDIT",ECLOCA,ECDSS,ECKEY,ECCNT)=ECREC
 .S ^TMP($J,"ECREDIT",ECLOCA)=$G(^TMP($J,"ECREDIT",ECLOCA))+1
 .S ^TMP($J,"ECREDIT",ECLOCA,ECDSS)=$G(^TMP($J,"ECREDIT",ECLOCA,ECDSS))+1
 Q
 ;
PRINT ;loop results array and format output
 ;
 N ECCLOC  ;current location
 N ECPLOC  ;previous location
 N ECLOCNM  ;location name
 N ECCDSS  ;current DSS unit
 N ECPDSS  ;previous DSS unit
 N ECDSSNM  ;DSS unit name
 N ECCNT   ;record count
 N ECDAT   ;procedure date/time
 N ECRDT   ;run date
 N ECFDT   ;from date
 N ECTDT   ;to date
 N ECKEY  ;sort key
 N ECSRTBY  ;sort type text
 N ECREC   ;tmp record data
 N CNT,ECNT,PAGE
 S ECRDT=$$FMTE^XLFDT($$NOW^XLFDT,"5DZ")
 S ECFDT=$$FMTE^XLFDT($P(ECSD+.0001,"."),"5DZ")
 S ECTDT=$$FMTE^XLFDT($P(ECED,"."),"5DZ")
 S (ECCLOC,ECPLOC)="",ECNT=1
 S ECSRTBY=$S(ECSORT="D":"Procedure Date",1:"Staff Name")
 U IO
 I '$D(^TMP($J,"ECREDIT")) D  Q
 .S ECCLOC=$O(ECLOC("")),ECCLOC=$P(ECLOC(ECCLOC),"^",2)
 .D HDR W:ECPTYP'="E" !!,?12,"No data to report for the date range selected.",!!
 F  S ECCLOC=$O(^TMP($J,"ECREDIT",ECCLOC)) Q:ECCLOC=""  D
 .I ECCLOC'=ECPLOC D  ;location changed
 ..S ECPLOC=ECCLOC
 ..I $G(^TMP($J,"ECREDIT",ECCLOC))=0 D HDR W:ECTYPE'="E" !!,"    ** No records found on Location that match selection criteria **" Q
 ..D HDR
 .S (ECCDSS,ECPDSS,ECKEY,CNT)=""
 .F  S ECCDSS=$O(^TMP($J,"ECREDIT",ECCLOC,ECCDSS)) Q:'ECCDSS  D
 ..I ECCDSS'=ECPDSS D  Q  ;dss unit changed
 ...S ECPDSS=ECCDSS
 ...D DSSHDR^ECCLIPRO(ECCDSS)
 ...I $G(^TMP($J,"ECREDIT",ECCLOC,ECCDSS))=0 D HDR W:ECPTYPE'="E" !,"** No records found on DSS Unit that match selection criteria **" Q
 ...S ECKEY=""
 ...F  S ECKEY=$O(^TMP($J,"ECREDIT",ECCLOC,ECCDSS,ECKEY)) Q:ECKEY=""  D
 ....S CNT=0
 ....F  S CNT=$O(^TMP($J,"ECREDIT",ECCLOC,ECCDSS,ECKEY,CNT)) Q:CNT=""  D
 .....S ECREC=^TMP($J,"ECREDIT",ECCLOC,ECCDSS,ECKEY,CNT),ECNT=ECNT+1
 .....I ECPTYP="E" S ^TMP($J,"ECRPT",ECNT)=ECCLOC_U_$$GETDSSN^ECRDSSA(ECCDSS,.ECDSSU)_"(IEN #"_ECCDSS_")"_U_ECREC Q  ;Exported fields
 .....W !,$P(ECREC,U),?32,$P(ECREC,U,2),?38,$P(ECREC,U,3),?50,$P(ECREC,U,4),?62,$P(ECREC,U,5),?98,$P(ECREC,U,6)
 .....I $Y>(IOSL-8) D HDR
 Q
 ;
HDR ; print heading
 Q:ECPTYP="E"
 W @IOF W:$G(PAGE) !
 S PAGE=$G(PAGE)+1
 W !?30,"EVENT CAPTURE EDIT LOG REPORT",?80,"Run Date: ",ECRDT,?122,"Page:",PAGE
 W !!,?35,"For Location: ",ECCLOC
 W !,?35,"Date Range: ",ECFDT," - ",ECTDT
 W !,?35,"Sorted By: ",ECSRTBY,!
 W !!,"PATIENT",?32,"SSN",?38,"PROCEDURE",?50,"DATE OF",?62,"PROVIDER",?98,"ENTERED/EDITED"
 W !,?50,"PROCEDURE",?62,"NAME",?98,"BY STAFF NAME"
 W !,$$REPEAT^XLFSTR("-",132)
 Q
 ;
