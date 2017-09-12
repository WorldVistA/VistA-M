IBY416PO ;ALB/ESG - Post Install for IB patch 416 ;17-Aug-2009
 ;;2.0;INTEGRATED BILLING;**416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV Phase 3 Iteration 1 post-install
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=8
 D PARM(1)         ; 1. Set eIV parameters appropriately
 D PYRAPP(2)       ; 2. Modify fields in eIV payer application subfile 365.121
 D USR(3)          ; 3. Modify the IIV non-human user to be EIV
 D MENU(4)         ; 4. Change IIV menu mnemonics to be EIV
 D MGRP(5)         ; 5. Change the name of the IIV mail group to be EIV
 D MCR(6)          ; 6. Medicare payer stuff
 D CLEARDUP(7)     ; 7. Clear duplicate entries in dictionary files
 D RMSG(8)         ; 8. Send site registration message to FSC
 ;
EX ; exit point
 Q
 ;
PARM(IBXPD) ; set eIV parameters for all extracts
 NEW IEN,DATA,TYB,DR,DA,DIE,DIK
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Set eIV Site Parameters ... ")
 ;
 S IEN=0
 F  S IEN=$O(^IBE(350.9,1,51.17,IEN)) Q:'IEN  D
 . S DATA=$G(^IBE(350.9,1,51.17,IEN,0))
 . S TYB=+$P(DATA,U,1)
 . I TYB=1 S DR=".02////1;.03////@;.04////@;.05////99999;.06////@",DA=IEN,DA(1)=1,DIE="^IBE(350.9,1,51.17," D ^DIE Q
 . I TYB=2 S DR=".02////1;.03////10;.04////@;.05////99999;.06////@",DA=IEN,DA(1)=1,DIE="^IBE(350.9,1,51.17," D ^DIE Q
 . I TYB=3 S DR=".02////0;.05////99999;.06////@",DA=IEN,DA(1)=1,DIE="^IBE(350.9,1,51.17," D ^DIE Q
 . I TYB=4 S DA=IEN,DA(1)=1,DIK="^IBE(350.9,1,51.17," D ^DIK Q
 . Q
 ;
PARMX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
PYRAPP(IBXPD) ; set eIV payer application values
 NEW PIEN,APPIEN,IDATA,IOK,Z
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Update eIV Payer Application values ... ")
 ; check if this patch has already been installed once. If so, don't change payer application values.
 D FIND^DIC(9.7,,"@;.02","PX","IB*2.0*416",,"B",,,"IDATA")
 S (IOK,Z)=0 F  S Z=$O(IDATA("DILIST",Z)) Q:'Z!IOK  I $P(IDATA("DILIST",Z,0),U,2)="Install Completed" S IOK=1
 I IOK G PYRAPPX
 ;
 S PIEN=0
 F  S PIEN=$O(^IBE(365.12,PIEN)) Q:'PIEN  D
 . S APPIEN=+$$PYRAPP^IBCNEUT5("IIV",PIEN) Q:'APPIEN
 . S $P(^IBE(365.12,PIEN,1,APPIEN,0),U,7)=0     ; initial default to auto-accept NO
 . S $P(^IBE(365.12,PIEN,1,APPIEN,0),U,9)=0     ; use SSN for subscriber ID always NO from now on
 . Q
 ;
PYRAPPX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
USR(IBXPD) ; change the name of the eIV non-human user
 NEW IDUZ,DIE,DA,DR,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Change the name of the eIV user ... ")
 ;
 S IDUZ=$$FIND1^DIC(200,"","X","INTERFACE,IB IIV")    ; old name to be changed
 I 'IDUZ G USRX   ; it has already been changed or doesn't exist
 S DIE=200,DA=IDUZ
 S DR=".01////^S X=""INTERFACE,IB EIV"";1////^S X=""EIV"""
 D ^DIE
