IBY432PO ;ALB/GEF - Post-Installation for IB patch 432 ;3-Oct-2010
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;
 ; check the names in file 355.1 to get ready for IB*2.0*447
 D NMCK
 ; do post-init from Patch 418 which was merged into our patch
 D PO418
 D RIT
 D ADDUSR
 D VC
 D TURNITON
 D INSFLAG
 D KILLPEB
 Q
 ;
RIT ; recompile billing screen templates
 N X,Y,DMAX,IBN
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:5,"10","102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN)
 .S Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B")
 .S DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL(" Done.")
 Q
 ;
ADDUSR ;IA#4677;This will add user if it's not there
 N IEN200
 S IEN200=$$CREATE^XUSAP("AUTHORIZER,IB REG","")
 Q:+IEN200=0  ; already exists
 Q:+IEN200>0   ; added the user successfully
 I IEN200<0 Q  ; problem adding the new user.  May want to let someone know.
 Q
 ;
PO418 ; post-init for Patch 418
 Q:$$INSTALDT^XPDUTL("IB*2.0*432")>1   ;DBIA#10141
 N U S U="^"
 D TAXADD
 Q
 ;
TAXADD ;Taxonomy code IEN in subfile 399.0222 (field .15/piece 15) if no exist
 ;IBSTUS - the bill status=1 (entered/not reviewed)
 ;IBEVDT - the outpatient event date or (inpatient admission date)
 ;IBPRV - IEN in new person file 200
 ;
 N DA,DA2,NUM,REC,REC2,IBSTUS,IBILL,IBTAX,IBEVDT,IBPRV
 S DA=0,NUM=0
 D MES^XPDUTL("Adding Taxonomy code IEN to file (#399)....")
 F  S DA=$O(^DGCR(399,DA)) Q:'DA  D
 . S REC=$G(^DGCR(399,DA,0)),IBSTUS=$P(REC,U,13)
 . Q:IBSTUS'=1
 . S DA2=0,IBILL=$P(REC,U),IBEVDT=$P(REC,U,3)
 . F  S DA2=$O(^DGCR(399,DA,"PRV",DA2)) Q:'DA2  D
 .. S REC2=$G(^DGCR(399,DA,"PRV",DA2,0))
 .. S IBPRV=$P(REC2,U,2),IBTAX=$P(REC2,U,15)
 .. Q:IBTAX'=""!($P(IBPRV,";",2)'="VA(200,")
 .. S IBTAX=$P($$GET^XUA4A72(+IBPRV,IBEVDT),U,1)
 .. Q:IBTAX'>0
 .. S $P(^DGCR(399,DA,"PRV",DA2,0),U,15)=IBTAX
 .. S IBPRV=$P($G(^VA(200,+IBPRV,0)),U)
 .. D MES^XPDUTL(" Taxonomy code IEN "_IBTAX_" for provider "_IBPRV_" added to bill# "_IBILL)
 .. S NUM=NUM+1
 D MES^XPDUTL("Total "_NUM_$S(NUM=1:" bill has",1:" bills have")_" been updated")
 D MES^XPDUTL("")
 Q
 ;
VC ;Mark Value Codes A3, B3, and C3 obsolete so that the user will not be able to enter them on the billing screens
 D BMES^XPDUTL("Marking Value Codes A3, B3, and C3 obsolete... ")
 N DA,DIE,DR,TODAY,X,Y,VC
 S TODAY=$G(DT) I TODAY="" D NOW^%DTC S TODAY=X
 S DR=".26////"_TODAY
 S DIE=399.1
 F VC="A3","B3","C3" D
 . S DA=""
 . F  S DA=$O(^DGCR(399.1,"C",VC,DA)) Q:'DA  D
 .. I '$$GET1^DIQ(399.1,DA,.18,"I") Q  ;Not a value code
 .. I $$GET1^DIQ(399.1,DA,.26,"I") Q   ;Already marked Obsolete
 .. D MES^XPDUTL(" IEN - "_DA)
 .. D ^DIE
 D MES^XPDUTL(" Done.")
 D MES^XPDUTL("")
 Q
 ;
