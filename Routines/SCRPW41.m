SCRPW41 ;RENO/KEITH - Veterans Without Activity Since a Specified Date Range ; 5/25/2004
 ;;5.3;Scheduling;**144,375,358**;AUG 13, 1993
 N DIR,%DT K SD
 D TITL^SCRPW50("Veterans Without Activity Since a Specified Date Range")
 W !!,"This report will return a list of veterans that are not deceased who had",!,"activity during a date range specified by the user, and have not been seen"
 W !,"since.  Activity is determined by an examination of Fee Basis, inpatient and",!,"outpatient care (including future appointments).  Once the scheduling"
 W !,"replacement application has been implemented at your site, this report will",!,"no longer be accurate."
 D SUBT^SCRPW50("**** Date Range Selection ****")
 W ! S %DT="AEPX",%DT("A")="Beginning date: " D ^%DT G:Y<1 EXIT^SCRPW42 S SD("BDT")=Y X ^DD("DD") S SD("PBDT")=Y
EDT S %DT("A")="   Ending date: " W ! D ^%DT G:Y<1 EXIT^SCRPW42
 I Y<SD("BDT") W !!,$C(7),"End date cannot be before begin date!",! G EDT
 S SD("EDT")=Y_.999999 X ^DD("DD") S SD("PEDT")=Y,(SDOUT,SDNUL)=0
 D BLD^SCRPW21 S SDX="" D SUBT^SCRPW50("**** Output Sort Selection (optional) ****") S DIR("?")="Sort elements selected will determine the order of output.",(SD("PAGE"),SD("SORT"))=0
 F SDI=1:1:6 S T="~",DIR("A")=$S(SDX="":"Specify data element to sort by",1:"Within "_SDX_", sort by") D ASK Q:SDOUT!SDNUL
 G:SDOUT EXIT^SCRPW42 D SUBT^SCRPW50("**** Parameters Selected ****") W !!,"Veterans not seen since the date range: ",SD("PBDT")," to ",SD("PEDT"),!!,"Output sort elements: " D
 .I SD("SORT")=0 W "(NONE SELECTED)" Q
 .S SDI=0 F  S SDI=$O(SD("SORT",SDI)) Q:'SDI  S SDX=SD("SORT",SDI) W:SDI>1 ! W ?(19+(3*SDI)) S SDL=$S($P(SDX,U,3):(69-$X),1:(80-$X)) W $E($P(SDX,U,2),1,SDL)_$S($P(SDX,U,3):" <pagefeed>",1:"")
 .Q
 K DIR S DIR(0)="Y",DIR("A")="Ok",DIR("B")="YES",DIR("?")="Specify if the parameters are satisfactory as displayed." W ! D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT^SCRPW42 G:'Y EXIT^SCRPW42
 N ZTSAVE S ZTSAVE("SD(")="" W !!,"This report requires 132 column output.",!
 D EN^XUTMDEVQ("START^SCRPW41","Veterans Without Activity Since a Specified Date",.ZTSAVE) G EXIT^SCRPW42
 ;
ASK ;Ask for sort elements
 N SDZ I $L(SDX) D SUBT^SCRPW50("**** Select "_$S(SDI=2:"second",SDI=3:"third",SDI=4:"fourth",SDI=5:"fifth",SDI=6:"sixth",1:"another")_" sort element (optional) ****")
 K DIR(0) S S1=$$DIR^SCRPW23(.DIR,1,"","","O",2) Q:SDOUT!SDNUL
 K DIR(0) S DIR("A")="Select "_$P(S1,U,2)_" data element",S2=$$DIR^SCRPW23(.DIR,2,"",$P(S1,U),"O",2,1) Q:SDOUT  I SDNUL S SDNUL=0 G ASK
 S SDX=$P(S2,U,2),SD("SORT",SDI)=$P(S1,U)_$P(S2,U)_U_SDX_U_$$PF(),SD("SORT")=SD("SORT")+1 Q
 ;
PF() ;Prompt for page feed
 N DIR S DIR(0)="Y",DIR("A")="Perform a pagefeed for each new "_SDX_" value",DIR("B")="NO",DIR("?")="Specify if you want a pagefeed between each sort value for this element." W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q 0
 S:Y SD("PAGE")=SDI Q Y
 ;
START ;Print report
 K ^TMP("SCRPW",$J) D BLD^SCRPW21 S (SDOUT,SDSTOP,DFN)=0 D NOW^%DTC S SDNOW=%,T="~"
 S SDFEE=""
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S SDSTOP=SDSTOP+1 D:SDSTOP#3000=0 STOP Q:SDOUT  I $$VET() S SDX=$$EVAL(SD("BDT"),SD("EDT")) D:$P(SDX,U)=2 SET
 G:SDOUT EXIT^SCRPW42 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDLINE="",$P(SDLINE,"-",133)="",SDPAGE=1,(SDTOT,SDPG)=0 G ^SCRPW42
 ;
