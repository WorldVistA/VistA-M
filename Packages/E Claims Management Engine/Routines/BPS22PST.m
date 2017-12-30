BPS22PST ;AITC/PD - Post-install for BPS*1.0*22 ;5/10/2017
 ;;1.0;E CLAIMS MGMT ENGINE;**22**;JUN 2004;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ; Post-install functions are coded here.
 ;
 D MES^XPDUTL("  Starting post-install of BPS*1.0*22")
 D AUTOREV
 D BMES^XPDUTL("  Finished post-install of BPS*1.0*22")
 Q
 ;
AUTOREV ; Update AUTO-REVERSAL PARAMETER in BPS PHARMACIES
 ;
 ; If existing value is nil or outside of inclusive range 3-10 set value to 5.
 ;
 N BPSAR,BPSARP,BPSIEN,CNT,DA,DIE,DR
 ;
 D BMES^XPDUTL("   Updating AUTO-REVERSAL PARAMETERs")
 ;
 S CNT=0
 S BPSIEN=0 F  S BPSIEN=$O(^BPS(9002313.56,BPSIEN)) Q:BPSIEN'?1N.N  D
 . S BPSARP=$P($G(^BPS(9002313.56,BPSIEN,0)),U,9)
 . I (BPSARP="")!(BPSARP<3)!(BPSARP>10) D
 . . S DIE=9002313.56,DA=BPSIEN,DR=".09////5"
 . . D ^DIE
 . . S BPSAR(BPSIEN)=BPSARP_U_$$NOW^XLFDT
 . . S CNT=CNT+1
 ;
 I $D(BPSAR) D MAIL(.BPSAR)
 ;
 D MES^XPDUTL("    - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with updating AUTO-REVERSAL PARAMETERs")
 ;
 Q
 ;
MAIL(BPSAR) ; Generate MailMan E-Mail
 ;
 N BPSARP,BPSDT,BPSIEN,BPSL,BPSNAME,BPSSITE,BPSX,USR,XMDUZ,XMSUB,XMTEXT,XMY
 ;
 S BPSSITE=$$SITE^VASITE()         ; IA 10112
 ;
 S BPSL=0
 S BPSL=BPSL+1,BPSX(BPSL)="VistA patch BPS*1.0*22 was successfully installed at your site."
 S BPSL=BPSL+1,BPSX(BPSL)=" "
 ;
 S BPSIEN=""
 F  S BPSIEN=$O(BPSAR(BPSIEN)) Q:BPSIEN=""  D
 . S BPSARP=$P($G(BPSAR(BPSIEN)),U)
 . S BPSDT=$P($G(BPSAR(BPSIEN)),U,2)
 . S BPSNAME=$P($G(^BPS(9002313.56,BPSIEN,0)),U,1)
 . S BPSL=BPSL+1,BPSX(BPSL)="        Name: "_BPSNAME
 . S BPSL=BPSL+1,BPSX(BPSL)="    Station#: "_$P(BPSSITE,U,3)
 . S BPSL=BPSL+1,BPSX(BPSL)="   Date/Time: "_$$FMTE^XLFDT(BPSDT,"5ZPM")
 . S BPSL=BPSL+1,BPSX(BPSL)="          By: "_$P($G(^VA(200,DUZ,0)),U,1)
 . S BPSL=BPSL+1,BPSX(BPSL)=" "
 . S BPSL=BPSL+1,BPSX(BPSL)="The ePharmacy Auto-Reversal Parameter has been changed at your site."
 . S BPSL=BPSL+1,BPSX(BPSL)="     Previous Value: "_BPSARP
 . S BPSL=BPSL+1,BPSX(BPSL)="          New Value: 5"
 . S BPSL=BPSL+1,BPSX(BPSL)=" "
 ;
 S BPSL=BPSL+1,BPSX(BPSL)="The Auto-Reversal Parameter can be changed using option Edit ECME Pharmacy"
 S BPSL=BPSL+1,BPSX(BPSL)="Data."
 S BPSL=BPSL+1,BPSX(BPSL)=" "
 S BPSL=BPSL+1,BPSX(BPSL)="ECME uses the AUTO-REVERSE site parameter when determining whether non-released"
 S BPSL=BPSL+1,BPSX(BPSL)="prescription claims (that have returned a PAYABLE response) are to be"
 S BPSL=BPSL+1,BPSX(BPSL)="automatically REVERSED."
 S BPSL=BPSL+1,BPSX(BPSL)=" "
 S BPSL=BPSL+1,BPSX(BPSL)="The AUTO-REVERSE site parameter is set for the number of days that ECME will"
 S BPSL=BPSL+1,BPSX(BPSL)="wait before the claim is automatically REVERSED. The user is allowed to enter"
 S BPSL=BPSL+1,BPSX(BPSL)="a number from 3 to 10. 5 is the suggested setting. ECME will wait the"
 S BPSL=BPSL+1,BPSX(BPSL)="entered number of days before REVERSING the non-released RX with a PAYABLE"
 S BPSL=BPSL+1,BPSX(BPSL)="payer returned response."
 ;
 S XMSUB="ePharmacy Auto-Reversal Parameter Change: BPS*1.0*22 "
 S XMSUB=XMSUB_$P(BPSSITE,U,3)_" #"_$P(BPSSITE,U,2)
 S XMDUZ="BPS Patch*1.0*22"
 S XMTEXT="BPSX("
 ; Define Recipients of Email - Recipients Include:
 ; Installer of Patch
 ; Holders of PSO EPHARMACY SITE MANAGER Key
 ; Gregory Laird (production only)
 ; Select team members (production only)
 S XMY(DUZ)=""
 S USR=0 F  S USR=$O(^XUSEC("PSO EPHARMACY SITE MANAGER",USR)) Q:USR=""  S XMY(USR)=""
 I $$PROD^XUPROD(1) D
 . S XMY("Gregory.Laird@domain")=""
 . S XMY("Mark.Dawson3@domain")=""
 . S XMY("Christine.Bullis@domain")=""
 . S XMY("Paul.Devine@domain")=""
 ; When invoking ^XMD in pre/post-init routine of Kernel Installation and
 ; Distribution System (KIDS) build, the calling routine must NEW the DIFROM variable
 ; Otherwise, your message will not be delivered.
 N DIFROM
 D ^XMD                 ; IA# 10070
 ;
 Q
