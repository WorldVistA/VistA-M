EASECED2 ;ALB/LBD - EDIT INCOME SCREENING DATA ;20 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5**;Mar 15, 2001
 ;NOTE: This routine was modified from DGRPEIS2 for LTC Co-pay
 ;
 ;
SPOUSE ; make sure marital status, spouse is up-to-date
 ; input -- DFN
 ;          DGREL("V") as returned from GETREL for veteran
 ;  used -- DGSPFL as VETS marital status
 N DGMS
 D GETIENS^EASECU2(DFN,+DGREL("V"),DT)
 S DGMS=$P($G(^DIC(11,+$P($G(^DPT(DFN,0)),"^",5),0)),"^",3),DGMS=$S("^M^S^"[("^"_DGMS_"^"):"YES",DGMS']"":"",1:"NO")
 D GETREL^DGMTU11(DFN,"S",DT,$G(DGMTI)) I $D(DGREL("S")) S DGMS="YES"
 ;
SPOUSE1 S DIE="^DGMT(408.22,",DA=DGIRI,DR=".05"_$S($G(DGMTI):"///",1:"//")_"^S X=DGMS" D ^DIE K DIE,DA,DR
 S DGSPFL=$P($G(^DGMT(408.22,DGIRI,0)),"^",5)
 Q
 ;
ACT ; ask date active as of (use dob if KIDS)
 ; In:  DOB
 ;      DGRP0ND as 0 node of PATIENT RELATION file (relation=piece 2)
 ;Out:  DGACT as date patient should be activated as of
 ;      DGFL as -1 if '^' or -2 if time-out
 N RELATION,X,Y
 S DGFL=$G(DGFL),RELATION=$P(DGRP0ND,"^",2)
 I RELATION=1 S DGACT=DOB Q  ;use DOB is self
 I "^3^4^"[("^"_RELATION_"^") S Y=DOB X ^DD("DD") S DIR("B")=Y ;if son or daughter, use DOB as default
 ;
READ ; get active as of date
 ; DIR("B") set before entry
 ; DOB passed in as input
 N DGDT,DGISDT,DGDTSPEC
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 S DGDT=$E(DGTSTDT,1,3)_"1231",DGISDT=$E(DGDT,1,3)+1700,DGACT=DOB
 S DGDTSPEC=$S($G(DGEDDEP):":EPX",1:":EP")
 S DIR(0)="D^"_DOB_":"_DGDT_DGDTSPEC,DIR("A")="EFFECTIVE DATE"
 S DIR("?")="^D HELP1^EASECED3(DGISDT)"
 D ^DIR K DIR I Y'>0 S DGFL=$S($D(DTOUT):-2,$D(DUOUT)!$D(DIRUT):-1,1:0) G ACTQ:DGFL,READ
 S DGACT=Y
ACTQ K DIRUT,DTOUT,DUOUT
 Q
