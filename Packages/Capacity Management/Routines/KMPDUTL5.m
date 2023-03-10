KMPDUTL5 ;OIFO/KAK - Obtain CPU Configuration;28 Feb 2002 ;2/17/04  10:56
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
 ;;
CPU(ARRAY) ;-- get cpu configuration information
 ;---------------------------------------------------------------------
 ; ARRAY = passed back by reference
 ; returns array with CPU information:
 ;                          piece : information
 ;       ARRAY(nodename) =    1   : type of cpu
 ;                            2   : number of processors
 ;                            3   : processor speed
 ;                            4   : amount of memory
 ;---------------------------------------------------------------------
 ;
 N ZV
 ;
 S ZV=$$MPLTF^KMPDUTL1
 ;
 S U="^"
 I (ZV["DSM") D DSM(.ARRAY)
 I (ZV["CVMS") D CVMS(.ARRAY,1)
 I (ZV["CWINNT") D CWINNT(.ARRAY,1)
 Q
 ;
DSM(CPUINFO) ;-- for DSM Platform
 ;---------------------------------------------------------------------
 ; CPUINFO = array passed back by reference - see CPU(ARRAY) above
 ;---------------------------------------------------------------------
 ;
 N CLSTRMEM,CSID,CSIDARRY,NODE,NODEARRY,X
 ;
 S CLSTRMEM=$ZC(%GETSYI,"CLUSTER_MEMBER")
 ;
 ; not in cluster environment
 I 'CLSTRMEM D  Q
 .S NODE=$ZC(%GETSYI,"NODENAME")
 .S CPUINFO(NODE)=$ZC(%GETSYI,"HW_NAME")_U_$ZC(%GETSYI,"ACTIVECPU_CNT")
 ;
 ; in cluster environment
 D CLSTR
 S X="ERR^ZU",@^%ZOSF("TRAP")
 S NODE=""
 F  S NODE=$O(NODEARRY(NODE)) Q:NODE=""  D
 .S CSID=NODEARRY(NODE)
 .S CPUINFO(NODE)=$ZC(%GETSYI,"HW_NAME",CSID)_U_$ZC(%GETSYI,"ACTIVECPU_CNT",CSID)
 Q
CLSTR ; get %GETSYI using wild card to get CSID and NODENAME for all nodes
 ;
 N X
 S X="ERRCLU^KMPDUTL5",@^%ZOSF("TRAP"),$ZE=""
 S CSIDARRY($ZC(%GETSYI,"NODE_CSID",-1))=""
 F  S CSIDARRY($ZC(%GETSYI,"NODE_CSID",""))=""
ERRCLU I $ZE'["NOMORENODE" ZQ
 N CSID
 S CSID=""
 F  S CSID=$O(CSIDARRY(CSID)) Q:CSID=""  S NODEARRY($ZC(%GETSYI,"NODENAME",CSID))=CSID
 Q
 ;
CVMS(CPUINFO,TYP) ;-- for Cache for OpenVMS Platform
 ;---------------------------------------------------------------------
 ; input: TYP = type of system information requested
 ;                1 : cpu system information
 ;                2 : operating system version information
 ;
 ; CPUINFO = array passed back by reference
 ;           : for TYP=1 see CPU(ARRAY) line tag above
 ;           : for TYP=2 CPUINFO(1)=os version
 ;---------------------------------------------------------------------
 ;
 N DFILE,DIR,DLOG,FILE,FILESPEC,LOG,TYPNM,Y
 ;
 S TYPNM=$S(TYP=1:"CPU",TYP=2:"VER",1:"")
 ;
 S DIR=$ZU(12)
 ;
 ; cleanup com file and log file
 S FILE=DIR_"KMPDU"_TYPNM_".COM"
 S DFILE="KMPDU"_TYPNM_".COM"
 S LOG=DIR_"KMPDU"_TYPNM_".LOG"
 S DLOG="KMPDU"_TYPNM_".LOG"
 S FILESPEC(DFILE)=""
 S FILESPEC(DLOG)=""
 S Y=$$DEL^%ZISH(DIR,.FILESPEC)
 ;
 ; create com file   quit on file creation error
 Q:$$CREATE(FILE,TYP)<0
 ;
 ; run com file and create log file
 I $ZF(-1,"",LOG,FILE)
 C LOG
 ;
 ; parse log file
 D PARSE(LOG,.CPUINFO,TYP)
 ;
 ; cleanup com file and log file
 K FILESPEC
 S FILESPEC(DFILE)=""
 S FILESPEC(DLOG)=""
 S Y=$$DEL^%ZISH(DIR,.FILESPEC)
 ;
 Q
 ;
CWINNT(CPUINFO,TYP) ;-- for Cache for Windows NT Platform
 ;---------------------------------------------------------------------
 ; input: TYP = type of system information requested
 ;                1 : cpu system information
 ;                2 : operating system version information
 ;
 ; CPUINFO = array passed back by reference
 ;           : for TYP = 1 see CPU(ARRAY) line tag above
 ;           : for TYP = 2 CPUINFO(1)=os version
 ;---------------------------------------------------------------------
 ;
 N DATA,FILE,I,NODE,OUT,POP,X
 S:'$G(DTIME) DTIME=30
 ;
 S DATA="",OUT=0
 ;
 ; $zu(110) = computername
 S (FILE,NODE)=$ZU(110)
 S CPUINFO(NODE)=""
 ;
 ; cleanup all report files
 I $ZF(-1,"DEL "_FILE_"*.TXT")
 ;
 S FILE=FILE_".TXT"
 ;
 ; send system reort to file
 ; switches: /s => summary report
 ;           /a => all report
 ;           /f => send to file named 'computername.TXT'
 I $ZF(-1,"WINMSD /s /f")
 ;
 S X="EOF1",@^%ZOSF("TRAP")
 ;
 ; read from report file
 D OPEN^%ZISH("CWINNT","",FILE,"R")
 Q:POP
 U IO
 ;
 ; TYP=1 => cpu information
 I TYP=1 D
 .F  R X:DTIME Q:$$STATUS^%ZISH  D  Q:OUT
 ..; type of cpu
 ..I X["Hardware Abstraction Layer:" S $P(DATA,U)=$$STRIP^KMPDUTL4($P(X,"Hardware Abstraction Layer:",2)) Q
 ..; number of processors
 ..I X["NUMBER_OF_PROCESSORS=" S $P(DATA,U,2)=$P(X,"NUMBER_OF_PROCESSORS=",2) Q
 ..; processor speed - no information available
 ..; amount of memory
 ..I X["Physical Memory (K)" D  Q
 ...R X:DTIME I $$STATUS^%ZISH S OUT=1 Q
 ...I X["Total:" S $P(DATA,U,4)=$$STRIP^KMPDUTL4($$COMMA^KMPDUTL4($P(X,"Total:",2)))\1024 Q
 ..S CPUINFO(NODE)=DATA
 ;
 ; TYP=2 => os version
 I TYP=2 D
 .F  R X:DTIME Q:$$STATUS^%ZISH  D  Q:OUT
 ..; version of operating system
 ..I X["OS Version Report" D
 ...F I=1:1:2 R X:DTIME I $$STATUS^%ZISH S OUT=1 Q
 ...S DATA=X
 ...S DATA=DATA_" "_X
 ...S CPUINFO(1)=DATA
 ;
 D CLOSE^%ZISH("CWINNT")
 ;
 Q
 ;
CREATE(FILE,TYP) ;-- function to create new com file
 ;---------------------------------------------------------------------
 ; input: FILE = name of file to create
 ;        TYP  = type of system information requested
 ;                 1 : cpu system information
 ;                 2 : operating system version information
 ;
 ; returns:  1 successful file creation
 ;          -1 failure of file creation
 ;---------------------------------------------------------------------
 ;
 N DIR,TYPNM
 ;
 S TYPNM=$S(TYP=1:"CPU",TYP=2:"VER",1:"")
 ;
 O FILE:("NWC"):0 Q:'$T -1
 ;
 U FILE
 W "$! KMPDU"_TYPNM_".COM - Obtain System Configuration Information"
 W "$!--------------------------------------------------------"
 W "$! OIFO - CAPACITY PLANNING/KAK"
 W "$! "_$P($T(+2)_";;",2,999)
 W "$!--------------------------------------------------------"
 W "$!"
 ;
 I TYP=2 D  G TAGXIT
 .W "$   write sys$output ""VERSION=""   , f$getsyi(""VERSION"")"
 ;
 W "$ if f$getsyi(""CLUSTER_MEMBER"") .eqs. ""FALSE"" then goto NOT_CLUSTER"
 W "$ CONTEXT = """""
 W "$START:"
 W "$   ID = f$csid(CONTEXT)"
 W "$   if ID .eqs. """" then goto EXIT"
 W "$   write sys$output ""NODE=""    , f$getsyi(""NODENAME"",,ID)"
 W "$   write sys$output ""TYPE=""    , f$getsyi(""HW_NAME"",,ID)"
 W "$   write sys$output ""CPU_CNT="" , f$getsyi(""ACTIVECPU_CNT"",,ID)"
 W "$   write sys$output ""SPEED=n/a"""
 W "$   write sys$output ""MEMSIZE="" , f$getsyi(""MEMSIZE"",,ID)"
 W "$   goto START"
 W "$NOT_CLUSTER:"
 W "$   write sys$output ""NODE=""    , f$getsyi(""NODENAME"")"
 W "$   write sys$output ""TYPE=""    , f$getsyi(""HW_NAME"")"
 W "$   write sys$output ""CPU_CNT="" , f$getsyi(""ACTIVECPU_CNT"")"
 W "$   write sys$output ""SPEED=n/a"""
 W "$   write sys$output ""MEMSIZE="" , f$getsyi(""MEMSIZE"")"
TAGXIT ;
 W "$EXIT:"
 W "$   write sys$output ""*EOF*"""
 W "$ exit"
 W "$!"
 ;
 C FILE
 Q 1
 ;
PARSE(LOG,CPUARRY,TYP) ;-- parse log file data
 ;---------------------------------------------------------------------
 ; input: LOG = name of log file to parse
 ;        TYP = type of system information requested
 ;                1 : cpu system information
 ;                2 : operating system version information
 ;
 ; CPUARRY = passed back by reference
 ;           : for TYP=1 see CPU(ARRAY) line tag above
 ;           : for TYP=2 CPUINFO(1)=os version
 ;---------------------------------------------------------------------
 ;
 N NODE,X
 ;
 S X="EOF",@^%ZOSF("TRAP"),NODE=""
 K X S U="^"
 ;
 D OPEN^%ZISH("LOG",DIR,DLOG,"R")
 Q:POP
 U IO
 ;
 I TYP=1 D
 .F  R X:DTIME Q:$$STATUS^%ZISH  I $E(X)'="$" I X["NODE=" D
 ..I X["NODE=" S NODE=$P(X,"=",2)
 ..F  R X:DTIME  I $E(X)'="$" D  Q:X["MEMSIZE="
 ...; type of cpu
 ...I X["TYPE=" S $P(CPUARRY(NODE),U)=$P(X,"=",2) Q
 ...; number of processors
 ...I X["CPU_CNT=" S $P(CPUARRY(NODE),U,2)=$P(X,"=",2) Q
 ...; processor speed - no information available
 ...I X["SPEED=" Q
 ...; amount of memory in MB
 ...I X["MEMSIZE=" S $P(CPUARRY(NODE),U,4)=$P(X,"=",2)/128 Q
 ;
 I TYP=2 D
 .F  R X:DTIME Q:$$STATUS^%ZISH  I $E(X)'="$" D
 ..; version of operating system
 ..I X["VERSION=" S CPUARRY(1)=$P(X,"=",2) Q
 ;
 D CLOSE^%ZISH("LOG")
 ;
 S X="ERR^ZU",@^%ZOSF("TRAP")
 Q
 ;
EOF ;-- end of file condition for CVMS
 S X="ERR^ZU",@^%ZOSF("TRAP")
 D CLOSE^%ZISH("LOG")
 Q
 ;
EOF1 ;-- end of file condition for CWINNT
 S X="ERR^ZU",@^%ZOSF("TRAP")
 D CLOSE^%ZISH("CWINNT")
 Q
 ;
CVMSVER() ;-- returns version of Cache for OpenVMS operating system
 ;
 N VER
 ;
 D CVMS(.VER,2)
 Q $S($D(VER(1)):VER(1),1:"")
 ;
CWNTVER() ;-- returns version of Cache for Windows NT operating system
 ;
 N VER
 ;
 D CWINNT(.VER,2)
 Q $S($D(VER(1)):VER(1),1:"")
