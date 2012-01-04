IBCU7B ;ALB/DEM - LINE LEVEL PROVIDER USER INPUT ;27-SEP-2010
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
EN ;
 ;
 N X,DIC,DIE,DR,DA,DLAYGO,PRVFUN,DIPA,Y,DO,DD,I,IBPOPOUT
 I '$D(IBLNPRV("IBCCPT")) N IBLNPRV  ; DEM;432 - Coming from routine IBCCPT.
 S:'$G(IBFT) IBFT=$$FT^IBCEF(IBIFN)  ;DEM;432 - Form Type for claim.
 I IBFT=3,$$INPAT^IBCEF(IBIFN) Q   ;WCJ*2.0*432 Don't ask line level providers if INPAT UB
 Q:(IBFT'=2)&(IBFT'=3)  ;DEM;432 - Must be CMS-1500 (2) or UB-04 (3) Form Type.
 S:IBFT=2 PRVFUN(2)="Rendering,Referring,Supervising"  ;DEM;432 - Allowable provider functions for CMS-1500.
 S:IBFT=3 PRVFUN(3)="Rendering,Referring,Operating,Other Operating"  ;DEM;432 - Allowable provider functions for UB-04.
 F PRVFUN("CNT")=1:1:$L(PRVFUN(IBFT),",") S PRVFUN=$P(PRVFUN(IBFT),",",PRVFUN("CNT")) D  I $G(IBPOPOUT) K IBPOPOUT Q
 . S X=$S(PRVFUN="Rendering":3,PRVFUN="Referring":1,PRVFUN="Supervising":5,PRVFUN="Operating":2,1:9)  ;DEM;432 - X=Provider Function Code Number.
 . ;I $D(IBLNPRV("IBCCPT")),X'=3 Q  ; DEM;432 - Coming from routine IBCCPT, only interested in RENDERING PROVIDER.
 . K DA,DO,DD
 . S DA(2)=IBIFN,DA(1)=IBPROCP  ;DEM;432 - Set up DA array for call to FILE^DICN.
 . S DIC="^DGCR(399,"_DA(2)_",""CP"","_DA(1)_",""LNPRV"","  ;DEM;432 - Global root of Line Provider multiple.
 . S DIC(0)="L"
 . S DIC("DR")=".01////"_X  ;DEM;432 - Stuff X (provider function) into new entry.
 . I '$D(^DGCR(399,DA(2),"CP",DA(1),"LNPRV","B",X)) D FILE^DICN  ; DEM;432 - Add new entry.
 . S DA=+$O(^DGCR(399,DA(2),"CP",DA(1),"LNPRV","B",X,0))  ;DEM;432 - Get DA of line provider entry.
 . S DIPA("RF")=X  ;DEM;432 - Save provider function in DIPA("RF") for later use in call to DIE.
 . S DIE=DIC
 . K DIC,DO,DD,DR,X,Y
 . D DRARRY  ;DEM;432 - Set up DR array for call to DIE.
 . ;
 . ; DEM;432 - Variable IBLNPRV is a flag for called code
 . ;           that we are coming from line level provider
 . ;           user input (example, EXTCR^IBCEU5).
 . ;
 . S IBLNPRV=1
 . S IBLNPRV("LNPRVIEN")=DA  ;DEM;432 - DA of line provider entry to edit.
 . S IBLNPRV("PROCIEN")=DA(1)  ;DEM;432 - DA(1) is procedure code multiple IEN.
 . S DLAYGO=399  ;DEM;432 - Set DLAYGO.
 . D ^DIE
 . I ($G(Y)="^")!($G(Y)=-1) S IBPOPOUT=1 Q  ; User entered caret ("^"), so exit line provider entry.
 . ; DEM;432 - If line provider zero node exist, and no provider, then delete entry.
 . I $D(^DGCR(399,IBIFN,"CP",IBLNPRV("PROCIEN"),"LNPRV",IBLNPRV("LNPRVIEN"),0))#10,'$P(^DGCR(399,IBIFN,"CP",IBLNPRV("PROCIEN"),"LNPRV",IBLNPRV("LNPRVIEN"),0),U,2) S DR=".01///@" D ^DIE
 . K DIC,DIE,DR,DA,X,Y,DO,DD,DLAYGO,DIPA  ;DEM;432 - Clean up.
 . Q
 ;
 K IBLNPRV,PRVFUN
 ;
END ;
 Q
 ;
