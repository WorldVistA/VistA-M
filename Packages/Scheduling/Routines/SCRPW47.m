SCRPW47 ;RENO/KEITH/MLR - Outpatient Diagnosis/Procedure Code Search (cont.) ; 9/29/00 12:34pm
 ;;5.3;Scheduling;**144,180,199**;AUG 13, 1993
 ;;07/22/99 ACS - Added CPT modifiers to the report
 ;  *199*
 ;   - Summary section correction (multiple divisions)
 ;   - Addition of Secondary Division subscript variable: DIV0
 ;   - Displaying only divisions with matching criterial in subheader
 ;
 N SDIV S SDIV=""
 F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""!SDOUT  D
 . S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,1,DFN)) Q:'DFN!SDOUT  D
 .. S (DIV1,DIV0)=0 F  S DIV0=$O(^TMP("SCRPW",$J,SDIV,1,DFN,DIV0)) Q:'DIV0  D
 ...; Screening "DR" or "PR" levels (SDZ) prior to setting print level
 ...; Note:  Patient must have valid Diagnosis or Procedure to print
 ... Q:$G(^TMP("SCRPW",$J,0,1,DFN,DIV0,SDZ))=""
 ... S SDSTOP=SDSTOP+1 D:SDSTOP#1000=0 STOP Q:SDOUT
 ... S SDPT0=$G(^DPT(DFN,0)),SDPTNA=$P(SDPT0,U)
 ... S:$L(SDPTNA) ^TMP("SCRPW",$J,SDIV,2,SDPTNA,DFN,DIV0)=$P(SDPT0,U,9)
 ;
 G:SDOUT EXIT
 D:$E(IOST)="C" DISP0^SCRPW23
 K SDTIT
 S SDTIT(1)="<*>  OUTPATIENT DIAGNOSIS/PROCEDURE CODE SEARCH  <*>"
 D HINI^SCRPW46,BLD^SCRPW21
 S SDTIT(2)="Report Parameters Selected"
 D HDR G:SDOUT EXIT D PD1(0) G:SDOUT EXIT
 ;if no data in file, exit from program
 I '$D(^TMP("SCRPW",$J,0,1)) D  G EXIT
 . K SDTIT(2) D HDR G:SDOUT EXIT
 . S SDX="No activity found within selected report parameters!"
 . W !!?(IOM-$L(SDX)\2),SDX
 . Q
 ;
 I $P(SDDIV,U,2)="SELECTED DIVISIONS" D
 . S SDI=0 F  S SDI=$O(SDDIV(SDI)) Q:'SDI  S SDIVL(SDDIV(SDI))=SDI
 ;
 I $P(SDDIV,U,2)="ALL DIVISIONS" D
 . S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,0,SDI)) Q:'SDI  D
 .. S SDX=$P($G(^DG(40.8,SDI,0)),U)
 .. S:'$L(SDX) SDX="***UNKNOWN***"
 .. S SDIVL(SDX)=SDI
 ;
 S:'$D(SDIVL) SDIVL($P(SDDIV,U,2))=$P(SDDIV,U)
 D:$E(IOST)="C" DISP0^SCRPW23 S SDCOL=$S(IOM=80:0,1:26)
 S SDIVN=""
 F  S SDIVN=$O(SDIVL(SDIVN)) Q:SDIVN=""!SDOUT  D DPRT(SDIVL(SDIVN))
 G:SDOUT EXIT S SDMD=0,SDMD=$O(^TMP("SCRPW",$J,SDMD)),SDMD=$O(^TMP("SCRPW",$J,SDMD)) D:SDMD DPRT(0)
 I $E(IOST)="C",'SDOUT W ! N DIR S DIR(0)="E" D ^DIR
 ;
