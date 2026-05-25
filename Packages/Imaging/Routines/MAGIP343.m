MAGIP343 ;WOIFO/JSL/MKN - Install code for MAG*3.0*343 ; Mar 21, 2023@10:58:35
 ;;3.0;IMAGING;**343**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; There are no environment checks here but the MAGIP343 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 ;
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10141 reference $$BMES^XPDUTL function call
 ; Supported IA #2053 reference FILE^DIE
 ;
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 D UPDATE
 D URL
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
UPDATE ; Add ELIGIBILITY/VA FORM 20-0986/10-0383" to the IMAGE INDEX FOR TYPES file (#2005.83)
 ;NOTE: Code contains hard sets to file #2005.83 because the file cannot be updated by FileMan due to
 ; a LAYGO TEST that can never be true (Authorized by the VA DBA)
 N DIK,MAG0,MAG3,MAG4,MAGFILE,MAGIEN,MAGIENCL,MAGNEW
 S MAGNEW="ELIGIBILITY/VA FORM 20-0986/10-0383",MAGFILE="IMAGE INDEX FOR TYPES file (#2005.83)"
 D BMES^XPDUTL("Checking for existence of form "_MAGNEW_" in the "_MAGFILE)
 S MAGIEN=$O(^MAG(2005.83,"B",MAGNEW,""))
 I MAGIEN D BMES^XPDUTL("Form "_MAGNEW_" already in "_MAGNEW_".") Q
 ;Add the new record to file #2005.83
 ;Find IEN of class "ADMIN" in IMAGE INDEX FOR CLASS file (#2005.82) 
 S MAGIENCL=$O(^MAG(2005.82,"B","ADMIN",""))
 I 'MAGIENCL D  Q
 . D BMES^XPDUTL("Unable to find the ""ADMIN"" class in the IMAGE INDEX FOR CLASS FILE (#2005.82)")
 . D BMES^XPDUTL("Unable to add form "_MAGNEW_" in "_MAGFILE)
 D BMES^XPDUTL("Adding "_MAGNEW_" to "_MAGFILE)
 S DIK="^MAG(2005.83," D IXALL2^DIK
 S MAG0=^MAG(2005.83,0),MAG3=$P(MAG0,U,3)+1,MAG4=$P(MAG0,U,4)+1
 S ^MAG(2005.83,MAG3,0)=MAGNEW_U_MAGIENCL_U_"A",^MAG(2005.83,MAG3,1)="20-0986"
 S $P(MAG0,U,3)=MAG3,$P(MAG0,U,4)=MAG4,^MAG(2005.83,0)=MAG0
 D BMES^XPDUTL("Reindexing "_MAGFILE)
 S DIK="^MAG(2005.83," D IXALL^DIK
 D BMES^XPDUTL("Form "_MAGNEW_" added to the "_MAGFILE)
 Q
 ;
URL ; update URL for Capture User Guide
 N MAGFILE,MAGIEN,MAGNEW,MAGURL
 S MAGURL="https://www.domain.ext/vdl/documents/Clinical/Vista_Imaging_Sys/mag_capture_user_manual.pdf"
 S MAGNEW="#76 CAPTURE HELP URL",MAGFILE="#2006.1 IMAGING SITE PARAMETERS",MAGIEN=0
 D BMES^XPDUTL("Updating field "_MAGNEW_" in file "_MAGFILE)
 S MAGIEN=$O(^MAG(2006.1,MAGIEN)) Q:MAGIEN=""  D
 .;I '$D(^MAG(2006.1,MAGIEN,"HELPC")) D BMES^XPDUTL("No data in "_MAGNEW_" in "_MAGFILE_" for entry#:  "_MAGIEN) Q
 .;Change the existing URL to:  https://www.domain.ext/vdl/documents/Clinical/Vista_Imaging_Sys/mag_capture_user_manual.pdf
 .D BMES^XPDUTL("Adding/Updating field "_MAGNEW_" for entry#:  "_MAGIEN)
 .S ^MAG(2006.1,MAGIEN,"HELPC")=MAGURL
 D BMES^XPDUTL("All "_MAGNEW_" fields in "_MAGFILE_" changed to:  "_MAGURL)
 Q
 ;
