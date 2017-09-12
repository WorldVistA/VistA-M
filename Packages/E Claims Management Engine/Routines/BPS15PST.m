BPS15PST ;ALB/ESG - Post-install for BPS*1.0*15 ;02/13/2013
 ;;1.0;E CLAIMS MGMT ENGINE;**15**;JUN 2004;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ePharmacy Operating Rules - BPS*1*15 patch post install
 ;
 Q
 ;
POST ; Entry Point for post-install
 D BMES^XPDUTL("  Starting post-install of BPS*1*15")
 N XPDIDTOT
 S XPDIDTOT=1
 D OPT(1)          ; 1. remove the IB DRUGS NON COVERED REPORT from a BPS parent menu
 ;
 ;If HL7 listener port number detected is not 5000 send notification e-mail message
 N PORT S PORT=$$EPPORT^BPSJUTL D:PORT'=5000 EMAIL(PORT)
 ;
 ;
EX ; exit point
 ;
 D BMES^XPDUTL("  Finished post-install of BPS*1*15")
 Q
 ;
OPT(BPSXPD) ; remove the IB DRUGS NON COVERED REPORT from the BPS MENU MAINTENANCE parent menu
 N RES
 D BMES^XPDUTL(" STEP "_BPSXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing the 'Drugs non covered report' from an ECME parent menu ... ")
 ;
 S RES=$$DELETE^XPDMENU("BPS MENU MAINTENANCE","IB DRUGS NON COVERED REPORT")
 I RES D MES^XPDUTL("  Menu option successfully removed!") G OPTX
 ;
 D MES^XPDUTL("  Menu option already removed.")
OPTX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(BPSXPD)
 Q
 ;
EMAIL(PORT) ; send email when patch is installed if port number detected is not 5000
 N SUBJ,MSG,XMTO,GLO,GLB,XMINSTR,SITE
 S SITE=$$SITE^VASITE
 S SUBJ="BPS*1*15 installed at Station# "_$P(SITE,U,3)_" - "_$P(SITE,U,2)
 S SUBJ=$E(SUBJ,1,65)
 S MSG(2)=""
 S MSG(3)="        Name: "_$P(SITE,U,2)
 S MSG(4)="    Station#: "_$P(SITE,U,3)
 S MSG(5)="      Domain: "_$G(^XMB("NETNAME"))
 S MSG(6)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S MSG(7)="          By: "_$P($G(^VA(200,DUZ,0)),U,1)
 S MSG(8)=""
 S MSG(9)="Port number detected = "_PORT
 S MSG(10)=""
 S MSG(11)="Patch Version:  "_$S(+$G(XPDA):$G(^XPD(9.7,+$G(XPDA),2)),1:"Unknown Install File ien")
 ;
 ;Copy mesage to EPOR team
 S XMTO(DUZ)=""
 S XMTO("peter.hartley@domain.ext")=""
 S XMTO("eric.gustafson@domain.ext")=""
 S XMTO("cynthia.fawcett@domain.ext")=""
 S XMTO("bill.losey@domain.ext")=""
 S XMINSTR("FROM")="BPS.1.15.POST"
 ;
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 I '$D(^TMP("XMERR",$J)) G EMAILX    ; no email problems
 ;
 D MES^XPDUTL("MailMan reported a problem trying to send the notification message.")
 D MES^XPDUTL("  ")
 S (GLO,GLB)="^TMP(""XMERR"","_$J
 S GLO=GLO_")"
 F  S GLO=$Q(@GLO) Q:GLO'[GLB  D MES^XPDUTL("   "_GLO_" = "_$G(@GLO))
 D MES^XPDUTL("  ")
 ;
EMAILX ;
 Q
