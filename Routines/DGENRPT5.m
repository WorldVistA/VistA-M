DGENRPT5 ;ALB/DW,LBD,GAH,PHH - EGT Impact Report Utility; 06/21/2007
 ;;5.3;Registration;**568,725,758**;Aug 13,1993;Build 1
 ;
 ;
 Q
GETAPPT(TYPE) ; Set up array of Patient IENs for SD API to process
 N VETARRAY,PIEN,PNAME,RCNT,ACNT,DGARRAY,SDCNT,I
 S ACNT=1,RCNT=0
 S PNAME="" F  S PNAME=$O(^TMP($J,TYPE,PNAME)) Q:PNAME=""  D
 .S PIEN=0 F  S PIEN=$O(^TMP($J,TYPE,PNAME,PIEN)) Q:'PIEN  D
 ..S RCNT=RCNT+1,VETARRAY(ACNT)=$G(VETARRAY(ACNT))_PIEN_";"
 ..; Group DFNs by no more than twenty records
 ..I RCNT>19 S ACNT=ACNT+1,RCNT=0
 ;
 ; Call SD API by array of Patient DFNs
 F I=1:1 Q:'$D(VETARRAY(I))  D
 .S DGARRAY("FLDS")="1;2;3;10",DGARRAY(4)=VETARRAY(I)
 .S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 .I SDCNT<0 D
 ..N ERR,ERROR,CNT
 ..S ERR=$O(^TMP($J,"SDAMA301",""))
 ..D
 ...I ERR=101 S ERROR="Appt. DB unavail. Try later" Q
 ...I ERR=115 S ERROR="Invalid reqst, Call help desk" Q
 ...I ERR=117 S ERROR="Error:  Check RSA error log" Q
 ...I ERR=113 S ERROR="Bad appt,pat stat fltr combo" Q
 ...I ERR=109 S ERROR="Invalid appt status filter" Q
 ...S ERROR=^TMP($J,"SDAMA301",ERR)
 ..F CNT=1:1:$L(VETARRAY(I),";")-1 S ^TMP($J,"SDAMA",$P(VETARRAY(I),";",CNT),"ERROR")=ERROR
 .;
 .I SDCNT>0 M ^TMP($J,"SDAMA")=^TMP($J,"SDAMA301")
 .K ^TMP($J,"SDAMA301")
 .K DGARRAY
 Q
 ;
BLDUTL(DFN) ; Build Utility Global Entries for records processed
 Q:'$D(^TMP($J,"SDAMA",DFN))
 N CLIEN,APPTDT,NODE,APPTNUM S APPTNUM=1
 S CLIEN=0  F  S CLIEN=$O(^TMP($J,"SDAMA",DFN,CLIEN)) Q:'CLIEN  D
 .S APPTDT=0 F  S APPTDT=$O(^TMP($J,"SDAMA",DFN,CLIEN,APPTDT)) Q:'APPTDT  D
 ..Q:APPTDT'>DT
 ..S NODE=^TMP($J,"SDAMA",DFN,CLIEN,APPTDT)
 ..S ^UTILITY("VASD",$J,APPTNUM,"E")=$$FMTE^DILIBF($P(NODE,U),"5U")_U_$P($P(NODE,U,2),";",2)_U_U_$P($P(NODE,U,10),";",2)
 ..S ^UTILITY("VASD",$J,APPTNUM,"I")=NODE,APPTNUM=APPTNUM+1
 K ^TMP($J,"SDAMA",DFN)
 Q
