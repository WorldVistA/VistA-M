MAGIP105 ;WOIFO/JSL - Post Install routine to add AWIV entry;3/08/2010
 ;;3.0;IMAGING;**105**;Mar 19, 2002;Build 1865;Oct 25, 2010
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
 D INS^MAGQBUT4($G(XPDNM,"MAG*3.0*105 AWIV"),DUZ,$$NOW^XLFDT,$G(XPDA))
 Q
 ;+++++ ADD 'REMOTE APPLICATION' ENTRY
ADD ;Create Imaging entries in 8994.5  REMOTE APPLICATION if it does not exist
 N ACODE,DA,DD,D0,DIC,DIE,DR,ENTRY,PORT,X,Y,CALLBKSRV,URLSTRING,CONTX,MAGZZERR
 W !,"I will check if the AWIV entry is in the REMOTE APPLICATION file."
 ;Set the new entry
 S X="VISTA IMAGING AWIV",DIC="^XWB(8994.5,",ACODE=$$EN^ROUTINE(X),CONTX="MAG WINDOWS"
 S DA=$$FIND1^DIC(8994.5,,,X,"B") D:DA=0
 . S DIC(0)="O" K DD,D0,DR D FILE^DICN
 . S ENTRY=+Y I 'ENTRY W !,"Can't add new entry "_X G ERROR
 . S DR=".02///"_CONTX_";.03///^S X=ACODE;1///H"
 . S PORT="19989",URLSTRING="/resolve.do",CALLBKSRV="vaww.context.vistaweb.domain.ext"
 . S DR(2,8994.51)=".01///H;.02///"_PORT_";.03///"_CALLBKSRV_";.04////"_URLSTRING
 . S DA=ENTRY,DIE="^XWB(8994.5," D ^DIE
 . Q
 Q
ERROR ;Trap Errors
 S MAGZZERR=$$EC^%ZOSV D ^%ZTER S $ECODE=""
 W !,MAGZZERR,!,"Please check the error log for details",!
 Q
 ;
