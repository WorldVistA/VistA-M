IVMCMZ ;ALB/EJG- PROCESS INCOME TEST (Z10) TRANSMISSIONS - EXTRINSICS ; 03/17/02 1:43pm
 ;;2.0;INCOME VERIFICATION MATCH;**77**;21-OCT-94
 ;
DOM(DFN) ; Is patient in a DOM?
 ;  Input:    DFN - pointer to pt in file (#2)
 ; Output: IVMDOM - Is the patient in a DOM?  0 => NO | 1 => YES
 ;
 N IVMDOM,VAINDT,VADMVT
 D ADM^VADPT2
 I VADMVT,$P($G(^DG(43,1,0)),"^",21),$D(^DIC(42,+$P($G(^DGPM(VADMVT,0)),"^",6),0)),$P(^(0),"^",3)="D" S IVMDOM=1
 Q +$G(IVMDOM)
 ;
