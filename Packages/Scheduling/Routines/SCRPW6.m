SCRPW6 ;RENO/KEITH - Trend of Facility Uniques by 12 Month Date Ranges ; 15 Jul 98  02:38PM
 ;;5.3;Scheduling;**139,144,466,510**;AUG 13, 1993;Build 3
 N SDDIV,SDI,SDSTA,DIR D TITL^SCRPW50("Trend of Facility Uniques by 12 Month Date Ranges") G:'$$DIVA^SCRPW17(.SDDIV) EXIT
 D SUBT^SCRPW50("**** Status Selection ****")
 S DIR(0)="S^1:Checked Out (Outpatients);2:Checked Out (Inpatients);3:Checked Out (Out/Inpatients)",DIR("A")="Select Status",DIR("B")="1"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!(+Y<0) G EXIT
 S SDSTA=$S(Y=1:2,Y=2:8,1:"2^8")
QUE W !!,"This report requires 132 column output.",!
 N ZTSAVE F X="SDDIV","SDDIV(","SDDNU(","SDSTA" S ZTSAVE(X)=""
 D EN^XUTMDEVQ("UNIQ^SCRPW6","Trend Facility Uniques",.ZTSAVE),DISP0^SCRPW23 Q
UNIQ ;Calculate/print uniques
 S (SDOUT,SDSTOP)=0,SDLINE="",SDPAGE=1,$P(SDLINE,"-",133)="" D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDMD=$O(SDDIV(0)),SDMD=$O(SDDIV(SDMD)) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDMD=1
 K ^TMP("SCRPW",$J) S SDBDT=$E(DT,1,3)-5_$E(DT,4,5)_"00",SDEDT=$E(DT,1,5)_"00",SDXEDT=$E(DT,1,3)-1_$E(DT,4,5)_"00" D OENC G:SDOUT EXIT
 S SDIV="" F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""  D STOP Q:SDOUT  D
 .S SDDT=SDBDT,SDXDT=$$YDTINC(SDDT),^TMP("SCRPW",$J,SDIV,"YR","MAX")=0 D LOOK
 .F  S SDDT=$$DTINC(SDDT) Q:SDDT>SDXEDT  S SDXDT=$$YDTINC(SDDT) D LOOK I ^TMP("SCRPW",$J,SDIV,"YR",SDDT)>^TMP("SCRPW",$J,SDIV,"YR","MAX") S ^TMP("SCRPW",$J,SDIV,"YR","MAX")=^TMP("SCRPW",$J,SDIV,"YR",SDDT)
 G:SDOUT EXIT D:$E(IOST)="C" DISP0^SCRPW23 I '$D(^TMP("SCRPW",$J)) D HDR G:SDOUT EXIT S SDX="No activity found within selected report parameters!" W !!?(IOM-$L(SDX)\2),SDX G EXIT
 I $P(SDDIV,U,2)="SELECTED DIVISIONS" D
 .S SDI=0 F  S SDI=$O(SDDIV(SDI)) Q:'SDI  S SDIV(SDDIV(SDI))=SDI
 .Q
 I $P(SDDIV,U,2)="ALL DIVISIONS" D
 .S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDI)) Q:'SDI  S SDX=$P($G(^DG(40.8,SDI,0)),U) S:'$L(SDX) SDX="***UNKNOWN***" S SDIV(SDX)=SDI
 .Q
 S:$D(SDIV)'>1 SDIV($P(SDDIV,U,2))=$P(SDDIV,U,3)
 G:SDOUT EXIT D:$E(IOST)="C" DISP0^SCRPW23 S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  S SDIV=SDIV(SDIVN) D DPRT(.SDIV)
 G:SDOUT EXIT S SDMD=0,SDMD=$O(^TMP("SCRPW",$J,SDMD)),SDMD=$O(^TMP("SCRPW",$J,SDMD)) I SDMD S SDIV=0 D DPRT(.SDIV)
 I $E(IOST)="C",'SDOUT W ! N DIR S DIR(0)="E" D ^DIR
 ;
EXIT K SDIV,SDIVN,SDMD,SDOUT,SDSTOP,SDDIV,SDBDT,SDCT,SDDFN,SDDT,SDEDT,SDFIG,SDI,SDLINE,SDMAX,SDMO,SDOE,SDOE0,SDPAGE,SDPNOW,SDXDT,SDXEDT,SDXMO,SDXYR,SDYR,Y,%,SDX,SDFIG1,DTOUT,DUOUT,X,Y D END^SCRPW50 Q
 ;
DPRT(SDIV) ;Print division
 K SDTIT D DHDR^SCRPW46(SDIV,1,.SDTIT) I '$D(^TMP("SCRPW",$J,SDIV)) S SDX="No activity within report parameters found for this division!" D HDR Q:SDOUT  W !!?(IOM-$L(SDX)\2),SDX Q
 S SDDT=SDBDT D FIG,HDR,HD1 Q:SDOUT  D LINE(SDDT) F  S SDDT=$O(^TMP("SCRPW",$J,SDIV,"YR",SDDT)) Q:'SDDT!SDOUT  D LINE(SDDT)
 D:$Y>($S(IOSL<80:IOSL,1:80)-5) HDR Q:SDOUT  F  W ! Q:$Y>($S(IOSL<80:IOSL,1:80)-6)
 W !?25,"Uniques in this report are based on OUTPATIENT ENCOUNTER file records with a"
 W !?25,"status of '"_$S(SDSTA=2:"",SDSTA=8:"inpatient appointment ",1:"Out/Inpatient ")_"checked out'.  This excludes any 'action required' activity."
 Q
 ;
