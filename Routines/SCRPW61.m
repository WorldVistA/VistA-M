SCRPW61 ;BP-CIOFO/KEITH - Patient Appointment Statistics (cont.) ; 07 May 99  4:33 PM
 ;;5.3;Scheduling;**163,176,194**;AUG 13, 1993
CNT ;Count clinic statistics
 S SDIV="" F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""!SDOUT  D
 .S SDCLN="" F  S SDCLN=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN)) Q:SDCLN=""  D STOP Q:SDOUT  D
 ..S SDCL=0 F  S SDCL=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL)) Q:'SDCL  D
 ...S SDPTNA="" F  S SDPTNA=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL,SDPTNA)) Q:SDPTNA=""  D
 ....S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL,SDPTNA,DFN)) Q:'DFN  D
 .....I SDPL,SDPLO'="D" S ^TMP("SCRPW",$J,SDIV,0,SDCLN,SDCL,$$ORD(),SDPTNA,DFN)=""
 .....S $P(^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL),U,3)=$P($G(^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL)),U,3)+1
 .....S SDDAY=0 F  S SDDAY=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL,SDPTNA,DFN,SDDAY)) Q:'SDDAY  D
 ......S $P(^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL),U,2)=$P($G(^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL)),U,2)+1
 ......S SDAPP=0 F  S SDAPP=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL,SDPTNA,DFN,SDDAY,SDAPP)) Q:'SDAPP  D
 .......I SDPL,SDPLO="D" S ^TMP("SCRPW",$J,SDIV,0,SDCLN,SDCL,SDAPP,SDPTNA,DFN)=""
 .......S $P(^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL),U)=$P($G(^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL)),U)+1 Q
 ......Q
 .....Q
 ....Q
 ...Q
 ..Q
 .Q:SDOUT
 .;Count division statistics
 .S SDPTNA="" F  S SDPTNA=$O(^TMP("SCRPW",$J,SDIV,2,SDPTNA)) Q:SDPTNA=""  D
 ..S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,2,SDPTNA,DFN)) Q:'DFN  D
 ...S $P(^TMP("SCRPW",$J,SDIV,4),U,3)=$P($G(^TMP("SCRPW",$J,SDIV,4)),U,3)+1
 ...S SDDAY=0 F  S SDDAY=$O(^TMP("SCRPW",$J,SDIV,2,SDPTNA,DFN,SDDAY)) Q:'SDDAY  D
 ....S $P(^TMP("SCRPW",$J,SDIV,4),U,2)=$P($G(^TMP("SCRPW",$J,SDIV,4)),U,2)+1
 ....S SDAPP=0 F  S SDAPP=$O(^TMP("SCRPW",$J,SDIV,2,SDPTNA,DFN,SDDAY,SDAPP)) Q:'SDAPP  D
 .....S $P(^TMP("SCRPW",$J,SDIV,4),U)=$P($G(^TMP("SCRPW",$J,SDIV,4)),U)+1 Q
 ....Q
 ...Q
 ..Q
 .Q
 Q
 ;
