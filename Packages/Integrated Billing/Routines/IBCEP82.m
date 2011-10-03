IBCEP82 ;ALB/CLT - Special cross references and data entry for fields in file 355.93 ;18 Apr 2008  3:46 PM
 ;;2.0;INTEGRATED BILLING;**343,374,377,391**;21-MAR-94;Build 39
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Call at tags only
 Q
 ;This routine will ask for the NPI, check for duplicate entries, and check for proper
 ;format using the double-add-double formula.  If the NPI is being deleted it will ask
 ;the user why it is being deleted.
 ;If it is being deleted because of an erroneous entry it will be completely deleted.
 ;If it is a valid NPI being deleted because of possible inappropriate usage it will be
 ;maintained in the history cross reference to preclude anyone from using this NPI again.
 ;
EN(IBNPRV) ;Routine primary entry point
 N DTOUT,DUOUT,DA,DIR,DIE,DIC,DR,X,Y,IBKEY
 N IBIEN,IBNPI,IBCHECK,IBOLDNPI,IBRBNPI,IBRB
 S IBOLDNPI="",IBNPI="",IBKEY="XUSNPIMTL"
EN1 ;
 S (DA,IBIEN)=IBNPRV
 K DIR
 S DIR(0)="FO^10:10",DIR("A")="NPI",DIR("?")="Enter a 10 digit National Provider Identifier"
 I $G(DA) S:$P($G(^IBA(355.93,DA,0)),U,14)'="" (DIR("B"),IBOLDNPI,IBNPI)=$P($G(^IBA(355.93,DA,0)),U,14)
 D ^DIR S IBCHECK=$S(Y=IBOLDNPI:2,1:0)
 I X="^" W *7,!,"   EXIT NOT ALLOWED ??" G EN1
 I $E(X)="^" W *7,!,"   JUMPING NOT ALLOWED ??" G EN1
 I X="@" G:IBOLDNPI'="" DEL W *7,"??" G EN1
 I $G(DUOUT)!$G(DTOUT) G XIT
 I $G(IBOLDNPI)="",$G(X)="" G XIT
 S IBNPI=$S(X="":$G(IBOLDNPI),1:X)
 I '$$PROC(IBNPI,IBOLDNPI,IBIEN) G EN1
 G XIT
 ;
EN2(IBNPRV,INDENT) ; entry point from input templates IB SCREEN82 and IB SCREEN8H
 N DTOUT,DUOUT,DA,DIR,DIE,DIC,DR,X,Y,IBKEY
 N IBIEN,IBNPI,IBCHECK,IBOLDNPI,IBRBNPI,IBRB,SPACES
 S IBNPI="",IBKEY="XUSNPIMTL",IBOLDNPI="",SPACES="          "
EN21 ;
 S (DA,IBIEN)=IBNPRV
 K DIR
 S DIR(0)="FO^10:10",DIR("A")=$E(SPACES,1,INDENT)_"NPI",DIR("?")=$E(SPACES,1,INDENT)_"Enter a 10 digit National Provider Identifier"
 I $G(DA) S:$P($G(^IBA(355.93,DA,0)),U,14)'="" (DIR("B"),IBOLDNPI,IBNPI)=$P($G(^IBA(355.93,DA,0)),U,14)
 D ^DIR S IBCHECK=$S(Y=IBOLDNPI:2,1:0)
 I X="@" G:IBOLDNPI'="" DEL W *7,"??" G EN21
 I $G(DUOUT)!$G(DTOUT) G XIT
 I $G(IBOLDNPI)="",$G(X)="" G XIT
 S IBNPI=$S(X="":$G(IBOLDNPI),1:X)
 I '$$PROC(IBNPI,IBOLDNPI,IBIEN) G EN21
 G XIT
 ;
