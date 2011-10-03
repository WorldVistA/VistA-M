IVMUM7 ;ALB/SEK,RTK - DELETE IVM MEANS TEST ; 23 JUNE 00
 ;;2.0;INCOME VERIFICATION MATCH;**1,17,31**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will process an IVM means test delete request
 ; from the IVM Center.
 ;
 ; delete IVM mean test records in the following files:
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
 .S HLERR="IVM means test for income year "_($E(DGLY,1,3)+1700)_" not found"
 .D ACK^IVMPREC
 ;
 ; get VAMC mt
 S IVMVAMC=0 ; ivmvamc is vamc ien
 F  S IVMVAMC=$O(^DGMT(408.31,"AD",1,DFN,IVMMTDT,IVMVAMC)) Q:'IVMVAMC  D  Q:$D(IVMVNO)
 .S IVMVNO=$G(^DGMT(408.31,+IVMVAMC,0)) ; vamc 0th node
 .S IVMSOT=$P($G(^DG(408.34,+$P(IVMVNO,"^",23),0)),"^") ; source of test
 .I IVMSOT'="VAMC",IVMSOT'="DCD",IVMSOT'="OTHER FACILITY" K IVMVNO Q
 I '$D(IVMVNO) D  Q
 .S HLERR=IVMSOT_" means test for income year "_($E(DGLY,1,3)+1700)_" not found"
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
 D SETUPAR^IVMUM8
 ;
 ; no "AIVM" x-ref means
 ;   no dependents
 ;       or
 ;   IVM v2.0 means test (no dependent difference)
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
 .D EN^IVMUM8
 .Q
 ;
 Q:$D(IVMFERR)
 D EN1^IVMUM8
 Q
