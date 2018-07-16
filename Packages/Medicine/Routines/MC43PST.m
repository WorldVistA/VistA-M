MC43PST ;ALB/JAM - MEDICINE RHEUMATOLOGY OPTIONS ;3/5/13  12:45
 ;;2.3;Medicine;**43**;09/13/1996;Build 8
 ;
 ;This post install routine(s) will place the Rheumatology menu option, 
 ;"Line Enter/Edit" and its sub-menu options out of order.
 ;
EN ;Patch entry point
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTREQ,ZTSAVE
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("This patch places the Rheumatology menu option, Line Enter/Edit Menu[MCRHMENULIN]")
 D MES^XPDUTL("and its sub-menu options out of order.")
 D MES^XPDUTL(" ") H 2
 D OUT^XPDMENU("MCRHMENULIN","OUT OF ORDER")
 D OUT^XPDMENU("MCRHDIAGL","OUT OF ORDER")
 D OUT^XPDMENU("MCRHNARRL","OUT OF ORDER")
 D OUT^XPDMENU("MCRHHAQL","OUT OF ORDER")
 D OUT^XPDMENU("MCRHPATHISTL","OUT OF ORDER")
 D OUT^XPDMENU("MCRHPHYSL","OUT OF ORDER")
 D OUT^XPDMENU("MCRHDEATHL","OUT OF ORDER")
 D OUT^XPDMENU("MCRHBRIEF","OUT OF ORDER")
 Q