PROC(IBNPI,IBOLDNPI,IBIEN) ; process new NPI
 I '$$CHKDGT^XUSNPI(IBNPI) W !,*7,$E($G(SPACES),1,+$G(INDENT))_"Not a valid NPI.  Please try again.",! Q 0
 I $$NPIUSED^IBCEP81(IBNPI,IBOLDNPI,IBIEN,IBCHECK,IBKEY)=1 Q 0
 S IBCHECK=1
 I IBOLDNPI="" D ACTI
 I IBOLDNPI'="" D:IBNPI'=IBOLDNPI INACT
 S $P(^IBA(355.93,IBIEN,0),U,14)=IBNPI,^IBA(355.93,"NPI",IBNPI,IBIEN)="",^IBA(355.93,"NPIHISTORY",IBNPI,IBIEN)=""
 Q 1
 ;
ACTI ;CREATE AN ACTIVATED ENTRY IN MULTIPLE NPISTATUS FIELD
 S DA(1)=IBIEN,DIC="^IBA(355.93,"_DA(1)_",""NPISTATUS"",",DIC(0)="L",X=$$NOW^XLFDT()
 S DIC("DR")=".02////^S X=1;.03////^S X=IBNPI;.04////^S X=DUZ"
 D FILE^DICN
 S $P(^IBA(355.93,IBIEN,0),U,14)=IBNPI
 Q
 ;
DEL ;NPI HAS BEEN DELETED
 ;If the user deletes the NPI this subroutine will determine why it was deleted and, if it was because it was found
 ;in a false identity situation, will mark it in history to never be used again.
 S IBNPI=$G(DIR("B"))
 K DIR
 S DIR(0)="Y"
 S DIR("A")="Are you sure you wish to delete this NPI"
 S DIR("?")="You have indicated you wish to delete the NPI.  This is a second chance check."
 D ^DIR
 G:Y(0)="NO" XIT
 S DIR(0)="S^E:ERROR;V:VALID",DIR("A")="Was this a Valid NPI or an NPI entered in Error"
 S DIR("?",1)="An example of an NPI entered in error is if the entry person transposed numbers,"
 S DIR("?",2)="or if the NPI for one provider is accidentally assigned to a different provider."
 S DIR("?")="Enter an 'E' for Error or a 'V' for Valid."
 D ^DIR
 I Y="E" D COMP W !,"The NPI has been deleted.",!
 I Y="V" S IBCHECK=2 D INACT W !,"The NPI is now inactive.",!
 Q:$D(DTOUT)!($D(DUOUT))
 S IBOLDNPI=IBNPI D WARND(IBIEN,IBOLDNPI,IBKEY)
 Q
 ;
COMP ;COMPLETELY DELETE THE NPI
 ;This subroutine will delete the NPI from the file 355.93.
 S OIEN=$O(^IBA(355.93,IBIEN,"NPISTATUS","C",IBOLDNPI,"A"),-1)
 D DELNPI(IBIEN,OIEN)
 K ^IBA(355.93,"NPI",IBOLDNPI,DA),^IBA(355.93,"NPIHISTORY",IBOLDNPI,DA)
 S IBRB=0
 D  ; Find the most recent status '0' (inactive) NPI entry in the list.
 . N IBRBLST,IBRBTMP
 . ; Don't want to roll back to the same number you are deleting.
 . S IBRBLST(IBOLDNPI)=""
 . S IBRBTMP="A"
 . ; Go through each entry in reverse order
 . F  S IBRBTMP=$O(^IBA(355.93,IBIEN,"NPISTATUS",IBRBTMP),-1) Q:'IBRBTMP  D  Q:IBRB'=0
 .. S IBRBLST=^IBA(355.93,IBIEN,"NPISTATUS",IBRBTMP,0)
 .. ; If this is an 'active' entry then ignore it.
 .. I $P(IBRBLST,U,2)=1 Q
 .. ; If this entry does not have an NPI then ignore it.
 .. I $P(IBRBLST,U,3)="" Q
 .. ;If this is an inactive entry then report it.
 .. I $P(IBRBLST,U,2)=0 S IBRB=IBRBTMP Q
 .. Q
 . Q
 I IBRB>0 D ROLLBACK
 Q
 ;
