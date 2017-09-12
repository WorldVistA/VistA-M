IB20P481 ;ALB/RDK - IB*2.0*481; UNSUPPORTED GLOBAL READS ; 4/2/13 8:55am
 ;;2.0;INTEGRATED BILLING;**481**;21-MAR-94;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
EN ;
 N DIK,DA,N,X,Y,DMAX,IBIEN,I
 D START,NULL64,DELDD,RECOMP,FINISH
 Q
 ;
 ;ICR 5907 - Delete Field #64 from file #399.
NULL64 ;NULL OUT VALUES FOR FIELD #64 IN FILE #399
 W !!,">>> Setting all values of field (#64) in file (#399) to null. <<<",!,">>> This may take a while, depending on how many bills are in <<<"
 W !,">>> the Bill/Claims file.  Please be patient.                 <<<"
 S IBIEN="" F I=1:1 S IBIEN=$O(^DGCR(399,IBIEN)) Q:IBIEN'?1N.N  I $D(^DGCR(399,IBIEN,"C")),$P(^DGCR(399,IBIEN,"C"),U,14)'="" S $P(^DGCR(399,IBIEN,"C"),U,14)=""
 W !!,">>> All values for field (#64) have been set to null. <<<"
 Q
DELDD ;DELETE FIELD #64 FROM FILE #399 IN DATA DICTIONARY
 W !!,">>> Deleting field (#64) from file (#399) in Data Dictionary. <<<"
 S DIK="^DD(399,",DA=64,DA(1)=399
 D ^DIK
 W !!,">>> Deletion from Data Dictionary complete. <<<"
 Q
RECOMP ;RECOMPILE CROSS REFERENCE ROUTINES
 W !!,">>> Recompiling cross reference routines for BILL/CLAIMS file. <<<"
 S (N,Y)=399 W ! I $D(^DD(N,0,"DIK"))#2 S X=^DD(N,0,"DIK"),DMAX=^DD("ROU") W !,"** File "_N_" **",! D EN^DIKZ
 W !!,">>> Recompile complete. <<<"
 Q
START ;PROCEDURE START MESSAGE
 W !!,"*** Procedure initiating. ***"
 Q
FINISH ;PROCEDURE COMPLETE MESSAGE
 W !!,"*** Procedure complete. ***"
 Q
