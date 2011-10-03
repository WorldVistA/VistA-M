SPNJRPPR ;BP/JAS - Returns list of ICNs who match Prosthetics criteria ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,"MPI" supported by IA# 4938
 ; References to ^RMPR(660 supported by IA# 4975
 ; Reference to ^ICPT("B" supported by IA# 2815
 ; Reference to API PSASHCPC^RMPOPF supported by IA# 4975
 ;
 ; Parm values:
 ;     DESC is the description of the Prosthetics device.
 ;     ^TMP($J) is the return value with list of ICNs
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,DESC) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J),^TMP("SPN",$J),DELIST
 I $D(DESC) D DELOAD
 ;JAS - 05/15/08 - DEFECT 1090
 ;S DFN=""
 S DFN=0
 F  S DFN=$O(^RMPR(660,"C",DFN)) Q:DFN=""  D IN
 D OUT,CLNUP
 Q
IN ;
 S ICN=$P($G(^DPT(DFN,"MPI")),"^",1)
 Q:ICN=""
 ;JAS - 05/15/08 - DEFECT 1090
 ;S PDA="",FND=0
 S PDA=0,FND=0
 F  S PDA=$O(^RMPR(660,"C",DFN,PDA)) Q:PDA=""!(FND)  D
 . Q:'$D(^RMPR(660,PDA,0))
 . I $D(DESC) D DESC
 Q
DESC ;
 S RMPRHCDT=$P(^RMPR(660,PDA,0),"^",1)
 Q:'$D(^RMPR(660,PDA,1))
 S RMPRHCPC=$P(^RMPR(660,PDA,1),"^",4)
 D PSASHCPC^RMPOPF
 Q:RMPREHC=""
 I $D(DELIST(RMPREHC)) D
 . S ^TMP("SPN",$J,ICN)=""
 . S FND=1
 Q
OUT ;
 S ICN=""
 F  S ICN=$O(^TMP("SPN",$J,ICN)) Q:ICN=""  D
 . S ^TMP($J,RETCNT)=ICN_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
DELOAD ;
 S DDA="" F  S DDA=$O(DESC(DDA)) Q:DDA=""  D
 . S DEX=$P(DESC(DDA),"^",1)
 . I $D(^ICPT("B",DEX)) S DELIST(DEX)=""
 Q
CLNUP ;
 K DA,DDA,DEX,DFN,FND,ICN,IREC0,IREF,IREF2,ITDA,ITEM
 K PDA,PRCDA,PROLIST,RETCNT,RMPRHCDT,RMPRHCPC,RMPREHC
 Q