ORD() ;Determine collating value for patient list
 Q:SDPLO="A" SDPTNA
 S SDSSN=$P(^DPT(DFN,0),U,9) Q $E(SDSSN,8,9)_$E(SDSSN,6,7)_$E(SDSSN,4,5)_$E(SDSSN,1,3)_"."
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
AC ;Gather all clinics
 S SDCL=0 F  S SDCL=$O(^SC(SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC SET
 Q
 ;
A1 S:$P(SDCL0,U,3)="C" SDAC=1 Q
 ;
SC ;Gather selected clinics
 S SDCL=0 F  S SDCL=$O(SDCL(SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC SET
 Q
 ;
RC ;Gather range of clinics
 S SDCLN=$O(SDCL("")),SDECL=$O(SDCL(SDCLN)),SDCL=SDCL(SDCLN),SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC SET
 F  S SDCLN=$O(^SC("B",SDCLN)) Q:(SDCLN=""!(SDCLN]SDECL))  S SDCL=0 F  S SDCL=$O(^SC("B",SDCLN,SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC SET
 Q
 ;
SS ;Gather clinics with selected Stop Codes
 S SDCL=0 F  S SDCL=$O(^SC(SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC SS1
 Q
 ;
SS1 S SDCSC=$P(SDCL0,U,7),SDCSC=$P($G(^DIC(40.7,+SDCSC,0)),U,2) I $D(SDCL(+SDCSC)) D SET
 Q
 ;
RS ;Gather clinics in range of Stop Codes
 S SDBCS=$O(SDCL("")),SDECS=$O(SDCL(SDBCS)),SDCL=0 S:'SDECS SDECS=SDBCS F  S SDCL=$O(^SC(SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC RC1
 Q
 ;
RC1 S SDCSC=$P(SDCL0,U,7),SDCSC=$P($G(^DIC(40.7,+SDCSC,0)),U,2) Q:('SDCSC!(SDCSC<SDBCS!(SDCSC>SDECS)))  D SET Q
 ;
CG ;Gather clinics with selected clinic group
 S SDCG=$O(SDCL(0)),SDCL=0 F  S SDCL=$O(^SC("ASCRPW",SDCG,SDCL)) Q:'SDCL  S SDCL0=^SC(SDCL,0),SDIV=$P(SDCL0,U,15),SDAC=0 I $$DIV() D STOP Q:SDOUT  D A1 D:SDAC SET
 Q
 ;
DIV() ;Check division
 S:'$L(SDIV) SDIV=$$PRIM^VASITE()
 Q:'SDDIV 1  Q $D(SDDIV(+SDIV))
 ;
SET ;Set ^TMP global
 N SDPAS
 S SDDAY=SDBDAY F  S SDDAY=$O(^SC(SDCL,"S",SDDAY)) Q:'SDDAY!(SDDAY>SDEDAY)  S SDI=0 F  S SDI=$O(^SC(SDCL,"S",SDDAY,1,SDI)) Q:'SDI  D
 .S SDCP0=$G(^SC(SDCL,"S",SDDAY,1,SDI,0)) Q:'$L(SDCP0)  Q:$P(SDCP0,U,9)="C"
 .S DFN=$P(SDCP0,U),SDPTNA=$P($G(^DPT(+DFN,0)),U) Q:'$L(SDPTNA)
 .S SDPAS=$P($G(^DPT(DFN,"S",SDDAY,0)),U,2) I $L(SDPAS),"NA"[SDPAS Q
 .D SET1(SDIV) D:SDMD SET1(0) Q
 Q
 ;
SET1(SDIV) S ^TMP("SCRPW",$J,SDIV,1,$P(SDCL0,U),SDCL,SDPTNA,DFN,$P(SDDAY,"."),SDDAY)=""
 S ^TMP("SCRPW",$J,SDIV,2,SDPTNA,DFN,$P(SDDAY,"."),SDDAY)=""
 Q
 ;
FOOT ;Report footer
 N SDI
 F SDI=1:1:80 Q:$Y>(IOSL-8)  W !
 W SDLINE,!?(SDCOL),"NOTE: This report reflects appointment workload that is not defined as cancelled"
 W !?(SDCOL+6),"or no-showed, including walk-in (unscheduled) appointments.  It does not"
 W !?(SDCOL+6),"represent all outpatient activity.  Report totals are tabulated separately",!?(SDCOL+6),"and will not necessarily be equal to the sum of the sub-total columns.",!,SDLINE Q
 ;
DPRT(SDIV) ;Print report for a division
 D DHDR^SCRPW40(4,.SDT)
 I '$D(^TMP("SCRPW",$J,SDIV)) D HDR^SCRPW60 S SDX="No appointments found for this division within report parameters!" W !!?(132-$L(SDX)\2),SDX Q
 I SDPL,SDIV S SDCLN="" F  S SDCLN=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN)) Q:SDCLN=""!SDOUT  D
 .S SDCL=0 F  S SDCL=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL)) Q:'SDCL!SDOUT  D
 ..S SDT(5)="Patient list for clinic: "_SDCLN D HDR^SCRPW60,HD1 Q:SDOUT
 ..S SDORD="" F  S SDORD=$O(^TMP("SCRPW",$J,SDIV,0,SDCLN,SDCL,SDORD)) Q:SDORD=""!SDOUT  D
 ...S SDPTNA="" F  S SDPTNA=$O(^TMP("SCRPW",$J,SDIV,0,SDCLN,SDCL,SDORD,SDPTNA)) Q:SDPTNA=""!SDOUT  D
 ....S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,0,SDCLN,SDCL,SDORD,SDPTNA,DFN)) Q:'DFN!SDOUT  D
 .....I SDPLO="D" D PLINE(SDORD) Q
 .....S SDDAY=0 F  S SDDAY=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL,SDPTNA,DFN,SDDAY)) Q:'SDDAY!SDOUT  D
 ......S SDAPP=0 F  S SDAPP=$O(^TMP("SCRPW",$J,SDIV,1,SDCLN,SDCL,SDPTNA,DFN,SDDAY,SDAPP)) Q:'SDAPP!SDOUT  D
 .......D PLINE(SDAPP) Q
 ......Q
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 Q:SDOUT  K SDT(5) D HDR^SCRPW60,HD2 Q:SDOUT
 S SDCLN="" F  S SDCLN=$O(^TMP("SCRPW",$J,SDIV,3,SDCLN)) Q:SDCLN=""!SDOUT  D
 .S SDCL=0 F  S SDCL=$O(^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL)) Q:'SDCL!SDOUT  D
 ..D CLINE Q
 .Q
 Q:SDOUT  D DTOT,FOOT Q
 ;
