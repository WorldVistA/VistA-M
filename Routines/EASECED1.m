EASECED1 ;ALB/LBD - CALLS TO ADD NEW PATIENT RELATIONS AND INCOME PERSONS ;18 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5**;Mar 15, 2001
 ;NOTE: This routine was modified from DGRPEIS1 for LTC Co-pay
 ;Adds entries to FILES #408.12 & 408.13
 ;
NEW ;check if data in FILE #408.12
 ;out - DGPRI=IFN of #408.12
 ;      DGFL [-1='^'/-2=time-out]
 N DGRPDOB,DGRP0ND
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 S DGPRI=$O(^DGPR(408.12,"C",DFN_";DPT(",0)),DGFL=$G(DGFL)
 I '$D(^DGPR(408.12,+DGPRI,0)) S DGRP0ND=DFN_"^"_1_"^"_DFN_";DPT(",DGRPDOB=$P($G(^DPT(+DFN,0)),"^",3) D NEWPR
 S DGIRI=$O(^DGMT(408.22,"B",DFN,0))
 I '$D(^DGMT(408.22,+DGIRI,0)) D GETIENS^EASECU2(DFN,+DGPRI,DGTSTDT)
 Q
NEWIP ;Add relation to #408.13 file
 ; In - DFN=IEN of File #2
 ;      DGRP0ND=0 node of 408.13
 ;Out - DGIPI=408.13 IEN
 K DINUM N DGRPDOB,DGSEX,I,X
 S DGRPDOB=$P(DGRP0ND,"^",3),DGSEX=$P(DGRP0ND,"^",2)
 S (DIK,DIC)="^DGPR(408.13,",DIC(0)="L",DLAYGO=408.13,X=$P(DGRP0ND,"^",1) K DD,DO D FILE^DICN S (DGIPI,DA)=+Y K DLAYGO
 L +^DGPR(408.13,+DGIPI) S ^DGPR(408.13,+DGIPI,0)=DGRP0ND D IX1^DIK L -^DGPR(408.13,+DGIPI)
 S Y=DGIPI,DGRP0ND=DFN_"^"_$S(SPOUSE:2,1:"")_"^"_+Y_";DGPR(408.13,"
 ;FALLS THRU!
NEWPR ;Add entry to file #408.12
 ;In - DGRP0ND=0 node of 408.12
 ;     DGRPDOB=DOB of relation
 ;Out - DGPRI=IFN of new 408.12 entry
 K DINUM N DOB,X
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 S DOB=$G(DGRPDOB) I 'DOB S DOB=$E(DGTSTDT,1,3)-1_"0101" ; use dob for effective date...default = Jan 1 of prior year
DIC I $P(DGRP0ND,"^",2)']"" S DIC="^DG(408.11,",DIC(0)="AEQMZ",DIC("A")="RELATIONSHIP: ",DIC("S")="I Y>2,""E""_DGSEX[$P(^(0),""^"",3),$S(DGTYPE=""D"":1,Y<7:1,1:0)" D ^DIC I '$D(DTOUT),(Y'>0) W $C(7),"   Required!!" G DIC
 I $D(DTOUT) K DTOUT S DGFL=-2 G NEWPRQ
 I $P(DGRP0ND,"^",2)']"" S $P(DGRP0ND,"^",2)=+Y
 D ACT^EASECED2 I DGFL<0 D  G NEWPRQ
 .W !?3,$C(7),"Entry incomplete...deleted",!
 .Q:'$G(DA)!($G(DIK)'="^DGPR(408.13,")  ;defined for deps in newip
 .D ^DIK
 S (DIK,DIC)="^DGPR(408.12,",DIC(0)="L",DLAYGO=408.12,X=+DGRP0ND K DD,DO D FILE^DICN S DGPRI=+Y K DLAYGO
 S DA=+DGPRI L +^DGPR(408.12,+DGPRI) S ^DGPR(408.12,+DGPRI,0)=DGRP0ND,^DGPR(408.12,+DGPRI,"E",0)="^408.1275D^1^1",^(1,0)=DGACT_"^"_1 D IX1^DIK L -^DGPR(408.12,+DGPRI)
 D RESET^DGMTU11(DFN,DGTSTDT,$G(DGMTI))
 S Y=DGPRI
NEWPRQ K DGACT,DGSEX,DGRPDOB,DA,DIC,DIK,DIRUT,DTOUT,DUOUT,X,Y
 Q
SETUP ; called from SPINACT / sets vars for ASOF tag
 N FNAME S FNAME=$P($$NAME^DGMTU1(+X),",",2)
 S ACT=$O(^DGPR(408.12,+X,"E","AID","")),ACT=$O(^(+ACT,0)),ACT=$G(^DGPR(408.12,+X,"E",+ACT,0))
 I $P(ACT,"^",2)']"" Q  ; never active
 I '$P(ACT,U,2) D  Q
 .W !,"Dependent has been inactivated as of "
 .S Y=+ACT
 .D DD^%DT W Y H 3
 S IEN=+X
ASOF ;ask as of date
 N LYR,SPOUSE,DGXDT
 I '$D(DGTSTDT) N DGTSTDT S DGTSTDT=$S($D(DGMTDT):DGMTDT,1:DT)
 S SPOUSE=$S($P($G(^DGPR(408.12,+IEN,0)),"^",2)=2:1,1:0)
 S LYR=$E($$LYR^DGMTSCU1(DGTSTDT),1,3)_1231
 ;I 'SPOUSE S LYR=$E($$LYR^DGMTSCU1(LYR),1,3)_1231
 K DIR S DIR(0)="D^"_+ACT_":"_LYR_":AEP",DIR("A")="Date "_FNAME_" no longer a dependent"
 S DIR("?",1)="Enter the date this person was no longer a dependent of the veteran.",DIR("?",2)="This could include a date of death or the date a child turned 18 for"
 S DIR("?",3)="children.  For a spouse, this would be the date of divorce or date ",DIR("?",4)="of death of the spouse.  Date must be after the person became a"
 S DIR("?",5)="dependent, but prior to 12/31/"_($E(LYR,1,3)+1700)_"."
 I 'SPOUSE S DIR("?",6)=" ",DIR("?",7)="A person should only be inactivated if the individual was not a",DIR("?",8)="dependent at any time during the prior calendar year."
 S DIR("?")=" "
 I SPOUSE S DIR("?",6)=" ",DIR("?",7)="A spouse should be inactivated if the spouse and veteran were not",DIR("?",8)="married as of 12/31/"_($E(LYR,1,3)+1700)_"."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S DGFL=$S($D(DTOUT):-2,1:-1) Q
 S DGXDT=Y
 I $E(Y,1,3)=$E(LYR,1,3) D  Q:'$G(Y)
 .N DIR,DIRUT,DIROUT,DTOUT,DUOUT
 .W !!,"Warning: Data will be used if dependent was active at least one day in a"
 .W !,"year.  Data will not be used if inactivation is prior to 1/1/"_($E(LYR,1,3)+1700)_" or it"
 .W !,"is equal to the activation date."
 .S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to inactivate this dependent on the selected date?"
 .D ^DIR
 S DA(1)=IEN,DIC="^DGPR(408.12,"_DA(1)_",""E"",",X=DGXDT,DIC(0)="L",DLAYGO=408.1275 D ^DIC S DIE=DIC,DA=+Y,DR=".02////0" D ^DIE
 D RESET^DGMTU11(DFN)
ASOFQ K DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,X,Y
 Q
