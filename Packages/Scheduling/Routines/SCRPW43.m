SCRPW43 ;RENO/KEITH - Means Test/Eligibility/Enrollment Report ; 24 Aug 99  9:25 PM
 ;;5.3;Scheduling;**144,176,199,258,243**;AUG 13, 1993
 D ASK1^SCRPW41 Q
 ;
START ;Print report
 D BLD^SCRPW21 S T="~"
 S SDMD="",SDMD=$O(SDDIV(SDMD)),SDMD=$O(SDDIV(SDMD)),(SDSTOP,SDOUT)=0,SDT=$P(SD("BDT"),U) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDMD=1
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!SDOUT!(SDT>SD("EDT"))  S SDOE=0 F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE!SDOUT  D
 .S SDOE0=$$GETOE^SDOE(SDOE) I $P(SDOE0,U,2),'$P(SDOE0,U,6),$P(SDOE0,U,11),$$DIV($P(SDOE0,U,11)),$D(SD("STAT",+$P(SDOE0,U,12))) D GET
 G:SDOUT EXIT G ^SCRPW44
 ;
EXIT G EXIT1^SCRPW42
 ;
SCAT ;Select format subcategory
 K DIR S (SDNUL,SDOUT)=0 I $P(SD("FMT",2),U)="MT" D
 .S DIR(0)="SOA^AS:SC MT COPAY EXEMPT;AN:NSC MT COPAY EXEMPT;C:MT COPAY REQUIRED;G:GMT COPAY REQUIRED;NO:NON-VETERAN;XO:NOT APPLICABLE;UO:UNKNOWN/REQUIRED"
 .S DIR("A")="Select Means Test indicator: ALL// ",DIR("?")="Specify which Means Test indicator(s) you wish to include on the report."
 .Q
 I $P(SD("FMT",2),U)="EE" D
 .S DIR(0)="POA^8:AEMQZ",DIR("A")="Select encounter eligibility: ALL// "
 .S DIR("?")="Specify which encounter eligibilities you wish to include in the report."
 .Q
 I $P(SD("FMT",2),U)="EP" D
 .S DIR(0)="SOA^1:Group 1;2:Group 2;3:Group 3;4:Group 4;5:Group 5;6:Group 6;7:Group 7;8:Group 8;0:No enrollment"
 .S DIR("A")="Select patient enrollment priority: ALL// "
 .S DIR("?")="Specify which patient enrollment priorities you wish to include in the report."
 .Q
 F  D SCAT1 Q:SDNUL!SDOUT  S DIR("A")=$P(DIR("A"),"ALL")
 Q:SDOUT  I SDNUL,'$D(SD("FMT",3)) S SD("FMT",3,"ALL")="ALL"
 Q
 ;
SCAT1 D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 I X="" S SDNUL=1 Q
 I $D(SD("FMT",3,"X",$P(Y,U))) D SDEL Q
 S SD("FMT",3,$P(Y,U))=$P(Y(0),U) Q
 ;
SDEL ;Delete sub-category
 N DIR S DIR(0)="Y",DIR("A")="This item has already been selected, do you want to delete it" D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 Q:'Y  K SD("FMT",3,$P(Y,U)) Q
 ;
PDIS ;Parameter display
 D SUBT^SCRPW50("**** Report Parameters Selected ****") W ! D PD1(0) W !
 K DIR S DIR(0)="Y",DIR("A")="Ok",DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 S SDOUT=Y'=1 Q
 ;
