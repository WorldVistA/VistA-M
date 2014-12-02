IBD3P63A  ;ALB/CFS - POST INSTALL ROUTINE FOR IBD*3*63 ;26-JUL-11
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 Q
 ;inactivate package interface entries
INACT ;
 N IBDIEN,IBDNAME,IBDNODE,DIE,DR,DA
 D MES^XPDUTL("Inactivating obsolete Problem List Package Interfaces:")
 S DIE=357.6,DR=".09////0"  ;Set "AVAILABLE?" .09 field equal to NO.
 S IBDIEN=0
 F  S IBDIEN=$O(^IBE(357.6,IBDIEN)) Q:'IBDIEN  D  ;
 .S IBDNODE=$G(^IBE(357.6,IBDIEN,0))
 .I $P(IBDNODE,U,3)="GMPLENFM" D  ;
 ..S IBDNAME=$P(IBDNODE,U)
 ..L +^IBE(357.6,IBDIEN):0 I '$T D MES^XPDUTL(IBDNAME_" Package Interface locked by another user. Unable to inactivate at this time.") Q
 ..S DA=IBDIEN
 ..D ^DIE
 ..K DA
 ..I '$D(DTOUT)!('$D(DUOUT)) D MES^XPDUTL(IBDNAME_" Package Interface has been deactivated.")
 ..L -^IBE(357.6,IBDIEN)
 ;
 Q
 ;
 ;Change name from DIAGNOSES (V2.1) to ICD-9 DIAGNOSES (V2.1).
ICD9NAME ;
 N IBDIEN,IBDNAME,IBDFOUND,IBDX,IBDPREV
 S IBDFOUND=0
 S IBDIEN=0
 S IBDPREV=0
 F  S IBDIEN=$O(^IBE(357.1,IBDIEN)) Q:'IBDIEN  D  ;
 .S IBDNAME=$P($G(^IBE(357.1,IBDIEN,0)),U)
 .I IBDNAME="ICD-9 DIAGNOSES (V2.1)" S IBDPREV=1
 .I IBDNAME="DIAGNOSES (V2.1)" D
 ..I IBDFOUND'=1 S IBDFOUND=1
 ..S IBDX=$$FILLFLDS^IBDUTIL1(357.1,.01,IBDIEN,"ICD-9 DIAGNOSES (V2.1)")
 I 'IBDFOUND D 
 . I IBDPREV=1 D MES^XPDUTL("DIAGNOSES (V2.1) block names were changed previously") Q
 . D MES^XPDUTL("Warning: DIAGNOSES (V2.1) block names were not changed to ICD-9 DIAGNOSES (V2.1).")
 I IBDFOUND D MES^XPDUTL("  Block names changed from 'DIAGNOSES (V2.1)' to 'ICD-9 DIAGNOSES (V2.1).")
 Q
 ;
 ;Change text on the INPUT DIAGNOSIS CODE (ICD9) record.
CHNG3576() ;
 N IBDIEN,IBDFLD
 S IBDIEN=$O(^IBE(357.6,"B","INPUT DIAGNOSIS CODE (ICD9)",""))
 I IBDIEN="" D MES^XPDUTL("Error: INPUT DIAGNOSIS CODE (ICD9) record was not found") Q 1
 S IBDFLD(18)="S IBDF(""OTHER"")=""80^I '$P(^(0),U,9)"" D LIST^IBDFDE2(.IBDSEL,.IBDF,""ICD-9 Diagnosis Code"")"
 S IBDRET=$$FILLFLDS^IBDUTIL1(357.6,18,IBDIEN,IBDFLD(18))
 I IBDRET<1 D MES^XPDUTL("Error: INPUT DIAGNOSIS CODE (ICD9) record text not changed from 'Diagnosis Code' to 'ICD-9 Diagnosis Code'.") Q 1
 D MES^XPDUTL("  INPUT DIAGNOSIS CODE (ICD9) record text changed from 'Diagnosis code' to 'ICD-9 Diagnosis Code")
 Q 0
 ;
 ; send a warning message and continue installation
NODEFAUL ;if DEFAULTS form was not found
 ;
 N DIFROM,XMSUB,XMTEXT,XMY,XMZ,XMMG,XMDUZ,IBDTXT
 ;
 ;the subject line
 S XMSUB="IBD*3*63 installation warning: The DEFAULTS form was not found"
 ;From:
 S XMDUZ="AICS PATCH IBD*3.0*63 INSTALLATION"
 ;the array to store the text of the e-mail
 S XMTEXT="IBDTXT("
 ;
 S IBDTXT=0 ;line counter
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)="   The DEFAULTS form was not found in the environment and therefore"
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)="the installation process didn't add the new ICD-10 block to the"
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)="DEFAULTS form."
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)="   Please log a Remedy ticket to add the DEFAULTS form to your AICS"
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)="environment if you need it."
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)="   When you have it in the environment you can use TK menu options"
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)="to add the ICD-10 block to the DEFAULTS form manually."
 S IBDTXT=IBDTXT+1,IBDTXT(IBDTXT,0)=""
 ;
 ;use user's DUZ to specify whom to send
 ;if it is not defined or this is a POSTMASETR then use DUZ=.5 to send to the POSTMASTER
 I $G(DUZ)'<1 S XMY(DUZ)="" E  S XMY(.5)=""
 ;send the e-mail
 D ^XMD
 ;
 Q
 ;
CHK10BLK(IBDFRIEN) ;check for ICD-10 block in the form
 N IBDBLIEN,IBDQ
 S (IBDQ,IBDBLIEN)=0
 F  S IBDBLIEN=$O(^IBE(357.1,"C",IBDFRIEN,IBDBLIEN)) Q:(+IBDBLIEN=0)!(IBDQ=1)  D
 . I $G(^IBE(357.1,IBDBLIEN,0))["ICD-10" S IBDQ=1
 Q IBDQ
 ;
 ;
CHK3576() ;check if the field #18 content was changed from ICD to ICD-9 previsouly 
 N IBDBLIEN,IBDQ
 S (IBDQ,IBDBLIEN)=0
 F  S IBDBLIEN=$O(^IBE(357.6,IBDBLIEN)) Q:(+IBDBLIEN=0)!(IBDQ=1)  D
 . I $G(^IBE(357.6,IBDBLIEN,18))["ICD-9" S IBDQ=1
 Q IBDQ
 ;IBD3P63A
