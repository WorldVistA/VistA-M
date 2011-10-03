DGPTAPP1 ;MTC/ALB - PTF Purge/Archive - Purge Continued ; 21 DEC 1992
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;
PURGE(TMP) ;-- Purge entry point. This function will loop thru the
 ; PTF records found in the A/P template pointed to by TMP.
 ; Starting with the PTF Release file, PTF Close Out file, Census
 ; Work file and finally the PTF record in file #45.
 ;
 ; INPUT :  TMP - Entry in PTF A/P History File (Sort Template Pointer)
 ;
 N PTF,REC
 S REC=$P($G(^DGP(45.62,+TMP,0)),U,8) Q:'REC
 S PTF=0 F  S PTF=$O(^DIBT(REC,1,PTF)) Q:'PTF  D
 . D REL(PTF),CLOSE(PTF),CENSUS(PTF),DELPTF(PTF),UPDATE(PTF)
 Q
 ;
REL(PTF) ;-- This function will delete the entries in the PTF
 ; Release File (#45.83) Associated with the record PTF.
 ;
 ; INPUT : PTF - PTF record to delete
 ;
 N I
 G:'$D(^DGP(45.83,"C",PTF)) RELQ
 S I=0 F  S I=$O(^DGP(45.83,"C",PTF,I)) Q:'I  D
 . S DA(1)=I,DA=PTF,DIK="^DGP(45.83,"_DA(1)_",""P""," D ^DIK
RELQ K DA,DIK
 Q
 ;
CLOSE(PTF) ;-- This function will delete the entries in the PTF Close
 ; Out file (#45.84), associated with the record PTF.
 ;
 ; INPUT : PTF - PTF record to delete
 ;
 G:'$D(^DGP(45.84,PTF)) CLOSEQ
 S DA=PTF,DIK="^DGP(45.84," D ^DIK
CLOSEQ K DA,DIK
 Q
 ;
CENSUS(PTF) ;-- This function will delete the entries in the PTF Close
 ; Out file (#45.84), associated with the record PTF.
 ;
 ; INPUT : PTF - PTF record to delete
 ;
 G:'$D(^DG(45.85,"PTF",PTF)) CENSUSQ
 S DA=$O(^DG(45.85,"PTF",PTF,0)),DIK="^DG(45.85," D ^DIK
CENSUSQ K DA,DIK
 Q
 ;
DELPTF(PTF) ;-- This function will delete the entries in the PTF 
 ; file (#45), associated with the record PTF.
 ;
 ; INPUT : PTF - PTF record to delete
 ;
 G:'$D(^DGPT(PTF)) DELPTFQ
 S DA=PTF,DIK="^DGPT(" D ^DIK
DELPTFQ K DA,DIK
 Q
 ;
UPDATE(PTF) ; This function will update the entry in the Patient Movement
 ; file (#405) cooresponding to the PTF record. The PTF record entry
 ; in field 16 will be deleted and the PTF PURGED STATUS field 26
 ; will be set to 1. This field will be used to prevent re-creation
 ; of the PTF record from a past admission.
 ;
 S DA=0 F  S DA=$O(^DGPM("APTF",PTF,DA)) Q:'DA  D
 . S DIE="^DGPM(",DR=".16///@;.26////1" D ^DIE
 K DA,DIE,DR
 Q
 ;
WARNING() ; This function will display a warning to the user before the
 ; purge of the data will occur. A '1' will be returned if the purge
 ; should continue.
 ;  OUTPUT : 1 - DO NOT CONTINUE
 ;           0 - OK
 N FLAG
 S FLAG=0
 W !,*7,"This option will permently purge data from the Data Base."
 W !,"Are you sure that you want to continue ?",!
 Q FLAG
 ;
