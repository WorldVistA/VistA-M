SDMHAD ;MAF/ALB - MENTAL HEALTH AD HOC NO SHOW REPORT ; JULY 14, 2010
 ;;5.3;Scheduling;**578**;Aug 13, 1993;Build 32
 ;
EN ;entry point for the manual generation of the No Show Report
 N SDBEG,SDEND,VAUTD,Y,SDUP,SDXFLG,SDTL,SDALL,SDDAT,Y,X,SDDAT,VADAT,ZTRTN,ZTSAVE,VADATE,%ZIS,SDALL
 I '$$RANGE G QUIT
 I '$$DIV G QUIT
SORT R !,"Sort report by (M)ental Health Clinic Quick List,(C)linic or (S)top Code: M//",X:DTIME G:X["^"!('$T) QUIT S X=$S(X="":"M",1:$E(X,1))
 I "CMScms"'[X W @IOF D  G SORT
 .W "Enter: 'M' to run the report using the face-to-face Mental Health clinics",!,?7,"defined in the 'VA-MH NO SHOW APPT CLINICS LL' Reminder Location List",!,?7,"- with no additional prompts to refine the list of Mental Health clinics."
 . W !,"Enter: 'C' to run the report by clinics which will then prompt",!,?7,"to refine the list of clinics to use."
 . W !,"Enter: 'S' to run the report by stop codes which will then prompt",!,?7,"to refine the list of stop codes to use.",!
 .Q
 ;I "CMScms"'[X W !,?10,"Enter:  ","'C' for clinic",!,?18,"'M' for Mental Health Clinics Quick List",!,?18,"'S' for stop codes" G SORT
 S SDTL=$S($G(X)="C":"CLIN",$G(X)="c":"CLIN",$G(X)="S":"STOP",$G(X)="s":"STOP",1:"MEN")
 I SDTL="MEN" S Y=0 S SDALL="M" D LIST Q:Y=1
 D @(SDTL) G:Y=-1 QUIT
FUTNUM N SDFUTNUM
 R !,"Select Number of days to List Future Appointments: 30//",X:DTIME G:X["^"!('$T) QUIT S X=$S(X="":"30",1:X) S SDFUTNUM=X
 I X'?.N!(X=0)!(X>90) W !!,?10,"Enter a number of days from 1 to 90. Future scheduled appointments",!,?10,"for the patients will list that number of days in the future",!,?10,"on the No Show report.",! G FUTNUM
 ;S SDFUTNUM=X
 W !!,*7,"This output requires 80 column output",!
 D NOW^%DTC S Y=$E(%,1,12) S SDDAT=$$FMTE^XLFDT(Y,"5")
 S IOM=80 S %ZIS="QM",%ZIS("A")="Select Device: ",%ZIS("B")="" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTRTN="START^SDMHAD",ZTSAVE("SD*")="",ZTSAVE("VA*")="" D ^%ZTLOAD K IO("Q"),ZTSK Q
 ;
START ;
 I $E(IOST)="C" D WAIT^DICD I $D(SDXFLG) D
 .W !!,?10,"This report option generates a mail message containing the"
 .W !,?10,"High Risk Mental Health No Show Nightly Report which is sent"
 .W !,?10,"only to individuals in the SD MH NO SHOW NOTIFICATION mailgroup.",!
 N SDDIV,SDPAG,SDCL,SDSC,SDRLL,SDPAG,NAMSPC,NAMSPC1,SDSTOP,VAUTRR,SDLINE,Y,TOTAL,SDPAT
 N X S X="DGPFAPIH" X ^%ZOSF("TEST") S X="" I '$T D  Q
 .I '$D(SDXFLG) W !!,"Patch DG*5.3*836 needs to be installed - ICR 4903.",!,"Routines required to run report. Aborting!",! Q
 .N SDX S SDX=""
 .S SDX=$$SETSTR^SDMHNS1("Patch DG*5.3*836 needs to be installed - ICR 4903.",X,1,80) D SET1^SDMHNS1(SDX)
 .S SDX="" S SDX=$$SETSTR^SDMHNS1("Routines required to run report. Report Aborted!",X,1,80) D SET1^SDMHNS1(SDX)
 .S SDX=""
 S Y=0 D LIST Q:Y=1
 S NAMSPC=$$NAMSPC
 S NAMSPC1=$$NAMSPC1
 K ^TMP(NAMSPC),^TMP(NAMSPC1)
 S (SDPAG,SDCL,SDSC,SDRLL)=0
 I $D(SDXFLG),SDXFLG=1 S VAUTCL=1
 I $D(SDXFLG) D PXRMD
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
PROCESS ;find patients in date range that had a no show appt for a MH clinic.
 N SDIV,SDC,SDR,SDS,SDHFL,SDUP,SDMHFLG
 S (SDIV,SDC,SDR,SDS,SDUP)=0
 S SDMHFLG=$$GET^XPAR("PKG.REGISTRATION","DGPF SUICIDE FLAG",1,"E")
 S SDMHFLG=$$GETFLAG^DGPFAPIU(SDMHFLG)
 F SDIV=0:0 S SDIV=$O(^TMP(NAMSPC,$J,SDIV)) Q:SDIV=""!(SDUP)  F SDC=SDC:0 S SDC=$O(^TMP(NAMSPC,$J,SDIV,SDC)) Q:SDC=""!(SDUP)  F SDS=SDS:0 S SDS=$O(^TMP(NAMSPC,$J,SDIV,SDC,SDS)) Q:SDS=""!(SDUP)  D
 .I SDTL="MEN" S SDR=$P($G(^TMP(NAMSPC,$J,SDIV,SDC,SDS)),"^",4)
 .N SDDT,SDNUM,SDNUM1,DFN,SDSTAT,ACT,SDRR
 .S (SDDT,SDNUM,SDNUM1,DFN,SDSTAT)=0
 .F SDDT=SDBEG:0 S SDDT=$O(^SC(SDC,"S",SDDT)) Q:'SDDT!(SDDT>SDEND)!(SDUP)  F SDNUM=0:0 S SDNUM=$O(^SC(SDC,"S",SDDT,SDNUM)) Q:'SDNUM!(SDUP)  F SDNUM1=0:0 S SDNUM1=$O(^SC(SDC,"S",SDDT,SDNUM,SDNUM1)) Q:'SDNUM1!(SDUP)  D
 ..Q:'$D(^SC(SDC,"S",SDDT,SDNUM,SDNUM1,0))
 ..S DFN=$P($G(^SC(SDC,"S",SDDT,SDNUM,SDNUM1,0)),"^",1) Q:$D(^SC(SDC,"S",SDDT,SDNUM,SDNUM1,"C"))  I $D(^DPT(DFN,0)),$D(^DPT(DFN,"S",SDDT)) S SDSTAT=$P($G(^DPT(DFN,"S",SDDT,0)),"^",2) I $$GETINF^DGPFAPIH(DFN,SDMHFLG,SDDT,SDDT,"ACT") D  Q:SDUP
 ...N PATNM,SDCLNM,SDDIVNM,SDSCNM,SDZERO
 ...;S SDXZERO=^DPT(DFN,"S",SDDT,0)
 ...;S SDDA=$$FIND^SDAM2(DFN,SDDT,SDC)
 ...;S SDSTAT=$$STATUS^SDAM1(DFN,SDDT,SDNUM,SDXZERO,SDDA)
 ... ;Q:SDSTAT=""
 ... S SDSTAT=$S(SDSTAT="N":"NS",SDSTAT="NT":"NAT",SDSTAT="NA":"NSA",SDSTAT="":"NAT",1:SDSTAT)
 ...;I '$D(SDXFLG) I SDSTAT="" S SDSTAT="NT" I "N^NA"'[SDSTAT Q  ;!(SDSTAT'="NA")
 ...I SDSTAT'["N" Q
 ...S SDDIVNM=$S($P(^DG(40.8,SDIV,0),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^DG(40.8,SDIV,0),"^",1))
 ...S SDCLNM=$S($P($G(^SC(SDC,0)),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^SC(SDC,0),"^",1))
 ...S SDSCNM=$S($P($G(^DIC(40.7,SDS,0)),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^DIC(40.7,SDS,0),"^",1))
 ...S PATNM=$S($P($G(^DPT(DFN,0)),"^",1)="NOT SPECIFIED":"NOT SPECIFIED",1:$P(^DPT(DFN,0),"^",1))
 ...I SDTL="CLIN" S ^TMP(NAMSPC1,$J,SDDIVNM,SDCLNM,PATNM,SDS,SDDT)=DFN_"^"_SDDT_"^"_SDSTAT_"^"_$$PID(DFN)_"^"_SDC_"^"_SDS ;D TOTAL(SDDIVNM,SDCLNM)
 ...I SDTL="STOP" S ^TMP(NAMSPC1,$J,SDDIVNM,SDSCNM,PATNM,SDCLNM,SDDT)=DFN_"^"_SDDT_"^"_SDSTAT_"^"_$$PID(DFN)_"^"_SDC_"^"_SDS
 ...I SDTL="MEN" S SDRR=$P(^PXRMD(810.9,SDR,0),"^",1) S ^TMP(NAMSPC1,$J,SDDIVNM,SDRR,SDCLNM,PATNM,SDDT)=DFN_"^"_SDDT_"^"_SDSTAT_"^"_$$PID(DFN)_"^"_SDC_"^"_SDS
 ...D TOTAL(SDDIVNM,SDCLNM)
BGJ I $D(SDXFLG) D  Q
 .I '$D(^TMP(NAMSPC1,$J)) D HEAD^SDMHNS
 .D ^SDMHNS1 Q
 I '$D(^TMP(NAMSPC1,$J)) G END
 D ^SDMHAD1
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
HEAD ;Heading for the report
 W @IOF
 W "HIGH RISK MENTAL HEALTH NO SHOW ADHOC REPORT BY",?70,"PAGE " S SDPAG=SDPAG+1 W SDPAG,!
 W $S(SDTL="MEN":"MH CLINICS",SDTL="STOP":"STOP CODES",1:"CLINICS")_" for Appointments "_$$FMTE^XLFDT(SDBEG,"2")_"-"_$$FMTE^XLFDT($P(SDEND,".",1),"2"),?56,"Run: "_SDDAT
 I $D(SDTOTPG) W !!,"Totals Page"
 I '$D(SDTOTPG) W !!,"PATIENT",?23,"PT ID",?33,"APPT D/T",?53,"CLINIC",?73,"STATUS"
 W !,$$LINE(""),!
 ;W "*STATUS: NS = No Show      NSA = No Show Auto Rebook     NAT = No Action Taken",!!
HEAD1 I $D(^TMP(NAMSPC1,$J)),'$D(SDTOTPG) D
 . N SDHEAD2
B .I SDTL'="STOP" S SDHEAD2="DIVISION/CLINIC/STOP: "_$E(SDXDIV,1,24)_"/"_$E(SDXCLIN,1,26)_"/"_$E(SDXSTOP,1,4)
 .;I SDTL="CLIN" S SDHEAD2="DIVISION/CLINC/STOP CODE: "_SDXDIV_"/"_SDXCLIN_"/"_SDXSTOP
 .I SDTL="STOP" S SDHEAD2="DIVISION/STOP/CLINIC: "_$E(SDXDIV,1,24)_"/"_$E(SDXSTOPN,1,4)_"/"_$E(SDXCLIN,1,26)
 .;I SDTL="STOP" S SDHEAD2="DIVISION/STOP/CLINIC: "_$E(SDXDIV,1,24)_"/"_$E($P($G(^DIC(40.7,$O(^DIC(40.7,"B",SDXSTOP,0)),0)),"^",2),1,4)_"/"_$E(SDXCLIN,1,26)
 .;S SDHEAD2=$S(SDTL="MEN":"DIVISION/MH CLIN LIST/CLINIC: "_SDXDIV_"/"_SDXREM,SDTL="CLIN":"DIVISION/CLINIC: "_SDXDIV_"/"_SDXCLIN,1:"DIVISION/STOP CODE: "_SDXDIV_"/"_SDXSTOP_"-"_$P($G(^DIC(40.7,$O(^DIC(40.7,"B",SDXSTOP,0)),0)),"^",2)) W !
 .W SDHEAD2,!
 Q
 ;
 ;
RANGE() ;Select Start and End date for report
 W !!,$$LINE(" High Risk Mental Health NO SHOW Adhoc Report")
 Q $$RANGE^SDAMQ(.SDBEG,.SDEND)
 ;
DIV() ;Division selection for multidivisional facility
 D ASK2^SDDIV I Y<0 K VAUTD
 Q $D(VAUTD)>0
 ;
LIST N X I '$D(^PXRMD(810.9,"B","VA-MH NO SHOW APPT CLINICS LL")) D  Q
 .I '$D(SDXFLG) W !!!,"Reminder location List file is not current.",!,"Missing reminder location list 'VA-MH NO SHOW APPT CLINICS LL' in file 810.9.",!,"Report Aborting!",! S Y=1 Q
 .N SDX S SDX="",X=""
 .S SDX=$$SETSTR^SDMHNS1("Reminder location List file is not current.",X,1,80) D SET1^SDMHNS1(SDX)
 .S SDX="",X="" S SDX=$$SETSTR^SDMHNS1("Missing reminder location list 'VA-MH NO SHOW APPT CLINICS LL' in file 810.9.",X,1,80) D SET1^SDMHNS1(SDX)
 .S SDX="",X="" S SDX=$$SETSTR^SDMHNS1("Report Aborted!",X,1,80) D SET1^SDMHNS1(SDX)
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
TOTAL(DIV,CLST) ;INITIALIZE total(DIV,CLIN/STOP)
 I '$D(TOTAL(DIV,CLST)) D
 .N SDCNTT S SDCNTT=0
 .S TOTAL(DIV,CLST)="0^0^0^0^0"
 I $D(TOTAL(DIV,CLST)) D
 .S $P(TOTAL(DIV,CLST),"^",1)=$P($G(TOTAL(DIV,CLST)),"^",1)+1
 .N X S X=$S(SDSTAT="NS":2,SDSTAT="NSA":3,1:4) S $P(TOTAL(DIV,CLST),"^",X)=$P(TOTAL(DIV,CLST),"^",X)+1
 .I '$D(SDPAT(DIV,CLST,DFN)) S SDPAT(DIV,CLST,DFN)="",$P(TOTAL(DIV,CLST),"^",5)=$P(TOTAL(DIV,CLST),"^",5)+1
 Q
 ;
 ;
CLIN ;select clinics
 W !!,"Clinic Selection:",!,?20,"A All clinics",!,?20,"M Mental Health clinics only",!
CL1 R !,"Select: (A)ll clinics  A//",X:DTIME S:X["^"!('$T) Y=-1 Q:Y=-1  S X=$S(X="":"A",1:$E(X)) I "AMam"'[X W !,?6,"Enter : 'A' for All clinics",!,?14,"'M' for Mental Health clinics only" G CL1
 S SDALL=X
 N DIC,K,VAUTVB,VAUTSTR,VAUTNI
 S VAUTVB="VAUTCL",DIC="^SC("
 I SDALL="M" S DIC("S")="N X,K S X=$O(^PXRMD(810.9,""B"",""VA-MH NO SHOW APPT CLINICS LL"",0)) I $D(^SC(+Y,0)) S K=$P(^SC(+Y,0),""^"",7) I $D(^PXRMD(810.9,X,40.7,""B"",+K))"
 S VAUTSTR="Clinic",VAUTNI=2 D FIRST^VAUTOMA S:Y=-1 SDFL=1 Q:$D(SDFL)
 Q
 ;
STOP N SDFL,DIC,K,VAUTVB,VAUTSTR,VAUTNI
 W !!,"Stop Code Selection:",!,?20,"A  All Stop Codes",!,?20,"M  Mental Health Stop Codes only",!
ST1 R !,"Select: (A)ll Stop Codes  A//",X:DTIME S:X["^"!('$T) Y=-1 Q:Y=-1  S X=$S(X="":"A",1:$E(X)) I "AMam"'[X W !,?6,"Enter:  'A' for All Stop Codes",!,?14,"'M' for Mental Health Stop Codes only" G ST1
 S SDALL=X
 S VAUTVB="VAUTSC",DIC="^DIC(40.7,"
 I SDALL="M" S DIC("S")="N X S X=$O(^PXRMD(810.9,""B"",""VA-MH NO SHOW APPT CLINICS LL"",0)) I $D(^PXRMD(810.9,X,40.7,""B"",+Y))"
 S VAUTSTR="Stop codes",VAUTNI=2 D FIRST^VAUTOMA
 Q
STOP1 N SDFL,DIC,K,VAUTVB,VAUTSTR,VAUTNI
 S VAUTVB="VAUTSC",DIC="^DIC(40.7,",DIC("S")="S SDFL=0 D MEN1^SDMHAD I SDFL",VAUTSTR="Stop codes",VAUTNI=2 D FIRST^VAUTOMA
 Q
 ;
MEN S VAUTR=0
MEN1 N X S X=$O(^PXRMD(810.9,"B","VA-MH NO SHOW APPT CLINICS LL",0)) S VAUTR(X)=$P($G(^PXRMD(810.9,X,0)),"^",1)
 I SDTL="STOP" D
 . I $D(^PXRMD(810.9,X,40.7,"B",+Y)) S SDFL=1
 . Q
 Q
 ;
PID(DFN) ; Return PID
 ; INPUT  - DFN
 ; OUTPUT - PID or 'UNKNOWN'
 N VA
 D PID^VADPT6
 Q $S(VA("BID")]"":VA("BID"),1:"UNKNOWN")
 ;
NAMSPC() ; API returns the name space for this patch
 Q "SDNSHOW"
NAMSPC1() ; API returns the name space for this patch
 Q "SDNS"
PXRMD ;Set up Reminder Location List valid Stop Codes for No Show Report
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
QUIT K %DT,DIR,SDTBEG,SDTEND,SDDIV,VAUTD,VAUTCL,VAUTR,VAUTSC,VADAT,VADATE,POP,X,Y
 K ^TMP("SDNSHOW",$J),^TMP("SDNS",$J)
 D CLOSE^DGUTQ Q
