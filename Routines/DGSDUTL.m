DGSDUTL ;ALB/PHH,RMM - DG/SD API UTILITIES ;3/4/2004  10:03
 ;;5.3;Registration;**568**;AUG 13, 1993
 ;
 Q
PCTEAM(DFN,DATE,ASSTYPE) ; Get Primary Care Team
 ; DFN - IEN of patient file (#2)
 ; DATE - Date of interest (Default=DT)
 ; ASSTYPE - Assignment Type (Default=1 for PC Team)
 ;
 N RETVAL,ACTDT,SCTM,SCPTTMA,INACTDT
 S RETVAL=0
 Q:'$G(DFN) RETVAL
 S DATE=$G(DATE,DT),ASSTYPE=$G(ASSTYPE,1)
 ;
 ; Returns pointer to file #404.51 if it exists, 0 if not
 S ACTDT=+$O(^SCPT(404.42,"APCTM",+DFN,+ASSTYPE,(DATE+.000001)),-1)
 S SCTM=$O(^SCPT(404.42,"APCTM",+DFN,+ASSTYPE,+ACTDT,0))
 S SCPTTMA=$O(^SCPT(404.42,"APCTM",+DFN,+ASSTYPE,+ACTDT,+SCTM,0))
 S INACTDT=$P($G(^SCPT(404.42,+SCPTTMA,0)),U,9)
 S RETVAL=$S('INACTDT:+SCTM,(INACTDT'<DATE):+SCTM,1:0)
 S RETVAL=$S('$G(RETVAL):"",1:RETVAL_U_$P($G(^SCTM(404.51,+RETVAL,0)),U,1))
 Q RETVAL
 ;
PCPRACT(DFN,DATE,PCROLE) ; Get PC Practitioner
 ; DFN - Pointer to Patient file 
 ; DATE - Date of interest 
 ; PCROLE - Practitioner Position where '1' = PC provider
 ;                                      '2' = PC attending 
 ;                                      '3' = PC associate provider
 ; Returned: Pointer to file #200 ^ External value of name
 ;           or, if error or none defined, returns a 0 or null
 ;
 N RETVAL,SCOK,SCTP,ACTDT,TPLP,TPDALP,INACTDT,PCAP
 S RETVAL=0
 Q:'$G(DFN) RETVAL
 S DATE=$G(DATE,DT),PCROLE=$G(PCROLE,1)
 ;
 ; Returns pointer to file #404.57 if it exists, 0 if not
 S SCOK=1,SCTP=0
 S ACTDT=+$O(^SCPT(404.43,"APCPOS",+DFN,+PCROLE,(DATE+.000001)),-1)
 F TPLP=0:0 S TPLP=$O(^SCPT(404.43,"APCPOS",+DFN,+PCROLE,+ACTDT,TPLP)) Q:TPLP=""!(SCTP=-1)  D
 .F TPDALP=0:0 S TPDALP=$O(^SCPT(404.43,"APCPOS",+DFN,+PCROLE,+ACTDT,TPLP,TPDALP)) Q:TPDALP=""  D  Q:SCTP=-1
 ..S INACTDT=$P($G(^SCPT(404.43,+TPDALP,0)),U,4)
 ..;
 ..; Error if it's already an active date
 ..I 'INACTDT S SCTP=$S(SCTP>0:-1,1:TPLP) Q
 ..I INACTDT'<DATE S SCTP=$S(SCTP>0:-1,1:TPLP)
 S RETVAL=+SCTP
 S RETVAL=$S('$G(RETVAL):"",RETVAL=-1:"",1:RETVAL_U_$P($G(^SCTM(404.57,+RETVAL,0)),U,1))
 ;
 S SCTP=+RETVAL,PCAP=+$G(PCROLE,1),PCAP=$S(PCAP=0:1,PCAP>3:1,1:PCAP)
 S PCROLE=$S(PCROLE=0:1,PCROLE>2:1,1:PCROLE)
 S RETVAL=$S('SCTP:"",1:$$PCPROV^SCAPMCU3(SCTP,.DATE,PCAP))
 Q RETVAL
 ;
DATE ; Get Begin Date and End Date
 S:$D(%DT(0)) SDT0=%DT(0) S:$D(SDT00) %DT=SDT00 S POP=0 K BEGDATE,ENDDATE W !!,"**** Date Range Selection ****"
 W ! S %DT=$S($D(SDT00):SDT00,1:"AE"),%DT("A")="   Beginning DATE : " D ^%DT S:Y<0 POP=1 G:Y<0 EX S (BEGDATE,SDBD)=Y
 W ! S %DT="AE",%DT("A")="   Ending    DATE : " D ^%DT K %DT S:Y<0 POP=1 G:Y<0 EX G:Y<SDBD HELP W ! S (ENDDATE,SDED)=Y
EX K SDT0,SDT00 Q
HELP W "??",!?5,"Ending date must not be before beginning date" S:$D(SDT0) %DT(0)=SDT0 G DATE
 ;
TDATA(DFN,VALMCNT,SDATE,SDPRT,SDCOL) ;
 ;Team information - gather, format and optionally print.
 ;
 ; Input: DFN=patient ifn
 ;        VALMCNT=variable to return number of lines (pass by reference)
 ;        SDATE=effective date (optional)
 ;        SDPRT=print flag, 'P' for PC info only, 'A' for all (optional)
 ;        SDCOL=column to print in conjunction with SDPRT flag (optional)
 ;
 Q:DFN'>0
 N SDI,SDATE,SDLIST,SDX,SDLN,SDY,SDPH,SDTEAM,SDPTA,SDII,SDIII,SDZ
 N SDTM,SDTMN,SDPO,SDPON,SDPR,SDPRN,PAGER,PHONE
 ;
 F SDI="SDPLIST","SDTEMP" K ^TMP(SDI,$J)
 S SDCOL=+$G(SDCOL),SDATE=$G(SDATE) S:SDATE<1 SDATE=DT
 F SDI="BEGIN","END" S SDATE(SDI)=SDATE
 S SDATE="SDATE",SDLIST="^TMP(""SDPLIST"",$J)",SDLN=2
 S SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDLIST)
 ;
 ;PC Team
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"PCTM",SDI)) Q:'SDI  D
 .S SDX=$G(^TMP("SDPLIST",$J,DFN,"PCTM",SDI)) Q:'$L(SDX)
 .S SDY="" D S1("Primary Care Team",$P(SDX,U,2))
 .S SDPH=$P($G(^SCTM(404.51,+SDX,0)),U,2) D:$L(SDPH) S2("Phone",SDPH)
 .S:$P(SDX,U,3) SDPTA($P(SDX,U,3))=""
 .D STL(SDY)
 .Q
 ;
 ;PCP
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"PCPR",SDI)) Q:'SDI  D
 .S SDX=$G(^TMP("SDPLIST",$J,DFN,"PCPR",SDI)) Q:'$L(SDX)
 .S SDY="" D S1("PC Provider",$P(SDX,U,2))
 .D S2("Position",$P(SDX,U,4)),STL(SDY),PHONE($P(SDX,U,1))
 .S SDY="" D S3("Pager",PAGER),S4("Phone",PHONE),STL(SDY)
 .Q
 ;
 ;AP
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"PCAP",SDI)) Q:'SDI  D
 .S SDX=$G(^TMP("SDPLIST",$J,DFN,"PCAP",SDI)) Q:'$L(SDX)
 .S SDY="" D S1("Associate Provider",$P(SDX,U,2)),S2("Position",$P(SDX,U,4)),STL(SDY),PHONE($P(SDX,U,1))
 .S SDY="" D S3("Pager",PAGER),S4("Phone",PHONE),STL(SDY)
 .Q
 ;
 I $G(SDPRT)="P" D PRT G TDQ
 S SDII=0 F  S SDII=$O(^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)) Q:'SDII  D
 .S SDX=^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)
 .Q:'$D(SDPTA(+$P(SDX,U,11)))
 .S SDIII=0 F  S SDIII=$O(^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)) Q:'SDIII  D
 ..S SDZ=^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)
 ..Q:$P(SDZ,U,3)'=+SDX
 ..S SDY="" D S1("Non-PC Provider",$P(SDZ,U,2)),S2("Position",$P(SDZ,U,4)),STL(SDY)
 ;
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"NPCTM",SDI)) Q:'SDI  D
 .S SDX=^TMP("SDPLIST",$J,DFN,"NPCTM",SDI)
 .S SDTEAM($P(SDX,U,2),+SDX)="",SDPTA=$P(SDX,U,3) Q:'SDPTA  D
 ..S SDII=0 F  S SDII=$O(^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)) Q:'SDII  D
 ...S SDY=^TMP("SDPLIST",$J,DFN,"NPCPOS",SDII)
 ...Q:$P(SDY,U,11)'=SDPTA
 ...S SDTEAM($P(SDX,U,2),+SDX,$P(SDY,U,2),+SDY)="",SDIII=0
 ...F  S SDIII=$O(^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)) Q:'SDIII  D
 ....S SDZ=^TMP("SDPLIST",$J,DFN,"NPCPR",SDIII)
 ....Q:$P(SDZ,U,3)'=+SDY
 ....S SDTEAM($P(SDX,U,2),+SDX,$P(SDY,U,2),+SDY,$P(SDZ,U,2),+SDZ)=""
 ;
 S SDTM="" F  S SDTM=$O(SDTEAM(SDTM)) Q:SDTM=""  D
 .S SDTMN=0 F  S SDTMN=$O(SDTEAM(SDTM,SDTMN)) Q:'SDTMN  D
 ..I SDLN>0 D STL("")
 ..S SDY="" D S1("Non-PC Team",SDTM)
 ..S SDPH=$P($G(^SCTM(404.51,+SDTMN,0)),U,2) D:$L(SDPH) S2("Phone",SDPH),STL(SDY)
 ..S SDPO="" F  S SDPO=$O(SDTEAM(SDTM,SDTMN,SDPO)) Q:SDPO=""  S SDPON=0 D
 ...F  S SDPON=$O(SDTEAM(SDTM,SDTMN,SDPO,SDPON)) Q:'SDPON  D
 ....I $O(SDTEAM(SDTM,SDTMN,SDPO,SDPON,""))="" S SDY="" D S1("Non-PC Provider",""),S2("Position",SDPO),STL(SDY) Q
 ....S SDPR="" F  S SDPR=$O(SDTEAM(SDTM,SDTMN,SDPO,SDPON,SDPR)) Q:SDPR=""  D
 .....S SDPRN=0 F  S SDPRN=$O(SDTEAM(SDTM,SDTMN,SDPO,SDPON,SDPR,SDPRN)) Q:'SDPRN  D
 ......S SDY="" D S1("Non-PC Provider",SDPR),S2("Position",SDPO),STL(SDY),PHONE(SDPRN)
 ......S SDY="" D S3("Pager",PAGER),S4("Phone",PHONE),STL(SDY)
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
 ; Input: SDT=subtitle, SDX=data value
 S SDY=$J(SDT,18)_": "_$E(SDX,1,28) Q
 ;
