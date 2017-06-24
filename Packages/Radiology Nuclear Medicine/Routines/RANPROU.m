RANPROU ;BPFO/CLT - NEW RADIOLOGY PROCEDURES UTILITIES ; 27 Oct 2016  2:43 PM
 ;;5.0;Radiology/Nuclear Medicine;**127**;Mar 16, 1998;Build 119
 ;
CPT(DA,RAX) ;Ask for CPT Code when the 'Procedure Enter/Edit' option
 ;is exercised. Called from input template: W RADIOLOGY PROCEDURE
 ;Input: DA=ien of new record being edited & RAX=procedure name
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RAFDA,RAYN,X,Y S RAYN=0
 F  D  Q:+RAYN!($D(DIRUT)#2)
 .K X,Y S DIR(0)="71.11,9" D ^DIR Q:$D(DIRUT)#2
 .;Y=N^S where N=record ien & S=.01 value of the record
 .W !!,"Note: If an erroneous CPT Code is accepted it cannot be changed; the",!,"procedure must be inactivated."
 . I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 . S RAX=$P($G(^RAMRPF(71.11,RA7111DA,0)),U,1) W !!,"Are you adding '"_$P(Y,U,2)_"' as the CPT Code for the new Rad/Nuc Med Procedure",!,"'"_RAX_"'? NO// "
 .;S RAX=$P($G(^RAMRPF(71.11,1,0)),U,1) W !!,"Are you adding '"_$P(Y,U,2)_"' as the CPT Code for the new Rad/Nuc Med Procedure",!,"'"_RAX_"'? NO// "
 .R RAYN:DTIME
 .I '$T!(RAYN["^") S RAYN=-1 Q
 .S RAYN=$E(RAYN) S:RAYN="" RAYN="N"
 .I "YyNn"'[RAYN W !?3,"Enter 'Y' to accept the CPT Code, or 'N' to reject the CPT Code or '^' to",!?3,"exit without selecting a CPT Code."
 .I  W !?5,"Note: If an erroneous CPT Code is accepted it cannot be changed; the",!?5,"procedure must be inactivated."
 .S:"Yy"[RAYN RAYN="1^Y"
 .S:"Nn"[RAYN RAYN=0
 .Q
 I $P(RAYN,U,2)="Y" S RAFDA(71.11,DA_",",9)=$P(Y,U) D FILE^DIE("","RAFDA")
 Q
 ;
