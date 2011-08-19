MHVXRXR ;WAS/GPM - Prescription refill request ; [12/12/07 11:38pm]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
REQUEST(QRY,ERR,DATAROOT) ; Entry point to request refills
 ; Walks list of prescriptions calling a pharmacy api AP1^PSOPRA to
 ; add the prescription to the internet refill request queue in the
 ; PRESCRIPTION REFILL REQUEST file #52.43.  The status of the api
 ; call is returned in DATAROOT.
 ;
 ;  Integration Agreements:
 ;         3768 : AP1^PSOPRA
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
 N CNT,RX,PORDERN,ORDERTM,STATUS,DIV,DFN,U
 ;
 D LOG^MHVUL2("MHVXRXR","BEGIN","S","TRACE")
 S U="^"
 S ERR=0
 K @DATAROOT
 S DFN=$G(QRY("DFN"))
 ;
 F CNT=1:1 Q:'$D(QRY("RX",CNT))  D
 . S RX=$G(QRY("RX",CNT))
 . S PORDERN=$P(RX,"^",2)
 . S ORDERTM=$P(RX,"^",3)
 . S RX=$P(RX,"^")
 . S STATUS=$$AP1^PSOPRA(DFN,RX)
 . S @DATAROOT@(CNT)=RX_U_STATUS_U_PORDERN_U_ORDERTM
 . Q
 ;
 S @DATAROOT=CNT-1
 D LOG^MHVUL2("MHVXRXR","END","S","TRACE")
 Q
