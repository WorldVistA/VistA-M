EASECED ;ALB/LBD - INCOME SCREENING DATA FOR EDIT ; 19 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5**;Mar 15, 2001
 ; Handles editing of dependent info
 ; CHANGES TO THIS ROUTINE SHOULD BE COORDINATED WITH THE MEANS TEST
 ; DEVELOPER.  MANY CALLS IN THIS ROUTINE (ADD, EDIT, INACT, ETC.) ARE
 ; CALLED FROM MEANS TEST OR ARE MIMICKED THERE.
 ;
 ; NOTE: This routine was modified from DGRPEIS for LTC Co-pay
 ; In:   DFN as IEN of PATIENT file
 ;       DGDR as string of items selected for editing
 ;Out:   DGFL as -2 if time-out, -1 if up-arrow
EN S DGFL=0
 S DGISDT=$E(DT,1,3)_"0000"
 S DGRP(0)=$G(^DPT(DFN,0)) D NEW^EASECED1,GETREL^DGMTU11(DFN,"VSD",DGISDT)
 I DGDR[801 D SPOUSE^EASECED2 S DGPREF=$G(DGREL("S")) G Q:DGFL I DGSPFL D:DGPREF EDIT(DGPREF,"S") I 'DGPREF D ADD(DFN,"S")
 K DGSPFL,DGPREF
Q Q
 ;
ADD(DFN,DGTYPE,DGTSTDT) ; subroutine to add to files 408.12 & 408.13
 ; In -- DFN as the IEN of file 2 for the vet
 ;       DGTYPE as C for mt children or D for all deps
 ;            S for spouse (default spouse)
 ;       DGTSTDT - optional test date
 ;Out -- DGPRI as patient relation IEN
 ;       DGIPI as income person IEN
 ;       DGFL as -2 if time-out, -1 if '^', 0 otherwise
 N ANS,DA,PROMPT,SPOUSE,TYPE
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 S DGFL=$G(DGFL)
 S DGTYPE=$G(DGTYPE),SPOUSE=$S(DGTYPE']"":1,DGTYPE="C":0,DGTYPE="D":0,1:1)
 S DGFL=$G(DGFL),PROMPT="NAME^SEX^DATE OF BIRTH^^^^^^SSN",TYPE=$S(SPOUSE:"SPOUSE'S ",DGTYPE="D":"DEPENDENT'S ",1:"CHILD'S ")
 F DGRPI=.01:.01:.03,.09 D  I DGFL Q
 . K DIR S DIR(0)="408.13,"_DGRPI I DGRPI=.01 S DIR(0)=DIR(0)_"O"
 . I DGRPI=.02,SPOUSE S X=$P($G(^DPT(DFN,0)),"^",2) I X]"" S DIR("B")=$S(X="F":"MALE",1:"FEMALE") ; default spouse sex
 . S:DGRPI=.03 DIR(0)=DIR(0)_"^^"_"S %DT=""EP"" D ^%DT S X=Y K:($E(DGTSTDT,1,3)_1231)<X X"
 . S DIR("A")=TYPE_$P(PROMPT,"^",DGRPI*100)
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S DGFL=$S($D(DUOUT):$S(DGRPI=.09:"",1:-1),1:-2) Q
 . I DGRPI=.01,(Y']"") S DGFL=-1 Q
 . S ANS(DGRPI)=Y
 . I DGRPI=.03,$D(ANS(.03)) S X2=ANS(.03),X1=DT D ^%DTC I 'SPOUSE S AGE=(X/365.25) W ?62,"(AGE: "_$P(AGE,".")_")" I AGE>17 D WRT^EASECED3
 I '$D(ANS(.01)) S DGFL=0 G ADDQ
 I DGFL=-2!'$D(ANS(.03)) W !?3,$C(7),"Incomplete Entry...Deleted" G ADDQ
 S DGRP0ND=ANS(.01)_"^"_ANS(.02)_"^"_ANS(.03)_"^^^^^^"_$G(ANS(.09)) D NEWIP^EASECED1
ADDQ K DGRP0ND,DGRPI,DIR,DIRUT,DTOUT,DUOUT
 Q
INACT ; prompt to inactivate a patient relation
 ;     Input -- DGREL("D") array of dependents
 ;              DGDEP as number of deps (from GETREL call)
 N ACT,DGDT,IEN,X
 S DGFL=$G(DGFL)
 I 'DGDEP W !!,"No dependents to inactivate!" Q
 W !!,"Enter a number 1-",DGDEP," to indicate the dependent you wish to inactivate: " R X:DTIME
 I '$T S DGFL=-2 Q
 I X["^" S DGFL=-1 Q
 I X']"" Q
 I X["?" W !!,"Enter a number 1-",DGDEP," indicating the number of the dependent you wish to inactivate" G INACT
 I $D(DGREL("D",X)) S X=DGREL("D",X) D SETUP^EASECED1 Q  ; check for IVM dependents
 S X=$G(DGREL("C",X)) I 'X G INACT ; check for MT deps
 D SETUP^EASECED1
 Q
EDIT(DGPREF,DGTYPE,DATE) ; edit demographic data for a dep
 ;    Input -- DGPREF as returned by GETREL^DGMTU11 for dep to edit
 ;             DGTYPE as D if all deps or C if MT children only
 ;                    S for spouse (optional - spouse if not defined)
 ;             DATE [optional] as income screening year/default= last yr
 ;   Output -- DGFL as -2 if timeout, -1 if '^', or 0 o/w
 N DOB,DGACT,RELATION,UPARROW,X,Y,DGEDDEP
 D EDIT^EASECED3
 Q