S2(SDT,SDX) ;Set second piece of string
 ; Input: SDT=subtitle, SDX=data value
 I $L($G(SDPRT)),SDCOL>0 Q
 S $E(SDY,53)=$J(SDT,8)_": "_$E(SDX,1,18) Q
 ;
S3(SDT,SDX) ;Set first piece of string that displays phone numbers
 ; Input: SDT=subtitle, SDX=data value
 S SDY=$J(SDT,30)_": "_$E(SDX,1,20) Q
 ;
S4(SDT,SDX) ;Set second piece of string that displays phone numbers
 ;Input: SDT=subtitle, SDX=data value
 I $L($G(SDPRT)),SDCOL>0 Q
 S $E(SDY,56)=$J(SDT,4)_": "_$E(SDX,1,20) Q
 ;
PHONE(IEN) ;Get provider's pager and phone numbers.
 ;Return: PAGER = Pager number
 ;        PHONE = Phone number
 NEW LIST
 S (PAGER,PHONE)=""
 Q:'$G(IEN)
 Q:'$$NEWPERSN^SCMCGU(IEN,"LIST")
 S PAGER=$P(LIST(IEN),U,5),PHONE=$P(LIST(IEN),U,2) Q
 ;
STL(SDY) ; Set text line
 ; Input: SDY=string
 S SDLN=SDLN+1,^TMP("SDTEMP",$J,SDLN)=SDY Q
 ;
