MAGIP111 ;WOIFO/JSL - Post Install routine to add RA entry
 ;;3.0;IMAGING;**111**;28-September-2009;;Build 1461
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
 ;***** POST-INSTALL CODE
POS ;
 D ADD
 ;--- Send the install notification via e-mail
 D INS^MAGQBUT4($G(XPDNM,"MAG*3.0*111 BSE"),DUZ,$$NOW^XLFDT,$G(XPDA))
 Q
 ;+++++ ADD 'REMOTE APPLICATION' ENTRY
ADD ;Create Imaging entries in 8994.5  REMOTE APPLICATION if they do not exist
 N A,ACODE,DA,DD,DO,DIC,DIE,DR,ENTRY,OPTN,PORT,RPC,X,Y
 W !,"I will check if Imaging entries are in the REMOTE APPLICATION file. . ."
 ;Set the new entry
 S DIC="^XWB(8994.5,",X="ERROR^MAGIP111",@^%ZOSF("TRAP")
 F A=1:1 S X=$P($T(API+A),";",3) Q:'$L(X)  D
 . S DA=$$FIND1^DIC(8994.5,,,X,"B") Q:DA  ;chk if already exist
 . S DIC(0)="O",ACODE=$$EN^ROUTINE(X)
 . K DD,D0 D FILE^DICN
 . S ENTRY=+Y I 'ENTRY W !,"Can't add new entry "_X G ERROR
 . S DR=".02///"_$P($T(API+A),";",4)_";.03///"_ACODE_";1///S"
 . S PORT=-1
 . S DR(2,8994.51)=".02////"_PORT ;sub file
 . S DA=ENTRY,DIE="^XWB(8994.5," D ^DIE W "*"
 . Q
 ; Add new RPC - MAG BROKER SECURITY into MAG WINDOWS & VISARAD WINDOWS
 S DA=$$FIND1^DIC(8994,,,"MAG BROKER SECURITY","B") ;RPC - BSE TOKEN
 I DA F OPTN="MAG WINDOWS","MAGJ VISTARAD WINDOWS" D
 . D ADDRPC^MAGQBUT4("MAG BROKER SECURITY",OPTN) W "*"
 . Q
 Q
ERROR ;Trap Errors
 W !,$ZE,!,"Please check the error log for details",!
 Q
API ;
 ;;VISTA IMAGING DISPLAY;MAG WINDOWS;
 ;;VISTA IMAGING TELEREADER;MAG WINDOWS;
 ;;VISTA IMAGING VIX;MAG WINDOWS;
 ;;VISTA IMAGING VISTARAD;MAGJ VISTARAD WINDOWS;
 Q
