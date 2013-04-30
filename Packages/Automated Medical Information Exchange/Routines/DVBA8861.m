DVBA8861 ;ALB/DJS - STATUS REPORT OF 8861 REQUESTS FOR MEDICAL SERVICES, CHAPTER 31 ; 8/8/12 4:48pm
 ;;2.7;AMIE;**181**;Apr 10, 1995;Build 38
 ;
 Q  ;no direct entry
 ;
STATRPT(BDATE,EDATE,RORPT,DVBSTAT,DLMTR)   ; entry point of 8861 report
 ;
 ;  Input: 
 ;    BDATE - beginning date for report
 ;    EDATE - ending date for report
 ;    RORPT - regional office to report on or "ALL"
 ;    DVBSTAT - requested status for report
 ;    DLMTR - delimiter indicator (0=no;1=yes)
 ; 
 N EXBDAT  ;beginning date
 N EXEDAT  ;end date
 N EXSTAT  ;request status
 N DVBRS  ;request status conversion results
 N REQERR  ;Fileman error message
 N REQCNT  ;number of found records
 ;
 K ^TMP("VOCREQ",$J)
 S EXBDAT=$$FMTE^XLFDT(BDATE,"5DZ")
 S EXEDAT=$$FMTE^XLFDT(EDATE,"5DZ")
 I DVBSTAT="A" S EXSTAT="ALL"
 E  D
 . D CHK^DIE(396.9,13,"E",DVBSTAT,.DVBRS,"REQERR")
 . S EXSTAT=$G(DVBRS(0))
 S (REQCNT,TOTPEND,AVGPEND,TOTCMPL,AVGCMPL)=0
 F STAT="C","N","P","X" S CNT(STAT)=0
 ;
 ; find records matching search criteria
 D FINDRECS(BDATE,EDATE,RORPT,DVBSTAT,.REQCNT)
 ;
 ; output results
 I 'REQCNT D
 . W "NO DATA FOUND"
 E  D
 . S RGNLOFC=$$SITE^VASITE,SITE=$P(RGNLOFC,U,2)_" ("_$P(RGNLOFC,U,3)_")" S:RORPT="ALL" ROREPRT="ALL"
 . S:RORPT'="ALL" RO4RPT=$$NS^XUAF4(RORPT),ROREPRT=$P(RO4RPT,U,1)_" ("_$P(RO4RPT,U,2)_")"
 . I 'DLMTR D HEADER(EXBDAT,EXEDAT,EXSTAT),PRINTND,NDTOTAL  ;print non-delimited records & totals  
 . I DLMTR D DLMTHDR(EXBDAT,EXEDAT,EXSTAT),PRTDLMT,DLMTOTL  ;print delimited records & totals
 K ^TMP("VOCREQ",$J)
 D KILL
 Q
 ;
FINDRECS(BDAT,EDAT,RORPT,DVBSTAT,CNT) ; find record matches
 ;
 ;  Input:
 ;    BDAT - beginning date for report
 ;    EDAT - ending date for report
 ;    RORPT - regional office to report on or "ALL"
 ;    DVBSTAT - requested status (internal format)
 ;    CNT - record count
 ;
 N REQIEN  ; 8861 Request IEN
 N FLDS  ; field array in external format
 ;
 S STAT="",(DONE,DONE2)=0
 F  S STAT=$O(^DVB(396.9,"ARSDT",STAT)) Q:STAT=""  I (STAT=DVBSTAT)!(DVBSTAT="A") D
 . S REQDT=BDATE
 . F  S REQDT=$O(^DVB(396.9,"ARSDT",STAT,REQDT)) S RQSTDT=$P(REQDT,".") S:REQDT="" DONE=1 Q:(DONE&(REQDT=""))!(RQSTDT>EDATE)!(REQDT<BDATE)  D  S DONE=0
 . . S REQIEN=""
 . . F  S REQIEN=$O(^DVB(396.9,"ARSDT",STAT,REQDT,REQIEN)) S:REQIEN="" DONE2=1 Q:(DONE2&(REQIEN=""))  D  S DONE2=0
 . . . K FLDS
 . . . I $$SETFLDS(REQIEN,.FLDS) D
 . . . . S CNT=CNT+1
 . . . . S ^TMP("VOCREQ",$J,RO,RPTSTAT,NM,CNT)=FLDS("REQDT")_U_FLDS("REQSTAT")_U_FLDS("NM")_U_FLDS("SS")_U_FLDS("POCNM")_U_FLDS("POCLOC")_U_FLDS("PENDING")_U_FLDS("CANCEL")
 . . . . S ^TMP("VOCREQ",$J,RO,RPTSTAT,NM,CNT)=^TMP("VOCREQ",$J,RO,RPTSTAT,NM,CNT)_U_FLDS("COMPLETE")_U_FLDS("CNSTOSVC")_U_FLDS("APPTDAYS")_U_FLDS("APPTDT")_U_FLDS("CNSLDT")
 . . . Q
 . . Q
 . Q
 Q
 ;