USRX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
MENU(IBXPD) ; change a menu mnemonic to EIV
 NEW MENUIEN,ITEMIEN,DIE,DA,DR,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating Patient Insurance Menu mnemonic ... ")
 S MENUIEN=$O(^DIC(19,"B","IBCN INSURANCE MGMT MENU",0)) I 'MENUIEN D MES^XPDUTL("Parent menu not found.") G M2
 S ITEMIEN=$O(^DIC(19,"B","IBCNE IIV MENU",0)) I 'ITEMIEN D MES^XPDUTL("eIV Menu item not found.") G M2
 S DA=+$O(^DIC(19,MENUIEN,10,"B",ITEMIEN,0)) I 'DA D MES^XPDUTL("eIV Menu item not found on Pt. Ins. Menu.") G M2
 I $P($G(^DIC(19,MENUIEN,10,DA,0)),U,2)="EIV" D MES^XPDUTL("eIV Menu mnemonic has already been updated.") G M2
 S DIE="^DIC(19,"_MENUIEN_",10,"
 S DA(1)=MENUIEN
 S DR="2////EIV"
 D ^DIE,MES^XPDUTL("eIV Menu mnemonic updated.")
M2 ;
 D MES^XPDUTL("Updating IB Purge Menu mnemonic ... ")
 S MENUIEN=$O(^DIC(19,"B","IB PURGE MENU",0)) I 'MENUIEN D MES^XPDUTL("Parent menu not found.") G MENUX
 S ITEMIEN=$O(^DIC(19,"B","IBCNE PURGE IIV DATA",0)) I 'ITEMIEN D MES^XPDUTL("eIV purge item not found.") G MENUX
 S DA=+$O(^DIC(19,MENUIEN,10,"B",ITEMIEN,0)) I 'DA D MES^XPDUTL("Purge eIV Transactions item not found on IB Purge Menu.") G MENUX
 I $P($G(^DIC(19,MENUIEN,10,DA,0)),U,2)="EIV" D MES^XPDUTL("eIV Purge option mnemonic has already been updated.") G MENUX
 S DIE="^DIC(19,"_MENUIEN_",10,"
 S DA(1)=MENUIEN
 S DR="2////EIV"
 D ^DIE,MES^XPDUTL("eIV Purge option mnemonic updated.")
 ;
MENUX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
MGRP(IBXPD) ; change the eIV mail group name/desc
 NEW MGIEN,MGDY,IENS,IBMGD
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating eIV Mail Group name ... ")
 ;
 S MGIEN=$$FIND1^DIC(3.8,,"BX","IBCNE EIV MESSAGE","B")
 I MGIEN D MES^XPDUTL("eIV Mail Group name already changed.") G MGRPX
 ;
 S MGIEN=$$FIND1^DIC(3.8,,"BX","IBCNE IIV MESSAGE","B")
 I 'MGIEN D MES^XPDUTL("Can't find the old IIV mail group.") G MGRPX
 ;
 S MGDY=2
 S MGDY(1)="This mail group will be used to deliver notifications for"
 S MGDY(2)="the Insurance Verification process."
 ;
 S IENS=MGIEN_","
 S IBMGD(3.8,IENS,.01)="IBCNE EIV MESSAGE"
 S IBMGD(3.8,IENS,3)="MGDY"
 D FILE^DIE(,"IBMGD")
 D MES^XPDUTL("eIV Mail Group name updated.")
 ;
MGRPX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
MCR(IBXPD) ; perform actions related to the Medicare payer
 NEW PAYR,LN,MSG,DIE,DA,DR,DIC,DO,ERR,APPIEN,APD,IDUZ,STOP,CNT,IBZ
 NEW INSLSTA,INSLSTB,INSLST,MRD,IBIFN,INS,X,Y,Z,OK,INSNM,NMUP,AMV
 NEW SITE,SUBJ,XMTO,XMINSTR
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Activating Medicare for eIV ... ")
 ;
 S LN=0,ERR=0
 S PAYR=+$$FIND1^DIC(365.12,"","X","MEDICARE WNR")
 I 'PAYR S LN=LN+1,ERR=1,MSG(LN)="Can't find the MEDICARE WNR Payer in file 365.12." G MCR1
 ;
 S DIE=350.9,DA=1,DR="51.25///"_PAYR D ^DIE K DIR,DA,DR
 S IBZ=+$P($G(^IBE(350.9,1,51)),U,25)
 S LN=LN+1,MSG(LN)="Medicare payer stored in IB site params; ien="_IBZ_"; "_$P($G(^IBE(365.12,IBZ,0)),U,1)_"."
 ;
 S APPIEN=+$$PYRAPP^IBCNEUT5("IIV",PAYR)
 I 'APPIEN S LN=LN+1,ERR=1,MSG(LN)="No eIV application data defined for MEDICARE WNR Payer." G MCR1
 ;
 S APD=$G(^IBE(365.12,PAYR,1,APPIEN,0))
 I $P(APD,U,2) S LN=LN+1,MSG(LN)="MEDICARE WNR is already nationally active."
 I $P(APD,U,3) S LN=LN+1,MSG(LN)="MEDICARE WNR is already locally active."
 S IDUZ=+$$FIND1^DIC(200,"","X","INTERFACE,IB EIV") I 'IDUZ S IDUZ=DUZ
 S DIE="^IBE(365.12,"_PAYR_",1,"
 S DA=APPIEN,DA(1)=PAYR
 S DR=".02///1;.03///1;.04///"_IDUZ_";.05///NOW;.06///NOW"
 D ^DIE K DIE,DA,DR
 S LN=LN+1,MSG(LN)="Payer MEDICARE WNR has been activated."
 ;
