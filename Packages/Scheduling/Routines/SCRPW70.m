SCRPW70 ;BP-CIOFO/KEITH,ESW - Clinic appointment availability extract ; 7/8/03 2:23pm
 ;;5.3;Scheduling;**192,206,223,241,249,291**;AUG 13, 1993
 N SDEX,SDDIV,DIR,SDFMT,SDFMTS,SDMAX,SDSORT,SDOUT,X,Y,DTOUT,DUOUT
 N SDREPORT,SDEDT,SDBDT,SDPEDT,SDPBDT,SDPAT,SDPT,SDJN
 S SDJN=$J
 S (SDEX,SDOUT)=0
 D TITL^SCRPW50("Clinic Appointment Availability Report")
 I '$$DIVA^SCRPW17(.SDDIV) S SDOUT=1 G EXIT^SCRPW74
 D SUBT^SCRPW50("**** Date Range Selection ****")
 W ! S %DT="AEX",%DT("A")="Beginning date: " D ^%DT I Y<1 S SDOUT=1 G EXIT^SCRPW74
 S SDBDT=Y X ^DD("DD") S SDPBDT=Y
EDT S %DT("A")="   Ending date: " W ! D ^%DT I Y<1 S SDOUT=1 G EXIT^SCRPW74
 I Y<SDBDT W !!,$C(7),"End date cannot be before begin date!",! G EDT
 S SDEDT=Y_.999999 X ^DD("DD") S SDPEDT=Y
 S SDMAX=Y D SUBT^SCRPW50("**** Report Format Selection ***")
 S DIR(0)="S^S:SUMMARY FOR DATE RANGE;D:DETAIL BY DAY",DIR("A")="Select report format"
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT^SCRPW74
 S SDFMT=Y G:SDFMT="S" REN
 ;clarification that you may skip entry for a patient
 W !!?3,"To generate a detailed report by stop code pair or clinic,"
 W !?3,"press 'enter' without inputting a patient name.",!
 S SDPAT=0
 K ^TMP("SDPAT",SDJN)
 D SELECT^SCRPW78(SDJN,.SDPAT) ;select patient(s)
 S DIR("B")="CLINIC NAME"
 S DIR(0)="S^CL:CLINIC NAME;CP:CREDIT PAIR",DIR("A")="Specify limiting category for detail"
 I $G(SDPAT) S DIR("B")="CLINIC ALL",DIR(0)="S^CA:CLINIC ALL;CL:CLINIC NAME;CP:CREDIT PAIR"
 S DIR("?")="Indicate if availability should be limited by clinic name or DSS credit pair."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT^SCRPW74
 S SDSORT=Y I '$$SORT^SCRPW72(.SDSORT) S SDOUT=1 G EXIT^SCRPW74
 G:SDOUT EXIT^SCRPW74
 I SDBDT>DT S SDREPORT(1)=1 G QUE
 G RENS
REN I SDBDT>DT S SDREPORT(1)=1 G QUE
 S DIR(0)="S^CL:ALL CLINICS;CP:CREDIT PAIR SELECTION",DIR("A")="Specify if all clinics or selected clinics by credit pair"
 S DIR("?")="Indicate if availability should include All clinics or clinics selected by DSS credit pair only."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT^SCRPW74
 S SDFMTS=Y I SDFMTS="CP" D  G:SDOUT EXIT^SCRPW74
 .S SDSORT=Y I '$$SORT^SCRPW72(.SDSORT) S SDOUT=1
 G:SDOUT EXIT^SCRPW74
