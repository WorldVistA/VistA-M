DVBAB4 ;ALB/KLB - CAPRI Exam checklist for RO ;03/01/00
 ;;2.7;AMIE;**35**;Apr 10, 1995
STRT(MSG) ;
 K ^TMP($J,"CAPRI")
 S CNT=1
 S ^TMP($J,"CAPRI",CNT,0)=";;Exam Checklist for the Regional Office",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;VA Regional Office - "_$$SITE^DVBCUTL4,CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;Compensation and Pension Examination Request Worksheet",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;Veteran's Name: _______________________________________     VAMC: ____________________",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)=";;C-Number: _______________         SSN: _______________",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;Telephone-Day: _______________  Night: _______________     Power of Attorney: _______________",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;Date Ordered: _______________                               By: _________________________",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;Priority of Exam: _______________        (   ) Insufficient Exam Dated: _______________",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)="                                                                        ;;(See Remarks)",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;(   ) General Medical Examination        (   ) Review of Pertinent Medical Records in",CNT=CNT+1
 S ^TMP($J,"CAPRI",CNT,0)=";;                                               Claims Folder is Required Prior to Examinations",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1,^TMP($J,"CAPRI",CNT,0)="",CNT=CNT+1
 S DIF="^TMP($J,""CAPRI"",",XCNP=CNT
 F ROU="DVBCEXM1" S X=ROU X ^%ZOSF("LOAD")
 ;M MSG=^TMP($J,"CAPRI")
 K DIF,XCNP,ROU
 S A=0
 F  S A=$O(^TMP($J,"CAPRI",A)) Q:'A  D
 .S XXX=$G(^TMP($J,"CAPRI",A,0))
 .I (XXX[";AMIE;")!(XXX["TOF")!(XXX["END") K ^TMP($J,"CAPRI",A,0)
 .E  S MSG(A)=$P(XXX,";;",2)
 K ^TMP($J,"CAPRI")
 K A,CNT,X
 Q
