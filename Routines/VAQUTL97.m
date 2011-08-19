VAQUTL97 ;ALB/JFP,JRP - PDX Patient Lookup ;24-JAN-93
 ;;1.5;PATIENT DATA EXCHANGE;**2,9,29,35**;NOV 17, 1993
 ;
GETDFN(PATIENT,TASK) ;-- Return DFN of patient
 ; -- This will return the same information that DIC returns in Y
 N DIC,X,Y,RESULT,USRABORT
 S USRABORT=-1
 S:'$D(PATIENT) PATIENT=""
 S:'$D(TASK) TASK=0
 ; -- User interface
 S DIC(0)="M"
 I (PATIENT="")&('TASK) S DIC(0)=DIC(0)_"A"
 I (PATIENT="")&(TASK) S RESULT=USRABORT Q RESULT
 S:TASK DIC(0)=DIC(0)_"XZ"
 S:'TASK DIC(0)=DIC(0)_"EQZ"
 S X=PATIENT
 S DIC="^DPT("
 ; -- Prevent sensitive record bulletin if called in TASK mode
 S:(TASK) DGSENFLG=""
 D ^DIC
 K DGSENFLG
 ; -- User aborted process
 Q:$D(DTOUT) USRABORT
 Q:$D(DUOUT) USRABORT
 Q Y
 ;
GETSEN(DFN) ; -- Returns code for sensitive patient or not
 ;        INPUT: DFN     = Dictionary file number
 ;       OUTPUT: 1       = Sensitive patient
 ;               0       = Non sensitive
 ;              -1       = Bad input
 ;
 Q:'$D(DFN) -1
 Q:DFN="" -1
 Q:DFN=0 -1
 Q:'$D(^DGSL(38.1,DFN,0)) -0 ; -- not sensitive patient
 Q $P($G(^DGSL(38.1,DFN,0)),U,2) ; -- 1 SENSITIVE, 0 NON-SENSITIVE
 ;
EXPTRN(TRANDA) ; -- Determines if any entry in the transactions file is 
 ;            marked for purge or exceed the life days.
 ;            Also checks to make sure that requesting domain is
 ;            not closed.  If it is, it marks the transaction file
 ;            entry for purging.
 ;               INPUT :  TRANDA   DA TO TRANSACTION RECORD
 ;               OUTOUT: -1    error in data
 ;                        0    not expired
 ;                        1    expired
 ;
 N X,LDAY,PURGE
 S PURGE=$P($G(^VAT(394.61,TRANDA,"PRG")),U,1)
 I PURGE=1 Q 1 ; -- purge flag set
 ;
 S X1=$$NOW^VAQUTL99(1,1) ; -- Current date
 S X2=$P($G(^VAT(394.61,TRANDA,"ATHR1")),U,1)
 I X2="" S X2=$P($G(^VAT(394.61,TRANDA,"RQST1")),U,1)
 S X2=$P(X2,".",1)
 I X2="" Q -1 ; -- error in data
 ;
 S LDAY=$P($G(^VAT(394.81,1,"LIFE")),U,1)
 I LDAY="" Q 0 ; -- no life days set
 ;
 D ^%DTC
 I X>LDAY Q 1 ; -- Expired
 Q 0
CLOSDOM(TRANDA,DOMAIN) ; Function, given domain, returns whether
 ; the domain is closed or not.  (1=closed; 0=not closed)
 ; If the domain is closed, then the transaction is marked for purging.
 Q:'$$CLOSED(DOMAIN) 0
 D SETPURGE(TRANDA)
 Q 1
CLOSTRAN(TRANDA,NODE) ; Function, given transaction number, returns whether
 ; the domain is closed or not.  (1=closed; 0=not closed)
 ; If NODE="RQST2", we are checking the domain that sent the request.
 ; If NODE="ATHR2", we are checking the domain to which we are sending
 ; the request.  If the domain is closed, then the transaction is marked
 ; for purging.
 Q:'$$CLOSED($P($G(^VAT(394.61,TRANDA,NODE)),U,2)) 0
 D SETPURGE(TRANDA)
 Q 1
CLOSED(DOMAIN) ; Function, given domain name, returns whether the domain
 ; is closed or not.  1=closed; 0=not closed
 N VIEN
 S VIEN=$$FIND1^DIC(4.2,"","MQX",DOMAIN,"B^C") Q:'VIEN 0
 Q $P($G(^DIC(4.2,VIEN,0)),U,2)["C"
SETPURGE(TRANDA) ;
 N VFDA
 S VFDA(394.61,TRANDA_",",90)=1 ; set purge flag
 D FILE^DIE("","VFDA")
 Q
 ;
GETINST(DOMAIN) ;-- Return name of institution for domain
 ;
 ; INPUT:     DOMAIN      - 
 ; OUTPUT:    NULL        - ERROR
 ;            INSTITUTION - SUCCESS
 ;
 N DOMNO,INSTDA,STNO,INST
 ;
 ;W !,"Domain = ",DOMAIN
 Q:'$D(DOMAIN) ""
 ;
 S DOMNO=+$$FIND1^DIC(4.2,"","BMX",DOMAIN,"B^C","","ERROR")
 Q:DOMNO=0 ""
 S INSTDA=$P($G(^DIC(4.2,DOMNO,0)),U,13) Q:INSTDA="" ""
 S STNO="",STNO=$O(^DIC(4,"D",INSTDA,"")) Q:STNO="" ""
 S INST=$P($G(^DIC(4,STNO,0)),U,1)
 Q:INST="" ""
 Q INST
 ;
