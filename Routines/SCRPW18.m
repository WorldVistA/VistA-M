SCRPW18 ;RENO/KEITH/MRY - ACRP encounter consistency checker ; 21 JUL 2000  2:17 PM
 ;;5.3;Scheduling;**139,144,155,222,387,466**;AUG 13, 1993;Build 2
CHEK(ENCPTR,SDARY,SDSTR) ;Consistency checker for outpatient encounter transactions
 ;Required input: ENCPTR=OUTPATIENT ENCOUNTER record IEN
 ;Required input: SDARY=array (passed by reference) of HL7 segments to 
 ;                check in the format SDARY(segmentname)="".  Returns
 ;                SDARY(segmentname)="", if no errors for that segment.
 ;                If errors exist for a specific segment, returns:
 ;
 ;  SDARY(segment)="-1^Element in xxx segment failed validity check"
 ;  SDARY(segment,errorcode)=error code description (from file #409.76)
 ;
 ;                If passed in as an undefined array, all segments will
 ;                be checked; otherwise, only segment names
 ;                in the array subscript will be checked.
 ;Optional input: SDSTR array as established by SEG^SCRPW18
 ;Output: 1=inconsistencies found, 0=no inconsistencies found
 ;
 N HL,HLEID,ENCDT,EVNTDATE,EVNTHL7,SEG,DELPTR,SDERR,DFN,VAFSTR,NODE,SDE1,SDI,SDX,VALERR,XMITPTR,ENCNDT S VALERR="SDE1",XMITPTR=""
 D:$D(SDSTR)<10 STR(.SDSTR) I $D(SDARY)<10 S SEG="" F  S SEG=$O(SDSTR(SEG)) Q:SEG=""  S SDARY(SEG)=""
 S NODE=$$GETOE^SDOE(ENCPTR) Q:'$L(NODE) 0  S DFN=$P(NODE,U,2)
 S SDERR=0,DELPTR="",HLEID=+$O(^ORD(101,"B","SCDX AMBCARE SEND SERVER FOR ADT-Z00",0)),ENCDT=$P($P(NODE,U),"."),EVNTDATE=$P(NODE,U),ENCNDT=EVNTDATE,EVNTHL7="A08" D INIT^HLFNC2(HLEID,.HL)
 S SEG="" F  S SEG=$O(SDARY(SEG)) Q:SEG=""  S VAFSTR=$G(SDSTR(SEG)) I $L(VAFSTR) D VER(SEG,VAFSTR,.SDARY,.SDERR) K @("VAF"_SEG)
 Q SDERR
 ;
VER(SEG,VAFSTR,SDARY,SDERR) ;Verify a segment
 ;Required input: SEG=segment name
 ;Required input: VAFSTR=segment string
 ;Required input: SDARY=array for error return
 ;Required input: SDERR=variable to return error status (pass by reference)
 ;Output: SDARY(SEG)=error (if one exists)
 N VAFARRY,TAG,ERROR,ERRSUB S SDARY(SEG)=""
 K ^TMP("SCRPWVER",$J) S VAFARRY="^TMP(""SCRPWVER"","_$J_","""_SEG_""")" S ERROR=0 F TAG="BLD"_SEG_"^SCDXMSG1","VLD"_SEG_"^SCDXMSG1" D @TAG
 K ^TMP("SCRPWVER",$J) I ERROR'=0 S SDARY(SEG)=ERROR,SDERR=1,SDI="" F  S SDI=$O(SDE1(SEG,SDI)) Q:SDI=""  S SDX=SDE1(SEG,SDI),SDARY(SEG,SDX)=$P($G(^SD(409.76,+$O(^SD(409.76,"B",SDX,"")),1)),U)
 Q
 ;
STR(SDSTR) ;Create segment string
 ;Required input: SDSEG=array to return segment strings (pass by reference)
 ;Output: array of segments and strings in the format SDSTR(segment)=segment string
 N SDI,SDSEG
 D SEGMENTS^SCDXMSG1("A08","SDSTR") S SDI=0 F  S SDI=$O(SDSTR(SDI)) Q:'SDI  S SDSEG=$O(SDSTR(SDI,"")),SDSTR(SDSEG)=SDSTR(SDI,SDSEG) K SDSTR(SDI,SDSEG)
 Q
 ;
SEGS(SDARY) ;Return segments to validate
 ;Optional input: SDARY=array to return list of segments in
 ;Output: string of HL7 segments to validate
 N SD,SDS,SDL
 S SDS="PID^ZIR^ZEL^ZPD^ZSP^DG1^PR1^ZCL^ZSC^ROL^"
 K SDARY F SDL=1:1 S SD=$P(SDS,U,SDL) Q:SD=""  S SDARY(SD)=""
 Q SDS
 ;
 ;Modules to print the Encounter 'Action Required' Report
DET ;Print detail
 S SDT(1)="<*>  ENCOUNTER 'ACTION REQUIRED' REPORT  <*>",SDFF=0,SDCG="" F  S SDCG=$O(^TMP("SCRPW",$J,SDIV,1,SDCG)) Q:SDCG=""  D HDR(.SDT,"D") Q:SDOUT  W:SD("FORMAT")="AG" !?2,"Clinic group: ",SDCG D TPRT
 Q
 ;
TPRT S SDCLN="" F  S SDCLN=$O(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN)) Q:SDCLN=""!SDOUT  D:(SDFF&$G(SD("PAGE"))!($Y>(IOSL-6))) HDR(.SDT,"D") Q:SDOUT  W !!?8,"Clinic: ",SDCLN S SDFF=1 D PPRT
 Q
 ;
PPRT S SDORD="" F  S SDORD=$O(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN,SDORD)) Q:SDORD=""!SDOUT  S DFN="" F  S DFN=$O(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN,SDORD,DFN)) Q:DFN=""!SDOUT  D PP1
 Q
 ;
PP1 S SDPT0=^TMP("SCRPW",$J,SDIV,3,DFN),SDPTNA=$P(SDPT0,U),SDSN=$P(SDPT0,U,3)
 S SDOE=0 F  S SDOE=$O(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN,SDORD,DFN,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE) I $L(SDOE0) D ETCO,PP2
 Q
 ;
PP2 S SDCT=2,SDI="" F  S SDI=$O(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN,SDORD,DFN,SDOE,SDI)) Q:SDI=""  S SDCT=SDCT+1
 D:$Y>(IOSL-SDCT) HDR(.SDT,"D") Q:SDOUT  W !!,$E(SDPTNA,1,24),?26,SDSN S Y=$P(SDOE0,U) X ^DD("DD") W ?39,$P(Y,":",1,2),?58,SDTY,?81,$E(SDCI,1,25),?107,$E(SDCO,1,25),!,?26,"Status: ",$P($G(^SD(409.63,+$P(SDOE0,U,12),0)),U)
 S SDCT=0,SDI="" F  S SDI=$O(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN,SDORD,DFN,SDOE,SDI)) Q:SDI=""!SDOUT  D
 .W ! W:'SDCT ?8,"Required elements:" S SDX=^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN,SDORD,DFN,SDOE,SDI) W ?27,$$DEF(SDX,104) S SDCT=SDCT+1
 .Q
 Q
 ;
ETCO S (SDTY,SDCI,SDCO)="" D:$P(SDOE0,U,8)=1 ETAP D:$P(SDOE0,U,8)=2 ETAE D:$P(SDOE0,U,8)=3 ETDIS Q
 ;
ETDIS S SDTY="DISPOSITION",SDDIS=$P(SDOE0,U,9),SDDIS=$G(^DPT(DFN,"DIS",+SDDIS,0)),SDCI=$P(SDDIS,U,5),SDCI=$P($G(^VA(200,+SDCI,0)),U),SDCO=$P(SDDIS,U,9),SDCO=$P($G(^VA(200,+SDCO,0)),U) Q
 ;
ETAP S SDAP0=$G(^DPT(DFN,"S",$P(SDOE0,U),0)) Q:'$L(SDAP0)  S SDCL=$P(SDAP0,U) Q:SDCL'=$P(SDOE0,U,4)
 S X=$P(SDAP0,U,7),SDTY=$S(X=3:"SCHEDULED APPOINTMENT",X=4:"UNSCHEDULED VISIT",X=2:"10-10 VISIT",X=1:"C&P APPOINTMENT",1:"")
 S SDCLPT=0 F  S SDCLPT=$O(^SC(SDCL,"S",$P(SDOE0,U),1,SDCLPT)) Q:'SDCLPT  Q:$P(^SC(SDCL,"S",$P(SDOE0,U),1,SDCLPT,0),U)=DFN
 Q:'SDCLPT  I SDTY["UNSCH" S SDCI=$P(^SC(SDCL,"S",$P(SDOE0,U),1,SDCLPT,0),U,6) S:SDCI SDCI=$P($G(^VA(200,SDCI,0)),U)
 S SDCLPTC=$G(^SC(SDCL,"S",$P(SDOE0,U),1,SDCLPT,"C")) Q:'$L(SDCLPTC)  I $P(SDCLPTC,U,2) S SDCI=$P($G(^VA(200,+$P(SDCLPTC,U,2),0)),U)
 I $P(SDCLPTC,U,4) S SDCO=$P($G(^VA(200,+$P(SDCLPTC,U,4),0)),U)
 Q
 ;
ETAE S SDTY="ADD/EDIT ENCOUNTER",SDV=$P(SDOE0,U,5),SDCO=$P($G(^AUPNVSIT(+SDV,0)),U,23),SDCO=$P($G(^VA(200,+SDCO,0)),U)
 Q
 ;
T2() Q:SD("FORMAT")="AC" "For all clinics"  Q:SD("FORMAT")="SC" "For selected clinics"
 I SD("FORMAT")="RC" N SDC,SDX S SDC=$O(SD("CLINIC","")),SDX="For range of clinics: "_SDC,SDC=$O(SD("CLINIC",SDC)) Q SDX_" to "_SDC
 I SD("FORMAT")="SS" N SDX,SDI S SDX="" D  Q SDX
 .S SDI=0 F  S SDI=$O(SD("STOPCODE",SDI)) Q:'SDI  S SDX=SDX_", "_SDI
 .S SDI=$S($L(SDX,", ")>11:", <more>",1:"")
 .S SDX="For selected Stop Codes: "_$P(SDX,", ",2,11)_SDI
 .Q
 I SD("FORMAT")="RS" N SDX,SDI S SDI=$O(SD("STOPCODE","")),SDX="For range of Stop Codes: "_SDI,SDI=$O(SD("STOPCODE",SDI)) Q SDX_" to "_SDI
 Q:SD("FORMAT")="AG" "For all clinic groups"  Q "For clinic group: "_$P(SD("GROUP"),U,2)
 ;
HD1 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDLINE="",$P(SDLINE,"-",133)="",Y=SD("BDT") X ^DD("DD") S SDBDAY=Y,Y=$P(SD("EDT"),".") X ^DD("DD") S SDEDAY=Y,SDPAGE=1 Q
 ;
HDR(SDT,SDR) ;Print header
 ;Required input: SDT=array of report titles
 ;Required input: SDR=report type
 D STOP^SCRPW16 Q:SDOUT
 I $E(IOST)="C",SDPAGE>1 N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 N SDI W:SDPAGE'=1!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0) W SDLINE S SDI=0 F  S SDI=$O(SDT(SDI)) Q:'SDI  W !?(132-$L(SDT(SDI))\2),SDT(SDI)
 W !,SDLINE,!,"For date range: ",SDBDAY," to ",SDEDAY,!,"Date printed: ",SDPNOW,?(126-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1
 I SDR="D" W !,"Patient:",?26,"SSN:",?39,"Date/time:",?58,"Type:",?81,"Check-in user:",?107,"Check-out user:",!,SDLINE
 Q
 ;
STAT ;Print statistics
 S SDT(1)="<*>  ENCOUNTER 'ACTION REQUIRED' STATISTICS  <*>" D HDR(.SDT,"S") S SDCG="" F  S SDCG=$O(^TMP("SCRPW",$J,SDIV,1,SDCG)) Q:SDCG=""  D ST1
 D:$Y>(IOSL-3) HDR(.SDT,"S") W !!?35,$S(SDIV:"DIVISION",1:"TOTAL")," 'ACTION REQUIRED' ENCOUNTERS IDENTIFIED: ",SDFCT(SDIV) Q
 ;
ST1 I SD("FORMAT")["G" D:$Y>(IOSL-7) HDR(.SDT,"S") S SDX="Clinic group: "_SDCG W !!?(132-$L(SDX)\2),SDX,!
 D REASON D:$Y>(IOSL-4) HDR(.SDT,"S") W !!?35,"Clinic:"
 S SDCLN="" F  S SDCLN=$O(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN)) Q:SDCLN=""  D:$Y>(IOSL-2) HDR(.SDT,"S") W !?35,SDCLN,?89,$J(^TMP("SCRPW",$J,SDIV,1,SDCG,SDCLN),6)
 I SD("FORMAT")["G" D:$Y>(IOSL-3) HDR(.SDT,"S") S SDX="Total for clinic group "_SDCG_": "_^TMP("SCRPW",$J,SDIV,1,SDCG) W !!?(132-$L(SDX)\2),SDX,!?35,$E(SDLINE,1,60),!
 Q
 ;
REASON D:$Y>(IOSL-4) HDR(.SDT,"S") W !?35,"Reason:" S SDI=""
 F  S SDI=$O(^TMP("SCRPW",$J,SDIV,2,SDCG,SDI)) Q:SDI=""  D:$Y>(IOSL-3) HDR(.SDT,"S") W !?35,$$DEF(SDI,52),?89,$J(^TMP("SCRPW",$J,SDIV,2,SDCG,SDI),6)
 W ! Q
 ;
DEF(SDX,SDL) ;Produce deficiency external value
 ;Required input: SDX=error code or value
 ;Required input; SDL=maximum length of output string
 Q:'$D(^SD(409.76,"B",SDX)) $E(SDX,1,SDL)
 N SDERR S SDERR=$$ERRSUB^SCRPW17(SDX) I SDERR'="" Q $E(SDERR,1,SDL)
 N SDV S SDV=$P($G(^SD(409.76,+$O(^SD(409.76,"B",SDX,"")),1)),U)
 Q $S($L(SDV):$E(SDV,1,SDL),1:$E(SDX,1,SDL))
