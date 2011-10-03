IBCNSP1 ;ALB/AAS - INSURANCE MANAGEMENT - policy actions ;22-OCT-92
 ;;2.0;INTEGRATED BILLING;**6,28,40,43,52,85,103,361,371,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;ICR#5002 for read of ^DIE input template data
 ;
% G EN^IBCNSP
 ;
EA ; -- Edit all
 N IBCDFN,IBTRC,IBTRN
 D FULL^VALM1 W !!
 S IBCDFN=$P($G(IBPPOL),"^",4) I 'IBCDFN W !!,"Can't identify the policy!" G EAQ
 S IBCNSEH=1 D PAT^IBCNSEH
 ;
 D BEFORE^IBCNSEVT
 D PATPOL^IBCNSM32(IBCDFN)
 D AFTER^IBCNSEVT,^IBCNSEVT
 ;
 ; -- edit policy data
 D POL^IBCNSEH
 D EDPOL^IBCNSM3(IBCDFN)
 ;
 W !! D AI
 ;
EAQ D:$G(IBTRC) AIP^IBCNSP02(IBTRC)
 D BLD^IBCNSP
 S VALMBCK="R"
 Q
 ;
AB ; -- Annual Benefits
 S X=+$P($G(IBPPOL),"^",4),IBCNS=+$G(^DPT(DFN,.312,X,0)),IBCPOL=+$P($G(^(0)),"^",18)
 I 'IBCPOL W !!,"Can't identify the plan!" S VALMBCK="" G ABQ
 D FULL^VALM1 W !!
 D EN^VALM("IBCNS ANNUAL BENEFITS")
 S VALMBCK="R"
ABQ Q
 ;
BU ; -- Benefits Used
 S IBCDFN=+$P($G(IBPPOL),"^",4),IBCNS=+$G(^DPT(DFN,.312,IBCDFN,0)),IBCPOL=+$P($G(^(0)),"^",18)
 I 'IBCPOL W !!,"Can't identify the plan!" S VALMBCK="" G BUQ
 D FULL^VALM1 W !!
 D EN^VALM("IBCNS BENEFITS USED BY DATE")
 S VALMBCK="R"
BUQ Q
 ;
IT ; -- edit insurance type info from patient policy and plan edit
 D FULL^VALM1 W !!
 N IBCDFN
 S IBCDFN=+$P($G(IBPPOL),"^",4),IBCPOL=+$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)
 I 'IBCPOL W !!,"Can't identify the plan!" S VALMBCK="" G ITQ
 D ITEDIT(IBCPOL,IBCDFN)
ITQ S VALMBCK="R" Q
 ;
IT1 ; -- edit insurance type info from patient policy
 D ITEDIT(IBCPOL)
 S VALMBCK="R"
 Q
 ;
ITEDIT(IBCPOL,IBCDFN) ;Edit insurance type info once you have plan (IBCPOL)
 ; IBCDFN = the ifn of the policy multiple for pt in ^DPT, node .312
 ;          only defined for editing via patient policy
 G:'$G(IBCPOL) ITEDITQ
 D SAVE^IBCNSP3(IBCPOL)
 L +^IBA(355.3,+IBCPOL):5 I '$T D LOCKED^IBTRCD1 G ITEDITQ
 I $G(IBCDFN) S IBCNSEH=+$G(^IBE(350.9,1,4)) D POL^IBCNSEH
 I $P($G(^IBA(355.3,IBCPOL,0)),"^",11) W !?2,*7,"Please note that this plan is inactive!",!
 S DA=IBCPOL,DIE="^IBA(355.3,",DR=".05;.12;.06;.07;.08"
 D ^DIE K DIC,DIE,DA,DR
 D COMP^IBCNSP3(IBCPOL)
 I IBDIF D UPDATE^IBCNSP3(IBCPOL) D:$G(IBCDFN) UPDATPT^IBCNSP3(DFN,IBCDFN),BLD^IBCNSP D:'$G(IBCDFN) INIT^IBCNSC4
 L -^IBA(355.3,+IBCPOL)
ITEDITQ Q
 ;
ED ; -- Edit effective dates
 D FULL^VALM1 W !!
 N IBDIF,DA,DR,DIE,DIC
 D BEFORE^IBCNSEVT
 D SAVEPT^IBCNSP3(DFN,IBCDFN)
 L +^DPT(DFN,.312,+$P($G(IBPPOL),"^",4)):5 I '$T D LOCKED^IBTRCD1 G EDQ
 D VARS^IBCNSP3
 S DR="8;3;1.09//;3.04"
 D ^DIE K DIC,DIE,DA,DR
 D COMPPT^IBCNSP3(DFN,IBCDFN) I IBDIF D UPDATPT^IBCNSP3(DFN,IBCDFN),UPDCLM(DFN,IBCDFN),AFTER^IBCNSEVT,^IBCNSEVT,BLD^IBCNSP
 L -^DPT(DFN,.312,+$P($G(IBPPOL),"^",4))
