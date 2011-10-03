IBECPTT ;ALB/ARH - TRANSFERS CPT RATE UPDATES TO 350.4 ; 10/22/91
 ;;2.0;INTEGRATED BILLING;**133**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; THIS FUNCTION IS OBSOLETE AND THE ROUTINE SHOULD BE DELETED WHEN 350.4 AND 350.5 ARE DELETED (133)
 Q
 ;
 ;transfer all entrys in 350.41 to 350.4 that are valid
 W !!!,?18,"Transfer HCFA updates to the Permanent BASC File",!!!
 W !!,"This option transfers the HCFA updates from the temporary BASC file to the"
 W !,"permanent BASC file."
 S DIR(0)="Y",DIR("A")="Proceed with transfer" D ^DIR K DIR G:$D(DIRUT)!('Y) END
 W !!,"Beginning transfer, this could take some time.   Please wait...",!
START W !,"Transferring HCFA updates to permanent BASC file."
 S IBX=0,(IBSD,IBNT,IBE,IBES,IBERR,IBCNT)=0
 F IBI=1:1 S IBX=$O(^IBE(350.41,IBX)) Q:IBX?1A.A  I '$P($G(^IBE(350.41,IBX,0)),"^",7) D SEARCH S IBCNT=IBCNT+1 I '(IBCNT#25) W "."
 W !!,"Transfer complete: ",IBSD," Entries created in 409.71"
 W !,?19,IBE," Entries created in 350.4",!,?19,IBES," Entries in 350.4 ""stuffed"""
 W !!,?19,IBNT," Codes already have entries for given effective date"
 W !,?19,IBERR," Codes unable to transfer"
END ;
 K IBX,IBSD,IBNT,IBE,IBES,IBCNT,IBERR,IBI,IBLN,IBLN1,IBUA,IBEDT,IBOLD,IBNEW,IBERRF,IBCD,DA,DR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 Q
 ;
SEARCH ;update/create new billing code entries if conditions meet
 ;  does not transfer to 350.4 if: - code inactive (in 81)
 ;                                 - date effective already defined for code
 ;                                 - deactivating a code not in billing
 ;                                 - deactivating a code already inactive
 ;                                 - stated old group not match current group
 ;                                 - entry does not cause changes in rate or status
 S IBLN=^IBE(350.41,IBX,0),IBEDT=$E($P(IBLN,"^",2),1,7),IBNEW=$P(IBLN,"^",4)
 S IBOLD=$P(IBLN,"^",3),IBCD=+IBLN,IBUA="@"
 I '$P($$CPT^ICPTCOD(+IBCD),U,7) S IBERRF="CODE NOT ACTIVE IN CPT FILE (81)" G ERROR
 I $D(^IBE(350.4,"AIVDT",IBCD,-IBEDT)) S IBNT=IBNT+1,IBERRF="DATE EFFECTIVE ALREADY DEFINED FOR CODE" G ERROR
 S IBLN1=$G(^IBE(350.4,+$O(^(+$O(^IBE(350.4,"AIVDT",IBCD,-(IBEDT+1))),0)),0))
 S IBUA=$S('IBLN1:1,'$P(IBLN1,"^",4):2,'IBNEW:4,IBNEW'=IBOLD&(IBNEW'=$P(IBLN1,"^",3)):3,1:"@")
 I IBOLD,$P(IBLN1,"^",3),IBOLD'=$P(IBLN1,"^",3) S IBERRF="STATED OLD GROUP DOES NOT MATCH CURRENT GROUP" G ERROR
 I 'IBNEW,'IBLN1 S IBERRF="DEACTIVATING A CODE NOT IN BILLING" G ERROR
 I 'IBNEW,'$P(IBLN1,"^",4) S IBERRF="DEACTIVATING A CODE ALREADY INACTIVE" G ERROR
 I IBUA="@" S IBERRF="NO VALID UPDATE ACTION FOUND, NO CHANGE IN RATE/STATUS" G ERROR
 S IBERRF="ERROR WHILE TRYING TO STORE THE DATA"
CREATE ;create entries in 350.4 and 409.71
 S DLAYGO=409.71,X="`"_IBCD,DIC="^SD(409.71,",DIC(0)="XL" D ^DIC K DIC G:Y<0 ERROR I $P(Y,"^",3) S IBSD=IBSD+1
 K DD,DO S DLAYGO=350.4,X=IBEDT,DIC="^IBE(350.4,",DIC(0)="L" D FILE^DICN K DIC,DLAYGO G:Y<0 ERROR S IBE=IBE+1
STUFF ;stuff data into newly created entry in 350.4
 S DR=".02////"_IBCD_";.03////"_IBNEW_";.04////"_$S(IBNEW:1,1:0)
 S DIE="^IBE(350.4,",DA=+Y D ^DIE K DIE,DIC,DR,DA,Y S IBES=IBES+1
 S DR=".06///"_IBUA_";.07////1;.08///@",DIE="^IBE(350.41,",DA=IBX D ^DIE K DIE,DIC,DR,DA,Y,X
 Q
 ;
ERROR ;entry can not be transfered for some reason, flag piece 7 in 350.41
 S IBERR=IBERR+1
 S DR=".06///"_IBUA_";.07////0;.08////"_IBERRF,DIE="^IBE(350.41,",DA=IBX D ^DIE K DIE,DIC,DR,DA,Y,X
 Q
