MAGIP81 ;Post init routine to queue site activity at install.
 ;;3.0;IMAGING;**81**;May 17, 2007
 ;;  Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed             |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
PRE ;
 ; Remove RPC so that it installs cleanly
 D RMRPC("MAGQ VOK")
 Q
POST ;
 D BMES^XPDUTL("Updating MAG WINDOWS: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDRPC^MAGQBUT4("MAGQ VOK","MAG WINDOWS")
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
RMRPC(NAME) ; Removing an RPC in order to revise
 N MW,RPC,MWE,DIERR
 S MW=$$FIND1^DIC(19,"","X","MAG WINDOWS","","","")
 D CLEAN^DILF
 Q:'MW
 S RPC=$$FIND1^DIC(8994,"","X",NAME,"","","")
 D CLEAN^DILF
 Q:'RPC
 S MWE=$$FIND1^DIC(19.05,","_MW_",","X",NAME,"","","")
 D CLEAN^DILF
 Q:'MWE
 S DA=MWE,DA(1)=MW,DIK="^DIC(19,"_DA(1)_",""RPC"","
 D ^DIK
 K DA,DIK
 S DA=RPC,DIK="^XWB(8994,"
 D ^DIK
 K DA,DIK
 Q
 ;
