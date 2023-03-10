ORPDMPHS ;ISP/LMT - PDMP Health Summary Extract ;Apr 24, 2020@13:27:55
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**519,550**;Dec 17, 1997;Build 1
 ;
 ; This routine uses the following ICRs:
 ;   3062 - MAIN^TIULAPIS                 (controlled)
 ;
 Q
 ;
EN(ORRETURN,DFN,ORFILTER) ;
 ;
 ; Input:
 ;         DFN - Patient (#2) IEN
 ;    ORFILTER - Array (Passed by reference). Can filter extract using the values below. Each filter can
 ;                                            include more than one value. Example: ORFILTER("STATUS")="EXN".
 ;                 ORFILTER("STATUS") = E: Error Query; Z: Error Report; C:Canceled Query; X:Canceled Report; N:Never Reviewed;
 ;                                      A: Auto Created Note; M: Manually Created Note
 ;                                      (Optional; Defaults to "EZCXNAM")
 ;                  ORFILTER("DATES") = StartDT:EndDT (Optional; Defaults to all dates)
 ;                 ORFILTER("SHARED") = 1/0 (Optional; Defaults to "10")
 ;
 ; Output:
 ;  ^TMP("ORPDMPHS",$J,SUB1,SUB2)=Query D/T_U_User_U_Delegate Of_U_Status (Cancelled, Error, Never Viewed Report, Reviewed Report)_U_Disclosed To
 ;
 N ORAUTHORIZED,ORCNT,ORDISCTO,ORENDDT,ORIEN,ORNODE0,ORQIEN,ORQUERYDT,ORSHARED,ORSTARTDT,ORSTATUS,ORSUB,ORSUMSTAT,ORVIEWED
 ;
 S ORSUB="ORPDMPHS"
 K ^TMP(ORSUB,$J)
 S ORRETURN=$NA(^TMP(ORSUB,$J))
 S ORCNT=0
 ;
 I $G(DFN)="" Q
 I $G(ORFILTER("STATUS"))="" S ORFILTER("STATUS")="EZCXNAM"
 I $G(ORFILTER("SHARED"))="" S ORFILTER("SHARED")=10
 S ORDISCTO=$$GET^XPAR("ALL","OR PDMP DISCLOSED TO","A","I")
 ;
 S ORIEN=$O(^ORD(101.62,"B",DFN,0))
 ;OR 550 run manual even if not in 101.62 
 ;I 'ORIEN Q
 I ORIEN D
 .S ORSTARTDT=$P($G(ORFILTER("DATES")),":",1)
 .I 'ORSTARTDT S ORSTARTDT=1
 .S ORENDDT=$P($G(ORFILTER("DATES")),":",2)
 .I 'ORENDDT S ORENDDT=9999999
 .I $P(ORENDDT,".",2)="" S ORENDDT=ORENDDT+.24
 .S ORQUERYDT=ORSTARTDT-.0000001
 .F  S ORQUERYDT=$O(^ORD(101.62,ORIEN,1,"B",ORQUERYDT)) Q:'ORQUERYDT!(ORQUERYDT>ORENDDT)  D
 .. S ORQIEN=0
 .. F  S ORQIEN=$O(^ORD(101.62,ORIEN,1,"B",ORQUERYDT,ORQIEN)) Q:'ORQIEN  D
 ... S ORNODE0=$G(^ORD(101.62,ORIEN,1,ORQIEN,0))
 ... S ORSTATUS=$P(ORNODE0,U,4)
 ... S ORSHARED=+$P(ORNODE0,U,5)
 ... S ORVIEWED=$P(ORNODE0,U,7)
 ... S ORAUTHORIZED=$P(ORNODE0,U,8)
 ... ;
 ... S ORSUMSTAT=$$GETSTAT(ORSTATUS,ORVIEWED)
 ... I ORSUMSTAT="" Q
 ... I ORFILTER("STATUS")'[$P(ORSUMSTAT,U,1) Q
 ... I ORFILTER("SHARED")'[ORSHARED Q
 ... ;
 ... S ORCNT=ORCNT+1
 ... S ^TMP(ORSUB,$J,ORQUERYDT,ORQIEN)=ORQUERYDT_U_$P(ORNODE0,U,2)_U_$S(ORAUTHORIZED:"",1:$P(ORNODE0,U,3))_U_$P(ORSUMSTAT,U,2)_U_ORDISCTO
 ;
 I ORFILTER("STATUS")["M" D
 . D ADDMANUAL(ORSUB,DFN,$G(ORFILTER("DATES")))
 ;
 Q
 ;
 ; Get query status
GETSTAT(ORSTATUS,ORVIEWED) ;
 I ORVIEWED="QCANCEL" Q "C^Canceled Query"
 I ORVIEWED="RCANCEL" Q "X^Canceled Report"
 I ORSTATUS<1 Q "E^Error Query"
 I ORVIEWED="ERROR" Q "Z^Error Report"
 I ORSTATUS>0,ORVIEWED="NO" Q "N^Never Viewed Report"
 I ORSTATUS>0,ORVIEWED="YES" Q "A^Note Auto Created"
 Q ""
 ;
 ; Add manually created PDMP notes to ^TMP result
ADDMANUAL(ORSUB,DFN,ORDATES) ;
 ;
 N ORAUTHOR,ORAUTHORIZED,ORCOSIG,ORDATE,ORDATE1,ORDATE2,ORDISCTO,ORDOC,ORI,ORIDT,ORSTATUS
 ;
 K ^TMP("TIU",$J)
 ;
 S ORDATE2=$P($G(ORDATES),":",1)
 I ORDATE2 S ORDATE2=9999999-ORDATE2
 S ORDATE1=$P($G(ORDATES),":",2)
 I ORDATE1 S ORDATE1=(9999999-ORDATE1)
 S ORSTATUS="COMPLETED"
 S ORDOC(1)=$$GETNOTE^ORPDMPNT
 D MAIN^TIULAPIS(DFN,.ORDOC,.ORSTATUS,ORDATE1,ORDATE2,999,1)  ; ICR 3062
 ;
 S ORDISCTO=$$GET^XPAR("ALL","OR PDMP DISCLOSED TO","M","I")
 S ORIDT=0
 F  S ORIDT=$O(^TMP("TIU",$J,ORIDT)) Q:'ORIDT  D
 . S ORI=0
 . F  S ORI=$O(^TMP("TIU",$J,ORIDT,ORI)) Q:'ORI  D
 . . S ORDOC=0
 . . F  S ORDOC=$O(^TMP("TIU",$J,ORIDT,ORI,ORDOC)) Q:'ORDOC  D
 . . . S ORAUTHOR=$G(^TMP("TIU",$J,ORIDT,ORI,ORDOC,1202,"I"))
 . . . I 'ORAUTHOR Q
 . . . S ORCOSIG=$G(^TMP("TIU",$J,ORIDT,ORI,ORDOC,1208,"I"))
 . . . S ORDATE=$G(^TMP("TIU",$J,ORIDT,ORI,ORDOC,1301,"I"))
 . . . I 'ORDATE Q
 . . . ; Check if note was auto created - if it was it would be in 101.62
 . . . I '$D(^ORD(101.62,"AT",ORDOC)) D
 . . . . S ORAUTHORIZED=$$ISAUTH^ORPDMP(ORAUTHOR)
 . . . . S ^TMP(ORSUB,$J,ORDATE,ORDOC_"M")=ORDATE_U_ORAUTHOR_U_$S(ORAUTHORIZED:"",ORCOSIG:ORCOSIG,1:"<See Note>")_U_"Note Manually Created"_U_ORDISCTO
 ;
 K ^TMP("TIU",$J)
 ;
 Q
