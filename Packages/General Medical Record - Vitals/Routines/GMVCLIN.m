GMVCLIN ;HOIFO/YH,FT-RETURNS A LIST OF PATIENTS WITH CLINIC APPOINTMENTS WITHIN A GIVEN PERIOD ;6/24/03  10:32
 ;;5.0;GEN. MED. REC. - VITALS;**1**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;  #3869 - ^SDAMA202 calls        (controlled)
 ; #10040 - ^SC( references        (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ;
CLINPTS(RESULT,CLIN,BDATE) ; GMV CLINIC PT [RPC entry point]
 ; Return list of patients with clinic appointments within given period
 ; Input:
 ;   RESULT - array name to return data in
 ;     CLIN - clinic name
 ;    BDATE - TODAY, TOMORROW, YESTERDAY, PAST WEEK, OR PAST MONTH
 ;
 ;  Output:
 ;   RESULT(n)=DFN^patient name^clinic name^appt date/time (external)^
 ;             SSN^DOB (external)^sex, age^^...^^^^^...
 ;
 ;   RESULT(1)=contains any error message
 ;
 N DFN,EDATE,GMVCLIN,GMVCNT,GMVDT,GMVI,GMVJ,GMVNODE,GMVNOW
 N GMVOUT,GMVPAT,GMVRESLT,NAME,X
 K RESULT
 I '$D(^SC("B",CLIN)) S RESULT(1)="ERROR^No clinic identified" G QCLIN
 S GMVCLIN=$O(^SC("B",CLIN,0))
 I GMVCLIN'>0 S RESULT(1)="ERROR^No clinic identified" G QCLIN
 S GMVNOW=$$NOW^XLFDT,EDATE=$P(GMVNOW,".")_".24"
 S BDATE=$$UP^XLFSTR(BDATE)
 S BDATE=$S(BDATE="TODAY":"T",BDATE="TOMORROW":"T+1",BDATE="YESTERDAY":"T-1",BDATE="PAST WEEK":"T-7",BDATE="PAST MONTH":"T-30",1:"")
 I BDATE="" S RESULT(1)="ERROR^Error in date range." G QCLIN
 ; convert bdate and edate into fileman date/time
 D DT^DILF("T",BDATE,.BDATE,"","")
 I BDATE>EDATE S EDATE=BDATE_".24"
 ; call scheduling api to get appt data
 D GETPLIST^SDAMA202(GMVCLIN,"1;4;","R",BDATE,EDATE,.GMVRESLT,"")
 ; if GMVRESLT < 0, scheduling api returned an error
 I GMVRESLT<0 D  G QCLIN
 .S RESULT(1)="ERROR"_U_$O(^TMP($J,"SDAMA202","GETPLIST","ERROR",0))
 .Q
 ; generate error message if # of appts > 200
 I $D(^TMP($J,"SDAMA202","GETPLIST",201,0)) D  G QCLIN
 .S RESULT(1)="ERROR^Too many appointments found. Please narrow search."
 .Q
 S (GMVCNT,GMVI)=0
 F  S GMVI=$O(^TMP($J,"SDAMA202","GETPLIST",GMVI)) Q:'GMVI  D
 .S GMVNODE=^TMP($J,"SDAMA202","GETPLIST",GMVI,4) ;dfn^patient name
 .Q:$P(GMVNODE,U,1)=""!($P(GMVNODE,U,2)="")
 .S DFN=$P(GMVNODE,U,1),NAME=$P(GMVNODE,U,2)
 .S GMVDT=$P(^TMP($J,"SDAMA202","GETPLIST",GMVI,1),U,1) ;appt date/time
 .S GMVOUT(NAME,DFN)=DFN_"^"_NAME_"^"_CLIN_"^"_$$FMTE^XLFDT(GMVDT)
 .S GMVCNT=GMVCNT+1
 .Q
 I $D(GMVOUT) D
 .S GMVI=0,NAME=""
 .F  S NAME=$O(GMVOUT(NAME)) Q:NAME=""  D
 ..S DFN=0
 ..F  S DFN=$O(GMVOUT(NAME,DFN)) Q:'DFN  D
 ...S GMVPAT=""
 ...D PTINFO^GMVUTL3(.GMVPAT,DFN)
 ...S GMVI=GMVI+1,RESULT(GMVI)=GMVOUT(NAME,DFN)_"^"_GMVPAT
 ...Q
 ..Q
 .Q
QCLIN ; called from above
 I '$D(RESULT(1)) S RESULT(1)="No patients found"
 K ^TMP($J,"SDAMA202")
 Q
 ;
