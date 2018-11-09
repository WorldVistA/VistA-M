XU8P672 ;SFIRMFO/MAF -POST-install;04/22/2015  14:20
 ;;8.0;KERNEL;**672**;APR 22, 2015;Build 28
 ;Per VHA Directive 2004-038, this routine should not be modified.
 D BMES^XPDUTL("                    *** Running post-init for patch XU*8.0*672 ***")
 N XUPKGID,XUPKGFL,DA,X,XUFLG
 S XUPKGID=$O(^DIC(9.4,"B","KERNEL",0)) I $D(^DIC(9.4,+XUPKGID,0)) D
 .D BMES^XPDUTL("Checking system for package file entry for KERNEL that is associated")
 .D MES^XPDUTL("with patient merge - delete entry")
 .S X=0,XUFLG=0
 .F X=0:0 S X=$O(^DIC(9.4,XUPKGID,20,X)) Q:X'>0  I $D(^DIC(9.4,XUPKGID,20,X,0)),$P($G(^DIC(9.4,XUPKGID,20,X,0)),"^",1)=2 S XUPKGFL=X D
 . .S DA(1)=XUPKGID,DA=XUPKGFL S DIK="^DIC(9.4,"_DA(1)_",20,"
 . .D ^DIK D BMES^XPDUTL("*** Entry found and deleted!") S XUFLG=1
 . .K DIK,DA
 . . Q
 .Q
 I 'XUFLG D BMES^XPDUTL("*** No entry found!")
 D BMES^XPDUTL(" ")
 Q
