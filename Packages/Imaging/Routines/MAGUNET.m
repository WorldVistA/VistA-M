MAGUNET ;WOIFO/SRR/RMP - Edit Network Location companion ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;;Mar 01, 2002
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
ED ;Enter/Edit Network Location Parameters
 S DIC="^MAG(2005.2,",DIC(0)="AEQLZ",DIC("A")="     Enter a Network Location: "
 W !!! D ^DIC G EXIT:Y=-1
 S DIE("NO^")="BACK",DIE=DIC,DA=+Y,DR="[MAG ENTER/EDIT NETWORK LOC]"
 D ^DIE G ED
 Q
 ;
CK ;Check name for Magnetic Storage
 S LOC=$P(^MAG(2005.2,DA,0),U) Q:$E(LOC,1,3)="MAG"
 W !,"Logical name for this device does not start with 'MAG'!!"
 Q
 ;
PR ;Physical Reference
 W !!,?10,"This is the PATH for the Image Storage"
 W !?10,"For example: J:\IMAGE\ or H:\IMAGE\",!!
 Q
 ;
STA ;Network Location Status
 W @IOF,!!!?20,"CHANGE a Magnetic Server STATUS"
 W !!?25,"OFF LINE =====> 0"
 W !!?25," ON LINE =====> 1",!!
 S (DIC,DIE)="^MAG(2005.2,",DR="5;",DIC(0)="QAEZ",DIC("S")="I $E($P(^(0),U),1,3)=""MAG"""
 D ^DIC G EXIT:Y<0
 S DA=+Y D ^DIE G EXIT
EXIT ;Exit routine
 K DA,DIC,DIE,DR,LOC,X,Y
 Q
MUSENET ;Edit MUSE fields 
 ; MUSE fields in 2006.1
 N DIC,DIE,X,Y,DR,D,D0,DA,D1,DQ,DP,MAGUSR,MDEF,MAGPSWD
 S DA=1
 S DIE="^MAG(2006.1,",DR="[MAG MUSE PARAMETERS]"
 D ^DIE
 S NET=$G(^MAG(2006.1,1,"NET"))
 S MAGUSR=$P($G(NET),"^"),MAGPSWD=$P(NET,"^",2)
 S MDEF=$P($G(^MAG(2006.1,1,"USERPREF")),"^",2)
 I MAGUSR=""!(MAGPSWD="")!(MDEF="") D
 . W !,$C(7),"The MUSE interface requires all of the above fields;"
 . W !,"please research and provide the appropriate responses."
 D ENTWK
 Q
ENTWK ;
 N DIC,DIE,X,Y,DR,D,D0,DA,D1,DQ,DP
 S DIC="^MAG(2005.2,",DIC(0)="AEQLZ"
 S DIC("A")="  Add/Edit Muse Network Location: "
 W !! D ^DIC
 I Y=-1 G EXIT
 S DA=+Y,DIE=DIC  Q:'DA
 S DIE("NO^")="BACKOUTOK"
 S DR="[MAG ENTER/EDIT MUSE NETWORK]"
 D ^DIE K X,Y G ENTWK
 Q
