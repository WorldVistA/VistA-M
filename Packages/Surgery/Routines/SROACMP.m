SROACMP ;BIR/ADM - M&M VERIFICATION REPORT ;12/19/07
 ;;3.0; Surgery ;**47,50,127,143,166**;24 Jun 93;Build 6
 S DFN=0 F  S DFN=$O(^TMP("SR",$J,DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,DFN,SRTN)) Q:'SRTN  D UTIL
 I SRFORM=1,SRSP D SS
 D HDR^SROACMP1 I $D(^TMP("SR",$J)) S SRPAT="" F  S SRPAT=$O(^TMP("SRPAT",$J,SRPAT)) Q:SRPAT=""  D  Q:SRSOUT  S SRNM=0 I $Y+7<IOSL W !! F LINE=1:1:132 W "-"
 .S SRX=^(SRPAT),SRNAME=">>> "_SRPAT_" ("_$P(SRX,"^",2)_")",SRDEATH=$P(SRX,"^",3)
 .I SRDEATH S SRNAME=SRNAME_" - DIED "_$E(SRDEATH,4,5)_"/"_$E(SRDEATH,6,7)_"/"_$E(SRDEATH,2,3) S X=$E(SRDEATH,9,12) I X S X=X_"000",SRNAME=SRNAME_"@"_$E(X,1,2)_":"_$E(X,3,4)
 .I $Y+9>IOSL D HDR^SROACMP1 I SRSOUT Q
 .W !,SRNAME S SRNM=1,DFN=$P(SRX,"^"),SRTN=0 F  S SRTN=$O(^TMP("SR",$J,DFN,SRTN)) Q:'SRTN!SRSOUT  D SET
 G:SRSOUT END^SROACMP1 I '$D(^TMP("SR",$J)) W !!,"There are no perioperative occurrences or deaths recorded for ",$S(SRFORM=1:"surgeries performed in the selected date range.",1:"completed assessments not yet transmitted.")
 D HDR2^SROACMP1,END^SROACMP1
 Q
UTIL ; list all cases within 30 days prior to postop occurrence and/or 90 days prior to death
 S SRPOST=0 F  S SRPOST=$O(^SRF(SRTN,16,SRPOST)) Q:'SRPOST  S SRDATE=$E($P(^SRF(SRTN,16,SRPOST,0),"^",7),1,7) I SRDATE S SRBACK=-30 D PRIOR
 D DEM^VADPT S ^TMP("SRPAT",$J,VADM(1))=DFN_"^"_VA("PID")_"^"_$P(VADM(6),"^")
 S SRDATE=$P(VADM(6),"^") I SRDATE S SRBACK=-90 D PRIOR
 Q
PRIOR ; list cases in 30 days before this occurrence or 90 days before death
 S X1=SRDATE,X2=SRBACK D C^%DTC S SDATE=X,SRCASE=0 F  S SRCASE=$O(^SRF("B",DFN,SRCASE)) Q:'SRCASE  I '$D(^TMP("SR",$J,DFN,SRCASE)) D
 .I $D(^XUSEC("SROCHIEF",+DUZ)) Q:'$$MANDIV^SROUTL0(SRINSTP,SRTN)
 .I '$D(^XUSEC("SROCHIEF",+DUZ)) Q:'$$DIV^SROUTL0(SRTN)
 .I '$P($G(^SRF(SRCASE,.2)),"^",12)!$P($G(^SRF(SRCASE,30)),"^")!($P($G(^SRF(SRCASE,"NON")),"^")="Y") Q
 .S SRX=$E($P(^SRF(SRCASE,0),"^",9),1,7) I SRX<SDATE!(SRX>SRDATE) Q
 .S ^TMP("SR",$J,DFN,SRCASE)=$P(^SRF(SRCASE,0),"^",4)
 Q
SET ; set variables to print
 N SRSEP,SRICDN
 S SR(0)=^SRF(SRTN,0),(SRD,Y)=$P(SR(0),"^",9),SRSDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3),Y=$P(SR(0),"^",4) I Y S SRSS=$P(^SRO(137.45,Y,0),"^")
