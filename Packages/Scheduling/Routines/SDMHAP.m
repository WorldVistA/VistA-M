SDMHAP ;MAF/ALB - MENTAL HEALTH AD HOC PROACTIVE HIGH RISK REPORT;JULY 14, 2010
 ;;5.3;Scheduling;**588**;Aug 13,1993;Build 53
 ;
EN ;entry point for the manual generation of the Proactive Report
 N SDBEG,SDEND,VAUTD,Y,SDUP,SDXFLG,SDTL,SDALL,SDDAT,Y,X,SDDAT,VADAT,ZTRTN,ZTSAVE,VADATE,%ZIS,%
 I '$$RANGE G QUIT
 I '$$DIV G QUIT
SORT ;sort is by clinic
 S SDTL="CLIN"
 D @(SDTL) G:Y=-1 QUIT
 W !!,*7,"This output requires 80 column output",!
 D NOW^%DTC S Y=$E(%,1,12) S SDDAT=$$FMTE^XLFDT(Y,"5")
 S IOM=80 S %ZIS="QM",%ZIS("A")="Select Device: ",%ZIS("B")="" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTRTN="START^SDMHAP",ZTSAVE("SD*")="",ZTSAVE("VA*")="" D ^%ZTLOAD K IO("Q"),ZTSK Q
 ;