DIV(SDD) ;Check division
 ;Required input: MEDICAL CENTER DIVISION pointer
 Q:'SDDIV 1
 Q $D(SDDIV(SDD))
 ;
SET(SDIV) ;Set TMP global
 S SDSTOP=SDSTOP+1 D:SDSTOP#2000=0 STOP Q:SDOUT
 Q:'SDIV  D SET1(SDIV) D:SDMD SET1(0) Q
 ;
SET1(SDIV) S ^TMP("SCRPW",$J,SDIV,"PT",SDDFN,$E(SDDT,1,5)_"00")="" Q
 ;
OENC S SDXDT=SDBDT,SDDFN=0
 F  S SDDFN=$O(^SCE("ADFN",SDDFN)) Q:'SDDFN  S SDDT=SDXDT F  S SDDT=$O(^SCE("ADFN",SDDFN,SDDT)) Q:'SDDT!(SDDT>SDEDT)  D OENC1
 Q
 ;
OENC1 S SDOE=0 F  S SDOE=$O(^SCE("ADFN",SDDFN,SDDT,SDOE)) Q:'SDOE  S SDOE0=$$GETOE^SDOE(SDOE) I $$OE(SDOE0,SDSTA) S SDIV=$P(SDOE0,U,11) I SDIV,$$DIV(SDIV) D SET(SDIV)
 Q
 ;
OE(SDOE0,SDSTA) ;Evaluate (in)outpatient encounter
 ;Required input: SDOE0=OUTPATIENT ENCOUNTER zeroeth node
 ;                SDSTA=2 -outpatient,8 -inpatient, 2^8 -both
 ;Output: '1' if checked out "parent" encounter, '0' otherwise
 I $P(SDOE0,U,4),$P($G(^SC($P(SDOE0,U,4),0)),U,17)="Y" Q 0
 S SDSTA=$G(SDSTA,2),SDSTA="^"_SDSTA_"^"
 Q:'$P(SDOE0,U,6)&(SDSTA[$P(SDOE0,U,12))&($P(SDOE0,U,7)'="") 1
 Q 0
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
HDR D STOP Q:SDOUT  I $E(IOST)="C" N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 W:SDPAGE>1!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0) W SDLINE,!?36,"<*>  TREND OF FACILITY UNIQUES BY 12 MONTH DATE RANGES  <*>"
 N SDI S SDI=$S(SDSTA=2:"Checked Out - Outpatients",SDSTA=8:"Checked Out - Inpatients",1:"Checked Out - Out/Inpatients") W !,?53,SDI ;?(132-SDI\2),SDI
 S SDI=0 F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(132-$L(SDTIT(SDI))\2),SDTIT(SDI)
 W !,SDLINE,!,"Date printed: ",SDPNOW,?125,"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1 Q
 ;
HD1 Q:SDOUT  W !!,"12 mo. date range",?23,"Uniques",?32,"| Histogram (each ""*"" equals ",SDFIG," unique",$S(SDFIG=1:"",1:"s"),")",!,$E(SDLINE,1,SDFIG1) Q
 ;
DTINC(SDDT) ;Increment date by one month
 ;Required input: SDDT=date
 ;Output: next month to examine
 Q:$E(SDDT,4,5)=12 $E(SDDT,1,3)+1_"0100"
 Q $E(SDDT,1,5)+1_"00"
 ;
LOOK S ^TMP("SCRPW",$J,SDIV,"YR",SDDT)=0,SDDFN=0 F  S SDDFN=$O(^TMP("SCRPW",$J,SDIV,"PT",SDDFN)) Q:'SDDFN  D L1
 Q
 ;
L1 I $D(^TMP("SCRPW",$J,SDIV,"PT",SDDFN,SDDT)) D LSET Q
 S SDX=$O(^TMP("SCRPW",$J,SDIV,"PT",SDDFN,SDDT)) I SDX,SDX<SDXDT D LSET
 Q
 ;
LSET S ^TMP("SCRPW",$J,SDIV,"YR",SDDT)=^TMP("SCRPW",$J,SDIV,"YR",SDDT)+1 Q
 ;
YDTINC(SDDT) ;Increment date by one year
 ;Required input: SDDT=date
 ;Output: date + 1 year
 Q $E(SDDT,1,3)+1_$E(SDDT,4,7)
 ;
FIG S SDMAX=^TMP("SCRPW",$J,SDIV,"YR","MAX") F SDFIG=1,10,25,50,100,250,500,1000,2500,5000,10000 Q:SDMAX/SDFIG<99
 S SDFIG1=34+(SDMAX\SDFIG) S:SDFIG1<73 SDFIG1=73 Q
 ;
LINE(SDDT) ;Print statistics line
 ;Required input: SDDT=date
 D:$Y>(IOSL-3) HDR,HD1 Q:SDOUT  S SDCT=^TMP("SCRPW",$J,SDIV,"YR",SDDT),SDMO=$E(SDDT,4,5),SDYR=(17+$E(SDDT))_$E(SDDT,2,3),SDXMO=SDMO-1 S:SDXMO=0 SDXMO=12 S:$L(SDXMO)=1 SDXMO=0_SDXMO
 S SDXYR=$S(SDXMO=12:SDYR,1:SDYR+1)
 W !,SDMO,"/",SDYR," thru ",SDXMO,"/",SDXYR,?24,$J(SDCT,6,0),?32,"| " F SDI=1:1:(SDCT\SDFIG) W "*"
 Q
