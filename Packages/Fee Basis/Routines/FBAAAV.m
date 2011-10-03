FBAAAV ;AISC/GRR-FLAG VENDOR FOR ADDITION IN CENTRAL FEE ;10JUL86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
UPDATE ;enter here to update FMS vendor file - called from fbaa fms update option
 N FBDA,FBSAY S FBSAY=1 ;flag, if 1 then write
 W !! S DIC(0)="AEQM",DIC="^FBAAV(",DIC("S")="N FBVC S FBVC=$P($G(^FBAA(161.25,+Y,0)),U,2,3),FBVC=$TR(FBVC,U) I FBVC'[""C""&(FBVC'[""N"")&('$D(^FBAA(161.25,""AF"",+Y)))" D ^DIC G EXIT:X="^"!(X=""),UPDATE:Y<0 S (FBDA,DA)=+Y
 D EN1^FBAAVD
 W ! S DIR(0)="Y",DIR("A")="Is this vendor information correct",DIR("B")="No" D ^DIR K DIR G EXIT:$D(DIRUT),VER:Y
 I '$D(^XUSEC("FBAA ESTABLISH VENDOR",DUZ)) W !!,*7,"You must contact a vendorizing clerk or supervisor to update this record!" G EXIT
 S FBHDA=DA D EDITV^FBAAVD S DA=FBHDA
 S FBVC=$P($G(^FBAA(161.25,DA,0)),U,2,3),FBVC=$TR(FBVC,U) I FBVC["C" W !!?5,"Vendor flagged for updating!" G UPDATE
VER W ! S DIR(0)="Y",DIR("A")="Are you sure you want to update this Vendor in the FMS and Central Fee vendor   files",DIR("B")="NO",DIR("??")="^D HELP^FBAAAV"
 D ^DIR K DIR G:$D(DIRUT) EXIT I 'Y W !!,*7,"Will NOT be Updated" G UPDATE
 D SET(FBDA) G UPDATE
 ;
SET(DA,FBSAY) ;INPUT:  DA = ien of record to be updated
 ;        FBSAY = flag to write: 1 for on (optional)
 Q:'+$G(DA)  N DIE,DR,FBIEN1,FBLOCK,FBT S FBT="C",FBIEN1=DA D SETGL^FBAAVD W:$G(FBSAY) !!,*7,"Vendor flagged for updating!"
 S DIE="^FBAAV(",DA=FBIEN1,DR="30.01///@;9///@;13///@" D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FBAAV(DA)
 ;K DA,DIE,DR,FBLOCK
 ;G UPDATE:FBSAY
EXIT K FBT,FBTOV,X,FBEXDT,FBEXNDT,DIC,DIE,Y,DA,DIRUT,FBHDA,FBIEN1,FBTOV,FEEO,Z,Z1,ZZ,FBAAPN,FBDEL,FBID,FBLIEN,FBPARCD,FBTV,FBVIEN,FBV1,FBVC,FBZ,FBX,FBCNUM Q
UPDT(FBDA) ;entry point from fbaavd2 - non-interactive
 ;INPUT:  FBDA = ien of vendor in vendor file
 ;OUTPUT: set in vendor correction file as update (link to itself) if vendor does not exist, or another vendor is not already linked to it.
 Q:'+$G(FBDA)  N FBSAY S FBSAY=0
 ;S DIC(0)="M",DIC="^FBAAV(" D ^DIC G EXIT:Y'>0 S FBDA=+Y
 I '$D(^FBAA(161.25,FBDA,0))&('$D(^FBAA(161.25,"AF",FBDA))) D SET(FBDA)
 Q
HELP ;help for update of fms vendor file
 W !?10,"This option should only be used to update the FMS and Central"
 W !?10,"Fee vendor files in Austin with the appropriate information."
 W !?10,"(NOTE:  The vendor may not exist in the FMS vendor file,"
 W !?10,"        or may exist, but the information in the FMS vendor"
 W !?10,"        file does not reflect accurate information.)"
 W !
 W !?10,"Use of this option should update the FMS system to reflect"
 W !?10,"what is currently in the DHCP system.  Information at all"
 W !?10,"other VA Medical Centers using this vendor will also be updated."
