DG531139P ;BIR/JFW - DG*5.3*1139 Post-Init ;1 Jan 2025  10:13 AM
 ;;5.3;Registration;**1139**;Aug 13, 1993;Build 2
 ;
 ;BMES^XPDUTL and MES^XPDUTL - DBIA #10141 Supported
 ;
 ;STORY VAMPI-27523 (jfw) - Allow Deletion of PREFERRED NAME (#.2405)
 ;                          in the PATIENT (#2) file.
 ;
POST ;
 D BMES^XPDUTL("Post-Install: Starting")
 K ^DD(2,.2405,"DEL")
 D BMES^XPDUTL("    - Deleted Data Dictionary 'DEL' array node on")
 D MES^XPDUTL("      PREFERRED NAME (#.2405) field in the PATIENT (#2) file!")
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
