RGMTUT98 ;BIR/CML,PTD-Misc. MPI Load COUNTER Utilities ;07/30/02
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**20**;30 Apr 99
 ;
 ;Reference to ^HLMA("AC" and other fields supported by IA #3273
 ;Reference to ^HLCS(870 supported by IA #3335
 ;Reference to ^VAT(391.71,"AXMIT" supported by IA #3422
 ;Reference to ^ORD(101 supported by IA #2596
 ;Reference to ^DPT("AICN", "AICNL", and "ACMORS" supported by IA #2070
 ;
HLMA1 ;check the contents of the ^HLMA("AC" xref - brief data
 S FLG=0 G HLMA
HLMA2 ;check the contents of the ^HLMA("AC" xref - detailed data
 S FLG=1
HLMA ;
 K ^XTMP("RGMT","HLMQHLMA"),MISSP
 S LOCSITE=$P($$SITE^VASITE(),"^",3),TXTCNT=0
 D NOW^%DTC
 S TXT="<<Run - "_$$FMTE^XLFDT(%)_">>"
 I $D(RGHLMQ) D
 .S TXTCNT=TXTCNT+1
 .S ^XTMP("RGMT","HLMQHLMA",LOCSITE,"@@ RUNDATE")=$$FMTE^XLFDT($E(%,1,12))
 .S ^XTMP("RGMT","HLMQHLMA",LOCSITE,TXTCNT)=TXT
 I '$D(RGHLMQ) W !,TXT
 ;
 S TXT="Outgoing messages:"
 I $D(RGHLMQ) S TXTCNT=TXTCNT+1,^XTMP("RGMT","HLMQHLMA",LOCSITE,TXTCNT)=TXT
 I '$D(RGHLMQ) W !,TXT
 ;
 S SITE=0
 F  S SITE=$O(^HLMA("AC","O",SITE)) Q:'SITE  D  I $D(CNT) D WRT
 .K CNT
 .S LINK=$$GET1^DIQ(870,SITE_",",.01) I $E(LINK,1,2)'="VA"&($E(LINK,1,2)'="MP") S QFLG=1 Q
 .K ARR
 .S MSG=0,CNT=0
 .F  S MSG=$O(^HLMA("AC","O",SITE,MSG)) Q:'MSG  D
 ..S CNT=CNT+1
 ..Q:'FLG
 ..S PROT=$$GET1^DIQ(773,MSG_",",8,"I")
 ..Q:'PROT
 ..I '$D(ARR(PROT)) S ARR(PROT)=0
 ..S ARR(PROT)=ARR(PROT)+1
 ;
 S TXT=""
 I $D(RGHLMQ) S TXTCNT=TXTCNT+1,^XTMP("RGMT","HLMQHLMA",LOCSITE,TXTCNT)=TXT
 I '$D(RGHLMQ) W !,TXT
 ;
 S TXT="Incoming messages:"
 I $D(RGHLMQ) S TXTCNT=TXTCNT+1,^XTMP("RGMT","HLMQHLMA",LOCSITE,TXTCNT)=TXT
 I '$D(RGHLMQ) W !,TXT
 S SITE=0
 F  S SITE=$O(^HLMA("AC","I",SITE)) Q:'SITE  D  D WRT
 .K ARR
 .S MSG=0,CNT=0
 .F  S MSG=$O(^HLMA("AC","I",SITE,MSG)) Q:'MSG  D
 ..S CNT=CNT+1
 ..Q:'FLG
 ..S PROT=$$GET1^DIQ(773,MSG_",",8,"I")
 ..Q:'PROT
 ..I '$D(ARR(PROT)) S ARR(PROT)=0
 ..S ARR(PROT)=ARR(PROT)+1
 ;
QUIT K SITE,CNT,MSG,PROT,PROTNM,ARR,LINKNM,MISSP,MSG,GOT,INFLR
 K FLG,LINK,LOCSITE,QFLG,STATE,TXT1,TXT2,TXTCNT
 Q
 ;
PIV ;Count # of entries in pivot file xref
 S CNT=0,IEN=0 F  S IEN=$O(^VAT(391.71,"AXMIT",4,IEN)) Q:'IEN  S CNT=CNT+1
 S TXT="(Total DATA UPDATES waiting to be processed = "_CNT_")"
 I $D(RGHLMQ) S TXTCNT=TXTCNT+1,^XTMP("RGMT","HLMQMONT",LOCSITE,TXTCNT)=TXT
 I '$D(RGHLMQ) W !?3,TXT
 S CNT=0,IEN=0 F  S IEN=$O(^VAT(391.71,"AXMIT",5,IEN)) Q:'IEN  S CNT=CNT+1
 S TXT="(Total TREATING FACILITY UPDATES waiting to be processed = "_CNT_")"
 I $D(RGHLMQ) S TXTCNT=TXTCNT+1,^XTMP("RGMT","HLMQMONT",LOCSITE,TXTCNT)=TXT
 I '$D(RGHLMQ) W !?3,TXT
 K CNT,IEN,TXT
 Q
 ;
WRT ;write type and total for messages
 ;find current STATE of Link
 S STATE=$$GET1^DIQ(870,SITE_",",4)
 S TXT1=$$GET1^DIQ(870,SITE_",",.01)_" - "_CNT_" messages"_$S(FLG:":",1:".")
 S TXT2="STATE: "_STATE
 I $D(RGHLMQ) S TXTCNT=TXTCNT+1,^XTMP("RGMT","HLMQHLMA",LOCSITE,TXTCNT)=TXT1_"    "_TXT2
 I '$D(RGHLMQ) W !,TXT1,?30,TXT2
 Q:'FLG
 S PROT=0
 F  S PROT=$O(ARR(PROT)) Q:'PROT  D
 .S PROTNM=$P($G(^ORD(101,PROT,0)),"^") I PROTNM="" S PROTNM="PROTOCOL NOT FOUND"
 .I $D(RGHLMQ) S TXTCNT=TXTCNT+1,TXT=PROTNM_"  -  "_ARR(PROT),^XTMP("RGMT","HLMQHLMA",LOCSITE,TXTCNT)=TXT
 .I '$D(RGHLMQ) W !?3,PROTNM,?32," - ",$J(ARR(PROT),8)
 Q
 ;
CNT ;do counts
 D SCORE,ICN,LICN
 Q
SCORE ;count number of CMOR scores
 D NOW^%DTC
 W !,"<<Run - ",$$FMTE^XLFDT(%),">>"
 W !,"...counting number of CMOR scores"
 S SC=0,CNT=0
 F  S SC=$O(^DPT("ACMORS",SC)) Q:'SC  D
 .S DFN=0
 .F  S DFN=$O(^DPT("ACMORS",SC,DFN)) Q:'DFN  D
 ..S CNT=CNT+1
 W !?3,"(Current total # of Patients with CMOR Scores = ",CNT,")"
 K %,SC,CNT,DFN
 Q
 ;
ICN ;count number of ICNs
 S HOME=$P($$SITE^VASITE(),"^",3)
 W !!,"...counting number of ICNs"
 S ICN=0,CNT=0
 F  S ICN=$O(^DPT("AICN",ICN)) Q:'ICN  D
 .Q:$E(ICN,1,3)=HOME
 .S CNT=CNT+1
 W !?3,"(Current total # of National ICNs = ",CNT,")"
 K HOME,ICN,CNT
 Q
 ;
LICN ;count number of local ICNs
 W !!,"...counting number of local ICNs"
 S ICN=0,CNT=0
 F  S ICN=$O(^DPT("AICNL",1,ICN)) Q:'ICN  S CNT=CNT+1
 W !?3,"(Current total # of Local ICNs = ",CNT,")"
 K CNT,DFN,ICN
 Q
