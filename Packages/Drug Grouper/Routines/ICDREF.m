ICDREF ;ALB/EG - GROUPER UTILITY FUNCTIONS ; 5/20/05 8:35pm
 ;;18.0;DRG Grouper;** 14,17 **;Oct 20, 2000
RTABLE(ICDRG,ICDDATE) ; Return Reference Table
 ;  Input:      ICDRG - DRG entry
 ;              ICDDATE - Date to use for resolving correct entry
 ;
 ;  Output:     Table reference associted with entry from DRG
 ;              file
 N ICDFY,ICDREF
 S (ICDFY,ICDREF)=""
 S ICDFY=$O(^ICD(ICDRG,2,"B",+ICDDATE+.01),-1)
 S ICDREF=$O(^ICD(ICDRG,2,"B",+ICDFY,ICDREF))
 S ICDREF=$P($G(^ICD(ICDRG,2,+ICDREF,0)),U,3)
 Q ICDREF
VMDC(CODE) ;Get versioned MDC for Diagnosis Code
 S (MDC,DRGFY)="",DRGFY=$O(^ICD9(CODE,4,"B",+$G(ICDDATE)),-1),MDC=$O(^ICD9(CODE,4,"B",+DRGFY,MDC))
 Q $P($G(^ICD9(CODE,4,+MDC,0)),U,2)
 ;
GETPVMDC ;Get versioned MDC for Op/Pro ICD code from previous years
 S (DAMDC,DADRGFY)=""
 F  S DRGFY=$O(^ICD0(CODE,2,"B",DRGFY),-1) Q:'DRGFY!(DAMDC>0)  D
 .S DADRGFY=$O(^ICD0(CODE,2,"B",+$G(DRGFY),DADRGFY))
 .S DAMDC=$O(^ICD0(CODE,2,+DADRGFY,1,"B",ICDMDC,DAMDC))
 Q