RENS D SUBT^SCRPW50("**** Report Output Section Selection ****")
ROSS S DIR(0)="Y",DIR("B")="YES"
 N II F II=1:1:5 S SDREPORT(II)=0
 I '$G(SDPAT) D
 .S DIR("A")="Include 'next available' appointment statistics"
 .W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 D EXIT^SCRPW74 Q
 .S SDREPORT(1)=Y
 .S DIR("A")="Include 'follow up' appointment statistics"
 .W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 D EXIT^SCRPW74 Q
 .S SDREPORT(2)=Y
 .S DIR("A")="Include 'non-follow up' appointment statistics"
 .W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 D EXIT^SCRPW74 Q
 .S SDREPORT(3)=Y
 .I SDFMT="D" D
 ..S DIR("A")="Include list of patient appointments"
 ..W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 D EXIT^SCRPW74 Q
 ..S SDREPORT(4)=Y
 I $G(SDPAT) D
 .S DIR("?")="Accept to print report for selected patient(s) or exit"
 .S DIR("A")="Print individual patient report" D
 .W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 D EXIT^SCRPW74 Q
 .S SDREPORT(5)=Y
 I '$D(SDREPORT) S SDOUT=1 D EXIT^SCRPW74 Q
 I 'SDREPORT(1),'SDREPORT(2),'SDREPORT(3),'SDREPORT(4),'SDREPORT(5) D  G ROSS
 .W $C(7),!!,"No output elements selected--at least one must be selected to continue..."
QUE I SDBDT'>DT W !!,"This report requires 132 column output!"
 N ZTSAVE F X="SDREPORT(","SDEX","SDBDT","SDPBDT","SDEDT","SDPEDT","SDDIV","SDDIV(","SDFMT","SDFMTS","SDSORT","SDSORT(","SDPAT","SDJN","^TMP(""SDPAT""," S ZTSAVE(X)=""
 W ! D EN^XUTMDEVQ("START^SCRPW72","Clinic Appointment Availability Report",.ZTSAVE) S SDOUT=1 G EXIT^SCRPW74
 ;
RESEND ;Entry point for manually initiating extracts for the current month
 N DIR,SDXTMP,SDMON,SDI,SDT,DTOUT,DUOUT
 W !!,$C(7),"NOTE:  Use of this utility will result in the transmission of extract data to"
 W !,"Austin.  It should only be used if automatically queued extracts failed to run."
 M SDXTMP=^XTMP("SD53P192") D QDIS^SCRPW74(.SDXTMP)
 F SDI=1,2 I $G(SDXTMP("EXTRACT",SDI,"DATE"))<DT D  Q:$D(DTOUT)!$D(DUOUT)
 .W !!,"Extract ",SDI," doesn't appear to be tasked to run repetitively in the future."
 .S DIR(0)="Y",DIR("A")="Do you wish to schedule it now",DIR("B")="YES"
 .W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  D:Y RQUE(SDI)
 Q:$D(DTOUT)!$D(DUOUT)
 S DIR(0)="Y",DIR("B")="NO"
 F SDI=1,2 D  Q:$D(DTOUT)!$D(DUOUT)
 .S SDT=DT S:SDI=1 SDT=$S($E(SDT,4,5)="01":$E(SDT,1,3)-1_12_$E(SDT,6,7),1:$E(SDT,1,5)-1_$E(SDT,6,7))
 .S DIR("A")="Do you want transmit Extract "_SDI_" for "_$P($$MON^SCRPW74(SDI,SDT,.SDMON),U)_" to Austin"
 .W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  D:Y QUEUE(.SDMON)
 Q
REQUE ;Entry point for initiating repetitive tasking of extracts
 N DIR,SDXTMP,DTOUT,DUOUT
 M SDXTMP=^XTMP("SD53P192") D QDIS^SCRPW74(.SDXTMP)
 I '$D(SDXTMP) D  W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  I Y D RQUE("B") Q
 .S DIR(0)="Y",DIR("A")="Do you want to schedule both extracts now"
 .S DIR("B")="YES"
 Q:$D(DTOUT)!$D(DUOUT)  K DIR
 S DIR(0)="S^1:EXTRACT 1 (PROSPECTIVE);2:EXTRACT 2 (RETROSPECTIVE);B:BOTH EXTRACTS"
 S DIR("?",1)="Extract 1 returns future clinic availability, extract 2 returns previous",DIR("?")="clinic availability and utilization."
 S DIR("A")="Specify which extract you wish to schedule"
 W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  D RQUE(Y)
 Q
