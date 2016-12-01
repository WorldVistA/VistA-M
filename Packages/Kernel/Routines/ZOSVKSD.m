%ZOSVKSD ;OAK/KAK/RAK/JML - ZOSVKSD - Calculate Disk Capacity ;9/1/2015
 ;;8.0;KERNEL;**121,197,268,456,568**;Jul 26, 2004;Build 48
 ;
 ; This routine will help to calculate disk capacity for
 ; Cache system platforms by looking up volume set table information
 ;
EN(SITENUM,SESSNUM,OS) ;-- called by routine SYS+2^KMPSLK
 ;--------------------------------------------------------------------
 ; SITENUM = Station number of site
 ; SESSNUM = SAGG session number
 ; VOLS    = Array containing names of monitored volumes
 ; OS      = Type of M platform (CVMS, CWINNT)
 ;
 ; Returns ^XTMP("KMPS",SITENUM,SESSNUM,"@VOL",vol_name) = vol_size
 ;--------------------------------------------------------------------
 ;
 Q:'$G(SITENUM)
 Q:$G(SESSNUM)=""
 Q:$G(OS)=""
 ;
 D ALLOS
 ;
 Q
 ;
ALLOS ; Using InterSystems APIs.  Designed to work on all OS's
 N KMPSARR,KMPSDIR,KMPSRNS,KMPSTNS,KMPSPTR
 ; 
 ; KMPS*2.0*1 -- now monitoring all volume sets
 ;
 S KMPSDIR="",KMPARR=""
 S KMPSRNS=$ZU(5),KMPSTNS=$ZU(5,"%SYS")
 F  S KMPSDIR=$O(^SYS("UCI",KMPSDIR)) Q:KMPSDIR=""  D
 .Q:$G(^SYS("UCI",KMPSDIR))]""
 .; get TOTAL BLOCKS for directory
 .S KMPSPTR=##class(SYS.Database).%OpenId(KMPSDIR)
 .; quit if not mounted
 .Q:KMPSPTR.Mounted'=1
 .;
 .S KMPSARR("KMPS",SITENUM,SESSNUM,"@VOL",KMPSDIR)=KMPSPTR.Blocks
 S KMPSTNS=$ZU(5,KMPSRNS)
 S KMPSDIR=""
 F  S KMPSDIR=$O(KMPSARR("KMPS",SITENUM,SESSNUM,"@VOL",KMPSDIR)) Q:KMPSDIR=""  D
 .S ^XTMP("KMPS",SITENUM,SESSNUM,"@VOL",KMPSDIR)=KMPSARR("KMPS",SITENUM,SESSNUM,"@VOL",KMPSDIR)
 Q
 ;
KMPVVSTM(KMPVDATA) ; Get storage metrics for Vista Storage Monitor (VSTM) within VistA System Monitor (VSM)
 S U="^"
 D GETENV^%ZOSV S KMPVNODE=$P(Y,U,3) ;  IA 10097
 ; get current namespace, switch to %SYS
 S KMPVRNS=$ZU(5),KMPVTNS=$ZU(5,"%SYS")
 S KMPVDIR=""
 S KMPVTNS=$ZU(5,"%SYS")
 F  S KMPVDIR=$O(^SYS("UCI",KMPVDIR)) Q:KMPVDIR=""  D
 .Q:$G(^SYS("UCI",KMPVDIR))]""
 .S KMPVDB=##class(SYS.Database).%OpenId(KMPVDIR)
 .S KMPVMAX=KMPVDB.MaxSize,KMPVSIZE=KMPVDB.Size
 .S KMPVBSIZ=KMPVDB.BlockSize,KMPVBPM=KMPVDB.BlocksPerMap
 .S KMPVSTAT=KMPVDB.GetFreeSpace(KMPVDIR,.KMPVFMB,.KMPVFBLK)
 .S KMPVSYSD=KMPVDB.IsSystemDB(KMPVDIR),KMPVESIZ=KMPVDB.ExpansionSize
 .; MaxSize(MB)^Current Size(MB)^Block Size(int)^Bocks per Map(int)^Free space(MB)^
 .; Free Space(int-Blocks)^System Dir(bool)^Expansion size
 .S KMPVDATA(KMPVDIR)=KMPVMAX_U_KMPVSIZE_U_KMPVBSIZ_U_KMPVBPM_U_KMPVFMB_U_KMPVFBLK_U_KMPVSYSD_U_KMPVESIZ
 ; Execute FreeSpace Query to add Directory Free Space
 S KMPVFLAG="*"
 S KMPVRSET=##class(%Library.ResultSet).%New("SYS.Database:FreeSpace")
 D KMPVRSET.Execute(KMPVFLAG,0)
 While (KMPVRSET.Next()) {
  I (KMPVRSET.Data("Available")["Dismounted") continue
  S KMPVDFSP=KMPVRSET.Data("DiskFreeSpace"),KMPVDIR=KMPVRSET.Data("Directory")
  I $D(KMPVDATA(KMPVDIR)) S $P(KMPVDATA(KMPVDIR),"^",9)=KMPVDFSP
 }
 D KMPVRSET.Close()
 ; Switch back to production namespace
 S KMPVTNS=$ZU(5,KMPVRNS)
 Q