START ;
 I $E(IOST)="C" D WAIT^DICD I $D(SDXFLG) D
 .W !!,?10,"This report option generates a mail message containing the"
 .W !,?10,"High Risk Mental Health Proactive Nightly Report which is sent only"
 .W !,?10,"to individuals in the SD MH NO SHOW NOTIFICATION mailgroup.",!
 N SDDIV,SDPAG,SDCL,SDSC,SDRLL,SDPAG,NAMSPC,NAMSPC1,SDSTOP,VAUTRR,SDLINE,Y,TOTAL,SDPAT
 N X S X="DGPFAPIH" X ^%ZOSF("TEST") S X="" I '$T D  Q
 .I '$D(SDXFLG) W !!,"Patch DG*5.3*836 needs to be installed - ICR 4903.",!,"Routines required to run report. Aborting!",! Q
 .N SDX S SDX=""
 .S SDX=$$SETSTR^SDMHPRO1("Patch DG*5.3*836 needs to be installed - ICR 4903.",X,1,80) D SET1^SDMHPRO1(SDX)
 .S SDX="" S SDX=$$SETSTR^SDMHPRO1("Routines required to run report. Report Aborted!",X,1,80) D SET1^SDMHPRO1(SDX)
 .S SDX=""
 S Y=0 D LIST Q:Y=1
 S NAMSPC=$$NAMSPC
 S NAMSPC1=$$NAMSPC1
 K ^TMP(NAMSPC),^TMP(NAMSPC1)
 S (SDPAG,SDCL,SDSC,SDRLL)=0
 I $D(SDXFLG),SDXFLG=1 S VAUTCL=1
 ;I $D(SDXFLG) D PXRMD
 I $D(SDALL) I SDALL="M" D PXRMD
 I VAUTD=1 D
 .S SDDIV=0 F SDDIV=0:0 S SDDIV=$O(^DG(40.8,SDDIV)) Q:'SDDIV  I $D(^DG(40.8,SDDIV,0)) S VAUTD(SDDIV)=$P(^DG(40.8,SDDIV,0),"^",1)
 I SDTL'="MEN" F SDCL=0:0 S SDCL=$O(^SC(SDCL)) Q:'SDCL  I $D(^SC(SDCL,0)),$P($G(^SC(SDCL,0)),"^",3)="C" D
 .S SDSC=$P($G(^SC(SDCL,0)),"^",7),SDDIV=$S('$P($G(^SC(SDCL,0)),"^",15):"NOT SPECIFIED",1:$P($G(^SC(SDCL,0)),"^",15)) I SDSC D CHK  ;S ^TMP("SDCLST",$J,SDCL,SDSC)=$P(^SC(SDCL,0),"^",1)
 I SDTL="MEN" S SDRLL=$O(^PXRMD(810.9,"B","VA-MH NO SHOW APPT CLINICS LL",0)) D
 .F SDDIV=0:0 S SDDIV=$O(VAUTRR(SDDIV)) Q:'SDDIV  F SDSC=0:0 S SDSC=$O(VAUTRR(SDDIV,SDSC)) Q:'SDSC  F SDCL=0:0 S SDCL=$O(VAUTRR(SDDIV,SDSC,SDCL)) Q:'SDCL  I SDCL D CHK
 S SDLINE=$S($D(^TMP(NAMSPC,$J)):"PROCESS",1:"END")
 D @SDLINE
 G QUIT
 ;
 ;
PROCESS ;find patients in date range that have scheduled appt for a clinic in the date range.
 N SDIV,SDC,SDR,SDS,SDHFL,SDUP,SDMHFLG,SDMHNFLG,SDACT
 S (SDIV,SDC,SDR,SDS,SDUP)=0
 S SDMHFLG=$$GET^XPAR("PKG.REGISTRATION","DGPF SUICIDE FLAG",1,"E")
 S SDMHFLG("L")=$$GETFLAG^DGPFAPIU(SDMHFLG,"L")
 S SDMHNFLG="HIGH RISK FOR SUICIDE"
 S SDMHFLG("N")=$$GETFLAG^DGPFAPIU(SDMHNFLG,"N")
 F SDIV=0:0 S SDIV=$O(^TMP(NAMSPC,$J,SDIV)) Q:SDIV=""!(SDUP)  F SDC=SDC:0 S SDC=$O(^TMP(NAMSPC,$J,SDIV,SDC)) Q:SDC=""!(SDUP)  F SDS=SDS:0 S SDS=$O(^TMP(NAMSPC,$J,SDIV,SDC,SDS)) Q:SDS=""!(SDUP)  D
 .I SDTL="MEN" S SDR=$P($G(^TMP(NAMSPC,$J,SDIV,SDC,SDS)),"^",4)
 .N SDDT,SDNUM,SDNUM1,DFN,SDSTAT,ACT,SDRR
 .S (SDDT,SDNUM,SDNUM1,DFN,SDSTAT)=0
 .F SDDT=SDBEG:0 S SDDT=$O(^SC(SDC,"S",SDDT)) Q:'SDDT!(SDDT>SDEND)!(SDUP)  F SDNUM=0:0 S SDNUM=$O(^SC(SDC,"S",SDDT,SDNUM)) Q:'SDNUM!(SDUP)  F SDNUM1=0:0 S SDNUM1=$O(^SC(SDC,"S",SDDT,SDNUM,SDNUM1)) Q:'SDNUM1!(SDUP)  D
 ..Q:'$D(^SC(SDC,"S",SDDT,SDNUM,SDNUM1,0))
 ..S DFN=$P($G(^SC(SDC,"S",SDDT,SDNUM,SDNUM1,0)),"^",1) Q:'DFN  Q:$D(^SC(SDC,"S",SDDT,SDNUM,SDNUM1,"C"))
 ..;I $D(^DPT(DFN,0)),$D(^DPT(DFN,"S",SDDT)) S SDSTAT=$P($G(^DPT(DFN,"S",SDDT,0)),"^",2) I $$GETINF^DGPFAPIH(DFN,SDMHFLG("L"),SDDT,SDDT,"ACT")!($$GETINF^DGPFAPIH(DFN,SDMHFLG("N"),SDDT,SDDT,"ACT")) D  Q:SDUP
 ..I $D(^DPT(DFN,0)),$D(^DPT(DFN,"S",SDDT)) S SDSTAT=$P($G(^DPT(DFN,"S",SDDT,0)),"^",2) Q:SDSTAT="N"!(SDSTAT="NA")  D ACT I SDACT D  Q:SDUP
 ...N PATNM,SDCLNM,SDDIVNM,SDSCNM,SDZERO
 ...S SDDIVNM=$S($P(^DG(40.8,SDIV,0),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^DG(40.8,SDIV,0),"^",1))
 ...S SDCLNM=$S($P($G(^SC(SDC,0)),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^SC(SDC,0),"^",1))
 ...S SDSCNM=$S($P($G(^DIC(40.7,SDS,0)),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^DIC(40.7,SDS,0),"^",1))
 ...S PATNM=$S($P($G(^DPT(DFN,0)),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^DPT(DFN,0),"^",1))
 ...I SDTL="CLIN" S ^TMP(NAMSPC1,$J,SDDIVNM,PATNM,SDDT,SDCLNM,SDS)=DFN_"^"_SDDT_"^"_SDSTAT_"^"_$E(PATNM,1)_$$PID(DFN)_"^"_SDC_"^"_SDS ;D TOTAL(SDDIVNM,SDCLNM)
 ...I SDTL="STOP" S ^TMP(NAMSPC1,$J,SDDIVNM,SDSCNM,PATNM,SDCLNM,SDDT)=DFN_"^"_SDDT_"^"_SDSTAT_"^"_$E(PATNM,1)_$$PID(DFN)_"^"_SDC_"^"_SDS
 ...I SDTL="MEN" S SDRR=$P(^PXRMD(810.9,SDR,0),"^",1) S ^TMP(NAMSPC1,$J,SDDIVNM,SDRR,SDCLNM,PATNM,SDDT)=DFN_"^"_SDDT_"^"_SDSTAT_"^"_$E(PATNM,1)_$$PID(DFN)_"^"_SDC_"^"_SDS
 ...D TOTAL(SDDIVNM)
BGJ I $D(SDXFLG) D  Q
 .I '$D(^TMP(NAMSPC1,$J)) D HEAD^SDMHPRO
 .D ^SDMHPRO1 Q
 I '$D(^TMP(NAMSPC1,$J)) G END
 D ^SDMHAP1
 Q
CHK ;Check to see if Division/Clinic/Stop have been selected & if  Clinic and Stop code are a valid mental health pair.
 N SDFLG,SDCLNM,SDDIVNM,SDSCNM
 S SDFLG=0
 I $D(VAUTD) D  Q:SDFLG
 . I SDDIV="NOT SPECIFIED" S SDFLG=1 Q
 . I 'VAUTD,'$D(VAUTD(SDDIV)) S SDFLG=1 Q
 I $D(VAUTCL) D  Q:SDFLG
 . I SDCL="NOT SPECIFIED" S SDFLG=1 Q
 . I 'VAUTCL,'$D(VAUTCL(SDCL)) S SDFLG=1 Q
 I $D(VAUTSC) D  Q:SDFLG
 . I SDSC="NOT SPECIFIED" S SDFLG=1 Q
 . I 'VAUTSC,'$D(VAUTSC(SDSC)) S SDFLG=1 Q
 Q:'$D(^DG(40.8,SDDIV,0))
 S SDDIVNM=$S($P($G(^DG(40.8,SDDIV,0)),"^",1)="":"NOT SPECIFIED",1:$P(^DG(40.8,SDDIV,0),"^",1))
 Q:'$D(^SC(SDCL,0))
 S SDCLNM=$S($P($G(^SC(SDCL,0)),"^",1)="":"NOT SPECIFIED",1:$P(^SC(SDCL,0),"^",1))
 Q:'$D(^DIC(40.7,SDSC,0))
 S SDSCNM=$S($P($G(^DIC(40.7,SDSC,0)),"^",1)="":"NOT SPECIFIED",1:$P(^DIC(40.7,SDSC,0),"^",1))
 S ^TMP(NAMSPC,$J,SDDIV,SDCL,SDSC)=SDDIVNM_"^"_SDCLNM_"^"_SDSCNM_"^"_$S(SDRLL="NOT SPECIFIED":"NOT SPECIFIED",1:SDRLL)
 Q
 ;
ACT ;Make sure patient has active patient record flag
 N SDDTNT
 S SDDTNT=$P(SDDT,".",1)
 I $$GETINF^DGPFAPIH(DFN,SDMHFLG("L"),SDDTNT,SDDTNT,"ACT") S SDACT=1 Q
 I $$GETINF^DGPFAPIH(DFN,SDMHFLG("N"),SDDTNT,SDDTNT,"ACT") S SDACT=1 Q  ;For increment 3
 S SDACT=0
 Q
HEAD ;Heading for the report
 W @IOF
 W "HIGH RISK MENTAL HEALTH PROACTIVE ADHOC REPORT BY",?70,"PAGE " S SDPAG=SDPAG+1 W SDPAG,!
 W $S(SDTL="MEN":"MENTAL HEALTH",SDTL="STOP":"STOP CODE",1:"CLINIC")_" for Appointments "_$$FMTE^XLFDT(SDBEG,"2")_"-"_$$FMTE^XLFDT($P(SDEND,".",1),"2"),?56,"Run: "_SDDAT
 I $D(SDTOTPG) W !!,"Totals Page"
 I '$D(SDTOTPG) W !!,"#",?4,"PATIENT",?25,"PT ID",?32,"APPT D/T",?49,"CLINIC"
 W !,$$LINE(""),!
HEAD1 I $D(^TMP(NAMSPC1,$J)),'$D(SDTOTPG) D
 . N SDHEAD2
 .I SDTL'="STOP" S SDHEAD2="DIVISION: "_$E(SDXDIV,1,30)
 .W SDHEAD2,!
 Q
 ;
 ;
RANGE() ;Select Start and End date for report
 W !!,$$LINE(" High Risk Mental Health Proactive Adhoc Report")
 Q $$RANGE1(.SDBEG,.SDEND)
 ;
DIV() ;Division selection for multidivisional facility
 D ASK2^SDDIV I Y<0 K VAUTD
 Q $D(VAUTD)>0
 ;
LIST N X I '$D(^PXRMD(810.9,"B","VA-MH NO SHOW APPT CLINICS LL")) D  Q
 .I '$D(SDXFLG) W !!!,"Reminder location List file is not current.",!,"Missing reminder location list 'VA-MH NO SHOW APPT CLINICS LL' in file 810.9.",!,"Report Aborting!",! S Y=1 Q
 .N SDX S SDX="",X=""
 .S SDX=$$SETSTR^SDMHPRO1("Reminder location List file is not current.",X,1,80) D SET1^SDMHPRO1(SDX)
 .S SDX="",X="" S SDX=$$SETSTR^SDMHPRO1("Missing reminder location list 'VA-MH NO SHOW APPT CLINICS LL' in file 810.9.",X,1,80) D SET1^SDMHPRO1(SDX)
 .S SDX="",X="" S SDX=$$SETSTR^SDMHPRO1("Report Aborted!",X,1,80) D SET1^SDMHPRO1(SDX)
 .S SDX=""
 .S Y=1
LINE(STR) ; Print display prompts
 N X
 S:STR]"" STR=" "_STR_" "
 S $P(X,"*",(IOM/2)-($L(STR)/2))=""
 Q X_STR_X
 ;
