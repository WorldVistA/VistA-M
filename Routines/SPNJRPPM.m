SPNJRPPM ;BP/JAS - Returns ADT Patient movement entries for requested date ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DGPM("B" supported by IA# 92
 ; References to ^DGPM(D0,0 supported by IA# 4942
 ; Reference to ^DG(405.3 supported by IA# 433
 ; Reference to file 4 supported by IA# 10090
 ; Reference to ^DIC(42 supported by IA# 10039
 ; Reference to ^DG(405.4 supported by IA# 1380
 ; Reference to file 200 supported by IA# 10060
 ; Reference to file 45.7 supported by IA# 1154
 ; Reference to ^DPT(D0,"MPI" supported by IA# 4938
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ; API COL^SPNJRPCS is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     ICNLST is the list of patient ICNs to process
 ;     ACTDATE: is the beginning date of patient movement activity 
 ;     RETURN: is the sorted data from the earliest date of listing
 ;
 ; ^TMP($J) returns:
 ;     ICN ^ DATESTAMP ^ TRANSACTION ^ TRANSFER FACILITY ^ WARD LOCATION ^ ROOM-BED ^ 
 ;     ATTENDING PHYSICIAN ^ TREATING SPECIALTY ^ PRIMARY PHYSICIAN ^ SCI STATUS ^ 
 ;     ORIGINAL ADMISSION DATE ^ EOL999
 ;
COL(RETURN,ICNLST,ACTDATE) ;
 ;***************************
 S RETURN=$NA(^TMP($J))
 S RETCNT=1
 S X=ACTDATE S %DT="T" D ^%DT S ACTDATE=Y
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D
 . Q:$G(ICN)=""
 . S DFN=$$FLIP^SPNRPCIC(ICN)
 . Q:$G(DFN)=""
 . S DFNLST(DFN)=ICN
 ;***************************
 S DA=ACTDATE-.00000001
 F  S DA=$O(^DGPM("B",DA)) Q:DA=""!($P(DA,".",1)>DT)  D
 . Q:$P(DA,".",1)<ACTDATE
 . ;JAS - 05/15/08 - DEFECT 1090
 . ;S IEN=""
 . S IEN=0
 . F  S IEN=$O(^DGPM("B",DA,IEN)) Q:IEN=""  D
 . . Q:'$D(^DGPM(IEN,0))
 . . S PMDATA=^DGPM(IEN,0)
 . . S DFN=$P(PMDATA,"^",3)
 . . Q:DFN=""
 . . Q:'$D(DFNLST(DFN))
 . . K TRANS,FAC,WRD,RB,PP,TS,AP,ORSTMP
 . . S ICN=$P(^DPT(DFN,"MPI"),"^",1)
 . . S MSTMP=$P(PMDATA,"^",1) I MSTMP'="" D
 . . . S Y=MSTMP X ^DD("DD") S STMP=Y
 . . S MASDA=$P(PMDATA,"^",2) I MASDA'="" D
 . . . S TRANS=$P($G(^DG(405.3,MASDA,0)),"^",1)
 . . I TRANS'="ADMISSION"&(TRANS'["TRANSFER")&(TRANS'="DISCHARGE") Q
 . . S FACDA=$P(PMDATA,"^",5) I FACDA'="" D
 . . . S FAC=$$GET1^DIQ(4,FACDA_",",.01)
 . . S WRDDA=$P(PMDATA,"^",6) I WRDDA'="" D
 . . . S WRD=$P(^DIC(42,WRDDA,0),"^",1)
 . . S RBDA=$P(PMDATA,"^",7) I RBDA'="" D
 . . . S RB=$P(^DG(405.4,RBDA,0),"^",1)
 . . S PPDA=$P(PMDATA,"^",8) I PPDA'="" D
 . . . S PP=$$GET1^DIQ(200,PPDA_",",.01)
 . . S TSDA=$P(PMDATA,"^",9) I TSDA'="" D
 . . . S TS=$$GET1^DIQ(45.7,TSDA_",",.01)
 . . S APDA=$P(PMDATA,"^",19) I APDA'="" D
 . . . ;JAS 07/15/08 IA Changes needed during SQA checklist
 . . . ;S AP=$P(^VA(200,APDA,0),"^",1)
 . . . S AP=$$GET1^DIQ(200,APDA_",",.01)
 . . D COL^SPNJRPCS(.STATUS,ICN)
 . . S VAS=$P($G(STATUS($J)),"^",1)
 . . I TRANS="DISCHARGE" D
 . . . S OREC=$P(PMDATA,"^",14)
 . . . I OREC'="" S ODAT=$P($G(^DGPM(OREC,0)),"^",1)
 . . . S Y=ODAT X ^DD("DD") S ORSTMP=Y
 . . I TRANS="SPECIALTY TRANSFER" D  Q
 . . . S PAR=$P(PMDATA,"^",24)
 . . . Q:PAR=""
 . . . I $D(^TMP("SPN",$J,PAR)) D
 . . . . S $P(^TMP("SPN",$J,PAR),"^",7)=$G(PP)
 . . . . S $P(^TMP("SPN",$J,PAR),"^",8)=$G(TS)
 . . . . S $P(^TMP("SPN",$J,PAR),"^",9)=$G(AP)
 . . S ^TMP("SPN",$J,IEN)=ICN_"^"_$G(STMP)_"^"_$G(TRANS)_"^"_$G(FAC)_"^"_$G(WRD)_"^"_$G(RB)_"^"_$G(PP)_"^"_$G(TS)_"^"_$G(AP)_"^"_$G(VAS)_"^"_$G(ORSTMP)_"^EOL999"
 S CNT=""
 F  S CNT=$O(^TMP("SPN",$J,CNT)) Q:CNT=""  D
 . S ^TMP($J,RETCNT)=^TMP("SPN",$J,CNT)
 . S RETCNT=RETCNT+1
 D CLNUP
 Q
CLNUP ;
 K %DT,AICN,APDA,CNT,DA,DFN,DFNLIST,DFNLST,FACDA,ICN,ICNNM
 K IEN,MASDA,MSTMP,ODAT,OREC,PAR,PATLIST,PMDATA,PPDA,RBDA
 K RETCNT,SPN,STATUS,STMP,TSDA,VAS,WRDDA,X,Y
 Q