PD1(SDI) ;Print parameters
 ;Required input: SDI=0 for all division selections or division ifn
 N SDLF,C S C=(IOM-80\2),SDLF=0 I SDI D PDP("Report for",SDDIV(SDI),1) Q:SDOUT
 I 'SDI D PDP("Report for",SDDIV,2) Q:SDOUT  D
 .F  S SDI=$O(SDDIV(SDI)) Q:'SDI!SDOUT  D PDP("Division",SDDIV(SDI),1)
 Q:SDOUT  D PDP("Beginning date",SD("BDT"),2,0,1) Q:SDOUT  D PDP("Ending date",SD("EDT"),2) Q:SDOUT
 D PDP("Report format",SD("FMT",1),2,0,1) Q:SDOUT  I $P(SD("FMT",1),U)="D" D
 .D PDP("Detail category",SD("FMT",2),2,0,1) Q:SDOUT  S SDI="",(SDII,SDL1)=0
 .F  S SDI=$O(SD("FMT",3,SDI)) Q:SDI=""!SDOUT  D PDP($$LC($P(SD("FMT",2),U,2)),SD("FMT",3,SDI),1,SDII,'SDL1) S (SDL1,SDII)=1
 .Q
 Q:SDOUT  S (SDI,SDII,SDL1)=0 F  S SDI=$O(SD("STAT",SDI)) Q:'SDI!SDOUT  D PDP("Encounter status",SD("STAT",SDI),1,SDII,'SDL1) S (SDL1,SDII)=1
 Q:$P(SD("FMT",1),U)="S"  S SDX="Output sort elements"
 I SD("SORT")=0 D PDP(SDX,"(NONE SELECTED)",1,0,1) Q
 I $E(IOST)="C",SDLF+SD("SORT")>18 D WAIT Q:SDOUT
 I $Y>(IOSL-3-SD("SORT")),$E(IOST)="P" D HDR^SCRPW44 Q:SDOUT
 W:$E(IOST)="C" !!?(C),SDX,":" W:$E(IOST)="P" !!,$J(SDX,(IOM-6\2)),":"
 S SDI=0 F  S SDI=$O(SD("SORT",SDI)) Q:'SDI  S SDX=SD("SORT",SDI) W:SDI>1 ! W ?($S($E(IOST)="P":(IOM\2-1),1:C+19+(3*SDI))) S SDL=$S($P(SDX,U,3):(IOM-11-$X),1:(IOM-$X)) W $E($P(SDX,U,2),1,SDL)_$S($P(SDX,U,3):" <pagefeed>",1:"")
 Q
 ;
PDP(SDT,SDX,SDP,SDL,SDL1) ;Print parameter display line
 ;Required input: SDT=parameter title
 ;Required input: SDX=parameter value
 ;Required input: SDP=$P of SDX to print
 ;Optional input: SDL=1 to suppress title and do line feed
 ;Optional input: SDL1=1 to do additional line feed
 S SDLF=SDLF+1 I $E(IOST)="C",SDLF#18=0 D WAIT Q:SDOUT
 I $Y>(IOSL-3),$E(IOST)="P" D HDR^SCRPW44 Q:SDOUT
 I $G(SDL1) W ! S SDLF=SDLF+1
 W ! W:'$G(SDL) $J(SDT,(IOM-6\2)),":" W ?(IOM\2-1),$P(SDX,U,SDP) Q
 ;
WAIT ;Do CRT pause
 N DIR W ! S DIR(0)="E" D ^DIR S SDOUT=Y'=1 W ! Q
 ;
LC(X) ;Lowercase value
 N SDI F SDI=2:1:$L(X) I $E(X,SDI)?1U,$E(X,SDI-1)?1A S X=$E(X,0,SDI-1)_$C($A(X,SDI)+32)_$E(X,SDI+1,999)
 Q X
 ;
DIV(SDIV) ;Evaluate division
 Q:'SDDIV 1  Q $D(SDDIV(SDIV))
 ;
