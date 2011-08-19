IBAMTV4 ;ALB/CPM - FIND CHARGES FOR IVM PATIENTS ; 13-JUN-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**15**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ALL(DFN,IBROOT,IBST,IBEND) ; Find IB Actions and Claims for the IVM Patient
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;          IBROOT  --  Root in which to place array of charges
 ;            IBST  --  Start date used as check for patient charges
 ;           IBEND  --  End date used as check for patient charges
 ;
 ; Output:  Array of charges:
 ;              @IBROOT@(ref #)=1^2^3^4^5^6^7^8^9^10^11, where
 ;                 ref # - bill number or field #.01 to #350
 ;                     1 - DFN
 ;                     2 - Classification [1-Inpt,2-Opt,3-Refill,4-Pros]
 ;                     3 - Type [1-Claim,2-Copay,3-Per Diem]
 ;                     4 - Bill From Date
 ;                     5 - Bill To Date
 ;                     6 - Date Bill Created
 ;                     7 - Amt Billed
 ;                     8 - Amt Collected  (Claims only)
 ;                     9 - Date Bill Closed  (Claims only)
 ;                    10 - Cancelled? [0-No,1-Yes]
 ;                    11 - On Hold?  (Patient charges only)
 ;
 I $G(IBROOT)=""!'$G(DFN) G ALLQ
 ;
 ; - build patient charge array
 I $G(IBST) S Y="" F  S Y=$O(^IB("AFDT",DFN,Y)) Q:'Y  I -Y'>IBEND S Y1=0 F  S Y1=$O(^IB("AFDT",DFN,Y,Y1)) Q:'Y1  D
 .S IBDA=0 F  S IBDA=$O(^IB("AF",Y1,IBDA)) Q:'IBDA  D
 ..Q:'$D(^IB(IBDA,0))  S IBX=^(0)
 ..Q:$P(IBX,"^",8)["ADMISSION"
 ..Q:$P(IBX,"^",9)'=IBDA
 ..S IBN=$$LAST^IBECEAU(IBDA),IBND=$G(^IB(IBN,0)),IBND1=$G(^(1))
 ..I $P(IBND,"^",15)<IBST!($P(IBND,"^",14)>IBEND) Q
 ..;
 ..; - start building string
 ..S IBSTR=DFN_"^"_$S($P(IBND,"^",8)["OPT COPAY":2,1:1)
 ..S IBSTR=IBSTR_"^"_$S($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["PER DIEM":3,1:2)
 ..S IBSTR=IBSTR_"^"_$P(IBND,"^",14)_"^"_$P(IBND,"^",15)_"^"_($P(IBND1,"^",4)\1)_"^"_$P(IBND,"^",7)
 ..S IBSTAT=$G(^IBE(350.21,+$P(IBND,"^",5),0))
 ..S IBSTR=IBSTR_"^^^"_$P(IBSTAT,"^",5)_"^"_$P(IBSTAT,"^",6)
 ..I $P(IBSTAT,"^",6) S $P(IBSTR,"^",6)=""
 ..;
 ..S @IBROOT@(+IBX)=IBSTR
 ;
 ; - build claim array
 D CLM(DFN,IBROOT)
 ;
ALLQ K Y,Y1,IBDA,IBX,IBN,IBND,IBND1,IBSTR,IBSTAT
 Q
 ;
 ;
INS(IBROOT) ; Find claims for patients with IVM-identified policies.
 ;  Input:  IBROOT  --  Root in which to place array of charges
 ; Output:  Array of charges as defined above
 ;
 N DFN
 I $G(IBROOT)="" G INSQ
 S DFN=0 F  S DFN=$O(^IBA(354,"AIVM",DFN)) Q:'DFN  I '$$CHK^IVMUFNC3(DFN) D CLM(DFN,IBROOT)
INSQ Q
 ;
 ;
CLM(DFN,IBROOT) ; Build charge array for insurance claims
 ;  Input:     DFN  --  Pointer to the patient in file #2
 ;          IBROOT  --  Root in which to place array of charges
 ; Output:  Array of charges as defined above
 ;
 I $G(IBROOT)=""!'$G(DFN) G CLMQ
 ;
 N IBN,IBI,IBND,IBX,IBSTR
 ;
 S IBN=0 F  S IBN=$O(^DGCR(399,"C",DFN,IBN)) Q:'IBN  I $$HOWID^IBRFN2(IBN)=3,$P($G(^DGCR(399,IBN,"S")),"^",12) D
 .F IBI=0,"S","U" S IBND(IBI)=$G(^DGCR(399,IBN,IBI))
 .;
 .; - build string
 .S IBSTR=DFN_"^"_$$CLS(IBN,IBND(0))_"^1"
 .S IBSTR=IBSTR_"^"_+IBND("U")_"^"_$P(IBND("U"),"^",2)_"^"_$P(IBND("S"),"^",12)
 .S IBX=$$ORI^PRCAFN(IBN) ; amt billed
 .S IBSTR=IBSTR_"^"_$S(IBX>0:IBX,1:0)
 .S IBX=$$TPR^PRCAFN(IBN) ; amt collected
 .S IBSTR=IBSTR_"^"_$S(IBX>0:IBX,1:0)
 .S IBX=$$CLO^PRCAFN(IBN) ; date bill closed
 .S IBSTR=IBSTR_"^"_$S(IBX>0:IBX,1:"")_"^"_$P(IBND("S"),"^",16)
 .;
 .S @IBROOT@($$BN^PRCAFN(IBN))=IBSTR
 ;
CLMQ Q
 ;
CLS(BN,BN0) ; Return a code for the bill classification.
 ;  Input:   BN  --  Pointer to the bill in file #399
 ;          BN0  --  Zeroth node of bill in file #399
 N X S X="O"
 I $G(BN)=""!($G(BN0)="") G CLSQ
 S X=$$BTYP^IBCOIVM1(BN,BN0)
CLSQ Q $S(X="I":1,X="O":2,X="R":3,X="P":4,1:2)
