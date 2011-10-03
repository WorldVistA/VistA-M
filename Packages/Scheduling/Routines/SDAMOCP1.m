SDAMOCP1 ;IOFO BAY PINES/TEH - Detail Print for Cancelled Statistics;4/15/92  ; Compiled January 25, 2007 12:00:46
 ;;5.3;Scheduling;**487,496**;Aug 13, 1993;Build 11
 ;
HDR ;Report Header
 ;
 N SDSTOP
 I SDPAGE>1,$E(IOST,1,2)="C-" D PAUSE^VALM1 I 'Y S SDSTOP=1 Q
HDR1 W @IOF
 W !,?50,"Cancelled Clinic Report - Detail"
 W !,?50,"Date Range: ",$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDEND)
 D NOW^%DTC
 W !,?54,"Run Date: ",$E($$FDTTM^VALM1(%),1,14)
 W !,?62,"Page: ",SDPAGE S SDPAGE=SDPAGE+1
 W !,"Division"
 W !,SDASH,!
 W "Status",?8,"Patient",?30,"SSN",?39,"Appt Date",?61,"Clinic",?81,"Cancel Date",?106,"User",!
 W SDASH
 Q
 ;
BLD ;Build output from ^TMP global
 ;
 N SDTOT,SDTOTT,SDCL,SDDATE,SDUSER,SDCDT
 D HDR
 I IOST["P-" K DIRUT
 S (SDSTOP,SDTOTT,SDFLG)=0,SDDV="" F  S SDDV=$O(^TMP("SDAMCD",$J,SDDV)) Q:SDDV=""!(SDSTOP)  D CHK D
 .S SDDVNM=$P($G(^DG(40.8,SDDV,0)),U) W !,SDDVNM
 .S SDCR="" F  S SDCR=$O(^TMP("SDAMCD",$J,SDDV,SDCR)) Q:SDCR=""!($D(DIRUT))  S SDTOT(SDCR)=0 D  W !!,"SUBTOTAL:",$J(SDTOT(SDCR),4),!
 ..S SDCL="" F  S SDCL=$O(^TMP("SDAMCD",$J,SDDV,SDCR,SDCL)) Q:SDCL=""!($D(DIRUT))  D 
 ...S SDDATE="" F  S SDDATE=$O(^TMP("SDAMCD",$J,SDDV,SDCR,SDCL,SDDATE)) Q:SDDATE=""!($D(DIRUT))  D
 ....S SDDFN="" F  S SDDFN=$O(^TMP("SDAMCD",$J,SDDV,SDCR,SDCL,SDDATE,SDDFN)) Q:SDDFN=""!($D(DIRUT))  D
 .....S SDDATA=$G(^TMP("SDAMCD",$J,SDDV,SDCR,SDCL,SDDATE,SDDFN))
 .....S Y=$P(SDDATA,";",2) D DD^%DT S SDAPDT=Y
 .....D GETS^DIQ(2,SDDFN_",",".01;.09",,"SDRES","SDMES") S SDNM=$E($G(SDRES(2,SDDFN_",",.01)),1,20),SDSSN=$E($G(SDRES(2,SDDFN_",",.09)),6,9)
 .....S Y=$P(SDDATA,U,14) D DD^%DT S SDCDT=Y S SDUSER=$P(SDDATA,U,12)
 .....S SDUSERNM=$$GET1^DIQ(200,SDUSER_",",.01,,"SDRES","SDMES")
 .....S SDCLNM=$$GET1^DIQ(44,SDCL_",",.01,,"SDRES","SDMES")
 .....W !,SDCR,?8,$E(SDNM,1,22),?30,SDSSN,?39,SDAPDT,?61,$E(SDCLNM,1,18),?81,SDCDT,?106,$E(SDUSERNM,1,26)
 .....K SDRES,SDMES ;SD/496
 .....D CHK I $D(DIRUT) Q 
 .....S SDTOT(SDCR)=$G(SDTOT(SDCR))+1,SDTOTT=SDTOTT+1
 W !!,"TOTAL CANCELLATIONS:",$J(SDTOTT,14)
 W !!,"End of Report!"
 K SDUSERNM,SDSSN,SDAPDT,SDCLNM,SDRES,SDNM,SDCR,SDDDATE,SDDFN,SDDATA,SDDVNM,SDCLNM
 I IOST["P-" S DIRUT=1
BLDQ Q
 ;
MCTOT ;
 N SDFLG,SDDV,SDNXT
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
 N SDY
 I $E(IOST,1,2)="C-",($Y+8)>IOSL D PAUSE^VALM1 S SDY=Y D:SDY HDR1 I 'SDY S SDSTOP=1 Q
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
