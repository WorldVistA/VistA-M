DGRPTU ;ALB/RMO - 10-10T Registration - Utilities; 04/25/2003
 ;;5.3;Registration;**108,513**;08/13/93
 ;
GETPAT(DGHOWPT,DGADDF,DFN,DGNEWPF) ;Look-up patient
 ; Input  -- DGHOWPT  How was patient entered
 ;                    1   =10-10T registration
 ;           DGADDF   Add new entry flag       (optional)
 ;                    1   =Allow new patient
 ; Output -- DFN      Patient IEN
 ;                    #   =Patient IEN
 ;                    -1  =No patient selected
 ;           DGNEWPF  New patient added flag
 ;                    1   =New patient added
 ;                    Null=Existing patient
 N DD,DIC,DINUM,DLAYGO,DO,X,Y
 S DIC="^DPT(",DIC(0)="AEMQ"
 I $G(DGADDF) S DIC(0)=DIC(0)_"L",DLAYGO=2
 W !! D ^DIC S DFN=+Y,DGNEWPF=$P(Y,U,3) N Y W ! D PAUSE^DG10
 ;If new patient
 I DGNEWPF D
 . N DA,DIE,DR
 . ;Set 'how was patient entered' field
 . I $G(DGHOWPT) S DA=DFN,DIE="^DPT(",DR=".098////"_DGHOWPT D ^DIE
 . ;Invoke code to execute new patient DR string for patient type
 . D NEW^DGRP
 Q
 ;
SETPAR(DGDIV,DGIO,DGASKDEV,DGRPTOUT) ;Set up registration parameters
 ; Input  -- None
 ; Output -- DGDIV    Primary Medical Center Division IEN
 ;           DGIO     Registration printer array
 ;           DGASKDEV Registration ask device flag
 ;           DGRPTOUT Quit flag
 ;                    1   =Timeout or User up-arrow
 ;Check ADT parameter set-up and user
 D LO^DGUTL
 ;Get primary medical center division IEN
 S DGDIV=$$PRIM^VASITE
 ;Get 1010 printer
 D GETPRT(DGDIV,.DGIO,.DGASKDEV,.DGRPTOUT)
SETPARQ Q
 ;
GETPRT(DGDIV,DGIO,DGASKDEV,DGRPTOUT) ;Get registration printer defaults
 ; Input  -- DGDIV    Primary Medical Center Division IEN
 ; Output -- DGIO     Registration printer array
 ;           DGASKDEV Registration ask device flag
 ;           DGRPTOUT Quit flag
 ;                    -1  =User entered up-arrow
 ;                    -2  =Timeout
 N DGASK,DTOUT,DUOUT,I,POP,Y
ASK ;Ask device in registration
 I $P(^DG(43,1,0),U,39) D  G GETPRTQ:$G(DGRPTOUT),ASK:$G(DGASK)
 . S DGASK=0
 . S:DGDIV %ZIS("B")=$P($G(^DG(40.8,+DGDIV,"DEV")),U,1)
 . S %ZIS="NQ",%ZIS("A")="Select 1010 printer: "
 . W ! D ^%ZIS I POP S DGRPTOUT=$S($D(DTOUT):-2,1:-1) Q
 . I $E(IOST,1,2)'["P-" W !,*7,"Not a printer" S DGASK=1 Q
 . S (DGIO(10),DGIO("PRF"),DGIO("RT"),DGIO("HS"))=ION,DGASKDEV=1
 ;Use closest printer
 I '$D(DGIO),$P(^DG(43,1,0),U,30) D
 . S %ZIS="N",IOP="HOME"
 . D ^%ZIS
 . I $D(IOS),IOS,$D(^%ZIS(1,+IOS,99)),$D(^%ZIS(1,+^(99),0)) S Y=$P(^(0),U,1) D
 . . W !,"Using closest printer ",Y,!
 . . F I=10,"PRF","RT","HS" S DGIO(I)=Y
 ;Use 10-10 printer for division
 I '$D(DGIO),$P($G(^DG(40.8,DGDIV,"DEV")),U,1)'="" S DGIO(10)=$P(^("DEV"),U,1)
 ;Reset home device
 D HOME^%ZIS
GETPRTQ K IO("Q"),%ZIS("B")
 Q
 ;
ELGCHK(DFN) ;Eligibility check for editing
 ; Input  -- DFN      Patient IEN
 ; Output -- 0=No and 1=Yes
 N Y
 ;If the elig is not verified, the user can edit
 I $P($G(^DPT(DFN,.361)),U,1)'="V" S Y=1
 ;If the elig is verified the user must hold the DG ELIGIBILITY key
 ;to edit
 I '$G(Y),$S('($D(DUZ)#2):0,'$D(^XUSEC("DG ELIGIBILITY",DUZ)):0,1:1) S Y=1
 Q +$G(Y)
