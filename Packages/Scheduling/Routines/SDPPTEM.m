SDPPTEM ;BP-CIOFO/KEITH - Patient Profile Team Info ; 8/27/99 10:39am
 ;;5.3;Scheduling;**41,177,297**;AUG 13, 1993
 ;
 ;Gathering Team Information for Patient Profile
 ;
TDATA(DFN,VALMCNT,SDATE,SDPRT,SDCOL) ;Team information - gather, format and optionally print.
 ;Input: DFN=patient ifn
 ;Input: VALMCNT=variable to return number of lines (pass by reference)
 ;Input: SDATE=effective date (optional)
 ;Input: SDPRT=print flag, 'P' for PC info only, 'A' for all (optional)
 ;Input: SDCOL=column to print in conjunction with SDPRT flag (optional)
 ;
 Q:DFN'>0
 N SDI,SDATE,SDLIST,SDX,SDLN,SDY,SDPH,SDTEAM,SDPTA,SDII,SDIII,SDZ
 N SDTM,SDTMN,SDPO,SDPON,SDPR,SDPRN
 N PAGER,PHONE
 ;
 F SDI="SDPLIST","SDTEMP" K ^TMP(SDI,$J)
 S SDCOL=+$G(SDCOL),SDATE=$G(SDATE) S:SDATE<1 SDATE=DT
 F SDI="BEGIN","END" S SDATE(SDI)=SDATE
 S SDATE="SDATE",SDLIST="^TMP(""SDPLIST"",$J)",SDLN=2
 ;
 S SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDLIST)
 ;
 ;PC Team
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"PCTM",SDI)) Q:'SDI  D
 .S SDX=$G(^TMP("SDPLIST",$J,DFN,"PCTM",SDI)) Q:'$L(SDX)
 .S SDY=""
 .D S1("Primary Care Team",$P(SDX,U,2))
 .S SDPH=$P($G(^SCTM(404.51,+SDX,0)),U,2) D:$L(SDPH) S2("Phone",SDPH)
 .S:$P(SDX,U,3) SDPTA($P(SDX,U,3))=""
 .D STL(SDY)
 .Q
 ;
 ;AP
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"PCAP",SDI)) Q:'SDI  D
 .S SDX=$G(^TMP("SDPLIST",$J,DFN,"PCAP",SDI)) Q:'$L(SDX)
 .S SDY=""
 .D S1("Associate Provider",$P(SDX,U,2))
 .D S2("Position",$P(SDX,U,4))
 .D STL(SDY)
 .D PHONE($P(SDX,U,1))
 .S SDY=""
 .D S3("Pager",PAGER)
 .D S4("Phone",PHONE)
 .D STL(SDY)
 .Q
 ;PCP
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"PCPR",SDI)) Q:'SDI  D
 .S SDX=$G(^TMP("SDPLIST",$J,DFN,"PCPR",SDI)) Q:'$L(SDX)
 .S SDY=""
 .D S1("PC Provider",$P(SDX,U,2))
 .D S2("Position",$P(SDX,U,4))
 .D STL(SDY)
 .D PHONE($P(SDX,U,1))
 .S SDY=""
 .D S3("Pager",PAGER)
 .D S4("Phone",PHONE)
 .D STL(SDY)
 .Q
 ;
 I $G(SDPRT)="P" D PRT G TDQ
 S SDII=0
 F  S SDII=$O(^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)) Q:'SDII  D
 .S SDX=^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)
 .Q:'$D(SDPTA(+$P(SDX,U,11)))  S SDIII=0
 .F  S SDIII=$O(^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)) Q:'SDIII  D
 ..S SDZ=^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)
 ..Q:$P(SDZ,U,3)'=+SDX  S SDY=""
 ..D S1("Non-PC Provider",$P(SDZ,U,2)),S2("Position",$P(SDZ,U,4))
 ..D STL(SDY) Q
 .Q
 S SDI=0
 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"NPCTM",SDI)) Q:'SDI  D
 .S SDX=^TMP("SDPLIST",$J,DFN,"NPCTM",SDI)
 .S SDTEAM($P(SDX,U,2),+SDX)="",SDPTA=$P(SDX,U,3) Q:'SDPTA  D
 ..S SDII=0
 ..F  S SDII=$O(^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)) Q:'SDII  D
 ...S SDY=^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)
 ...Q:$P(SDY,U,11)'=SDPTA
 ...S SDTEAM($P(SDX,U,2),+SDX,$P(SDY,U,2),+SDY)="",SDIII=0
 ...F  S SDIII=$O(^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)) Q:'SDIII  D
 ....S SDZ=^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)
 ....Q:$P(SDZ,U,3)'=+SDY
 ....S SDTEAM($P(SDX,U,2),+SDX,$P(SDY,U,2),+SDY,$P(SDZ,U,2),+SDZ)=""
 ....Q
 ...Q
 ..Q
 .Q
 S SDTM="" F  S SDTM=$O(SDTEAM(SDTM)) Q:SDTM=""  D
 .S SDTMN=0 F  S SDTMN=$O(SDTEAM(SDTM,SDTMN)) Q:'SDTMN  D
 ..I SDLN>0 D STL("")
 ..S SDY="" D S1("Non-PC Team",SDTM)
 ..S SDPH=$P($G(^SCTM(404.51,+SDTMN,0)),U,2) D:$L(SDPH) S2("Phone",SDPH)
 ..D STL(SDY) S SDPO=""
 ..F  S SDPO=$O(SDTEAM(SDTM,SDTMN,SDPO)) Q:SDPO=""  S SDPON=0 D
 ...F  S SDPON=$O(SDTEAM(SDTM,SDTMN,SDPO,SDPON)) Q:'SDPON  D
 ....I $O(SDTEAM(SDTM,SDTMN,SDPO,SDPON,""))="" S SDY="" D S1("Non-PC Provider",""),S2("Position",SDPO),STL(SDY) Q
 ....S SDPR=""
 ....F  S SDPR=$O(SDTEAM(SDTM,SDTMN,SDPO,SDPON,SDPR)) Q:SDPR=""  D
 .....S SDPRN=0
 .....F  S SDPRN=$O(SDTEAM(SDTM,SDTMN,SDPO,SDPON,SDPR,SDPRN)) Q:'SDPRN  D
 ......S SDY=""
 ......D S1("Non-PC Provider",SDPR)
 ......D S2("Position",SDPO)
 ......D STL(SDY)
 ......D PHONE(SDPRN)
 ......S SDY=""
 ......D S3("Pager",PAGER)
 ......D S4("Phone",PHONE)
 ......D STL(SDY)
 ......Q
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 ;
 I $G(SDPRT)="A" D PRT G TDQ
 S SDY="",$E(SDY,29)="*** Team Information ***"
 S ^TMP("SDTEMP",$J,1)=SDY,^TMP("SDTEMP",$J,2)=""
 I SDLN=2 S SDY="",$E(SDY,20)="-- No team assignment information found --",^TMP("SDTEMP",$J,3)=SDY
 S GBL=$G(GBL,"") I $L(GBL)<1 S GBL=$S('$D(VALMAR):"^TMP(""SDPP"",$J)",$L(VALMAR)>1:VALMAR,1:"^TMP(""SDPP"",$J)")
 ;add line at bottom of array for readability
 S SDI=$O(^TMP("SDTEMP",$J,""),-1)+1,^TMP("SDTEMP",$J,SDI)=""
 ;respect the array count passed in to the function
 S (SDII,VALMCNT)=$O(@GBL@(""),-1)+1
 S SDI=0
 F  S SDI=$O(^TMP("SDTEMP",$J,SDI)) Q:'SDI  D
 .S SDX=^TMP("SDTEMP",$J,SDI),SDII=SDII+1
 .S @GBL@(SDII,0)=SDX,VALMCNT=$G(VALMCNT)+1
 .I SDLN<7,SDI>3 S SDII=SDII+1,@GBL@(SDII,0)="",VALMCNT=$G(VALMCNT)+1
 .Q
TDQ F SDI="SDPLIST","SDTEMP" K ^TMP(SDI,$J,DFN)
 Q
 ;
S1(SDT,SDX) ;Set first piece of string
 ;Input: SDT=subtitle
 ;Input: SDX=data value
 S SDY=$J(SDT,18)_": "_$E(SDX,1,28) Q
 ;
S2(SDT,SDX) ;Set second piece of string
 ;Input: SDT=subtitle
 ;Input: SDX=data value
 I $L($G(SDPRT)),SDCOL>0 Q
 S $E(SDY,53)=$J(SDT,8)_": "_$E(SDX,1,18) Q
 ;
S3(SDT,SDX) ;Set first piece of string that displays phone numbers
 ;Input: SDT=subtitle
 ;Input: SDX=data value
 S SDY=$J(SDT,30)_": "_$E(SDX,1,20)
 Q
 ;
S4(SDT,SDX) ;Set second piece of string that displays phone numbers
 ;Input: SDT=subtitle
 ;Input: SDX=data value
 I $L($G(SDPRT)),SDCOL>0 Q
 S $E(SDY,56)=$J(SDT,4)_": "_$E(SDX,1,20)
 Q
 ;
PHONE(IEN) ;Get provider's pager and phone numbers.
 ;Return: PAGER = Pager number
 ;        PHONE = Phone number
 NEW LIST
 S (PAGER,PHONE)=""
 Q:'$G(IEN)
 Q:'$$NEWPERSN^SCMCGU(IEN,"LIST")
 S PAGER=$P(LIST(IEN),U,5)
 S PHONE=$P(LIST(IEN),U,2)
 Q
 ;
STL(SDY) ;Set text line
 ;Input: SDY=string
 S SDLN=SDLN+1
 S ^TMP("SDTEMP",$J,SDLN)=SDY
 Q
 ;
PRT ;Write assignment information
 N SDI S SDI=0
 F  S SDI=$O(^TMP("SDTEMP",$J,SDI)) Q:'SDI  D
 .W !?(SDCOL),^TMP("SDTEMP",$J,SDI) Q
 Q
 ;
PCLINE(DFN,SDATE) ;PC provider, associate and team in a single line
 ;Input: DFN=patient ifn
 ;Input: SDATE=effective date (optional)
 ;Output: PC provider, associate and team formatted as 80 character
 ;        line, or "" if none
 ;
 N SDLIST,SDI,SDX,SDY,SDZ,SDL,SDC,SDTL
 Q:'DFN ""  S:$G(SDATE)<1 SDATE=DT S SDLIST="^TMP(""SDPLIST"",$J)"
 F SDI="BEGIN","END" S SDATE(SDI)=SDATE
 S SDATE="SDATE"
 S SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDLIST)
 S SDY="PC Prov: ^Assoc. Prov: ^Team: ",SDL=48,SDC=3,SDTL=0
 S SDX(1)=$$PCL("PCPR")
 S SDX(2)=$$PCL("PCAP")
 S SDX(3)=$$PCL("PCTM")
 K ^TMP("SDPLIST",$J,DFN)
 F SDI=1,2,3 S SDZ($L(SDX(SDI)),SDI)=""
 S SDI="" F  S SDI=$O(SDZ(SDI)) Q:SDI=""  D
 .S SDII=0 F  S SDII=$O(SDZ(SDI,SDII)) Q:'SDII  D
 ..I 'SDI S SDC=SDC-1 Q
 ..I SDI<(SDL\SDC) S SDX(SDII)=$P(SDY,U,SDII)_SDX(SDII),SDL=SDL-SDI,SDC=SDC-1 Q
 ..S SDX(SDII)=$P(SDY,U,SDII)_$E(SDX(SDII),1,(SDL\SDC))
 ..Q
 .Q
 F SDI=1,2,3 S SDTL=SDTL+$L(SDX(SDI))
 Q:SDTL=0 ""
 S SDX=SDX(1),$E(SDX,($L(SDX)+1+(80-SDTL\2)))=SDX(2),$E(SDX,81-$L(SDX(3)))=SDX(3)
 Q SDX
 ;
PCL(SDSUB) ;Get name value
 ;Input: SDSUB=node from GETALL^SCAPMCA
 N SDN
 S SDN=+$G(^TMP("SDPLIST",$J,DFN,"PCPOS",0))
 Q:SDN=0 ""
 Q:SDN>1 "[ambiguous data]"
 S SDN=+$G(^TMP("SDPLIST",$J,DFN,SDSUB,0))
 Q:SDN=0 ""
 Q:SDN>1 "[ambiguous data]"
 Q $P($G(^TMP("SDPLIST",$J,DFN,SDSUB,1)),U,2)
