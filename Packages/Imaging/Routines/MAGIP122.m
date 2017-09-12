MAGIP122 ;WOIFO/JSL - INSTALL CODE FOR MAG*3.0*122 ; 08 Nov 2010 3:17 PM
 ;;3.0;IMAGING;**122**;Mar 19, 2002;Build 92;Aug 02, 2012
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
POST ;
 D CLEAR^MAGUERR(1),CHKFNSZ
 N ERROR D EN^XPAR("SYS","MAG IMAGE ALLOW ANNOTATE",,"NO",.ERROR)
 D BMES^XPDUTL("Turn off MAG IMAGE Annotation by default - EDIT PARAMETER VALUES(OPTION NAME)")
 ;--- Link new remote procedures to the Broker context option
 D BMES^XPDUTL("Updating MAG WINDOWS: RPCs ")
 D ADDRPC("MAG ANNOT GET IMAGE")
 D ADDRPC("MAG ANNOT GET IMAGE DETAIL")
 D ADDRPC("MAG ANNOT STORE IMAGE DETAIL")
 D ADDRPC("MAG ANNOT IMAGE ALLOW")
 D ADDRPC("MAG DICOM GET AGENCY")
 D ADDRPC("MAGJ GET TREATING LIST")
 D REMTASK^MAGQE4,STTASK^MAGQE4
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
ADDRPC(NAME) ;Adding Remote Procedure Call
 Q:$G(NAME)=""  ;IA # 4011
 I $$FIND1^DIC(8994,,"O",NAME,"B",,"MAGMSG")>0 D
 . N DIC,Y,X S DIC="^DIC(19,",DIC(0)="",X="MAG WINDOWS" D ^DIC Q:$P(Y,U)<0
 . I '$D(^DIC(19,+Y,"RPC","B",$O(^XWB(8994,"B",NAME,"")))) D ADDRPC^MAGQBUT4(NAME,"MAG WINDOWS") W "*"
 Q
CHKFNSZ ;Checking default annotate font size (11->36)
 N USR,Y
 S USR=0 F  S USR=$O(^MAG(2006.18,USR)) Q:'USR  D
 . S Y=$G(^MAG(2006.18,USR,"ANNOTCAPTURE")) I $P(Y,U,3)=11 S $P(^("ANNOTCAPTURE"),U,3)=36 W "|"
 . S Y=$G(^MAG(2006.18,USR,"ANNOTDISPLAY")) I $P(Y,U,3)=11 S $P(^("ANNOTDISPLAY"),U,3)=36 W "-"
 . Q
 Q
 ;
