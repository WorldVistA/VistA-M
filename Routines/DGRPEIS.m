DGRPEIS ;ALB/MIR,ERC - INCOME SCREENING DATA FOR EDIT ; 1/23/06 2:37pm
 ;;5.3;Registration;**10,45,108,624,653,688**;Aug 13, 1993;Build 29
 ; Handles editing of dependent info
 ; CHANGES TO THIS ROUTINE SHOULD BE COORDINATED WITH THE MEANS TEST
 ; DEVELOPER.  MANY CALLS IN THIS ROUTINE (ADD, EDIT, INACT, ETC.) ARE
 ; CALLED FROM MEANS TEST OR ARE MIMICKED THERE.
 ; In:   DFN as IEN of PATIENT file
 ;       DGDR as string of items selected for editing
 ;Out:   DGFL as -2 if time-out, -1 if up-arrow
EN S DGFL=0
 S DGISDT=$$LYR^DGMTSCU1(DT)
 S DGRP(0)=$G(^DPT(DFN,0)) D NEW^DGRPEIS1,GETREL^DGMTU11(DFN,"VSD",DGISDT)
 I DGDR[801 D SPOUSE^DGRPEIS2 S DGPREF=$G(DGREL("S")) G Q:DGFL I DGSPFL D:DGPREF EDIT(DGPREF,"S") I 'DGPREF D ADD(DFN,"S")
 K DGSPFL,DGPREF
Q Q
 ;
ADD(DFN,DGTYPE,DGTSTDT,DGDEP) ; subroutine to add to files 408.12 & 408.13
 ; In -- DFN as the IEN of file 2 for the vet
 ;       DGTYPE as C for mt children or D for all deps
 ;            S for spouse (default spouse)
 ;       DGTSTDT - optional test date
 ;       DGDEP - optional number of dependent children
 ;Out -- DGPRI as patient relation IEN
 ;       DGIPI as income person IEN
 ;       DGFL as -2 if time-out, -1 if '^', 0 otherwise
 N ANS,DA,PROMPT,SPOUSE,TYPE,DGVADD,DGSKIPST,DGSADD,DGIPIEN,DGUQTLP
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 S DGFL=$G(DGFL)
 S:('$D(DGDEP)) DGDEP=""
 S DGTYPE=$G(DGTYPE),SPOUSE=$S(DGTYPE']"":1,DGTYPE="C":0,DGTYPE="D":0,1:1)
 S DGFL=$G(DGFL),PROMPT="NAME^SEX^DATE OF BIRTH^^^^^^SSN^PS SSN REASON^MAIDEN NAME^STREET ADDRESS [LINE 1]^STREET ADDRESS [LINE 2]^STREET ADDRESS [LINE 3]^CITY^STATE^ZIP^PHONE NUMBER"
 S TYPE=$S(SPOUSE:"SPOUSE'S ",DGTYPE="C":"CHILD'S ",1:"DEPENDENT'S ")
 S DGSKIPST=0 ;* Skip Add 2 and 3 prompts when Add 1 or 2 not entered
 S DGUQTLP=0
 F DGRPI=.01:.01:.03,.09,.1,1.1:.1:1.8 D  Q:DGVADD  Q:DGSADD  Q:DGUQTLP  I DGFL Q
 . S (DGSADD,DGVADD,DGIPIEN)=0
 . ; Is spouse/dependent address same as patient address?
 . I +DGRPI=1.2 DO
 . . I $$FORIEN^DGADDUTL($P($G(^DPT(DFN,.11)),U,10)) G FOREIGN ; only ask next fields if address same if vet address is in USA
 . . K DIR
 . . S DIR(0)="YAO^^"
 . . S DIR("A")=TYPE_"STREET ADDRESS SAME AS PATIENT'S: "
 . . S DIR("B")="YES"
 . . S:TYPE'="SPOUSE'S " DIR("?")="Enter 'Y' if the child/dependent has the same address and phone number as the patient, otherwise enter 'N'."
 . . S:TYPE="SPOUSE'S " DIR("?")="Enter 'Y' if the spouse has the same address and phone number as the patient, otherwise enter 'N'."
 . . D ^DIR
 . . S DGVADD=+Y
 . . K Y,DIR
FOREIGN . . ;tag to rejoin if vet address is not USA
 . . S DGIPIEN=$$SPSCHK(DFN)
 . . I 'DGVADD,(TYPE'="SPOUSE'S"),(DGIPIEN) DO
 . . . K DIR,Y
 . . . S DIR(0)="YAO^^"
 . . . S DIR("A")=TYPE_"STREET ADDRESS SAME AS SPOUSE'S: "
 . . . S DIR("B")="YES"
 . . . S DIR("?")="Enter 'Y' if the child/dependent has the same address as the spouse, otherwise enter 'N'."
 . . . D ^DIR
 . . . S DGSADD=+Y
 . . . K Y,DIR
 . ;
 . ; If spouse/dependent address is same as patient's set spouse/dep add.
 . I DGVADD D PATASET(DFN) ;*Set to Patient address
 . I DGSADD D SPSASET(DGIPIEN) ;*Set to Spouse address
 . ;
 . ; Spouse/dep address is not same as patient/spouse add, prompt add.
 . I 'DGVADD,'DGSADD DO
 . . K DIR S DIR(0)="408.13,"_DGRPI I DGRPI=.01 S DIR(0)=DIR(0)_"O"
 . . I DGRPI=.02,SPOUSE S X=$P($G(^DPT(DFN,0)),"^",2) I X]"" S DIR("B")=$S(X="F":"MALE",1:"FEMALE") ; default spouse sex
 . . S:DGRPI=.03 DIR(0)=DIR(0)_"^^"_"S %DT=""EP"" D ^%DT S X=Y K:($E(DGTSTDT,1,3)-1_1231)<X X"
 . . S:+DGRPI<1 DIR("A")=TYPE_$P(PROMPT,"^",DGRPI*100)
 . . S:+DGRPI>1 DIR("A")=TYPE_$P(PROMPT,"^",DGRPI*10)
 . . I (+DGRPI'=1.1)!((+DGRPI=1.1)&(SPOUSE)&($G(ANS(.02))="F")) DO
 . . . ;if .1, check to see if SSN is a pseudo, if yes, require Reason
 . . . I DGRPI=.1 D REAS Q
 . . . I (+DGRPI=1.3)!(+DGRPI=1.4) D:('DGSKIPST) ^DIR
 . . . I (+DGRPI'=1.3)&(+DGRPI'=1.4) D ^DIR
 . . . I $D(DTOUT)!$D(DUOUT) S:(DGRPI=.09)!((DGRPI>1.1)&(DGRPI<1.9)) DGUQTLP=1
 . . . I $D(DTOUT)!$D(DUOUT) S DGFL=$S($D(DUOUT):$S((DGRPI>1.1)&(DGRPI<1.9):"",1:-1),1:-2) Q
 . . . I DGRPI=.01,(Y']"") S DGFL=-1 Q
 . . . S ANS(DGRPI)=Y
 . . . I (+DGRPI=1.2),(ANS(1.2)']"") S DGSKIPST=1
 . . . I (+DGRPI=1.3),(ANS(1.3)']"") S DGSKIPST=1
 . . . I DGRPI=.03,$D(ANS(.03)) S X2=ANS(.03),X1=DT D ^%DTC I 'SPOUSE S AGE=(X/365.25) W ?62,"(AGE: "_$P(AGE,".")_")" I AGE>17 D WRT^DGRPEIS3
 . . I DGRPI=.01,(Y']"") Q
 I '$D(ANS(.01)) S DGFL=0 G ADDQ
 I DGFL=-2!'$D(ANS(.09)) W !?3,*7,"Incomplete Entry...Deleted" G ADDQ
 S DGRP0ND=ANS(.01)_"^"_ANS(.02)_"^"_ANS(.03)_"^^^^^^"_$G(ANS(.09))_"^"_$G(ANS(.1))
 S DGRP1ND=$G(ANS(1.1))_"^"_$G(ANS(1.2))_"^"_$G(ANS(1.3))_"^"_$G(ANS(1.4))_"^"_$G(ANS(1.5))_"^"_$P($G(ANS(1.6)),"^",1)_"^"_$G(ANS(1.7))_"^"_$G(ANS(1.8))
 D NEWIP^DGRPEIS1
ADDQ K DGRP0ND,DGRP1ND,DGRPI,DIR,DIRUT,DTOUT,DUOUT
 Q
 ;
PATASET(DFN) ;* Set the address equal to the patient's
 ; Input:  DFN   - Patient file IEN and key to Patient Relation entries
 ; Output: ANS array of dependents address
 S ANS(1.2)=$P($G(^DPT(DFN,.11)),"^",1)
 S ANS(1.3)=$P($G(^DPT(DFN,.11)),"^",2)
 S ANS(1.4)=$P($G(^DPT(DFN,.11)),"^",3)
 S ANS(1.5)=$P($G(^DPT(DFN,.11)),"^",4)
 S ANS(1.6)=$P($G(^DPT(DFN,.11)),"^",5)
 S ANS(1.7)=$P($G(^DPT(DFN,.11)),"^",12)
 S ANS(1.8)=$P($G(^DPT(DFN,.13)),"^",1)
 Q
 ;
SPSCHK(DFN) ;*Check for existence of active spouse
 ; Input:  DFN   - Patient file IEN and key to Patient Relation entries
 ; Output: IPIEN - Spouse IEN in 408.13
 ;                 0: no active spouse
 N PRIEN,IPIEN,SPREDIEN,SPRED
 S IPIEN=0
 I $D(^DGPR(408.12,"B",DFN)) DO
 . S PRIEN=""
 . F  S PRIEN=$O(^DGPR(408.12,"B",DFN,PRIEN)) Q:(+PRIEN=0)  DO
 . . I $D(^DG(408.11,$P(^DGPR(408.12,PRIEN,0),"^",2),0)) DO
 . . . I $P(^DG(408.11,$P(^DGPR(408.12,PRIEN,0),"^",2),0),"^",1)="SPOUSE" DO
 . . . . S SPRED=$O(^DGPR(408.12,PRIEN,"E","AID",""))
 . . . . S:+SPRED'=0 SPREDIEN=$O(^DGPR(408.12,PRIEN,"E","AID",SPRED,""))
 . . . . I +$P($G(^DGPR(408.12,PRIEN,"E",SPREDIEN,0)),"^",2)=1 S IPIEN=$P($P(^DGPR(408.12,PRIEN,0),"^",3),";",1)
 Q IPIEN
 ;
SPSASET(IPIEN) ;* Set the address equal to the patient's spouse address
 ; Input:  IPIEN - Spouse IEN in 408.13
 ; Output: ANS array of Childs address
 ;
 S ANS(1.2)=$P($G(^DGPR(408.13,IPIEN,1)),"^",2)
 S ANS(1.3)=$P($G(^DGPR(408.13,IPIEN,1)),"^",3)
 S ANS(1.4)=$P($G(^DGPR(408.13,IPIEN,1)),"^",4)
 S ANS(1.5)=$P($G(^DGPR(408.13,IPIEN,1)),"^",5)
 S ANS(1.6)=$P($G(^DGPR(408.13,IPIEN,1)),"^",6)
 S ANS(1.7)=$P($G(^DGPR(408.13,IPIEN,1)),"^",7)
 S ANS(1.8)=$P($G(^DGPR(408.13,IPIEN,1)),"^",8)
 Q
 ;
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
 I $D(DGREL("D",X)) S X=DGREL("D",X) D SETUP^DGRPEIS1 Q  ; check for IVM dependents
 S X=$G(DGREL("C",X)) I 'X G INACT ; check for MT deps
 D SETUP^DGRPEIS1
 Q
EDIT(DGPREF,DGTYPE,DATE) ; edit demographic data for a dep
 ;    Input -- DGPREF as returned by GETREL^DGMTU11 for dep to edit
 ;             DGTYPE as D if all deps or C if MT children only
 ;                    S for spouse (optional - spouse if not defined)
 ;             DATE [optional] as income screening year/default= last yr
 ;   Output -- DGFL as -2 if timeout, -1 if '^', or 0 o/w
 N DOB,DGACT,RELATION,UPARROW,X,Y,DGEDDEP
 D EDIT^DGRPEIS3
 Q
REAS ;require a Pseudo SSN Reason if the SSN is a Pseudo - DG*5.3*653 ERC
 Q:ANS(.09)'["P"
 S DIR(0)="408.13,.1^^"
 D ^DIR
 I $D(DUOUT) S DGFL=-2 Q
 I $D(DTOUT)!($D(DIRUT)) W !!,"Pseudo SSN Reason Required if the SSN is Pseudo." G REAS
 ;I $D(DUOUT) S DGFL=-2 Q
 S ANS(.1)=Y
 Q