PRT ; Write assignment information
 N SDI S SDI=0
 F  S SDI=$O(^TMP("SDTEMP",$J,SDI)) Q:'SDI  D
 .W !?(SDCOL),^TMP("SDTEMP",$J,SDI) Q
 Q
 ;
PCLINE(DFN,SDATE) ;PC provider, associate and team in a single line
 ; Input:  DFN=patient ifn
 ;         SDATE=effective date (optional)
 ; Output: PC provider, associate and team formatted as 80 character
 ;         line, or "" if none
 ;
 N SDLIST,SDI,SDX,SDY,SDZ,SDL,SDC,SDTL
 Q:'DFN ""  S:$G(SDATE)<1 SDATE=DT S SDLIST="^TMP(""SDPLIST"",$J)"
 F SDI="BEGIN","END" S SDATE(SDI)=SDATE
 S SDATE="SDATE",SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDLIST)
 S SDY="PC Prov: ^Assoc. Prov: ^Team: ",SDL=48,SDC=3,SDTL=0
 S SDX(1)=$$PCL("PCPR"),SDX(2)=$$PCL("PCAP"),SDX(3)=$$PCL("PCTM")
 K ^TMP("SDPLIST",$J,DFN)
 F SDI=1,2,3 S SDZ($L(SDX(SDI)),SDI)=""
 S SDI="" F  S SDI=$O(SDZ(SDI)) Q:SDI=""  D
 .S SDII=0 F  S SDII=$O(SDZ(SDI,SDII)) Q:'SDII  D
 ..I 'SDI S SDC=SDC-1 Q
 ..I SDI<(SDL\SDC) S SDX(SDII)=$P(SDY,U,SDII)_SDX(SDII),SDL=SDL-SDI,SDC=SDC-1 Q
 ..S SDX(SDII)=$P(SDY,U,SDII)_$E(SDX(SDII),1,(SDL\SDC))
 ;
 F SDI=1,2,3 S SDTL=SDTL+$L(SDX(SDI))
 Q:SDTL=0 ""
 S SDX=SDX(1),$E(SDX,($L(SDX)+1+(80-SDTL\2)))=SDX(2),$E(SDX,81-$L(SDX(3)))=SDX(3)
 Q SDX
 ;
PCL(SDSUB) ; Get name value
 ; Input: SDSUB=node from GETALL^SCAPMCA
 N SDN S SDN=+$G(^TMP("SDPLIST",$J,DFN,"PCPOS",0))
 Q:SDN=0 ""
 Q:SDN>1 "[ambiguous data]"
 S SDN=+$G(^TMP("SDPLIST",$J,DFN,SDSUB,0))
 Q:SDN=0 ""
 Q:SDN>1 "[ambiguous data]"
 Q $P($G(^TMP("SDPLIST",$J,DFN,SDSUB,1)),U,2)
 ;
LAST() ; Output - the latest date, beginning day or -100 days
 ; the APPOINTMENT STATUS UPDATE LOG was updated
 N SDI,LAST
 F SDI=0:1:100 S X1=DT,X2=-SDI D C^%DTC S LAST=$O(^SDD(409.65,"B",X,0)) S LAST1=$P($G(^SDD(409.65,+LAST,0)),U,5) Q:LAST1
 Q LAST
 ;
 ;
 Q
