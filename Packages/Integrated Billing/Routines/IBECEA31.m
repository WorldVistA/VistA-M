IBECEA31 ;ALB/CPM-Cancel/Edit/Add... Handle Events ; 02-APR-93
 ;;2.0;INTEGRATED BILLING;**27,57,52,176,188**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EVF(DFN,IBFR,IBTO,IBNH) ; Find the matching event for a copay or per diem.
 ;  Input:    DFN   --   Pointer to the patient in file #2
 ;           IBFR   --   Charge 'Bill From' date
 ;           IBTO   --   Charge 'Bill To' date
 ;           IBNH   --   2 - Fee, 1 - NHCU charge, 0 - Hospital charge
 ;                       3 - LTC
 ;  Output:    >1   --   ien of event ^ admission date ^ discharge date
 ;              0   --   an event is not found
 ;             -1   --   an event is found, but can't be billed
 I '$G(DFN)!'$G(IBFR)!'$G(IBTO) Q 0
 S IBNH=$G(IBNH),IBNH=$S(IBNH=2:"FEE",IBNH=3:"LTC A",IBNH:"NHCU",1:"HOSPITAL")
 N DIS,EVD,IBN,Y S EVD="",(IBN,Y)=0
 F  S EVD=$O(^IB("AFDT",DFN,EVD)) Q:'EVD  I -EVD'>IBFR F  S IBN=$O(^IB("AFDT",DFN,EVD,IBN)) Q:'IBN  S IBND=$G(^IB(IBN,0)) I $P(IBND,"^",8)[IBNH,$P(IBND,"^",8)'["FEE OPT",$P(IBND,"^",8)'["FEE LTC OPT" D EVS G EVFQ
EVFQ Q Y
 ;
EVS ; Set the output variable Y for the most recent (applicable) event.
 S DIS=$$DIS($P(IBND,"^",4))
 S Y=$S(IBXA=3&(IBTO>DIS):-1,(IBXA=2!(IBXA=1))&(IBTO'<DIS):-1,1:IBN)_"^"_-EVD_"^"_DIS
 Q
 ;
DIS(X) ; Find the discharge date for an admission.
 ;  Input:   X  --  Softlink from an entry in #350
 ;  Output:  Discharge date (if discharged), or 9999999 (still admitted)
 N DIS
 I +X=405 S DIS=+$G(^DGPM(+$P($G(^DGPM(+$P(X,":",2),0)),"^",17),0))
 I +X=45 S DIS=+$G(^DGPT(+$P(X,":",2),70))
 Q $S(DIS:DIS\1,1:9999999)
 ;
ADSEL(DFN) ; Select an admission to use to build an event.
 ;  Input:  DFN  --  Pointer to the patient in file #2
 ;  Output:    >1   --   ien of pt movement (in file #405) to link event
 ;              0   --   no admissions for the patient, or
 ;             -1   --   user decided to quit.
 I '$D(^DGPM("ATID1",+$G(DFN))) Q 0
 N ARR,DG,IBD,IBQ,J,SEL,X S IBQ=0,IBD=""
 F J=1:1 S IBD=$O(^DGPM("ATID1",DFN,IBD)) Q:'IBD  S DG=+$O(^(IBD,0)) I $D(^DGPM(DG,0)) W:J=1 !!," Please select one of the following admissions:" S ARR(J)=DG_"^"_(+^(0)\1)_"^"_+$P(^(0),"^",17) W !?3,J D DISEL,ASKAD:'(J#5) G:IBQ!($D(SEL)) ADSELQ
 I '$D(ARR) G ADSELQ
 I '((J-1)#5) W !!?3,"End of list.",!
 S J=J-1 D ASKAD
ADSELQ Q $S('$D(ARR):0,IBQ!'$D(SEL):-1,1:SEL)
 ;
DISEL ; Display admission data.
 N DGPM S DGPM=$G(^DGPM(DG,0))
 W ?7,$$DAT2^IBOUTL(+DGPM),?28,"to:  ",$E($P($G(^DIC(42,+$P(DGPM,"^",6),0)),"^"),1,18)
 I $P(DGPM,"^",17) W ?52,"(Discharged: ",$$DAT2^IBOUTL(+$G(^DGPM(+$P(DGPM,"^",17),0))\1),")"
 Q
 ;
ASKAD ; Prompt the user to select an admission.
 W !," Select 1-",J," or type '^' to quit: " R X:DTIME S:'$T!(X["^") IBQ=1 I IBQ!(X="") G ASKADQ
 I '$D(ARR(+X)) W !!?3,*7,"Enter a NUMBER from 1-",J,".",! G ASKAD
 I IBXA=6!(IBXA=7) S SEL=ARR(+X) G ASKADQ
 S IBDIS=+$G(^DGPM(+$P(ARR(+X),"^",3),0))\1 S:'IBDIS IBDIS=DT
 I IBFR'<$P(ARR(+X),"^",2),IBTO'>IBDIS S SEL=ARR(+X) G ASKADQ
 W !!?3,*7,"The bill dates fall outside the admissions dates!",! G ASKAD
ASKADQ K IBDIS
 Q
 ;
ADEV ; Add a new event entry in file #350.
 W !!,"I have to build the event record first...  "
 N DIE,DR,DA,IBLAST
 D EVADD^IBAUTL3 K IBN,IBEVDT Q:IBY<0  W "done."
 S IBLAST=$S(IBXA=2:IBTO,IBFR=IBTO:IBTO,1:$$FMADD^XLFDT(IBTO,-1))
 W !,"Updating the Date Last Calculated to ",$$DAT1^IBOUTL(IBLAST),"...  "
 S DIE="^IB(",DA=IBEVDA,DR=".18////"_IBLAST D ^DIE W "done."
 I $P(IBDG,"^",3) W !,"Since the patient has been discharged, let me 'close' the IB event... " S DIE="^IB(",DA=IBEVDA,DR=".05////2" D ^DIE W "done."
 Q
 ;
NOEV ; No event in Integrated Billing - ask user to select an admission
 W !! I IBEVDA<0 D UNAB W !,"Tried to link the charge to an admission on ",$$DAT1^IBOUTL($P(IBEVDA,"^",2)),", but the Bill To date",!,"(",$$DAT1^IBOUTL(IBTO),") exceeds the discharge date of ",$$DAT1^IBOUTL($P(IBEVDA,"^",3)),"."
 D:'IBEVDA UNAB
 I IBNH=2 D NOEVT^IBECEA34 Q
 W !,"You may link this charge to one of the patient's admissions..."
 S IBDG=$$ADSEL(DFN)
 I 'IBDG W !!,"This patient has no admissions -- this charge cannot be added." S IBY=-1 Q
 I IBDG=-1 W !!,"No admission selected -- transaction cannot be completed." S IBY=-1 Q
 W !!,"I will need to build an event record in Integrated Billing for this charge."
 ;
 ; - check for special inpatient billing case
 I IBXA'=9 D SPEC^IBECEA32(1,$O(^IBE(351.2,"AC",+IBDG,0)))
 ;
 ; - build softlink and set event date
 S IBSL="405:"_+IBDG,IBEVDT=$P(IBDG,"^",2)
 Q
 ;
UNAB W "Unable to link this charge to an event in Integrated Billing!"
 Q
