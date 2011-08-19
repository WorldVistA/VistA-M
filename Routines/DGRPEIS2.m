DGRPEIS2 ;ALB/MIR,ERC - EDIT INCOME SCREENING DATA (SCREEN 9) ; 4/20/06 10:37am
 ;;5.3;Registration;**10,45,122,653,688**;Aug 13, 1993;Build 29
 ;  -Called from DGRPE to edit Scr #9 (Income Screening)
EDIT9 ; Allow edit of income screening amounts (called from DGRPE)
 ; In: DFN
 ;     DGRPANN as string of selected items
 ;     DGRPSEL as allowable groups for edit (V, S, and/or D)
 ;     DGRPSELT (maybe) as type of dependent selected (V=vet,
 ;        S=spouse, and D=dependent).  If not defined, it is set
 ;        to DGRPSEL.
 N MTVER,DGMTI,DGTY,DGIAIYR,DGTYEXT
 I 'DGRPANN Q  ; if no string passed in (nothing selected)
 S DGRPSELT=$G(DGRPSELT) I DGRPSELT']"" S DGRPSELT=DGRPSEL ; if no V, S, or D preface, edit all
 D ALL^DGMTU21(DFN,"VSD",DT,"IP")
 S DGIAIYR=$P($G(^DGMT(408.21,+$G(DGINC("V")),0)),"^",1)
 S DGIAIYR=$E(DGIAIYR,1,3)+1700
 S DGMTI=+$$LST^DGMTU(DFN,DT)
 I (+DGMTI>0),(+DGIAIYR>0) DO
 . S DGTY=$E($P(^DGMT(408.31,+DGMTI,0),"^",1),1,3)
 . S DGTYEXT=DGTY+1700
 . S:(DGTYEXT=DGIAIYR+1) MTVER=$P($G(^DGMT(408.31,+DGMTI,2)),"^",11)
 . S:(DGTYEXT'=(DGIAIYR+1)) MTVER=$$VER^DGMTUTL3(.DGINC)
 I (+DGMTI'>0)!(+DGIAIYR'>0) S MTVER=$$VER^DGMTUTL3(.DGINC)
 I '$G(DGREL("V")) D HELP^DGRPEIS3 G EDIT9Q
 I DGRPSELT["V" S DGPRI=+DGREL("V"),DGMTED=$D(DGMTED("V")) D EDT
 I '$G(DGRPOUT)&(DGRPSELT["S") S DGPRI=+DGREL("S"),DGMTED=$D(DGMTED("S")) D EDT
 I '$G(DGRPOUT)&(DGRPSELT["D") F DGCNT=0:0 S DGCNT=$O(DGREL("D",DGCNT)) Q:'DGCNT!($G(DGRPOUT))  S DGPRI=+DGREL("D",DGCNT),DGMTED=$D(DGMTED("D",DGCNT)) D EDT
 S DGFL=$G(DGFL)
 K DGCNT
EDIT9Q Q
 ;
EDT ;Edit inc and nt worth
 N DA,DGERR,DGFIN,DGINI,DGIRI,DIE,DR,OK
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 D GETIENS^DGMTU2(DFN,+DGPRI,DGTSTDT) G EDTQ:DGERR
 I DGRPSELT]"" W !!,"NAME: ",$$NAME^DGMTU1(DGPRI)
 I DGMTED W "    [Must edit through means test!!]" Q
 S DA=DGINI,DIE="^DGMT(408.21,"
 S:(+MTVER<1) DR="[DGRP ENTER/EDIT ANNUAL INCOME]"
 S:(+MTVER=1) DR="[DGRP V1 ENTER/EDIT ANNUAL INC]"
 D ^DIE S:'$D(DGFIN) DGRPOUT=1
 I $D(DTOUT) S DGFL=-2,DGRPOUT=1 Q
 I 'DGRPOUT S DR="103////^S X=DUZ;104///^S X=""NOW""" D ^DIE
 I 'DGRPOUT&'$D(DGINC("V")) D GETIENS^DGMTU2(DFN,+DGREL("V"),DT) S DGINC("V")=DGINI G:DGERR EDTQ
 I 'DGRPOUT&($G(DA)'=$G(DGINC("V"))) S DA=DGINC("V") D ^DIE
 ;
 ;log patient for transmission to HEC if DCD criteria are met
 D LOGDCD^IVMCUC($G(DFN))
 ;
EDTQ Q
 ;
SPOUSE ; make sure marital status, spouse is up-to-date
 ; input -- DFN
 ;          DGREL("V") as returned from GETREL for veteran
 ;  used -- DGSPFL as VETS marital status
 N DGMS
 D GETIENS^DGMTU2(DFN,+DGREL("V"),DT)
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
 N DGDT,DGISDT,DGDTSPEC,VDOB
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 S DGDT=$E(DGTSTDT,1,3)-1_"1231",DGISDT=$E(DGDT,1,3)+1700,DGACT=DOB
 S DGDTSPEC=$S($G(DGEDDEP):":EPX",1:":EP")
 ;S DIR(0)="D^"_DOB_":"_DGDT_DGDTSPEC,DIR("A")="EFFECTIVE DATE"
 S DIR(0)="D^"_DOB
 I RELATION=2 S VDOB=$P($G(^DPT(DFN,0)),"^",3) S:(VDOB>DOB) $P(DIR(0),"^",2)=VDOB
 S DIR(0)=DIR(0)_":"_DGDT_DGDTSPEC,DIR("A")="EFFECTIVE DATE"
 S DIR("?")="^D HELP1^DGRPEIS3(DGISDT)"
 D ^DIR K DIR I Y'>0 S DGFL=$S($D(DTOUT):-2,$D(DUOUT)!$D(DIRUT):-1,1:0) G ACTQ:DGFL,READ
 S DGACT=Y
ACTQ K DIRUT,DTOUT,DUOUT
 Q
RELTYPE(RELIEN,TYPE) ;* Return type of relationship
 ;
 ;* INPUT
 ;    RELIEN - IEN from Income Person file (408.13)
 ;    TYPE   - 0: Pull specific relationship from Relationship file
 ;           - 1: Just return "spouse", "child", "dependent"
 ;
 ;* OUTPUT
 ;    DGPATREL - Relationship value
 ;
 N DGPTRLIN,DGRELIEN,DGPATREL
 S TYPE=+$G(TYPE)
 I +$G(RELIEN)>0 DO
 .S DGPTRLIN=""
 .S DGPTRLIN=$O(^DGPR(408.12,"C",RELIEN_";DGPR(408.13,",DGPTRLIN))
 .S DGRELIEN=$P($G(^DGPR(408.12,DGPTRLIN,0)),"^",2)
 .S DGPATREL=$P($G(^DG(408.11,DGRELIEN,0)),"^",1)
 .S:DGPATREL']"" DGPATREL="dependent"
 .I +TYPE=1 S DGPATREL=$S(DGPATREL["SPOUSE":"spouse",($G(DGRPS)=8):"relative",$G(DGSCR8):"relative",1:"child")
 I +$G(RELIEN)'>0 DO
 .S:$G(DGANS)="S" DGPATREL="spouse"
 .S:$G(DGANS)="C" DGPATREL="child"
 .S:$G(DGANS)="D" DGPATREL="relative"
 S:DGPATREL="" DGPATREL="relative"
 Q DGPATREL
