PXIPOST ;ISL/dee - POST ROUTINE FOR PX PACKAGE ;8/12/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
EN ;
 ;Run post clean up routine
 N PXNEWCP
 S PXNEWCP=$$NEWCP^XPDUTL("PXPTPOST LOC","LOC^PXPTPOST")
 S PXNEWCP=$$NEWCP^XPDUTL("PXPTPOST MASTER","MASTER^PXPTPOST")
 S PXNEWCP=$$NEWCP^XPDUTL("PXIPOST1","PROTOCOL^PXIPOST1")
 S PXNEWCP=$$NEWCP^XPDUTL("PXIPOST","POST^PXIPOST")
 S PXNEWCP=$$NEWCP^XPDUTL("PXIPOST APPGRP","APPGRP^PXIPOST")
 S PXNEWCP=$$NEWCP^XPDUTL("PXIPOST AICS","AICS^PXIPOST")
 S PXNEWCP=$$NEWCP^XPDUTL("PXIPOST SDAMPROT","SDAMPROT^PXIPOST")
 S PXNEWCP=$$NEWCP^XPDUTL("PXIPOST PACKAGE","PACKAGE^PXIPOST")
 S PXNEWCP=$$NEWCP^XPDUTL("PXIPOST QUE","QUE^PXIPOST")
 Q
 ;
POST ;
 S $P(^AUPNVPRV(0),"^",2)="9000010.06AIP"
 ;
 ;Set the SD/PCE SWITCH OVER DATE
 I $P($G(^PX(815,1,0)),"^",2)'>2960000,$G(XPDQUES("POS SWITCH DATE")),XPDQUES("POS SWITCH DATE")>2960000,XPDQUES("POS SWITCH DATE")<2961002 D
 . I $D(^PX(815,1,0))#2 S $P(^PX(815,1,0),"^",2)=XPDQUES("POS SWITCH DATE")
 . E  S ^PX(815,1,0)="1^"_XPDQUES("POS SWITCH DATE")
 ;
 ;Set the HEALTH SUMMARY START DATE
 I $P($G(^PX(815,1,0)),"^",3)'>1800000,$P($G(^PX(815,1,0)),"^",2)>2960000 D
 . S $P(^PX(815,1,0),"^",3)=$P(^PX(815,1,0),"^",2)
 ;
SET ;Set PCE into the package multiple in visit tracking
 N VAR
 S VAR=$$PKGON^VSIT("PX") I VAR'=1 S VAR=$$PKG^VSIT("PX",1)
 Q
 ;
APPGRP ;
 D BMES^XPDUTL("Add ""PXRM"" Application Group to file 60, 71, 120.51")
 D MES^XPDUTL("  Done only if not there already.")
 N GMI
 K DIC,DA,DD,DO
 F GMI=60,71,120.51 I '$D(^DIC(GMI,"%","B","PXRM")) D
 . S DIC="^DIC("_GMI_",""%"","
 . S DIC(0)="L"
 . S DA(1)=GMI
 . S X="PXRM"
 . S DIC("P")=$P(^DD(1,10,0),"^",2)
 . D FILE^DICN
 . K DIC,DA,DD,DO
 . D:+Y>0 BMES^XPDUTL("Adding ""PXRM"" Application Group to ^DIC("_GMI_",")
 ;
APPGRP2 ;
 D BMES^XPDUTL("Add ""PXRS"" Application Group to file 80, 80.1, 81")
 D MES^XPDUTL("  Done only if not there already.")
 K GMI,DIC,DA,DD,DO
 F GMI=80,80.1,81 I '$D(^DIC(GMI,"%","B","PXRS")) D
 . S DIC="^DIC("_GMI_",""%"","
 . S DIC(0)="L"
 . S DA(1)=GMI
 . S X="PXRS"
 . S DIC("P")=$P(^DD(1,10,0),"^",2)
 . D FILE^DICN
 . K DIC,DA,DD,DO
 . D:+Y>0 BMES^XPDUTL("Adding ""PXRS"" Application Group to ^DIC("_GMI_",")
 Q
 ;
AICS ;Below is copyed form PXACT^IBD21PT2
PXACT ; -- if pce is installed, activate the selection package interfaces
 D BMES^XPDUTL("Activate the selection package interfaces in AICS for PCE")
 N I,J
 K X,Y
 I $D(^AUTTEDT(0)) D  ; education topics installed
 .F I=1:1 S X=$P($T(INTRFCE+I),";;",2) Q:X=""  D
 ..S IBDIEN=$O(^IBE(357.6,"B",X,0))
 ..Q:'IBDIEN
 ..Q:$G(^IBE(357.6,IBDIEN,0))=""
 ..Q:$P($G(^IBE(357.6,IBDIEN,0)),"^",9)=1  ;already available
 ..S $P(^IBE(357.6,IBDIEN,0),"^",9)=1 ;makes it available
 ..D BMES^XPDUTL(">>> AICS interface ",X," now available.")
 ;
