SPNRPCQ ;SD/WDE - Returns LAB TEST/DRUG NAMES;JUL 17, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;Pharmacy Reference to PSS50 DBIA #4533 TAG ZERO in line tag NDC
 ;
 ;Lab Reference to DBIA91-A CUSTODIAL PACKAGE: LAB SERVICE
 ;Clinic Reference to DBIA 10040 Hospital Location file access
 ;
 ;Scheduling Reference to ^SC supported by IA# 10040
 ;
 ;Used to generate a list of selectable labs or drugs hospital location names
 ;
 ;
 ;
COL(ROOT,TYPE) ;
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
 I (TYPE'="LAB")&(TYPE'="NDC")&(TYPE'="PROS")&(TYPE'="CLINIC") S ^TMP($J,1)="No tag by this name" Q
 D @TYPE
 K CNT,CODENAM,D,DES,DFN,DRGIEN
 K DRGNAM,FDATE,HIUSERS,IEN,LAB,LOC
 K OLDCNT,QLIST,TESTNAM,PTLIST,TESTNUM,TIUDA,VADRGCL
 Q
LAB ;-------------------------------------------------------------------
 ;         Lab test names  (ORIG SPNLRR)
 S CNT=0
 S LAB=0 F  S LAB=$O(^LAB(60,LAB)) Q:(LAB="")!('+LAB)  D
 .S LOC=$P($G(^LAB(60,LAB,0)),U,5)
 .Q:LOC=""  ;LOCATION (DATA NAME) not defined in ^LAB(60.
 .S TESTNAM=$P($G(^LAB(60,LAB,0)),U,1)
 .S TESTNUM=$P(LOC,";",2)
 .;S ^TMP($J,"UTIL",TESTNAM,CNT)=TESTNAM_U_TESTNUM  ;TMP IN ALPHA ORDER
 .S ^TMP($J,"UTIL",TESTNAM,CNT)=TESTNUM_U_TESTNAM
 .S CNT=CNT+1
 .Q
 S TESTNAM="",CNT=0
 F  S TESTNAM=$O(^TMP($J,"UTIL",TESTNAM)) Q:TESTNAM=""  D
 .S OLDCNT=0 F  S OLDCNT=$O(^TMP($J,"UTIL",TESTNAM,OLDCNT)) Q:'+OLDCNT  D
 ..S CNT=CNT+1 S ^TMP($J,CNT)=$G(^TMP($J,"UTIL",TESTNAM,OLDCNT))_"^EOL999"
 .Q
 K ^TMP($J,"UTIL")
 Q
 ;---------------------------------------------------------------------
NDC ;
 ;RETURNS
 ;      3085^ZYMACAP CAPS^NO VA DRUG CLASS^EOL999
 ;      7241^ZYPREXA ZYDIS 15MG^CN709^EOL999
 ;      6987^ZYPREXA ZYDIS 5MG TAB^CN709^EOL999
 ;      3993^ZZACETAMINOPHEN 325mg SUPPOSITORY (ea)^NO VA DRUG CLASS^EOL999
 ;          
 ;
 S SPNCNT=0
 K ^TMP($J)
 ; Next two lines added for defect SCI1025
 ; D ZERO^PSS50(,"??",,,,"TMP")
 S IDATE=DT
 D ZERO^PSS50(,"??",IDATE,,,"TMP")
 S SPNDRNA="" F  S SPNDRNA=$O(^TMP($J,"TMP","B",SPNDRNA)) Q:(SPNDRNA="")  D
 .S SPNIEN=0 F  S SPNIEN=$O(^TMP($J,"TMP","B",SPNDRNA,SPNIEN)) Q:(SPNIEN="")!('+SPNIEN)  D
 ..S SPNVADRG=$P($G(^TMP($J,"TMP",SPNIEN,2)),U,1)
 ..S SPNCNT=SPNCNT+1
 ..S ^TMP($J,SPNCNT)=SPNIEN_"^"_SPNDRNA_"^"_SPNVADRG_"^EOL999"
 ..Q
 .Q
 K ^TMP($J,"TMP")
 K SPNVADRG,SPNDRNA,SPNCNT,SPNIEN,IDATE
 Q
CLINIC ;
 S CNT=0
 S CLNAM=0
 F  S CLNAM=$O(^SC("B",CLNAM)) Q:CLNAM=""  S IEN=0 F  S IEN=$O(^SC("B",CLNAM,IEN)) Q:(IEN="")!('+IEN)  D
 .S CNT=CNT+1
 .S ^TMP($J,CNT)=IEN_U_CLNAM_U_"EOL999"
 K CLNAM,IEN,CNT
