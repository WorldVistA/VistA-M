SCRPW72 ;BP-CIOFO/KEITH,ESW - Clinic appointment availability extract (cont.) ; 5/23/03 12:16pm
 ;;5.3;Scheduling;**192,206,223,241,249,291**;AUG 13, 1993
 ;
START ;Gather data for printed report
 N SDCP,SC,SCNA,SDI,SDOUT,SDPAST,SDXM,MAX,X1,X2,X,SDIOM,SDFOOT
 I $E(IOST)="C" D WAIT^DICD
 S (SDOUT,SDI)=0,SDIOM=$G(IOM,80)
 S SDPAST=SDBDT'>DT S:SDPAST SDIOM=130
 D HINI^SCRPW76,FOOT^SCRPW77(.SDFOOT)
 K ^TMP("SD",$J),^TMP("SDS",$J),^TMP("SDTMP",$J),^TMP("SDTOT",$J)
 I $G(SDREPORT(4)) K ^TMP("SDPLIST",$J)
 I $G(SDREPORT(5)) D
 .N CC F CC="SDIPLST","SDIP","SDORD" K ^TMP(CC,$J)
 D INIT^SCRPW71 S SDCOL=$S(SDPAST:0,1:(SDIOM-58\2))
 S X1=SDEDT,X2=SDBDT D ^%DTC S MAX=X+1
 I SDPAST I '$G(SDREPORT(5)) D OE(SDBDT,SDEDT,MAX,0) Q:SDOUT  ;get outpt. enc. workload
 G:SDOUT EXIT^SCRPW74
 I $G(SDFMT)="D"!($G(SDFMTS)="CP") D
 .I $G(SDREPORT(5)) D CA(.SDSORT) Q
 .D @SDSORT
 I $G(SDFMT)="S"&($G(SDFMTS)'="CP") S SC=0 F  S SC=$O(^SC(SC)) Q:'SC!SDOUT  D
 .S SDI=SDI+1 I SDI#25=0 D STOP Q:SDOUT
 .S SC0=$G(^SC(SC,0)) Q:'$$DIV(+$P(SC0,U,15))
 .S SDX=$$CLINIC^SCRPW71(SC,SDFMT,SDBDT,SDEDT,MAX,SDPAST)
 G:SDOUT EXIT^SCRPW74
 S SDMD=$O(^TMP("SD",$J,"")),SDMD=$O(^TMP("SD",$J,SDMD)),SDMD=$L(SDMD)
 I SDPAST D NAVA^SCRPW75(SDBDT,SDEDT,SDEX)  ;get next available wait times
 G:SDOUT EXIT^SCRPW74
 D ORD
 I $E(IOST)="C" D END^SCRPW50
 S SDREPORT=0 F  S SDREPORT=$O(SDREPORT(SDREPORT)) Q:SDOUT!'SDREPORT  D
 .I SDREPORT(SDREPORT) S SDPAGE=1 D PRT^SCRPW73(0,SDREPORT)
 G EXIT^SCRPW74
 ;
ORD ;Build list to order clinic output
 S SDIV="" F  S SDIV=$O(^TMP("SD",$J,SDIV)) Q:SDIV=""!SDOUT  D
 .S SDCP=0 F  S SDCP=$O(^TMP("SD",$J,SDIV,SDCP)) Q:'SDCP!SDOUT  D
 ..S SC=0 F  S SC=$O(^TMP("SD",$J,SDIV,SDCP,SC)) Q:'SC!SDOUT  D
 ...S SCNA=$P($G(^SC(SC,0)),U) S:'$L(SCNA) SCNA="UNKNOWN"
 ...S ^TMP("SDS",$J,SDCP,SCNA,SC)=""
 Q
 ;
OE(SDBDT,SDEDT,MAX,SDEX) ;Count clinic workload
 ;Input: SDBDT=begin date
 ;Input: SDEDT=end date
 ;Input: MAX=number of days in date range
 ;Input: SDEX='0' for user report, '1' for Austin extract
 N SDT,SDOE,SDOE0,SDCT,SDCP,SDQUIT,SDAY,DFN
 S (SDQUIT,SDCT)=0,SDT=SDBDT
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!(SDT>SDEDT)!SDOUT  D
 .S SDOE=0 F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE!SDOUT  D
 ..S SDCT=SDCT+1 I SDCT#1000=0 D STOP Q:SDOUT
 ..S SDOE0=$$GETOE^SDOE(SDOE) Q:$P(SDOE0,U,6)  Q:$P(SDOE0,U,12)=12
 ..S DFN=$P(SDOE0,U,2) Q:'DFN
 ..Q:$E($P($G(^DPT(DFN,0)),U,9),1,5)="00000"  ;exclude test patients
 ..S SC=$P(SDOE0,U,4) Q:'SC  Q:'$$DIV(+$P(SDOE0,U,11))
 ..S SC0=$G(^SC(SC,0)) Q:'$L($P(SC0,U))
 ..Q:$P(SC0,U,17)="Y"  Q:'$$CPAIR^SCRPW71(SC0,.SDCP)
 ..I 'SDEX,$D(SDSORT) S SDQUIT=0 D  Q:SDQUIT
 ...I SDSORT="CL"!(SDSORT="CA"),'$D(SDSORT($P(SC0,U))) S SDQUIT=1 Q
 ...I SDSORT="CP",'$D(SDSORT(SDCP)) S SDQUIT=1
 ..S SDIV=$$DIV^SCRPW71(SC0) Q:'$L(SDIV)
 ..I '$D(^TMP("SD",$J,SDIV,SDCP,SC)) D ARRINI^SCRPW71(SDCP,SC,MAX,SDPAST)
 ..S $P(^TMP("SD",$J,SDIV,SDCP),U,3)=$P(^TMP("SD",$J,SDIV,SDCP),U,3)+1
 ..S $P(^TMP("SD",$J,SDIV,SDCP,SC),U,3)=$P(^TMP("SD",$J,SDIV,SDCP,SC),U,3)+1
 ..Q:SDFMT'="D"  S X1=$P(SDT,"."),X2=SDBDT D ^%DTC S SDAY=X+1
 ..D ARRSET(SDCP,SC,SDAY) Q
 Q
 ;
ARRSET(SDCP,SC,SDI) ;Set daily counts into array
 ;Input: SDCP=credit pair
 ;Input: SC=clinic ifn
 ;Input: SDI=number of days from report date
 N SDS,SDP,SDX
 S SDS=SDI-1\12,SDP=SDI#12 S:SDP=0 SDP=12
 S SDX=$P(^TMP("SD",$J,SDIV,SDCP,SC,SDS),U,SDP)
 S:'$L(SDX) SDX="0~0~0"
 S $P(SDX,"~",3)=$P(SDX,"~",3)+1
 S $P(^TMP("SD",$J,SDIV,SDCP,SC,SDS),U,SDP)=SDX
 Q
 ;
DIV(SDIV) ;Evaluate division
 Q:'SDDIV 1  Q $D(SDDIV(SDIV))
 ;
CA(SORT) ;Evaluate list of clinics for selected patient
 N SDCNAM,SC0,SDIV,XX,DFN,SDIV,SDCP,SDPNAME S SDI=0
 F XX=1:1:$G(SDPAT) S DFN=+^TMP("SDPAT",SDJN,XX),SDPNAME=$P(^(XX),U,2)  D
 .N SDDT S SDDT=SDBDT-1+.9999999 ; DATE/TIME APPT SCHEDULED 
 .F  S SDDT=$O(^DPT(DFN,"S",SDDT)) Q:'SDDT!(SDDT>SDEDT)  D
 ..S SDI=SDI+1 I SDI#10=0 D STOP Q:SDOUT
 ..S SC=+^DPT(DFN,"S",SDDT,0),SC0=$G(^SC(SC,0)) I '$$DIV(+$P(SC0,U,15)) Q
 ..Q:$P(SC0,U,17)="Y"  ;non-count clinic
 ..S SDIV=$$DIV^SCRPW71(SC0)
 ..I '$$CPAIR^SCRPW71(SC0,.SDCP) Q
 ..I $G(SORT)="CP",'$D(SORT(SDCP)) Q  ;selection by credit pairs
 ..I $G(SORT)="CL",'$D(SORT($P(SC0,U))) Q  ; selection by list of clinics
 ..I $G(SDREPORT(5)) S ^TMP("SDIPLST",$J,DFN,SC)="",^TMP("SDIP",$J,$P(SDIV,U,2),SC)=SDCP_U_$P(SDIV,U),^TMP("SDORD",$J,SDPNAME,DFN)=""
 ..S SDX=$$CLINIC^SCRPW71(SC,SDFMT,SDBDT,SDEDT,MAX,SDPAST)
 Q
CL ;Evaluate list of clinics
 N SDCNAM,SC0,SDIV S SDI=0
 S SDCNAM="" F  S SDCNAM=$O(SDSORT(SDCNAM)) Q:SDCNAM=""!SDOUT  D
 .S SDI=SDI+1 I SDI#10=0 D STOP Q:SDOUT
 .S SC=SDSORT(SDCNAM),SC0=$G(^SC(SC,0)) Q:'$$DIV(+$P(SC0,U,15))
 .I $G(SDREPORT(4)) S ^TMP("SDPLIST",$J,SC)=""
 .S SDX=$$CLINIC^SCRPW71(SC,SDFMT,SDBDT,SDEDT,MAX,SDPAST)
 .I $P(SDX,U,3)=-1 D
 ..S SDIV=$$DIV^SCRPW71(SC0)
 ..S:$L(SDIV) $P(^TMP("SD",$J,SDIV,SDCNAM),U,3)=$P(SDX,U,3,4) Q
 Q
 ;
CP ;Evaluate list of credit pairs
 N SDCCP,SC,SC0 S SC=0
 F  S SC=$O(^SC(SC)) Q:'SC!SDOUT  D
 .S SC0=$G(^SC(SC,0)) Q:'$$DIV(+$P(SC0,U,15))
 .Q:'$$CPAIR^SCRPW71(SC0,.SDCCP)!'$D(SDSORT(SDCCP))
 .I $G(SDREPORT(4)) S ^TMP("SDPLIST",$J,SC)=""
 .S SDX=$$CLINIC^SCRPW71(SC,SDFMT,SDBDT,SDEDT,MAX,SDPAST)
 Q
 ;
CNAME(SC) ;Massage clinic name
 N SDX
 ;Default name value
 S SDX=$P($G(^SC(SC,0)),U) Q:'$L(SDX) "UNKNOWN"
 ;Remove extract formatting characters
 S SDX=$TR(SDX,"#$^~|")
 ;Uppercase name value
 S SDX=$TR(SDX,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q SDX
 ;
SORT(SDSORT) ;Gather sort values for detailed report
 ;Input: SDSORT=sort category (pass by reference)
 ;Output: '1' if selection(s) made, '0' otherwise
 ;        SDSORT(clinic name)=clinic ifn 
 ;                    (or)
 ;        SDSORT(credit pair)=credit pair
 ;
 N SDSX S SDSX="S"_SDSORT
 I SDSORT="CA" Q 1
 D @SDSX Q $D(SDSORT)>1
 ;
SCL ;Select clinics for detail
 N DIC,SDQUIT S (SDQUIT,SDOUT)=0
 S DIC="^SC(",DIC(0)="AEMQ",DIC("A")="Select CLINIC: ",DIC("S")="I $P(^(0),U,3)=""C"""
 W ! F  Q:SDOUT!SDQUIT  D
 .D ^DIC I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 .I X="" S SDQUIT=1 Q
 .I Y>0,$L($P(Y,U,2)) S SDSORT($P(Y,U,2))=+Y
 Q
 ;
SCP ;Get credit pairs for detail
 N DIR,SDQUIT S (SDQUIT,SDOUT)=0
 S DIR(0)="NO:101000:999000:0",DIR("A")="Select clinic DSS credit pair"
 S DIR("?",1)="Specify a six digit number that represents the primary and secondary stop"
 S DIR("?",2)="code of clinics you wish to evaluate.  For clinics that do not have a"
 S DIR("?",3)="secondary stop code, enter ""000"" as the second half of the credit pair"
 S DIR("?")="(eg. ""323000"")."
 W ! F  Q:SDOUT!SDQUIT  D
 .D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 .I X="" S SDQUIT=1 Q
 .I '$$VCP(Y) W "  Invalid credit pair!" Q
 .S SDSORT(Y)=Y
 Q
 ;
VCP(Y) ;Validate credit pair
 ;Input: Y=credit pair
 ;Output: '1' if valid, '0' otherwise
 Q:Y'?6N 0
 Q:'$D(^DIC(40.7,"C",$E(Y,1,3))) 0
 Q:$E(Y,4,6)="000" 1
 Q:'$D(^DIC(40.7,"C",$E(Y,4,6))) 0
 Q 1
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
ADDL(SDZ) ;Format additional data
 ;Input: SDZ=addl. data from ^TMP("SDNAVB",^J,SDCP,SC)
 ;
 N SDI,SDX S SDX=""
 F SDI=1:1:7 S SDX=SDX_$S(SDI=5:"^",1:"~")_+$P(SDZ,U,SDI)
 Q SDX
 ;
EXTRACT ;Gather data for extract
 N SDBEG,SDEND,SDTIME,SDCP,SDX,SDY,SC,SCNA,SDI,SDFMT,SDOUT,SDXM,SDIOM,SDFOOT
 N SDEXDT,MAX,X1,X2,X S SDIOM=$G(IOM,80)
 F SDI=1,2,3 S SDREPORT(SDI)=1
 S (SDOUT,SDCOL)=0,SDFMT="D",SDBEG=$H,SDEXDT=DT D INIT^SCRPW71
 K ^TMP("SD",$J),^TMP("SDS",$J),^TMP("SDTMP",$J),^TMP("SDXM",$J)
 S X1=SDEDT,X2=SDBDT D ^%DTC S MAX=X+1
 D HINI^SCRPW76,FOOT^SCRPW77(.SDFOOT)
 ;
 ;Get encounter workload
 I SDPAST D OE(SDBDT,SDEDT_.9999,MAX,1)  ;encounter workload
 ;
 ;Get clinic availability data
 S SC=0 F  S SC=$O(^SC(SC)) Q:'SC  S SC0=$G(^SC(SC,0)) D
 .S SDX=$$CLINIC^SCRPW71(SC,SDFMT,SDBDT,SDEDT,MAX,SDPAST)
 ;
 ;Get next available wait times
 S SDMD=$O(^TMP("SD",$J,"")),SDMD=$O(^TMP("SD",$J,SDMD)),SDMD=$L(SDMD)
 I SDPAST D NAVA^SCRPW75(SDBDT,SDEDT_.9999,1)  ;next ava. wait times
 ;
 ;Order by clinic, send extract data to Austin
 D ORD,TXXM^SCRPW70 K ^TMP("SDXM",$J)
 ;
 ;Send summary bulletin to mail group
 S SDFMT="S",SDEND=$H,SDTIME=$$TIME(SDBEG,SDEND)
 S SDBEG=$$HTE^XLFDT(SDBEG),SDEND=$$HTE^XLFDT(SDEND)
 S SDY="*** Clinic Appointment "_$S(SDPAST:"Utilization",1:"Availability")_" Extract ***"
 S SDXM=1,SDX="",$E(SDX,(79-$L(SDY)\2))=SDY D XMTX^SCRPW73(SDX)
 D XMTX^SCRPW73(" ")
 D XMTX^SCRPW73("                   For date range: "_SDPBDT_" to "_SDPEDT)
 D XMTX^SCRPW73("               Extract start time: "_SDBEG)
 D XMTX^SCRPW73("                 Extract end time: "_SDEND)
 D XMTX^SCRPW73("                 Extract run time: "_SDTIME)
 D XMTX^SCRPW73("                      Task number: "_$G(ZTSK))
 F SDI=1:1:4 D XMTX^SCRPW73("")
 D PRT^SCRPW73(SDXM,1),EXXM^SCRPW70("G.SC CLINIC WAIT TIME")
 I SDPAST F SDI=2,3 D
 .K ^TMP("SDXM",$J) S SDXM=1
 .D PRT^SCRPW73(SDXM,SDI),EXXM^SCRPW70("G.SC CLINIC WAIT TIME")
 G EXIT^SCRPW74
 ;
TIME(SDBEG,SDEND) ;Calculate length of run time
 ;Input: SDBEG=start time in $H format
 ;Input: SDEND=end time in $H format
 ;Output: text formatted string with # days, hours, minutes and seconds
 N X,Y
 S SDEND=$P(SDEND,",")-$P(SDBEG,",")*86400+$P(SDEND,",",2)
 S SDBEG=$P(SDBEG,",",2),X=SDEND-SDBEG,Y("D")=X\86400
 S X=X#86400,Y("H")=X\3600,X=X#3600,Y("M")=X\60,Y("S")=X#60
 S Y("D")=$S('Y("D"):"",1:Y("D")_" day"_$S(Y("D")=1:"",1:"s")_", ")
 S Y("H")=Y("H")_" hour"_$S(Y("H")=1:"",1:"s")_", "
 S Y("M")=Y("M")_" minute"_$S(Y("M")=1:"",1:"s")_", "
 S Y("S")=Y("S")_" second"_$S(Y("S")=1:"",1:"s")
 Q Y("D")_Y("H")_Y("M")_Y("S")
