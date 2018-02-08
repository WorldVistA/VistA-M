IBENDS1 ;DAL/JCH - NDS PAYERS MTOP UTILITIES ;15-JUN-2017
 ;;2.0;INTEGRATED BILLING;**585**;21-MAR-94;Build 68
 ;
 ; Type of Plan (#355.1) to Master Type of Plan (#355.99) associations
 ; Available at Master Type of Plan Report [IBMTOP RPT] option, at the following menu path:
 ;    Billing Supervisor Menu [IB BILLING SUPERVISOR MENU]
 ;      MCCR System Definition Menu [MCCR SYSTEM DEFINITION MENU]
 ;        Master Type of Plan Menu [IBMTOP MNU]
 ;          Master Type of Plan Report [IBMTOP RPT]
 Q
 ;
EN ; MTOP Report Entry point
 N IBEOUT,IBEION
 S IBEOUT=0
 F  Q:$G(IBEOUT)  D
 .D MAIN Q:IBEOUT
 .N DIR W !!
 .S DIR(0)="Y",DIR("B")="Y",DIR("A")="Run report again" D ^DIR
 .S:X'="Y" IBEOUT=1
 Q
 ;
MAIN ; Driver loop
 N IBESUM,IBEMUA,IBESTOP,IBEOUTP
 S IBESTOP=0
 ;
 D CLEAR^VALM1
 ;
 W !!?2,"This report will print Plan Types from the TYPE OF PLAN"
 W !?2,"(#355.1) file and each Plan Type's mapping relationship"
 W !?2,"to the Public Health Data Standards Consortium (PHDSC)"
 w !?2,"Source of Payment in the MASTER TYPE OF PLAN (#355.99) file."
 ;
 ; Select (M)apped, (U)nmapped, or (A)ll entries from TYPE OF PLAN (#355.1) file.
 W ! D MUA(.IBEMUA) I '$D(IBEMUA)!$G(IBEOUT) S IBEOUT=1 Q
 ;
 ; Select summary report or detailed
 S IBESUM=$$SUMMARY I 'IBESUM Q
 ;
 ; Select output format
 S IBEOUTP=$$OUT I IBESTOP Q
 ;
 ; Select device
 I $$SELDEV()!IBESTOP Q
 ;
 I IBEOUTP="R" W !!,"<*> please wait <*>"
 U IO D DQ
 ;
 Q
 ;
DQ ;  report (queue) starts here
 N IBETOPI,IBEMTOPI,IBETOP0,IBEMTOP0,IBENAME
 ;
 K ^TMP($J,"IBENDS1")
 ;  build list of plan types
 S IBETOPI=0 F  S IBETOPI=$O(^IBE(355.1,IBETOPI)) Q:'IBETOPI  D
 .S IBETOP0=$G(^IBE(355.1,IBETOPI,0)),IBEMTOPI=$P(IBETOP0,"^",5)
 .I $G(IBEMUA)="U",$G(IBEMTOPI) Q
 .I $G(IBEMUA)="M",'$G(IBEMTOPI) Q
 .S IBEMTOP0=$S($G(IBEMTOPI):$G(^IBEMTOP(355.99,+IBEMTOPI,0)),1:"Not Mapped")
 .I IBEMTOPI S $P(IBEMTOP0,"^",4)=IBEMTOPI
 .S IBENAME=$P(IBETOP0,"^")
 .S ^TMP($J,"IBENDS1",IBENAME,IBETOPI,"TOP")=$G(IBETOP0)
 .S ^TMP($J,"IBENDS1",IBENAME,IBETOPI,"MTOP")=$G(IBEMTOP0)
 ;
 D PRINT
 ;
 D ^%ZISC
 K ^TMP($J,"IBENDS1")
 Q
 ;
PRINT ; Print output
 N MAXCNT,IBESTOP,IBEPGCNT,IBEHDR,CRT,IBCNT
 I IOST["C-" S MAXCNT=IOSL-10,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 I IBESUM=1 S MAXCNT=MAXCNT+5
 S IBEPGCNT=0,IBESTOP=0
 ;
 I '$D(^TMP($J,"IBENDS1")) D HEADER W !!!?5,"No Data Found" Q
 ;
 N IBETOPI,IBENAME
 S IBENAME="" F IBCNT=1:1 S IBENAME=$O(^TMP($J,"IBENDS1",IBENAME)) Q:IBENAME=""!IBESTOP  D
 .S IBETOPI=0 F  S IBETOPI=$O(^TMP($J,"IBENDS1",IBENAME,IBETOPI)) Q:'IBETOPI!IBESTOP  D
 ..D PRINT2(IBENAME,IBETOPI)
 Q
 ;
PRINT2(IBENAME,IBETOPI)  ; Continue printing output
 N IBETOP0,IBEMTOP0,IBECT,IBECTS,IBECTX,IBTOPST
 N IBEMTST,IBEMTED,IBEMTOPI,IBEMTEDI,IBEMPAR,IBEMPARX
 N IBEMREPL,IBEMREPX,IBEMV0
 ;
 I $G(IBEOUTP)="E" D DELIM(IBENAME,IBETOPI) Q
 ;
 I ($Y+1>MAXCNT)!'IBEPGCNT D HEADER Q:IBESTOP
 S IBETOP0=$G(^TMP($J,"IBENDS1",IBENAME,IBETOPI,"TOP"))
 S IBTOPST=$P(IBETOP0,"^",4),IBTOPST=$S(IBTOPST:"INACTIVE",1:"ACTIVE")
 D PRINTOP(IBENAME,IBETOPI)
 ;
 Q:'IBEMTOPI
 I $G(IBESUM)=2 D
 .S IBEMTED=$$NOW^XLFDT,IBEMTED=$O(^IBEMTOP(355.99,IBEMTOPI,"TERMSTATUS","B",IBEMTED),-1)
 .I IBEMTED D  ; This should always be true, if data came from STS MFS process
 ..S IBEMTEDI="",IBEMTEDI=$O(^IBEMTOP(355.99,IBEMTOPI,"TERMSTATUS","B",IBEMTED,IBEMTEDI))
 ..S IBEMTST=$P(^IBEMTOP(355.99,IBEMTOPI,"TERMSTATUS",IBEMTEDI,0),"^",2)
 ..W ?22,"  PHDSC Status: ",$S(IBEMTST:"ACTIVE",1:"INACTIVE")
 .S IBEMPAR=$P(IBEMTOP0,"^",3) I IBEMPAR S IBEMPARX=$P($G(^IBEMTOP(355.99,IBEMPAR,0)),"^")
 .I $L($G(IBEMPARX)) W !,"PHDSC Parent: ",IBEMPARX
 .S IBEMV0=$G(^IBEMTOP(355.99,IBEMTOPI,"VUID"))
 .S IBEMREPL=$P(IBEMV0,"^",3) I IBEMREPL S IBEMREPX=$P($G(^IBEMTOP(355.99,IBEMREPL,0)),"^")
 .I $L($G(IBEMREPX)) W !,"MTOP PHDSC Replaced By: ",IBEMREPX
 Q
 ;
MUA(IBEMUA) ; Select (M)apped, (U)nmapped, or(A)ll - entries from 355.1 mapped to 355.99
 N DIR,DIRUT,Y
 W ! S DIR(0)="SAO^M:(M)apped;U:(U)nmapped;A:(A)ll"
 S DIR("?")="Enter ^ to exit"
 S DIR("A",1)="Run the report for"
 S DIR("A")="(M)apped, (U)nmapped, or (A)ll Type of Plan entries: ",DIR("B")="A" D ^DIR
 I $D(DIRUT) S IBEOUT=1 Q
 S IBEMUA=Y
 Q
 ;
SUMMARY() ;  ask to print detailed or summary report
 N DIR,DIRUT,X,Y
 S DIR(0)="SOA^D:Detailed;S:Summary;",DIR("B")="Summary"
 S DIR("A")="Type of report to print: "
 W ! D ^DIR
 I $D(DIRUT) S IBESTOP=1 Q 0
 Q $S(Y="S":1,Y="D":2,1:0)
 ;
OUT() ; select Excel or Report format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S IBESTOP=1 Q ""
 Q Y
 ;
DELIM(IBENAME,IBETOPI)  ; Print output in "^" delimited format
 ; Print data in (E)xcel format, e.g., "data^data^data"
 N IBSTRING,IBABB,IBCATX,IBTOPST
 N IBMCOD,IBMNAM,IBMSTAT,IBMAP
 I IBCNT=1 D
 .I IBESUM=2 W !,"TYPE OF PLAN NAME^PLAN ABBREVIATION^PLAN STATUS^MAJOR CATEGORY^MAPPED/NOT MAPPED^MTOP PHDSC NAME^MTOP PHDSC CODE^MTOP PHDSC STATUS^PARENT^REPLACED BY"
 .I IBESUM=1 W !,"TYPE OF PLAN NAME^MAPPED/NOT MAPPED^MTOP PHDSC NAME"
 S IBETOP0=$G(^TMP($J,"IBENDS1",IBENAME,IBETOPI,"TOP"))
 S IBTOPST=$P(IBETOP0,"^",4),IBTOPST=$S(IBTOPST:"INACTIVE",1:"ACTIVE")
 S IBABB=$P(IBETOP0,"^",2)
 S IBECT=$P(IBETOP0,"^",3) D
 .N IBECTS,IBERR
 .S IBCATX=""
 .D FIND^DIC(355.1,,".01;.03","A","`"_+$G(IBETOPI),,,,,"IBECTS","IBERR")
 .I $G(IBENAME)=$G(IBECTS("DILIST","ID",1,.01)) S IBCATX=$G(IBECTS("DILIST","ID",1,.03))
 S IBEMTOP0=$G(^TMP($J,"IBENDS1",IBENAME,IBETOPI,"MTOP"))
 S IBEMTOPI=+$P(IBEMTOP0,"^",4)
 S IBMNAM=$P(IBEMTOP0,"^"),IBMCOD=$P(IBEMTOP0,"^",2)
 S IBMAP=$S(IBEMTOPI:"MAPPED",1:"NOT MAPPED")
 I 'IBEMTOPI D  Q
 .I IBESUM=2 S IBSTRING=IBENAME_"^"_IBABB_"^"_IBTOPST_"^"_IBCATX_"^"_IBMAP
 .I IBESUM'=2 S IBSTRING=IBENAME_"^"_IBMAP
 .W !,IBSTRING
 S IBEMTED=$$NOW^XLFDT,IBEMTED=$O(^IBEMTOP(355.99,IBEMTOPI,"TERMSTATUS","B",IBEMTED),-1)
 S IBEMTEDI="",IBEMTEDI=$O(^IBEMTOP(355.99,IBEMTOPI,"TERMSTATUS","B",IBEMTED,IBEMTEDI))
 S IBEMTST=$P(^IBEMTOP(355.99,IBEMTOPI,"TERMSTATUS",IBEMTEDI,0),"^",2)
 S IBMSTAT=$S(IBEMTST:"ACTIVE",1:"INACTIVE")
 S IBEMPAR=+$P(IBEMTOP0,"^",3)
 S IBEMPARX=$P($G(^IBEMTOP(355.99,IBEMPAR,0)),"^")
 S IBEMV0=$G(^IBEMTOP(355.99,IBEMTOPI,"VUID"))
 S IBEMREPL=+$P(IBEMV0,"^",3)
 S IBEMREPX=$P($G(^IBEMTOP(355.99,IBEMREPL,0)),"^")
 I IBESUM=2 S IBSTRING=IBENAME_"^"_IBABB_"^"_IBTOPST_"^"_IBCATX_"^"_IBMAP_"^"_IBMNAM_"^"_IBMCOD_"^"_IBMSTAT_"^"_IBEMPARX_"^"_IBEMREPX
 I IBESUM'=2 S IBSTRING=IBENAME_"^"_IBMAP_"^"_IBMNAM
 W !,IBSTRING
 Q
 ;
SELDEV()  ; Prompt for output device, return 1 if queued
 I IBEOUTP="E" D
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
 N IBEDONE
 W !,"You may queue this report to print at a later time.",!
 F  Q:$G(IBESTOP)!$G(IBEDONE)  D
 .K %ZIS,IOP,POP,ZTSK N I S IBEION=$I,%ZIS="QM"
 .D ^%ZIS K %ZIS
 .I POP S IOP=IBEION D ^%ZIS K IOP,IBEION D  Q
 ..N DIR,X,Y
 ..S DIR(0)="YA",DIR("A",1)="  ** No Device Selected **",DIR("A")="Select a different device? (Y/N) " D ^DIR
 ..S:'Y IBESTOP=1
 .S IBEDONE=1
 I $D(IO("Q")) D  Q 1
 .N ZTDESC,ZTSAVE,ZTRTN
 .S ZTDESC="Type of Plan to MTOP Mapping Report",ZTRTN="DQ^IBENDS1"
 .S ZTSAVE("DATE*")="",ZTSAVE("IBE*")="",ZTSAVE("ZTREQ")="@"
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print!" K ZTSK
 Q:$G(IBESTOP) -1
 Q 0
 ;
HEADER ; page break and report header information
 N IBEHDR,IBETAB,IBESPACE
 S IBESTOP=0
 I CRT,IBEPGCNT>0,'$D(ZTQUEUED) D  Q:IBESTOP
 .N DIR,LIN
 .I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 .W !
 .S DIR(0)="E" D ^DIR K DIR
 .I 'Y S IBESTOP=1 Q
 S IBEPGCNT=IBEPGCNT+1
 W @IOF,!
 S $P(IBESPACE," ",132)=""
 S IBEHDR=" Type Of Plan Map to Master Type of Plan (MTOP)    "
 S IBEHDR(1)="    PHDSC Source of Payment Typology Report"
 S IBEHDR=IBEHDR_"Page: "_IBEPGCNT,IBETAB=132-$L(IBEHDR)-1
 W IBEHDR
 W !,IBEHDR(1)
 Q
 ;
PRINTOP(IBENAME,IBETOPI)  ; Print Type of Plan file (#355.1) entry
 W !!,"Type of Plan: ",$P(IBETOP0,"^")
 I $G(IBESUM)=2 D
 .W !,"Abbreviation: ",$P(IBETOP0,"^",2)
 .W ?30,"Status: ",IBTOPST
 .S IBECT=$P(IBETOP0,"^",3) I $L(IBECT) D
 ..D FIELD^DID(355.1,.03,"","POINTER","IBECTS")
 ..S IBECTX=$P(IBECTS("POINTER"),+IBECT_":",2),IBECTX=$P(IBECTX,";")
 ..I $L(IBECTX) W !?4,"Category: ",IBECTX
 S IBEMTOP0=$G(^TMP($J,"IBENDS1",IBENAME,IBETOPI,"MTOP"))
 S IBEMTOPI=+$P(IBEMTOP0,"^",4)
 W !?2,"Mapped to PHDSC Source of Payment?: ",$S(IBEMTOPI:"YES",1:"NO")
 Q:'IBEMTOPI
 W !?2,"PHDSC Name: ",$P(^TMP($J,"IBENDS1",IBENAME,IBETOPI,"MTOP"),"^")
 W !?2,"PHDSC Code: ",$P(^TMP($J,"IBENDS1",IBENAME,IBETOPI,"MTOP"),"^",2)
 Q
