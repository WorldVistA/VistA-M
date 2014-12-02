ICDREF ;ALB/EG/KUM - GROUPER UTILITY FUNCTIONS ;5/20/05 8:35pm
 ;;18.0;DRG Grouper;**14,17,57,64**;Oct 20, 2000;Build 103
 ;
RTABLE(ICDRG,ICDDATE) ; Return Reference Table
 ;  Input:      ICDRG - DRG entry
 ;              ICDDATE - Date to use for resolving correct entry
 ;
 ;  Output:     Table reference associted with entry from DRG
 ;              file
 Q $$REF^ICDEX($G(ICDRG),$G(ICDDATE))
VMDC(IEN) ;Get versioned MDC for Diagnosis Code
 Q $$VMDCDX^ICDEX($G(IEN),$G(ICDDATE))
 ;
GETPVMDC ;Get versioned MDC for Op/Pro ICD code from previous years
 ; Needs CODE, ICDMDC and DRGFY
 S X=$$VMDCOP^ICDEX(+($G(CODE)),$G(ICDMDC),$G(DRGFY))
 S DRGFY=$P(X,"^",1),ICDMDC=$P(X,"^",2),DADRGFY=$P(X,"^",3),DAMDC=$P(X,"^",4)
 Q
