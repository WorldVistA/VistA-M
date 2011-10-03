IVMPXFR ;ALB/MLI/CJM - Called from DD to update IVM transmit flag ; 14 APR 93
 ;;2.0;INCOME VERIFICATION MATCH;**9,17**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DPT ; Update transmit status if patient file fields are updated
 ;
 N DFN
 S DFN=+DA I '$D(^DPT(DFN,0)) Q
 D IVM
 ;
 ; log DCD event for nightly transmission to HEC
 D LOGDCD^IVMCUC(DFN)
 ;
 ; if change in SSN, DOB, or SEX see if financial query needs to
 ; be sent to HEC Center
 I $D(IVMKILL),$P($G(^DPT(+DA,0)),"^",IVMKILL)'="" D QRYQUE^IVMCQ2(DFN)
 ;
 Q
 ;
IVM ; check to see if patient needs to be retransmitted
 N DA,I,NODE,X,IVMDT,EVENTS
 Q:'$D(^IVM(301.5,"B",DFN))
 F DA=0:0 S DA=$O(^IVM(301.5,"B",DFN,DA)) Q:'DA  D
 .S X=$G(^IVM(301.5,DA,0))
 .I 'X!($P(X,"^",3)=0)!$P(X,"^",4) Q  ; stop if transmit=no or stop=yes
 .S IVMDT=$E($P(X,"^",2),1,3)+1_"1231.9999"
 .Q:'$$IVM^IVMUFNC(DFN,IVMDT)  ;stop if not an IVM patient
 .S EVENTS("IVM")=1
 .I $$SETSTAT^IVMPLOG(DA,.EVENTS)
 Q
 ;
SPSSN ; Update transmit status if the spouse's SSN has been updated
 N DFN,IVMPR,IVMPRN
 S IVMPR=$O(^DGPR(408.12,"C",+DA_";DGPR(408.13,",0)) Q:'IVMPR
 S IVMPRN=$G(^DGPR(408.12,IVMPR,0)) Q:'IVMPRN
 Q:$P(IVMPRN,"^",2)'=2  ; not a spouse
 S DFN=+IVMPRN
 D IVM
 Q
