SCRPW59 ;RENO/KEITH - Visits and Unique SSNs by County (OP9) or (IP9) ; 15 Jul 98  02:38PM
 ;;5.3;Scheduling;**144,466**;AUG 13, 1993;Build 2
 S SDSTA=$G(SDSTA,2)
 D RQUE^SCRPW50("START^SCRPW59","Visits and Unique SSNs by County "_$S(SDSTA=2:"(OP9)",1:"(IP9)")) Q
 ;
START ;Print report
 K ^TMP("SCRPW",$J) S (SDSTOP,SDOUT)=0,SDT=SD("FYD")
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!SDOUT!(SDT>SD("EDT"))  S SDOE=0 F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE),SDIV=$P(SDOE0,U,11) I $$VALID() D SET(SDIV) D:SDMD SET(0)
 G:SDOUT EXIT S SDLINE="",$P(SDLINE,"-",(IOM+1))="" D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDTIT(1)="<*>  VISITS AND UNIQUE SSNS BY COUNTY "_$S(SDSTA=2:"(OP9)",1:"(IP9)")_"  <*>",SDPG=0,C=(IOM-80\2) D:$E(IOST)="C" DISP0^SCRPW23
 I '$D(^TMP("SCRPW",$J)) S SDPAGE=1,SDX="No activity found within report parameters." D HDR G:SDOUT EXIT W !!?(IOM-$L(SDX)\2),SDX G EXIT
 S (SDVCT,SDIV)="" F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""!SDOUT  D STOP D DLIST S SDX="" F  S SDX=$O(^TMP("SCRPW",$J,SDIV,SDX)) Q:SDX=""!SDOUT  D SUBT
 G:SDOUT EXIT S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  D DPRT(SDIV(SDIVN))
 G:SDOUT EXIT D:SDVCT>1 DPRT(0)
EXIT I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 K ^TMP("SCRPW",$J),%,%H,%I,C,DFN,DIR,SD,SDDIV,SDE,SDI,SDIV,SDIVN,SDLINE,SDMD,SDOE,SDOE0,SDOUT,SDPAGE,SDPG,SDPNOW,SDSTOP,SDT,SDTIT,SDU,SDV,SDVCT,SDX,SDY,X,Y,SDSTA Q
 ;
DPRT(SDV) ;Print division
 ;Required input: SDV=division ifn or '0' for combined divisions
 I SDV S SDTIT(2)="For "_$S(SDDIV["DIVISIONS":"division",1:"facility")_": "_SDIVN
 I 'SDV S SDTIT(2)="Report for: "_$P(SDDIV,U,2) D
 .S SDI=2,SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""  S SDI=SDI+1,SDTIT(SDI)=$J("Division: ",$L(SDIVN))_SDIVN
 .Q
 S SDPAGE=1 D HDR,HD1 Q:SDOUT  S SDX="" F  S SDX=$O(^TMP("SCRPW",$J,SDV,SDX)) Q:SDX=""!SDOUT  S SDY=^TMP("SCRPW",$J,SDV,SDX,"STAT") D PLINE
 Q
PLINE ;Print output line
 D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT
 W !?(C),$E($P(SDX," / ",2),1,22),?(C+24),$E($P(SDX," / "),1,20) F SDI=0:1:2 W ?(C+46+(12*SDI)),$J($P(SDY,U,(SDI+1)),10,0)
 Q
 ;
HDR ;Print header
 I $E(IOST)="C",SDPG N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT  W:SDPG!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 N SDI S SDI=0 W SDLINE F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(IOM-$L(SDTIT(SDI))\2),SDTIT(SDI)
 W !,SDLINE,!,"For Fiscal Year activity through ",SD("PEDT"),!,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1,SDPG=1 Q
 ;
HD1 ;Print subheader
 Q:SDOUT  W !?(C),"County",?(C+24),"State",?(C+50),"Visits",?(C+58),"Encounters",?(C+73),"Uniques",!?(C),$E(SDLINE,1,22),?(C+24),$E(SDLINE,1,20),?(C+46),$E(SDLINE,1,10),?(C+58),$E(SDLINE,1,10),?(C+70),$E(SDLINE,1,10) Q
 ;
DLIST ;Create alphabetic list of divisions found
 Q:'SDIV  S SDX=$P($G(^DG(40.8,SDIV,0)),U) S:'$L(SDX) SDX="*** UNKNOWN ***" S SDIV(SDX)=SDIV,SDVCT=SDVCT+1 Q
 ;
SUBT ;Count uniques and visits
 S (SDU,SDV,DFN)=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,SDX,DFN)) Q:'DFN  S SDU=SDU+1,SDT=0 F  S SDT=$O(^TMP("SCRPW",$J,SDIV,SDX,DFN,SDT)) Q:'SDT  S SDV=SDV+1
 S SDE=^TMP("SCRPW",$J,SDIV,SDX,"STAT"),^TMP("SCRPW",$J,SDIV,SDX,"STAT")=SDV_U_SDE_U_SDU
 Q
 ;
VALID() ;Check encounter record
 I $P(SDOE0,U,4),$P($G(^SC($P(SDOE0,U,4),0)),U,17)="Y" Q 0
 I SDIV,$$DIV(),$P(SDOE0,U,2),'$P(SDOE0,U,6),$P(SDOE0,U,7),$P(SDOE0,U,12)=SDSTA Q 1
 Q 0
 ;
DIV() ;Check division
 Q:'SDDIV 1  Q $D(SDDIV(SDIV))
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
SET(SDIV) ;Set division lists
 ;Required input: SDIV=division ifn or '0' for summary
 S SDSTOP=SDSTOP+1 I SDSTOP#2000=0 D STOP^SCRPW40 Q:SDOUT
 K SDX D PDSC^SCRPW24(.SDX) S SDX=$O(SDX("")),SDX=$P(SDX(SDX),U,2)
 S ^TMP("SCRPW",$J,SDIV,SDX,"STAT")=$G(^TMP("SCRPW",$J,SDIV,SDX,"STAT"))+1,^TMP("SCRPW",$J,SDIV,SDX,$P(SDOE0,U,2),$P(SDT,"."))=""
 Q
