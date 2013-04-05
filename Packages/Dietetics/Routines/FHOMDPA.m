FHOMDPA ;Hines OIFO/RTK OUTPATIENT LOOK-UP ;12/3/02  09:46
 ;;5.5;DIETETICS;**5,17,24,31**;Jan 28, 2005;Build 1
F1 ;
 ; FHALL=1 - Lookup INPATIENTS or OUTPATIENTS
 ; FHALL=0 - Lookup OUTPATIENTS only (to lookup INPATS only, use FHDPA)
 ; FHDFN=IEN in file #115, FHZ115=.01 in file #115 (ie P27 or N1866)
 ; DFN=IEN in file #2 (or NULL), IEN200=IEN in file #200 (or NULL)
 ;
 S (FHZ115,FHDFN,IEN200)="",FHALL=$G(FHALL),FHMSG1=$G(FHMSG1)
 R !!,"Select Patient (Name or SSN): ",X:DTIME I '$T!(U[X) D NOP Q
 S XRESP=X
 I XRESP=" " S FHDFN=$G(^DISV(DUZ,"^FHPT(")) I FHDFN'="" D PATNAME^FHOMUTL W FHPTNM K:DFN="" FHALL Q:DFN=""  S Y=DFN D FX1 K FHALL Q
 K DIC S DIC=2,DIC(0)="EZM" D ^DIC K DIC I U[X D NOP Q
 S FHYIEN=+Y,DFN=FHYIEN
FX1 I FHALL=1,$D(^DPT(DFN,.1)) D ENOM^FHDPA K FHALL Q
 I $D(^DPT(DFN,.1)) D MSG K FHALL Q
 ;Added FH*5.5*24,Revised FH*5.5*31
 D DEAD I FHDFN=0 S FHDFN="" Q
 I DFN>0 D VER I Y="^" D NOP Q
 I Y=0,XRESP=" " D F1 Q
 I Y=1 S FHZ115="P"_DFN D ADD K FHALL Q
FF11 ;
 W !!,"LOOKING IN THE NEW PERSON FILE, FILE # 200.",!!
 S X=XRESP K DIC S DIC=200,DIC(0)="EQZM" D ^DIC K DIC I U[X D NOP Q
 S FHYIEN=+Y,IEN200=FHYIEN
 I IEN200>0 D VER I Y="^"!(Y=0) K FHALL Q
 I IEN200<1 W !!,"NOT FOUND IN 2 OR 200" D F1 K FHALL Q
 S FHZ115="N"_IEN200 D ADD
 K FHALL Q
VER ;
 W ! S DIR(0)="YA",DIR("A")="Correct? ",DIR("B")="Y" D ^DIR
 Q
ADD ; ADD ENTRY IF NOT ALREADY IN FILE 115
 D CHECK I FLAG=1 Q
 K DD,DO S DIC="^FHPT(",DIC(0)="L",X=FHZ115 D FILE^DICN
 S FHDFN=$O(^FHPT("B",FHZ115,"")) I FHDFN="" Q
 S ^DISV(DUZ,"^FHPT(")=FHDFN  ;save SPACEBAR/RETURN value
 S FHPTTYP=$E(FHZ115,1),FHPTR=$E(FHZ115,2,99)
 I FHPTTYP="P" D
 .K DIE S DA=FHDFN,DIE="^FHPT(",DR="14////^S X=FHPTR;15///@" D ^DIE
 I FHPTTYP="N" D
 .K DIE S DA=FHDFN,DIE="^FHPT(",DR="15////^S X=FHPTR;14///@" D ^DIE
 Q
CHECK ; CHECK IF ALREADY IN FILE 115
 S FLAG=0,FHDFN=""
 I $D(^FHPT("B",FHZ115)) D
 .S FLAG=1,FHDFN=$O(^FHPT("B",FHZ115,""))
 .S ^DISV(DUZ,"^FHPT(")=FHDFN  ;save SPACEBAR/RETURN value
 .I $E(FHZ115,1)="P" S DFN=$E(FHZ115,2,99),IEN200=""
 .I $E(FHZ115,1)="N" S IEN200=$E(FHZ115,2,99),DFN=""
 Q
MSG ;
 W !!,"Currently admitted as an Inpatient." D NOP
 Q
NOP ;
 S FHDFN=0,DFN=0,Y=-1 K FHALL Q
 Q
DEAD ;PATIENT IS DEAD
 ;Added patch FH*5.5*24, Revised FH*5.5*31
 ;If no date of death quit 
 I $P($G(^DPT(DFN,.35)),U)="" Q
 ;Get patient's date of death
 S PTDOD=$$FMTE^XLFDT($P($G(^DPT(DFN,.35)),U),"D")
 ;Get patient's name
 S PTNAME=$P($G(^DPT(DFN,0)),U)
 ;Display patient is dead message
 W !!?5,"This patient, ",PTNAME,", died on ",PTDOD,"."
 ;If ordering Outpatient meal
 I FHMSG1'="" D
 . ;Set quit condition for outpatient meal ordering
 . D NOP
 . ;Display outpatient can't be ordered for dead patient message
 . D TYPE^FHOMUTL
 . W !?5,FHMSGML," cannot be ordered for this patient."
 W !
 K PTDOD,PTNAME
 Q
