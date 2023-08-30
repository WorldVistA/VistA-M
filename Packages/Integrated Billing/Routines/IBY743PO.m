IBY743PO ;AITC/TAZ - Post-Installation for IB patch 743; NOV 08, 2022
 ;;2.0;INTEGRATED BILLING;**743**;MAR 21,1994;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 Q
 ;
POST ; POST-INSTALL
 N IBINSTLD,IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=2
 ;
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S IBINSTLD=$$INSTALDT^XPDUTL("IB*2.0*743","")
 D MES^XPDUTL("")
 ;
 D ORPHAN(1) ; check IIV TRANSMISSION QUEUE File (#365.1) for 'TRANSMITTED' orphans
 ;
 D NONVER(2) ;Clean up Non-Verified extract data in Site Parameter file (350.9)
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D BMES^XPDUTL("POST-Install for IB*2.0*743 Completed.")
 Q
 ;============================
 ;
ORPHAN(IBXPD,SITENUM) ; check IIV TRANSMISSION QUEUE File (#365.1) for 'TRANSMITTED' orphans
 ;
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("Check IIV TRANSMISSION QUEUE File (#365.1) for 'TRANSMITTED' orphans ")
 D MES^XPDUTL("-------------")
 N IBMES,IBSTAT
 D BMES^XPDUTL("Queueing 'IB - eIV TQ Orphan Check' to run at 8pm")
 S IBMES="",IBSTAT=$$BGORPHAN^IBCNEUT7
 S IBMES=IBMES_$P(IBSTAT,U,2)
 D BMES^XPDUTL(IBMES)
 Q
 ;
NONVER(IBXPD) ;Clean up Non-Verified extract data in Site Parameter file (350.9)
 ;
 N IBIEN
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL(";Clean up Non-Verified extract data in Site Parameter file (350.9)")
 D MES^XPDUTL("-------------")
 N IBMES,IBSTAT
 ; Get IEN of Non-Verified Extract from "B" xref
 S IBIEN=$O(^IBE(350.9,1,51.17,"B",3,"")) I 'IBIEN G NONVERQ
 ; Kill Non-Verified Extract Node
 K ^IBE(350.9,1,51.17,IBIEN)
 ; Kill Non-Verified Extract Cross Reference
 K ^IBE(350.9,1,51.17,"B",3)
NONVERQ ;
 D MES^XPDUTL("Clean up of Non-Verified extract data in Site Parameter file (350.9) - Complete")
 Q