AICSPROT ;
 D BMES^XPDUTL("Attach other packages' protocol to PCE's protocols.")
 N IBDF,PXCA,PXK,IBDFNAME,PXCANAME,PXKNAME
 K DIC,DA,X,Y
 S IBDFNAME="IBDF PCE EVENT"
 S IBDF=$O(^ORD(101,"B",IBDFNAME,0))
 S PXCANAME="PXCA DATA EVENT"
 S PXCA=$O(^ORD(101,"B",PXCANAME,0))
 S PXKNAME="PXK VISIT DATA EVENT"
 S PXK=$O(^ORD(101,"B",PXKNAME,0))
 I IBDF>0 D
 . S DIC(0)="LSX"
 . S DIC("P")=$P(^DD(101,10,0),"^",2)
 . I PXCA>0 D
 .. D MES^XPDUTL("  Adding protocol "_IBDFNAME_" to extended action protocol "_PXCANAME)
 .. S DA(1)=PXCA
 .. I $O(^ORD(101,DA(1),10,"B",IBDF,0))>0 D MES^XPDUTL("    ... already there") Q
 .. S DIC="^ORD(101,"_DA(1)_",10,"
 .. S X=IBDFNAME
 .. D ^DIC
 . I PXK>0 D
 .. D MES^XPDUTL("  Adding protocol "_IBDFNAME_" to extended action protocol "_PXKNAME)
 .. S DA(1)=PXK
 .. I $O(^ORD(101,DA(1),10,"B",IBDF,0))>0 D MES^XPDUTL("    ... already there") Q
 .. S DIC="^ORD(101,"_DA(1)_",10,"
 .. S X=IBDFNAME
 .. D ^DIC
 Q
 ;
SDAMPROT ;
 N IBDF,PXCA,PXK,IBDFNAME,PXCANAME,PXKNAME
 K DIC,DA,X,Y
 S SDAMNAME="SDAM PCE EVENT"
 S SDAM=$O(^ORD(101,"B",SDAMNAME,0))
 S PXKNAME="PXK VISIT DATA EVENT"
 S PXK=$O(^ORD(101,"B",PXKNAME,0))
 I SDAM>0 D
 . S DIC(0)="LSX"
 . S DIC("P")=$P(^DD(101,10,0),"^",2)
 . I PXK>0 D
 .. D MES^XPDUTL("  Adding protocol "_SDAMNAME_" to extended action protocol "_PXKNAME)
 .. S DA(1)=PXK
 .. I $O(^ORD(101,DA(1),10,"B",SDAM,0))>0 D MES^XPDUTL("    ... already there") Q
 .. S DIC="^ORD(101,"_DA(1)_",10,"
 .. S X=SDAMNAME
 .. D ^DIC
 Q
 ;
 ;
PACKAGE ;Remove the old package entries that are no longer used.
 N PACKAGE,NAME
 N DA,DIC,DIK
 D BMES^XPDUTL("Deleting old package file entries & Deleting old Order Parameters.")
 F NAME="PCE PATIENT/IHS SUBSET" D
 . K DA,DIC
 . S DIC=9.4
 . S DIC(0)="IOSX"
 . S X=NAME
 . D ^DIC
 . I +Y>0 D
 .. S PACKAGE=+Y
 .. I $O(^ORD(100.99,1,5,PACKAGE,""))]"" D
 ... ;Remove the Order Parameter entry for this package.
 ... K DIK
 ... S DIK="^ORD(100.99,1,5,"
 ... S DA(1)=1,DA=PACKAGE
 ... D MES^XPDUTL("  Deleting Order Parameter for package -- "_NAME)
 ... I DA>0 D ^DIK
 .. D MES^XPDUTL("  Deleting Package ++ "_NAME)
 .. K DIK
 .. S DIK="^DIC(9.4,"
 .. S DA=PACKAGE
 .. D ^DIK
 Q
 ;
QUE ; Queue job to populate IHS Patient File #9000001
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE
 N PXPTLOC,DINUM,PXPTLAST
 D GETLOC^PXPTPOST
 I 'PXPTLOC D  Q
 . D MES^XPDUTL($C(7)_$C(7)_"Could not start the task job.")
 . D MES^XPDUTL("You should start it by doing:  D QUE^PXPTPOST  at the programmers prompt.")
 S PXPTLAST=$P($G(^PX(815,1,"PXPT")),"^",2)
 I PXPTLAST>0 S $P(^PX(815,1,"PXPT"),"^",2)=0
Q1 D BMES^XPDUTL("Populating the Patient/IHS File #9000001 via the following queued job ... ")
 S ZTRTN="LOAD^PXXDPT",ZTDESC="Patient File (#9000001) Population",ZTIO=""
 S ZTDESC="Populating the Patient/IHS File"
 S ZTDTH=$H,ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL("The job is task # "_ZTSK)
 I '$D(ZTSK) D MES^XPDUTL("Could not start the task job.") D BMES^XPDUTL("You should start it by doing:  D QUE^PXPTPOST  at the programmers prompt.")
 D MES^XPDUTL("")
 Q
 ;