DELNPI(IEN,OIEN) ;DELETE-INVALID removes NPI from file.
 NEW DIE,DIK,DIC,DA,DR,D,D0,DI,DIC,DQ,X
 NEW DP,DM,DK,DL,DIEL
 S DIE="^IBA(355.93,",DA=IEN,DR="41.01////@"
 D ^DIE
 S DA(1)=IEN,DIK="^IBA(355.93,"_DA(1)_",""NPISTATUS"",",DA=OIEN
 D ^DIK
 Q
 ;
INACT ;INACTIVATE AN ENTRY
 ;This subroutine makes two entries in the NPI multiple field:
 ;one for the deactivation of the old NPI and the second
 ;for the activation of a new NPI.
 S DA(1)=IBIEN,DIC="^IBA(355.93,"_DA(1)_",""NPISTATUS"",",DIC(0)="L",X=$$NOW^XLFDT()
 S DIC("DR")=".02////^S X=0;.03////^S X=IBOLDNPI;.04////^S X=DUZ"
 D FILE^DICN
 S ^IBA(355.93,"NPIHISTORY",IBOLDNPI,DA(1))=""
 K ^IBA(355.93,"NPI",IBOLDNPI,DA(1))
 S $P(^IBA(355.93,IBIEN,0),U,14)=""
 I $G(IBCHECK)<2 D
 .D ACTI
 .S ^IBA(355.93,"NPIHISTORY",IBNPI,DA(1))=""
 .D WARNR(IBIEN,IBOLDNPI,IBKEY)
 Q
 ;
ROLLBACK ;Rollback or delete NPI
 S IBRBNPI=$P(^IBA(355.93,IBIEN,"NPISTATUS",IBRB,0),U,3)
 NEW DIE,DIK,DIC,DA,DR,D,D0,DI,DIC,DQ,X
 NEW DP,DM,DK,DL,DIEL
 S DA(1)=IBIEN,DIK="^IBA(355.93,"_DA(1)_",""NPISTATUS"",",DA=IBRB
 D ^DIK
 S $P(^IBA(355.93,IBIEN,0),U,14)=IBRBNPI,^IBA(355.93,"NPI",IBRBNPI,IBIEN)=""
 Q
 ;
XIT ;CLEAN AND EXIT
 Q
 ;
XR ;Set the primary taxonomy code cross reference for field 42
 N ATAX S ATAX=""
 I $D(^IBA(355.93,DA(1),"TAXONOMY","D")) D:X=1
 . F  S ATAX=$O(^IBA(355.93,DA(1),"TAXONOMY","D",1,ATAX)) Q:ATAX=""  D
 .. K ^IBA(355.93,DA(1),"TAXONOMY","D",1,ATAX)
 .. I ATAX'=DA S $P(^IBA(355.93,DA(1),"TAXONOMY",ATAX,0),U,2)=0,^IBA(355.93,DA(1),"TAXONOMY","D",0,ATAX)=""
 S ^IBA(355.93,DA(1),"TAXONOMY","D",X,DA)=""
 Q
 ;
KXR ;Kill primary taxonomy code cross reference for field 42
 N K
 F K=0,1 K ^IBA(355.93,DA(1),"TAXONOMY","D",K,DA)
 Q
 ;