MCR1 ; now find and process the Medicare (WNR) insurance company
 ;
 ; loop to examine recent MRA request claims at the site
 S STOP=0,CNT=0 K INSLSTA
 S MRD="" F  S MRD=$O(^DGCR(399,"APM",MRD),-1) Q:MRD=""!STOP  S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"APM",MRD,IBIFN)) Q:'IBIFN!STOP  D  Q:STOP
 . S CNT=CNT+1 I CNT>1000 S STOP=1 Q
 . S INS=+$P($G(^DGCR(399,IBIFN,"I1")),U,1) Q:'INS     ; ins. co. ien
 . I '$$MCRWNR^IBEFUNC(INS) Q    ; must be defined as medicare wnr
 . S INSLSTA(INS)=""
 . Q
 I 'STOP,CNT S LN=LN+1,ERR=1,MSG(LN)="Very few MRA request claims on file.  Count="_CNT_"."
 I 'CNT S LN=LN+1,ERR=1,MSG(LN)="No MRA request claims found."
 S INS=0 F Z=0:1 S INS=$O(INSLSTA(INS)) Q:'INS
 I 'Z S LN=LN+1,ERR=1,MSG(LN)="No Medicare (WNR) ins co found in MRA request claims."
 I 'CNT!'Z S LN=LN+1,ERR=1,MSG(LN)="Value of the EDI/MRA ACTIVATED parameter: "_$$EXTERNAL^DILFD(350.9,8.1,"",$P($G(^IBE(350.9,1,8)),U,10))
 I Z>1 D
 . S LN=LN+1,ERR=1,MSG(LN)="More than 1 Medicare (WNR) ins co found in MRA request claims.  "_Z_" found as follows."
 . S INS=0 F  S INS=$O(INSLSTA(INS)) Q:'INS  D
 .. S LN=LN+1,ERR=1,MSG(LN)="     "_$P($G(^DIC(36,INS,0)),U,1)_"  ien="_INS
 .. Q
 . Q
 ;
 ; now loop through insurance company file
 K INSLSTB
 S INS=0 F  S INS=$O(^DIC(36,INS)) Q:'INS  D
 . I '$$MCRWNR^IBEFUNC(INS) Q     ; check for medicare wnr
 . I '$$ACTIVE^IBCNEUT4(INS) Q    ; check for active
 . S INSLSTB(INS)=""
 . Q
 S INS=0 F Z=0:1 S INS=$O(INSLSTB(INS)) Q:'INS
 I 'Z S LN=LN+1,ERR=1,MSG(LN)="No Medicare (WNR) ins co found in the insurance company file."
 I Z>1 D
 . S LN=LN+1,ERR=1,MSG(LN)="More than 1 Medicare (WNR) ins co found in the insurance company file.  "_Z_" found as follows."
 . S INS=0 F  S INS=$O(INSLSTB(INS)) Q:'INS  D
 .. S LN=LN+1,ERR=1,MSG(LN)="     "_$P($G(^DIC(36,INS,0)),U,1)_"  ien="_INS
 .. Q
 . Q
 ;
 ; combine the lists together and loop thru them all
 K INSLST
 M INSLST=INSLSTA,INSLST=INSLSTB
 S INS=0 F  S INS=$O(INSLST(INS)) Q:'INS  D
 . S INSNM=$P($G(^DIC(36,INS,0)),U,1)
 . S NMUP=$$UP^XLFSTR(INSNM)   ; uppercase name
 . S OK=0
 . I NMUP["MEDICARE",NMUP["WNR" S OK=1
 . ;
 . ; name disqualifies this ins co from being changed
 . I 'OK S LN=LN+1,ERR=1,MSG(LN)="Insurance company "_INSNM_" will NOT be linked to the MEDICARE WNR payer." Q
 . ;
 . ; name is good for payer linking
 . I PAYR D
 .. S DIE=36,DA=INS,DR="3.1////"_PAYR D ^DIE K DIE,DA,DR
 .. S LN=LN+1,MSG(LN)="Insurance company "_INSNM_" linked to MEDICARE WNR payer."
 .. I INSNM'="MEDICARE (WNR)" S ERR=1     ; to be notified of these strange ones
 .. Q
 . ;
 . ; name is good for possibly creating these 2 Auto-Match entries
 . F AMV="MEDICARE","MEDICARE WNR" D
 .. S LN=LN+1,MSG(LN)="Attempt to add Auto-Match entry for """_AMV_"""."
 .. I AMV=NMUP S LN=LN+1,MSG(LN)="No Auto-Match for """_AMV_""" - same value as ins co name." Q
 .. I $D(^IBCN(365.11,"B",AMV)) S LN=LN+1,MSG(LN)=""""_AMV_""" already in Auto-Match file." Q
 .. I $D(^DIC(36,"B",AMV)) S LN=LN+1,MSG(LN)=""""_AMV_""" already an Ins Co Name." Q
 .. I $D(^DIC(36,"C",AMV)) S LN=LN+1,MSG(LN)=""""_AMV_""" already an Ins Co Synonym." Q
 .. ;
 .. ; OK to file this new Auto-Match entry
 .. K DO
 .. S IDUZ=+$$FIND1^DIC(200,"","X","INTERFACE,IB EIV") I 'IDUZ S IDUZ=DUZ
 .. S DIC="^IBCN(365.11,",DIC(0)="",X=AMV
 .. S DIC("DR")=".02////"_NMUP_";.03///NOW;.04///"_IDUZ_";.05///NOW;.06///"_IDUZ_";.07////"_AMV_";.08////"_NMUP
 .. D FILE^DICN
 .. I +Y>0,$P(Y,U,3) S LN=LN+1,MSG(LN)="Auto-Match entry linking """_AMV_""" with "_NMUP_" added." Q
 .. S LN=LN+1,ERR=1,MSG(LN)="Failure when trying to add Auto-Match entry linking """_AMV_""" with "_NMUP_"." Q
 .. Q
 . Q
 ;
 ; display the MSG array to the screen and save in the install file
 D MES^XPDUTL(.MSG)
 ;
 ; send email
 I ERR=0 G MCRX                 ; nothing email-worthy found
 I '$$PROD^XUPROD(1) G MCRX     ; only email from production accounts
 ;
 S SITE=$$SITE^VASITE
 S SUBJ="IB*2*416 eIV Medicare Activation - #"_$P(SITE,U,3)_" - "_$P(SITE,U,2)
 S SUBJ=$E(SUBJ,1,65)
 ;
 S XMTO("Yan.Gurtovoy@domain.ext")=""
 ;
 S XMINSTR("FROM")="IB*2*416.Medicare.Activation"
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 ;
MCRX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
CLEARDUP(IBXPD) ; clear duplicate entries in dictionary files
 N CODE,FILE,NESDESC,NEWIEN,OLDIEN
 N DA,DIE,DIK,DR,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Cleaning dictionary files ... ")
 F FILE=365.011:.001:365.028 D
 .I '$D(^DIC(FILE)) Q
 .S CODE="" F  S CODE=$O(^IBE(FILE,"B",CODE)) Q:CODE=""  D
 ..S OLDIEN=$O(^IBE(FILE,"B",CODE,"")),NEWIEN=$O(^IBE(FILE,"B",CODE,""),-1)
 ..I OLDIEN=NEWIEN Q  ; only one entry, no duplicates
 ..; replace description in the old entry
 ..S NEWDESC=$P($G(^IBE(FILE,NEWIEN,0)),U,2) I NEWDESC="" Q
 ..S DIE=FILE,DA=OLDIEN,DR=".02///"_NEWDESC D ^DIE
 ..; delete duplicate entry
 ..S DA=NEWIEN,DIK="^IBE("_FILE_"," D ^DIK
 ..Q
 .Q
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
RMSG(IBXPD) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 I '$$PROD^XUPROD(1) D MES^XPDUTL(" N/A - not a production account") G RMSGX  ; only sent reg. message from production account
 D ^IBCNEHLM
 D MES^XPDUTL(" Done.")
RMSGX ;
 D UPDATE^XPDID(IBXPD)
 Q
