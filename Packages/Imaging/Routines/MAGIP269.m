MAGIP269 ;WOIFO/ZEB - Install code for MAG*3.0*269 ;3/4/21  15:24
 ;;3.0;IMAGING;**269**;Mar 19, 2002;Build 8;Jan 18, 2012
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
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 D RPCS
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
RPCS ;register RPCs in MAG WINDOWS
 N RPC,I,D0,DIC,DA,X
 S RPC(0)=6
 S RPC(1)=$O(^XWB(8994,"B","XHD GET SITE INFO",""))
 S RPC(2)=$O(^XWB(8994,"B","ORWCIRN FACLIST",""))
 S RPC(3)=$O(^XWB(8994,"B","ORRCQLPT PTDEMOS",""))
 S RPC(4)=$O(^XWB(8994,"B","ORWU USERINFO",""))
 S RPC(5)=$O(^XWB(8994,"B","DSIC DPT GET ICN",""))
 S RPC(6)=$O(^XWB(8994,"B","MAG STUDY UID QUERY",""))
 ;find IEN for MAG WINDOWS
 S D0=$O(^DIC(19,"B","MAG WINDOWS",""))
 Q:D0=""  ;abort iff MAG WINDOWS doesn't exist
 ;add RPCS to context
 F I=1:1:RPC(0) D
 . Q:RPC(I)=""  ;abort if RPC doesn't exist
 . Q:$O(^DIC(19,D0,"RPC","B",RPC(I),""))]""  ;abort if RPC in context already
 . S DIC="^DIC(19,"_D0_",""RPC"","
 . S DIC(0)="FL"
 . S DA(1)=D0
 . S X=RPC(I)
 . K DO
 . D FILE^DICN
 Q
