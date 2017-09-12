MAGIP127 ;WOIFO/NST - Install code for MAG*3.0*127 ; 27 Feb 2013 09:15 AM
 ;;3.0;IMAGING;**127**;Mar 19, 2002;Build 4231;Apr 01, 2013
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
 ; There are no environment checks here but the MAGIP118 has to be
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
 ;--- Link new remote procedures to the Broker context option.
 S CALLBACK="$$ADDRPCS^"_$NA(MAGKIDS1("RPCLST^"_$T(+0),"MAG WINDOWS"))
 I $$CP^MAGKIDS("MAG ATTACH RPCS P127 WIN",CALLBACK)<0  D ERROR  Q
 ;
 ;--- Various Updates
 I $$CP^MAGKIDS("MAG P127 UPDATE","$$UPDATE^"_$T(+0))<0  D ERROR  Q
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ; Delete PROCEDURE field (#2006.5841,1). The field will be reloaded with the install.
 ; In this way we don't need to have IA for deletion of ^DD(2006.5841,0,"ID") 
 D DELFLDS^MAGKIDS(2006.5841,1)
 Q
 ;
 ;+++++ LIST OF NEW REMOTE PROCEDURES
 ; have a list in format ;;MAG4 IMAGE LIST
RPCLST ;
 ;;MAG3 TELEREADER TIU TITLES LST
 ;;MAG3 TELEREADER CLONE READER
 Q 0
 ;
 ;+++++ Various updates
UPDATE() ;
 D CLEANAC  ; Clean up bogus "AC" cross-reference
 Q 0
 ;
CLEANAC ; Clean up bogus "AC" cross-reference in TELEREADER ACQUISITION SERVICE file (#2006.5841)  
 N DIK
 L +^MAG(2006.5841):1E9
 K ^MAG(2006.5841,"AC")  ; delete "AC" cross-reference
 K ^MAG(2006.5841,"B")   ; delete "B" cross-reference 
 S DIK="^MAG(2006.5841,"
 D IXALL^DIK   ; Rebuild all cross-references in TELEREADER ACQUISITION SERVICE file (#2006.5841)
 L -^MAG(2006.5841)
 D MES^MAGKIDS("Rebuild of cross-references in TELEREADER ACQUISITION SERVICE file (#2006.5841) has been completed.")
 Q
