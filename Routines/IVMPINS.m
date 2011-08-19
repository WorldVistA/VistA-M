IVMPINS ;ALB/CPM,PHH - INSURANCE EVENT DRIVER INTERFACE ; 01-MAY-94
 ;;2.0;INCOME VERIFICATION MATCH;**9,94**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Queue transmission if an IVM patient's insurance status changes.
 ;  Input:  DFN -- Pointer to the patient in file #2
 ;
 N EVENTS
 S EVENTS("IVM")=1
 ;
 I '$G(DFN) G ENQ
 ;
 ; - quit if invoked by the IVM insurance upload process
 I $G(IVMINSUP) G ENQ
 ;
 ; - quit if the patient is not Cat C or Cat A
 S IVMMT=$$LST^DGMTU(DFN)
 I $P(IVMMT,"^",4)'="A",$P(IVMMT,"^",4)'="C" G ENQ
 ;
 ; - find the latest IVM case record, if it exists
 S (IVMDA,IVMDT,X)=0
 F  S X=$O(^IVM(301.5,"APT",DFN,X)) Q:'X  S IVMDT=X
 I IVMDT S IVMDA=+$O(^IVM(301.5,"APT",DFN,IVMDT,0))
 S IVMNEW='IVMDA
 ;
 ; - determine changes in insurance status
 S IVMINSP=$$PRIOR(IVMDA)
 S IVMINSA=$$INSUR^IBBAPI(DFN)
 ;
 ; - queue transmission if status has changed
 I IVMDA,(IVMINSP&'IVMINSA)!('IVMINSP&IVMINSA=1) I $$SETSTAT^IVMPLOG(IVMDA,.EVENTS)
 ;
 ; - queue transmission if Cat C pt w/o a case record has no insurance
 I 'IVMDA,'IVMINSA,$P(IVMMT,"^",4)="C" S IVMDT=$$LYR^DGMTSCU1(+$P(IVMMT,"^",2)) I $$LOG^IVMPLOG(DFN,IVMDT,.EVENTS)
 ;
ENQ K IVMDA,IVMDT,IVMINSA,IVMINSP,IVMMT,IVMNEW,X
 Q
 ;
 ;
PRIOR(DA) ; Find insurance status from last transmission
 ;  Input:  DA -- Pointer to the case record in file #301.5
 ; Output:   0 -- No active insurance at last transmission
 ;                (or could not identify last transmission)
 ;           1 -- Had active insurance at last transmission
 ;
 N X,Y S (X,Y)=0
 I $G(DA) F  S Y=$O(^IVM(301.6,"B",DA,Y)) Q:'Y  S X=Y
 Q $S(X:+$P($G(^IVM(301.6,X,1)),"^",2),1:0)