SETFLDS(REQIEN,REQFLDS)  ;build field array in external format
 ;
 ;  Integration Agreement Reference # 10061 - DEM^VADPT
 ;
 ;  Input:
 ;    REQIEN - 8861 Request IEN
 ;    REQFLDS - field array passed by reference
 ;
 ;  Output:
 ;    REQFLDS("REQDT") - request date
 ;    REQFLDS("REQSTAT") - request status
 ;    REQFLDS("NM") - patient name
 ;    REQFLDS("SS") - patient SSN
 ;    REQFLDS("POCNM") - POC name
 ;    REQFLDS("POCLOC") - POC location (RO name & station number)
 ;    REQFLDS("APPTDT") - appointment dates
 ;    REQFLDS("CNSLDT") - date consult is linked to 8861 request
 ;    REQFLDS("CNSTITL") - consult To Service
 ;    REQFLDS("PENDING") - number of days pending for pending requests
 ;    REQFLDS("CANCEL") - number of days from receipt of 8861 to cancellation
 ;    REQFLDS("COMPLETE") - number of days from receipt of 8861 to complete
 ;    RO - Regional Office of requestor used to filter records by
 ;
 N DFN   ; PATIENT file IEN used in VADPT call
 N DVBREQ  ; 8861 Request data field array
 N REQSTAT  ; status of current request
 N REQRSLT  ; function result
 N DVBCNARR  ; consult return array
 N CNSLTS  ; consults data array
 N VADM  ; VADPT return array
 N FLDS  ; results return array
 N APPTARY  ; appointment retrieval array
 N APPTCNT  ; count of appointments
 N APPTDT1  ; retrieved appointment record(s)
 ;
 S (REQRSLT,PENDING,DAYS2CMP,CANCEL)=0
 D NOW^%DTC S TODAY=X
 S REQIENS=+$G(REQIEN)_","
 D GETS^DIQ(396.9,REQIENS,".01;2;3;4;11;13;15","IE","DVBREQ","")
 S REQFLDS("POCNM")=$G(DVBREQ(396.9,REQIENS,11,"E"))
 S RO=$G(DVBREQ(396.9,REQIENS,3,"I")) I RO'=RORPT&(RORPT'="ALL") S REQRSLT=0 Q REQRSLT
 I RO'="" S ROSTANM=$$NS^XUAF4(RO),REQFLDS("POCLOC")=$P(ROSTANM,U,1)_" ("_$P(ROSTANM,U,2)_")"
 E  I RO="" S RO=0,REQFLDS("POCLOC")="UNDEFINED"
 S DFN=$G(DVBREQ(396.9,REQIENS,4,"I"))
 D DEM^VADPT
 I $G(VADM(1))'="" D
 . S (REQFLDS("NM"),NM)=$G(VADM(1))
 . S REQFLDS("SS")=+$G(VADM(2))
 . S REQESTDT=$G(DVBREQ(396.9,REQIENS,.01,"I"))
 . S REQFLDS("REQDT")=$$FMTE^XLFDT(REQESTDT,"2DZ")
 . S REQFLDS("COMPLETE")=0
 . I STAT="C" S COMPLTDT=$G(DVBREQ(396.9,REQIENS,2,"I")) I $G(COMPLTDT)'="" S DAYS2CMP=+$$FMDIFF^XLFDT(COMPLTDT,REQESTDT),TOTCMPL=TOTCMPL+DAYS2CMP,REQFLDS("COMPLETE")=DAYS2CMP
 . I STAT'="X" S REQFLDS("CANCEL")=0
 . E  I STAT="X" S CANCLDT=$G(DVBREQ(396.9,REQIENS,15,"I")) I $G(CANCLDT)'="" S CANCEL=+$$FMDIFF^XLFDT(CANCLDT,REQESTDT),REQFLDS("CANCEL")=CANCEL
 . S REQFLDS("REQSTAT")=$G(DVBREQ(396.9,REQIENS,13,"E"))
 . S (REQFLDS("CNSLDT"),REQFLDS("CNSTOSVC"),REQFLDS("APPTDT"))="",REQFLDS("APPTDAYS")=0
 . D GETS^DIQ(396.9,REQIENS,"14*","I","DVBCNARR","ARRAY")
 . S CNSLDT=""
 . I '$D(ARRAY)&($D(DVBCNARR)) D
 . . S (CONIENS,CNSLIENS)=""
 . . S CONIENS=$O(DVBCNARR(396.914,CONIENS)) Q:CONIENS=""  D
 . . . S CNSLIENS=+$G(DVBCNARR(396.914,CONIENS,.01,"I"))_","
 . . . D GETS^DIQ(123,CNSLIENS,"1;3","IE","CNSLTS","CNSLERR")
 . . . I '$D(CNSLERR) D
 . . . . S CNSLDT=$G(CNSLTS(123,CNSLIENS,3,"I"))
 . . . . S REQFLDS("CNSLDT")=$$FMTE^XLFDT($G(CNSLTS(123,CNSLIENS,3,"I")),"2DZ")
 . . . . S REQFLDS("CNSTOSVC")=$G(CNSLTS(123,CNSLIENS,1,"E"))
 . . . . ; get appointment data
 . . . . K ^TMP($J,"SDAMA301")
 . . . . S APPTARY("FLDS")="1;33",APPTARY("SORT")="P",APPTARY(4)=DFN,APPTARY(1)=CNSLDT
 . . . . S APPTCNT=$$SDAPI^SDAMA301(.APPTARY) I APPTCNT<0 S APPTERR=$$ERR() Q
 . . . . I APPTCNT>0 S APPTDT="" F  S APPTDT=$O(^TMP($J,"SDAMA301",DFN,APPTDT)) Q:APPTDT']""  S APPTDT1=$G(^TMP($J,"SDAMA301",DFN,APPTDT,0)) Q:APPTDT1']""  D
 . . . . . S CNSLT=+$G(DVBCNARR(396.914,CONIENS,.01,"I")),CNSLTLNK=$P(APPTDT1,U,6) Q:('$G(CNSLTLNK)!(CNSLT'=CNSLTLNK))
 . . . . . S REQFLDS("APPTDT")=$$FMTE^XLFDT(APPTDT,"2DZ")
 . . . . . S APPTDAYS=+$$FMDIFF^XLFDT(APPTDT,REQDT),REQFLDS("APPTDAYS")=APPTDAYS
 . . . . . K ^TMP($J,"SDAMA301")
 . . . . Q
 . . . Q
 . . Q
 . S REQFLDS("PENDING")=0  ; do not calculate number of days pending unless status="P" (below)
 . I STAT="P"&($G(CNSLDT)'="") S PENDING=+$$FMDIFF^XLFDT(TODAY,CNSLDT),REQFLDS("PENDING")=PENDING,TOTPEND=TOTPEND+PENDING
 . S RPTSTAT=STAT
 . S REQRSLT=1
 Q REQRSLT
 ;
ERR() ; Process error message.
 N APPTERR
 S APPTERR=0
 I $D(^TMP($J,"SDAMA301",101)) D
 . S APPTERR=101_"^"_"  *** RSA: Process DATABASE IS UNAVAILABLE ***"
 I $D(^TMP($J,"SDAMA301",115)) D
 . S APPTERR=115_"^"_"  *** RSA: Appointment request filter contains invalid values ***"
 I $D(^TMP($J,"SDAMA301",116)) D
 . S APPTERR=116_"^"_"  *** RSA: Data doesn't exist error has occurred ***"
 I $D(^TMP($J,"SDAMA301",117)) D
 . S APPTERR=117_"^"_"  *** RSA: Other undefined error has occurred ***"
 Q APPTERR
 ;         
DLMTHDR(EXBDAT,EXEDAT,EXSTAT)  ;output delimited format header
 ;
 ;  Input:
 ;    EXBDAT - beginning date (external format)
 ;    EXEDAT - ending date (external format)
 ;    EXSTAT - request status (external format)
 ;
 W "8861 Request for Medical Services, Chapter 31 Status Report"
 W !,"Date Range: "_EXBDAT_" - "_EXEDAT
 W !,"Regional Office: ",ROREPRT," for site: ",SITE
 W !,"Request Status: ",EXSTAT
 W !,"DateReceived^ReqStat^PatientName^SSN^POCName^POCLocation^PendDays^CnclDays^Consults^ApptDays^ApptDate^ConsultDate"
 Q
 ;
PRTDLMT ; output delimited format details
 ;
 N REGOFF  ; regional office - sort criteria
 N VOCG  ; generic counter
 ;
 S REGOFF=""
 F  S REGOFF=$O(^TMP("VOCREQ",$J,REGOFF)) Q:REGOFF=""  D
 . I RORPT="ALL" S RO4RPT=$$NS^XUAF4(REGOFF),REGOPRT=$S(REGOFF=0:"UNSPECIFIED",1:$P(RO4RPT,U,1)_" ("_$P(RO4RPT,U,2)_")") W !!!,"  Regional Office:  " W REGOPRT,!?20 F I=1:1:$L(REGOPRT) W "-"
 . I DVBSTAT="A" F RSTAT="N","P","X","C" D DLM
 . E  I DVBSTAT'="A" S RSTAT=RPTSTAT D DLM
 Q
 ;
DLM ; write delimited detail data
 ;
 Q:'$D(^TMP("VOCREQ",$J,REGOFF,RSTAT))
 I $D(^TMP("VOCREQ",$J,REGOFF,RSTAT)) W !
 S NM=""
 F  S NM=$O(^TMP("VOCREQ",$J,REGOFF,RSTAT,NM)) Q:NM=""  D
 . S VOCG=""
 . F  S VOCG=$O(^TMP("VOCREQ",$J,REGOFF,RSTAT,NM,VOCG)) Q:VOCG=""  D
 . . I $P(^TMP("VOCREQ",$J,REGOFF,RSTAT,NM,VOCG),U,7)=0 S $P(^TMP("VOCREQ",$J,REGOFF,RSTAT,VOCG),U,7)=""  ; don't print 0 days pending
 . . W !,^TMP("VOCREQ",$J,REGOFF,RSTAT,NM,VOCG)
 . . S CNT(RSTAT)=CNT(RSTAT)+1
 Q
 ;
DLMTOTL ;  print totals in delimited format
 ;
 ;  Input: 
 ;    AVGPEND - average days pending
 ;    AVGCMPL - average days to complete
 ;
 S:TOTPEND AVGPEND=TOTPEND\CNT("P") S:TOTCMPL AVGCMPL=TOTCMPL\CNT("C")
 ;
 W !!,"Avg Days^Avg Days^New^Pending^Cancelled^Complete",!
 W "Totals for R.O.^Pending^Complete^Requests^Requests^Requests^Requests^Totals",!
 W ROREPRT_"^"_AVGPEND_"^"_AVGCMPL_"^"_$G(CNT("N"))_"^"_$G(CNT("P"))_"^"_$G(CNT("X"))_"^"_$G(CNT("C"))_"^"_REQCNT
 Q
 ;    
HEADER(EXBDAT,EXEDAT,EXSTAT)  ;  print plain format header
 ;
 ;  Input:
 ;    EXBDAT - beginning date (external format)
 ;    EXEDAT - ending date (external format)
 ;    EXSTAT - request status (external format)
 ;
 W "8861 Request for Medical Services, Chapter 31 Status Report"
 W !,"Date Range: ",EXBDAT," - ",EXEDAT
 W !,"Regional Office: ",ROREPRT," for site: ",SITE
 W !,"Request Status: ",EXSTAT
 W !!,"Date",?17,"Patient",?43,"POC",?59,"POC",?78,"Pend",?83,"Canc",?88,"Comp",?93,"Consult",?109,"Appt  Appt",?122,"Consult"
 W !,"Received",?9,"Status",?17,"Name",?38,"SSN",?43,"Name",?59,"Location"
 W ?78,"Days",?83,"Days",?88,"Days",?93,"Service",?109,"Days  Date",?122,"Date"
 Q
 ;
PRINTND ;  output plain format details
 ;
 N REGOFF  ; regional office - sort criteria
 N VOCG  ; generic counter
 ;
 S REGOFF=""
 F  S REGOFF=$O(^TMP("VOCREQ",$J,REGOFF)) Q:REGOFF=""  D
 . I RORPT="ALL" S RO4RPT=$$NS^XUAF4(REGOFF),REGOPRT=$S(REGOFF=0:"UNSPECIFIED",1:$P(RO4RPT,U,1)_" ("_$P(RO4RPT,U,2)_")") W !!!,"  Regional Office:  " W REGOPRT,!?20 F I=1:1:$L(REGOPRT) W "-"
 . I DVBSTAT="A" F RSTAT="N","P","X","C" D ND1
 . E  I DVBSTAT'="A" S RSTAT=RPTSTAT D ND1
 Q
 ;
ND1 ; write plain detail data
 ;
 Q:'$D(^TMP("VOCREQ",$J,REGOFF,RSTAT))
 I $D(^TMP("VOCREQ",$J,REGOFF,RSTAT)) W !
 S NM=""
 F  S NM=$O(^TMP("VOCREQ",$J,REGOFF,RSTAT,NM)) Q:NM=""  D
 . S VOCG=""
 . F  S VOCG=$O(^TMP("VOCREQ",$J,REGOFF,RSTAT,NM,VOCG)) Q:VOCG=""  D
 . . S VOCREC=^TMP("VOCREQ",$J,REGOFF,RSTAT,NM,VOCG)
 . . S CNT(RSTAT)=CNT(RSTAT)+1
 . . S REQDT=$P(VOCREC,U),REQSTAT=$E($P(VOCREC,U,2),1,4),PATIENT=$E($P(VOCREC,U,3),1,22),SSN=$P(VOCREC,U,4),LN=$L(SSN),SSN1=$E(SSN,LN-3,LN),POCNM=$E($P(VOCREC,U,5),1,15),POCLOC=$E($P(VOCREC,U,6),1,20)
 . . S PENDING=$P(VOCREC,U,7),CANCEL=$P(VOCREC,U,8),COMPLETE=$P(VOCREC,U,9),CNSTOSVC=$E($P(VOCREC,U,10),1,15),APPTDAYS=$P(VOCREC,U,11),APPTDT=$P(VOCREC,U,12),CNSLDT=$P(VOCREC,U,13)
 . . W !,REQDT,?10,REQSTAT,?15,PATIENT,?38,SSN1,?43,POCNM,?59,POCLOC
 . I PENDING W ?78,$J(PENDING,3)
 . I CANCEL W ?83,$J(CANCEL,3)
 . I COMPLETE W ?88,$J(COMPLETE,3)
 . W ?93,CNSTOSVC
 . I APPTDAYS W ?109,$J(APPTDAYS,2)
 . W ?113,APPTDT,?122,CNSLDT
 Q
 ;
NDTOTAL ; print plain format totals section
 ;
 ;  Input:
 ;   AVGPEND - average days pending
 ;   AVGCMPL - average days to complete
 ;
 S:(TOTPEND&$G(CNT("P"))) AVGPEND=TOTPEND\CNT("P") S:(TOTCMPL&$G(CNT("C"))) AVGCMPL=TOTCMPL\CNT("C")
 S REQCNT=$J(REQCNT,3)
 ;
 W !!!?27,"Avg Days",?37,"Avg Days",?46,"New",?56,"Pending",?66,"Cancelled",?77,"Complete"
 W !?3,"Totals for R.O.",?27,"Pending",?37,"Complete",?46,"Requests",?56,"Requests",?66,"Requests",?77,"Requests",?87,"Totals"
 W !!?2,ROREPRT,?30,AVGPEND,?41,AVGCMPL,?49,$G(CNT("N")),?59,$G(CNT("P")),?70,$G(CNT("X")),?80,$G(CNT("C")),?88,REQCNT,!
 Q
 ;
KILL  ; kill local variables
 ;
 K APPTARY,APPTDAYS,APPTDT,APPTDT1,APPTERR,ARRAY,AVGCMPL,AVGPEND,CANCEL,CANCLDT,CNSLDT,CNSLERR,CNSLIENS,CNSLT,CNSLTLNK,CNSLTS
 K CNSTOSVC,COMPLETE,COMPLTDT,CONIENS,DAYS2CMP,DONE,DONE2,DVBCNARR,DVBREQ,DVBRS,DVBSTAT,I,LN,NM,PATIENT,PENDING,POCLOC,POCNM,REGOPRT
 K REQDT,REQESTDT,REQIENS,RGNLOFC,RO,RO4RPT,ROREPRT,ROSTANM,RPTSTAT,RQSTDT,RSTAT,SITE,SSN,SSN1,STAT,TODAY,TOTCMPL,TOTPEND,VOCREC,X
 Q
