BPS20PST ;ALB/ESG - Post-install for BPS*1.0*20 ;08/26/2015
 ;;1.0;E CLAIMS MGMT ENGINE;**20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF ePharmacy Compliance Phase 3 - BPS*1*20 patch post install
 ;
 Q
 ;
POST ; Entry Point for post-install
 ;
 D BMES^XPDUTL("  Starting post-install of BPS*1*20")
 N XPDIDTOT
 S XPDIDTOT=7
 D MENU(1)          ; 1. remove the cached hidden menu protocol for the ECME User Screen
 D UPDPRTCL(2)      ; 2. update the protocols on the ECME user screen
 D DNSBPS(3)        ; 3. delete the IP address & enter the DNS Domain in BPS NCPDP link
 D DNSEPH(4)        ; 4. delete the IP address & enter the DNS Domain in EPHARM OUT link
 D VERSION(5)       ; 5. update the Vitria interface version and do the registration
 D TRICARE(6)       ; 6. rename the BPS COB RPT TRICARE CLAIMS option
 D COBMNE(7)        ; 7. rename the TRI mnemonic in BPS COB MENU option
 ;
EX ; exit point
 ;
 D BMES^XPDUTL("  Finished post-install of BPS*1*20")
 Q
 ;
MENU(BPSXPD) ; remove the cached hidden menu protocol
 N BPSORD,XQORM
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing the cached hidden parent menu for the ECME User Screen ... ")
 ;
 S BPSORD=$O(^ORD(101,"B","BPS PRTCL USRSCR HIDDEN ACTIONS",0))
 S XQORM=BPSORD_";ORD(101,"
 K ^XUTL("XQORM",XQORM)
 ;
MENUX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
 ;
