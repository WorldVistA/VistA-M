XUINP275 ;ISF/RWF - PATCH 275 PRE/POST INSTALL ;06/28/2004  14:26
 ;;8.0;KERNEL;**275**;Jul 10, 1995
PRE ;PRE-init
 Q
POST ;POST-INIT
 D ALT1,ALT2
 Q
ALT1 ;ALTERNATE EDITOR GTM/VMS
 Q:$G(^%ZOSF("OS"))'["GT.M"
 N FDA,WP
 S WP(1)="Call to the VAX VMS EDT editor to process FileMan wordprocessing fields."
 S WP(2)="Creates a temporary VMS file in the default directory with a name of"
 S WP(3)="'DIWE$'_$JOB_'.TMP'.  This version will remove the two copies of the file"
 S WP(4)="that EDT leaves behind."
 S FDA(1.2,"?+1,",.01)="VMSEDT - GTM",FDA(1.2,"?+1,",1)="G GTMVMS^XTEDTVXD"
 S FDA(1.2,"?+1,",2)="I $ZV[""VMS""",FDA(1.2,"?+1,",7)="WP"
 D UPDATE^DIE("","FDA","IEN")
 Q
ALT2 ;ALTERNATE EDITOR Cache/VMS
 Q:$G(^%ZOSF("OS"))'["OpenM"
 Q:$ZV'["VMS"
 N FDA,WP
 S WP(1)="Call to the VAX VMS EDT editor to process FileMan wordprocessing fields."
 S WP(2)="Creates a temporary VMS file in the default directory with a name of"
 S WP(3)="'DIWE$'_$JOB_'.TMP'.  This version will remove the two copies of the file"
 S WP(4)="that EDT leaves behind."
 S FDA(1.2,"?+1,",.01)="VMSEDT - CACHE",FDA(1.2,"?+1,",1)="G CACHE^XTEDTVXD"
 S FDA(1.2,"?+1,",2)="I $ZV[""VMS""",FDA(1.2,"?+1,",7)="WP"
 D UPDATE^DIE("","FDA","IEN")
 Q
