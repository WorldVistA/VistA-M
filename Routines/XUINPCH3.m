XUINPCH3 ;SFISC/RWF - KERNEL PATCH POST-INIT'S ;10/17/2000  11:46
 ;;8.0;KERNEL;**115,176**;Feb 22, 1999
 W !,"NO ENTRY FROM TOP" Q
 ;
POST115 ;Build new X-ref in file 200.
 N DA,DIK,DIC,DR,DIE
 S DA=1,DIE="^XTV(8989.3,",DR="230///180" D ^DIE
 F DA(1)=0:0 S DA(1)=$O(^VA(200,DA(1))) Q:DA(1)'>0  I $D(^VA(200,DA(1),2)) S DIK="^VA(200,"_DA(1)_",2,",DIK(1)=.01 D ENALL^DIK
 Q
 ;
POST176 ;Rebuild the X-ref of the fields that patch XU*8*176 is fixing.
 N DA,DIK,DIC,DIE,DR
 K ^VA(200,"APS1") ;Delete any old entries
 S DIK="^VA(200,",DIK(1)=53.2 D ENALL^DIK ;Rebuild PS1, DEA#
 K ^VA(200,"APS2") ;Delete any old entries
 S DIK="^VA(200,",DIK(1)=53.3 D ENALL^DIK ;Rebuild PS2, VA#
 ;Remove extra fields sent out.
 ;Remove experamental fields.
 F DA=10.2,10.3,10.4,10.5 S DA(1)=200,DIK="^DD(200," D ^DIK
 ;Remove the OE/RR field removed by OR v3.
 F XDA=11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27 S DA="100."_XDA,DA(1)=200,DIK="^DD(200," D ^DIK
 Q
