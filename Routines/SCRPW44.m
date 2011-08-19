SCRPW44 ;RENO/KEITH - Means Test/Eligibility/Enrollment Report (cont.) ; 03 Feb 99  2:10 PM
 ;;5.3;Scheduling;**144,176**;AUG 13, 1993
START ;Print report
 D S44^SCRPW42 Q
 ;
DPRT(SDIV) ;Print a division
 ;Required input: SDIV=division ifn or '0' for facility totals
 I 'SDPG S SDTIT(2)="Report parameters selected",SDPAGE=1 D HDR Q:SDOUT  D PD1^SCRPW43(0) Q:SDOUT
 S SDPAGE=1 D DHDR^SCRPW40(2,.SDTIT)
 D HDR Q:SDOUT  I '$D(^TMP("SCRPW",$J,0,SDIV)) S SDX="No activity found that meets the report criteria!" W !!?(IOM-$L(SDX)\2),SDX Q
 D SUMM(SDIV) Q:SDOUT  Q:$P(SD("FMT",1),U)'="D"
 S SDTIT(2)="Detail by "_$P(SD("FMT",2),U,2)_" for:"_$P(SDTIT(2),":",2) D PRTD Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
HDR ;Print report header
 I $E(IOST)="C",SDPG N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT
 I SDPG!($E(IOST)="C") W $$XY^SCRPW50(IOF,1,0)
 W:$X $$XY^SCRPW50("",0,0) W SDLINE N SDI S SDI=0 F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(IOM-$L(SDTIT(SDI))\2),SDTIT(SDI)
 W !,SDLINE,!,"For date range: ",$P(SD("BDT"),U,2)," to ",$P(SD("EDT"),U,2),!,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPG=1,SDPAGE=SDPAGE+1,SDPGL=0 Q
 ;
SUMM(SDIV) ;Print summary for a division
 ;Required input: SDIV=division ifn or '0' for facility total
 D SHDS("E N C O U N T E R   M E A N S   T E S T   I N D I C A T O R","Means Test indicator") Q:SDOUT  D SLP("MT") Q:SDOUT  D STOT Q:SDOUT
 D SHDS("E N C O U N T E R   E L I G I B I L I T Y","Encounter eligibility") Q:SDOUT  D SLP("EE") Q:SDOUT  D STOT Q:SDOUT
 D SHDS("C U R R E N T   E N R O L L M E N T   P R I O R I T Y","Enrollment priority") Q:SDOUT  D SLP("EP") Q:SDOUT  D STOT Q
 ;
SHDS(SDX,SDY) ;Print subheader for summary
 D:$Y>(IOSL-8) HDR Q:SDOUT
 W !!?(IOM-$L(SDX)\2),SDX,!?(IOM-$L(SDX)\2),$E(SDLINE,1,$L(SDX))
 W !?(C),SDY,?(C+40),"Encounters",?(C+59),"Visits",?(C+73),"Uniques",!?(C),$E(SDLINE,1,30),?(C+40),$E(SDLINE,1,10),?(C+55),$E(SDLINE,1,10),?(C+70),$E(SDLINE,1,10) Q
 ;
SLP(SDI) ;Print summary line
 S SDX="" F  S SDX=$O(^TMP("SCRPW",$J,0,SDIV,SDI,SDX)) Q:SDX=""!SDOUT  D
 .S SDE=^TMP("SCRPW",$J,0,SDIV,SDI,SDX,"ENC"),SDV=$P(SDE,U,2),SDU=$P(SDE,U,3),SDE=$P(SDE,U)
 .Q:SDOUT  D:$Y>(IOSL-2) HDR Q:SDOUT
 .W !?(C),SDX,?(C+40),$J(SDE,10,0),?(C+55),$J(SDV,10,0),?(C+70),$J(SDU,10,0)
 .Q
 Q
 ;
