IBACUS ;ALB/CPM - TRICARE BILLING UTILITIES ; 02-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,240,274**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CUS(DFN,IBDT) ; Does the patient have TRICARE coverage?
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;           DATE  --  Date on which coverage is to be determined
 ; Output:  IBCOV  --  0, if the vet has no billable TRICARE coverage
 ;                     >0 => pointer to such coverage in file #2.312
 ;
 N IBCOV,IBPOL,IBI
 S IBCOV=0
 I '$G(DFN) G CUSQ
 S:'$G(IBDT) IBDT=DT
 ;
 ; - find a billable TRICARE policy
 D ALL^IBCNS1(DFN,"IBPOL",1,IBDT)
 S IBI=0 F  S IBI=$O(IBPOL(IBI)) Q:'IBI  D  Q:IBCOV
 .Q:$P($G(IBPOL(IBI,3)),"^",4)  ; ignore billing this policy
 .I $P($G(^IBE(355.1,+$P($G(IBPOL(IBI,355.3)),"^",9),0)),"^",3)=7 S IBCOV=IBI
CUSQ Q IBCOV
 ;
 ;
TRI() ; Is the Tricare Billing engine up and running?
 ;  Input:  none
 ; Output:  0 - No  1 - Yes
 ;
 Q $P($G(^IBE(350.9,1,9)),"^",4)>0
 ;
 ;
CHPUS(DFN,DATE,IBRX,IBREF,IBLAB,IBRSITE,IBDUZ) ; Bill this patient for TRICARE?
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;           DATE  --  Date on which coverage is to be determined
 ;           IBRX  --  Pointer to the prescription in file #52
 ;          IBREF  --  Pointer to the refill in file #52.1, or
 ;                     0 if billing the original prescription
 ;          IBLAB  --  Pharmacy label printing device
 ;        IBRSITE  --  Pointer to the Pharmacy in file #59
 ;          IBDUZ  --  Pointer to the Pharmacy user in file #200
 ; Output:  IBCHK  --  0 => can't bill rx || 1 => bill rx
 ;
 N IBCHK,IBKEY S IBCHK=0
 I '$G(DFN) G CHPUSQ
 D POL^IBCNSU41(DFN)
 ;
 ; - make sure system is running and the patient has TRICARE coverage
 I '$$TRI() G CHPUSQ
 I '$$CUS(DFN,DATE) G CHPUSQ
 ;
 ; - check remaining user input
 I '$G(IBRX) G CHPUSQ
 I $G(IBREF)="" G CHPUSQ
 I $G(IBLAB)=""!('$G(IBRSITE))!('$G(IBDUZ)) G CHPUSQ
 ;
 ; - perform all Pharmacy edits
 I '$$CHK^PSOCPTRI(IBRX,IBREF) G CHPUSQ
 ;
 ; - queue rx for billing
 S IBCHK=1,IBKEY=IBRX_";"_IBREF
 S ^IBA(351.5,"APOST",IBKEY)=IBLAB_"^"_IBRSITE_"^"_IBDUZ
 ;
CHPUSQ Q IBCHK
 ;
 ;
 ;
 ;
 ; The following three queued entry points are invoked by the
 ; TRICARE Rx Billing engine.  The following two variables are
 ; defined for each of the jobs:
 ;
 ;     IBCHTRN  --  Pointer to the transaction entry in file #351.5
 ;      IBKEYD  --  1 ^ 2 ^ 3, where
 ;                    1 = Rx label printing device
 ;                    2 = Pointer to the Pharmacy in file #59
 ;                    3 = Pointer to the Pharmacy user in file #200
 ;
RXLAB ; Queued entry point to print the TRICARE Rx label.
 I $G(IBKEYD)="" G RXLABQ
 S IBCOP=$J(+$G(^IBA(351.5,+$G(IBCHTRN),2)),0,2)
 I 'IBCOP G RXLABQ
 D LABEL^PSOCPTRI(+$G(^IBA(351.5,IBCHTRN,0)),$P(IBKEYD,"^"),$P(IBKEYD,"^",2),$P(IBKEYD,"^",3),IBCOP)
RXLABQ K IBCOP
 Q
 ;
 ;
RXBIL ; Queued entry point to create TRICARE Rx Billing charges.
 ;
 ; - check some basic input
 I '$$RXSET G RXBILQ
 ;
 ; - create copay charge
 D BILL^IBACUS1(IBKEY,IBCHTRN)
 ;
 ; - create fiscal intermediary claim
 D BILL^IBACUS2(IBKEY,IBCHTRN)
 ;
RXBILQ Q
 ;
 ;
RXCAN ; Queued entry point to cancel TRICARE Rx Billing charges.
 ;
 ; - check some basic input
 I '$$RXSET G RXCANQ
 ;
 ; - cancel copay charge
 D CANC^IBACUS1(IBCHTRN)
 ;
 ; - cancel fiscal intermediary claim
 D CANC^IBACUS2(IBCHTRN)
 ;
RXCANQ Q
 ;
 ;
RXSET() ; Establish the session.
 N IBOK S IBOK=0
 ;
 ; - check some basic input
 I '$G(IBCHTRN) G RXSETQ
 S IBKEY=$P($G(^IBA(351.5,IBCHTRN,0)),"^")
 I IBKEY="" G RXSETQ
 S DUZ=+$P(IBKEYD,"^",3)
 I $G(^VA(200,DUZ,0))="" G RXSETQ
 ;
 N DIQUIET S DIQUIET=1 D DT^DICRW
 S IBOK=1
 ;
RXSETQ Q IBOK
