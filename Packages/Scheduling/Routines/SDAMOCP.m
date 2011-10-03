SDAMOCP ;IOFO BAY PINES/TEH - Print for Cancelled Statistics;4/15/92
 ;;5.3;Scheduling;**487**;Aug 13, 1993
 ;
HDR ;Report Header
 ;
 N SDSTOP,%
 I SDPAGE>1,$E(IOST,1,2)="C-" D PAUSE^VALM1 I 'Y S SDSTOP=1 Q
HDR1 W @IOF
 W !,?50,"Cancelled Clinic Report - Summary"
 W !,?50,"Date Range: ",$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDEND)
 D NOW^%DTC
 W !,?54,"Run Date: ",$E($$FDTTM^VALM1(%),1,14)
 W !,?62,"Page: ",SDPAGE S SDPAGE=SDPAGE+1
 W !!,"Division"
 W ?34,"Can'd by Clinic",?52,"Can'd by Clinic RB",?73,"Can'd by Patient",?92,"Can'd by Patient RB",?114,"Total"
 W !,SDASH
 Q
 ;
BLD ;Build output from ^TMP global
 ;
 N SDCTYP,SDTOTS,SDTOTN,SDCI,SDCL,SDDV,SDDVNM,SDFLG,SDNXT,SDTAB
 N SDTOTT,SDY
 S (SDSTOP,SDTOT,SDTOTT,SDFLG)=0,SDDV="" F  S SDDV=$O(^TMP("SDAMC",$J,SDDV)) Q:SDDV=""!(SDSTOP)  D CHK D
 .S SDDVNM=$P($G(^DG(40.8,SDDV,0)),U) W !,SDDVNM
 .S SDCL="" F  S SDCL=$O(^TMP("SDAMC",$J,SDDV,SDCL)) Q:SDCL=""  D
 ..K SDTOT,SDTOTS W !,?12,$P($G(^SC(SDCL,0)),U) S SDTOT=0,SDTOT(SDCL)=0 F SDTOTN=1:1:4 S SDTOTS(SDTOTN)=0
 ..S SDCTYP="" F  S SDCTYP=$O(^TMP("SDAMC",$J,SDDV,SDCL,SDCTYP)) Q:SDCTYP=""  D
 ...S SDTOT=$G(^TMP("SDAMC",$J,SDDV,SDCL,SDCTYP)),SDTOTT=SDTOTT+SDTOT,SDTOTS(SDCTYP)=SDTOT,SDTOT(SDCL)=SDTOT(SDCL)+SDTOT
 ..F SDTOTN=1:1:4 S SDTAB=$S(SDTOTN=1:41,SDTOTN=2:58,SDTOTN=3:79,SDTOTN=4:98,1:0) W ?SDTAB,$J(SDTOTS(SDTOTN),3)
 ..W ?116,$J(SDTOT(SDCL),3)
 W !,?114,"-----",!,?90,"Total Cancellations:",?116,$J(SDTOTT,3)
 W !!,"End of Report!"
BLDQ Q
 ;
MCTOT ;
 N SDAT
 S SDFLG=1,SDDV="" D HDR F  S SDDV=$O(^TMP("SDAMS",$J,SDDV)) Q:SDDV=""  D  Q:SDSTOP
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
 I $E(IOST,1,2)="C-",($Y+8)>IOSL D PAUSE^VALM1
 S SDY=FMT D:SDY HDR1 I 'SDY S SDSTOP=1 Q
 I ($Y+8)>IOSL D HDR1
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
