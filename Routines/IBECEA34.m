IBECEA34 ;ALB/CPM - Cancel/Edit/Add... Fee Support ; 12-FEB-96
 ;;Version 2.0 ; INTEGRATED BILLING ;**57**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NOEVT ; No event in Integrated Billing - ask user to select a fee ptf
 W !,"You may link this charge to one of the patient's Fee PTF entries..."
 S IBDG=$$ADSEL(DFN)
 I 'IBDG W !!,"This patient has no Fee PTF entries -- this charge cannot be added." S IBY=-1 G NOEVTQ
 I IBDG=-1 W !!,"No Fee PTF entry selected -- transaction cannot be completed." S IBY=-1 G NOEVTQ
 W !!,"I will need to build an event record in Integrated Billing for this charge."
 ;
 ; - build softlink and set event date
 S IBSL="45:"_+IBDG,IBEVDT=$P(IBDG,"^",2),IBFEEV=1
NOEVTQ Q
 ;
 ;
ADSEL(DFN) ; Select a Fee PTF as an admission to use to build an event.
 ;  Input:  DFN  --  Pointer to the patient in file #2
 ;  Output:    >1   --   ien of ptf entry (in file #45) to link event
 ;              0   --   no feee ptf entries for the patient, or
 ;             -1   --   user decided to quit.
 I '$D(^DGPT("AFEE",+$G(DFN))) Q 0
 N ARR,PTF,IBD,IBQ,J,SEL,X S IBQ=0,IBD=""
 F J=1:1 S IBD=$O(^DGPT("AFEE",DFN,IBD)) Q:'IBD  S PTF=+$O(^(IBD,0)) I $D(^DGPT(PTF,0)) W:J=1 !!," Please select one of the following admissions:" S ARR(J)=PTF_"^"_(IBD\1) W !?3,J D DISEL,ASKAD:'(J#5) G:IBQ!($D(SEL)) ADSELQ
 I '$D(ARR) G ADSELQ
 I '((J-1)#5) W !!?3,"End of list.",!
 S J=J-1 D ASKAD
ADSELQ Q $S('$D(ARR):0,IBQ!'$D(SEL):-1,1:SEL)
 ;
DISEL ; Display admission data.
 N DGPT S DGPT=$G(^DGPT(PTF,0))
 W ?7,$$DAT2^IBOUTL($P(DGPT,"^",2))
 I $G(^DGPT(PTF,70)) W ?32,"(Discharged: ",$$DAT2^IBOUTL(+^(70)),")"
 Q
 ;
ASKAD ; Prompt the user to select an admission.
 W !," Select 1-",J," or type '^' to quit: " R X:DTIME S:'$T!(X["^") IBQ=1 I IBQ!(X="") G ASKADQ
 I '$D(ARR(+X)) W !!?3,*7,"Enter a NUMBER from 1-",J,".",! G ASKAD
 S IBDIS=+$G(^DGPT(+ARR(+X),70))\1 S:'IBDIS IBDIS=DT
 I IBFR'<$P(ARR(+X),"^",2),IBTO'>IBDIS S SEL=ARR(+X) G ASKADQ
 W !!?3,*7,"The bill dates fall outside the admissions dates!",! G ASKAD
ASKADQ K IBDIS
 Q
 ;
 ;
ADEV ; Add a new event entry for the Fee PTF in file #350.
 W !!,"Building the Fee PTF event record...  "
 N DIE,DR,DA
 D EVADD^IBAUTL3 K IBN,IBEVDT Q:IBY<0  W "done."
 S DIE="^IB(",DA=IBEVDA,DR=".05////2" D ^DIE
 S $P(^IB(IBEVDA,0),"^",8)="FEE ADMISSION"
 Q
 ;
 ;
MED ; Is the Fee Charge for a CNH or Contract Hospital Admission?
 R !,"  Is this a C(N)H or Contract (H)ospital Admission? CNH// ",X:DTIME
 I '$T!(X["^") S IBY=-1 G MEDQ
 S:X="" X="N" S X=$E(X)
 I "NHnh"'[X D HMED G MED
 W $S("nN"[X:"  CNH",1:"  CONTRACT HOSPITAL")
 S IBADJMED=1 I "Hh"[X S IBADJMED=2,IBMED=IBMED/2
MEDQ Q
 ;
HMED ; Help for the 'C(N)H or Contract (H)ospital' prompt
 W !!?6,"Enter:  '<CR>' -  If the charge is for a CNH Admission"
 W !?14,"'H'    -  If the charge is for a Contract Hospital Admission"
 W !?14,"'^'    -  To quit this option",!
 Q