LINE1(STR) ; Print display prompts
 N X
 S:STR]"" STR=" "_STR_" "
 S $P(X," ",(IOM/2)-($L(STR)/2))=""
 Q X_STR_X
 ;
 ;
TOTAL(DIV) ;INITIALIZE total(DIV,CLIN/STOP)
 I '$D(TOTAL(DIV)) D
 .N SDCNTT S SDCNTT=0
 .S TOTAL(DIV)="0^0^0^0^0"
 I $D(TOTAL(DIV)) D
 .S $P(TOTAL(DIV),"^",1)=$P($G(TOTAL(DIV)),"^",1)+1
 .N X S X=$S(SDSTAT="NS":2,SDSTAT="NSA":3,1:4) S $P(TOTAL(DIV),"^",X)=$P(TOTAL(DIV),"^",X)+1
 .I '$D(SDPAT(DIV,DFN)) S SDPAT(DIV,DFN)="",$P(TOTAL(DIV),"^",5)=$P(TOTAL(DIV),"^",5)+1
 Q
 ;
 ;
CLIN ;select clinics
 W !!,"Sort the report by:",!,?20,"A  All clinics",!,?20,"M  Mental Health clinics only",!
 R !,"Sort by: (A)ll clinics  A//",X:DTIME S:X["^"!('$T) Y=-1 Q:Y=-1  S X=$S(X="":"A",1:$E(X)) I "AMam"'[X W !,"Enter a 'A' for All clinics or 'M' for Mental Health clinics only" G CLIN
 S SDALL=X
 N DIC,K,VAUTVB,VAUTSTR,VAUTNI
 S VAUTVB="VAUTCL",DIC="^SC("
 I SDALL="M" S DIC("S")="N X,K S X=$O(^PXRMD(810.9,""B"",""VA-MH NO SHOW APPT CLINICS LL"",0)) I $D(^SC(+Y,0)) S K=$P(^SC(+Y,0),""^"",7) I $D(^PXRMD(810.9,X,40.7,""B"",+K))"
 S VAUTSTR="Clinic",VAUTNI=2 D FIRST^VAUTOMA S:Y=-1 SDFL=1 Q:$D(SDFL)
 Q
 ;
PID(DFN) ; Return PID
 ; INPUT  - DFN
 ; OUTPUT - PID or 'UNKNOWN'
 N VA
 D PID^VADPT6
 Q $S(VA("BID")]"":VA("BID"),1:"UNKNOWN")
 ;
RANGE1(SDBEG,SDEND,SDAMETH) ; -- select range
 N SDWITCH,SDT,X1,X2,X
 S (SDBEG,SDEND)=0,SDT=DT
 I $G(SDAMETH)>0 S X1=DT,X2=-1 D C^%DTC S SDT=X
 S DIR("B")=$$FDATE^VALM1(SDT),SDWITCH=$$SWITCH^SDAMU
 S DIR("?",1)="Dates in the past (after "_$$FDATE^VALM1(SDWITCH)_" ) and into the  future can be entered",DIR("?")=" "
 S DIR(0)="DA",DIR("A")="Select Beginning Date: "
 W ! D ^DIR K DIR G RANGEQ:Y'>0 S SDBEG=Y
 S DIR("B")=$$FDATE^VALM1(SDT)
 S DIR(0)="DA",DIR("A")="Select    Ending Date: "
 S DIR("?",1)="Dates between "_$$FDATE^VALM1(SDBEG)_"and into the future can be entered. ",DIR("?")=" "
 D ^DIR K DIR G RANGEQ:Y'>0 S SDEND=Y_".24"
RANGEQ Q SDEND
 ;
NAMSPC() ; API returns the name space for this patch
 Q "SDPRO"
NAMSPC1() ; API returns the name space for this patch
 Q "SDPRO1"
PXRMD ;Set up Reminder Location List valid Stop Codes for Proactive Report
 N SDX,SDY,SDI,SDSFL,SDCFL
 S SDY=0
 S SDX=$O(^PXRMD(810.9,"B","VA-MH NO SHOW APPT CLINICS LL",0)) Q:SDX']""  F  S SDY=$O(^PXRMD(810.9,SDX,40.7,"B",SDY)) Q:SDY']""  D
 .S SDSTOP(+SDY)=""
 .I SDTL="MEN" N SDI S SDI=0 F  S SDI=$O(^SC("AST",+SDY,SDI)) Q:SDI']""  S VAUTRR(+$P($G(^SC(+SDI,0)),"^",15),+SDY,+SDI)=""
 .I $D(VAUTSC),$G(VAUTSC)=1 S VAUTSC(+SDY)=$P($G(^DIC(40.7,+SDY,0)),"^",1) S SDSFL=1
 .I $D(VAUTCL),$G(VAUTCL)=1 N SDI S SDI=0 F  S SDI=$O(^SC("AST",+SDY,SDI)) Q:SDI']""  D 
 ..S VAUTCL(+SDI)=$P($G(^SC(+SDI,0)),"^",1) S SDCFL=1
 I $D(SDSFL) S VAUTSC=0
 I $D(SDCFL) S VAUTCL=0
 Q
END ;NO RECORDS
 D HEAD
 W !!,$$LINE1(">>>>>>  NO RECORDS FOUND <<<<<<")
QUIT K %DT,DIR,SDTBEG,SDTEND,SDDIV,SDFL,SDTOTPG,SDXDIV,SDMHNFLG,VAUTD,VAUTCL,VAUTR,VAUTSC,VADAT,VADATE,POP,X,Y
 K ^TMP("SDPRO",$J),^TMP("SDPRO1",$J)
 D CLOSE^DGUTQ Q
