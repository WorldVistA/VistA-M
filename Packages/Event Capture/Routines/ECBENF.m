ECBENF ;BIR/MAM,JPW-Stuff New Batched Procedures ;12 Feb 96
 ;;2.0; EVENT CAPTURE ;**4,5,13,17,18,23,42,54,72,76**;8 May 96;Build 6
CRAM ; entry
 S ECDT=$P(ECA,"^"),ECL=$P(ECA,"^",2),ECS=$P(ECA,"^",3),ECM=$P(ECA,"^",4),ECD=$P(ECA,"^",5)
 S ECPCE=$P(ECA,"^",6)
 S (CNT,CNT1)=0
 F  S CNT1=$O(ECPT(CNT1)) Q:'CNT1  D
 .S ECNODE2=$G(ECPT(CNT1))
 .S ECELIG=$G(ECELPT(CNT1))
 .S ECPS=$P(ECNODE2,"^"),ECDX=$P(ECNODE2,"^",3),ECINP=$P(ECNODE2,"^",4),ECVST=$P(ECNODE2,"^",5),ECSC=$P(ECNODE2,"^",6),ECAO=$P(ECNODE2,"^",7),ECIR=$P(ECNODE2,"^",8),ECZEC=$P(ECNODE2,"^",9),ECMST=$P(ECNODE2,"^",12)
 .S ECHNC=$P(ECNODE2,"^",13),ECCV=$P(ECNODE2,"^",14),ECSHAD=$P(ECNODE2,"^",15)
 .F  S CNT=$O(ECEC(CNT)) Q:'CNT  D
 ..S EC4=$P(ECNODE2,"^",10),ECID=$P(ECNODE2,"^",11)
 ..D NODE D DIE
END D ^ECKILL K DLAYGO S:$D(ZTQUEUED) ZTREQ="@"
 Q
NODE ;set patient array data
 S ECNODE=ECEC(CNT)
 S ECC=+$P(ECNODE,"^"),ECP=$P(ECNODE,"^",2),ECO=$P(ECNODE,"^",4),ECV=$P(ECNODE,"^",5)
 S ECCPT=$P(ECNODE,"^",11),ECPRPTR=$P(ECNODE,"^",12)
 ;
 ;- Get associated clinic from event code screen if null
 S:$G(EC4)="" EC4=$P($G(^ECJ(+$O(^ECJ("AP",+ECL,+ECD,+ECC,$G(ECP),0)),"PRO")),"^",4)
 S:$G(ECID)="" ECID=$P($G(^SC(+EC4,0)),"^",7)
 Q
DIE ;
 L +^ECH(0):60 S ECRN=$P(^ECH(0),"^",3)+1 I $D(^ECH(ECRN)) S $P(^ECH(0),"^",3)=$P(^ECH(0),"^",3)+1 L -^ECH(0) G DIE
 L -^ECH(0) K DD,DO,DIC S X=ECRN,DIC(0)="L",DLAYGO=721,DIC="^ECH(" D FILE^DICN K DIC S ECFN=+Y
 ; set the zero node
 S ^ECH(ECFN,0)=ECFN_"^"_ECPS_"^"_ECDT_"^"_ECL_"^"_ECS_"^"_ECM_"^"_ECD_"^"_ECC_"^"_ECP_"^"_ECV_"^^"_ECO_"^"_ECDUZ_"^^^^^^"_EC4_"^"_ECID_"^"_ECVST_"^"_ECINP
 ;ALB/JAM file multiple providers (EC*2*72)
 S ECFIL=$$FILPRV^ECPRVMUT(ECFN,.ECPRVARY,.ECOUT) K ECFIL
 ;
 ; ALB/JAM add CPT procedure modifiers
 I $O(ECEC(CNT,"MOD",""))'="" D  K MODIEN,MOD
 . S MOD="" F  S MOD=$O(ECEC(CNT,"MOD",MOD)) Q:MOD=""  D
 . . S MODIEN=$P(ECEC(CNT,"MOD",MOD),U,2) I MODIEN<0 Q
 . . K DIC,DD,DO
 . . S DIC(0)="L",DA(1)=ECFN,DIC="^ECH("_DA(1)_","_"""MOD"""_","
 . . S DIC("P")=$P(^DD(721,36,0),U,2),X=MODIEN
 . . D FILE^DICN
 ; ALB/ESD - Set procedure reason into zero node
 I +ECPRPTR S $P(^ECH(ECFN,0),"^",23)=+ECPRPTR
 ;set the "P" node
 S ^ECH(ECFN,"P")=ECCPT_"^"_ECDX_"^"_ECAO_"^"_ECIR_"^"_ECZEC_"^"_ECSC
 S $P(^ECH(ECFN,"P"),"^",9,12)=ECMST_"^"_ECHNC_"^"_ECCV_"^"_ECSHAD
 ; ALB/JAM - add secondary diagnosis codes
 I $O(ECPT(CNT1,"DXS",""))'="" D  K DXSIEN,DXS
 . S DXS="" F  S DXS=$O(ECPT(CNT1,"DXS",DXS)) Q:DXS=""  D
 . . S DXSIEN=$P(ECPT(CNT1,"DXS",DXS),U) I DXSIEN<0 Q
 . . K DIC,DD,DO
 . . S DIC(0)="L",DA(1)=ECFN,DIC="^ECH("_DA(1)_","_"""DX"""_","
 . . S DIC("P")=$P(^DD(721,38,0),U,2),X=DXSIEN
 . . D FILE^DICN
 K ECDXX M ECDXX=ECPT(CNT1,"DXS")
 S PXUPD=$$PXUPD^ECUTL2(ECPS,ECDT,ECL,EC4,ECDX,.ECDXX,ECFN) K PXUPD,ECDXX
XREF ; sets crossreferences
 S DIK="^ECH(",DA=ECFN D IX1^DIK K DA,DIK
 ;
PCE ;format PCE data to send
 Q:$P(ECPCE,"~",2)="N"  I $P(ECPCE,"~",2)="O"&(ECINP'="O") Q
 D PCE^ECBEN2U
 Q