UPDPRTCL(BPSXPD) ; Update protocols
 N BPSDELP,BPSADDP,X,BPSDATA,BPSPUPD
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating actions on the ECME User Screen ... ")
 ;
 S BPSDELP(1)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR CONTINUOUS"
 S BPSDELP(2)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR UPDATE"
 S BPSDELP(3)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR CLAIM LOG"
 S BPSDELP(4)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR EXIT"
 S BPSDELP(5)="BPS PRTCL USRSCR HIDDEN ACTIONS^BPS PRTCL USRSCR VIEW ECME RX"
 ;
 S BPSADDP(1)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR CHANGE VIEW^CV^11"
 S BPSADDP(2)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR SORTLIST^SO^12"
 S BPSADDP(3)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR COMMENT^CMT^13"
 S BPSADDP(4)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR REVERSE^REV^21"
 S BPSADDP(5)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR RESUBMIT^RES^22"
 S BPSADDP(6)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR CLOSE^CLO^23"
 S BPSADDP(7)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR RESEARCH MENU^FR^31"
 S BPSADDP(8)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR VIEW ECME RX^VER^32"
 S BPSADDP(9)="BPS PRTCL ECME USRSCR^BPS PRTCL USRSCR PHARM WRKLST^WRK^33"
 S BPSADDP(10)="BPS PRTCL USRSCR HIDDEN ACTIONS^BPS PRTCL USRSCR UPDATE^UD"
 S BPSADDP(11)="BPS PRTCL USRSCR HIDDEN ACTIONS^BPS PRTCL USRSCR CLAIM LOG^LOG"
 S BPSADDP(12)="BPS PRTCL USRSCR HIDDEN ACTIONS^BPS PRTCL USRSCR EXIT^EX"
 ;
 I '+$$LKPROT^XPDPROT("BPS PRTCL ECME USRSCR") G UPDPRTX
 I '+$$LKPROT^XPDPROT("BPS PRTCL USRSCR HIDDEN ACTIONS") G UPDPRTX
 ;
 ; Delete protocols
 F X=1:1:5 D
 .S BPSDATA=BPSDELP(X)
 .Q:'+$$LKPROT^XPDPROT($P(BPSDATA,"^",2))
 .S BPSPUPD=$$DELETE^XPDPROT($P(BPSDATA,"^"),$P(BPSDATA,"^",2))
 .I 'BPSPUPD D  Q
 ..D MES^XPDUTL($P(BPSDATA,"^",2)_" protocol already deleted from "_$P(BPSDATA,"^")_".")
 ;
 ; Add protocols
 F X=1:1:12 D
 .S BPSDATA=BPSADDP(X)
 .Q:'+$$LKPROT^XPDPROT($P(BPSDATA,"^",2))
 .S BPSPUPD=$$ADD^XPDPROT($P(BPSDATA,"^"),$P(BPSDATA,"^",2),$P(BPSDATA,"^",3),$S($P(BPSDATA,"^",4)'="":$P(BPSDATA,"^",4),1:""))
 .I 'BPSPUPD D  Q
 ..D MES^XPDUTL("  Unable to add "_$P(BPSDATA,"^",2)_" protocol to "_$P(BPSDATA,"^")_".")
 ;
UPDPRTX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
TRICARE(BPSXPD) ; Rename BPS COB RPT TRICARE CLAIMS option
 N BPSOLDNM,BPSNEWNM,BPSIEN19,DR,DIE,DA
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Renaming BPS COB RPT TRICARE CLAIMS option ... ")
 ;
 S BPSOLDNM="BPS COB RPT TRICARE CLAIMS"
 S BPSNEWNM="BPS POTENTIAL CLAIMS RPT DUAL"
 S BPSIEN19=+$$LKOPT^XPDMENU(BPSOLDNM)
 I 'BPSIEN19 D MES^XPDUTL(BPSOLDNM_" has already been renamed.") G TRICX
 ;
 D RENAME^XPDMENU(BPSOLDNM,BPSNEWNM)
 S BPSIEN19=+$$LKOPT^XPDMENU(BPSNEWNM)
 I BPSIEN19 D
 .S DR="1///Potential Claims Report for Dual Eligible"
 .S DIE="^DIC(19,",DA=BPSIEN19
 .D ^DIE
 ;
TRICX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
 ;
COBMNE(BPSXPD) ; Rename mnemonic in BPS COB MENU option
 N BPSOPT,BPSIEN19,BPSITEM,DR,DIE,DA
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Renaming mnemonic in BPS COB MENU option ... ")
 ;
 S BPSOPT="BPS COB MENU"
 S BPSIEN19=+$$LKOPT^XPDMENU(BPSOPT)
 I 'BPSIEN19 D MES^XPDUTL(BPSOPT_" option not found.") G COBMNEX
 S BPSITEM=+$O(^DIC(19,BPSIEN19,10,"C","PCR",0))
 I BPSITEM D MES^XPDUTL(BPSOPT_" has already been renamed.") G COBMNEX
 ;
 S BPSITEM=+$O(^DIC(19,BPSIEN19,10,"C","TRI",0))
 I BPSITEM D
 .S DR="2///PCR"
 .S DIE="^DIC(19,"_BPSIEN19_",10,",DA(1)=BPSIEN19,DA=BPSITEM
 .D ^DIE
 ;
COBMNEX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
 ;
DNSBPS(BPSXPD) ; Delete the TCP/IP ADDRESS if it exists in the BPS NCPDP
 ; logical link & enter the FSC DNS DOMAIN in File #870
 N DA,DIE,DLAYGO,DR,X,Y
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Deleting the TCP/IP ADDRESS and entering the Financial Services Center")
 D MES^XPDUTL("DNS DOMAIN in the 'BPS NCPDP' link of the HL LOGICAL LINK File #870...")
 ;
 S IBPRD=$S($$PROD^XUPROD(1)=1:"P",1:"T")
 S DIC="^HLCS(870,",DLAYGO=870,DIC(0)="LS",X="BPS NCPDP" D ^DIC
 ;
 ; For Test environments use the FSC TEST domain
 I IBPRD="T",Y'=-1 D
 . S DIE=DIC,DA=+Y,DR=".08///EPHARMACY.VITRIA-EDI-TEST.AAC.DOMAIN.EXT;400.01///@"
 . K DIC D ^DIE
 ;
 ; For Production environments, use the FSC PRD domain
 I IBPRD="P",Y'=-1 D
 . S DIE=DIC,DA=+Y,DR=".08///EPHARMACY.VITRIA-EDI.AAC.DOMAIN.EXT;400.01///@"
 . K DIC D ^DIE
 ;
DNSX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
 ;
DNSEPH(BPSXPD) ; Delete the TCP/IP ADDRESS if it exists in the EPHARM OUT 
 ; logical link & enter the FSC DNS DOMAIN in File #870
 N DA,DIE,DLAYGO,DR,X,Y
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Deleting the TCP/IP ADDRESS and entering the Financial Services Center")
 D MES^XPDUTL("DNS DOMAIN in the 'EPHARM OUT' link of the HL LOGICAL LINK File #870...")
 S IBPRD=$S($$PROD^XUPROD(1)=1:"P",1:"T")
 S DIC="^HLCS(870,",DLAYGO=870,DIC(0)="LS",X="EPHARM OUT" D ^DIC
 ;
 ; For Test environments use the FSC TEST domain
 I IBPRD="T",Y'=-1 D
 . S DIE=DIC,DA=+Y,DR=".08///EPHARMACY.VITRIA-EDI-TEST.AAC.DOMAIN.EXT;400.01///@"
 . K DIC D ^DIE
 ;
 ; For Production environments, use the FSC PRD domain
 I IBPRD="P",Y'=-1 D
 . S DIE=DIC,DA=+Y,DR=".08///EPHARMACY.VITRIA-EDI.AAC.DOMAIN.EXT;400.01///@"
 . K DIC D ^DIE
 ;
EPHX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
 ;
VERSION(BPSXPD) ; Update Vitria Interface Version and do automatic registration
 N DR,DIE,DA
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating the Vitria ePharmacy Interface Version ... ")
 ;
 I $$GET1^DIQ(9002313.99,1,6003)'<5 D MES^XPDUTL("Vitria Interface version has already been updated.") G VERX
 ;
 S DR="6003///5"                  ; update to version 5 with BPS*1*20
 S DIE="^BPS(9002313.99,",DA=1
 D ^DIE
 D TASKMAN^BPSJAREG               ; perform registration with AITC
VERX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
