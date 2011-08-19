PRCUFC0E ;WISC/SJG-OBLIGATION CONVERSION ERROR ROUTINE ;7/22/94  9:35 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(IEN,ERR) ;
 ; IEN = Internal record number from 442
 ; ERR = Error from Obligation conversion routines
 N TAG
 S TRANS=$S($D(PRCFA("CONVG")):"GPF",$D(PRCFA("CONVS")):"SFF")
 S TAG=ERR D @TAG
 Q
ERR1 ;STATION NUMBER NOT FOUND IN 411
 ;N DIC,DIE,DA,DR,FIELD
 ;D NEXT S DR=DR_"6///^S X=1" D ^DIE Q
 Q
ERR2 ;
 ;N DIC,DIE,DA,DR,FIELD
 ;D NEXT S DR=DR_"6///^S X=2" D ^DIE Q
 Q
ERR3 ;
 ;N DIC,DIE,DA,DR,FIELD
 ;D NEXT S DR=DR_"6///^S X=3" D ^DIE Q
 Q
ERR4 ; Purchase Order Receipts and Purchase Status do not match
 N DIC,DIE,DA,DR,FIELD
 D NEXT S DR=DR_"6///^S X=8" D ^DIE Q
 ;
ERR5 ; 'Dummy' GPF Fund Control point is missing
 N DIC,DIE,DA,DR
 D NEXT S DR=DR_"6///^S X=9" D ^DIE Q
 ;
NEXT ;GET THE NEXT FREE ENTRY IN FILE 411.3
 N NEXT,DLAYGO
 S NEXT=$P($G(^PRC(411.3,0)),U,4) F  S NEXT=NEXT+1 Q:$G(^PRC(411.3,NEXT,0))=""
 K DD,DO S DIC="^PRC(411.3,",DIC(0)="L",DLAYGO=411.3,X=NEXT D FILE^DICN Q:+Y'>0  S DA=+Y,DIE=DIC,DR="9///^S X=TRANS;12///^S X=IEN;"