OPS S SROPER=$P(^SRF(SRTN,"OP"),"^")
 K SRP,Z S:$L(SROPER)<121 SRP(1)=SROPER I $L(SROPER)>120 S SROPER=SROPER_"  " F M=1:1 D OPER Q:Z=""
 N SRL S SRL=109 D CPTS^SROAUTL0 I SRPROC(1)="" S SRPROC(1)="NOT ENTERED"
 S SRCHK=0 I SRDEATH S X1=SRDEATH,X2=-90 D C^%DTC I SRD<X S SRCHK=1,SRREL="N/A"
 I 'SRCHK S X=$P($G(^SRF(SRTN,.4)),"^",7),SRREL=$S(SRDEATH="":"N/A",X="U":"NO",X="R":"YES",1:"NOT ENTERED")
COMP ; perioperative occurrences
 K SRC S (SRFG,SRIC)=0 F  S SRIC=$O(^SRF(SRTN,10,SRIC)) Q:SRIC=""  S SRFG=SRFG+1,SRO=^SRF(SRTN,10,SRIC,0),SRICD=$P(SRO,"^",3) D
 .S Y=SRD D DATE S SRCAT=$P(SRO,"^",2) Q:'SRCAT  S SRC(SRFG)=$P(^SRO(136.5,SRCAT,0),"^")_" "_SRY
 .I SRICD S SRICDN=$$ICDDX^ICDCODE(SRICD,$P($G(^SRF(SRTN,0)),"^",9)),SRFG=SRFG+1,SRC(SRFG)="  ICD: "_$P(SRICDN,"^",2)_"  "_$P(SRICDN,"^",4)
 .S $P(SRC(SRFG),"^",2)="10;"_SRIC
 S SRPC=0 F  S SRPC=$O(^SRF(SRTN,16,SRPC)) Q:SRPC=""  S SRFG=SRFG+1,SRO=^SRF(SRTN,16,SRPC,0),SRICD=$P(SRO,"^",3) D
 .S Y=$E($P(SRO,"^",7),1,7) D DATE S SRCAT=$P(SRO,"^",2) Q:'SRCAT
 .S SRSEP="" I SRCAT=3 S X=$P(SRO,"^",4) I X S SRSEP="/"_$S(X=2:"SEPSIS",X=3:"SEPTIC SHOCK",1:"SIRS")_" "
 .S SRC(SRFG)=$P(^SRO(136.5,SRCAT,0),"^")_"  ** POSTOP ** "_SRSEP_SRY
 .I $P(SRO,"^",2)=3 S X=$P(SRO,"^",4) I X S SRSEP=$S(X=2:"SEPSIS",X=3:"SEPTIC SHOCK",1:"SIRS")
 .I SRICD S SRICDN=$$ICDDX^ICDCODE(SRICD,$P($G(^SRF(SRTN,0)),"^",9)),SRFG=SRFG+1,SRC(SRFG)="  ICD: "_$P(SRICDN,"^",2)_"  "_$P(SRICDN,"^",4)
 .S $P(SRC(SRFG),"^",2)="16;"_SRPC
RA ; risk assessment type and status
 S SRA=$G(^SRF(SRTN,"RA")),SRSTATUS=$P(SRA,"^"),SRTYPE=$P(SRA,"^",2),SRYN=$P(SRA,"^",6),SRE=$P(SRA,"^",7) D
 .I SRTYPE="" S SRTYPE="NON-ASSESSED" Q
 .S SRTYPE=$S(SRTYPE="C":"CARDIAC",SRYN="Y":"NON-CARDIAC",1:"EXCLUDED")
 S SRSTATUS=$S(SRSTATUS="C":"COMPLETE",SRSTATUS="T":"TRANSMITTED",SRSTATUS="I":"INCOMPLETE",1:"N/A")
