RAUTL23 ;MANTECH/CLT - LOINC FOR THE HL7 UTILITY ; 28 Oct 2016  11:13 AM
 ;;5.0;Radiology/Nuclear Medicine;**127**;Mar 16, 1998;Build 119
EN ;MAIN ENTRY POINT
 S RAMATCH=$P($G(^RAMIS(71,+$P(RACN0,"^",2),"NTRT")),U,1)
 I $G(RAMATCH)'="" S RALOINC=$P($G(^RAMRPF(71.99,RAMATCH,0)),U,4)
 Q
MTCH ;ALREADY MATCHED NOTIFICATION
 S RAPLUSY=^XTMP("RAMAIN4",$J,Y)
MTCH1 ;ALTERNATE ENTRY POINT
 S RAIEN="",RAIEN=$O(^RAMIS(71,"MRPF",RAPLUSY,RAIEN))
 Q:$G(RAMATCH)="GO"
 W !!?3,$C(7),"The MRPF procedure "_RAMATCH_" is already mapped to your procedure ",$P(^RAMIS(71,RAIEN,0),U,1)_"."
 I RAMTCH=1 W !,"  Use the already created procedure.",!
 ;I RAMTCH=2 W !?3,"Either change "_$P(^RAMIS(71,RAIEN,0),U,1)_" or choose another MRPF.",!
 I $G(RANEW)=1 W !!,"This new procedure will be removed." H 1
 S ^XTMP("RAMAIN4",$J,"RAEND")=1 K RAMTCH
 Q
SEED ;HAS FILE 71.99 BEEN SEEDED
 W !!?3,"The populating of the MASTER RADIOLOGY PROCEDURE file is called seeding.",!
 S DIE="^RAMRPF(71.98,",DA=1,DR="9//NO" D ^DIE
 Q
