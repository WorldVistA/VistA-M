DGMFR11 ;DAL/JCH - NDS DEMOGRAPHICS MASTER MARITAL STATUS ASSOCIATIONS REPORT ;15-AUG-2017
 ;;5.3;Registration;**933**;Aug 13, 1993;Build 44
 ;
 ; Available at Master File Reports [DGMF RMAIN] option, at the following menu path:
 ;    Supervisor ADT Menu [DG SUPERVISOR MENU]
 ;      ADT System Definition Menu [DG SYSTEM DEFINITION MENU]
 ;        Master File Menu [DGMF MNU]
 ;          Master File Reports [DGMF RMAIN]
 Q
 ;
EN ; MMS Report Entry point
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
 N DGSUM,DGMUA,DGSMS,DGOUTP
 S DGSMS=0
 ;
 D INFO
 ; Select (M)apped, (U)nmapped, or (A)ll entries from Marital Status (#11) file.
 D MUA(.DGMUA) I '$D(DGMUA)!$G(DGOUT) S DGOUT=1 Q
 S DGSUM=$$SUMMARY I 'DGSUM Q
 ;
 ; Select output format
 S DGOUTP=$$OUT I DGSMS Q
 ;
 ; Select device
 I $$SELDEV()!DGSMS Q
 ;
 I DGOUTP="R" W !!,"<*> please wait <*>"
 U IO D DQ
 Q
 ;
DQ ;  report (queue) starts here
 N DGMSI,DGMMSI,DGMS0,DGMMS0
 ;
 K ^TMP($J,"DGMFR11")
 ;  build list of Marital Statuses
 S DGMSI=0 F  S DGMSI=$O(^DIC(11,DGMSI)) Q:'DGMSI  D
 .S DGMS0=$G(^DIC(11,DGMSI,0))
 .S DGMSP02=+$G(^DIC(11,DGMSI,.02))
 .S DGMMSI=+$G(^DIC(11,DGMSI,"MASTER"))
 .I $G(DGMUA)="U",$G(DGMMSI) Q
 .I $G(DGMUA)="M",'$G(DGMMSI) Q
 .S DGMMS0=$S($G(DGMMSI):$G(^DGMMS(11.99,+DGMMSI,0)),1:"Not Mapped")
 .I DGMMSI S $P(DGMMS0,"^",4)=DGMMSI
 .S ^TMP($J,"DGMFR11",DGMS0,DGMSI,"MS")=$G(DGMS0)
 .S ^TMP($J,"DGMFR11",DGMS0,DGMSI,"STATUS")=DGMSP02
 .S ^TMP($J,"DGMFR11",DGMS0,DGMSI,"MMSE")=$G(DGMMS0)
 ;
 D PRINT
 ;
 D ^%ZISC
 K ^TMP($J,"DGMFR11")
 Q
 ;
PRINT ; Print output
 N MAXCNT,DGSMS,DGPGCNT,DGHDR,CRT,DGMS0,DGDELHD
 I IOST["C-" S MAXCNT=IOSL-10,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 I DGSUM=1 S MAXCNT=MAXCNT+5
 S DGPGCNT=0,DGSMS=0
 ;
 I '$D(^TMP($J,"DGMFR11")) D HEADER W !!!?5,"No Data Found" Q
 ;
 S DGMS0="" F  S DGMS0=$O(^TMP($J,"DGMFR11",DGMS0)) Q:DGMS0=""  D PRINT2(DGMS0)
 Q
PRINT2(DGMS0) ; Get details
 N DGMSI
 S DGMSI=0 F  S DGMSI=$O(^TMP($J,"DGMFR11",DGMS0,DGMSI)) Q:'DGMSI!DGSMS  D
 .N DGMMS0,DGCT,DGCTS,DGCTX,DGMSST
 .N DGMTST,DGMTED,DGMMSI,DGMTEDI,DGMPAR,DGMPARX
 .N DGMREPL,DGMREPX,DGMV0
 .;
 .I $G(DGOUTP)="E" D DELIM(DGMS0,DGMSI) Q
 .;
 .I ($Y+1>MAXCNT)!'DGPGCNT D HEADER Q:DGSMS
 .S DGMS0=$G(^TMP($J,"DGMFR11",DGMS0,DGMSI,"MS"))
 .S DGMSST=+$G(^TMP($J,"DGMFR11",DGMS0,DGMSI,"STATUS")),DGMSST=$S(DGMSST:"INACTIVE",1:"ACTIVE")
 .D PRINMS(DGMSI)
 .;
 .Q:'DGMMSI
 .I $G(DGSUM)=2 D
 ..S DGMTED=$$NOW^XLFDT,DGMTED=$O(^DGMMS(11.99,DGMMSI,"TERMSTATUS","B",DGMTED),-1)
 ..I DGMTED D  ; This should always be true, if data came from STS MFS process
 ...S DGMTEDI="",DGMTEDI=$O(^DGMMS(11.99,DGMMSI,"TERMSTATUS","B",DGMTED,DGMTEDI))
 ...S DGMTST=$P(^DGMMS(11.99,DGMMSI,"TERMSTATUS",DGMTEDI,0),"^",2)
 ...W ?25,"Master Status: ",$S(DGMTST:"ACTIVE",1:"INACTIVE")
 ..S DGMV0=$G(^DGMMS(11.99,DGMMSI,"VUID"))
 ..W !?3,"VUID: ",$P(DGMV0,"^")
 Q
 ;
MUA(DGMUA) ; Select (M)apped, (U)nmapped, or(A)ll - entries from 11 mapped to 11.99
 N DIR,DIRUT,Y
 W ! S DIR(0)="SAO^M:(M)apped;U:(U)nmapped;A:(A)ll"
 S DIR("?")="Enter ^ to exit"
 S DIR("A",1)="Run the report for"
 S DIR("A")="(M)apped, (U)nmapped, or (A)ll Marital Status entries: ",DIR("B")="A" D ^DIR
 I $D(DIRUT) S DGOUT=1 Q
 S DGMUA=Y
 Q
 ;
SUMMARY() ;  ask to print detailed or summary report
 N DIR,DIRUT,X,Y
 S DIR(0)="SOA^D:Detailed;S:Summary;",DIR("B")="Summary"
 S DIR("A")="Type of report to print: "
 W ! D ^DIR
 I $D(DIRUT) S DGSMS=1 Q 0
 Q $S(Y="S":1,Y="D":2,1:0)
 ;
OUT() ; select Excel or Report format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S DGSMS=1 Q ""
 Q Y
 ;
DELIM(DGMS0,DGMSI)  ; Print output in "^" delimited format
 ; Print data in (E)xcel format, e.g., "data^data^data"
 I '$G(DGDELHD) S DGDELHD=1 D
 .I $G(DGSUM)=1 W !,"VA Marital Status^Mapped/Not Mapped^Master Marital Status"
 .I $G(DGSUM)=2 W !,"VA Marital Status^VA Abbreviation^VA Status^VA Code^Mapped/Not Mapped^Master MS Name^Master MS Code^Master Status^VUID"
 S DGMSST=$P(DGMS0,"^",4)
 S DGMSST=$S(DGMSST:"INACTIVE",1:"ACTIVE")
 W !,$P(DGMS0,"^")
 I $G(DGSUM)=2 D
 .W "^",$P(DGMS0,"^",2)
 .W "^",DGMSST
 .S DGCT=$P(DGMS0,"^",3) W "^",DGCT
 S DGMMS0=$G(^TMP($J,"DGMFR11",DGMS0,DGMSI,"MMSE"))
 S DGMMSI=+$P(DGMMS0,"^",4)
 W "^",$S(DGMMSI:"MAPPED",1:"NOT MAPPED")
 Q:'DGMMSI
 W "^",$P(DGMMS0,"^")  ; $P(^TMP($J,"DGMFR11",DGMS0,DGMSI,"MMSE"),"^")
 I $G(DGSUM)=2 D
 .W "^",$P(DGMMS0,"^",2)
 .S DGMTED=$$NOW^XLFDT,DGMTED=$O(^DGMMS(11.99,DGMMSI,"TERMSTATUS","B",DGMTED),-1)
 .I $G(DGMTED) D
 ..S DGMTEDI="",DGMTEDI=$O(^DGMMS(11.99,DGMMSI,"TERMSTATUS","B",DGMTED,DGMTEDI))
 ..S DGMTST=$P(^DGMMS(11.99,DGMMSI,"TERMSTATUS",DGMTEDI,0),"^",2)
 ..W "^",$S(DGMTST:"ACTIVE",1:"INACTIVE")
 .S DGMV0=$G(^DGMMS(11.99,DGMMSI,"VUID"))
 .W "^",$P(DGMV0,"^")
 Q
 ;
SELDEV()  ; Propmt for output device, return 1 if queued
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
 F  Q:$G(DGSMS)!$G(DGDONE)  D
 .K %ZIS,IOP,POP,ZTSK N I S DGION=$I,%ZIS="QM"
 .D ^%ZIS K %ZIS
 .I POP S IOP=DGION D ^%ZIS K IOP,DGION D  Q
 ..N DIR,X,Y
 ..S DIR(0)="YA",DIR("A",1)="  ** No Device Selected **",DIR("A")="Select a different device? (Y/N) " D ^DIR
 ..S:'Y DGSMS=1
 .S DGDONE=1
 I $D(IO("Q")) D  Q 1
 .N ZTDESC,ZTSAVE,ZTRTN
 .S ZTDESC="Marital Status to Master Marital Status Mapping Report",ZTRTN="DQ^DGMFR11"
 .S ZTSAVE("DATE*")="",ZTSAVE("DG*")="",ZTSAVE("ZTREQ")="@"
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print!" K ZTSK
 Q:$G(DGSMS) -1
 Q 0
 ;
HEADER ; page break and report header information
 N DGHDR,DGTAB,DGSPACE
 S DGSMS=0
 I CRT,DGPGCNT>0,'$D(ZTQUEUED) D  Q:DGSMS
 .N DIR,LIN
 .I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 .W !
 .S DIR(0)="E" D ^DIR K DIR
 .I 'Y S DGSMS=1 Q
 S DGPGCNT=DGPGCNT+1
 W @IOF,!
 S $P(DGSPACE," ",132)=""
 S DGHDR=" Marital Status to Master Marital Status Report     "
 S DGHDR=DGHDR_"Page: "_DGPGCNT,DGTAB=132-$L(DGHDR)-1
 W ?DGTAB,DGHDR
 Q
 ;
PRINMS(DGMSI)  ; Print Marital Status file (#11) entry
 W !!,"Marital Status: ",$P(DGMS0,"^")
 N DGCT2
 I $G(DGSUM)=2 D
 .W !,"Abbreviation: ",$P(DGMS0,"^",2)
 .W ?30,"Status: ",DGMSST
 .S DGCT=$P(DGMS0,"^",3) I $L(DGCT) W !?3,"Code: ",DGCT
 S DGMMS0=$G(^TMP($J,"DGMFR11",DGMS0,DGMSI,"MMSE"))
 S DGMMSI=+$P(DGMMS0,"^",4)
 W !,"Mapped to Master Marital Status : ",$S(DGMMSI:"YES",1:"NO")
 Q:'DGMMSI
 W !?3,"Master MS Name: ",$P(^TMP($J,"DGMFR11",DGMS0,DGMSI,"MMSE"),"^")
 I $G(DGSUM)=2 W !?3,"Master Code: ",$P(^TMP($J,"DGMFR11",DGMS0,DGMSI,"MMSE"),"^",2)
 Q
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="  This report prints Marital Statuses from the MARITAL"
 S MSG(2)="  STATUS file (#11), and each Marital Status' relationship"
 S MSG(3)="  to the Master Marital Status (#11.99) file."
 S MSG(4)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