TURNITON ;
 N DIE,DA,DR,DIC,D0
 S DIE=350.9,DA=1,DR="8.17///YES" D ^DIE
 Q
 ;
INSFLAG ; Set new field to YES
 N INSCO
 S INSCO=0 F  S INSCO=$O(^DIC(36,INSCO)) Q:'+INSCO  D
 . Q:($$GET1^DIQ(36,INSCO,6.1))]""    ; don't set if a value is already there
 . N X,Y,DA,DIE,DR
 . S DA=INSCO
 . S DIE=36
 . S DR="6.1///YES"
 . D ^DIE
 Q 
 ;
NMCK ; Check to make sure that names in file 355.1 have not been edited at site.
 ; this is in preparation for IB*2.0*447 (TCR15) which will be updating some entries in that file.
 Q:$$INSTALDT^XPDUTL("IB*2.0*432")>1   ;DBIA#10141
 N DATA,IEN,ERR,LN
 F LN=2:1:12 D
 .S DATA=$P($T(NM3551+LN),";;",2) Q:DATA=""
 .S IEN=$O(^IBE(355.1,"B",$P(DATA,U,2),""))
 .S:IEN="" ERR(LN)="     "_$P(DATA,U,2)
 D:$D(ERR) BULL(.ERR)
 Q
 ;
BULL(ERR) ; send mail bulletin if there was a problem with file 355.1
 ;
 N DIFROM,XMDUZ,XMTEXT,XMY,XMSUB,L,SITE,IBTXT,I
 S SITE=$P($$SITE^VASITE,U,2)
 S XMSUB="Problem w/ TYPE OF PLAN (file #355.1) at "_SITE
 S XMDUZ=.5,XMTEXT="IBTXT("
 K XMY S XMY("GRACE.FIAMENGO@DOMAIN.EXT")=""
 S IBTXT(1)="During the pre-install check for IB*2.0*447 there was a problem with one or"
 S IBTXT(2)="more names in the TYPE OF PLAN file (#355.1) at:  "_SITE
 S IBTXT(3)=""
 S IBTXT(4)="The Name Check in IBY432PO did not find an exact match for the following:  "
 S L=5 F I=2:1:12 I $D(ERR(I)) S L=L+1,IBTXT(L)=ERR(I)
 D ^XMD
 Q
 ;
NM3551   ; entries in file 355.1 to be checked
 ;
 ;;^CARVE-OUT^
 ;;^COMPREHENSIVE MAJOR MEDICAL^
 ;;^MEDICAL EXPENSE (OPT/PROF)^
 ;;^MEDICARE SECONDARY^
 ;;^MEDIGAP (SUPPLEMENTAL)^
 ;;^MEDIGAP (SUPPL - COINS, DED, PART B EXC)^
 ;;^MENTAL HEALTH^
 ;;^POINT OF SERVICE^
 ;;^PREFERRED PROVIDER ORGANIZATION (PPO)^
 ;;^RETIREE^
 ;;^SURGICAL EXPENSE INSURANCE^
 ;
 Q
 ;
KILLPEB ; Designed to remove the "Print EOB" option from the "IBCE 837 EDI REPORTS" menu.
 N MENUIEN,ITEMIEN,DIK,DA
 S MENUIEN=$O(^DIC(19,"B","IBCE 837 EDI REPORTS",0)) Q:MENUIEN=""
 S ITEMIEN=$O(^DIC(19,MENUIEN,10,"C","PEB",0)) Q:ITEMIEN=""
 S DIK="^DIC(19,"_MENUIEN_",10,"
 S DA=ITEMIEN,DA(1)=MENUIEN
 D ^DIK
 Q
