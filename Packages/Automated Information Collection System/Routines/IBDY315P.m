IBDY315P ;ALB/AAS - Post Install routine for ibd*3*15  - 11-Oct-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15**;APR 24, 1997
 ;
 D CLEANUP,AUTOINS,DEL,TRANS
 Q
 ;
AUTOINS ; -- auto install tool kit blocks into production
 N FORM,NEWFORM,FORMNM,CNT,CNT1,ARY,NAME,X,Y,NEWBLOCK,A,EXCLUDE,BLK,CNTF,CNTB
 D MES^XPDUTL(">>> Now Attempting to automatically add Clinical Reminders Tool Kit Blocks.")
 S (CNTB,CNTF)=0
 ;
 ; -- add all tool kit blocks
 S FORMNM="TOOL KIT"
 I '$O(^IBE(357,"B",FORMNM,0)) Q
 S ORD="" F  S ORD=$O(^IBE(358.1,"D",ORD)) Q:ORD=""  S BLK=0 F  S BLK=$O(^IBE(358.1,"D",ORD,BLK)) Q:'BLK  D
 .S NAME=$P($G(^IBE(358.1,+BLK,0)),"^")
 .Q:$P($G(^IBE(358.1,BLK,0)),"^",14)'=1  ;not toolkit
 .I $O(^IBE(357.1,"B",NAME,0)) D MES^XPDUTL("     Block "_NAME_" already exists") Q
 .D MES^XPDUTL("    Moving Block '"_$P($G(^IBE(358.1,+BLK,0)),"^")_"' from import/export to Tool Kit")
 .N IBTKBLK S IBTKBLK=1
 .S NEWBLOCK=$$COPYBLK^IBDFU2(BLK,$$TKFORM^IBDFU2C,358.1,357.1,"","",$$TKORDER^IBDF13),CNTB=CNTB+1
 .D:$G(NEWBLOCK) DLTBLK^IBDFU3(BLK,"",358.1)
 ;
 ; -- clear workspace
 D DLTALL^IBDE2
 Q
 ;
DEL ; -- delete unused field in 357.6
 S DIK="^DD(357.613,",DA=1,DA(1)=357.613
 D ^DIK
 K DIK,DA
 Q
 ;
CLEANUP ; -- Clean up initial reminder blocks
 N IBDI,IBDJ
 S IBDI=0
 F  S IBDI=$O(^IBE(357.2,"B","CLINICAL REMINDERS",IBDI)) Q:'IBDI  D
 .S IBDJ=0
 .F  S IBDJ=$O(^IBE(357.2,IBDI,2,IBDJ)) Q:'IBDJ  D
 ..I $P($G(^IBE(357.2,IBDI,2,IBDJ,0)),"^",3)=13 S $P(^IBE(357.2,IBDI,2,IBDJ,0),"^",3)=12
 ..I $P($G(^IBE(357.2,IBDI,2,IBDJ,0)),"^",3)=17 S $P(^IBE(357.2,IBDI,2,IBDJ,0),"^",3)=18
 ;
 S IBDI=0
 F  S IBDI=$O(^IBE(357.2,"B","FULL CLINICAL REMINDER",IBDI)) Q:'IBDI  D
 .S IBDJ=0
 .F  S IBDJ=$O(^IBE(357.2,IBDI,2,IBDJ)) Q:'IBDJ  D
 ..I $P($G(^IBE(357.2,IBDI,2,IBDJ,0)),"^",3)=13 S $P(^IBE(357.2,IBDI,2,IBDJ,0),"^",3)=12
 ..I $P($G(^IBE(357.2,IBDI,2,IBDJ,0)),"^",3)=17 S $P(^IBE(357.2,IBDI,2,IBDJ,0),"^",3)=18
 Q
BLOCKS ;;
 ;;TOOL KIT
 ;;
 Q
TRANS D MES^XPDUTL(">>> Translating letters O and l to numbers 0 and 1 in Time Queued field of file 357.09.")
 N IBX,IBX1,IBY1,IBNODE
 S IBX1=0
 F  S IBX1=$O(^IBD(357.09,IBX1)) Q:'IBX1  D
 .S IBY1=0 F  S IBY1=$O(^IBD(357.09,IBX1,"Q",IBY1)) Q:'IBY1  D
 ..S IBNODE=$G(^IBD(357.09,IBX1,"Q",IBY1,0))
 ..S IBX=$P(IBNODE,"^",13)
 ..I IBX]"" S IBX=$TR(IBX,"OoLl","0011"),$P(^IBD(357.09,IBX1,"Q",IBY1,0),"^",13)=IBX
 Q
