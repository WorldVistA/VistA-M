IBY664PO ;AITC/VD - Post-Installation for IB patch 664; MAR 31, 2020
 ;;2.0;INTEGRATED BILLING;**664**;MAR 21,1994;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 Q
PRE ; PRE-INSTALL for IBY664PO
 D DELTRG
 Q
 ;
DELTRG ; delete 2 triggers in #2.312,.01
 ; ICR# 2916 - Is for the use of the DELIX^DDMOD call to delete
 ;             the TRIGGERS in #2.312,.01.
 N IBA
 S IBA(2)="     IB*2*664 Pre-Install .....",IBA(1)=" " D MES^XPDUTL(.IBA) K IBA
 ;
 D DELIX^DDMOD(2.312,.01,4)
 S IBA(2)="     >> ^DD(2.312,.01) Trigger #4 deleted",IBA(1)=" " D MES^XPDUTL(.IBA) K IBA
 ;
 D DELIX^DDMOD(2.312,.01,5)
 S IBA(2)="     >> ^DD(2.312,.01) Trigger #5 deleted",IBA(1)=" " D MES^XPDUTL(.IBA) K IBA
 ;
 S IBA(2)="     IB*2*664 Pre-Install Complete",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;- - - - - - - - - - - - - - - - - - - - - - - - - - - -
 ;
 ;
POST ; POST ROUTINE(S)
 N IBXPD,PRODENV,SITE,SITENAME,SITENUM,XPDIDTOT
 S XPDIDTOT=2
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S PRODENV=$$PROD^XUPROD(1)   ; 1=Production Environment, 0=Test Environment
 D MES^XPDUTL("")
 D ADDSOI(1)          ; Add 'Electronic Health Record' to the SOI file (#355.12)
 D SITEREG(2,SITENUM) ; Send site registration message to FSC
 ;
 ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install for IB*2.0*664 Completed.")
 Q
 ;============================
ADDSOI(IBXPD) ; Add 'ELECTRONIC HEALTH RECORD' to the SOI file.
 N DA,DIK,IBCNT,IBERR,IBIEN,NEWSOI,OLDSOI
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding ELECTRONIC HEALTH RECORD as a new Source of Information")
 D MES^XPDUTL("in the Source of Information File (#355.12) ... ")
 ;
 S NEWSOI(.01)=21,NEWSOI(.02)="ELECTRONIC HEALTH RECORD",NEWSOI(.03)="EHR"
 ;
 S IBCNT=21
 I $D(^IBE(355.12,IBCNT)) D  Q   ; An SOI already exists in record #21.
 . N PCCNT
 . F PCCNT=.01:.01:.03 S OLDSOI(PCCNT)=$$GET1^DIQ(355.12,IBCNT,PCCNT,"I")
 . ;
 . I OLDSOI(.02)="ELECTRONIC HEALTH RECORD",OLDSOI(.03)="EHR" D  Q  ;'EHR' already exists.
 . . D MES^XPDUTL("")
 . . D MES^XPDUTL("ELECTRONIC HEALTH RECORD (EHR) entry was not installed.")
 . . D MES^XPDUTL("It already exists in the Source Of Information file (#355.12).")
 . ;
 . ; Delete pre-existing SOI record #21 because it is not the EHR SOI.
 . S DA=IBCNT S DIK="^IBE(355.12," D ^DIK
 . S IBIEN=$$ADD^IBDFDBS(355.12,,.NEWSOI,.IBERR,IBCNT)
 . I IBERR D  Q
 . . D BMES^XPDUTL("")
 . . D BMES^XPDUTL("*** ERROR ADDING "_NEWSOI(.02)_" CODE TO THE SOURCE OF INFORMATION TABLE (#355.12) (#355.12) - Log a Service Ticket! ***")
 . D BMES^XPDUTL("")
 . D BMES^XPDUTL("Replaced record #21 ("_OLDSOI(.03)_") - "_OLDSOI(.02)_" with the new")
 . D BMES^XPDUTL("ELECTRONIC HEALTH RECORD (EHR) entry in the Source Of Information file")
 . D BMES^XPDUTL("(#355.12).")
 . ;
 . I PRODENV D   ; Send an email to the eInsurance Rapid Response Team.
 . . N MSG,SUBJ,XMINSTR,XMTO
 . . S SUBJ="IB*2*644 - EHR replaces existing SOI #"_$P(SITE,U,3)_" "_$P(SITE,U,2)  ; Approved by eBiz on 5/5/2020 @ USD&P
 . . S SUBJ=$E(SUBJ,1,65)
 . . S MSG(1)="On "_$$FMTE^XLFDT($$NOW^XLFDT)_" at Site # "_SITENUM_" - "_SITENAME_","
 . . S MSG(2)="the installation of patch IB*2.0*664 added the new EHR - ELECTRONIC HEALTH RECORD"
 . . S MSG(3)="entry to the Source Of Information file (#355.12) by removing the non-standardized"
 . . S MSG(4)="entry # 21 for "_OLDSOI(.03)_" - "_OLDSOI(.02)_"."
 . . S MSG(5)=""
 . . S XMTO("VHAeInsuranceRapidResponse@domain.ext")=""
 . . ;
 . . S XMINSTR("FROM")="VistA-eInsurance"
 . . D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 ;
 S IBIEN=$$ADD^IBDFDBS(355.12,,.NEWSOI,.IBERR,IBCNT)
 I IBERR D  Q
 . D BMES^XPDUTL("")
 . D BMES^XPDUTL("*** ERROR ADDING "_NEWSOI(.02)_" CODE TO THE SOURCE OF INFORMATION TABLE (#355.12) (#355.12) - Log a Service Ticket! ***")
 D MES^XPDUTL("Source of Information: ELECTRONIC HEALTH RECORD added successfully")
 Q
 ;
SITEREG(IBXPD,SITENUM) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Send eIV site registration message to FSC ... ")
 ;
 I '$$PROD^XUPROD(1) D MES^XPDUTL("N/A - Not a production account - No site registration message sent") G SITEREGQ
 I SITENUM=358 D MES^XPDUTL("Current Site is MANILA - NO eIV site registration message sent") G SITEREGQ
 D ^IBCNEHLM
 D MES^XPDUTL("eIV site registration message was successfully sent")
 ;
SITEREGQ ;
 Q
 ;