GET ;Gather report information
 N SDINC
 S DFN=$P(SDOE0,U,2),SDIV=$P(SDOE0,U,11),SDSTOP=SDSTOP+1 D:SDSTOP#2000=0 STOP Q:SDOUT
 S SDMT=$$MTI^SCDXUTL0(DFN,$P(SDOE0,U),$P(SDOE0,U,13),$P(SDOE0,U,10),SDOE)
 S:"NXU"[SDMT SDMT=SDMT_"O" S SDEL=$P(SDOE0,U,13) S:'$L(SDEL) SDEL="NONE"
 S SDEP=+$P($$ENROL^SCRPW24(DT),U,7),SDINC=$$INCL()
 S SDMT=$S(SDMT="AN":"NSC MT Copay exempt (AN)",SDMT="AS":"SC MT Copay exempt (AS)",SDMT="C":"MT Copay req'd (C)",SDMT="G":"GMT Copay req'd (G)",SDMT="NO":"Non-veteran (NO)",SDMT="XO":"Not applicable (XO)",SDMT="UO":"Unknown/Req'd (UO)",1:"NN")
 I SDMT="NN" S SDMT="~~~NONE~~~"
 S SDEL=$P($G(^DIC(8,+SDEL,0)),U) S:'$L(SDEL) SDEL="~~~NONE~~~"
 S SDEP=$S(SDEP=0:"No enrollment",1:"Group "_SDEP)
 D SET0(SDIV) D:SDMD SET0(0) Q:$P(SD("FMT",1),U)="S"
 S SDX=$P(SD("FMT",2),U),SDX=$S(SDX="MT":SDMT,SDX="EE":SDEL,1:SDEP),SDY=SDMT_U_SDEL_U_SDEP
 I SDINC,$P(SD("FMT",1),U)="D" D SET1($P(SDOE0,U,11)) D:SDMD SET1(0)
 Q
 ;
SET0(SDIV) ;Set TMP global for summary
 S ^TMP("SCRPW",$J,0,SDIV,"MT",SDMT,"ENC")=$G(^TMP("SCRPW",$J,0,SDIV,"MT",SDMT,"ENC"))+1
 S ^TMP("SCRPW",$J,0,SDIV,"MTP",SDMT,DFN,$P($P(SDOE0,U),"."))=""
 S ^TMP("SCRPW",$J,0,SDIV,"EE",SDEL,"ENC")=$G(^TMP("SCRPW",$J,0,SDIV,"EE",SDEL,"ENC"))+1
 S ^TMP("SCRPW",$J,0,SDIV,"EEP",SDEL,DFN,$P($P(SDOE0,U),"."))=""
 S ^TMP("SCRPW",$J,0,SDIV,"EP",SDEP,"ENC")=$G(^TMP("SCRPW",$J,0,SDIV,"EP",SDEP,"ENC"))+1
 S ^TMP("SCRPW",$J,0,SDIV,"EPP",SDEP,DFN,$P($P(SDOE0,U),"."))=""
 S ^TMP("SCRPW",$J,0,SDIV,"RPT","ENC")=$G(^TMP("SCRPW",$J,0,SDIV,"RPT","ENC"))+1
 S ^TMP("SCRPW",$J,0,SDIV,"RPT",DFN,$P($P(SDOE0,U),"."))=""
 Q
 ;
SET1(SDIV) ;Set TMP global for detail
 S SD0=$G(^DPT(DFN,0)),SDSSN=$P(SD0,U,9),SDPNAM=$P(SD0,U) Q:'$L(SDPNAM)
 N SDS I SD("SORT") S SDI="" F  S SDI=$O(SD("SORT",SDI)) Q:'SDI  S SDS(SDI)=$$SORT($P(SD("SORT",SDI),U))
 I 'SD("SORT") S ^TMP("SCRPW",$J,1,SDIV,SDX,SDPNAM,DFN)=SDSSN_U_SDY Q
 I SD("SORT")=1 S ^TMP("SCRPW",$J,1,SDIV,SDX,SDS(1),SDPNAM,DFN)=SDSSN_U_SDY Q
 I SD("SORT")=2 S ^TMP("SCRPW",$J,1,SDIV,SDX,SDS(1),SDS(2),SDPNAM,DFN)=SDSSN_U_SDY Q
 I SD("SORT")=3 S ^TMP("SCRPW",$J,1,SDIV,SDX,SDS(1),SDS(2),SDS(3),SDPNAM,DFN)=SDSSN_U_SDY Q
 S SDUI=$$DSV(SDIV,SDX,SDS(1),SDS(2),SDS(3),SDS(4))
 I SD("SORT")=4 S ^TMP("SCRPW",$J,1,SDIV,SDX,SDS(1),SDS(2),SDS(3),SDS(4))=SDUI,^TMP("SCRPW",$J,2,SDUI,SDPNAM,DFN)=SDSSN_U_SDY Q
 I SD("SORT")=5 S ^TMP("SCRPW",$J,1,SDIV,SDX,SDS(1),SDS(2),SDS(3),SDS(4))=SDUI,^TMP("SCRPW",$J,2,SDUI,SDS(5),SDPNAM,DFN)=SDSSN_U_SDY Q
 I SD("SORT")=6 S ^TMP("SCRPW",$J,1,SDIV,SDX,SDS(1),SDS(2),SDS(3),SDS(4))=SDUI,^TMP("SCRPW",$J,2,SDUI,SDS(5),SDS(6),SDPNAM,DFN)=SDSSN_U_SDY
 Q
 ;
DSV(SDIV,S0,S1,S2,S3,S4) ;Produce detail sort value
 ;Required input: SDIV=division
 ;Required input: S0, S1, S2, S3, S4=subscript values
 N SDX S SDX=$G(^TMP("SCRPW",$J,3,SDIV,S0,S1,S2,S3,S4)) Q:SDX SDX
 S (SDX,^TMP("SCRPW",$J,3,SDIV,0))=$G(^TMP("SCRPW",$J,3,SDIV,0))+1
 S ^TMP("SCRPW",$J,3,SDIV,S0,S1,S2,S3,S4)=SDX Q SDX
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
INCL() ;Determine if encounter should be included in detailed report
 ;Output: 1=yes, 0=no
 Q:$P(SD("FMT",1),U)="S" 1
 N SDFMT S SDFMT=$P(SD("FMT",2),U)
 Q:$D(SD("FMT",3,"ALL")) 1
 I SDFMT="MT",$D(SD("FMT",3,SDMT)) Q 1
 I SDFMT="EE",$D(SD("FMT",3,SDEL)) Q 1
 I SDFMT="EP",$D(SD("FMT",3,SDEP)) Q 1
 Q 0