EXIT D END^SCRPW50
 K %,%H,%I,%DT,DFN,DIC,DIR,DTOUT,DUOUT,S1,S2,SD,SDACT,SDAPF,SDBAD,SDC
 K SDC1,SDCL,SDCOL,SDCPT,SDCRI,SDCT,SDD,SDDIV,SDDX,SDEXE,SDF,SDFF
 K SDI,SDI2,SDII,SDIII,SDITX,SDIV,SDIVL,SDIVN,SDIXE,SDL,SDL1,SDLAB
 K SDLAST,SDLF,SDLINE,SDLIST,SDLOC,SDLTH,SDMD,SDNUL,SDOE,SDOE0,SDOTX
 K SDOUT,SDOXE,SDP,SDPAGE,SDPAR,SDPDIV,SDPNAM,SDPNOW,SDPT0,SDPTNA,SDR
 K SDR1,SDR2,SDSEL,SDSSN,SDSTOP,SDSTR,SDT,SDTIT,SDTX,SDTXB,SDTY,SDUI
 K SDUII,SDUIII,SDUIV,SDUJC,SDRESP,SDS1,SDS2,SDV,SDVAL,SDVAR,SDX,SDX2
 K SDFMT,SDY,SDZ,X,X1,X2,X3,X4,Y,Z
 Q  ;EXIT
 ;
HDR D HDR^SCRPW46 Q
 ;
HD1 ;Report subheader
 Q:SDOUT
 W !?(SDCOL),"Patient/Division:",?(SDCOL+26),"SSN:"
 W ?(SDCOL+38),$S('$D(SD("LIST","P")):"Diagnoses:",'$D(SD("LIST","D")):"Procedures/Modifiers:",1:"Diagnoses/Procedures:")
 W !?(SDCOL),$E(SDLINE,1,24),?(SDCOL+26),$E(SDLINE,1,10)
 W ?(SDCOL+38),$E(SDLINE,1,42)
 Q  ;HD1
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
DPRT(SDV) ;Print report for a division
 ;Required input: SDV=division ifn or '0' for summary
 S SDIV=SDV  ;copying division #
 D DHDR^SCRPW46(SDV,2,.SDTIT) S SDPAGE=1 D HDR Q:SDOUT
 I '$D(^TMP("SCRPW",$J,SDV,2)) D
 . S SDX="No activity found within selected report parameters for this division!"
 . W !!?(IOM-$L(SDX)\2),SDX Q
 D HD1 S (SDCT,SDDCT,DIVB)=0,(SDPNAM,SDPNAM2)="",SDF=$P(SDFMT,U)
 F  S SDPNAM=$O(^TMP("SCRPW",$J,SDV,2,SDPNAM)) Q:SDPNAM=""!SDOUT  D
 . S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDV,2,SDPNAM,DFN)) Q:'DFN!SDOUT  D
 .. S SDCT=SDCT+1,DIV0=0
 .. F  S DIV0=$O(^TMP("SCRPW",$J,SDV,2,SDPNAM,DFN,DIV0)) Q:DIV0=""  D
 ... S SDDCT=SDDCT+1,SDSSN=^TMP("SCRPW",$J,SDV,2,SDPNAM,DFN,DIV0)
 ... S SDPNAM2=SDPNAM_" "_DIV0
 ... D DPRT1 W !
 W !?(SDCOL),$E(SDLINE,1,80)
 W !?(SDCOL),"TOTAL PATIENTS IDENTIFIED: ",SDCT
 I SDV=0 W !?(SDCOL),"MULTI-DIVISION PATIENTS:   ",SDDCT-SDCT
 Q
 ;
DPRT1 ;Prints name & ss# of line detail
 D:$Y>(IOSL-6) HDR,HD1 Q:SDOUT
 W !?(SDCOL),$E(SDPNAM2,1,24)
 W ?(SDCOL+26),SDSSN
 S SDLF=0
 ;
 D  ;Calling print format modules
 . D PATIENT
 . I SDF="V" D VISIT Q
 . I SDF="E" D ENCNTR Q
 . Q
 Q  ;DPRT1
 ;