STOT ;Print summary total
 D:$Y>(IOSL-3) HDR Q:SDOUT
 S SDE=^TMP("SCRPW",$J,0,SDIV,"RPT","ENC"),SDV=$P(SDE,U,2),SDU=$P(SDE,U,3),SDE=$P(SDE,U)
 W !?(C),$E(SDLINE,1,30),?(C+40),$E(SDLINE,1,10),?(C+55),$E(SDLINE,1,10),?(C+70),$E(SDLINE,1,10),!?(C),"TOTAL:",?(C+40),$J(SDE,10,0),?(C+55),$J(SDV,10,0),?(C+70),$J(SDU,10,0)
 Q
 ;
PRTD ;Print detail
 I '$D(^TMP("SCRPW",$J,1,SDIV)) D HDR Q:SDOUT  N SDX S SDX="No activity found for this division for selected detail category elements." W !!?(IOM-$L(SDX)\2),SDX Q
 S S0="" F  S S0=$O(^TMP("SCRPW",$J,1,SDIV,S0)) Q:S0=""!SDOUT  D HDR,HD1 Q:SDOUT  D PRT0
 Q
 ;
PRT0 ;Print 0 sorts
 S SDT(0)=0 I SD("SORT") D PRT1 Q
 D SHD(0),HD2 S SDPNAM=""
 F  S SDPNAM=$O(^TMP("SCRPW",$J,1,SDIV,S0,SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,1,SDIV,S0,SDPNAM,DFN)) Q:'DFN!SDOUT  S SDX=^TMP("SCRPW",$J,1,SDIV,S0,SDPNAM,DFN) D PLINE(0)
 Q
 ;
PRT1 ;Print 1 sort
 S S1="" F  S S1=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1)) Q:S1=""!SDOUT  D
 .S SDT(1)=0 D:SD("PAGE")=1&SDPGL HDR,HD1 Q:SDOUT
 .I SD("SORT")=1 D PRT11 Q
 .D PRT2,SST(1) Q
 Q
 ;
PRT2 ;Print 2 sorts
 S S2="" F  S S2=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,S2)) Q:S2=""!SDOUT  D
 .S SDT(2)=0 D:SD("PAGE")=2&SDPGL HDR,HD1 Q:SDOUT
 .I SD("SORT")=2 D PRT21 Q
 .D PRT3,SST(2) Q
 Q
 ;
PRT3 ;Print 3 sorts
 S S3="" F  S S3=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,S3)) Q:S3=""!SDOUT  D
 .S SDT(3)=0 D:SD("PAGE")=3&SDPGL HDR,HD1 Q:SDOUT
 .I SD("SORT")=3 D PRT31 Q
 .D PRT4,SST(3) Q
 Q
 ;
PRT4 ;Print 4 sorts
 S S4="" F  S S4=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,S3,S4)) Q:S4=""!SDOUT  D
 .S SDUI=$$DSV^SCRPW43(SDIV,S0,S1,S2,S3,S4)
 .S SDT(4)=0 D:SD("PAGE")=4&SDPGL HDR,HD1 Q:SDOUT
 .I SD("SORT")=4 D PRT41 Q
 .D PRT5,SST(4) Q
 Q
 ;
PRT5 ;Print 5 sorts
 S S5="" F  S S5=$O(^TMP("SCRPW",$J,2,SDUI,S5)) Q:S5=""!SDOUT  D
 .S SDT(5)=0 D:SD("PAGE")=5&SDPGL HDR,HD1 Q:SDOUT
 .I SD("SORT")=5 D PRT51 Q
 .D PRT6,SST(5) Q
 Q
 ;
PRT6 ;Print 6 sorts
 S S6="" F  S S6=$O(^TMP("SCRPW",$J,2,SDUI,S5,S6)) Q:S6=""!SDOUT  S SDT(6)=0 D:SD("PAGE")=6&SDPGL HDR,HD1 Q:SDOUT  D PRT61
 Q
 ;
PRT11 D SHD(1),HD2 S SDPNAM=""
 F  S SDPNAM=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,SDPNAM,DFN)) Q:'DFN!SDOUT  S SDX=^TMP("SCRPW",$J,1,SDIV,S0,S1,SDPNAM,DFN) D PLINE(1)
 W ! D SST(1) Q
 ;