ONE ;EDIT MAPPING ON A SINGLE PROCEDURE
 N A,RACPTMR,RAPRDA,DA,DR,DIR,DIE,DIC,OK,RAPRNM,RAMRPFNM,RAMRPFDA,RAXX
 S (A,RACPTMR)=""
 S DIC="^RAMIS(71,",DIC(0)="AEQM",DIC("A")="ENTER THE PROCEDURE TO BE EDITED:"
 D ^DIC I +Y'>0 G ONEQT
 S DA=+Y,(A,RACPTMR,RAPRDA)="",RAPRDA=DA,RAPRNM=$$GET1^DIQ(71,DA_",",.01)
 ; inactive check
 S A=$$GET1^DIQ(71,DA_",",100,"I") I A'="" W !!,"This procedure is inactive" D ONEQT G ONE
 ; check for CPT code
 S RACPTMR=$$GET1^DIQ(71,DA_",",9,"E") I RACPTMR="" W !!,"This procedure is not associated to a CPT Code." D ONEQT G ONE
 ; check if associated to MRPF
 S A=$$GET1^DIQ(71,DA_",",900,"I") I A'="" S RAXX=$$GET1^DIQ(71.99,A_",",.01) W !!,"This procedure is already mapped to "_RAXX_"." D ONEQT G ONE
 ; CPT code not in MRPF
 S A=$O(^RAMRPF(71.99,"C",RACPTMR,0)) I 'A W !!,"There are not any MRPF entries associated to CPT Code: "_RACPTMR D ONEQT G ONE
 ; check if all affiliated MRPFs are in use
 S A=0,OK=0 F  S A=$O(^RAMRPF(71.99,"C",RACPTMR,A)) Q:'A  D  I OK=1 Q
 . S B=$O(^RAMIS(71,"MRPF",A,""))
 . I B'="" Q
 . S OK=1 Q
 I 'OK W !!,"All MRPF Terms for this CPT Code ("_RACPTMR_") are allocated to other Procedures" D ONEQT G ONE
 ; select MRPF for procedure
 K DIR,DIRUT,DA,Y
 S DIR("S")="I '$$SCREEN^XTID(71.99,"""",(+Y_"",""))&($$ONECHK^RAUTL23(+Y)=1)&($$ONECK2^RAUTL23(+Y)=1)"
 S DIR(0)="PO^71.99:EQZ"
 S DIR("A")="Enter the MRPF to Associate with the Selected Procedure"
 S DIR("?")="Enter the MRPF that you want to associate to the Procedure. Or, enter a '?' to view available choices for the Procedures CPT"
 D ^DIR ; I $D(DIRUT) G ONEQT
 I Y="^"!(X="^") G ONEQT
 I +Y'>0 W !,"Nothing Selected" D ONEQT G ONE
 N DA,DIE,DR
 S A=$G(^RAMRPF(71.99,+Y,0)),A=$P(A,"^",4),RAMRPFDA=+Y
 S DA=RAPRDA,DIE="^RAMIS(71,",DR="900///"_RAMRPFDA_";903///"_A D ^DIE
 S RAMRPFNM=$$GET1^DIQ(71.99,RAMRPFDA_",",.01)
 K DA,DIE,DR
 W !!,"Procedure "_RAPRNM_" is now associated to MRPF "_RAMRPFNM
 W !! D ONEQT G ONE
 Q
 ;
ONEQT ; quit from one
 K A,RACPTMR,RAPRDA,DA,DR,DIR,DIE,DIC,OK,RAPRNM,RAMRPFNM,RAMRPFDA,RAXX
 Q
 ;
ONECHK(A) ; check if MRPF has same CPT code
 I 'A Q 0
 N B S B=$G(^RAMRPF(71.99,A,0)),B=$P(B,"^",3)
 I B'=RACPTMR K B Q 0
 K B Q 1
 ;
ONECK2(A) ; check if other 71 procedure is using MRPF item
 I 'A Q 0
 N B S B=""
 S B=$O(^RAMIS(71,"MRPF",A,B))
 I B K B Q 0
 K B Q 1
 ;
LOINC ;ENTER/EDIT LOINC FOR ONE ENTRY IN FILE 71
 N DIC,DIE,X,Y
 S DIC="^RAMIS(71,",DIC(0)="AEQM" D ^DIC Q:Y'>0  S DA=+Y
 S DIE=DIC,DR=903 D ^DIE
 Q
ACTIVE ;IS THE MRPF ENTRY ACTIVE
 N RA99,I99,I999 S I99=0 F  S I99=$O(^RAMRPF(71.99,RAPROIEN,"TERMSTATUS","B",I99)) Q:I99=""  D
 . S I999="",I999=$O(^RAMRPF(71.99,RAPROIEN,"TERMSTATUS","B",I99,I999))
 . I $P(^RAMRPF(71.99,RAPROIEN,"TERMSTATUS",I999,0),U,1)<DT S RA99=$S($P(^(0),U,2)=1:"ACTIVE",1:"INACTIVE")
 . Q
 Q $G(RA99)
CPT(DA,RAX) ;Ask for CPT Code when the 'Procedure Enter/Edit' option
 ;is exercised. Called from input template: RA PROCEDURE EDIT
 ;Input: DA=ien of new record being edited & RAX=procedure name
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RAFDA,RAYN,X,Y S RAYN=0
 F  D  Q:+RAYN!($D(DIRUT)#2)
 .K X,Y S DIR(0)="71,9" D ^DIR Q:$D(DIRUT)#2
 .;Y=N^S where N=record ien & S=.01 value of the record
 .W !!,"Note: If an erroneous CPT Code is accepted it cannot be changed; the",!,"procedure must be inactivated."
 .W !!,"Are you adding '"_$P(Y,U,2)_"' as the CPT Code for the new Rad/Nuc Med Procedure",!,"'"_RAX_"'? NO// "
 . S DIR(0)="Y",DIR("B")="NO",DIR("A",1)="Are you adding '"_+Y_"' as the CPT Code for the new RAD/NUC MED PROCEDURE",DIR("A")=RAX D ^DIR
 . D ^DIR
 .;R RAYN:DTIME
 .;I '$T!(RAYN["^") S RAYN=-1 Q
 .;S RAYN=$E(RAYN) S:RAYN="" RAYN="N"
 .I "YyNn"'[X W !?3,"Enter 'Y' to accept the CPT Code, or 'N' to reject the CPT Code or '^' to",!?3,"exit without selecting a CPT Code."
 .I  W !?5,"Note: If an erroneous CPT Code is accepted it cannot be changed; the",!?5,"procedure must be inactivated."
 .S:"Yy"[X RAYN="1^Y"
 .S:"Nn"[X RAYN=0
 .Q
 I $P(RAYN,U,2)="Y" S RAFDA(71,DA_",",9)=$P(Y,U) D FILE^DIE("","RAFDA")
 Q
