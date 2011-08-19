EASUM7 ;ALB/GN,EG - DELETE IVM MEANS TEST ; 07/07/2006
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**42,74**;21-OCT-94;Build 6
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;EAS*1*42 This routine patterned after IVMUM7.
 ;
EN ; this routine will process an IVM MT/CT delete request
 ; from the IVM Center.
 ;
 ; delete IVM MT/CT records in the following files:
 ;     408.22
 ;     408.21
 ;
 ;     408.12 & 408.13 if IVM dependent
 ;               or
 ;     408.1275 if IVM & VAMC dependent (new 408.1275 record was
 ;              created for each IVM dependent by upload). 
 ;              change back the following fields to VAMC values
 ;              from IVM values:
 ;                 408.12  - relationship
 ;                 408.13  - name, dob, ssn, sex
 ;               or
 ;     408.1275 if VAMC dependent (new inactivated 408.1275 record
 ;              was created by upload).
 ;
 ;     408.31
 ;
 ; the "PRIM" node for the VAMC MT will be changed to 1 
 ;
 ; the event driver will be called twice
 ;    DGMTACT="DUP"
 ;    DGMTACT="DEL"
 ;
 ;
 ;     Input       IVMMTDT      MT date
 ;                 IVMMTIEN     primary MT IEN
 ;
 ; check primary test is IVM
 S IVMNO=$G(^DGMT(408.31,IVMMTIEN,0)) ; ivm mt 0th node  
 S IVMSOT=$P($G(^DG(408.34,+$P(IVMNO,"^",23),0)),"^") ; source of test
 I IVMSOT'="IVM" D  Q
 .S HLERR="IVM "_^DG(408.33,DGMTYPT,0)_" for income year "_($E(DGLY,1,3)+1700)_" not found"
 .D ACK^IVMPREC
 ;
 ; get VAMC MT/CT via AD xref (by type) to be re-instated    ;EAS*1*42
 S IVMVAMC="A" ; ivmvamc is vamc ien
 ;make sure you get the latest test of that type for that date first
 F  S IVMVAMC=$O(^DGMT(408.31,"AD",DGMTYPT,DFN,IVMMTDT,IVMVAMC),-1) Q:'IVMVAMC  D  Q:$D(IVMVNO)
 . S IVMVNO=$G(^DGMT(408.31,+IVMVAMC,0)) ; vamc 0th node
 . S IVMSOT=$P($G(^DG(408.34,+$P(IVMVNO,"^",23),0)),"^") ; source of test
 . I IVMSOT'="VAMC",IVMSOT'="DCD",IVMSOT'="OTHER FACILITY" K IVMVNO Q
 . Q
 ;
 ; if no previous VAMC RXCT (type 2) on file, then          ;EAS*1*42
 ; simply delete the IVM RX converted 408.31 record
 I '$D(IVMVNO),DGMTYPT=2 D EN1^EASUM8 Q
 ;
 ; if no VAMC MT type 1, then error
 I '$D(IVMVNO) D  Q
 .S HLERR=IVMSOT_^DG(408.33,DGMTYPT,0)_" for income year "_($E(DGLY,1,3)+1700)_" not found"
 .D ACK^IVMPREC
 ;
 ; get array dginc containing ien(s) of 408.21
 ; get array dginr containing ien(s) of 408.22
 D ALL^DGMTU21(DFN,"VSC",IVMMTDT,"IR",IVMMTIEN)
 ;
 ; delete 408.22
 ;
 S DA=$G(DGINR("V")) D
 .Q:'DA  S DIK="^DGMT(408.22," D ^DIK
 S DA=$G(DGINR("S")) D
 .Q:'DA  S DIK="^DGMT(408.22," D ^DIK
 S IVMN=0
 F  S IVMN=$O(DGINR("C",IVMN)) Q:'IVMN  S DA=$G(DGINR("C",IVMN)),DIK="^DGMT(408.22," D ^DIK
 ;
 ; delete 408.21
 ;
 S DA=$G(DGINC("V")) D
 .Q:'DA  S DIK="^DGMT(408.21," D ^DIK
 S DA=$G(DGINC("S")) D
 .Q:'DA  S DIK="^DGMT(408.21," D ^DIK
 S IVMN=0
 F  S IVMN=$O(DGINC("C",IVMN)) Q:'IVMN  S DA=$G(DGINC("C",IVMN)),DIK="^DGMT(408.21," D ^DIK
 ;
 ; logic for 408.12/408.1275 & 408.13
 ;
 D SETUPAR^EASUM8
 ;
 ; no "AIVM" x-ref means
 ;   no dependents
 ;       or
 ; IVM v2.0 means test (no dependent difference)
 ; only 408.22, 408.21, and 408.31 records will be deleted
 ;
 S IVM12="" F  S IVM12=$O(^DGPR(408.12,"AIVM",IVMMTIEN,IVM12)) Q:'IVM12  D  Q:$D(IVMFERR)
 .I $G(^DGPR(408.12,+IVM12,0))']"" D  Q
 ..S (IVMTEXT(6),HLERR)="Can't find 408.12 record "_IVM12
 ..D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 ..S IVMFERR=""
 ..D ACK^IVMPREC
 ..Q
 .;
 .I $P($G(^DGPR(408.12,+IVM12,"E",0)),"^",4)=1 D  Q
 ..; only 1 multiple record (408.1275) indicates IVM dependent
 ..; delete 408.12 & 408.13 records for IVM dependent
 ..S IVM13=$P($P($G(^DGPR(408.12,+IVM12,0)),"^",3),";") I $G(^DGPR(408.13,+IVM13,0))']"" D  Q
 ...S (IVMTEXT(6),HLERR)="Can't find 408.13 record "_IVM13
 ...D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 ...S IVMFERR=""
 ...D ACK^IVMPREC
 ...Q
 ..S DA=IVM12,DIK="^DGPR(408.12," D ^DIK K DA,DIK
 ..S DA=IVM13,DIK="^DGPR(408.13," D ^DIK K DA,DIK
 ..Q
 .;
 .; delete 408.1275 record for IVM dependent and
 .; change demo data in 408.12 & 408.13 back to VAMC values
 .;       or
 .; delete 408.1275 record for inactivated VAMC dependent
 .S IVM121="",IVM121=$O(^DGPR(408.12,"AIVM",IVMMTIEN,+IVM12,IVM121))
 .I $G(^DGPR(408.12,+IVM12,"E",+IVM121,0))']"" D  Q
 ..S (IVMTEXT(6),HLERR)="Can't find 408.1275 record "_IVM12_"  "_IVM121
 ..D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 ..S IVMFERR=""
 ..D ACK^IVMPREC
 ..Q
 .S IVMVAMCA=$P(^(0),"^",2) ; dependent active?
 .S DA(1)=IVM12,DA=IVM121,DIK="^DGPR(408.12,"_DA(1)_",""E"","
 .D ^DIK K DA(1),DA,DIK
 .Q:'IVMVAMCA  ; quit if inactivated VAMC dependent 
 .S IVM13=+$P($P($G(^DGPR(408.12,+IVM12,0)),"^",3),";")
 .D EN^EASUM8
 .Q
 ;
 Q:$D(IVMFERR)
 D EN1^EASUM8
 Q
 ;