PRINT ; print case information
 I $Y+8>IOSL D HDR^SROACMP1 I SRSOUT Q
 W !!,SRSDATE,?11,SRTN,?25,SRSS,?80,SRTYPE,?98,SRSTATUS,?116,SRREL
 W !,?11,SRP(1) W:$D(SRP(2)) !,?11,SRP(2)
 W !,?11,"CPT Codes: ",SRPROC(1) W:$D(SRPROC(2)) !,?24,SRPROC(2)
 W !,?11,"Occurrences: " I '$D(SRC(1)) S SRC(1)="NONE ENTERED"
 S SRI=0 F  S SRI=$O(SRC(SRI)) Q:'SRI  D
 .W:SRI>1 ! W ?24,$P(SRC(SRI),"^")
 .I $Y+6>IOSL D HDR^SROACMP1 W ! I SRSOUT Q
 .D TEXT D:SRT WP
 S SRNDTH=$P($G(^SRF(SRTN,205)),"^",3)
 I SRDEATH!SRNDTH D  K SRNDTH
 .I SRNDTH W !,?11,"Date of Death: "_$E(SRNDTH,4,5)_"/"_$E(SRNDTH,6,7)_"/"_$E(SRNDTH,2,3) S X=$E(SRNDTH,9,12) I X S X=X_"000" W "@"_$E(X,1,2)_":"_$E(X,3,4)
 .W !,?11,"Review of Death Comments: " D
 ..I '$O(^SRF(SRTN,47,0)) W "NONE ENTERED" Q
 ..D DWP
 Q
OPER ; break procedure if greater than 48 characters
 S SRP(M)="" F LOOP=1:1 S Z=$P(SROPER," ") Q:Z=""  Q:$L(SRP(M))+$L(Z)'<49  S SRP(M)=SRP(M)_Z_" ",SROPER=$P(SROPER," ",2,200)
 Q
DATE S SRY=$S(Y:" ("_$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_")",1:" (NO DATE)")
 Q
SS ; set up ^TMP for selected specialties
 K ^TMP("SRSP",$J) S SRQ=0,SRNAME="" F  S SRNAME=$O(^TMP("SRPAT",$J,SRNAME)) Q:SRNAME=""  S DFN=$P(^TMP("SRPAT",$J,SRNAME),"^"),(SRQ,SRTN)=0 D
 .F  S SRTN=$O(^TMP("SR",$J,DFN,SRTN)) Q:'SRTN  D  Q:SRQ
 ..S Y=$P(^SRF(SRTN,0),"^",4) S:'Y Y="ZZ" I $D(SRSP(Y)) S ^TMP("SRSP",$J,DFN)="",SRQ=1 Q
 S SRNAME="" F  S SRNAME=$O(^TMP("SRPAT",$J,SRNAME)) Q:SRNAME=""  S DFN=$P(^TMP("SRPAT",$J,SRNAME),"^") I '$D(^TMP("SRSP",$J,DFN)) K ^TMP("SR",$J,DFN),^TMP("SRPAT",$J,SRNAME)
 Q
WP ; print occurrence comments
 N CM K ^UTILITY($J,"W") S CM=0 F  S CM=$O(^SRF(SRTN,SRY,SRZ,1,CM)) Q:'CM  S X=^SRF(SRTN,SRY,SRZ,1,CM,0),DIWL=30,DIWR=132 D ^DIWP
 I $D(^UTILITY($J,"W")) F J=1:1:^UTILITY($J,"W",30) D
 .I $Y+7>IOSL D HDR^SROACMP1 W ! I SRSOUT Q
 .W !,?30,^UTILITY($J,"W",30,J,0)
 Q
TEXT ; check for occurrence comments
 S SRT=0,SRX=$P(SRC(SRI),"^",2) I SRX'="" S SRY=$P(SRX,";"),SRZ=$P(SRX,";",2) I $O(^SRF(SRTN,SRY,SRZ,1,0)) S SRT=1 W !,?26,">>> Comments:"
 Q
DWP ; print review of death comments
 N CM K ^UTILITY($J,"W") S CM=0 F  S CM=$O(^SRF(SRTN,47,CM)) Q:'CM  S X=^SRF(SRTN,47,CM,0),DIWL=38,DIWR=132 D ^DIWP
 I $D(^UTILITY($J,"W")) F J=1:1:^UTILITY($J,"W",38) D
 .I $Y+7>IOSL D HDR^SROACMP1 W ! I SRSOUT Q
 .W ?38,^UTILITY($J,"W",38,J,0),!
 Q