RQUE(SDEX) ;Schedule extract for repetitive run
 ;Input: SDEX=extract type, '1', '2' or 'B' for both
 I SDEX="B" D RQUE(1) Q:$D(DTOUT)!$D(DUOUT)  D RQUE(2) Q
 N SDMON,SDNOW,SDOUT,DIR,Y,SDT
 S SDNOW=$$NOW^XLFDT(),SDOUT=0,Y=$G(SDXTMP("EXTRACT",SDEX,"DATE"))
 I Y>SDNOW D  Q:$D(DTOUT)!$D(DUOUT)  Q:SDOUT
 .W !!,"Extract ",SDEX," appears to be queued for the future--"
 .X ^DD("DD") W !!,"Scheduled for: ",Y,", task number: ",$G(SDXTMP("EXTRACT",SDEX,"TASK"))
 .S DIR(0)="Y",DIR("B")="NO"
 .S DIR("A")="Do you want to delete this task and re-schedule extract "_SDEX
 .W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S SDOUT='Y
 .Q:'Y  S ZTSK=$G(SDXTMP("EXTRACT",SDEX,"TASK")) D KILL^%ZTLOAD
 .K ^XTMP("SD53P192","EXTRACT",SDEX) Q
 S SDT=$$WHEN^SCRPW74(SDEX),SDRPT=$$MON^SCRPW74(SDEX,SDT,.SDMON)
 D SCHED^SCRPW74(SDEX,SDT,SDRPT,.SDMON) Q
QUEUE(SDMON) ;Queue extraction for re-run
 ;Input: SDMON=array of input parameters (as described in MON^SCRPW74)
 N %DT,SDI,Y,ZTSK,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 S Y=DT_.22 X ^DD("DD") S %DT("B")=Y,%DT("A")="Queue to run: "
 S %DT="AEFXR" W ! D ^%DT I Y<1 G QQ
 S ZTDTH=Y,ZTSAVE("SDMON(")="",ZTRTN="RUN^SCRPW74(0)",ZTIO=""
 S ZTDESC="Clinic Appointment Wait Time Extract ("_SDMON("SDEX")_")"
 F SDI=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
QQ I '$G(ZTSK) W !!,"Extract not queued!!!",! Q
 W !!,"Task number: ",ZTSK,! Q
TXXM ;Transmit extract data
 N SDFAC,SDL,SDIV,SDCP,SC,SDI,SDX,SDEX,SDY,SDZ,SDP,SDSIZE,SDMG,SDMGM
 S SDFAC=$P($$SITE^VASITE(),U,3),SDXM=1,SDL=0,SDIV="",SDSIZE=0
 S SDEX=$S(SDPAST:2,1:1)
 S SDMG=$P($G(^SD(404.91,1,"PATCH192")),U,(6+SDEX))
 S:SDMG="" SDMG="G.SC CLINIC WAIT TIME"
 ;Set up monitoring mail group
 S SDMGM="SC CWT EXTRACT MONITOR"
 S:'$$GOTLOCAL^XMXAPIG(SDMGM) SDMGM=""
 F  S SDIV=$O(^TMP("SD",$J,SDIV)) Q:SDIV=""  S SDCP=0 D
 .F  S SDCP=$O(^TMP("SD",$J,SDIV,SDCP)) Q:'SDCP  S SC=0 D
 ..F  S SC=$O(^TMP("SD",$J,SDIV,SDCP,SC)) Q:'SC  D
 ...I SDSIZE>29000 D EXXM(SDMG,SDMGM)  ;Transmit message if >29K
 ...;Build record leader string
 ...;Reporting facility, extract date, extract type
 ...S SDX="#"_SDFAC_U_SDEXDT_U_SDEX
 ...;Format version--NOTE: THIS NUMBER MUST INCREMENTED IF THE EXTRACT
 ...;FORMAT IS MODIFIED (e.g. existing number + 1).  Refer to patch
 ...;SD*5.3*249 documentation for additional information.
 ...S SDX=SDX_"~5"
 ...;Report begin date, division, credit pair
 ...S SDX=SDX_U_SDBDT_U_$P(SDIV,U,2)_U_SDCP_U
 ...;Clinic ifn and name
 ...S SDX=SDX_SC_"~"_$$CNAME^SCRPW72(SC)_"~"
 ...;Maximum days for future booking
 ...S SDX=SDX_+$P($G(^SC(SC,"SDP")),U,2)_U
 ...;Build clinic statistics string
 ...S SDI="" F  S SDI=$O(^TMP("SD",$J,SDIV,SDCP,SC,SDI)) Q:SDI=""  D
 ....S SDY=^TMP("SD",$J,SDIV,SDCP,SC,SDI) Q:'$L(SDY)
 ....F SDP=1:1 S SDZ=$P(SDY,U,SDP) Q:SDZ=""  D
 .....I $L(SDX)>220 D XMTX(SDX) S SDX=""
 .....S SDX=SDX_$S($E(SDX,$L(SDX))=U:"",1:"|")_SDZ
 ...I SDEX=1 S SDX=SDX_"$" D XMTX(SDX) Q
 ...S SDY=$G(^TMP("SDNAVA",$J,SDIV,SDCP,SC))  ;get next ava. info.
 ...S SDZ=$G(^TMP("SDNAVB",$J,SDIV,SDCP,SC))  ;get additional data
 ...S SDY=$$NAVA(SDY) D  S SDX=SDX_SDY,SDY=$$ADDL^SCRPW72(SDZ) D
 ....I $L(SDX)+$L(SDY)>240 D
 .....S SDI=$L(SDX),SDX=SDX_$E(SDY,1,(240-SDI)),SDY=$E(SDY,(241-SDI),999)
 .....D XMTX(SDX) S SDX=""
 ...S SDX=SDX_SDY_"$" D XMTX(SDX)
 D:$D(^TMP("SDXM",$J)) EXXM(SDMG,SDMGM)
 Q
