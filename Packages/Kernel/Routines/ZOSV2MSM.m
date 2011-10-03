%ZOSV2 ;CLKS/SO MSM - JOB OUT RTHISTJB - MUST BE IN MGR UCI ;02/10/95  10:38
 ;;8.0;KERNEL;;JUL 03, 1995
START Q
RTHSTOP Q
RTH ;FROM TASKMAN DRIVER 'XUCSTM'
 ; Fire Up RTHISTJB & Begin Data Collection
 S:$D(^RTHIST)'=11 ^RTHIST=0
 S ^RTHIST=^RTHIST+1,IRN=^RTHIST
 ; Set RTHIST job parameters
 S XUCSDUR=3600 ;rthist duration 1 hr.
 S XUCSRI=3600 ;rthist report interval 1 HR.
 S XUCSCDI=300 ;rthist cpu/disk report interval 5 min.
 I $ZV'["MSM-PC" S XUCSCDI=300 ;=PARAM("CPUTIL")
 S XUCSRDES="XUCS C.M. Tasked RTHIST" ;rthist report description
 S XUCSDAT=$P($H,","),XUCSTIM=$P($H,",",2) ; Use Node's Current Date/Time
 S ^RTHIST(IRN)=XUCSDAT_"^"_XUCSTIM_"^"_XUCSRI_"^"_XUCSRDES_"^"_XUCSDUR_"^"_XUCSCDI_"^"_XUCSTBS
RTHCHK ; Check for and remove IN PROGRESS & SUBMITTED - RTHIST's
 ; See Routine: RTHIST
 ; Line: READ+3, OPT=4
 ; Line: TERM:TP+6, OPT=2 & OPT=4
 ; OPT=2 see lines: SAVE:SAVE+3
 ; OPT=4 see lines: TERM2:DISCARD+3
INPROG I $D(^RTHIST("IN PROGRESS")) D
 . S XIRN=^RTHIST("IN PROGRESS")
 . S ^RTHIST(XIRN,"STOP")="SAVE FIRST" ; RTHIST, SAVE+3
 . F  H 1 Q:'$V(53,-5)  ; RTHIST, SAVE+4
 . ;$V(53,-5)>0  if ^RTHISTJB is running
 . I $D(^RTHIST("IN PROGRESS")),'$V(53,-5) K ^RTHIST("IN PROGRESS")
 . Q
 K XIRN
SUBMIT I $D(^RTHIST("SUBMITTED")) D
 . S XIRN=0 F  S XIRN=$O(^RTHIST("SUBMITTED",XIRN)) Q:XIRN=""  S XUCSX=^RTHIST(XIRN) D
 .. I ($P(XUCSX,"^")<XUCSDAT!($P(XUCSX,"^")>XUCSDAT)) K XUCSX Q  ;not today
 .. S XUCSX1=XUCSTIM+XUCSDUR
 .. I $P(XUCSX,"^",2)>XUCSX1 K XUCSX,XUCSX1 Q  ;start time after me
 .. S ^RTHIST(XIRN,"STOP")="IMMEDIATELY" ; RTHIST, DISCARD+3
 .. F  H 1 Q:'$V(53,-5)  ;RTHIST, DISCARD+4
 .. K XUCSX,XUCSX1
 .. Q
 . K XIRN
 . Q
RTHCLEAN ; Clean Up Any 'Old' XUCS ^RTHIST Nodes
 I '$D(^RTHIST("IN PROGRESS")),'$V(53,-5) DO
 . S XUCSIRN=0 F  S XUCSIRN=$O(^RTHIST(+XUCSIRN)) Q:'XUCSIRN  S XUCSIRNX=^(+XUCSIRN) DO
 .. I (($P($H,",")-$P(XUCSIRNX,"^"))>0),$E($P(XUCSIRNX,"^",4),1,4)="XUCS" K ^RTHIST(+XUCSIRN)
 .. Q
 . K XUCSIRN,XUCSIRNX
 . Q
 S XUCSJOB="J ^RTHISTJB(IRN,^RTHIST(IRN))::0" X XUCSJOB I '$T Q
 S ^RTHIST("SUBMITTED",IRN)=""
 K XUCSJOB
 D AMPM
 ;
