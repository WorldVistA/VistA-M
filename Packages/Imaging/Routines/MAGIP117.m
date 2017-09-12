MAGIP117 ;WOIFO/NST,MLH - INSTALL CODE FOR MAG*3.0*117 ; 08 Feb 2011 10:57 AM
 ;;3.0;IMAGING;**117**;Mar 19, 2002;Build 2238;Jul 15, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
 ; There are no environment checks here but the MAGIP117 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
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
 ;--- Link new remote procedures to the Broker context option
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS",CALLBACK)<0  D ERROR  Q
 ;
 ;--- Restart the Imaging Utilization Report task
 I $$CP^MAGKIDS("MAG REPORT TASK","$$RPTSKCP^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Misc Updates
 I $$CP^MAGKIDS("MAG 117 MISC UPDATES ","$$UPDATE^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Send the notification e-mail
 I $$CP^MAGKIDS("MAG NOTIFICATION","$$NOTIFY^MAGKIDS1")<0  D ERROR  Q
 ;
 ;--- Set default for existing users to Show Deleted Image Placeholder
 D BMES^MAGKIDS("Setting Delete Image Placeholder to True")
 D DFTON
 ;--- Clean invalid (orphaned QA Statistics Nodes) from XTMP Reports.
 D BMES^MAGKIDS("Clearing orphaned QA Statistics from XTMP")
 D CLNXTMP^MAGGA03Q
 Q
 ;***** DFTON
 ; This will loop through existing users, and set the showdeletedImagePlaceholder 
 ; to 1 ON.
DFTON ;Set default for existing users to Show Deleted Image Placeholder
 N I
 S I=0
 F  S I=$O(^MAG(2006.18,I)) Q:'I  D
 . ; If the preference hasn't been set yet,  set it to 1.
 . I $P($G(^MAG(2006.18,I,"APPPREFS")),"^",9)="" S $P(^MAG(2006.18,I,"APPPREFS"),"^",9)=1
 . Q
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ;
 Q
 ;+++++ LIST OF NEW REMOTE PROCEDURES
 ; have a list in format ;;MAG4 IMAGE LIST
RPCLST ;
 ;;MAGG IMAGE STATISTICS BY USER 
 ;;MAGG IMAGE STATISTICS QUE 
 ;;MAGG MULTI IMAGE PRINT
 ;;MAGG JUKE BOX PATH
 Q 0
 ;
 ;+++++ RESTARTS THE IMAGING UTILIZATION REPORT TASK
RPTSKCP() ;
 D REMTASK^MAGQE4,STTASK^MAGQE4
 Q 0
 ;
UPDATE() ; Misc Updates
 N MAGRC
 ;--- Check if the file has been processed already
 I '$$PRD^MAGKIDS(2005.1,117) D  Q:MAGRC<0 MAGRC
 . S MAGRC=$$UPD20051^MAGGTUX4()
 . Q
 ;--- Check if the file has been processed already
 I '$$PRD^MAGKIDS(2005,117) D  Q:MAGRC<0 MAGRC
 . S MAGRC=$$UPD2005^MAGGTUX4()
 . Q
 ;
 ; Add a new entry to OBJECT TYPE file (#2005.02)
 I $$ADDOBJ(501,"NCAT") Q -1
 I $$ADDOBJ(502,"Unsupported Type From Non-VA Origin") Q -1
 I $$ADDOBJ(503,"DoD JPG") Q -1
 I $$ADDOBJ(504,"DoD Word") Q -1
 I $$ADDOBJ(505,"DoD ASCII Text") Q -1
 I $$ADDOBJ(506,"DoD PDF (non-NCAT)") Q -1
 I $$ADDOBJ(507,"DoD RTF") Q -1
 ;
 ;--- Allow installer to build ADTDUZ cross references if desired
 D SETUP^MAGUXDPS
 Q 0
 ;
ADDOBJ(IEN,NAME) ; Adds a record to OBJECT TYPE file (#2005.02)
 ; IEN - IEN in OBJECT TYPE file (#2005.02)
 ; NAME - value for field (#.01) in OBJECT TYPE file (#2005.02)
 N MAGNFDA,MAGNIEN,MAGNERR,IENS
 ;
 S IENS=$S('$D(^MAG(2005.02,IEN)):"+1,",1:IEN_",")
 S MAGNFDA(2005.02,IENS,.01)=NAME
 S MAGNIEN(1)=IEN
 D UPDATE^DIE("","MAGNFDA","MAGNIEN","MAGNERR")
 I $D(MAGNERR) Q -1
 Q 0
