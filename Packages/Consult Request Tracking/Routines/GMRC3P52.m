GMRC3P52 ;ALB/MRY - POST INIT ;04/14/06  
 ;;3.0;CONSULT/REQUEST TRACKING;**52**;DEC 27, 1997
 ;
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 I XPDABORT="" K XPDABORT
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S XPDABORT=2 Q
 ;
PRE ;Set seed flag, so, 'AHST' xref of the new Consult Link field (#688)
 ;of the Hospital Location file (#44) doesn't get set during install.
 S SDSEED=1
 Q
POST ;-------------------------------------------------------------------
 ;Add option to menu.
 N GMRCOK
 S GMRCOK=$$ADD^XPDMENU("GMRC REPORTS","GMRC RPT SD SCH-MGT CONSULTS","SH",6)
 D BMES^XPDUTL("*****")
 I GMRCOK=1 D
 .D MES^XPDUTL("Adding option 'Service Consults Schedule-Management Report'")
 .D MES^XPDUTL("               to 'Consult Tracking Reports' menu.")
 E  D
 .D MES^XPDUTL("Error - 'Service Consults Schedule-Management Report' option not added.")
 .D BMES^XPDUTL("*****")
 ;
 ;---------------------------------------------------------------------
 ;Post-init for sites running Class 3 software.
 ;
 ;Quit, if Class 3 field not installed.
 ;
 ;File 123.5
 ;   Loop down Class 3 ^GMR("AB" xref. to build new entries.
 ;   Sites can remove Class 3 field when satisfied of changes.
 ;
 ;---------------------------------------------------------------------
 ;Convert #123.5 Class 3 ASSOCIATED STOP CODE field and xrefs.
 I '$D(^GMR(123.5,"AB")),'$D(^XTMP("GMRC3P52")) Q  ;quit, no Class 3 data.
 D BMES^XPDUTL("*****")
 N GMRX,GMRDA,GMRSTOP,DIC
 ;Check/create ^XTMP for conversion run to completion.
 I $D(^XTMP("GMRC3P52")) D  I $G(GMRSTOP) G CONS
 . I $P($G(^XTMP("GMRC3P52",1)),U,2)="DONE" D
 .. S GMRSTOP=1
 .. D MES^XPDUTL("Conversion of Class III Associated Stop Codes already run to completion.")
 .. D MES^XPDUTL(" ")
 . E  S GMRX=+$P($G(^XTMP("GMRC3P52",1)),U)
 E  S ^XTMP("GMRC3P52",0)=$$FMADD^XLFDT(DT,90)_"^"_DT
 D MES^XPDUTL("...Moving File #123.5, ASSOCIATED STOP CODE (Class 3) field entries...")
 D MES^XPDUTL(" ")
 I $G(GMRX)']0 S GMRX=0
 F  S GMRX=$O(^GMR(123.5,"AB",GMRX)) Q:'GMRX  D
 . S GMRDA=0 F  S GMRDA=$O(^GMR(123.5,"AB",GMRX,GMRDA)) Q:'GMRDA  D
 .. ;check for duplicate.  FILE^DICN call will add duplicates.
 .. I +$O(^GMR(123.5,"AB1",GMRX,GMRDA,0)) Q
 .. K DIC("DR")
 .. S DA(1)=GMRDA
 .. S DIC="^GMR(123.5,"_DA(1)_",688,"
 .. S DIC(0)="L",DIC("P")=$P(^DD(123.5,688,0),"^",2)
 .. S DIC("DR")="688///"_GMRX
 .. S X=GMRX
 .. K D0 D FILE^DICN
 .. I Y=-1 Q
 .. S $P(^XTMP("GMRC3P52",1),U)=GMRX
 S $P(^XTMP("GMRC3P52",1),U,2)="DONE"
 ;
CONS ;---------------------------------------------------------------------
 ;Post-init for sites running Class 3 software.
 ;
 ;Quit, if Class 3 field not installed.
 ;
 ;File 44
 ;   Loop down Class 3 ^SC("AWAS" xref. to build new entries.
 ;---------------------------------------------------------------------
 ;
 ;Convert HOSPITAL LOCATION Class III CONSULT LINK field and xrefs.
 I '$D(^SC("AWAS")),'$D(^XTMP("SD53P478")) Q  ;quit, no Class 3 data
 N CNSLTLNK,SDC,SDT,SDY,DA,DIE,DR,SDSTOP
 ;Check/create ^XTMP for conversion run to completion.
 I $D(^XTMP("SD53P478")) D  I $G(SDSTOP) Q
 . I $P($G(^XTMP("SD53P478",1)),U,2)="DONE" D
 .. S SDSTOP=1
 .. D MES^XPDUTL("Conversion of Class III Consult Link entries already run to completion.")
 .. D MES^XPDUTL(" ")
 . E  S CNSLTLNK=+$P($G(^XTMP("SD53P478",1)),U)
 E  S ^XTMP("SD53P478",0)=$$FMADD^XLFDT(DT,90)_"^"_DT
 D MES^XPDUTL("...Moving File #44, CONSULT LINK (Class 3) field entries...")
 ;Loop down Class III CONSULT LINK "AWAS" xref (if exits).
 I $G(CNSLTLNK)']0 S CNSLTLNK=0
 F  S CNSLTLNK=$O(^SC("AWAS",CNSLTLNK)) Q:'CNSLTLNK  D
 .S SDC=0 F  S SDC=$O(^SC("AWAS",CNSLTLNK,SDC)) Q:'SDC  D
 ..S SDT=0 F  S SDT=$O(^SC("AWAS",CNSLTLNK,SDC,SDT)) Q:'SDT  D
 ...S SDY=0 F  S SDY=$O(^SC("AWAS",CNSLTLNK,SDC,SDT,SDY)) Q:'SDY  D
 ....;don't process if already exists (install rerun).
 ....Q:$D(^SC("AWAS1",CNSLTLNK,SDC,SDT,SDY))
 ....;create Class I CONSULT LINK field and xrefs.
 ....S DA(2)=SDC,DA(1)=SDT,DA=SDY
 ....S DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,",DR="688////^S X=CNSLTLNK"
 ....D ^DIE
 . S $P(^XTMP("SD53P478",1),U)=CNSLTLNK
 S $P(^XTMP("SD53P478",1),U,2)="DONE"
 ;move Class 3 'AHST' Consult history to new 'AHST1' xref.
 D MES^XPDUTL("  ....Restoring historical cross reference entries.")
 M ^SC("AHST1")=^SC("AHST")
 D BMES^XPDUTL("Class III Conversion Complete.")
 K SDSEED
 D BMES^XPDUTL("*****")
 ;
NOTIFY ;Send notification
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 I '$G(GMRSTOP),'$G(SDSTOP),($P($G(^XTMP("GMRC3P52",1)),U,2)="DONE"),($P($G(^XTMP("SD53P478",1)),U,2)="DONE") D
 . S XMDUZ="APPOINTMENT/CONSULT LINK"
 . S XMSUB="Class 3 Consults Conversion Complete"
 . S XMTEXT="^TMP(""GMRC3P52"",$J,"
 . S XMY(DUZ)=""
 . S ^TMP("GMRC3P52",$J,1)=" "
 . S ^TMP("GMRC3P52",$J,2)="The conversion of your ASSOCIATED STOP CODES and CONSULT LINK Class III entries"
 . S ^TMP("GMRC3P52",$J,3)="to the new Class I fields in patch SD*5.3*478 has successfully completed."
 . S ^TMP("GMRC3P52",$J,4)=" "
 . S ^TMP("GMRC3P52",$J,5)="After completely satified with you conversion, please follow the instructions"
 . S ^TMP("GMRC3P52",$J,6)="in the Patch Installation Guide for removing your Class III fields."
 . D ^XMD K ^TMP("GMRC3P52",$J),XMY
 Q