ERRBULL ; build mail message for transmission to IVM mail group notifying site
 ; of upload error.
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="IVM - MEANS TEST UPLOAD"
 S IVMTEXT(1)="The following error occured when an Income Verification Match"
 S IVMTEXT(2)="verified Means Test was being uploaded for the following patient:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="    NAME:     "_$P(IVMPAT,"^")
 S IVMTEXT(5)="    ID:       "_$P(IVMPAT,"^",2)
 S IVMTEXT(6)="    ERROR:    "_IVMTEXT(6)
 Q
 ;
MTBULL ; build mail message for transmission to IVM mail group notifying them
 ; an IVM verified MT/CT has been uploaded into DHCP for a patient.
 ;
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="IVM - INCOME TEST UPLOAD for "_$P($P(IVMPAT,"^"),",")_" ("_$P(IVMPAT,"^",3)_")"
 S IVMTEXT(1)="An Income Verification Match verified "
 S IVMTEXT(1)=IVMTEXT(1)_^DG(408.33,DGMTYPT,0)_" has been uploaded"
 S IVMTEXT(2)="for the following patient:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="  NAME:           "_$P(IVMPAT,"^")
 S IVMTEXT(5)="  ID:             "_$P(IVMPAT,"^",2)
 S Y=IVMMTDT X ^DD("DD")
 S IVMTEXT(6)="  DATE OF TEST:   "_Y
 ;set previous sts from previous 408.31 or previous RX sts
 S IVMTEXT(7)="  PREV CATEGORY:  "
 I DGMTYPT=2 D
 . S IVMTEXT(7)=IVMTEXT(7)_IVMCEB
 E  D
 . S IVMTEXT(7)=IVMTEXT(7)_$P($G(^DG(408.32,+$P(IVMMT31,"^",3),0)),"^",1)
 ;
 S IVMTEXT(8)="  NEW CATEGORY:   "_DGCAT
 I IVM5 S Y=IVM5 X ^DD("DD") S IVMTEXT(9)="  DATE/TIME OF ADJUDICATION:  "_Y
 Q
