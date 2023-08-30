WEBG013P ; SLC/JAS - WEBG*3*13 Post Init Routine; May 2, 2023@17:00 PM
 ;;3.0;WEB VISTA REMOTE ACCESS MANAGEMENT;**13**;Apr 06, 2021;Build 1
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;  File #19.05 updates - Covered by Supported ICR# 10075
 ;
 Q
 ;
POST ; Post-Installation Process 
 ;
 ;;; Update OPTION (#19) file
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL(">>> Updating the WEBG WEBVRAM GUI option.")
 D MES^XPDUTL("")
 ;
 ; Verify that the WEBG WEBVRAM GUI option exists
 ;
 N ADDERR,OPTIEN,RPCNAME,UPERR
 S OPTIEN=$O(^DIC(19,"B","WEBG WEBVRAM GUI",0))
 I 'OPTIEN D  Q
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** There has been an issue identifying the WEBG WEBVRAM GUI Option.")
 . D MES^XPDUTL("      This patch may need to be re-installed at a later time.")
 ;
 ; Attempt to add RPC(s) to WEBG WEBVRAM GUI option
 ;
 S UPERR=0
 F RPCNAME="WEBG GMRV VERSRV" D ADDRPC(.ADDERR,OPTIEN,RPCNAME) I ADDERR S UPERR=1
 ;
 I UPERR D  Q
 . D MES^XPDUTL("")
 . D MES^XPDUTL("")
 . D MES^XPDUTL("        *** The issues referenced above need to be addressed. ***")
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL(">>> Updates to the WEBG WEBVRAM GUI have completed successfully. <<<")
 ;
ADDRPC(ADDERR,OPTIEN,RPCNAME) ;Add RPC(s) to the WEBG WEBVRAM GUI Option
 N FDA,FDAERR,RPCIEN
 S ADDERR=0
 ;
 ; Verify that the RPC is valid
 ;
 I '$D(^XWB(8994,"B",RPCNAME)) D  Q
 . S ADDERR=1
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** RPC "_RPCNAME_" does not exist and cannot be added")
 . D MES^XPDUTL("      to the WEBG WEBVRAM GUI Option.")
 ;
 S RPCIEN=$O(^XWB(8994,"B",RPCNAME,0))
 I 'RPCIEN D  Q
 . S ADDERR=1
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** There has been an issue identifying the "_RPCNAME_" RPC.")
 . D MES^XPDUTL("      This patch may need to be re-installed at a later time.")
 ;
 ; Attempt to register the RPC to the WEBG WEBVRAM GUI context
 ;
 I $D(^DIC(19,OPTIEN,"RPC","B",RPCIEN)) D  Q
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** RPC "_RPCNAME_" is already registered to WEBG WEBVRAM GUI.")
 ;
 S ADDERR=0
 S FDA(19.05,"+1,"_OPTIEN_",",.01)=RPCIEN
 D UPDATE^DIE(,"FDA",,"FDAERR") K FDA
 ;
 I $D(FDAERR) D  Q
 . S ADDERR=1
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** There was an issue adding RPC "_RPCNAME_" to")
 . D MES^XPDUTL("     WEBG WEBVRAM GUI context. It may need to be added manually.")
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL(">> RPC "_RPCNAME_" has been successfully registered to WEBG WEBVRAM GUI.")
 Q
