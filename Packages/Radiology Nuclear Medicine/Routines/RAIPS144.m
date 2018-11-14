RAIPS144 ;WOIFO/KLM-Rad/NM Post-init Driver, patch 144;07 Mar 2018 3:25 PM
 ;;5.0;Radiology/Nuclear Medicine;**144**;Mar 16, 1998;Build 1
 ;Clean-up decommissioned HLO Application Registries for NTP
 ; RA-NTP-QRY-CLIENT
 ; RA-NTP-QRY-SERVER
 ; RA-NTP-QUERY
 ; RA-NTP-RSP
 ;
 ;Integration Agreements
 ;----------------------
 ; FIND^DIC           2051 (S)
 ; $$DELETE^HLOASUB1  6865 (P)
 ;
EN      ;Entry pt for post-install
 N RACHK
 ;
 ;Delete RA NTP HLO Application Registries
 S RACHK=$$NEWCP^XPDUTL("POST1","EN1^RAIPS144")
 ;
 Q
EN1 ;Post-install entry point
 N RAHLOAR,RAARY,RAI,RATXT,RADA,RAFILE,RADEL,RAERR
 S RAHLOAR="RA-NTP-",RAFILE=779.2
 D FIND^DIC(779.2,"","@;.01","P",RAHLOAR,"","","","","RAARY")
 I +RAARY("DILIST",0)>0 S RAI=0 F  S RAI=$O(RAARY("DILIST",RAI)) Q:RAI=""  D
 .S RAHLOAR=$G(RAARY("DILIST",RAI,0))
 .S RADA=$P(RAHLOAR,"^") Q:RADA=""
 .S RADEL=$$DELETE^HLOASUB1(RAFILE,RADA,.RAERR)
 .I $G(RAERR)="" S RATXT=$P(RAHLOAR,"^",2)_" deleted."
 .D MES^XPDUTL(RATXT)
 .Q
 Q
