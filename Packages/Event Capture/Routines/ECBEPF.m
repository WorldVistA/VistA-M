ECBEPF ;BIR/MAM,JPW-Stuff Batch Entry by Procedure (cont'd) ;2 Mar 96
 ;;2.0; EVENT CAPTURE ;**4,5,13,17,18,23,42,54,72,76**;8 May 96;Build 6
CRAM ; entry
 S ECDT=$P(ECA,"^"),ECL=$P(ECA,"^",2),ECS=$P(ECA,"^",3),ECM=$P(ECA,"^",4),ECD=$P(ECA,"^",5)
 S ECPCE=$P(ECA,"^",6)
 S (CNT,CNT1)=0 F  S CNT1=$O(ECPT(CNT1)) Q:'CNT1  D SET F  S CNT=$O(ECEC(CNT)) Q:'CNT  D DIE
END D ^ECKILL K DLAYGO S:$D(ZTQUEUED) ZTREQ="@"
 Q
SET ;
 S ECPS=$P(ECPT(CNT1),"^"),ECO=$P(ECPT(CNT1),"^",3),ECV=+$P(ECPT(CNT1),"^",5)
 S ECDX=$P(ECPT(CNT1),"^",6),ECINP=$P(ECPT(CNT1),"^",7),ECVST=$P(ECPT(CNT1),"^",8),ECSC=$P(ECPT(CNT1),"^",9),ECAO=$P(ECPT(CNT1),"^",10),ECIR=$P(ECPT(CNT1),"^",11)
 S ECZEC=$P(ECPT(CNT1),"^",12),EC4=$P(ECPT(CNT1),"^",13),ECID=$P(ECPT(CNT1),"^",14)
 S ECMST=$P(ECPT(CNT1),"^",15),ECHNC=$P(ECPT(CNT1),"^",16),ECCV=$P(ECPT(CNT1),"^",17),ECSHAD=$P(ECPT(CNT1),"^",18)
 S ECELIG=$G(ECELPT(CNT1))
 Q
DIE ;
 L +^ECH(0):60 S ECRN=$P(^ECH(0),"^",3)+1 I $D(^ECH(ECRN)) S $P(^ECH(0),"^",3)=$P(^ECH(0),"^",3)+1 L -^ECH(0) G DIE
 L -^ECH(0) K DD,DO,DIC S X=ECRN,DIC(0)="L",DLAYGO=721,DIC="^ECH(" D FILE^DICN K DIC S ECFN=+Y
 S ECNODE=ECEC(CNT),ECC=+$P(ECNODE,"^"),ECP=$P(ECNODE,"^",2),ECPRPTR=$P(ECNODE,"^",12)
 S ECCPT=$P(ECNODE,"^",9)
 ; set the zero node
 S ^ECH(ECFN,0)=ECFN_"^"_ECPS_"^"_ECDT_"^"_ECL_"^"_ECS_"^"_ECM_"^"_ECD_"^"_ECC_"^"_ECP_"^"_ECV_"^^"_ECO_"^"_ECDUZ_"^^^^^^"_EC4_"^"_ECID_"^"_ECVST_"^"_ECINP
 ;ALB/JAM file multiple providers (EC*2*72)
 S ECFIL=$$FILPRV^ECPRVMUT(ECFN,.ECPRVARY,.ECOUT) K ECFIL
 ;ALB/ESD - Set procedure reason into zero node
 I +ECPRPTR S $P(^ECH(ECFN,0),"^",23)=+ECPRPTR
 ;set the "P" node
 S ^ECH(ECFN,"P")=ECCPT_"^"_ECDX_"^"_ECAO_"^"_ECIR_"^"_ECZEC_"^"_ECSC
 S $P(^ECH(ECFN,"P"),"^",9,12)=ECMST_"^"_ECHNC_"^"_ECCV_"^"_ECSHAD
 ;add secondary diagnosis codes
 I $O(ECPT(CNT1,"DXS",""))'="" D  K DXSIEN,DXS
 . S DXS="" F  S DXS=$O(ECPT(CNT1,"DXS",DXS)) Q:DXS=""  D
 . . S DXSIEN=$P(ECPT(CNT1,"DXS",DXS),U) I DXSIEN<0 Q
 . . K DIC,DD,DO
 . . S DIC(0)="L",DA(1)=ECFN,DIC="^ECH("_DA(1)_","_"""DX"""_","
 . . S DIC("P")=$P(^DD(721,38,0),U,2),X=DXSIEN
 . . D FILE^DICN
 K ECDXX M ECDXX=ECPT(CNT1,"DXS")
 S PXUPD=$$PXUPD^ECUTL2(ECPS,ECDT,ECL,EC4,ECDX,.ECDXX,ECFN) K PXUPD,ECDXX
 ;add CPT procedure modifiers
 I $O(ECEC(CNT,"MOD",""))'="" D  K MODIEN,MOD
 . S MOD="" F  S MOD=$O(ECEC(CNT,"MOD",MOD)) Q:MOD=""  D
 . . S MODIEN=$P(ECEC(CNT,"MOD",MOD),U,2) I MODIEN<0 Q
 . . K DIC,DD,DO
 . . S DIC(0)="L",DA(1)=ECFN,DIC="^ECH("_DA(1)_","_"""MOD"""_","
 . . S DIC("P")=$P(^DD(721,36,0),U,2),X=MODIEN
 . . D FILE^DICN
XREF ; sets crossreferences
 S DIK="^ECH(",DA=ECFN D IX1^DIK K DA,DIK
PCE ;format data to send PCE
 Q:$P(ECPCE,"~",2)="N"  I $P(ECPCE,"~",2)="O"&(ECINP'="O") Q
 D PCE^ECBEN2U
 Q
