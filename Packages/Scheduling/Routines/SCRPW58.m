SCRPW58 ;RENO/KEITH - Most Frequent 20 Practitioner Types (OP8) or (IP8); 15 Jul 98  8:28 PM
 ;;5.3;Scheduling;**144,466**;AUG 13, 1993;Build 2
 ;Most Frequent 20 Practitioner Types (OP8) or (IP8)
 S SDSTA=$G(SDSTA,2)
 D RQUE^SCRPW50("START^SCRPW58","Most Frequent 20 Practitioner Types "_$S(SDSTA=2:"(OP8)",1:"(IP8)"),1) Q
 ;
START ;Print report
 K ^TMP("SCRPW",$J) S (SDSTOP,SDOUT)=0,SDT=SD("FYD")
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!SDOUT!(SDT>SD("EDT"))  S SDOE=0 F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE),SDIV=$P(SDOE0,U,11) I $$VALID() D SET(SDIV) D:SDMD SET(0)
 G:SDOUT EXIT S (SDVCT,SDIV)=""
 F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""!SDOUT  D STOP,DLIST S SDX="" F  S SDX=$O(^TMP("SCRPW",$J,SDIV,0,SDX)) Q:SDX=""!SDOUT  S SDI=^TMP("SCRPW",$J,SDIV,0,SDX),^TMP("SCRPW",$J,SDIV,1,SDI,SDX)=""
 G:SDOUT EXIT S SDLINE="",$P(SDLINE,"-",(IOM+1))="" D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDTIT(1)="<*>  MOST FREQUENT 20 PRACTITIONER TYPES "_$S(SDSTA=2:"(OP8)",1:"(IP8)")_"  <*>",SDPG=0 D:$E(IOST)="C" DISP0^SCRPW23
 I '$D(^TMP("SCRPW",$J)) S SDPAGE=1,SDX="No activity found within report parameters." D HDR G:SDOUT EXIT W !!?(IOM-$L(SDX)\2),SDX G EXIT
 G:SDOUT EXIT S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  D DPRT(SDIV(SDIVN))
 G:SDOUT EXIT D:SDVCT>1 DPRT(0)
EXIT I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 K ^TMP("SCRPW",$J),%,%H,%I,DIR,SD,SDARY,SDCD,SDDIV,SDI,SDII,SDIV,SDIVN,SDLINE,SDMD,SDOE,SDOE0,SDOUT,SDPAGE,SDPC,SDPG,SDPNOW,SDSPE,SDSTOP,SDSUB,SDT,SDTIT,SDV,SDVCT,SDX,X,Y,SDSTA Q
 ;
DPRT(SDV) ;Print division
 ;Required input: SDV=division ifn or '0' for combined divisions
 I SDV S SDTIT(2)="For "_$S(SDDIV["DIVISIONS":"division",1:"facility")_": "_SDIVN
 I 'SDV S SDTIT(2)="Report for: "_$P(SDDIV,U,2) D
 .S SDI=2,SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""  S SDI=SDI+1,SDTIT(SDI)=$J("Division: ",$L(SDIVN))_SDIVN
 .Q
 S SDPAGE=1 D HDR,HD1 Q:SDOUT  S (SDI,SDII)="" F  S SDI=$O(^TMP("SCRPW",$J,SDV,1,SDI),-1) Q:SDI=""!SDOUT!(SDII>19)  S SDX="" F  S SDX=$O(^TMP("SCRPW",$J,SDV,1,SDI,SDX)) Q:SDX=""!SDOUT!(SDII>19)  D PLINE
 Q
 ;
PLINE ;Print output line
 D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT
 S SDPC=$$CODE2TXT^XUA4A72(SDX) Q:'$L(SDPC)
 S SDCD=+$P(SDX,"V",2),SDSPE=$P(SDPC,U,2),SDSUB=$P(SDPC,U,3),SDII=SDII+1
 W !,$J(SDII,3,0),?6,$J(SDCD,7,0),?15,$E(SDSPE,1,51),?68,$E(SDSUB,1,52),?122,$J(SDI,10,0)
 Q
 ;
HDR ;Print header
 I $E(IOST)="C",SDPG N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT  W:SDPG!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 N SDI S SDI=0 W SDLINE F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(IOM-$L(SDTIT(SDI))\2),SDTIT(SDI)
 W !,SDLINE,!,"For Fiscal Year activity through ",SD("PEDT"),!,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1,SDPG=1 Q
 ;
HD1 ;Print subheader
 Q:SDOUT  W !,"Rank",?6,"VA Code",?15,"Specialty",?68,"Subspecialty",?123,"Frequency",!,"----  -------  ",$E(SDLINE,1,51),?68,$E(SDLINE,1,52),?122,"----------" Q
 ;
DLIST ;Create alphabetic list of divisions found
 Q:'SDIV  S SDX=$P($G(^DG(40.8,SDIV,0)),U) S:'$L(SDX) SDX="*** UNKNOWN ***" S SDIV(SDX)=SDIV,SDVCT=SDVCT+1 Q
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
 N SDARY,SDI,SDX
 D PROV^SCRPW50(SDOE,.SDARY)
 S SDI=0 F  S SDI=$O(SDARY(SDI)) Q:'SDI  S SDX=SDARY(SDI) I $L(SDX) D
 .S ^TMP("SCRPW",$J,SDIV,0,SDX)=$G(^TMP("SCRPW",$J,SDIV,0,SDX))+1
 .Q
 Q
