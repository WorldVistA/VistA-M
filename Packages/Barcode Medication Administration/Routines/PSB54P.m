PSB54P ;MNT/BJR - PSB*3*54 POST INSTALL; 7 April 2010  11:36 AM ; 9/5/13 9:37am
 ;;3.0;BAR CODE MED ADMIN;**54**;Mar 2004;Build 40
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 Q
PSTINSTL ;PSB*3*54 POST INSTALL ROUTINE
 N PSBMG,XMDUZ,XMSUB,XMTEXT,PSBUNMG,PSBMEMB,XMY,PSBMES
 S PSBMG=$$GET^XPAR("DIV","PSB MG ADMIN ERROR",,"E") Q:PSBMG=""
 S PSBMEMB=$$GOTLOCAL^XMXAPIG(PSBMG)
 I PSBMEMB=0  D
 .S PSBMES="*****PSB*3.0*54 has been installed and found that the UNKNOWN ACTIONS Mailgroup"  D  Q
 ..D BMES^XPDUTL(PSBMES)
 ..S PSBMES="listed in the BCMA PARAMETERS GUI has no active members. Please contact your"
 ..D MES^XPDUTL(PSBMES)
 ..S PSBMES="local BCMA Coordinator to add active members to this mailgroup.*****"
 ..D MES^XPDUTL(PSBMES)
 ..S XMSUB="NO ACTIVE MEMBERS IN UNKNOWN ACTIONS MAILGROUP"
 ..S XMDUZ=DUZ
 ..S XMTEXT="PSBUNMG"
 ..S XMY(DUZ)=""
 ..S PSBUNMG(1)="PSB*3.0*54 has been installed and found that the"
 ..S PSBUNMG(2)="UNKNOWN ACTIONS Mailgroup listed in the BCMA"
 ..S PSBUNMG(3)="PARAMETERS GUI has no active members. Please contact"
 ..S PSBUNMG(4)="your local BCMA Coordinator to add active members to"
 ..S PSBUNMG(5)="this mailgroup."
 ..D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY)
 Q