EXXM(XMG,SDMGM) ;Send extract mail message
 ;Input: XMG=mail group to receive message
 ;Input: SDMGM=extract monitoring mail group (optional)
 N XMSUB,XMDUZ,XMDUN,XMTEXT,XMY,XMZ
 S XMSUB="Clinic Appointment Waiting Time Extract ("_SDEX_")"
 S (XMDUZ,XMDUN)="Patch SD*5.3*192/Task "_$G(ZTSK)
 S XMTEXT="^TMP(""SDXM"",$J,"
 S XMY(XMG)="" S:$L($G(SDMGM)) XMY("G."_SDMGM)=""
 D ^XMD
 K ^TMP("SDXM",$J) S SDXM=1,SDSIZE=0
 Q
XMTX(SDX) ;Set mail message line
 ;Input: SDX=text value
 S ^TMP("SDXM",$J,SDXM)=SDX,SDXM=SDXM+1,SDSIZE=SDSIZE+$L(SDX)
 Q
NAVA(SDY) ;Format next available appointment information
 ;Input: SDY=next ava. numbers from ^TMP("SDNAVA",$J,SDCP,SC)
 N SDI,SDX
 ;Format 'next available' data
 S SDX="^" F SDI=0:1:3 D
 .S:SDI SDX=SDX_"|"
 .S SDX=SDX_SDI_"~"_+$P(SDY,U,(SDI+SDI+1))_"~"_+$P(SDY,U,(SDI+SDI+2))
 ;Format 'follow up'/'non-follow up' appointment data
 S SDX=SDX_U F SDI=9:2:19 D
 .S:SDI>9 SDX=SDX_"|"
 .S SDX=SDX_+$P(SDY,U,SDI)_"~"_+$P(SDY,U,(SDI+1))
 S SDX=SDX_U_+$P(SDY,U,21)_"~"_+$P(SDY,U,22)
 F SDI=23:3:35 D
 .S SDX=SDX_"|"_+$P(SDY,U,SDI)_"~"_+$P(SDY,U,(SDI+1))
 .S SDX=SDX_"~"_+$P(SDY,U,(SDI+2))
 ;Format 'appts. w/in 30 days' data
 S SDX=SDX_U_+$P(SDY,U,38)_"~"_+$P(SDY,U,39)
 Q SDX
