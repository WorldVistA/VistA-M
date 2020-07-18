CVERCVT	;Routine for making VistA changes based on OS
	;
	; 11/21/10 - based on VRO conversion utility
	; 02/07/12 - updates for standard Linux VistA
	;	     spool = /srv/vista/<scd>/spl/spool
	;	     hfs = /srv/vista/<scd>/spl/hfs
	;	     chown <scd>cacheusr for Linux paths
	;	     S MIXED OS = 0 for Linux
	; 06-08-12 - new update for standard spl and hfs to 
	;	     hfs = /srv/vista/<scd>/user/hfs
        ;            spool = /srv/vista/<scd>/user/print	     
	; 08-06-12 - added class recompile
	; 09-15-12 - added full routine recompile 
	;	     hfs"/" added
	;	     prompt for class and routine recompile
        ; 05-03-13 - commented out the class recompile directive
	; 06-07-13 - update the HFS device search criteria 
	; 08-25-13 - added code to kill ^DIZ("foo")
	; 04-30-14 - added code to look for spool device "USER$:[SPOOL]" and null device "_NLA0:"
	; 03-14-17 - added code to look for spool with SPL$, hfs devices with HFS.TXT, and P-MESSAGE devices with MESSAGE.TXT
	; share proper syntax
	W !,"CVERCVT routine syntax: D START^CVERCVT(""x"") where x ="
	W !
	W !,"A for Auto sense the operating system"
	W !,"L for Linux"
	W !,"W for Windows"
	W !,"V for VMS"
	W !
	W !,"NOTE: Run the utility from within the VistA namespace to be converted"
	W !
	;	