WARNR(IBIEN,IBOLDNPI,IBKEY) ;Warn user that the old NPI that was replaced is currently used by an entry in the New Person file (#200)
 N IBIEN200
 Q:$G(IBOLDNPI)=""
 S IBIEN200=$O(^VA(200,"ANPI",IBOLDNPI,""))
 Q:IBIEN200=""
 W !!,"WARNING: NPI ",IBOLDNPI," is also associated with Provider ",$$GET1^DIQ(200,IBIEN200,.01),".",!
 I $O(^XUSEC(IBKEY,""))="" W !!,"There are no holders of the ",IBKEY," security key on the VistA system.  Contact your IRM department for further direction." Q
 W !,"A MailMan message has been sent to holders of the "_""""_IBKEY_""""_" security key."
 D MAILR(IBIEN,IBKEY,IBIEN200,IBOLDNPI)
 Q
 ;
WARND(IBIEN,IBOLDNPI,IBKEY) ;Warn user that the old NPI that was deleted is currently used by an entry in the New Person file (#200)
 N IBIEN200
 Q:$G(IBOLDNPI)=""
 S IBIEN200=$O(^VA(200,"ANPI",IBOLDNPI,""))
 Q:IBIEN200=""
 W !!,"WARNING: NPI ",IBOLDNPI," is also associated with VA Provider ",$$GET1^DIQ(200,IBIEN200,.01),".",!
 I $O(^XUSEC(IBKEY,""))="" W !!,"There are no holders of the ",IBKEY," security key on the VistA system.  Contact your IRM department for further direction." Q
 W !,"A MailMan message has been sent to holders of the "_""""_IBKEY_""""_" security key."
 D MAILD(IBIEN,IBKEY,IBIEN200,IBOLDNPI)
 Q
 ;
MAILR(IBIEN,IBKEY,IBIEN200,IBOLDNPI) ;Send mailman message for replacement of NPI
 ;This subroutine is supported by IA# 10070
 ;Lookups in NEW PERSON file (#200) are supported by IA#10076
 N IBIEN2,XMDUZ,XMSUB,XMTEXT,XMY,IBMSG,XMZ,XMMG
 S IBIEN2=0 F  S IBIEN2=$O(^XUSEC(IBKEY,IBIEN2)) Q:IBIEN2=""  S XMY(IBIEN2)=""
 S XMDUZ=$S($G(DUZ):DUZ,1:.5),XMSUB="NPI Replacement"
 S IBMSG(1)="The NPI "_IBOLDNPI_" was changed to "_IBNPI_" for"
 S IBMSG(2)=$$GET1^DIQ(355.93,IBIEN,.01)_" in the IB NON/OTHER VA BILLING PROVIDER"
 S IBMSG(3)="file.  The NPI "_IBOLDNPI_" is also associated with"
 S IBMSG(4)=$$GET1^DIQ(200,IBIEN200,.01)_" in the NEW PERSON file."
 S IBMSG(5)=""
 S IBMSG(6)="The same change may need to be made to the NEW PERSON file using the"
 S IBMSG(7)="Add/Edit NPI values for Providers option."
 S XMTEXT="IBMSG(" D ^XMD
 Q
 ;
MAILD(IBIEN,IBKEY,IBIEN200,IBOLDNPI) ;Send mailman message for deletion of an NPI
 ;This subroutine is supported by IA# 10070
 ;Lookups in NEW PERSON file (#200) are supported by IA#10076
 N IBIEN2,XMDUZ,XMSUB,XMTEXT,XMY,IBMSG,XMZ,XMMG
 S IBIEN2=0 F  S IBIEN2=$O(^XUSEC(IBKEY,IBIEN2)) Q:IBIEN2=""  S XMY(IBIEN2)=""
 S XMDUZ=$S($G(DUZ):DUZ,1:.5),XMSUB="NPI Deletion"
 S IBMSG(1)="The NPI "_IBOLDNPI_" was deleted for "_$$GET1^DIQ(355.93,IBIEN,.01)
 S IBMSG(2)="in the IB NON/OTHER VA BILLING PROVIDER file.  The NPI "_IBOLDNPI_" is also"
 S IBMSG(3)="associated with "_$$GET1^DIQ(200,IBIEN200,.01)_" in the NEW PERSON file."
 S IBMSG(4)=""
 S IBMSG(5)="The same change may need to be made to the NEW PERSON file using the"
 S IBMSG(6)="Add/Edit NPI values for Providers option."
 S XMTEXT="IBMSG(" D ^XMD
 Q
