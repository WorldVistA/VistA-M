SD132EN ;ALB/MJK - Patch SD*5.3*132 Environmental Check Routine ; 11/5/97
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
EN ; --- main entry point
 S U="^"
 D HOME^%ZIS
 ;
 W !,"Environmental Checks Started..."
 ;
 ; -- main driver calls
 D EVT,PKG
 ;
 W !!,"Environmental Checks Completed."
 W " [",$S($G(XPDQUIT):"Failed",1:"Passed"),"]",!
 Q
 ;
EVT ; -- check SDAM APPOINTMENT EVENTS protocol for dangling pointers
 N SDMAIN,SDITEM,SDIEN,SDBAD
 S SDBAD=0
 S SDMAIN=$O(^ORD(101,"B","SDAM APPOINTMENT EVENTS",0))
 IF 'SDMAIN G EVTQ
 S SDITEM=0
 F  S SDITEM=$O(^ORD(101,SDMAIN,10,SDITEM)) Q:'SDITEM  D  Q:SDBAD
 . S SDIEN=+$G(^ORD(101,SDMAIN,10,SDITEM,0))
 . IF '$D(^ORD(101,SDIEN,0)) D
 . . S SDBAD=1
 . . W !!?5,"Item #",SDITEM," on the 'SDAM APPOINTMENT EVENTS' protocol"
 . . W !?5,"is a dangling pointer and must be corrected/removed"
 . . W !?5,"before patch SD*5.3*132 can be installed."
 . . W !!,?5,"Please contact the Customer Support Help Desk for assistance."
 . . D PAUSE
 IF SDBAD S XPDQUIT=2
EVTQ Q
 ;
PKG ; -- check if needed patches are installed
 N SDLIST
 ;
 ; -- build patch list info
 D BUILD(.SDLIST)
 ;
 ; -- display patch info
 D DISPLAY(.SDLIST)
 ;
 ; -- have all patches passed check
 IF '$$OK(.SDLIST) D
 . S XPDQUIT=2
 . W !!,"   -> At least one patch check failed."
 ELSE  D
 . W !!,"   -> All patch checks passed."
 D PAUSE
 Q
 ;
LINE(OK,REASON) ; -- print line of text
 W !,"       -> ",SDPKG,"...",$S(OK:"Ok",1:"not Ok"),?30,"Reason: ",REASON
 Q
 ;
BUILD(SDLIST) ; -- scan patch list and build array
 N SDI,SDX,SDPATCH,SDPKG,SDPKGN,SDOVER,SDREASON,SDTEXT,SDPKGV
 F SDI=1:1 S SDX=$P($T(PKGS+SDI),";;",2) Q:SDX="$$END$$"  D
 . S SDPKGN=$P(SDX,U)
 . S SDPKG=$P(SDX,U,2)
 . S SDPATCH=$P(SDX,U,3)
 . S SDPKGV=$P(SDX,U,4)
 . S SDOVER=+$P($G(^XTMP("SD*5.3*132 OVERRIDE FLAGS",SDPKG)),U)
 . ;
 . S SDREASON=$$REASON(SDPATCH,SDPKG,SDPKGV,SDOVER)
 . S SDTEXT=$P($T(REASONS+SDREASON),";;",2)
 . ;
 . S SDLIST(SDPKG,"PACKAGE NAME")=SDPKGN
 . S SDLIST(SDPKG,"PATCH")=SDPATCH
 . S SDLIST(SDPKG,"NEEDED VERSION")=SDPKGV
 . S SDLIST(SDPKG,"PASSED")=+SDTEXT
 . S SDLIST(SDPKG,"REASON TEXT")=$P(SDTEXT,U,2)
 . S SDLIST(SDPKG,"REASON NUMBER")=SDREASON
 . S SDLIST(SDPKG,"OVERRIDE")=SDOVER
 Q
 ;
REASON(SDPATCH,SDPKG,SDPKGV,SDOVER) ; check if patch is loaded or not needed
 N SDREASON,SDVERS
 IF SDOVER S SDREASON=1 G REASONQ
 S SDVERS=$$VERSION^XPDUTL(SDPKG)
 IF SDVERS="" S SDREASON=2 G REASONQ
 IF $$PATCH^XPDUTL(SDPATCH) S SDREASON=3 G REASONQ
 IF SDPKGV]"",SDVERS=SDPKGV S SDREASON=5 G REASONQ
 S SDREASON=4
REASONQ Q SDREASON
 ;
