IBCNRE5 ;BHAM ISC/DMK - Edit HIPAA NCPDP ACTIVE FLAG ;09-APR-2004
 ;;2.0;INTEGRATED BILLING;**251,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Edit HIPAA NCPDP ACTIVE FLAG
 ; (master switch to control e-Pharmacy NCPDP transactions)
 ;
 ; 350.9  IB SITE PARAMETERS File
 ;  11.01 HIPAA NCPDP ACTIVE FLAG Field
 ;
1000 ; Control processing
 N LOCK
 D LOCK I 'LOCK Q
 D HEADING
 D EDIT
 D UNLOCK
 Q
 ;
EDIT ; Edit IB SITE PARAMETERS File
 ; 350.9 IB SITE PARAMETERS
 ;
 N DA,DIDEL,DIC,DIE,DLAYGO,DR,DTOUT,X,Y
 N %,D,D0,DDER,DDH,DI,DQ,DZ
 ;
 S DA=1
 S DIE="^IBE(350.9,"
 ;
 ; 11.01 HIPAA NCPDP ACTIVE FLAG
 S DR="11.01"
 ;
 D ^DIE
 Q
 ;
HEADING ; Print heading
 W @IOF
 W "Edit HIPAA NCPDP ACTIVE FLAG",!
 W "(master switch to control e-Pharmacy NCPDP transactions)",!!
 Q
 ;
LOCK ; Lock IB SITE PARAMETERS File
 S LOCK=0
 I '$D(^IBE(350.9,1,0)) W !!,*7,"IB SITE PARAMETERS File undefined.",! Q
 L +^IBE(350.9,1,0):0
 I '$T W !!,*7,"IB SITE PARAMETERS File unavailable.",! Q
 S LOCK=1
 Q
 ;
UNLOCK ; Unlock IB SITE PARAMETERS File
 L -^IBE(350.9,1,0)
 Q
