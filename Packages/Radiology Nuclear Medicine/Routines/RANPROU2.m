RANPROU2 ;MANTECH/CLT - LOINC FOR THE HL7 UTILITY ; 28 Oct 2016  10:36 AM
 ;;5.0;Radiology/Nuclear Medicine;**127**;Mar 16, 1998;Build 119
EN ;MAIN ENTRY POINT
 S RAMATCH=$P($G(^RAMIS(71,+$P(RACN0,"^",2),"NTRT")),U,1)
 I $G(RAMATCH)'="" S RALOINC=$P($G(^RAMRPF(71.99,RAMATCH,0)),U,4)
 Q
MTCH ;ALREADY MATCHED NOTIFICATION
 S RAPLUSY=^XTMP("RAMAIN4",$J,Y)
MTCH1 ;ALTERNATE ENTRY POINT
 S RAIEN="",RAIEN=$O(^RAMIS(71,"MRPF",RAPLUSY,RAIEN))
 S RAMATCH=$S($G(RAIEN)'="":"QUIT",1:"GO")
 I $G(RAMATCH)="GO" S RAMV=1 Q
 W !!?3,$C(7),"The MRPF procedure "_$P(^RAMRPF(71.99,RAPROIEN,0),U,1)_" is already mapped to your procedure ",$P(^RAMIS(71,RAIEN,0),U,1)_"."
 I RAMTCH=1 W !,"  Use the already created procedure.",!
 ;I RAMTCH=2 W !?3,"Either change "_$P(^RAMIS(71,RAIEN,0),U,1)_" or choose another MRPF.",!
 ;I RAMTCH=2 W !,?3," Choose another MRPF.",!
 I $G(RANEW)=1 W !!,"This new procedure will be removed." H 1 D
 . ;S DIK="^RAMRPF(71.11,",DA=1 D ^DIK K ^RAMRPF(71.11,"CREAT",DT,DA)
 . I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 . I RA7111DA>0 D
 . . S DIK="^RAMRPF(71.11,",DA=RA7111DA D ^DIK K ^RAMRPF(71.11,"CREAT",DT,DA)
 . . K ^TMP("RA7111DA",$J)
 . S ^XTMP("RAMAIN4",$J,"RAEND")=1,RANQUIT=1 K RAMTCHS S RAMV=0
 . Q
 Q
SEED ;HAS FILE 71.99 BEEN SEEDED
 W !!?3,"The populating of the MASTER RADIOLOGY PROCEDURE file is called seeding.",!
 S DIE="^RAMRPF(71.98,",DA=1,DR="9//NO" D ^DIE
 Q
ONE ;EDIT MAPPING ON A SINGLE PROCEDURE
 G ONE^RAUTL23
 S DIC="^RAMIS(71,",DIC(0)="AEQM",DIC("A")="ENTER THE PROCEDURE TO BE EDITED:"
 D ^DIC Q:Y'>0
 S DIE=DIC,DA=+Y,DR="900" D ^DIE
 S RAPLUSY=$P($G(^RAMIS(71,DA,"NTRT")),U,1) Q:RAPLUSY=""
 S RAIEN="",RAIEN=$O(^RAMIS(71,"MRPF",RAPLUSY,RAIEN))
 I $G(RAIEN)'="",$G(RAIEN)'=DA S RAMTCH=2 D  G ONE
 . S RAMATCH=$P(^RAMRPF(71.99,RAPLUSY,0),U,1) D MTCH1
 . S DR="900///@" D ^DIE
 . Q
 W !! G ONE
 Q
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