VET() ;Vet?  Alive?  Eligible?
 D DEM^VADPT Q:VADM(6) 0  ;deceased
 D ELIG^VADPT Q:'VAEL(4) 0  ;veteran
 Q VAEL(5)  ;eligible
 ;
EVAL(SDBD,SDED) ;Evaluate last activity
 ;Required input: SDBD=begin date of date range
 ;Required input: SDED=end date of date range
 ;Output: code^last activity date^location, where 'code'=
 ;        1=activity since date range
 ;        2=activity during date range, none since
 ;        3=no activity during or after date range
 N SDDT,SDX,SDXX,SDY
 S SDX=$O(^SCE("ADFN",DFN,9999999),-1) I SDX S SDY=$O(^SCE("ADFN",DFN,SDX,0)),SDY=$$GETOE^SDOE(SDY),SDY=$P($G(^SC(+$P(SDY,U,4),0)),U),SDDT(SDX)=SDY
 S SDX=$O(^DPT(DFN,"S",9999999),-1) I SDX S SDY=+$G(^DPT(DFN,"S",SDX,0)),SDY=$P($G(^SC(+SDY,0)),U),SDDT(SDX)=SDY
 S SDX=$O(^DPT(DFN,"DIS",0)) I SDX S SDDT(9999999-SDX)="REGISTRATION"
 S SDX=$O(^SDV("ADT",DFN,9999999),-1) I SDX S SDDT(SDX)="ADD/EDIT"
 ;S SDX=$O(^FBAAA(DFN,1,9999999),-1) I SDX S SDX=$P($G(^FBAAA(DFN,1,SDX,0)),U) I SDX S SDDT(SDX)="FEE BASIS"
 S SDXX=$$AUTHL^FBUTL(DFN,,SDBD,"SDX") D
 .I +SDXX=-1,$P(SDXX,"^",2)=110 S SDFEE="FEE BASIS SYSTEM NOT AVAILABLE"
 .I SDXX>0 S SDDT($G(SDX(SDXX,"FDT")))="FEE BASIS"
 S SDX=$O(^DGPM("APRD",DFN,9999999),-1) I SDX S SDY=$O(^DGPM("APRD",DFN,SDX,0)),SDY=$G(^DGPM(+SDY,0)) I $L(SDY) D
 .I $P(SDY,U,2)=1 S SDDT(SDX)=$P($G(^DIC(42,+$P(SDY,U,6),0)),U) Q
 .I $P(SDY,U,2)=3 N D0,X S D0=$O(^DGPM("APRD",DFN,SDX,0)) D WARD^DGPMUTL S SDDT(SDX)=X Q
 .D WARD(SDX) Q
 D WARD(SDNOW)
 S SDX=$O(SDDT(9999999),-1),SDX=$S('$L(SDX):U_U,1:U_SDX_U_SDDT(SDX))
 Q:$P(SDX,U,2)'<SDED 1_SDX  Q:$P(SDX,U,2)'<SDBD 2_SDX  Q 3_SDX
 ;
WARD(SDT) ;Get ward for date/time
 ;Required input: SDT=date/time
 N DGT,DG1,DGA1,DGXFR0 S DGT=SDT D ^DGPMSTAT I DG1 S SDDT(SDT)=$P($G(^DIC(42,DG1,0)),U)
 Q
 ;
SET ;Set TMP global
 S SD0=$G(^DPT(DFN,0)),SDSSN=$P(SD0,U,9),SDPNAM=$P(SD0,U) Q:'$L(SDPNAM)  S $P(SDX,U)=SDSSN
 N SDS I SD("SORT") S SDI="" F  S SDI=$O(SD("SORT",SDI)) Q:'SDI  S SDS(SDI)=$$SORT($P(SD("SORT",SDI),U))
 I 'SD("SORT") S ^TMP("SCRPW",$J,1,SDPNAM,DFN)=SDX Q
 I SD("SORT")=1 S ^TMP("SCRPW",$J,1,SDS(1),SDPNAM,DFN)=SDX Q
 I SD("SORT")=2 S ^TMP("SCRPW",$J,1,SDS(1),SDS(2),SDPNAM,DFN)=SDX Q
 I SD("SORT")=3 S ^TMP("SCRPW",$J,1,SDS(1),SDS(2),SDS(3),SDPNAM,DFN)=SDX Q
 S SDUI=$$DSV^SCRPW42(SDS(1),SDS(2),SDS(3),SDS(4))
 I SD("SORT")=4 S ^TMP("SCRPW",$J,1,SDS(1),SDS(2),SDS(3),SDS(4))="",^TMP("SCRPW",$J,2,SDUI,SDPNAM,DFN)=SDX Q
 I SD("SORT")=5 S ^TMP("SCRPW",$J,1,SDS(1),SDS(2),SDS(3),SDS(4))="",^TMP("SCRPW",$J,2,SDUI,SDS(5),SDPNAM,DFN)=SDX Q
 I SD("SORT")=6 S ^TMP("SCRPW",$J,1,SDS(1),SDS(2),SDS(3),SDS(4))="",^TMP("SCRPW",$J,2,SDUI,SDS(5),SDS(6),SDPNAM,DFN)=SDX
 Q
 ;
SORT(SDACR) ;Return sort value
 ;Required input: SDACR=data element acronym
 N SDACT,SDX,SDOE0
 S SDOE0=U_DFN_U,SDACT=^TMP("SCRPW",$J,"ACT",SDACR) X $P(SDACT,T,7)
 S SDX=$O(SDX("")) Q $P(SDX(SDX),U,2)
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
ASK1 ;Prompt for 'Means Test/Eligibility/Enrollment Report' parameters
 N SD,SDDIV,%DT,X,Y,DIR,SDOUT,SDNUL S (SDOUT,SDNUL,SD("SORT"))=0
 D TITL^SCRPW50("Means Test/Eligibility/Enrollment Report")
 G:'$$DIVA^SCRPW17(.SDDIV) EXIT1^SCRPW42
 D SUBT^SCRPW50("**** Date Range Selection ****")
 W ! S %DT="AEPX",%DT(0)=2961001,%DT("A")="Beginning date: " D ^%DT G:Y<1 EXIT1^SCRPW42 S SD("BDT")=Y X ^DD("DD") S $P(SD("BDT"),U,2)=Y
EDT1 S %DT("A")="   Ending date: " W ! D ^%DT G:Y<1 EXIT1^SCRPW42
 I Y<SD("BDT") W !!,$C(7),"End date cannot be before begin date!",! G EDT1
 S SD("EDT")=Y_.999999 X ^DD("DD") S $P(SD("EDT"),U,2)=Y
 D SUBT^SCRPW50("**** Report Format Selection ****")
 K DIR S DIR(0)="S^D:DETAILED;S:SUMMARY",DIR("A")="Select report format",DIR("?",1)="Specify the format of report you wish to print.  'Detailed' allows the printing",DIR("?")="of patient lists, 'summary' produces totals only."
 S DIR("B")="SUMMARY" D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT1^SCRPW42 S SD("FMT",1)=Y_U_Y(0)  G:Y="S" STAT
 D SUBT^SCRPW50("**** Detail Category Selection ****")
 K DIR S DIR(0)="S^MT:MEANS TEST INDICATOR;EE:ENCOUNTER ELIGIBILITY;EP:ENROLLMENT PRIORITY",DIR("A")="Select category for detail",DIR("?")="This determines how output will be sorted."
 D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT1^SCRPW42 S SD("FMT",2)=Y_U_Y(0) D SCAT^SCRPW43 G:'$D(SD("FMT",3))!SDOUT EXIT1^SCRPW42
 S SDNUL=0 D BLD^SCRPW21 S SDX="" D SUBT^SCRPW50("**** Output Sort Selection (optional) ****") S DIR("?")="Sort elements selected will determine the order of output.",(SD("PAGE"),SD("SORT"))=0
 F SDI=1:1:6 S T="~",DIR("A")=$S(SDX="":"Specify data element to sort by",1:"Within "_SDX_", sort by") D ASK^SCRPW41 Q:SDOUT!SDNUL
STAT ;Prompt for encounter statuses to include
 D SUBT^SCRPW50("**** Encounter Status Selection ****")
 K SD("STAT") W !!,"Choose as many of the following statuses",!,"as you wish to include in the report:",!
 W !?10,"CHECKED IN",!?10,"CHECKED OUT",!?10,"NO ACTION TAKEN",!?10,"INPATIENT APPOINTMENT",!?10,"NON-COUNT",!?10,"ACTION REQUIRED",! N DIC,I S DIC="^SD(409.63,",DIC(0)="AEMQ",DIC("B")="CHECKED OUT"
 S DIC("S")="I Y<4!(Y=8!(Y=12!(Y=14)))",DIC("A")="Select encounter status: " F I=1:1 D ^DIC Q:$D(DTOUT)!$D(DUOUT)  S:Y>0 SD("STAT",$P(Y,U))=$P(Y,U,2) K DIC("B") Q:X=""&(I>1)
 G:'$D(SD("STAT")) EXIT1^SCRPW42 D PDIS^SCRPW43 G:SDOUT EXIT1^SCRPW42
 N ZTSAVE S ZTSAVE("SD(")="",ZTSAVE("SDDIV(")="",ZTSAVE("SDDIV")=""
 W:$P(SD("FMT",1),U)="D" !!,"This report requires 132 column output." W ! D EN^XUTMDEVQ("START^SCRPW43","Means Test/Eligibility/Enrollment Report",.ZTSAVE),DISP0^SCRPW23 G EXIT1^SCRPW42