PATIENT ;Prints Patient Diagnosis/Procedures for all Types of Detail
 F SDI="DR","PR" I $D(^TMP("SCRPW",$J,0,1,DFN,DIV0,SDI)) D  Q:SDOUT
 . S SDII="" F  S SDII=$O(^TMP("SCRPW",$J,0,1,DFN,DIV0,SDI,SDII)) Q:SDII=""!SDOUT  D
 .. D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT
 .. D
 ... W:SDLF ! Q
 ... I DIV1'=DIV0 S DIV1=DIV0 W ! Q
 ... Q
 .. W ?(SDCOL+38),$E($S(SDI="DR":"Dx: ",1:"Proc.: ")_SDII,1,42) S SDLF=1
 ..; print mod and desc for current CPT (SDII)
 ..; SDII2 = modifier and description
 .. I $D(^TMP("SCRPW",$J,0,1,DFN,DIV0,SDI,SDII)) D
 ... N SDII2 S SDII2=""
 ... F  S SDII2=$O(^TMP("SCRPW",$J,0,1,DFN,DIV0,SDI,SDII,SDII2)) Q:'SDII2  D
 .... D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT
 .... W !,?(SDCOL+47),"-",$E(SDII2,1,32)
 .. Q
 . Q
 S SDI=0 F  S SDI=$O(SDAPF(2,SDI)) Q:'SDI!SDOUT  S SDOE0=U_DFN_U,SDY=SDAPF(2,SDI) D APF(SDY,SDOE0,5)
 ;
 Q  ;PATIENT
 ;
VISIT ;Printing Type of Detail: Visits
 S SDT=0
 F  S SDT=$O(^TMP("SCRPW",$J,0,1,DFN,DIV0,"ACT",SDT)) Q:'SDT!SDOUT  D
 . D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT
 . S Y=SDT X ^DD("DD") W !?(SDCOL+10),"Visit: ",Y Q
 ;
 Q  ;VISIT
 ;
ENCNTR ;Printing Type of Detail: ENCOUNTER
 S SDT=0
 F  S SDT=$O(^TMP("SCRPW",$J,0,1,DFN,DIV0,"ACT",SDT)) Q:'SDT!SDOUT  D
 . S SDOE=0 F  S SDOE=$O(^TMP("SCRPW",$J,0,1,DFN,DIV0,"ACT",SDT,SDOE)) Q:'SDOE!SDOUT  D
 .. D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT
 .. S SDOE0=^TMP("SCRPW",$J,0,1,DFN,DIV0,"ACT",SDT,SDOE)
 .. S SDLOC=$P($G(^SC(+$P(SDOE0,U,4),0)),U)
 .. S Y=SDT X ^DD("DD") W !?(SDCOL+10),"Encounter: ",$P(Y,":",1,2)
 .. W ?(SDCOL+40),SDLOC
 .. S SDI=0 F  S SDI=$O(SDAPF(1,SDI)) Q:'SDI!SDOUT  S SDY=SDAPF(1,SDI) D APF(SDY,SDOE0,$S($D(SDAPF(2)):15,1:25))
 .. Q
 Q  ;ENCNTR
 ;
APF(SDY,SDOE0,SDC) ;Print additional print fields
 ;Required input: SDY=action acronym^major category^minor category
 ;Required input: SDOE0=zeroeth node of OUTPATIENT ENCOUNTER record
 ;Required input: SDC=column to begin output
 N SDACT,SDX,SDI
 D:$Y>(IOSL-4) HDR,HD1 Q:SDOUT  W !?(SDCOL+SDC),$P(SDY,U,3),":"
 S SDACT=^TMP("SCRPW",$J,"ACT",$P(SDY,U)),SDLF=0,SDC1=SDC+2+$L($P(SDY,U,3))
 K SDX X $P(SDACT,"~",7) S SDX="" F  S SDX=$O(SDX(SDX)) Q:SDX=""!SDOUT  D
 .D:$Y>(IOSL-3) HDR,HD1 Q:SDOUT  W:SDLF ! W ?(SDCOL+SDC1),$E($P(SDX(SDX),U,2),1,(80-SDC1)) S SDLF=1
 .Q
 Q
 ;
