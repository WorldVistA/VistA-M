IBCEMRA ;ALB/TMP - 837 MEDICARE MRA UTILITIES ;30-JUL-98
 ;;2.0;INTEGRATED BILLING;**103,137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CATOK(X) ; Screen executed for data in plan category field in field 355.3
 ;  Required Input:
 ;    X = PLAN CATEGORY CODE ENTERED
 ;   DA = File 355.3 IEN
 ;  Output:
 ; Returns 1 if valid (TYPE OF PLAN'S MAJOR CATEGORY = 5  MEDICARE)
 ;         0 if not valid
 ;         0 if TYPE OF PLAN is blank
 ;
 N PLTYP
 S PLTYP=$P($G(^IBE(355.1,+$P($G(^IBA(355.3,DA,0)),U,9),0)),U,3)
 Q $S(PLTYP="":0,"ABC"[X:PLTYP=5,1:PLTYP'=5)
 ;
MRA(IBEOB) ; Print the MRA for entry # IBEOB in file 361.1
 W @IOF
 Q
 ;