PART2 ; Get RTHIST's IN PROGRESS Node - Report Number
 K XUCSEND F  H 10 Q:$D(XUCSEND)  I $D(^RTHIST("IN PROGRESS")) D
 . S XUCSRN=^RTHIST("IN PROGRESS"),^%ZRTL("XUCS",XUCSVG,XUCSAP,"TRANSFER-STATUS")="P1"_"^"_XUCSSDT_"^"_XUCSRN,XUCSEND=1
 . S XUCSX="" F I=1:1 S XUCSXX=$T(CONFIG+I) Q:$P(XUCSXX,";",3)="END TEXT"  I $P(XUCSXX,";",4),$P(XUCSXX,";",5) S XUCSX=XUCSX_$V($P(XUCSXX,";",4),-4,$P(XUCSXX,";",5))_"~"
 . S ^%ZRTL("XUCS","ZZZ","SYS-CONFIG",XUCSVG)=XUCSX
 . K XUCSX,XUCSXX
 . Q
 D CLEAN
 Q  ; End of RTHIST Run For This Node
 ;
PART4 ; Move RTHIST(IRN Nodes To %ZRTL
 D AMPM
 I $D(^RTHIST(XUCSRN,"MESSAGE")) S ^%ZRTL("XUCS",XUCSVG,XUCSAP,"TRANSFER-STATUS")="P4^"_$TR($E(^RTHIST(XUCSRN,"MESSAGE"),1,65),"^","~") D CLEAN Q
 I '$D(^RTHIST(XUCSRN,1,0)),'$D(^(1)) DO  D CLEAN Q
 . S $P(^%ZRTL("XUCS",XUCSVG,XUCSAP,"TRANSFER-STATUS"),"^")="P3"
 . I '$D(^RTHIST("IN PROGRESS")) K ^RTHIST(XUCSRN)
 . I $D(^RTHIST("IN PROGRESS")),^RTHIST("IN PROGRESS")=XUCSRN K ^RTHIST("IN PROGRESS"),^RTHIST(XUCSRN)
 . Q
 S ^%ZRTL("XUCS",XUCSVG,XUCSAP,XUCSRN)=^RTHIST(XUCSRN)
 S XUCSQ="""",%X="^RTHIST("_XUCSRN_","
 S %Y="^%ZRTL(""XUCS"","_XUCSQ_XUCSVG_XUCSQ_","_XUCSQ_XUCSAP_XUCSQ_","_XUCSRN_","
 D %XY^%RCR
 S $P(^%ZRTL("XUCS",XUCSVG,XUCSAP,"TRANSFER-STATUS"),"^")="P2"
 I '$D(^RTHIST("IN PROGRESS")) K ^RTHIST(XUCSRN)
 ;$V(53,-5)>0  if ^RTHISTJB is running
 I $D(^RTHIST("IN PROGRESS")),'$V(53,-5) K ^RTHIST(XUCSRN)
 D CLEAN
 Q
CLEAN ; Kill XUCS* Local Variables
 K IRN,XUCSCDI,XUCSDAT,XUCSDUR,XUCSEND,XUCSJOB,XUCSQ,XUCSRDES,XUCSRI,XUCSRN,XUCSSDT,XUCSTBS,XUCSTM,XUCSVG
 Q
AMPM ; XUCSSDT = AM or PM?
 S XUCSAP=$S($E($P(XUCSSDT,".",2),1,2)<12:"AM",1:"PM")
 Q
TI() ; Get MSM Tic Interval
 Q $V(284,-4,1)
OS() ; Get Operating system and Version Number
 Q $P($ZV," ")_"^"_+$P($ZV," ",3)
CONFIG ;
 ;;Buffer Cache Size;116;4;W " Buffers"
 ;;Disk I/O Threshholds;;
 ;;    Begin Burst Flush;74;2;
 ;;    Stop Burst Flush;72;2;
 ;;    Flush Panic Level;308;4;
 ;;    Flush Interval (sec);76;2;
 ;;    Flush Quantity;300;4;
 ;;    I/O Capacity (iolevel);72;2;
 ;;    I/O Flush level (fllevel);74;2;
 ;;Dasd I/O Delay;134;2;
 ;;Dasd Fsync;156;2;
 ;;Term I/O Delay;136;2;
 ;;Maximum Partitions;34;2;
 ;;Maximum Concurrent Partitions;94;2;
 ;;Dispatch Parameters;;
 ;;    Slice Size;144;2;
 ;;    RunQ Slice;146;2;
 ;;    Q1 -> Q2 threshhold;148;4;
 ;;    Q2 -> Q3 Threshhold;152;4;
 ;;STAP Size;96;2;W " (=",$V(96,-4,2)\1024,"K)"
 ;;STACK Size;98;2;W " (=",$V(98,-4,2)\1024,"K)"
 ;;END TEXT