EDQ S VALMBCK="R" Q
 ;
VC ; -- Verify Coverage
 D FULL^VALM1 W !!
 D VFY^IBCNSM2
 D BLD^IBCNSP
 S VALMBCK="R" Q
 ;
SU ; -- Subscriber Update
 D FULL^VALM1 W !!
 ;Patch 40
 N IBDIF,DA,DR,DIC,DIE,DGSENFLG
 S DGSENFLG=1
 D SAVEPT^IBCNSP3(DFN,IBCDFN)
 D VARS^IBCNSP3
 L +^DPT(DFN,.312,+$P($G(IBPPOL),"^",4)):5 I '$T D LOCKED^IBTRCD1 G SUQ
 ;
 D EDIT(DFN,IBCDFN)   ; IB*371 - edit pat ins 2.312 subfile fields
 ;
 D COMPPT^IBCNSP3(DFN,IBCDFN)
 I IBDIF D UPDATPT^IBCNSP3(DFN,IBCDFN),BLD^IBCNSP
 L -^DPT(DFN,.312,+$P($G(IBPPOL),"^",4))
SUQ S VALMBCK="R" Q
 ;
IC ; -- Insurance Contact Information
 D FULL^VALM1 W !!
 N IBDIF,DA,DR,DIC,DIE,IBTRC,DIR,DUOUT,DTOUT,DIRUT,IBTRN
 D AI
 D:$G(IBTRC) AIP^IBCNSP02(IBTRC),BLD^IBCNSP
 S VALMBCK="R" Q
 Q
AI ; -- Add ins. verification entry
 N X,Y,I,J,DA,DR,DIC,DIE,DR,DD,DO,VA,VAIN,VAERR,IBQUIT,IBXIFN,IBTRN,DUOUT,IBX,IBQUIT,DTOUT
 Q:'$G(DFN)
 Q:'$G(IBCDFN)  S IBQUIT=0
 D AI^IBCNSP02
 Q
 ;
PIDEF(IBREL,FLD,IBDFN,SPDEF) ; Function to return patient file defaults
 ; Called from input template IBCN PATIENT INSURANCE
 ; IBREL = value from 2.312,4.03 field (PT. RELATIONSHIP - HIPAA)
 ;   FLD = field# in file 2.312
 ; IBDFN = patient ien to file 2
 ; SPDEF = spouse default flag =1 if this field should be defaulted
 ;         when the spouse is the policy holder
 ;
 ; The purpose is to provide a default value for the field when the
 ; patient and the ins. subscriber are the same.
 ;
 NEW VAL
 S VAL=""
 I +$G(IBREL)'=1,+$G(IBREL)'=18 G PIDEFX     ; patient not the insured or spouse, get out
 I +$G(IBREL)=1,'$G(SPDEF) G PIDEFX          ; not a field for spouse default
 I '$G(FLD) G PIDEFX                         ; no field# passed in
 I '$G(IBDFN) G PIDEFX                       ; no patient passed in
 ;
 ; Build the patient demographics area
 I '$D(^UTILITY("VADM",$J)) D
 . N VAHOW,DFN,VADM
 . S VAHOW=2,DFN=IBDFN D DEM^VADPT
 . Q
 ;
 ; Build the patient address area
 I '$D(^UTILITY("VAPA",$J)) D
 . N VAHOW,DFN,VAPA
 . S VAHOW=2,DFN=IBDFN,VAPA("P")="" D ADD^VADPT
 . Q
 ;
 I FLD=17 S VAL=$P($G(^UTILITY("VADM",$J,1)),U,1) G PIDEFX                          ; Name
 I FLD=3.01 S VAL=$$FMTE^XLFDT($P($G(^UTILITY("VADM",$J,3)),U,1),"5Z") G PIDEFX     ; Date of Birth
 I FLD=3.02 S VAL=$$EXTERNAL^DILFD(2,.325,,$P($G(^DPT(IBDFN,.32)),U,5)) G PIDEFX    ; Branch
 I FLD=3.05 S VAL=$P($G(^UTILITY("VADM",$J,2)),U,2) G PIDEFX                        ; SSN
 I FLD=3.06 S VAL=$P($G(^UTILITY("VAPA",$J,1)),U,1) G PIDEFX                        ; Street Address 1
 I FLD=3.07 S VAL=$P($G(^UTILITY("VAPA",$J,2)),U,1) G PIDEFX                        ; Street Address 2
 I FLD=3.08 S VAL=$P($G(^UTILITY("VAPA",$J,4)),U,1) G PIDEFX                        ; City
 I FLD=3.09 S VAL=$P($G(^UTILITY("VAPA",$J,5)),U,2) G PIDEFX                        ; State
 I FLD=3.1 S VAL=$P($G(^UTILITY("VAPA",$J,11)),U,2) G PIDEFX                        ; Zipcode
 I FLD=3.11 S VAL=$P($G(^UTILITY("VAPA",$J,8)),U,1) G PIDEFX                        ; Phone#
 I FLD=3.12 S VAL=$P($G(^UTILITY("VADM",$J,5)),U,2) G PIDEFX                        ; Sex
