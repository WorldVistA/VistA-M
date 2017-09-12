MAGIPS94  ;WOIFO/NST - INSTALL CODE FOR MAG*3.0*94 ; 04 May 2010 1:44 PM
 ;;3.0;IMAGING;**94**;Mar 19, 2002;Build 1744;May 26, 2010
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
 ; There are no environment checks here but the MAGIPS94 has to be
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
 ;S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 ;I $$CP^MAGKIDS("MAG ATTACH RPCS",CALLBACK)<0  D ERROR  Q
 ;
 ;--- Enable version checking for all sites
 I $$CP^MAGKIDS("MAG VERSION CHECK","$$VERCHKON^MAGKIDS1")<0  D ERROR  Q
 D MES^MAGKIDS("")
 D MES^MAGKIDS("When Patch 94 is released : ")
 D MES^MAGKIDS("Version Checking can NOT BE TURNED OFF.")
 D MES^MAGKIDS("Only Imaging Clients running Patch 72, Patch 93, or Patch 94 are acceptable.")
 D MES^MAGKIDS("")
 D MES^MAGKIDS("IMAGING CLIENTS OTHER THAN 72, 93 or 94")
 D MES^MAGKIDS("WILL NOT BE ABLE TO CONNECT TO THE DATABASE")
 ;
 ;--- Restart the Imaging Utilization Report task
 I $$CP^MAGKIDS("MAG REPORT TASK","$$RPTSKCP^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Misc Updates
 I $$CP^MAGKIDS("MAG 94 MISC UPDATES ","$$UPD94^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Send the notification e-mail
 I $$CP^MAGKIDS("MAG NOTIFICATION","$$NOTIFY^MAGKIDS1")<0  D ERROR  Q
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ;--- Delete the field #6 in case sites created one
 D DELFLDS^MAGKIDS(2005.021,"6")
 Q
 ;
 ;--- Update field #6 in IMAGE FILE FORMATS file (#2005.021)
 ;--- Update field #42 (TYPE INDEX) in MAG DESCRIPTIVE CATEGORIES file (#2005.81)
 ;    to 77 if field #1 (CLASS) equals "ADMIN" 
UPD94() ; Misc Updates
 ; Add values for the new field in IMAGE FILE FORMATS File
 ; The new field is $p 7 of the 0 node.
 ; named : FORMAT IS SUPPORTED
 N I
 S I=0
 F  S I=$O(^MAG(2005.021,I)) Q:'I  D
 . S $P(^MAG(2005.021,I,0),"^",7)=$S($P(^MAG(2005.021,I,0),"^",1)="DOC":"0",1:"1")
 . Q
 ; Change field #42 in file (#2005.81) to 77 if 2nd piece of 0 node is "ADMIN"
 ; and piece 3 of 2 node is 45 and .01 field equals "MISCELLANEOUS"
 ; 
 S I=""
 F  S I=$O(^MAG(2005.81,"B","MISCELLANEOUS",I)) Q:I=""  D
 . I $P(^MAG(2005.81,I,0),"^",2)="ADMIN" D
 . . S:$P(^MAG(2005.81,I,2),"^",3)=45 $P(^MAG(2005.81,I,2),"^",3)=77
 . Q
 ;
 ; Upref file, and set the EKG Node
 S I=0 F  S I=$O(^MAG(2006.18,I)) Q:'I  S ^MAG(2006.18,I,"EKG")="2^1^1^600^400^0"
 Q 0
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
