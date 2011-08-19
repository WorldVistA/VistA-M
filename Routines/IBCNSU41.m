IBCNSU41 ;ALB/CPM - SPONSOR UTILITIES (CON'T) ; 5/9/03 1:25pm
 ;;2.0;INTEGRATED BILLING;**52,211,240**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SPON(DFN) ; Add/edit sponsor/sponsor relationships for a patient.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;
 I '$G(DFN) G SPONQ
 N IBQ S IBQ=0
 F  D LSP Q:IBQ
SPONQ Q
 ;
 ;
 ;
LSP ; Main loop to collect sponsor and relation data.
 S DIR(0)="FAO^3:30",DIR("A")="Select SPONSOR: " D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) K DIRUT,DIROUT,DTOUT,DUOUT S IBQ=1 G LSPQ
 S IBX=X
 ;
 ; - perform lookup to find sponsor or add a patient sponsor
 S DIC(0)="ELMZ",DIC="^IBA(355.8,",DLAYGO=355.8 D ^DIC K DIC,DLAYGO
 I Y>0 S IBSP=+Y,IBSPD=$G(^IBA(355.8,IBSP,0)),IBNAM=Y(0,0) G LSPC
 I IBX'?1.A1","1.ANP W !,"New sponsors must be in the format LAST,FIRST.",! G LSP
 ;
 ; - is this a new sponsor to be added to the system?
 S DIR(0)="Y",DIR("A")="  Are you adding '"_IBX_"' as a new SPONSOR"
 D ^DIR K DIR
 I 'Y!$D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) K DIRUT,DIROUT,DTOUT,DUOUT G LSP
 ;
 ; - add non-patient sponsor to file #355.82 (sponsor person file)
 S (X,IBNAM)=IBX,DIC(0)="L",DIC="^IBA(355.82,",DLAYGO=355.82
 D FILE^DICN S IBSPP=+Y K DLAYGO
 I IBSPP<0 W !,"Unable to add a new sponsor!" G LSPQ
 ;
 ; - now add to file #355.8 (sponsor file)
 S (IBSPD,X)=IBSPP_";IBA(355.82,",DIC(0)="L",DIC="^IBA(355.8,",DLAYGO=355.8
 D FILE^DICN S IBSP=+Y K DLAYGO
 I IBSP<0 W !,"Unable to add a new sponsor!" G LSPQ
 ;
LSPC ; - allow edit of non-patient sponsor name/dob/ssn
 I $P(IBSPD,"^")["IBA" D
 .S DIE="^IBA(355.82,",DA=+IBSPD
 .S DR=".01  NAME;.02  DATE OF BIRTH;.03  SOCIAL SECURITY NUMBER"
 .D ^DIE K DIE,DA,DR
 ;
 ; - edit remaining sponsor attributes
 S DIE="^IBA(355.8,",DA=IBSP
 S DR=".02  MILITARY STATUS;.03  BRANCH;.04  RANK"
 D ^DIE K DA,DR,DIE
 ;
 ; - find patient relation to sponsor, or create one
 S IBSPR=0 F  S IBSPR=$O(^IBA(355.81,"B",DFN,IBSPR)) Q:'IBSPR  I $P($G(^IBA(355.81,IBSPR,0)),"^",2)=IBSP Q
 I 'IBSPR S IBQQ=0 D  G:IBQQ LSPQ
 .W !!,"The person '",IBNAM,"' is not currently the sponsor of this patient."
 .S DIR(0)="Y",DIR("A")="Okay to add this person as the patient's sponsor"
 .S DIR("?")="Please enter 'YES' to add this person as the patient's sponsor, or 'NO' to select a new sponsor."
 .D ^DIR K DIR I 'Y W ! S IBQQ=1 Q
 .;
 .S X=DFN,DIC="^IBA(355.81,",DIC(0)="L",DIC("DR")=".02////"_IBSP,DLAYGO=355.81
 .D FILE^DICN S IBSPR=+Y S:Y<0 IBQQ=1 K DLAYGO
 ;
 ; - edit sponsor relation attributes
 S DIE="^IBA(355.81,",DA=IBSPR,DR=".03:.06" D ^DIE K DA,DIE,DR
 W !
 ;
LSPQ K IBSP,IBSPD,IBSPP,IBSPR,IBQQ,IBNAM,IBX,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 Q
 ;
 ;
 ;
POL(DFN) ; Update TRICARE policies with Sponsor information.
 ;  Input:   DFN  --  Pointer to the patient in file #2
 ;
 I '$G(DFN) G POLQ
 N IBX,IBY,SPON,X,X1,X3,Y,Z
 ;
 S X=0 F  S X=$O(^IBA(355.81,"B",DFN,X)) Q:'X  D  Q:$D(Z)
 .S Y=$G(^IBA(355.81,X,0))
 .;
 .; - relationship must be with a Tricare sponsor
 .Q:$P(Y,"^",4)'="T"
 .;
 .S SPON=$G(^IBA(355.8,+$P(Y,"^",2),0)) Q:SPON=""
 .;
 .; - if sponsor is a patient, get name/dob/SSN from the patient
 .;   file; otherwise, use file #355.82
 .I $P(SPON,"^")["DPT" D
 ..S X1=$G(^DPT(+SPON,0)) Q:X1=""
 ..S Z("NAME")=$P(X1,"^"),Z("DOB")=$P(X1,"^",3),Z("SSN")=$P(X1,"^",9)
 .E  D
 ..S X1=$G(^IBA(355.82,+SPON,0)) Q:X1=""
 ..S Z("NAME")=$P(X1,"^"),Z("DOB")=$P(X1,"^",2),Z("SSN")=$TR($P(X1,"^",3),"-","")
 .;
 .S Z("BRAN")=$P(SPON,"^",3),Z("RANK")=$P(SPON,"^",4)
 ;
 ; - if no Tricare sponsors were found, quit.
 I '$D(Z) G POLQ
 ;
 ; - update any policies with TRICARE plans
 S IBX=0 F  S IBX=$O(^DPT(DFN,.312,IBX)) Q:'IBX  S IBY=$G(^(IBX,0)) D
 .;
 .; - only consider TRICARE plans
 .Q:$P($G(^IBE(355.1,+$P($G(^IBA(355.3,+$P(IBY,"^",18),0)),"^",9),0)),"^",3)'=7
 .;
 .; - the policyholder should not be the veteran (patient)
 .Q:$P(IBY,"^",6)="v"
 .;
 .; - if a sponsor DOB exists, be sure it's the same as the
 .;   sponsor file DOB
 .S X3=$G(^DPT(DFN,.312,IBX,3))
 .I X3,+X3'=Z("DOB") Q
 .;
 .S DR=""
 .;IB*2*211
 .I $P(IBY,"^",17)="" S DR=DR_"17////"_Z("NAME")_";"
 .I $P(X3,"^")="",Z("DOB") S DR=DR_"3.01////"_Z("DOB")_";"
 .I $P(X3,"^",2)="",Z("BRAN") S DR=DR_"3.02////"_Z("BRAN")_";"
 .I $P(X3,"^",3)="",Z("RANK")]"" S DR=DR_"3.03////"_Z("RANK")_";"
 .I $P(X3,"^",5)="",Z("SSN")]"" S DR=DR_"3.05////"_Z("SSN")_";"
 .;
 .Q:DR=""
 .I $E(DR,$L(DR))=";" S DR=$E(DR,1,$L(DR)-1)
 .;
 .S DIE="^DPT(DFN,.312,",DA(1)=DFN,DA=IBX D ^DIE K DA,DIE,DR
 ;
POLQ Q
