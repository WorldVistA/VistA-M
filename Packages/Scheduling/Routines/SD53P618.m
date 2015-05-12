SD53P618 ;ALB/TXH - POST INIT ROUTINE FOR PATCH SD*5.3*618;Jul 22, 2014
 ;;5.3;Scheduling;**618**;Aug 13, 1993;Build 3
 ;
 ; This is the post-install for patch SD*5.3*618 to modify DESCRIPTION
 ; field (#10) of Appointment Type ORGAN DONORS in APPOINTMENT TYPE
 ; file (#409.1).
 Q
 ;
EN ; Entry point
 N SDFILE,SDFLD,SDTYPE
 S SDFILE=409.1,SDFLD=10,SDTYPE="ORGAN DONORS"
 D BMES^XPDUTL("SD*5.3*618 Post Installation -- ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Update to APPOINTMENT TYPE file (#"_SDFILE_").")
 I '$D(^SD(SDFILE)) D BMES^XPDUTL("Missing file "_SDFILE_".")
 I $D(^SD(SDFILE)) D ACT
 Q
 ;
ACT ; Add new text
 N SDIEN,SDLINE,SDX
 I '$D(^SD(SDFILE,"B",SDTYPE)) D MISSMSG Q
 S SDIEN=$O(^SD(SDFILE,"B",SDTYPE,""))
 I '$D(^SD(SDFILE,SDIEN,0)) D MISSMSG Q
 F SDX=1:1 S SDLINE=$P($T(SDTXT+SDX),";;",2) Q:SDLINE="QUIT"  D
 . S SD(SDX,0)=SDLINE
 S SDIEN=SDIEN_","
 D WP^DIE(SDFILE,SDIEN,SDFLD,"K","SD","ERR")
 ; Display error messages if unsuccessful
 I $D(ERR) D  Q
 . S SDX="ERR" F  S SDX=$Q(@SDX) Q:SDX=""  D
 . . D BMES^XPDUTL(SDX)
 . . D MES^XPDUTL(@SDX)
 . D BMES^XPDUTL("*** Warning - DESCRIPTION field of")
 . D MES^XPDUTL("               Appointment Type "_SDTYPE_", file #409.1")
 . D MES^XPDUTL("               could not be modified.")
 . D BMES^XPDUTL(" Please contact the PIMS NATIONAL VISTA SUPPORT Team.")
 . D MES^XPDUTL("                 for assistance.")
 D BMES^XPDUTL("DESCRIPTION of Appointment Type "_SDTYPE_" successfully modified.")
 D MES^XPDUTL(" ")
 ;
 K ERR,SD,SDIEN,SDLINE,SDX
 Q
 ;
MISSMSG ; Missing messages
 D BMES^XPDUTL("Missing Appointment Type ORGAN DONORS in file #409.1...")
 D MES^XPDUTL("Please contact the PIMS NATIONAL VISTA SUPPORT Team.")
 Q
 ;
SDTXT ; New text for DESCRIPTION field
 ;;Exam of a veteran or non-veteran who wishes to be an organ 
 ;;donor to determine if organ designated will be useable.
 ;;QUIT