START(VER)	; pass the OS version to convert to or A for auto
	N VERS,USCD,LSCD
	S VERS=$G(VER)
	I (VERS="")!("LWVAlwva"'[VERS) D  Q
	.W !,"CVERCVT routine syntax: D START^CVERCVT(""x"") where x ="
	.W !
	.W !,"A for Auto sense the operating system"
	.W !,"L for Linux"
	.W !,"W for Windows"
	.W !,"V for VMS"
	.W !
        .W !,"Run the utility from within the VistA namespace to be converted"
        .W !
	;W !,"CAUTION!! The CVERCVT routine is intended only for" 
	;W !,"Intersystems Cache' test or development environments,"
	;W !,"NOT FOR PRODUCTION VISTA CONFIGURATIONS!"
	W !
	;R !,"With this in mind, press any key to continue or ""^"" to abort: ",X:90
	;Q:X="^"
	;
	; upper and lowercase site code
        S USCD=$E($P($SYSTEM,":",2),1,3)
        s upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        s lower="abcdefghijklmnopqrstuvwxyz"
        S LSCD=$TR(USCD,upper,lower)
	I "Aa"[VERS D DEFENV  Q:VERS=""
	D SETUP  Q:VERS=""
	D SPLRES
	D NULRES
	D TNTRES
	D CONSRES
	D HFSRES
	D PMESRES
	D PARMRES
	D FOOKILL
	;D CLRCMPL
	;W !,"Conversion complete!"
	Q
SETUP ;Set potentially required variables
	N X,RC,CFG,CNSP,DNSP
	S:'$D(U) U="^"
	S:+$G(DTIME)'>0 DTIME=300
	S:'$D(DUZ) DUZ=.5
	S:$G(DUZ(0))'="@" DUZ(0)="@"
	S:+$G(DT)'>0 DT=$$DT^XLFDT()
	I VERS="L" S VNAME="Linux"
	I VERS="W" S VNAME="Windows"
	I VERS="V" S VNAME="VMS"
	W !,"The OS selected is "_VNAME_". If this is correct"
	R !,"press any key to continue or ""^"" to abort: ",X:90
	I X="^" S VERS="" Q
	W !,"Cache OS version = "_VNAME
	S CNSP=$ZU(5)
	W !, "Current namespace = "_$ZU(5)
	w !, "Current site code to use for hfs and spool directories = "_LSCD
	U $P
	W !,"Setup done..."
	Q
	;
DEFENV	;Define the current environment
	;
	N VNAME,X
	S VERS=""
	I $F($ZV,"Linux")'=0 s VERS="L",VNAME="Linux"
	I $F($ZV,"Windows")'=0 s VERS="W",VNAME="Windows"
	I $F($ZV,"VMS")'=0 s VERS="V",VNAME="VMS"
	I VERS="" W !,"WARNING! Unable to determine the current OS...Aborting!" Q
	Q
SPLRES	; reset SPOOL devices
	N SPL,ODEV,AXXI
        N DIE,DA,DR
	I VERS="L" s SPL="/srv/vista/"_LSCD_"/user/print" S X=$ZF(-2,"mkdir -p /srv/vista/"_LSCD_"/user/print") s X=$ZF(-2,"chown -R "_LSCD_"cacheusr:"_LSCD_"cacheusr /srv/vista/"_LSCD_"/print") 
	I VERS="W" s SPL="C:\SPOOLER" S X=$ZF(-2,"md c:\SPOOLER")
	I VERS="V" s SPL="USER$:[SPOOLER]" S X=$ZF(-2,"create/dir USER$:[SPOOLER]")
        W !,"Resetting DEVICE file spool device(s) $I to "_SPL_"..."
        S AXXI=0
        F ODEV="c:\SPOOLER","USER$:[SPOOL]","USER$:[SPOOLER]","SPL$","/srv/vista/"_LSCD_"/print" I ODEV'=SPL D
        .F  S AXXI=$O(^%ZIS(1,"C",ODEV,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_ODEV
        ..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
        ..S DIE="^%ZIS(1,"
        ..S DA=AXXI
        ..S DR="1///^S X=SPL"
        ..D ^DIE K DIE,DA,DR
        K ODEV,SPL,AXXI
	W "...done.",!
	Q
NULRES	; null device reset
	N ODEV,NDEV,AXXI
	N DIE,DA,DR
	I VERS="L" s NDEV="/dev/null"
	I VERS="W" s NDEV="//./nul"
	I VERS="V" s NDEV="NLA0:"
	W !,"Resetting DEVICE file NULL device(s) $I to "_NDEV_"..."
	S AXXI=0
	F ODEV="/dev/nul","/dev/null","//./nul","_NLA0:","NLA0:" I ODEV'=NDEV D
	.F  S AXXI=$O(^%ZIS(1,"C",ODEV,AXXI)) Q:'AXXI  D
	..W !,AXXI_"="_ODEV 
	..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
	..S DIE="^%ZIS(1,"
	..S DA=AXXI
	..S DR="1///^S X=NDEV"
	..D ^DIE K DIE,DA,DR
	K ODEV,NDEV,AXXI
	W "...done.",!
	Q
TNTRES	; telnet device reset
	N TDEV,OTDEV,AXXI
	N DIE,DA,DR
	I VERS="L" s TDEV="/dev/pts"
	I VERS="W" s TDEV="|TNT|"
	I VERS="V" s TDEV="TNA"
	W !,"Resetting DEVICE file TNA VIRTUAL device(s) $I to "_TDEV_"..."
	S AXXI=0
	F OTDEV="/dev/pts","|TNT|","TNA" I OTDEV'=TDEV D
	.F  S AXXI=$O(^%ZIS(1,"C",OTDEV,AXXI)) Q:'AXXI  D
	..W !,AXXI_"="_OTDEV 
	..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
	..S DIE="^%ZIS(1,"
	..S DA=+AXXI
	..S DR="1///^S X=TDEV"
	..D ^DIE K DIE,DA,DR
	K TDEV,OTDEV,AXXI
	W "...done.",!
	Q
CONSRES	; console device reset
	N OCDEV,CDEV,AXXI
	N DIE,DA,DR
	I VERS="L" s CDEV="/dev/tty"
	I VERS="W" s CDEV="|TRM|"
	I VERS="V" s CDEV="OPA"
	W !,"Resetting DEVICE file CONSOLE device(s) $I to "_CDEV_"..."
	S AXXI=0
	F OCDEV="/dev/tty","|TRM|","OPA" I OCDEV'=CDEV  D
	.F  S AXXI=$O(^%ZIS(1,"C",OCDEV,AXXI)) Q:'AXXI  D
	..W !,AXXI_"="_OCDEV
	..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
	..S DIE="^%ZIS(1,"
	..S DA=+AXXI
	..S DR="1///^S X=CDEV"
	..D ^DIE K DIE,DA,DR
	K OCDEV,CDEV,AXXI
	W "...done.",!
	Q
HFSRES	; HSF device reset
	N HFS,OHFS,OHFS1,AXXI
	N DIE,DA,DR
	I VERS="L" s HFS="/srv/vista/"_LSCD_"/user/hfs/" S X=$ZF(-2,"mkdir -p /srv/vista/"_LSCD_"/user/hfs/") s X=$ZF(-2,"chown -R "_LSCD_"cacheusr:"_LSCD_"cacheusr /srv/vista/"_LSCD_"/user")
	I VERS="W" s HFS="c:\HFS" S X=$ZF(-2,"md c:\HFS")
	I VERS="V" s HFS="USER$:[HFS]" S X=$ZF(-2,"create/dir USER$:[HFS]")
	W !,"Resetting DEVICE file HFS device(s) $I values to "_HFS_"..."
	S AXXI=0
	F OHFS="TMP.DAT","tmp.dat","USER$:[HFS]","HFS.TXT""/HFS",$ZU(5)_"_HFS$:[HFS]" I OHFS'=HFS D
	.S OHFS1="" F  S OHFS1=$O(^%ZIS(1,"C",OHFS1)) Q:OHFS1=""  I $G(OHFS1)[$G(OHFS) D
	..F  S AXXI=$O(^%ZIS(1,"C",OHFS1,AXXI)) Q:'AXXI  D
	...W !,AXXI_"="_OHFS1_" which contains "_OHFS
	...W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
	...S DIE="^%ZIS(1,"
	...S DA=+AXXI
	...S DR="1///^S X=HFS"
	...D ^DIE K DIE,DA,DR
        W "...done.",!
        W !,"Resetting KERNEL SYSTEM PARAMETERS file PRIMARY HFS DIRECTORY to "_HFS_"..."
        S ^XTV(8989.3,1,"DEV")=HFS
        ; if Linux also set MIXED OS to 0/No
        I VERS="L" S $P(^XTV(8989.3,1,0),"^",5)=0
        K HFS,OHFS,OHFS1,AXXI
	W "...done.",!
	Q
PMESRES	; P-MESSAGE device reset
	N PMES,OPMES,AXXI
	N DIE,DA,DR
	I VERS="L" s PMES="/srv/vista/"_LSCD_"/user/hfs/XMHFS.TMP"
	I VERS="W" s PMES="c:\HFS\XMHFS.TMP"
	I VERS="V" s PMES="USER$:[HFS]XMHFS.TMP"
	W !,"Resetting DEVICE file P-MESSAGE device(s) $I values to "_PMES_"..."
	S AXXI=0
	F OPMES="C:\TEMP\XMHFS.TMP","/HFS/XMHFS.TMP","c:\HFS\XMHFS.TMP","MESSAGE.TXT","USER$:[HFS]XMHFS.TMP" I OPMES'=PMES D
	.F  S AXXI=$O(^%ZIS(1,"C",OPMES,AXXI)) Q:'AXXI  D
	..W !,AXXI_"="_OPMES
	..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
	..S DIE="^%ZIS(1,"
	..S DA=+AXXI
	..S DR="1///^S X=PMES"
	..D ^DIE K DIE,DA,DR
	K PMES,OPMES,AXXI
	W "...done.",!
	Q 
PARMRES	; PARAMETERS file reset
	N AXX1,AXXG,AXXGREF,AXXDATA,AXXFIX
	I VERS="L" s HFS="/srv/vista/"_LSCD_"/user/hfs/"
	I VERS="W" s HFS="c:\HFS\"
	I VERS="V" s HFS="USER$:[HFS]"
	W !,"Resetting appropriate PARAMETERS file entry values to "_HFS
	F AXX1=$ZU(5)_"_HFS$:[TMP]",$ZU(5)_"_HFS$:[HFS]","/hfs","C:\HFS","C:\TEMP" I AXX1'=HFS D
	.S AXXG="^XTV(8989.5)",AXXGREF="^XTV(8989.5"
	.F  S AXXG=$Q(@AXXG) Q:AXXG'[AXXGREF  D
	..S AXXDATA=@AXXG
	..I AXXDATA="" K AXXDATA Q
	..S AXXFIX=0
	..S AXXDATA=$$UP^XLFSTR(AXXDATA)
	..I AXXDATA=AXX1 S AXXFIX=1
	..I 'AXXFIX&(AXXDATA["_HFS$:") S AXXFIX=1
	..I AXXFIX=1 S @AXXG=HFS
	..K AXXDATA,AXXFIX
	.K AXX1,AXX2,AXXG,AXXGREF
	W "...done.",!
	Q
CLRCMPL	; class recompile
	;R !,"Press any key to compile ALL ROUTINES or ""^"" to skip: ",X:90
        ;I X'="^"  D
        ;.W !,"Performing full routine recompile..."
        ;.D $SYSTEM.OBJ.CompileList("*.INT","ckfs")
	;.D $SYSTEM.OBJ.CompileList("%DT*.INT","ckfs")
	;.D $SYSTEM.OBJ.CompileList("%RCR*.INT","ckfs")
	;.D $SYSTEM.OBJ.CompileList("%XU*.INT","ckfs")
	;.D $SYSTEM.OBJ.CompileList("%ZIS*.INT","ckfs")
	;.D $SYSTEM.OBJ.CompileList("%ZO*.INT","ckfs")
	;.D $SYSTEM.OBJ.CompileList("%ZT*.INT","ckfs")
	;.D $SYSTEM.OBJ.CompileList("%ZV*.INT","ckfs")
        ;.W !,"Full routine recompile done...",!
        ;R !,"Press any key to compile ALL CLASSES or ""^"" to skip: ",X:90
        ;I X'="^"  D
	;.W !,"Performing full class recompile..."
	;.DO $SYSTEM.OBJ.CompileAll()
	;.W !,"Full class recompile done...",!
	;Q
FOOKILL ; kill the ^DIZ("foo" global when bringing up Cache after migration
	W !,"^DIZ(""foo"") is currently: ",$G(^DIZ("foo"))
	DO ##class(%SYS.System).WriteToConsoleLog("^DIZ(""foo"") killed by CVERCVT routine",0,0)
	K ^DIZ("foo")
	W !,"^DIZ(""foo"") is now: ",$G(^DIZ("foo"))
	Q
