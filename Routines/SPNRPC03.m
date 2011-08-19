SPNRPC03 ;SD/WDE - Nutrition Dietary Precautions RPC;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^FHPT supported by IA# 4920
 ; Reference to ^FH(119.4 supported by IA# 2319
 ; Reference to ^FH(115.4 supported by IA# 5457
 ; THIS FILE IS NO LONGER ACCESSED: [Requested IA to ^FH(118.2]
 ;
RPC(ROOT,SDATE,EDATE,ICN) ;
 ;parms
 ;
 ; FDATE   = DATE TO START FROM
 ; TDATE   = DATE TO GO TO
 ; ICN     = ICN
 ;
BLD ;  TEMPJUMP IN LINE TAG
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
 S CNT=0
 S X=SDATE S %DT="T" D ^%DT S SDATE=Y
 S X=EDATE S %DT="T" D ^%DT S EDATE=Y
 D PT
 D STATUS
 S CNT=CNT+1
 S ^TMP($J,"UTIL",CNT)="EOR999"_U_"EOL999"
 K %DT,CLINICNA,SHOWDT,X,Y,APPTDT,CL,CLIEN,CLINIC,CLINICS,CLLIST,DFN,FDATE,FILTER,ICN
 K DIETIEN,SDATE,EDATE,RSTDT,TFENT,TFIEN,DIETDT,CNT
 K D1,D2,DISPDT
 Q
 ;-------------------------------------------------------------
PT ;
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:DFN=""  ;NO ICN ON FILE
 S DIETIEN=0 F  S DIETIEN=$O(^FHPT(DFN,"A",DIETIEN)) Q:(DIETIEN="")!('+DIETIEN)  D
 .D CHECK
 Q
CHECK ;
 ;Check if diet is date range
 ; if ok build the top of the record
 S DIETDT=$P($G(^FHPT(DFN,"A",DIETIEN,0)),U,1)
 I $P(DIETDT,".",1)<SDATE Q
 I $P(DIETDT,".",1)>EDATE Q
 S Y=DIETDT X ^DD("DD") S DISPDT=Y
 S CNT=CNT+1
 S D1=$P($G(^FHPT(DFN,"A",DIETIEN,0)),U,10)  ;isolation/precaution
 I D1'="" S D1=$P($G(^FH(119.4,D1,0)),U,1)
 S D2=$P($G(^FHPT(DFN,"A",DIETIEN,0)),U,13)  ;OE/RR isolation order
 S ^TMP($J,"UTIL",CNT)="BOR999"_U_DISPDT_U_D1_U_D2_U_"EOL999"
 ;now check the tube feeding data
 D TUBFEED
 Q
TUBFEED ;--------------------------------------------------------------
 S TFIEN=0 F  S TFIEN=$O(^FHPT(DFN,"A",DIETIEN,"TF",TFIEN)) Q:(TFIEN="")!('+TFIEN)  D
 .S Y=$P($G(^FHPT(DFN,"A",DIETIEN,"TF",TFIEN,0)),U,1)
 .X ^DD("DD") S D1=Y  ;Tubefeeding date
 .S CNT=CNT+1
 .S ^TMP($J,"UTIL",CNT)="BOSTUBEFEEDING999"_U_D1_U_"EOL999"
 .S TFENT=0 F  S TFENT=$O(^FHPT(DFN,"A",DIETIEN,"TF",TFIEN,"P",TFENT)) Q:(TFENT="")!('+TFENT)  D
 ..S Y=$P($G(^FHPT(DFN,"A",DIETIEN,"TF",TFIEN,0)),1)
 ..X ^DD("DD") S D1=Y  ;Tubefeeding date
 ..;JAS 07/18/08 Modifications due to IA Issues found during SQA Checklist
 ..;S D2=$P($G(^FHPT(DFN,"A",DIETIEN,"TF",TFIEN,"P",TFENT,0)),U,1)
 ..;S D2=$P($G(^FH(118.2,D2,0)),U,1)
 ..S D2=$$GET1^DIQ(115.1,TFENT_","_TFIEN_","_DIETIEN_","_DFN,.01)
 ..S CNT=CNT+1
 ..S ^TMP($J,"UTIL",CNT)=D2_U_"EOL999"
 Q
 ;-----------------------------------------------------------------
STATUS ;Get the status node data.  Note that it's not tied to the admission
 S CNT=CNT+1
 S ^TMP($J,"UTIL",CNT)="BOSSTATUS999"_U_"EOL999"
 Q:DFN=""
 ;JAS 03/03/08 - DEFECT 1124 - Modification to allow Status to be retrieved
 ;Q:$G(^FHPT(DFN,"S"))'>0
 Q:'$D(^FHPT(DFN,"S"))
 S RSTDT=0 F  S RSTDT=$O(^FHPT(DFN,"S",RSTDT)) Q:(RSTDT="")!('+RSTDT)  D
 .S Y=$P($G(^FHPT(DFN,"S",RSTDT,0)),U,1)
 .Q:$P(Y,".",1)<SDATE
 .Q:$P(Y,".",1)>EDATE
 .X ^DD("DD") S D1=Y
 .S D2=$P($G(^FHPT(DFN,"S",RSTDT,0)),U,2) S D2=$P($G(^FH(115.4,D2,0)),U,1)_" "_$P($G(^FH(115.4,D2,0)),U,2)
 .S CNT=CNT+1
 .S ^TMP($J,"UTIL",CNT)=D1_U_D2_U_"EOL999"
 .Q
 Q