DISPLAY(SDLIST) ; -- display patch info
 N SDPKGN,SDLINE
 S $P(SDLINE,"-",IOM)="-"
 ;
 W @IOF,!,"Information On Patches Needed For SD*5.3*132 Install",!,SDLINE
 W !?33,"Patch or",?50,"Passed"
 W !,"Package",?33,"Version",?50,"Check",?58,"Reason",!,SDLINE
 S SDPKG=""
 F  S SDPKG=$O(SDLIST(SDPKG)) Q:SDPKG=""  D
 . W !,SDLIST(SDPKG,"PACKAGE NAME")
 . W ?33,SDLIST(SDPKG,"PATCH")
 . IF SDLIST(SDPKG,"NEEDED VERSION")]"" W " / ",SDLIST(SDPKG,"NEEDED VERSION")
 . W ?50,$S($G(SDLIST(SDPKG,"PASSED")):"Yes",1:"No")
 . W ?58,$E($G(SDLIST(SDPKG,"REASON TEXT")),1,25)
 W !,SDLINE
 Q
 ;
OK(SDLIST) ; -- have all patch checks passed
 N SDPKGN,SDOK
 S SDOK=1
 S SDPKG=""
 F  S SDPKG=$O(SDLIST(SDPKG)) Q:SDPKG=""  D  Q:'SDOK
 . S SDOK=+$G(SDLIST(SDPKG,"PASSED"))
 Q SDOK
 ;
PKGS ; -- packages to check [ package name ^ package namespace ^ patch designation ^ package version ] 
 ;;AUTOMATED MED INFO EXCHANGE^DVBA^DVBA*2.7*14^
 ;;ADVERSE REACTION TRACKING^GMRA^GMRA*4.0*9^
 ;;HOSPITAL BASED HOME CARE^HBH^HBH*1.0*10^
 ;;INTEGRATED BILLING^IB^IB*2.0*91^
 ;;AUTOMATED INFO COLLECTION SYS^IBD^IBD*3.0*17^
 ;;ICR - IMMUNOLOGY CASE REGISTRY^IMR^IMR*2.0*25^2.1
 ;;INCOME VERIFICATION MATCH^IVM^IVM*2.0*11^
 ;;RECORD TRACKING^RT^RT*2.0*30^
 ;;$$END$$
 ;;REGISTRATION^DG^DG*5.3*151^
 ;
REASONS ; -- reason list [ 0:failed ; 1:passed ^ reason text ]
 ;;1^Override Flag Set
 ;;1^Package Not Installed
 ;;1^Patch Installed
 ;;0^Patch Not Installed
 ;;1^New Version Installed
 ;;$$END$$
 ;
QIK(SDQIK) ; -- create quick list
 N SDI,SDX
 F SDI=1:1 S SDX=$P($T(PKGS+SDI),";;",2) Q:SDX="$$END$$"  D
 . S SDQIK($P(SDX,U,2))=""
 Q
 ;
VALID(SDPKG) ; -- was a valid namespace pasted
 N SDQIK,SDOK
 S SDOK=0
 D QIK(.SDQIK)
 IF $G(SDPKG)]"",$D(SDQIK(SDPKG)) S SDOK=1
 IF 'SDOK W "...invalid namespace passed!",!
 Q SDOK
 ;
PAUSE ; -- pause for return
 N Y
 R !!,"Press return to continue: ",Y:$G(DTIME,300)
 Q
 ;
 ;
 ; <<<<<<<<<<<<<<< Entry points for Customer Service >>>>>>>>>>>>>>>
 ;
SET(SDPKG) ; -- set override for package namespace
 Q:'$$VALID($G(SDPKG))
 IF '$D(^XTMP("SD*5.3*132 OVERRIDE FLAGS",0)) S ^XTMP("SD*5.3*132 OVERRIDE FLAGS",0)="2991231^"_DT_"^Patch SD*5.3*132 Package Override Flags"
 S ^XTMP("SD*5.3*132 OVERRIDE FLAGS",SDPKG)=1
 W " ...override set for '",SDPKG,"'",!
 Q
 ;
KILL(SDPKG) ; -- kill override for package namespace
 Q:'$$VALID($G(SDPKG))
 K ^XTMP("SD*5.3*132 OVERRIDE FLAGS",SDPKG)
 IF $O(^XTMP("SD*5.3*132 OVERRIDE FLAGS",0))="" K ^XTMP("SD*5.3*132 OVERRIDE FLAGS")
 W " ...override killed for '",SDPKG,"'",!
 Q
 ;
KILLALL ; -- kill overrides for all package namespaces
 K ^XTMP("SD*5.3*132 OVERRIDE FLAGS")
 W " ...killed",!
 Q
 ;
