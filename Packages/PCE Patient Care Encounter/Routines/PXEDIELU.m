PXEDIELU ;ISL/PKR - Look up Device Interface errors and report them. ;9/18/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**5**;Aug 12, 1996
 ;
 ;=======================================================================
EDT ;Look up by encounter date and time.
 N IEN,EDT,VIEN
 S EDT=BENDT-.0001
 F  S EDT=$O(^AUPNVSIT("B",EDT)) Q:(EDT>EENDT)!(EDT="")  D
 . S VIEN="",VIEN=$O(^AUPNVSIT("B",EDT,VIEN))
 . S IEN=""
 . F  S IEN=$O(^PX(839.01,"AD",VIEN,IEN)) Q:(IEN="")  D
 .. S ^TMP("PXEDI",$J,"EDT",0,IEN)=^PX(839.01,IEN,0)
 Q
 ;
 ;=======================================================================
ERN ;Look up by error number.
 N ERN
 I BERN=0 Q
 S ERN=BERN-1
 F  S ERN=$O(^PX(839.01,ERN)) Q:(ERN>EERN)!(+ERN=0)  D
 . S ^TMP("PXEDI",$J,"ERN",0,ERN)=^PX(839.01,ERN,0)
 Q
 ;
 ;=======================================================================
PAT ;Look up by patient.
 N IC,IEN
 F IC=1:1:NPATIENT D
 . S IEN=""
 . F  S IEN=$O(^PX(839.01,"C",PATIENT(IC),IEN)) Q:(IEN="")  D
 .. S ^TMP("PXEDI",$J,"PAT",PATIENT(IC),IEN)=^PX(839.01,IEN,0)
 Q
 ;
 ;=======================================================================
PDT ;Look up by processing date and time.
 N IEN,PDT
 S PDT=BERDT-.0001
 F  S PDT=$O(^PX(839.01,"B",PDT)) Q:(PDT>EERDT)!(PDT="")  D
 . S IEN="",IEN=$O(^PX(839.01,"B",PDT,IEN))
 . S ^TMP("PXEDI",$J,"PDT",0,IEN)=^PX(839.01,IEN,0)
 Q
 ;
