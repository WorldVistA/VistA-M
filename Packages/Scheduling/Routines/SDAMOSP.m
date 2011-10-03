SDAMOSP ;ALB/CAW - Print for Appointment Statistics;4/15/92
 ;;5.3;Scheduling;**22**;Aug 13, 1993
 ;
HDR ;Report Header
 ;
 I $E(IOST,1,2)="C-" D PAUSE^VALM1 I 'Y S SDSTOP=1 Q
HDR1 W @IOF,$S('SDFLG:"Division: "_$P($G(^DG(40.8,SDDV,0)),U),1:"MEDICAL CENTER")
 W ?41,"Date Range: ",$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDEND)
 D NOW^%DTC W ?95,"Run Date: ",$E($$FDTTM^VALM1(%),1,14),?125,"Page: ",SDPAGE S SDPAGE=SDPAGE+1
 W !,?1,$S('SDFLG:"Clinic",1:"Division"),?34,"Checked-In",?48,"Checked-Out",?63,"No Action Taken",?83,"___No-show___",?99,"__Cancelled__",?114,"Inpatient",?127,"Total"
 W !,?83,"Tot",?89,"CI",?94,"RB",?99,"Tot",?105,"CI",?110,"RB",!,SDASH
 Q
 ;
BLD ;Build output from ^TMP global
 ;
 S (SDSTOP,SDTOT,SDFLG)=0,SDDV="" F  S SDDV=$O(^TMP("SDAMS",$J,SDDV)) Q:SDDV=""!(SDSTOP)  D:SDSEL=5 HDR D
 .S SDCL="" F  S SDCL=$O(^TMP("SDAMS",$J,SDDV,SDCL)) Q:SDCL=""!(SDSTOP)  D  S SDNXT=$O(^TMP("SDAMS",$J,SDDV,SDCL)) I SDNXT'="" W:SDSEL=4 !,SDASH
 ..S SDCLI="" F  S SDCLI=$O(^TMP("SDAMS",$J,SDDV,SDCL,SDCLI)) Q:'SDCLI!(SDSTOP)  D
 ...S SDAT="" F  S SDAT=$O(^TMP("SDAMS",$J,SDDV,SDCL,SDCLI,SDAT)) Q:'SDAT!(SDSTOP)  S SDCNT(SDAT)=^(SDAT)
 ...W:SDSEL=5 !,SDCL F SDI=1:1:11 S SDTOT=$G(SDTOT)+$G(SDCNT(SDI))
 ...D:SDSEL=5 CNT
 ...I SDSEL=5 W ?124,$J(SDTOT,8) K SDTOT,SDCNT D CHK Q:SDSTOP
 .Q:SDSTOP  I SDSEL=5 W !,SDTDASH,!,"TOTAL" D TOTAL W ?124,$J(SDTOT,8) K SDTOT,SDCNT D CHK Q:SDSTOP
 .I SDSEL=5 W !! D LEGEND
BLDQ I SDSTOP Q
 ;
MCTOT S SDFLG=1,SDDV="" D HDR F  S SDDV=$O(^TMP("SDAMS",$J,SDDV)) Q:SDDV=""  D  Q:SDSTOP
 .W !,$P($G(^DG(40.8,SDDV,0)),U)
 .K SDTOT,SDCNT D TOTAL
 .W ?124,$J(SDTOT,8)
 .D CHK Q:SDSTOP
 .S SDNXT=$O(^TMP("SDAMS",$J,SDDV)) W:SDNXT'="" !,SDASH
 .K SDTOT,SDCNT
 W !,SDTDASH,!,"TOTAL" F SDI=1:1:11 S SDCNT(SDI)=+$G(SDAT("SDAMS",$J,SDI)),SDTOT=$G(SDTOT)+$G(SDCNT(SDI))
 D CNT
 W ?124,$J(SDTOT,8) K SDTOT,SDCNT D CHK I SDSTOP G MCTOTQ
 W !! D LEGEND
MCTOTQ Q
CNT ;Place no-show/no-show auto rebook & cancel/cancel auto-rebook together
 S SDCNT(4)=+$G(SDCNT(4))+(+$G(SDCNT(6))),SDCNT(13)=+$G(SDCI(+SDCL,4))+(+$G(SDCI(+SDCL,6)))
 S SDCNT(5)=+$G(SDCNT(5))+(+$G(SDCNT(7))),SDCNT(14)=+$G(SDCI(+SDCL,5))+(+$G(SDCI(+SDCL,7)))
 F SDI=1,2,3,4,13,6,5,14,7,8 D
 .W ?$$COL(SDI),$J($S($D(SDCNT(SDI)):SDCNT(SDI),1:0),$$LEN(SDI))
 Q
 ;
CHK ;Check to pause on screen
 I $E(IOST,1,2)="C-",($Y+6)>IOSL D PAUSE^VALM1 S SDY=Y D:SDY HDR1 I 'SDY S SDSTOP=1 Q
 I ($Y+6)>IOSL D HDR1
 Q
TOTAL ;Totals
 F SDI=1:1:11 S SDCNT(SDI)=+$G(SDCL("SDAMS",$J,SDDV,SDI)),SDTOT=$G(SDTOT)+$G(SDCNT(SDI))
 D CNT
 K SDCNT
 Q
 ;
LEGEND ;Legend on bottom of output
 ;
 W !,?5,"o CI=Checked In ; RB=Rebooked"
 W !,?5,"o 'Cancelled' appointments only reflect appointments cancelled using 'Cancel Clinic Availability'."
 W !,?5,"o 'Checked-In' does not include no-shows or cancelled appointments that have been checked in."
 Q
 ;
COL(SDI) ;Column placement of appt. status
 ;
 ;input - SDI (appt. type)
 ;output - column placement
 Q $S(SDI=1:34,SDI=2:48,SDI=3:63,SDI=4:81,SDI=5:97,SDI=6:92,SDI=7:108,SDI=8:114,SDI=13:87,SDI=14:103)
 ;
LEN(SDI) ;Length of column
 ;
 ;input - SDI (appt. type)
 ;output - length of column
 Q $S(SDI=1:10,SDI=2:11,SDI=3:15,SDI=4:5,SDI=6:4,SDI=5:5,SDI=7:4,SDI=8:9,SDI=13:4,SDI=14:4)
 ;
