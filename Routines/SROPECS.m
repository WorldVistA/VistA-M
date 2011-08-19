SROPECS ;BIR/ADM-Ensuring Correct Surgery Compliance Report ; [ 07/03/03  11:39 AM ]
 ;;3.0; Surgery ;**120,126,129**;24 Jun 93
 W @IOF,!,?18,"Ensuring Correct Surgery Compliance Report"
 W !!,?2,"This two-part report includes a summary of the rate of compliance and/or a",!,?2,"list of surgical cases that are non-compliant in documenting the process"
 W !,?2,"for ensuring correct surgery for operations performed by the selected",!,?2,"surgical specialties during the selected date range.",!
 N SRFRTO,SRINSTP,SRORD,SRRPT S (SRORD,SRSOUT,SRSP)=0
ASK W ! K DIR S DIR("A",1)="Print which part of the report?",DIR("A",2)="",DIR("A",3)="1. Compliance Summary Only",DIR("A",4)="2. List of Non-Compliant Cases",DIR("A",5)="3. Both Parts",DIR("A",6)=""
 S DIR("A")="Select Number (1, 2 or 3): ",DIR("B")="3"
 S DIR(0)="NA^1:3:0" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 S SRFLG=Y W "  "_$S(Y=1:"Compliance Summary Only",Y=2:"List of Non-Compliant Cases",1:"Both Parts")
DATE D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
 D SORT G:SRSOUT END
 S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
DEVICE W ! K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the report on which Printer ? ",%ZIS="Q",%ZIS("B")="" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") D  D ^%ZTLOAD S SRSOUT=1 G END
 .S ZTDESC="ENSURING CORRECT SURGERY REPORT",ZTRTN="EN^SROPECS"
 .S (ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRFLG"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRORD"),ZTSAVE("SRSP*"))=""
EN ; entry point when queued
 U IO S SRSOUT=0,(SRHDR,SRPAGE)=1,SRSDT=SDATE-.0001,SRSEDT=EDATE+.9999,Y=SDATE X ^DD("DD") S STARTDT=Y,Y=EDATE X ^DD("DD") S ENDATE=Y
 S SRRPT="ENSURING CORRECT SURGERY",SRFRTO="FROM: "_STARTDT_"  TO: "_ENDATE
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S SRPRINT="REPORT PRINTED: "_Y
 N SR0,SR71,SR72,SR73,SRCIRC,SRHDRL,SRICNE,SRICNO,SRICY,SRICNR,SRTAG,SRTONE,SRTONO,SRTOT,SRTOV,SRVER,SRSCY,SRSCNR,SRSCNO,SRSCNE
 S SRTAG=$S(SRFLG'=1:"LIST OF NON-COMPLIANT CASES",1:"COMPLIANCE SUMMARY")
 I SRFLG'=1 K ^TMP("SRLIST",$J)
 S (SRTOT,SRTOV,SRTONO,SRTONE,SRICY,SRICNO,SRICNR,SRICNE,SRSCY,SRSCNR,SRSCNO,SRSCNE)=0
 F  S SRSDT=$O(^SRF("AC",SRSDT)) Q:'SRSDT!(SRSDT>SRSEDT)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDT,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN),$P($G(^SRF(SRTN,30)),"^")="" D UTIL
 D ^SROPECS1
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W ! K DIR S DIR("A")="Press RETURN to continue  ",DIR(0)="FOA" D ^DIR K DIR
 D ^%ZISC,^SRSKILL K SRTN,^TMP("SRLIST",$J) W @IOF
 Q
UTIL ; process case
 Q:$P($G(^SRF(SRTN,.2)),"^",12)=""!($P($G(^SRF(SRTN,"NON")),"^")="Y")
 S SR0=$G(^SRF(SRTN,0)) S SRSS=$P(SR0,"^",4) S:SRSS="" SRSS="ZZ" I SRORD,'SRSP,'$D(SRSP(SRSS)) Q
 S SRVER=$G(^SRF(SRTN,"VER")) D TOV,IC,MRK S SRTOT=SRTOT+1 Q:SRFLG=1
 I SR71="Y",(SR72="Y"!(SR72="I")),(SR73="Y"!(SR73="M")) Q
 S Y=$S(SRSS="ZZ":"",1:SRSS),C=$P(^DD(130,.04,0),"^",2) D:Y'="" Y^DIQ S SRSS=$S(Y'="":Y,1:"ZZSPECIALTY NOT ENTERED")
 I SRORD S ^TMP("SRLIST",$J,SRSS,SRSDT,SRTN)=$P(SR0,"^")_"^"_SR71_"^"_SR72_"^"_SR73 Q
 S ^TMP("SRLIST",$J,SRSDT,SRTN)=$P(SR0,"^")_"^"_SR71_"^"_SR72_"^"_SRSS_"^"_SR73
 Q
TOV ; process time out verified field
 S SR71=$P(SRVER,"^",3) I SR71="Y" S SRTOV=SRTOV+1 Q
 I SR71="N" S SRTONO=SRTONO+1 Q
 S SRTONE=SRTONE+1
 Q
IC ; process preoperative imaging confirmed field
 S SR72=$P(SRVER,"^",4) I SR72="Y" S SRICY=SRICY+1 Q
 I SR72="I" S SRICNR=SRICNR+1 Q
 I SR72="N" S SRICNO=SRICNO+1 Q
 S SRICNE=SRICNE+1
 Q
MRK ; process mark on surgical site confirmed field
 S SR73=$P(SRVER,"^",5) I SR73="Y" S SRSCY=SRSCY+1 Q
 I SR73="M" S SRSCNR=SRSCNR+1 Q
 I SR73="N" S SRSCNO=SRSCNO+1 Q
 S SRSCNE=SRSCNE+1
 Q
SORT I SRFLG=1 S SRORD=1 D SPEC Q
 W ! S DIR("?",1)="Press the ENTER key to sort the report by surgical specialty or enter NO",DIR("?")="to not sort by surgical specialty."
 S DIR("A")="Print the List of Non-Compliant Cases sorted by Surgical Specialty ? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRORD=Y Q:'Y
SPEC W ! S DIR("?",1)="Enter YES if you would like the report printed for all Surgical Specialties",DIR("?")="or enter NO to select a single specialty."
 S DIR("A")="Print the report for all Surgical Specialties ? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRSP=Y Q:Y
SP W ! S DIR("A")="Print the report for which Specialty ? ",DIR(0)="130,.04A" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRSP(+Y)=+Y
MORE ; asK for more surgical specialties
 W ! S DIR("A")="Select an additional Specialty: ",DIR(0)="130,.04AO" D ^DIR K DIR I $D(DTOUT) S SRSOUT=1 Q
 Q:'+Y  S SRSP(+Y)=+Y G MORE
 Q