DRARRY ; Set of DR array for user input.
 ;
 ; DEM;432 - DIE uses DR to execute individual DR array elements, so
 ;           need to leave DR(1,399.0404) undefined for DIE to move
 ;           DR string into DR(1,399.0404).
 ;
 ; Note: 'B' line tags represent DR string branching.
 ;
 ; 399.0404,.01 LINE FUNCTION.
 ; Stuff value from FILE^DICN add above (DIPA("RF")) into .01 field.
 ; Also, need to set up DIPA("I#") array from claim level for later reference in DR array.
 S DR=".01///^S X=DIPA(""RF"");K DIPA S DIPA(""RF"")=X,DIPA(""I1"")=$D(^DGCR(399,DA(2),""I1"")),DIPA(""I2"")=$D(^(""I2"")),DIPA(""I3"")=$D(^(""I3""))"
 ;
 ; 399.0404,.02 LINE PERFORMED BY.
 ; If no provider entered by user, then delete entry (accomplished by
 ; deleting .01 field, LINE FUNCTION field).
 ; Branch to end (@499) if no provider entered.
 ;S:'$D(IBLNPRV("IBCCPT")) DR(1,399.0404,1)=".02"_PRVFUN_$S(PRVFUN'["Operating":" Provider",1:" Physician")_";S:X DIPA(""PRF"")=X,Y=""@4"";.01///@;S Y=""@499"""
 ;S:$D(IBLNPRV("IBCCPT")) DR(1,399.0404,1)=".02///"_IBLNPRV("IBCCPT")_";.02Rendering;S:X DIPA(""PRF"")=X,Y=""@4"";.01///@;S Y=""@499"""
 S DR(1,399.0404,1)=""
 S:$D(IBLNPRV("IBCCPT"))&(PRVFUN["Rendering") DR(1,399.0404,1)=".02///"_IBLNPRV("IBCCPT")_";"
 S DR(1,399.0404,1)=DR(1,399.0404,1)_".02"_PRVFUN_$S(PRVFUN'["Operating":" Provider",1:" Physician")_";S:X DIPA(""PRF"")=X,Y=""@4"";.01///@;S Y=""@499"""
 ; Branch to @48 if VA PROVIDER.
 ; IF Non-VA PROVIDER, then file changes to IB NON/OTHER VA BILLING PROVIDER File (#355.93) for user input.
 ; DR string syntax ";^355.93^IBA(355.93," accomplishes variable pointer file change.
 ; See DR array DR(2,355.93) and DR(2,355.93,SEQ #) below for details.
 ;
 S DR(1,399.0404,2)="@4;N Z1 S Z1=$P($G(^DGCR(399,DA(2),""CP"",DA(1),""LNPRV"",DA,0)),U,2) S DIPA(""NVA_PRV"")=$S(Z1[""IBA(355.93"":+Z1,1:0) S X=+X I DIPA(""NVA_PRV"")=0 S Y=""@48"""
 S DR(1,399.0404,3)="S:$D(^XUSEC(""IB PROVIDER EDIT"",DUZ)) DLAYGO=355.93;^355.93^IBA(355.93,"
 ;
NVAPRV ; Start of user input into IB NON/OTHER VA BILLING PROVIDER File (#355.93).
 ;
 S DR(2,355.93)="S DIPA(""NVA_PRV-0"")=$G(^IBA(355.93,DIPA(""NVA_PRV""),0))"
 ;
 ; Branch to @42 if PROVIDER TYPE equals '1' FOR FACILITY/GROUP.
 ; Branch to @41 if CREDENTIALS are not NULL.
 S DR(2,355.93,1)="S:$P(DIPA(""NVA_PRV-0""),U,2)=1 Y=""@42"";S:$P(DIPA(""NVA_PRV-0""),U,3)'="""" Y=""@41"""
 ;
 ; 355.93,.03 CREDENTIALS.
 S DR(2,355.93)="S DIPA(""NVA_PRV-0"")=$G(^IBA(355.93,DIPA(""NVA_PRV""),0))"
 ;
 ; Branch to @42 if PROVIDER TYPE equals '1' FOR FACILITY/GROUP.
 ; Branch to @41 if CREDENTIALS are not NULL.
 S DR(2,355.93,1)="S:$P(DIPA(""NVA_PRV-0""),U,2)=1 Y=""@42"";S:$P(DIPA(""NVA_PRV-0""),U,3)'="""" Y=""@41"""
 ;
 ; 355.93,.03 CREDENTIALS.
 S DR(2,355.93,2)=".03"
B41 ;
 ; 355.93,.04 SPECIALTY.
 ; Branch to @45 if CREDENTIALS are not NULL.
 S DR(2,355.93,3)="@41;S:$P(DIPA(""NVA_PRV-0""),U,3)'="""" Y=""@45"";.04;S Y=""@45"""
B42 ;
 ; 355.93,.05 STREET ADDRESS.
 ; 355.93,.06 CITY.
 ; 355.93,.07 STATE.
 ; Branch to @43 if there is an STREET ADDRESS, CITY, and STATE.
 S DR(2,355.93,4)="@42;S:$P(DIPA(""NVA_PRV-0""),U,5)'=""""&($P(DIPA(""NVA_PRV-0""),U,6)'="""")&($P(DIPA(""NVA_PRV-0""),U,7)'="""") Y=""@43"""
 ; 355.93,.05 STREET ADDRESS.
 ; 355.93,.1 STREET ADDRESS LINE 2.
 ; 355.93,.06 CITY.
 ; 355.93,.07 STATE.
 ; 355.93,.08 ZIP CODE.
 S DR(2,355.93,5)=".05;.1;.06;.07;.08"
B43 ;
 ; 355.93,.09 FACILITY DEFAULT ID NUMBER.
 ; Branch to @44 if there is a FACILITY DEFAULT ID NUMBER.
 S DR(2,355.93,6)="@43;S:$P(DIPA(""NVA_PRV-0""),U,9)'="""" Y=""@44"";.09LAB OR FACILITY PRIMARY ID"
B44 ;
 ; 355.93,.11 X12 TYPE OF FACILITY.
 ; Branch to @45 if there is a X12 TYPE OF FACILITY.
 S DR(2,355.93,7)="@44;S:$P(DIPA(""NVA_PRV-0""),U,11)'="""" Y=""@45"";.11"
B45 ;
 ; 355.93,41.01 NPI.
 ; Branch to @46 if there is an NPI.
 S DR(2,355.93,8)="@45;S:$P(DIPA(""NVA_PRV-0""),U,14)'="""" Y=""@46"";D EN2^IBCEP82(DIPA(""NVA_PRV""),4)"
B46 ;
 ; 355.93,42 TAXONOMY CODE.
 ; Branch to @47 if there is TAXONOMY data.
 ; 355.93,42 TAXONOMY CODE is a multiple (Sub-File 355.9342). We want 'ALL'
 ; fields from TAXONOMY CODE Sub-File 355.9342. Thus,
 ; DR string S DR(4,355.9342)=".01:.03" below.
 S DR(2,355.93,9)="@46;S:$D(^IBA(355.93,DIPA(""NVA_PRV""),""TAXONOMY""))>0 Y=""@47"";42"
 S DR(3,355.9342)=".01:.03"
B47 ;
 ; End of data entry for IB NON/OTHER VA BILLING PROVIDER File (#399.53).
 S DR(2,355.93,10)="@47"
 ;
B48 ;
 ;
LNPRV ; User input into LINE PROVIDER Sub-File 399.0404.
 ;
 S DR(1,399.0404,4)="@48"
 S DR(1,399.0404,5)="S DIK=""^DGCR(399,""_DA(2)_"",""""CP"""",""_DA(1)_"",""""LNPRV"""","",DIK(1)="".02"" D EN1^DIK K DIK"
 ; 399.0404,.15 LINE TAXONOMY.
 S DR(1,399.0404,6)=".15Line Level Taxonomy"
 S DR(1,399.0404,7)="D DISPTAX^IBCEP81($P($G(^DGCR(399,DA(2),""CP"",DA(1),""LNPRV"",DA,0)),U,15),"""")"
 S DR(1,399.0404,8)="N Z S Z=$$EXPAND^IBTRE(399.0404,.08,$P($G(^DGCR(399,DA(2),""CP"",DA(1),""LNPRV"",DA,0)),U,8)) S DIPA(""SPC"")=$S(Z'="""":Z,1:""UNSPECIFIED"")"
 S DR(1,399.0404,9)="W !,""    Prov Specialty On File:  "",DIPA(""SPC"")"
 S DR(1,399.0404,10)="S DIPA(""CRD"")=$$CRED^IBCEU($P($G(^DGCR(399,DA(2),""CP"",DA(1),""LNPRV"",DA,0)),U,2))"
 ; 399.0404,.03 LINE CREDENTIALS
 S DR(1,399.0404,11)=".03;K DIPA(""W1"") S:$G(DIPA(""CRD""))'=$P($G(^DGCR(399,DA(2),""CP"",DA(1),""LNPRV"",DA,0)),U,3) DIPA(""W1"")=1"
 S DR(1,399.0404,12)="I $G(DIPA(""W1"")) D WRT1^IBCSC10H($G(DIPA(""CRD"")))"
 ; Branch to @405 if File #399 PRIMARY NODE is non numeric.
 S DR(1,399.0404,13)="K DIPA(""W1"") I '$G(DIPA(""I1"")) S Y=""@405"""
 ; Branching based on DIPA("EDIT") - DIPA("EDIT") set in PROVID^IBCEP2B call
 S DR(1,399.0404,14)="D PROVID^IBCEP2B(DA(2),DA,1,.DIPA) S Y=$S(DIPA(""EDIT"")<0:""@482"",DIPA(""EDIT"")=1:""@491"",DIPA(""EDIT"")=2:""@471"",1:"""")"
B482 ;
 ; Branch to @405 if File #399 SECORDARY NODE is non numeric.
 S DR(1,399.0404,15)="@482;I '$G(DIPA(""I2"")) S Y=""@405"""
 S DR(1,399.0404,16)="D PROVID^IBCEP2B(DA(2),DA,2,.DIPA)"
 ; Branching based on DIPA("EDIT") - DIPA("EDIT") set in PROVID^IBCEP2B call.
 S DR(1,399.0404,17)="S Y=$S(DIPA(""EDIT"")<0:""@483"",DIPA(""EDIT"")=1:""@492"",DIPA(""EDIT"")=2:""@472"",1:"""")"
B483 ;
 ; Branch to @405 if File #399 TERTIARY NODE is non numeric.
 S DR(1,399.0404,18)="@483;I '$G(DIPA(""I3"")) S Y=""@405"""
 S DR(1,399.0404,19)="D PROVID^IBCEP2B(DA(2),DA,3,.DIPA)"
 ; Branching based on DIPA("EDIT") - DIPA("EDIT") set in PROVID^IBCEP2B call.
 S DR(1,399.0404,20)="S Y=$S(DIPA(""EDIT"")<0:""@405"",DIPA(""EDIT"")=1:""@493"",DIPA(""EDIT"")=2:""@473"",1:"""");S Y=""@405"""
B491 ;
 ; 399.0404,.12 LINE PRIM INS PROVIDER ID TYPE.
 ; 399.0404,.05 LINE PRIMARY INS CO ID NUMBER.
 ; Branch to @482.
 S DR(1,399.0404,21)="@491;.12R~T;.05T;S Y=""@482"""
B492 ;
 ; 399.0404,.13 LINE SEC INS PROVIDER ID TYPE.
 ; 399.0404,.06 LINE SECONDARY INS CO ID NUMBER.
 ; Branch to @483.
 S DR(1,399.0404,22)="@492;.13R~T;.06T;S Y=""@483"""
B493 ;
 ; 399.0404,.14 LINE TERT INS PROVIDER ID TYPE.
 ; 399.0404,.07 LINE TERTIARY INS CO ID NUMBER.
 ; Branch to @405.
 S DR(1,399.0404,23)="@493;.14R~T;.07T;S Y=""@405"""
B471 ;
 ; 399.0404,.12 LINE PRIM INS PROVIDER ID TYPE.
 ; 399.0404,.05 LINE PRIMARY INS CO ID NUMBER.
 ; Branch to @482.
 S DR(1,399.0404,24)="@471;.12////^S X=DIPA(""PRIDT"");.05////^S X=DIPA(""PRID"");S Y=""@482"""
B472 ;
 ; 399.0404,.13 LINE SEC INS PROVIDER ID TYPE.
 ; 399.0404,.06 LINE SECONDARY INS CO ID NUMBER.
 ; Branch to @483.
 S DR(1,399.0404,25)="@472;.13////^S X=DIPA(""PRIDT"");.06////^S X=DIPA(""PRID"");S Y=""@483"""
B473 ;
 ; 399.0404,.14 LINE TERT INS PROVIDER ID TYPE.
 ; 399.0404,.07 LINE TERTIARY INS CO ID NUMBER.
 ; Branch to @405.
 S DR(1,399.0404,26)="@473;.14////^S X=DIPA(""PRIDT"");.07////^S X=DIPA(""PRID"");S Y=""@405"""
B405 ;
 S DR(1,399.0404,27)="@405"
 ;
B499 ;
 ; End of user input @499 and W @IOF.
 S DR(1,399.0404,28)="@499;W @IOF"
 Q