PD1(SDI) ;Print parameters
 ;Required input: SDI=0 for all division selections or division ifn
 N SDLF,C S C=(IOM-80\2),SDLF=0 I SDI D PDP("Report for",SDDIV(SDI),1) Q:SDOUT
 I 'SDI D PDP("Report for",SDDIV,2) Q:SDOUT  D
 .F  S SDI=$O(SDDIV(SDI)) Q:'SDI!SDOUT  D PDP("Division",SDDIV(SDI),1)
 Q:SDOUT  D PDP("Beginning date",SD("PBDT"),1,0,1) Q:SDOUT  D PDP("Ending date",SD("PEDT"),1) Q:SDOUT
 S SDI="" F  S SDI=$O(SDPAR(SDI)) Q:SDI=""!SDOUT  D
 .D PDP("Search element '"_SDI_"'",SDPAR(SDI),2,0,1) Q:SDOUT  S SDTY=$P(SDPAR(SDI),U)
 .I SDTY["L" S SDLAB=$S(SDTY["D":"Diagnosis",1:"Procedure") S SDII=0 F  S SDII=$O(SDPAR(SDI,SDII)) Q:'SDII  D PDP(SDLAB,SDPAR(SDI,SDII),1) Q:SDOUT
 .I SDTY["R" S SDVAL=$O(SDPAR(SDI,"")) D PDP("From",SDVAL,1) Q:SDOUT  S SDVAL=$O(SDPAR(SDI,SDVAL)) D PDP("To",SDVAL,1)
 .Q
 S SDI="" F  S SDI=$O(SDCRI(SDI)) Q:SDI=""!SDOUT  D
 .D PDP("Combine logic",SDI,1,0,1) Q:SDOUT  M SDITX=SDCRI(SDI) D WRAP^SCRPW45(.SDITX,.SDOTX,,,60,"") S SDII="" F  S SDII=$O(SDOTX(SDII)) Q:SDII=""!SDOUT  D
 ..S SDLF=SDLF+1 I $E(IOST)="C",SDLF#18=0 D WAIT Q:SDOUT
 ..I $Y>(IOSL-3),$E(IOST)="P" D HDR Q:SDOUT
 ..S SDX=SDOTX(SDII) W !?(IOM-$L(SDX)\2),SDX
 ..Q
 .Q
 D PDP("Type of detail",SDFMT,2,0,1) Q:SDOUT
 S SDIII=0 F SDI=2,1 S SDII=0 F  S SDII=$O(SDAPF(SDI,SDII)) Q:'SDII!SDOUT  D
 .D PDP("Additional print fields",SDAPF(SDI,SDII),3,SDIII,'SDIII) S SDIII=1
 D:$E(IOST)="C" WAIT Q
 ;
PDP(SDT,SDX,SDP,SDL,SDL1) ;Print parameter display line
 ;Required input: SDT=parameter title
 ;Required input: SDX=parameter value
 ;Required input: SDP=$P of SDX to print
 ;Optional input: SDL=1 to suppress title and do line feed
 ;Optional input: SDL1=1 to do additional line feed
 S SDLF=SDLF+1 I $E(IOST)="C",SDLF#18=0 D WAIT Q:SDOUT
 I $Y>(IOSL-3),$E(IOST)="P" D HDR Q:SDOUT
 I $G(SDL1) W ! S SDLF=SDLF+1 I $E(IOST)="C",SDLF#18=0 D WAIT Q:SDOUT
 W ! W:'$G(SDL) $J(SDT,(IOM-6\2)),":" W ?(IOM\2-1),$P(SDX,U,SDP) Q
 ;
WAIT ;Do CRT pause
 N DIR W ! S DIR(0)="E" D ^DIR S SDOUT=Y'=1 W ! Q
