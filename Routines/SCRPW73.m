SCRPW73 ;BP-CIOFO/KEITH,ESW - Clinic appointment availability extract (cont.) ; 5/28/03 2:27pm
 ;;5.3;Scheduling;**192,206,223,249,291**;AUG 13, 1993
 ;
PRT(SDXM,SDREPORT) ;Print report
 ;Input: SDXM='1' for output to mail message text, '0' otherwise
 ;Input: SDREPORT=report element to print
 ;
 N SDX,SDY,SDI,SDP,SDPCT,SDMD,SCNA,SDT,SDFLEN
 S SDOUT=0,SDFLEN=$S('SDPAST:5,SDREPORT#1:12,1:11)
 S SDMD=$O(^TMP("SD",$J,"")),SDMD=$O(^TMP("SD",$J,SDMD)),SDMD=$L(SDMD)
 I '$D(^TMP("SD",$J)),$G(SDREPORT)'=5 D  Q
 .D HDR^SCRPW76(0,SDREPORT) S SDX="No data found within the report parameters selected."
 .W !!?(SDIOM-$L(SDX)\2),SDX Q
 I '$D(^TMP("SDIPLST",$J)),$G(SDREPORT)=5 D  Q
 .D HDR^SCRPW76(0,SDREPORT) S SDX="No data found within the report parameters selected."
 .W !!?(SDIOM-$L(SDX)\2),SDX Q
 I SDREPORT=5 D PRT5^SCRPW78 Q
 S SDIV=9999999 F  S SDIV=$O(^TMP("SD",$J,SDIV)) Q:SDIV=""!SDOUT  D
 .I SDFMT="D" D
 ..S SDCP="" F  S SDCP=$O(^TMP("SD",$J,SDIV,SDCP)) Q:SDCP=""!SDOUT  D
 ...S SCNA="" F  S SCNA=$O(^TMP("SDS",$J,SDCP,SCNA)) Q:SCNA=""!SDOUT  D
 ....S SC=0 F  S SC=$O(^TMP("SDS",$J,SDCP,SCNA,SC)) Q:'SC!SDOUT  D
 .....Q:'$D(^TMP("SD",$J,SDIV,SDCP,SC))
 .....D HDR^SCRPW76(1,SDREPORT,SDIV,SDCP,SC) Q:SDOUT
 .....I SDREPORT=4 D OUT4^SCRPW77 Q
 .....S SDX=^TMP("SD",$J,SDIV,SDCP,SC)
 .....I $P(SDX,U)+$P(SDX,U,2)+$P(SDX,U,3)'>0,'$D(^TMP("SDNAVA",$J,SDIV,SDCP,SC)) D  Q
 ......S SDY="No availability found"_$S($L($P(SDX,U,4)):": "_$P(SDX,U,4)_".",1:".")
 ......W !!?(SDIOM-$L(SDY)\2),SDY Q
 .....S SDI="" F  S SDI=$O(^TMP("SD",$J,SDIV,SDCP,SC,SDI)) Q:SDI=""!SDOUT  D
 ......S SDX=^TMP("SD",$J,SDIV,SDCP,SC,SDI)
 ......F SDP=1:1 S SDY=$P(SDX,U,SDP) Q:'$L(SDY)!SDOUT  D
 .......S SDY=$TR(SDY,"~","^"),SDT=$$DAY(SDI,SDP,SDBDT)
 .......S SDY=$$TRX(SDREPORT,SDY,SDIV,SDCP,SC,$P(SDT,U,2))
 .......I 'SDXM,$Y>(IOSL-SDFLEN) D
 ........D:SDPAST FOOTER^SCRPW77(SDREPORT) D HDR^SCRPW76(1,SDREPORT,SDIV,SDCP,SC)
 ........Q
 .......Q:SDOUT
 .......D OUTPUT(SDREPORT,$P(SDT,U),SDY,SDCOL,4,0,SDPAST,.SDXM)
 .......Q
 ......Q
 .....Q:SDOUT
 .....S SDX=^TMP("SD",$J,SDIV,SDCP,SC),SDX=$$TRX(SDREPORT,SDX,SDIV,SDCP,SC)
 .....D OUTPUT(SDREPORT,"    Clinic Total:",SDX,SDCOL,0,1,SDPAST,.SDXM)
 .....D:SDPAST FOOTER^SCRPW77(SDREPORT)
 .....Q
 ....Q
 ...Q
 ..Q
 .Q:SDOUT  D SUM(SDIV,SDREPORT) Q
 Q:SDOUT
 ;
 I SDMD D SUM(0,SDREPORT)
 Q
 ;
TRX(SDREPORT,SDX,SDIV,SDCP,SC,SDT) ;Transform string for output
 ;Input: SDREPORT=report element to print
 ;Input: SDX=output numbers to transform
 ;Input: SDIV=medical center division
 ;Input: SDCP=credit pair (optional)
 ;Input: SC=clinic ien (optional)
 ;Input: SDT=date for detail by day (optional)
 ;Output: string of output values for specified SDREPORT type
 ;
 N SDY
 I SDREPORT=1 S SDY=$$TRX1()
 I SDREPORT=2 S SDY=$$TRX2()
 I SDREPORT=3 S SDY=$$TRX3()
 Q SDY
 ;
TRX1() N SDZ S SDZ=""
 S SDY=$P(SDX,U,2)_U_$P(SDX,U)_U
 S SDY=SDY_$S(+$P(SDX,U,2)=0:0,1:$P(SDX,U)*100\$P(SDX,U,2))
 S SDY=SDY_U_$P(SDX,U,3) D
 .I '$G(SDCP) S SDZ=$G(^TMP("SDNAVA",$J,SDIV)) Q
 .I '$G(SC) S SDZ=$G(^TMP("SDNAVA",$J,SDIV,SDCP)) Q
 .I '$G(SDT) S SDZ=$G(^TMP("SDNAVA",$J,SDIV,SDCP,SC)) Q
 .S SDZ=$G(^TMP("SDNAVA",$J,SDIV,SDCP,SC,SDT)) Q
 S SDY=SDY_U_$P(SDZ,U,1,8)_U_$P(SDZ,U,38,39)
 Q SDY
 ;
TRX2() I '$G(SDCP) S SDY=$P($G(^TMP("SDNAVA",$J,SDIV)),U,9,20) Q SDY
 I '$G(SC) S SDY=$P($G(^TMP("SDNAVA",$J,SDIV,SDCP)),U,9,20) Q SDY
 I '$G(SDT) S SDY=$P($G(^TMP("SDNAVA",$J,SDIV,SDCP,SC)),U,9,20) Q SDY
 S SDY=$P($G(^TMP("SDNAVA",$J,SDIV,SDCP,SC,SDT)),U,9,20)
 Q SDY
 ;
TRX3() I '$G(SDCP) S SDY=$P($G(^TMP("SDNAVA",$J,SDIV)),U,21,37) Q SDY
 I '$G(SC) S SDY=$P($G(^TMP("SDNAVA",$J,SDIV,SDCP)),U,21,37) Q SDY
 I '$G(SDT) S SDY=$P($G(^TMP("SDNAVA",$J,SDIV,SDCP,SC)),U,21,37) Q SDY
 S SDY=$P($G(^TMP("SDNAVA",$J,SDIV,SDCP,SC,SDT)),U,21,37)
 Q SDY
 ;
DAY(SDI,SDP,SDBDT) ;Produce date/day value
 ;Input: SDI=array subscript incrementor
 ;Input: SDP=$PIECE of string containing related date data
 ;Input: SDBDT=report start date
 N X1,X2,X,%H,Y,SDT,SDAY
 S X1=SDBDT,X2=-1 D C^%DTC
 S X1=X,X2=SDI*12+SDP D C^%DTC S SDT=X
 D DW^%DTC S SDAY=X,Y=SDT X ^DD("DD")
 Q Y_" "_$S($E(SDT,6)=0:"-",1:"")_"- "_SDAY_U_SDT
 ;
SUM(SDIV,SDREPORT) ;Print division/facility summary
 ;Input: SDDIV=division name^number (or '0' for facility total)
 ;Input: SDREPORT=report element to print
 ;
 I SDREPORT=4!(SDREPORT=5) Q
 N SDY,SCNA,SDI
 S SDCP="",SDHD=$S(SDIV=0:3,1:2) D HDR^SCRPW76(SDHD,SDREPORT,SDIV)
 F  S SDCP=$O(^TMP("SD",$J,SDIV,SDCP)) Q:SDCP=""!SDOUT  D
 .S SDX=^TMP("SD",$J,SDIV,SDCP),SDY=$G(^TMP("SD",$J,SDIV))
 .F SDI=1:1:3 S $P(SDY,U,SDI)=$P(SDY,U,SDI)+$P(SDX,U,SDI)
 .S ^TMP("SD",$J,SDIV)=SDY
 .Q:'$$DATA(1)  ;Quit if no data
 .I SDMD S SDY=$G(^TMP("SD",$J,0,SDCP)) D 
 ..F SDI=1:1:3 S $P(SDY,U,SDI)=$P(SDY,U,SDI)+$P(SDX,U,SDI)
 ..S ^TMP("SD",$J,0,SDCP)=SDY
 .S SDY=$$OTX("CP"),SDX=$$TRX(SDREPORT,SDX,SDIV,SDCP)
 .D OUTPUT(SDREPORT,SDY,SDX,SDCOL,0,1,SDPAST,.SDXM)
 .S SCNA="" F  S SCNA=$O(^TMP("SDS",$J,SDCP,SCNA)) Q:SCNA=""!SDOUT  D 
 ..S SC=0 F  S SC=$O(^TMP("SDS",$J,SDCP,SCNA,SC)) Q:'SC!SDOUT  D 
 ...S SDX=$G(^TMP("SD",$J,SDIV,SDCP,SC))
 ...Q:'$$DATA(2)  ;Quit if no data
 ...I 'SDXM,$Y>(IOSL-SDFLEN) D
 ....D:SDPAST FOOTER^SCRPW77(SDREPORT) D HDR^SCRPW76(SDHD,SDREPORT,SDIV)
 ....Q
 ...Q:SDOUT
 ...I SDMD S SDY=$G(^TMP("SD",$J,0,SDCP,SC)) D
 ....F SDI=1:1:3 S $P(SDY,U,SDI)=$P(SDY,U,SDI)+$P(SDX,U,SDI)
 ....S ^TMP("SD",$J,0,SDCP,SC)=SDY
 ....Q
 ...S SDY=$$OTX("CL"),SDX=$$TRX(SDREPORT,SDX,SDIV,SDCP,SC)
 ...D OUTPUT(SDREPORT,SDY,SDX,SDCOL,4,0,SDPAST,.SDXM)
 ...Q
 ..Q
 .Q
 Q:SDOUT  S SDX=$G(^TMP("SD",$J,SDIV)),SDX=$$TRX(SDREPORT,SDX,SDIV)
 I $G(SDFMT)="S"&($G(SDFMTS)="CP") D:SDPAST FOOTER^SCRPW77(SDREPORT) Q
 S SDY=$S(SDIV=0:"Facility",1:"Division")_" total:" D OUTPUT(SDREPORT,SDY,SDX,SDCOL,0,1,SDPAST,.SDXM,1)
 D:SDPAST FOOTER^SCRPW77(SDREPORT)
 Q
 ;
DATA(SDS) ;Check for data to print
 ;Input: SDS=subscript level
 ;Output: '1' if data, '0' otherwise
 N SDCK,SDNODE,SDI,SDCT S (SDCT,SDCK)=0
 Q:SDFMT'="S" 1
 I 'SDPAST S SDCK=($P(SDX,U)+$P(SDX,U,2)+$P(SDX,U,3)>0) Q SDCK
 I $P(SDX,U)+$P(SDX,U,2)+$P(SDX,U,3)>0 Q 1
 I SDS=1 S SDNODE=$G(^TMP("SDNAVA",$J,SDIV,SDCP))
 I SDS=2 S SDNODE=$G(^TMP("SDNAVA",$J,SDIV,SDCP,SC))
 F SDI=1:1:39 S SDCT=SDCT+$P(SDNODE,U,SDI)
 S SDCK=SDCT>0
 Q SDCK
 ;
OUTPUT(SDREPORT,SDTX,SDX,SDCOL,SDC,SDL,SDPAST,SDXM,SDTL) ;Write output or load summary message
 ;Input: SDREPORT=report element to print
 ;Input: SDTX=category text value
 ;Input: SDX=output count values
 ;Input: SDCOL=margin adjusted column control
 ;Input: SDC=column to start line
 ;Input: SDL=number of additional linefeeds
 ;Input: SDPAST='0' if dates > TODAY, '1' otherwise
 ;Input: SDXM=mail message line number message text (optional)
 ;Input: SDTL='1' if this is a totals line
 ;
 N SDI,SDPCT
 G:$G(SDXM) OUTXM F SDI=1:1:SDL W !
 D:SDREPORT=1 OUT1 D:SDREPORT=2 OUT2 D:SDREPORT=3 OUT3
 Q
 ;
OUT1 N SDL1,SDL2,SDL3
 W !?(SDCOL+SDC),SDTX
 F SDI=1:1:$S(SDPAST:12,1:3) D MANI(SDX,SDI,$G(SDTL)) D
 .W ?(SDCOL+34+SDL1+(SDI-1*7)),$J(+$P(SDX,U,SDI),$S(((SDI<3)&(SDL3>7)):SDL3,SDI=3:(6-SDL1),1:7),$$OPD())_$S(SDI=3:"%",1:"")
 .Q
 I SDPAST F SDI=0,1 D
 .W ?(SDCOL+118+(SDI*7)),$J(+$P(SDX,U,13+SDI),6,0)_"%"
 .Q
 Q
 ;
MANI(SDX,SDI,SDTL) ;Manipulate column position for large totals
 ;
 S (SDL1,SDL2)=0,SDL3=$L($P(SDX,U,SDI))
 I $G(SDTL) D
 .I SDI=1,SDL3>7 S SDL1=(7-SDL3)
 .I SDI=2,SDL3>6 S SDL1=1
 .I SDI=3 S SDL1=3
 .Q
 Q
 ;
OUT2 W !?(SDCOL+SDC),SDTX
 F SDI=0:1:5 D
 .W ?(36+(SDI*16)),$J(+$P(SDX,U,(1+(SDI*2))),8,0)
 .W ?(44+(SDI*16)),$J(+$P(SDX,U,(2+(SDI*2))),8,1)
 .Q
 Q
 ;
OUT3 W !?(SDCOL+SDC),SDTX
 W ?30,$J(+$P(SDX,U),6,0),?36,$J(+$P(SDX,U,2),6,1)
 F SDI=0:1:4 D
 .W ?(42+(SDI*18)),$J(+$P(SDX,U,(3+(SDI*3))),6,0)
 .W ?(48+(SDI*18)),$J(+$P(SDX,U,(4+(SDI*3))),6,1)
 .W ?(54+(SDI*18)),$J(+$P(SDX,U,(5+(SDI*3))),6,1)
 .Q
 Q
 ;
OPD() ;Output decimal places
 Q $S(SDI<6:0,SDI#2:0,1:1)
 ;
OUTXM ;Load bulletin message text
 ;Output: ^TMP("SDXM",$J,SDXM)=mail message text line
 N SDZ S:SDC<1 SDC=1
 F SDI=1:1:SDL D XMTX("")
 D:SDREPORT=1 OUTXM1 D:SDREPORT=2 OUTXM2 D:SDREPORT=3 OUTXM3
 Q
 ;
OUTXM1 N SDL1,SDL2,SDL3
 S SDZ="",$E(SDZ,SDC)=SDTX
 F SDI=1:1:$S(SDPAST:12,1:3) D MANI(SDX,SDI,$G(SDTL)) D
 .S $E(SDZ,(35+SDL1+(SDI-1*7)))=$J(+$P(SDX,U,SDI),$S(((SDI<3)&(SDL3>7)):SDL3,SDI=3:(6-SDL1),1:7),$$OPD())_$S(SDI=3:"%",1:"")
 I SDPAST F SDI=0,1 D
 .S $E(SDZ,(119+(SDI*7)))=$J(+$P(SDX,U,13+SDI),6,0)_"%"
 D XMTX(SDZ)
 Q
 ;
OUTXM2 S SDZ="",$E(SDZ,SDC)=SDTX
 F SDI=0:1:5 D
 .S $E(SDZ,(37+(SDI*16)))=$J(+$P(SDX,U,(1+(SDI*2))),8,0)
 .S $E(SDZ,(45+(SDI*16)))=$J(+$P(SDX,U,(2+(SDI*2))),8,1)
 .Q
 D XMTX(SDZ)
 Q
 ;
OUTXM3 S SDZ="",$E(SDZ,SDC)=SDTX
 S $E(SDZ,31)=$J(+$P(SDX,U),6,0),$E(SDZ,37)=$J(+$P(SDX,U,2),6,1)
 F SDI=0:1:4 D
 .S $E(SDZ,(43+(SDI*18)))=$J(+$P(SDX,U,(3+(SDI*3))),6,0)
 .S $E(SDZ,(49+(SDI*18)))=$J(+$P(SDX,U,(4+(SDI*3))),6,1)
 .S $E(SDZ,(55+(SDI*18)))=$J(+$P(SDX,U,(5+(SDI*3))),6,1)
 .Q
 D XMTX(SDZ)
 Q
 ;
XMTX(SDX) ;Set mail message text line
 ;Input: SDX=text value
 S ^TMP("SDXM",$J,SDXM)=SDX,SDXM=SDXM+1 Q
 ;
OTX(SDSORT)    ;Produce output text for clinic or credit pair
 ;Input: SDSORT='CL' for clinic name, 'CP' for credit pair
 N SDZ,SDSC1,SDSC2
 I SDSORT="CL" D  Q SDZ
 .S SDZ=$P($G(^SC(+SC,0)),U) S:'$L(SDZ) SDZ="UNKNOWN"
 .I SDREPORT=3 S SDZ=$E(SDZ,1,26)
 .Q
 S SDSC1=$O(^DIC(40.7,"C",$E(SDCP,1,3),""))
 S SDSC1=$P($G(^DIC(40.7,+SDSC1,0)),U),SDSC1=$TR(SDSC1,"/","-")
 S:'$L(SDSC1) SDSC1="UNKNOWN"
 I $E(SDCP,4,6)="000" S SDSC2="(NONE)" G CPO1
 S SDSC2=$O(^DIC(40.7,"C",$E(SDCP,4,6),""))
 S SDSC2=$P($G(^DIC(40.7,+SDSC2,0)),U),SDSC2=$TR(SDSC2,"/","-")
 S:'$L(SDSC2) SDSC2="UNKNOWN"
CPO1 I $L(SDSC1)<13 S SDZ=SDSC1_"/"_$E(SDSC2,1,(13+(13-$L(SDSC1)))) G CPOTQ
 I $L(SDSC2)<13 S SDZ=$E(SDSC1,1,(13+(13-$L(SDSC2))))_"/"_SDSC2 G CPOTQ
 S SDZ=$E(SDSC1,1,13)_"/"_$E(SDSC2,1,13)
CPOTQ S SDZ=SDCP_" "_SDZ I SDREPORT=3 S SDZ=$E(SDZ,1,30)
 Q SDZ