PIDEFX ;
 Q VAL
 ;
ASK(QUES,DEFLT) ; Function to ask Yes/No Question
 ; Returns 1 (yes), 0 (no, up-arrow, or timeout)
 NEW X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y",DIR("A")=$G(QUES)
 S DIR("B")=$S($G(DEFLT):"Yes",1:"No")
 W ! D ^DIR W:Y !
 I $D(DIRUT) S Y=0
ASKX ;
 Q Y
 ;
EDIT(IBDFN,IBCDFN,IBQUIT) ; Main call to edit data in 2.312 pat ins subfile
 ;  IBDFN - patient DFN
 ; IBCDFN - ien for patient insurance policy in subfile 2.312
 ; IBQUIT - Output variable.  Pass by reference.  Will be set to 1 if
 ;          the user entered an up-arrow, timed-out, or deleted the
 ;          2.312 subfile entry by entering "@" at the .01 field
 ; 
 NEW DA,DR,DIE,IBZ,IBY,X,Y,DTOUT
 NEW IDS,SUB,PAT,PCE,SUB1,PAT1
 S DA(1)=+$G(IBDFN)    ; patient IEN
 S DA=+$G(IBCDFN)      ; patient insurance IEN
 I 'DA!'DA(1) G EDITX
 S DIE="^DPT("_IBDFN_",.312,"
 ;
 ; Find the input template IEN for the [IBCN PATIENT INSURANCE] template
 S IBY=+$$FIND1^DIC(.402,,"X","IBCN PATIENT INSURANCE")
 I 'IBY G EDITX
 ;
 ; Build the DR array/string - ICR# 5002
 M DR(1)=^DIE(IBY,"DR",2)
 S DR=$G(DR(1,2.312))
 I DR="" G EDITX
 ;
 S $P(^DIE(IBY,0),U,7)=DT   ; see TEM+2^DIE  ICR# 5002
 ;
 D ^DIE     ; edit subfile data
 ;
 ; If the user entered an up-arrow, or timed-out, or deleted the entry,
 ; then set the output variable IBQUIT
 I $D(Y)!$D(DTOUT)!'$D(DA) S IBQUIT=1
 ;
 F IBZ="VADM","VAPA" K ^UTILITY(IBZ,$J)    ; cleanup scratch global
 ;
 D UPDCLM(IBDFN,IBCDFN)      ; update editable claims
 ;
 ; Cleanup any problems in the secondary ID area
 S IDS=$G(^DPT(IBDFN,.312,IBCDFN,5))           ; whole 5 node
 S (SUB,PAT)=""
 F PCE=3:1:8 S $P(SUB,U,PCE)=$P(IDS,U,PCE-1)   ; subscriber sec ID/qual
 F PCE=3:1:8 S $P(PAT,U,PCE)=$P(IDS,U,PCE+5)   ; patient sec ID/qual
 ; SUB and PAT are 8-piece strings with pieces 1 and 2 being nil
 S SUB1=$$SCRUB^IBCEF21(SUB)                   ; scrub 8-piece string
 S PAT1=$$SCRUB^IBCEF21(PAT)                   ; scrub 8-piece string
 I SUB'=SUB1 S $P(^DPT(IBDFN,.312,IBCDFN,5),U,2,7)=$P(SUB1,U,3,8)
 I PAT'=PAT1 S $P(^DPT(IBDFN,.312,IBCDFN,5),U,8,13)=$P(PAT1,U,3,8)
 ;
EDITX ;
 Q
 ;
UPDCLM(IBDFN,IBCDFN) ; Update the Insurance nodes of claims that are still editable
 NEW IBIFN
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"C",IBDFN,IBIFN)) Q:'IBIFN  D UPDCLM^IBCNSP2(IBIFN,IBDFN,IBCDFN)
 ;
UPDCLMX ;
 Q
 ;
PRELCNV(CODE,FLG) ; conversion between X12, NCPDP and VistA pt. relationship codes
 ; CODE - code for pt. relationship to convert
 ; FLG - 0 for X12 -> VistA conversion, 1 for VistA -> X12 conversion, 2 - for VistA -> NCPDP conversion
 ; returns converted code for pt. relationship, or null if no match found
 N I,RES,VSTR,X12STR
 S VSTR="01^02^03^08^11^15^32^33^34^35^36"
 S X12STR="18^01^19^20^39^41^32^33^29^53^G8"
 S RES=""
 I FLG=0 F I=1:1:11 S:$P(X12STR,U,I)=CODE RES=$P(VSTR,U,I) Q:RES'=""
 I FLG=1 F I=1:1:11 S:$P(VSTR,U,I)=CODE RES=$P(X12STR,U,I) Q:RES'=""
 I FLG=2,+CODE>0 S RES=$S(+CODE>3:"04",1:CODE)
 Q RES
