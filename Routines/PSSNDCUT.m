PSSNDCUT ;BIRM/MFR - NDC Utilities ;10/15/04
 ;;1.0;PHARMACY DATA MANAGEMENT;**90**;9/30/97
 ;
SAVNDC(DRG,SITE,NDC,CMP) ; Saves the NDC in the DRUG file (Format: 5-4-2)
 ; Input: (r) DRG  - Drug IEN (#50)
 ;        (r) SITE - Outpatient Site IEN (#59)
 ;        (r) NDC  - NDC Number
 ;        (o) CMP  - CMOP? (1-YES/0-NO)
 N RFL,DIE,DIC,DA,DR,I,DD,DO,DINUM,X,Y
 ;
 S NDC=$$NDCFMT(NDC) I NDC="" Q
 ;
 ;- Saving the NDC in the DRUG file (#50)
 I '$D(^PSDRUG(DRG,"NDCOP",SITE)) D
 . S DIC="^PSDRUG("_DRG_",""NDCOP"","
 . S (X,DINUM)=SITE,DA(1)=DRG,DIC(0)=""
 . K DD,DO D FILE^DICN K DD,DO,DINUM,Y
 ;
 K DA,DIE,DR S DIE="^PSDRUG("_DRG_",""NDCOP"","
 S DA(1)=DRG,DA=SITE,DR=$S($G(CMP):2,1:1)_"///"_NDC
 D ^DIE
 Q
 ;
GETNDC(DRG,SITE,CMOP) ; Retuns the NDC for a specific Drug/Site/CMOP or NON-CMOP
 N NDC,NDF
 ;
 I '$D(CMOP) S CMOP=$S($D(^PSDRUG("AQ",DRG)):1,1:0)
 ; - LOCAL NDC by DIVISION
 I $G(SITE),'CMOP S NDC=$$NDCFMT($$GET1^DIQ(50.032,SITE_","_DRG,1)) I NDC'="" Q NDC
 ; - CMOP NDC by DIVISION
 I $G(SITE),CMOP S NDC=$$NDCFMT($$GET1^DIQ(50.032,SITE_","_DRG,2)) I NDC'="" Q NDC
 ; - Drug File NDC
 S NDC=$$NDCFMT($$GET1^DIQ(50,DRG,31)) I NDC'="" Q NDC
 ; - National Drug File NDC
 I NDC="" S NDF=+$$GET1^DIQ(50,DRG,22,"I") I NDF'="" S NDC=$$NDCFMT($$GET1^DIQ(50.68,NDF,13)) I NDC'="" Q NDC
 Q NDC
 ;
NDCFMT(NDC) ; Formats NDC codes into 5-4-2
 N S1,S2,S3
 I '$$CHKCH(NDC) Q ""
 I NDC?.N,NDC'?11N Q ""
 I NDC?11N Q ($E(NDC,1,5)_"-"_$E(NDC,6,9)_"-"_$E(NDC,10,11))
 ;
 I $L(NDC,"-")'=3 Q ""
 S S1=$P(NDC,"-"),S2=$P(NDC,"-",2),S3=$P(NDC,"-",3)
 I '$L(S1)!'$L(S2)!'$L(S3) Q ""
 I $L(S1)>6!($L(S2)>4)!($L(S3)>2) Q ""
 ;
 S:$L(S1)>5 S1=$E(S1,$L(S1)-4,$L(S1))
 S:$L(S1)<5 S1=$E(S1+100000,2,6)
 S S2=$E(S2+10000,2,5)
 S S3=$E(S3+100,2,3)
 ;
 Q (S1_"-"_S2_"-"_S3)
 ;
CHKCH(STR)      ; Checks characters different from "-" and numbers
 N CHKCH
 I STR="" Q 0
 S CHKCH=1 F I=1:1:$L(STR) I $E(STR,I)'?1N,$E(STR,I)'?1"-" S CHKCH=0 Q
 Q CHKCH