PLINE(SDAPP) ;Print patient detail line
 ;Input: SDAPP=patient appointment date/time
 S SDSSN=$P(^DPT(DFN,0),U,9) D:$Y>(IOSL-4) HDR^SCRPW60,HD1 Q:SDOUT
 W !?(SDCOL+8),SDPTNA,?(SDCOL+40),$E(SDSSN,1,3),"-",$E(SDSSN,4,5),"-",$E(SDSSN,6,10) S Y=SDAPP X ^DD("DD") W ?(SDCOL+54),$P(Y,":",1,2) Q
 ;
CLINE ;Print clinic sub-total line
 S SDCTOT=^TMP("SCRPW",$J,SDIV,3,SDCLN,SDCL) D:$Y>(IOSL-11) FOOT,HDR^SCRPW60,HD2 Q:SDOUT
 W !?(SDCOL+5),SDCLN F SDI=1:1:3 W ?(SDCOL+27+(12*SDI)),$J($P(SDCTOT,U,SDI),12,0)
 Q
 ;
DTOT ;Print division total
 S SDTOT=^TMP("SCRPW",$J,SDIV,4) W !?(SDCOL+4),$E(SDTLINE,1,32) F SDI=1:1:3 W ?(SDCOL+30+(12*SDI)),$E(SDTLINE,1,10)
 W !?(SDCOL+5),$S(SDIV:"DIVISION",1:"REPORT")," TOTAL:" F SDI=1:1:3 W ?(SDCOL+27+(12*SDI)),$J($P(SDTOT,U,SDI),12,0)
 Q
 ;
HD1 ;Print patient list sub-header
 Q:SDOUT  W !?(SDCOL+8),"Patient",?(SDCOL+40),"SSN",?(SDCOL+54),"Appt. date/time"
 W !?(SDCOL+7),$E(SDLINE,1,31),?(SDCOL+40),$E(SDLINE,1,12),?(SDCOL+54),$E(SDLINE,1,18)
 Q
 ;
HD2 ;Print clinic list sub-header
 Q:SDOUT  W !?(SDCOL+5),"Clinic",?(SDCOL+45),"Appts.",?(SDCOL+57),"Visits",?(SDCOL+68),"Uniques"
 W !?(SDCOL+4),$E(SDLINE,1,32) F SDI=1:1:3 W ?(SDCOL+30+(12*SDI)),$E(SDLINE,1,10)
 Q
