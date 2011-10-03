IBD3KENV ;ALB/MLI - AICS 3.0 Environment Checker ; 4 OCT 1996
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
EN ;entry point
 W !,"AICS 3.0 Installation Requirements:",!
 D ENV ; check environment
 D PATCH ; check patches
 D BLDCHK ; check build entries
 W:$D(XPDABORT) !!,">>> Environment check failed.  Installation will not be allowed."
 W:'$D(XPDABORT) !!,">>> Environment is Ok"
 Q
 ;
 ;
ENV ; check enviroment for KIDS/programmer variables
 W !,">>> Checking Environment:"
 I $G(XPDABORT) W !,"    Can not proceed.  XPDABORT is inappropriately defined."
 I +$G(DUZ)'>0!($G(DUZ(0))'="@")!($G(U)'="^")!('$D(DT)) D
 . S XPDABORT=2
 . W !,"You must first initialize Programmer Environment by running ^XUP",!
 I '$G(XPDABORT) W !,"    Environment checks OK"
 Q
 ;
 ;
PATCH ;check for required patches
 N LINE,OK,PATCH
 W !!,">>> Checking PACKAGE File Entries:"
 F LINE=1:1 S PATCH=$P($T(LIST+LINE),";;",2) Q:(PATCH="QUIT")  D
 . W !,"    Checking for required patch ",PATCH,"..."
 . S OK=$$PATCH^XPDUTL(PATCH)
 . I 'OK S XPDABORT=2 W "not found!!"
 . I OK W "OK"
 Q
 ;
BLDCHK ;check build file entries
 W !,">>> Checking BUILD File Entries:"
 F IBX=1:1 S IBPATCH=$P($P($T(BUILD+IBX),";;",2),U,1) Q:'$L(IBPATCH)  D
 .W !,?5,IBPATCH
 .IF '$D(^XPD(9.6,"B",IBPATCH)) D
 ..N IBPKG,IBVER
 ..S IBPKG=$P($P($T(BUILD+IBX),";;",2),U,2)
 ..S IBVER=$P($P($T(BUILD+IBX),";;",2),U,3)
 ..IF $$VERSION^XPDUTL(IBPKG)'=IBVER D
 ...S XPDABORT=2
 ...W !,"Missing Required Package File Entry (Package/Patch): ",IBPATCH
 ..ELSE  D
 ...W " ...Ok - in Package File"
 .ELSE  D
 ..W " ...Ok"
LIST ;
 ;;XU*8.0*2
 ;;XU*8.0*15
 ;;XU*8.0*16
 ;;XU*8.0*28
 ;;XU*8.0*32
 ;;XU*8.0*44
 ;;QUIT
BUILD ;
 ;;PCE V1.0^PX^1.0
