ORCPOST ; slc/dcm,MKB - CPRS post-init ;10/25/97  16:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
EN ;-- Post-init cleanup
 D POSTORLP^ORLP3C1,POSTORB^ORB3C1 ; User Parameters, Notifications
 D BMES^XPDUTL("Cleaning up unused data and fields ...")
 K ^ORYX("ORERR") S ^ORYX("ORERR",0)="OE/RR ERRORS^100.4D^^"
 D 22,19,101,P49,200,DGPM,ZIS
 Q
 ;
22 ;Set print 0th node
 S $P(^ORD(100.22,0),"^",3)=""
 ;S $P(^ORD(100.23,0),"^",3)=""
 D RECMPL^ORPR00
 Q
19 ;Clean-up old entry & exit actions in Option file
 N IFN,ENT,EX
 S IFN=0 F  S IFN=$O(^DIC(19,IFN)) Q:IFN<1  S ENT=$G(^(IFN,20)),EX=$G(^(15)) D
 . I ENT["D TIT^OR",$P(ENT,"D TIT^",2)="OR" S ^DIC(19,IFN,20)=""
 . I ENT["D EN^OR",$P(ENT,"D EN^",2)="OR" S ^DIC(19,IFN,20)="D ^ORCHART"
 . I EX="D EXIT^OR" S ^DIC(19,IFN,15)=""
 Q
101 ;Clean-up old entry actions in Protocol file
 N IFN,ENT
 S IFN=0 F  S IFN=$O(^ORD(101,IFN)) Q:IFN<1  S ENT=$G(^(IFN,20)) D
 . I ENT["^OR3" S ^ORD(101,IFN,20)="" Q
 Q
200 ;Clean-up unused data and fields in file 200
 N DA,DIK,IFN
 S IFN=0 F  S IFN=$O(^VA(200,IFN)) Q:IFN<1  D
 . I $D(^VA(200,IFN,100.1)) K ^(100.1)
 . I $D(^VA(200,IFN,100.2)) K ^(100.2)
 S DIK="^DD(200,",DA=100.21,DA(1)=200 D ^DIK ;Remove Summary Default
 S DIK="^DD(200,",DA=100.22,DA(1)=200 D ^DIK ;Remove Patient List Order
 S DIK="^DD(200,",DA=100.23,DA(1)=200 D ^DIK ;Remove Default Result Reporting
 S DIK="^DD(200,",DA=100.24,DA(1)=200 D ^DIK ;Remove Primary Profile Menu
 S DIK="^DD(200,",DA=100.25,DA(1)=200 D ^DIK ;Remove Provider List
 S DIK="^DD(200,",DA=100.26,DA(1)=200 D ^DIK ;Remove Specialty List
 S DIK="^DD(200,",DA=100.27,DA(1)=200 D ^DIK ;Remove New Orders Default
 S DIK="^DD(200,",DA=100.11,DA(1)=200 D ^DIK ;Remove Primary OE/RR Menu
 S DIK="^DD(200,",DA=100.12,DA(1)=200 D ^DIK ;Remove Primary Order Menu
 S DIK="^DD(200,",DA=100.13,DA(1)=200 D ^DIK ;Remove Primary Order Display
 S DIK="^DD(200,",DA=100.14,DA(1)=200 D ^DIK ;Remove Ward List
 S DIK="^DD(200,",DA=100.15,DA(1)=200 D ^DIK ;Remove Patient List
 S DIK="^DD(200,",DA=100.16,DA(1)=200 D ^DIK ;Remove Selectpat
 S DIK="^DD(200,",DA=100.17,DA(1)=200 D ^DIK ;Remove Clinic List
 S DIK="^DD(200,",DA=100.18,DA(1)=200 D ^DIK ;Remove Clinic Appointment Start
 S DIK="^DD(200,",DA=100.19,DA(1)=200 D ^DIK ;Remove Clinic Appointment Stop
 Q
 ;
DGPM ; -- Replace OR items on DGPM MOVEMENT EVENTS
 N DGPM,DIK,DA,DIC,DLAYGO,X,Y,ORDITEM,ORTASK,ORNOTASK,ORD,DONE
 S DGPM=+$O(^ORD(101,"B","DGPM MOVEMENT EVENTS",0)) Q:'DGPM
 F X=""," NOTASK" S Y=+$O(^ORD(101,"B","OR GUA EVENT PROCESSOR"_X,0)) I Y,$O(^ORD(101,"AD",Y,DGPM,0)) S DONE=1 Q  ; already added
 Q:$G(DONE)  S DA(1)=DGPM,DIK="^ORD(101,"_DGPM_",10,"
 F ORDITEM="GENERIC ORDERS","GEN ORD ON TRANS" D
 . S ORD=$O(^ORD(101,"B","OR GUA DC "_ORDITEM,0)) Q:'ORD
 . S DA=$O(^ORD(101,"AD",ORD,DGPM,0)) I DA D ^DIK S ORTASK=1
 . S ORD=$O(^ORD(101,"B","OR GUA DC "_ORDITEM_" NOTASK",0)) Q:'ORD
 . S DA=$O(^ORD(101,"AD",ORD,DGPM,0)) I DA D ^DIK S ORNOTASK=1
 S DIC=DIK,DIC(0)="L",DLAYGO=101,DIC("P")=$P(^DD(101,10,0),U,2),DIC("DR")="3///999",X=+$O(^ORD(101,"B","OR GUA EVENT PROCESSOR"_$S($G(ORNOTASK):" NOTASK",1:""),0)) K Y
 D:X FILE^DICN I +$G(Y)'>0 D BMES^XPDUTL(">>> Unable to add OR GUA EVENT PROCESSOR protocol to DGPM MOVEMENT EVENTS")
 Q
 ;
P49 ; -- Ck stuff in patch 49 (do, if clean install)
 I $O(^ORD(101.43,0)) D OI^ORSETUP1 ;      Ck quick order ptrs only
 I '$O(^ORD(101.43,0)) D ORDITMS^ORSETUP ;  or populate whole file
 D BMES^XPDUTL("Populating Parameters file ..."),^ORXPAR
 I '$P($G(^ORD(100.99,1,200)),U,2) D  ;    [re]convert patch 49 stuff
 . D ^ORPFCNVT,PARM^RAO7MFN ;              Update package parameters
 . D DGROUPS^ORSETUP ;                     Add new fields to #100.98
 . D URG^ORSETUP ;                         Add Consult urgencies
 . K ^ORD(100.99,1,101),^(101.41),^(200) D DIALOGS^ORSETUP ; #101->101.41
 S $P(^ORD(100.99,1,200),U,2)=1 ; Done.
 Q
 ;
ZIS ; -- Add OR WORKSTATION and resource devices
 N DA,DIC,DIE,DLAYGO,X,Y
 S DIC(0)="LQMZ",(DIC,DLAYGO)=3.5,X="OR WORKSTATION" D ^DIC
 I Y,$P(Y,"^",3) D  ; if newly added
 . S DA=+Y,DIE=DIC
 . S DR=".02///^S X=""OR Workstation HFS Device"";1///^S X=""ORDEV.DAT"""
 . S DR=DR_";1.95////0;2///^S X=""HFS"";4////0;5////0;5.1////0;5.2////0"
 . S DR=DR_";3///^S X=""`""_"_$$SUBTYPE^ORCPOST()
 . D ^DIE
 ;
 S X=$$RES^XUDHSET("ORW/PXAPI RESOURCE",,5,"CPRS to PCE transactions")
 S X=$$RES^XUDHSET("ORB NOTIFICATION RESOURCE",,5,"OE/RR notifications")
 S X=$$RES^XUDHSET("OR MOVEMENT RESOURCE",,5,"OR movement event process")
 Q
 ;
SUBTYPE() ; get subtype for P-OTHER
 N DIC,X
 S DIC(0)="QMXZ",DIC="^%ZIS(2,",X="P-OTHER" D ^DIC
 Q +Y
