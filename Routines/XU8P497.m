XU8P497 ;BP/BT - UPDATE PERSON CLASS FILE; 10/23/08
 ;;8.0;KERNEL;**497**;July 10, 1995;Build 5
 ;;"Per VHA Directive 2004-038, this routine should not be modified."
 ;
 Q
POST ; entry point of Post-Initi Routine
 D LOOP,INACTIVE
 Q
LOOP ; loop through New Person file. And map new Person Classes for users
 N XUIEN,XUPC,XUEFDATE,XUEXDATE
 K ^TMP("XU8P497")
 S XUIEN=0 F  S XUIEN=$O(^VA(200,XUIEN)) Q:XUIEN'>0  D
 . I $P($$ACTIVE^XUSER(XUIEN),"^",2)="TERMINATED" Q
 . S XUPC=$$GETPC(XUIEN)
 . I +XUPC>522 Q
 . I +XUPC<187 Q
 . S XUEFDATE=$P(XUPC,"^",2) I XUEFDATE<$$DT^XLFDT S XUEFDATE=$$DT^XLFDT
 . S XUEXDATE=$P(XUPC,"^",3)
 . I +XUPC=187 D REPOINT(XUIEN,181,XUEFDATE,XUEXDATE),PRINT(XUIEN,181) Q
 . I +XUPC=247 D REPOINT(XUIEN,1135,XUEFDATE,XUEXDATE),PRINT(XUIEN,1135) Q
 . I +XUPC=353 D REPOINT(XUIEN,675,XUEFDATE,XUEXDATE),PRINT(XUIEN,675) Q
 . I +XUPC=515 D REPOINT(XUIEN,352,XUEFDATE,XUEXDATE),PRINT(XUIEN,352) Q
 . I +XUPC=517 D REPOINT(XUIEN,352,XUEFDATE,XUEXDATE),PRINT(XUIEN,352) Q
 . I +XUPC=519 D REPOINT(XUIEN,354,XUEFDATE,XUEXDATE),PRINT(XUIEN,354) Q
 . I +XUPC=522 D REPOINT(XUIEN,352,XUEFDATE,XUEXDATE),PRINT(XUIEN,352) Q
 Q
 ;
REPOINT(USERIEN,NEWPC,EFDATE,EXDATE) ;Use FM so to fire X-ref's
 N RX1,RX2,DA1
 S DA1=USERIEN
 I $G(EFDATE)="" S EFDATE=$$DT^XLFDT
 S RX1(200.05,"+1,"_DA1_",",.01)=NEWPC
 S RX1(200.05,"+1,"_DA1_",",2)=$G(EFDATE)
 S RX1(200.05,"+1,"_DA1_",",3)=$G(EXDATE)
 L +^VA(200,DA1,"USC1"):2 I '$T D  Q
 .S XUA(1)="",XUA(2)=">>>User # "_DA1_" is locked at this time." D MES^XPDUTL(.XUA)
 D UPDATE^DIE("S","RX1","RX2")
 L -^VA(200,DA1,"USC1")
 Q
 ;
INACTIVE ; inactivate Person Class entries
 N XUI
 F XUI=187,247,353,515,517,519,522 D INAC(XUI)
 Q
 ;
INAC(PCIEN) ; inactivate single Person Class entry
 I +$G(PCIEN)'=$G(PCIEN) Q
 I $G(PCIEN)'>0 Q
 N XUA,XUDT S XUDT=$$DT^XLFDT
 L +^USC(8932.1,PCIEN,0):10 I '$T D  Q
 .S XUA(1)="",XUA(2)=">>>Record # "_PCIEN_" locked at time of patch installation. Could not inactivate." D MES^XPDUTL(.XUA)
 N DR,DIE,DA S DR="3////i",DIE="^USC(8932.1,",DA=PCIEN D ^DIE
 N DR,DIE,DA S DR="4///^S X=XUDT",DIE="^USC(8932.1,",DA=PCIEN D ^DIE
 L -^USC(8932.1,PCIEN,0)
 Q
 ;
PRINT(USERIEN,PCNEW) ; print a user who is assigned the replacement Person Class
 N XUA,XUY
 S XUY=+$O(^TMP("XU8P497",$J,"A"),-1)
 S XUA(1)=">>> The user "_$P($G(^VA(200,USERIEN,0)),"^")_" is assigned to the Person Class IEN: "_PCNEW
 S XUA(2)=""
 S ^TMP("XU8P497",$J,XUY+1)=XUA(1)
 D MES^XPDUTL(.XUA)
 Q
 ;
GETPC(XUIEN) ;Get Person Class for a single user
 N XUEXDA,XUPCIEN
 I +$G(XUIEN)'>0 Q ""
 I '$D(^VA(200,XUIEN,"USC1")) Q ""
 S XUPCIEN=$O(^VA(200,XUIEN,"USC1","A"),-1)
 I $G(XUPCIEN)'>0 Q ""
 S XUEXDA=$P($G(^VA(200,XUIEN,"USC1",XUPCIEN,0)),"^",3)
 I XUEXDA'="",(XUEXDA<$$DT^XLFDT) Q ""
 Q $G(^VA(200,XUIEN,"USC1",XUPCIEN,0))
 ;
SETDATE(USERIEN,PCIEN,XUEFDA,XUEXDA) ;set eff and exp date for the privious Person Class entry.
 I +$G(XUEFDA)>$$DT^XLFDT D SETEFDA(USERIEN,PCIEN,$$DT^XLFDT)
 I +$G(XUEXDA)>$$DT^XLFDT D SETEXDA(USERIEN,PCIEN,$$DT^XLFDT)
 Q
 ;
SETEXDA(USERIEN,PCIEN,EXDATE) ; set exp date
 N DIE,DA,DR
 S DA(1)=USERIEN ;
 S DA=PCIEN ; entry number in subfile
 S DIE="^VA(200,"_DA(1)_","_"""USC1"""_"," ; global root of subfile
 S DR="3///^S X=EXDATE" ; fields in subfile to edit
 L +^VA(200,USERIEN,"USC1"):2 I '$T D  Q
 .S XUA(1)="",XUA(2)=">>>User # "_DA1_" is locked at this time." D MES^XPDUTL(.XUA)
 D ^DIE
 L -^VA(200,USERIEN,"USC1")
 Q
SETEFDA(USERIEN,PCIEN,EFDATE) ; set eff date
 N DIE,DA,DR
 S DA(1)=USERIEN ;
 S DA=PCIEN ; entry number in subfile
 S DIE="^VA(200,"_DA(1)_","_"""USC1"""_"," ; global root of subfile
 S DR="2///^S X=EFDATE" ; fields in subfile to edit
 L +^VA(200,USERIEN,"USC1"):2 I '$T D  Q
 .S XUA(1)="",XUA(2)=">>>User # "_DA1_" is locked at this time." D MES^XPDUTL(.XUA)
 D ^DIE
 L -^VA(200,USERIEN,"USC1")
 Q