PRT21 D SHD(2),HD2 S SDPNAM=""
 F  S SDPNAM=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,SDPNAM,DFN)) Q:'DFN!SDOUT  S SDX=^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,SDPNAM,DFN) D PLINE(2)
 W ! D SST(2) Q
 ;
PRT31 D SHD(3),HD2 S SDPNAM=""
 F  S SDPNAM=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,S3,SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,S3,SDPNAM,DFN)) Q:'DFN!SDOUT  S SDX=^TMP("SCRPW",$J,1,SDIV,S0,S1,S2,S3,SDPNAM,DFN) D PLINE(3)
 W ! D SST(3) Q
 ;
PRT41 D SHD(4),HD2 S SDPNAM=""
 F  S SDPNAM=$O(^TMP("SCRPW",$J,2,SDUI,SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,2,SDUI,SDPNAM,DFN)) Q:'DFN!SDOUT  S SDX=^TMP("SCRPW",$J,2,SDUI,SDPNAM,DFN) D PLINE(4)
 W ! D SST(4) Q
 ;
PRT51 D SHD(5),HD2 S SDPNAM=""
 F  S SDPNAM=$O(^TMP("SCRPW",$J,2,SDUI,S5,SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,2,SDUI,S5,SDPNAM,DFN)) Q:'DFN!SDOUT  S SDX=^TMP("SCRPW",$J,2,SDUI,S5,SDPNAM,DFN) D PLINE(5)
 W ! D SST(5) Q
 ;
PRT61 D SHD(6),HD2 S SDPNAM=""
 F  S SDPNAM=$O(^TMP("SCRPW",$J,2,SDUI,S5,S6,SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,2,SDUI,S5,S6,SDPNAM,DFN)) Q:'DFN!SDOUT  S SDX=^TMP("SCRPW",$J,2,SDUI,S5,S6,SDPNAM,DFN) D PLINE(6)
 W ! D SST(6) Q
 ;
SHD(SDLEV) ;Print sort subheaders
 ;Required input: SDLEV=number of sort levels
 Q:SDOUT
 I $Y>(IOSL-SDLEV-6) D HDR,HD1 S SDPGL=0 Q:SDOUT
 W:(SD("PAGE")'=SD("SORT")&SDPGL) !!,SDLINE S SDPGL=1
 I SD("SORT") W ! N SDI S SDI=0 D  W !
 .F  S SDI=$O(SD("SORT",SDI)) Q:'SDI  W !?(5*SDI),$P(SD("SORT",SDI),U,2),": ",@("S"_SDI)
 .Q
 Q
 ;
PLINE(SDLEV) ;Print detail line
 D:$Y>(IOSL-3) HDR,HD1,HD2 Q:SDOUT  D ELIG^VADPT S SDMTS=$P(VAEL(9),U,2),SDMTS=$S($L(SDMTS)>13:$E(SDMTS,1,13)_".",1:SDMTS)
 W !,SDPNAM,?32,$P(SDX,U),?44,$P(SDX,U,2),?67,$P(SDX,U,3),?99,$P(SDX,U,4)
 N SDI F SDI=0:1:SDLEV S SDT(SDI)=SDT(SDI)+1
 Q
 ;
SST(SDLEV) ;Print sort subtotal
 D:$Y>(IOSL-3) HDR,HD1 Q:SDOUT
 W !?(5*SDLEV),"SUBTOTAL: ",SDT(SDLEV),"  " S SDX=$P(SD("SORT",SDLEV),U,2)_" = "_@("S"_SDLEV),SDX=$E(SDX,1,(130-$X)) W "(",SDX,")" Q
 ;
HD1 ;Print detail category
 Q:SDOUT  S SDZ=$P(SD("FMT",2),U,2)_": "_S0 W !?(IOM-$L(SDZ)\2),SDZ,!?(IOM-$L(SDZ)\2),$E(SDLINE,1,$L(SDZ)) Q
 ;
HD2 ;Print detail subheader
 Q:SDOUT  D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT  W !,"Patient:",?32,"SSN:",?44,"Means Test Indicator:",?67,"Encounter Eligibility:",?99,"Enrollment Priority:" Q
