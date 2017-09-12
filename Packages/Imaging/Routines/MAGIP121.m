MAGIP121 ;WOIFO/NST/GEK - INSTALL CODE FOR MAG*3.0*121 ; 22 Feb 2011 12:32 PM
 ;;3.0;IMAGING;**121**;Mar 19, 2002;Build 2340;Oct 20, 2011
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
 ; There are no environment checks here but the MAGIP121 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
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
 ;--- Link new remote procedures to the Broker context option
 ;S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 ;I $$CP^MAGKIDS("MAG ATTACH RPCS",CALLBACK)<0  D ERROR  Q
 ;
 ;--- Restart the Imaging Utilization Report task
 I $$CP^MAGKIDS("MAG REPORT TASK","$$RPTSKCP^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Misc Updates
 ;I $$CP^MAGKIDS("MAG 121 MISC UPDATES ","$$UPDATE^"_$T(+0))<0  D ERROR Q
 ;
 ;--- Send the notification e-mail
 I $$CP^MAGKIDS("MAG NOTIFICATION","$$NOTIFY^MAGKIDS1")<0  D ERROR  Q
 ;
 ;--- Adding new Reason to the MAG REASONS file for 'Rescinded TIU Note'.
 D BMES^MAGKIDS("Adding new Reason to the MAG REASONS file.")
 D ADDREAS
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
 ;+++++ LIST OF NEW REMOTE PROCEDURES
 ; have a list in format ;;MAG4 IMAGE LIST
RPCLST ;
 ;
 Q 0
 ;
 ;+++++ RESTARTS THE IMAGING UTILIZATION REPORT TASK
RPTSKCP() ;
 D REMTASK^MAGQE4,STTASK^MAGQE4
 Q 0
 ;
 ;+++++ Adds an entry to the MAG REASON File (#2005.88)
ADDREAS ; Add new entry "Rescinded TIU Note"
 ; NAME - value for field (#.01) MAG REASON File (#2005.88)
 N MAGFDA,MAGERR,MAGWP,REASON,MAGCODE
 S REASON="Rescinded TIU Note"
 ; Quit if already exist.
 I $D(^MAG(2005.88,"B",REASON)) Q
 S MAGWP(1)="The TIU Note has been Rescinded." ; 
 S MAGFDA(2005.88,"+1,",.01)=REASON
 S MAGFDA(2005.88,"+1,",.02)="SD" ; Status and Deleted 
 S MAGFDA(2005.88,"+1,",1)="MAGWP"
 S MAGCODE=$P(^MAG(2005.88,0),"^",3)+1
 S MAGFDA(2005.88,"+1,",.04)=MAGCODE
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 I $D(MAGERR) D
 . D BMES^MAGKIDS("Error creating new MAG REASON entry")
 . Q
 Q
