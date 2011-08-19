%ZOSVKSD ;OAK/KAK - Calculate Disk Capacity ;5/9/07  10:36
 ;;8.0;KERNEL;**121,197,268,456**;Jul 26, 2004
 ;
 ; This routine will help to calculate disk capacity for
 ; either DSM or Cache system platforms by looking up
 ; volume set table information
 ;
EN(SITENUM,SESSNUM,VOLS,OS) ;-- called by routine SYS+2^KMPSLK
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
 D @OS
 ;
 Q
 ;
CVMS ;--------------------------------------------------------------------
 ; Version for Cache for OpenVMS platform
 ;--------------------------------------------------------------------
 ;
 ;-- code from routine %FREECNT
 ;
 N DIR
 ;
 S DIR=""
 F  S DIR=$O(^|"%SYS"|SYS("UCI",DIR)) Q:DIR=""  D
 .;
 .N BLKSIZ,DIRUP,ISBIGDB,MAX,SIZE,VOLTOT,X,Y,ZU
 .;
 .Q:$G(^|"%SYS"|SYS("UCI",DIR))]""
 .S X=DIR
 .X ^%ZOSF("UPPERCASE")
 .;
 .; strip off trailing '\' if needed
 .I $E(Y,$L(Y))="\" S Y=$E(Y,1,$L(Y)-1)
 .S DIRUP=Y
 .;
 .; use $ZU(49) to see if directory is mounted
 .S ZU=$ZU(49,DIR)
 .;
 .; quit if directory does not exist or is dismounted
 .Q:ZU<0
 .;
 .; quit is directory is not mounted
 .Q:+ZU=256
 .;
 .S ISBIGDB=0
 .S BLKSIZ=$P(ZU,",",2)
 .;
 .I BLKSIZ>2048 D
 ..S ISBIGDB=1
 ..S VOLTOT=$P(ZU,",",22)
 .;
 .E  D
 ..I $ZBITGET($ZVERSION(0),21) S SIZE=+$P(ZU,",",23),MAX=$P(ZU,",",24)
 ..E  S SIZE=+$P(ZU,",",2),MAX=$P(ZU,",",4)
 ..I 'SIZE Q
 ..S VOLTOT=MAX*SIZE
 .;
 .;-- end of code from routine %FREECNT
 .;
 .D SETNODE(SITENUM,SESSNUM,DIRUP,VOLTOT)
 ;
 Q
 ;
CWINNT ;--------------------------------------------------------------------
 ; Version for Cache for Windows NT platform
 ;--------------------------------------------------------------------
 ;
 ;-- code from routine %FREECNT
 ;
 N DIR,DIRUP,VOLTOT
 N X,Y,ZU
 ;
 S DIR=""
 F  S DIR=$O(^|"%SYS"|SYS("UCI",DIR)) Q:DIR=""  D
 .Q:$G(^|"%SYS"|SYS("UCI",DIR))]""
 .S X=DIR
 .X ^%ZOSF("UPPERCASE")
 .;
 .; strip off trailing '\' if needed
 .I $E(Y,$L(Y))="\" S Y=$E(Y,1,$L(Y)-1)
 .S DIRUP=Y
 .;
 .; use $ZU(49) to see if directory is mounted
 .S ZU=$ZU(49,DIR)
 .;
 .; quit if directory does not exist or is dismounted
 .Q:ZU<0
 .;
 .; quit is directory is not mounted
 .Q:+ZU=256
 .;
 .; volume size = blocks per map * number of maps
 .S VOLTOT=+$P(ZU,",",2)*$P(ZU,",",4)
 .;
 .;-- end of code from routine %FREECNT
 .;
 .D SETNODE(SITENUM,SESSNUM,DIRUP,VOLTOT)
 ;
 Q
 ;
SETNODE(SITENUM,SESSNUM,VOLNAM,VOLTOT) ;
 ; Set the @VOL node in the ^XTMP("KMPS" global array
 ;
 ; quit if SAGG is not monitoring this volume set (directory)
 Q:'$D(VOLS(VOLNAM))
 ;
 S ^XTMP("KMPS",SITENUM,SESSNUM,"@VOL",VOLNAM)=VOLTOT
 Q
 ;
 ;
DCMPST(VERSION) ;-
 ;---------------------------------------------------------------------------
 ;---------------------------------------------------------------------------
 Q:$G(VERSION)="" ""
 I VERSION<5.1 D DecomposeStatus^%DM(RC,.MSGLIST,0,"") Q
 E  D DecomposeStatus^%SYS.DATABASE(RC,.MSGLIST,0,"")
 Q
 ;
GETDIRGL(VERSION) ;-extrinsic function
 ;----------------------------------------------------------------------------
 ; ; set up GLOARRAY array indexed by global name 
 ;----------------------------------------------------------------------------
 Q:$G(VERSION)="" ""
 I VERSION<5.1 Q $$GetDirGlobals^%DM(DIRNAM,.GLOARRAY)
 E  Q $$GetDirGlobals^%SYS.DATABASE(DIRNAM,.GLOARRAY)
 ;
GLOINTEG(VERSION) ;- extrinsic function
 ;----------------------------------------------------------------------------
 ; check integrity of a single global
 ; will stop if there are more than 999 errors with this global
 ;----------------------------------------------------------------------------
 Q:$G(VERSION)="" ""
 I VERSION<5.1 Q $$CheckGlobalIntegrity^%DM(DIRNAM,GLO,999,.GLOTOTBLKS,.GLOPNTBLKS,.GLOTOTBYTES,.GLOPNTBYTES,.GLOBIGBLKS,.GLOBIGBYTES,.GLOBIGSTRINGS,.DATASIZE)
 E  Q $$CheckGlobalIntegrity^%SYS.DATABASE(DIRNAM,GLO,999,.GLOTOTBLKS,.GLOPNTBLKS,.GLOTOTBYTES,.GLOPNTBYTES,.GLOBIGBLKS,.GLOBIGBYTES,.GLOBIGSTRINGS,.DATASIZE)
