DGMFR13 ;DAL/JCH - NDS DEMOGRAPHICS MASTER RELIGION ASSOCIATIONS REPORT ;15-AUG-2017
 ;;5.3;Registration;**933**;Aug 13, 1993;Build 44
 ;
 ; Available at Master File Reports [DGMF RMAIN] option, at the following menu path:
 ;    Supervisor ADT Menu [DG SUPERVISOR MENU]
 ;      ADT System Definition Menu [DG SYSTEM DEFINITION MENU]
 ;        Master File Menu [DGMF MNU]
 ;          Master File Reports [DGMF RMAIN]
 Q
 ;
EN ; MMR Report Entry point
 N DGOUT
 S DGOUT=0
 F  Q:$G(DGOUT)  D
 .D MAIN Q:DGOUT
 .N DIR W !!
 .S DIR(0)="Y",DIR("B")="Y",DIR("A")="Run report again" D ^DIR
 .S:X'="Y" DGOUT=1
 Q
 ;
MAIN ; Driver loop
 N DGSUM,DGMUA,DGSMR,DGOUTP
 S DGSMR=0
 ;
 D INFO
 ; Select (M)apped, (U)nmapped, or (A)ll entries from Religion (#13) file.
 D MUA(.DGMUA) I '$D(DGMUA)!$G(DGOUT) S DGOUT=1 Q
 S DGSUM=$$SUMMARY I 'DGSUM Q
 ;
 ; Select output format
 S DGOUTP=$$OUT I DGSMR Q
 ;
 ; Select device
 I $$SELDEV()!DGSMR Q
 ;
 I DGOUTP="R" W !!,"<*> please wait <*>"
 U IO D DQ
 Q
 ;
DQ ;  report (queue) starts here
 N DGMRI,DGMMRI,DGMR0,DGMMR0
 ;
 K ^TMP($J,"DGMFR13")
 ;  build list of religions types
 S DGMRI=0 F  S DGMRI=$O(^DIC(13,DGMRI)) Q:'DGMRI  D
 .S DGMR0=$G(^DIC(13,DGMRI,0))
 .S DGMMRI=+$G(^DIC(13,DGMRI,"MASTER"))
 .I $G(DGMUA)="U",$G(DGMMRI) Q
 .I $G(DGMUA)="M",'$G(DGMMRI) Q
 .S DGMMR0=$S($G(DGMMRI):$G(^DGMR(13.99,+DGMMRI,0)),1:"Not Mapped")
 .I DGMMRI S $P(DGMMR0,"^",4)=DGMMRI
 .S ^TMP($J,"DGMFR13",DGMR0,DGMRI,"MR")=$G(DGMR0)
 .S ^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE")=$G(DGMMR0)
 ;
 D PRINT
 ;
 D ^%ZISC
 K ^TMP($J,"DGMFR13")
 Q
 ;
PRINT ; Print output
 N MAXCNT,DGSMR,DGPGCNT,DGHDR,CRT,DGMR0,DGDELHD
 I IOST["C-" S MAXCNT=IOSL-10,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 I DGSUM=1 S MAXCNT=MAXCNT+5
 S DGPGCNT=0,DGSMR=0
 ;
 I '$D(^TMP($J,"DGMFR13")) D HEADER W !!!?5,"No Data Found" Q
 ;
 S DGMR0="" F  S DGMR0=$O(^TMP($J,"DGMFR13",DGMR0)) Q:DGMR0=""  D PRINT2(DGMR0)
 Q
 ;
PRINT2(DGMR0) ; Get details
 N DGMRI
 S DGMRI=0 F  S DGMRI=$O(^TMP($J,"DGMFR13",DGMR0,DGMRI)) Q:'DGMRI!DGSMR  D
 .N DGMMR0,DGCT,DGCTS,DGCTX,DGMRST,DGMRCOD
 .N DGMTST,DGMTED,DGMMRI,DGMTEDI,DGMPAR,DGMPARX
 .N DGMREPL,DGMREPX,DGMV0
 .;
 .I $G(DGOUTP)="E" D DELIM(DGMR0,DGMRI) Q
 .;
 .I ($Y+1>MAXCNT)!'DGPGCNT D HEADER Q:DGSMR
 .S DGMR0=$G(^TMP($J,"DGMFR13",DGMR0,DGMRI,"MR"))
 .S DGMRST=+$G(^TMP($J,"DGMFR13",DGMR0,DGMRI,"STATUS")),DGMRST=$S(DGMRST:"INACTIVE",1:"ACTIVE")
 .D PRINMR(DGMRI)
 .;
 .Q:'DGMMRI
 .I $G(DGSUM)=2 D
 ..S DGMTED=$$NOW^XLFDT,DGMTED=$O(^DGMR(13.99,DGMMRI,"TERMSTATUS","B",DGMTED),-1)
 ..I DGMTED D  ; This should always be true, if data came from STS MFS process
 ...S DGMTEDI="",DGMTEDI=$O(^DGMR(13.99,DGMMRI,"TERMSTATUS","B",DGMTED,DGMTEDI))
 ...S DGMTST=$P(^DGMR(13.99,DGMMRI,"TERMSTATUS",DGMTEDI,0),"^",2)
 ...W ?30," Status: ",$S(DGMTST:"ACTIVE",1:"INACTIVE")
 ..S DGMV0=$G(^DGMR(13.99,DGMMRI,"VUID"))
 ..W !?3,"VUID: ",$P(DGMV0,"^")
 Q
 ;
MUA(DGMUA) ; Select (M)apped, (U)nmapped, or(A)ll - entries from 13 mapped to 13.99
 N DIR,DIRUT,Y
 W ! S DIR(0)="SAO^M:(M)apped;U:(U)nmapped;A:(A)ll"
 S DIR("?")="Enter ^ to exit"
 S DIR("A",1)="Run the report for"
 S DIR("A")="(M)apped, (U)nmapped, or (A)ll Religion entries: ",DIR("B")="A" D ^DIR
 I $D(DIRUT) S DGOUT=1 Q
 S DGMUA=Y
 Q
 ;
SUMMARY() ;  ask to print detailed or summary report
 N DIR,DIRUT,X,Y
 S DIR(0)="SOA^D:Detailed;S:Summary;",DIR("B")="Summary"
 S DIR("A")="Type of report to print: "
 W ! D ^DIR
 I $D(DIRUT) S DGSMR=1 Q 0
 Q $S(Y="S":1,Y="D":2,1:0)
 ;
OUT() ; select Excel or Report format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S DGSMR=1 Q ""
 Q Y
 ;
DELIM(DGMR0,DGMRI)  ; Print output in "^" delimited format
 ; Print data in (E)xcel format, e.g., "data^data^data"
 I '$G(DGDELHD) S DGDELHD=1 D
 .I $G(DGSUM)=1 W !,"VA Religion^Mapped/Not Mapped^Master Religion Name"
 .I $G(DGSUM)=2 W !,"VA Religion^VA Religion Code^Mapped/Not Mapped^Master Religion Name^Master Religion Code^Master Religion Status^VUID"
 W !,$P(DGMR0,"^")
 I $G(DGSUM)=2 W "^",$P(DGMR0,"^",4)
 S DGMMR0=$G(^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE"))
 S DGMMRI=+$P(DGMMR0,"^",4)
 W "^",$S(DGMMRI:"MAPPED",1:"NOT MAPPED")
 Q:'DGMMRI
 W "^",$P(^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE"),"^")
 I $G(DGSUM)=2 D
 .W "^",$P(^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE"),"^",2)
 .S DGMTED=$$NOW^XLFDT,DGMTED=$O(^DGMR(13.99,DGMMRI,"TERMSTATUS","B",DGMTED),-1)
 .I $G(DGMTED) D
 ..S DGMTEDI="",DGMTEDI=$O(^DGMR(13.99,DGMMRI,"TERMSTATUS","B",DGMTED,DGMTEDI))
 ..S DGMTST=$P(^DGMR(13.99,DGMMRI,"TERMSTATUS",DGMTEDI,0),"^",2)
 ..W "^",$S(DGMTST:"ACTIVE",1:"INACTIVE")
 .S DGMV0=$G(^DGMR(13.99,DGMMRI,"VUID"))
 .W "^",$P(DGMV0,"^")
 Q
 ;
SELDEV()  ; Prompt for output device, return 1 if queued
 I DGOUTP="E" D
 .N DIR,X,Y
 .S DIR("A",1)=""
 .S DIR("A",2)="     ************************************************************"
 .S DIR("A",3)="     **  You selected a Delimited report. Please verify you    **"
 .S DIR("A",4)="     **  you have turned logging on to capture the output.     **"
 .S DIR("A",5)="     **                                                        **"
 .S DIR("A",6)="     **  To avoid undesired wrapping, enter '0;199;999' at     **"
 .S DIR("A",7)="     **  the 'DEVICE:' prompt. The Terminal Session display    **"
 .S DIR("A",8)="     **  may need to be set to 199 columns.                    **"
 .S DIR("A",9)="     ************************************************************"
 .S DIR("A",10)=""
 .S DIR("A",11)="",DIR("A",12)=""
 .S DIR("A")=" Press return to continue"
 .S DIR(0)="EA" D ^DIR W !
 ;
 N DGDONE
 W !,"You may queue this report to print at a later time.",!
 F  Q:$G(DGSMR)!$G(DGDONE)  D
 .K %ZIS,IOP,POP,ZTSK N I S DGION=$I,%ZIS="QM"
 .D ^%ZIS K %ZIS
 .I POP S IOP=DGION D ^%ZIS K IOP,DGION D  Q
 ..N DIR,X,Y
 ..S DIR(0)="YA",DIR("A",1)="  ** No Device Selected **",DIR("A")="Select a different device? (Y/N) " D ^DIR
 ..S:'Y DGSMR=1
 .S DGDONE=1
 I $D(IO("Q")) D  Q 1
 .N ZTDESC,ZTSAVE,ZTRTN
 .S ZTDESC="Religion to Master Religion Mapping Report",ZTRTN="DQ^DGMFR13"
 .S ZTSAVE("DATE*")="",ZTSAVE("DG*")="",ZTSAVE("ZTREQ")="@"
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print!" K ZTSK
 Q:$G(DGSMR) -1
 Q 0
 ;
HEADER ; page break and report header information
 N DGHDR,DGTAB,DGSPACE
 S DGSMR=0
 I CRT,DGPGCNT>0,'$D(ZTQUEUED) D  Q:DGSMR
 .N DIR,LIN
 .I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 .W !
 .S DIR(0)="E" D ^DIR K DIR
 .I 'Y S DGSMR=1 Q
 S DGPGCNT=DGPGCNT+1
 W @IOF,!
 S $P(DGSPACE," ",132)=""
 S DGHDR=" Religion to Master Religion Report     "
 S DGHDR=DGHDR_"Page: "_DGPGCNT,DGTAB=132-$L(DGHDR)-1
 W ?DGTAB,DGHDR
 Q
 ;
PRINMR(DGMRI)  ; Print Religion file (#13) entry
 N DGCT2
 W !!,"VA Religion: ",$P(DGMR0,"^")
 I $G(DGSUM)=2 D
 .W !,"VA Religion Code: ",$P(DGMR0,"^",4)
 S DGMMR0=$G(^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE"))
 S DGMMRI=+$P(DGMMR0,"^",4)
 W !,"Mapped to Master Religion: ",$S(DGMMRI:"YES",1:"NO")
 Q:'DGMMRI
 W !?3,"Master Religion Name: ",$P(^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE"),"^")
 I $G(DGSUM)=2 W !?3,"Master Code: ",$P(^TMP($J,"DGMFR13",DGMR0,DGMRI,"MMRE"),"^",2)
 Q
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="  This report prints Religions from the RELIGION"
 S MSG(2)="  file (#13), and each Religion' relationship"
 S MSG(3)="  to the Master Religion (#13.99) file."
 S MSG(4)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
