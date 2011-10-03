MHVXRX ;WAS/GPM - Prescription extract ; [12/14/06 11:38am]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
PROFILE(QRY,ERR,DATAROOT) ; Entry point to get prescription profile
 ; Retrieves requested prescription data and returns it in DATAROOT
 ; Retrieves all prescriptions with an active status
 ;
 ;  Integration Agreements:
 ;         3768 : AP2^PSOPRA,AP5^PSOPRA
 ;         4687 : EN^PSOMHV1
 ;
 ;  Input:
 ;       QRY - Query array
 ;          QRY(DFN) - (required) Pointer to PATIENT (#2) file
 ;  DATAROOT - Root of array to hold extract data
 ;
 ;  Output:
 ;  DATAROOT - Populated data array, includes # of hits
 ;       ERR - Errors during extraction
 ;
 N U,DT,HIT,DFN,FROM,TO,STA,DRUG,DIV,MHVSTAT,RXN,MHVDATE,INDEX
 ;
 D LOG^MHVUL2("MHVXRX PROFILE","BEGIN","S","TRACE")
 S U="^",DT=$$DT^XLFDT
 S ERR=0,HIT=0
 K @DATAROOT
 K ^TMP("PSO",$J)
 S DFN=$G(QRY("DFN"))
 S FROM=DT
 S TO=""
 ;
 D EN^PSOMHV1(DFN,FROM,TO)
 ;
 S STA="",INDEX=""
 F STA="ACT","SUS" F  S INDEX=$O(^TMP("PSO",$J,STA,INDEX)) Q:INDEX=""  D SET
 ;
 K ^TMP("PSO",$J)
 S @DATAROOT=HIT
 D LOG^MHVUL2("MHVXRX PROFILE",HIT_" HITS","S","TRACE")
 D LOG^MHVUL2("MHVXRX PROFILE","END","S","TRACE")
 Q
 ;
EXTRACT(QRY,ERR,DATAROOT) ; Entry point to extract prescription data
 ; Retrieves requested prescription data and returns it in DATAROOT
 ; Retrieves all prescriptions of all statuses in given date range
 ; Statuses of deleted are filtered by the pharmacy API.
 ;
 ;  Integration Agreements:
 ;         3768 : AP2^PSOPRA,AP5^PSOPRA
 ;         4687 : EN3^PSOMHV1
 ;
 ;  Input:
 ;       QRY - Query array
 ;          QRY(DFN) - (required) Pointer to PATIENT (#2) file
 ;         QRY(FROM) - Date to start from
 ;           QRY(TO) - Date to go to
 ;  DATAROOT - Root of array to hold extract data
 ;
 ;  Output:
 ;  DATAROOT - Populated data array, includes # of hits
 ;       ERR - Errors during extraction
 ;
 N U,DT,HIT,DFN,FROM,TO,STA,DRUG,DIV,MHVSTAT,RXN,MHVDATE,INDEX
 ;
 D LOG^MHVUL2("MHVXRX EXTRACT","BEGIN","S","TRACE")
 S U="^",DT=$$DT^XLFDT
 S ERR=0,HIT=0
 K @DATAROOT
 K ^TMP("PS",$J)
 S DFN=$G(QRY("DFN"))
 S FROM=$G(QRY("FROM"))
 S TO=$G(QRY("TO"))
 ;
 I FROM="" S FROM=2000101  ;01/01/1900
 ;
 ; The EN3^PSOMHV1 call uses RX IEN instead of DRUG as a
 ; subscript in ^TMP("PSO",$J).  This was a late breaking change to
 ; PSOMHV1 to support historical extracts.
 D EN3^PSOMHV1(DFN,FROM,TO)
 ;
 S STA="",INDEX=""
 F  S STA=$O(^TMP("PSO",$J,STA)) Q:STA=""  I STA'="PEN" F  S INDEX=$O(^TMP("PSO",$J,STA,INDEX)) Q:INDEX=""  D SET
 ;
 K ^TMP("PSO",$J)
 S @DATAROOT=HIT
 D LOG^MHVUL2("MHVXRX EXTRACT",HIT_" HITS","S","TRACE")
 D LOG^MHVUL2("MHVXRX EXTRACT","END","S","TRACE")
 Q
 ;
SET ;
 ;INDEX will be RXIEN if called from EXTRACT
 ;INDEX will be drug name if called from PROFILE
 S RXN=$P($G(^TMP("PSO",$J,STA,INDEX,"RXN",0)),"^")
 I RXN="" Q
 I $D(QRY("RXLIST")) Q:'$D(QRY("RXLIST",RXN))
 S MHVSTAT=$$AP2^PSOPRA(DFN,RXN)
 S MHVDATE=$P(MHVSTAT,"^",2)
 S MHVSTAT=$P(MHVSTAT,"^",1)
 I MHVSTAT>0 I $$AP5^PSOPRA(DFN,RXN)   ;Clear RXN from queue
 S DRUG=$P($G(^TMP("PSO",$J,STA,INDEX,0)),"^",1)   ;Drug Name
 S HIT=HIT+1
 S @DATAROOT@(HIT)=RXN_U_DRUG_U_MHVSTAT_U_MHVDATE
 S @DATAROOT@(HIT,0)=$G(^TMP("PSO",$J,STA,INDEX,0))
 S @DATAROOT@(HIT,"P")=$G(^TMP("PSO",$J,STA,INDEX,"P",0))
 S @DATAROOT@(HIT,"RXN")=$G(^TMP("PSO",$J,STA,INDEX,"RXN",0))
 S @DATAROOT@(HIT,"DIV")=$G(^TMP("PSO",$J,STA,INDEX,"DIV",0))
 I '$D(^TMP("PSO",$J,STA,INDEX,"SIG")) S @DATAROOT@(HIT,"SIG",0)=0
 E  M @DATAROOT@(HIT,"SIG")=^TMP("PSO",$J,STA,INDEX,"SIG")
 Q
 ;
