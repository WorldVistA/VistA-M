%ZOSVKSD ;OAK/KAK/RAK/JML - ZOSVKSD - Calculate Disk Capacity ;7/25/2004
 ;;8.0;KERNEL;**121,197,268,456,568,670**;3/1/2018;Build 45
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
 S KMPSDIR="",KMPSARR=""
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
 N KMPVRNS,KMPVTNS,KMPVDIR,KMPVDB,KMPVMAX,KMPVSIZE,KMPVBSIZ,KMPVBPM,KMPVSTAT,KMPVFMB
 N KMPVFBLK,KMPVSYSD,KMPVESIZ,KMPVFLAG,KMPVRSET,KMPVDFSP
 S U="^"
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
 ;
KMPVVTCM(KMPVDATA) ; Get Cache metrics for Vista Timed Collection Monitor (VTCM) within VistA System Monitor (VSM)
 N U,KMPVRNS,KMPVTNS
 S U="^"
 ; get current namespace, switch to %SYS
 S KMPVRNS=$ZU(5),KMPVTNS=$ZU(5,"%SYS")
 S KMPVTNS=$ZU(5,"%SYS")
 ;
 S KMPVDATA("KMPVDASH")=##class(SYS.Stats.Dashboard).Sample()
 S KMPVDATA("KMPVROUT")=##class(SYS.Stats.Routine).Sample()
 S KMPVDATA("KMPVSMH")=##class(%SYSTEM.Config.SharedMemoryHeap).GetUsageSummary()
 S KMPVDATA("KMPVMEM")=##class(%SYSTEM.Config.SharedMemoryHeap).FreeCount()
 ;
 ; Return to 'from' namespace
 S KMPVTNS=$ZU(5,KMPVRNS)
 Q
 ;
BLKCOL(KMPVRET) ;
 ; ** Non interactive subset of Intersystems' ^BLKCOL routine - includes parts of BLKCOL and RUNERR line tags
 ;
 N KMPVRNS,KMPVTNS,KMPVSEC,KMPVWAIT,KMPVDET,KMPVCOL,KMPVTO,KMPVCNT,KMPVINFO
 ; get current namespace, switch to %SYS
 S KMPVRNS=$ZU(5),KMPVTNS=$ZU(5,"%SYS")
 S KMPVSEC=10,KMPVWAIT=10,KMPVDET=2,KMPVRET=""
 ;
 S $ZTRAP="RUNERR"
 L +^SYS("BLKCOL"):5 E  Q
 K ^||BLKCOL
 S KMPVCOL=0,KMPVTO=$ZH+KMPVSEC
 F KMPVCNT=1:1:1000 D
 .S KMPVINFO=$zu(190,17)
 .I KMPVINFO]"" S KMPVCOL=KMPVCOL+1
 .H KMPVWAIT/1000
 S KMPVRET=KMPVCNT_","_KMPVCOL
 L -^SYS("BLKCOL")
 ; Return to 'from' namespace
 S KMPVTNS=$ZU(5,KMPVRNS)
 Q
RUNERR ; Trap errors
 S $ZTRAP=""
 L -^SYS("BLKCOL")
 ; Return to 'from' namespace
 S KMPVTNS=$ZU(5,KMPVRNS)
 Q
