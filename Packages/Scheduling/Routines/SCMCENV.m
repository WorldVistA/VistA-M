SCMCENV ;ALB/REW - PCMM Environment Checker ; 3 Feb 1996
 ;;5.3;Scheduling;**41**;AUG 13, 1993
EN ;entry point
 W !,"PCMM Installation Requirements:",!
 IF $D(XPDABORT)#2 W !!?4,"*** Warning: Because variable XPDABORT exists, PCMM will not install."
 N SCX,SCPATCH,SCROUT,SCCOMM,SC2LINE,SC2DATA,SCGLOB,SC2CHECK,SCARR,SCSUB
 W !,">>> Checking Programmer Variables:"
 IF +$G(DUZ)'>0!($G(DUZ(0))'="@")!($G(U)'="^")!('$D(DT)) D  Q
 . S XPDABORT=2
 . W !,"You must first initialize Programmer Environment by running ^XUP",!
 ELSE  D
 . W " ...Ok"
BLDCHK ;check build file entries
 W !,">>> Checking BUILD File Entries:"
 F SCX=1:1 S SCPATCH=$P($P($T(BUILD+SCX),";;",2),U,1) Q:'$L(SCPATCH)  D
 .W !,?5,SCPATCH
 .IF '$D(^XPD(9.6,"B",SCPATCH)) D
 ..N SCPKG,SCVER
 ..S SCPKG=$P($P($T(BUILD+SCX),";;",2),U,2)
 ..S SCVER=$P($P($T(BUILD+SCX),";;",2),U,3)
 ..IF $$VERSION^XPDUTL(SCPKG)'=SCVER D
 ...S XPDABORT=2
 ...W !,"Missing Required Package File Entry (Package/Patch): ",SCPATCH
 ..ELSE  D
 ...W " ...Ok - in Package File"
 .ELSE  D
 ..W " ...Ok"
PKGCHK ;check package file entries
 W !,">>> Checking PACKAGE File Entries:"
 F SCX=1:1 S SCPATCH=$P($T(PACKAGE+SCX),";;",2) Q:'$L(SCPATCH)  D
 .N SCPKG,SCVER,SCPTC,SCPKGI,SCVERI
 .W !,?5,SCPATCH
 .IF '$$PATCH^XPDUTL(SCPATCH) D
 ..S XPDABORT=2
 ..W:$G(XPDABORT) !,"Missing Required (Package/Patch) Entry: ",SCPATCH
 .ELSE  D
 ..W " Ok"
 ;check patched routines
 ;check patched routines
RTCHK W !,">>> Checking Routines: "
 ;needs to be improved if 1 digit patches are checked
 F SCX=1:1 S SCRT=$P($T(ROUTINE+SCX),";;",2) Q:'$L(SCRT)  D
 .S SCROUT=$P(SCRT,U,1)
 .W !,?5,$P(SCRT,U,3)," v",$P(SCRT,U,2),?30,"Patch#: ",$P(SCRT,U,4),?43,"Routine: ^",SCROUT," ..."
 .S SCCOMM="S SC2LINE=$P($T(+2"_U_SCROUT_"),"";;"",2)"
 .X SCCOMM
 .S SC2CHECK=$P(SCRT,U,2,99)
 .IF '$L(SC2LINE) D  Q
 ..W "Missing (Required Routine)"
 ..S XPDABORT=2
 .ELSE  D
 ..IF $P(SC2LINE,";",1)>$P(SC2CHECK,U,1) D  Q
 ...W !?10,"Version of ",$P(SC2LINE,";",2)," is greater than standard - No patch checks done"
 ..IF $P(SC2LINE,";",1)<$P(SC2CHECK,U,1) D  Q
 ...W !?10,"Version of ",$P(SC2LINE,";",2)," is less than required"
 ...S XPDABORT=2
 ..IF $P(SC2LINE,";",3)'[$P(SC2CHECK,U,3) D  Q
 ...W !?10,"Missing Patch # ",$P(SC2CHECK,U,3)
 ...S XPDABORT=2
 ..W "Ok"
GLOBCHK W !,">>> Checking Globals:"
 F SCX=1:1 S SCGLOB=$P($T(GLOB+SCX),";;",2) Q:'$L(SCGLOB)  D
 .W !,?5,SCGLOB
 .IF $$GET1^DID(.84,"","","NAME")'="DIALOG" D
 ..W " ...Missing"
 ..S XPDABORT=2
 .ELSE  D
 ..W " ...Ok"
 W:$D(XPDABORT) !,">>> PCMM Aborted in Environment Checker"
 W:'$D(XPDABORT) !!,">>> Environment is Ok"
 Q
 ;
PACKAGE ;
 ;;XU*8.0*2
 ;;XU*8.0*15
 ;;XU*8.0*16
 ;;XU*8.0*28
BUILD ;
 ;;RPC BROKER 1.0^XWB^1.0
ROUTINE ;
 ;;DICA^21.0^VA FileMan^17^Dec 28, 1994
 ;;SDUTL3^5.3^Scheduling^30^AUG 13, 1993
 ;
GLOB ;
 ;;^DI(.84
 ;
