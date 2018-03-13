DGMFR10 ;DAL/JCH - NDS DEMOGRAPHICS RACE MASTER ASSOCIATIONS REPORT ;15-AUG-2017
 ;;5.3;Registration;**933**;Aug 13, 1993;Build 44
 ;
 ; Available at Master File Reports [DGMF RMAIN] option, at the following menu path:
 ;    Supervisor ADT Menu [DG SUPERVISOR MENU]
 ;      ADT System Definition Menu [DG SYSTEM DEFINITION MENU]
 ;        Master File Menu [DGMF MNU]
 ;          Master File Reports [DGMF RMAIN]
 Q
 ;
EN ; MRAC Report Entry point
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
 N DGSUM,DGMUA,DGSRAC,DGOUTP
 S DGSRAC=0
 ;
 D INFO
 ; Select (M)apped, (U)nmapped, or (A)ll entries from RACE (#10) file.
 W ! D MUA(.DGMUA) I '$D(DGMUA)!$G(DGOUT) S DGOUT=1 Q
 ;
 ; Select summary report or detailed
 S DGSUM=$$SUMMARY I 'DGSUM Q
 ;
 ; Select output format
 S DGOUTP=$$OUT I DGSRAC Q
 ;
 ; Select device
 I $$SELDEV()!DGSRAC Q
 ;
 I DGOUTP="R" W !!,"<*> please wait <*>"
 U IO D DQ
 ;
 Q
 ;
DQ ;  report (queue) starts here
 N DGRACI,DGMRACI,DGRAC0,DGMRAC0
 ;
 K ^TMP($J,"DGMFR10")
 ;  build list of races
 S DGRACI=0 F  S DGRACI=$O(^DIC(10,DGRACI)) Q:'DGRACI  D
 .S DGRAC0=$G(^DIC(10,DGRACI,0))
 .S DGRACP02=+$G(^DIC(10,DGRACI,.02))
 .S DGMRACI=+$G(^DIC(10,DGRACI,"MASTER"))
 .I $G(DGMUA)="U",$G(DGMRACI) Q
 .I $G(DGMUA)="M",'$G(DGMRACI) Q
 .S DGMRAC0=$S($G(DGMRACI):$G(^DGRAM(10.99,+DGMRACI,0)),1:"Not Mapped")
 .I DGMRACI S $P(DGMRAC0,"^",4)=DGMRACI
 .S ^TMP($J,"DGMFR10",DGRAC0,DGRACI,"RAC")=$G(DGRAC0)
 .S ^TMP($J,"DGMFR10",DGRAC0,DGRACI,"STATUS")=DGRACP02
 .S ^TMP($J,"DGMFR10",DGRAC0,DGRACI,"MRACE")=$G(DGMRAC0)
 ;
 D PRINT
 ;
 D ^%ZISC
 K ^TMP($J,"DGMFR10")
 Q
 ;
PRINT ; Print output
 N MAXCNT,DGSRAC,DGPGCNT,DGHDR,CRT,DGDELHD
 I IOST["C-" S MAXCNT=IOSL-10,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 I DGSUM=1 S MAXCNT=MAXCNT+5
 S DGPGCNT=0,DGSRAC=0
 ;
 I '$D(^TMP($J,"DGMFR10")) D HEADER W !!!?5,"No Data Found" Q
 ;
 N DGRACI,DGRAC0
 S DGRAC0="" F  S DGRAC0=$O(^TMP($J,"DGMFR10",DGRAC0)) Q:DGRAC0=""  D PRINT2(DGRAC0)
 Q
 ;
PRINT2(DGRAC0) ; Get details
 S DGRACI=0 F  S DGRACI=$O(^TMP($J,"DGMFR10",DGRAC0,DGRACI)) Q:'DGRACI!DGSRAC  D
 .N DGMRAC0,DGCT,DGCTS,DGCTX,DGRACST
 .N DGMTST,DGMTED,DGMRACI,DGMTEDI,DGMPAR,DGMPARX
 .N DGMREPL,DGMREPX,DGMV0
 .;
 .I $G(DGOUTP)="E" D DELIM(DGRAC0,DGRACI) Q
 .;
 .I ($Y+1>MAXCNT)!'DGPGCNT D HEADER Q:DGSRAC
 .S DGRAC0=$G(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"RAC"))
 .S DGRACST=+$G(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"STATUS")),DGRACST=$S(DGRACST:"INACTIVE",1:"ACTIVE")
 .D PRINRAC(DGRACI)
 .;
 .Q:'DGMRACI
 .I $G(DGSUM)=2 D
 ..W !?3,"Master Code: ",$P(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"MRACE"),"^",2)
 ..S DGMTED=$$NOW^XLFDT,DGMTED=$O(^DGRAM(10.99,DGMRACI,"TERMSTATUS","B",DGMTED),-1)
 ..I DGMTED D  ; This should always be true, if data came from STS MFS process
 ...S DGMTEDI="",DGMTEDI=$O(^DGRAM(10.99,DGMRACI,"TERMSTATUS","B",DGMTED,DGMTEDI))
 ...S DGMTST=$P(^DGRAM(10.99,DGMRACI,"TERMSTATUS",DGMTEDI,0),"^",2)
 ...W ?25," Master Status: ",$S(DGMTST:"ACTIVE",1:"INACTIVE")
 ..S DGMV0=$G(^DGRAM(10.99,DGMRACI,"VUID"))
 ..I $G(DGMV0) W !?3,"VUID: ",$P(DGMV0,"^")
 Q
 ;
MUA(DGMUA) ; Select (M)apped, (U)nmapped, or(A)ll - entries from 10 mapped to 10.99
 N DIR,DIRUT,Y
 W ! S DIR(0)="SAO^M:(M)apped;U:(U)nmapped;A:(A)ll"
 S DIR("?")="Enter ^ to exit"
 S DIR("A",1)="Run the report for"
 S DIR("A")="(M)apped, (U)nmapped, or (A)ll Race entries: ",DIR("B")="A" D ^DIR
 I $D(DIRUT) S DGOUT=1 Q
 S DGMUA=Y
 Q
 ;
SUMMARY() ;  ask to print detailed or summary report
 N DIR,DIRUT,X,Y
 S DIR(0)="SOA^D:Detailed;S:Summary;",DIR("B")="Summary"
 S DIR("A")="Type of report to print: "
 W ! D ^DIR
 I $D(DIRUT) S DGSRAC=1 Q 0
 Q $S(Y="S":1,Y="D":2,1:0)
 ;
OUT() ; select Excel or Report format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S DGSRAC=1 Q ""
 Q Y
 ;
DELIM(DGRAC0,DGRACI)  ; Print output in "^" delimited format
 ; Print data in (E)xcel format, e.g., "data^data^data"
 I '$G(DGDELHD) S DGDELHD=1 D
 .I $G(DGSUM)=1 W !,"VA Race^Mapped/Not Mapped^Race Master"
 .I $G(DGSUM)=2 W !,"VA Race^VA Race Abbreviation^VA Race Status^VA Race HL7 Code^VA Race PTF Code^Mapped/Not Mapped^Race Master Name^Race Master Code^Race Master Status^VUID"
 S DGRACST=$G(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"STATUS"))
 S DGRACST=$S(DGRACST:"INACTIVE",1:"ACTIVE")
 W !,$P(DGRAC0,"^")
 I $G(DGSUM)=2 D
 .W "^",$P(DGRAC0,"^",2)
 .W "^",DGRACST
 .S DGCT=$P(DGRAC0,"^",3) I $L(DGCT) D
 ..D FIELD^DID(10,90,"","POINTER","DGCTS")
 ..S DGCTX=$P(DGCTS("POINTER"),+DGCT_":",2),DGCTX=$P(DGCTX,";")
 ..I $L(DGCTX) W "^",DGCTX
 .W "^",$P(DGRAC0,"^",3)
 .W "^",$P(DGRAC0,"^",5)
 S DGMRAC0=$G(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"MRACE"))
 S DGMRACI=+$P(DGMRAC0,"^",4)
 W "^",$S(DGMRACI:"MAPPED",1:"NOT MAPPED")
 Q:'DGMRACI
 W "^",$P(DGMRAC0,"^") ;$P(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"MRACE"),"^")
 I $G(DGSUM)=2 D
 .W "^",$P(DGMRAC0,"^",2)
 .S DGMTED=$$NOW^XLFDT,DGMTED=$O(^DGRAM(10.99,DGMRACI,"TERMSTATUS","B",DGMTED),-1)
 .I DGMTED D
 ..S DGMTEDI="",DGMTEDI=$O(^DGRAM(10.99,DGMRACI,"TERMSTATUS","B",DGMTED,DGMTEDI))
 ..S DGMTST=$P(^DGRAM(10.99,DGMRACI,"TERMSTATUS",DGMTEDI,0),"^",2)
 ..W "^",$S(DGMTST:"ACTIVE",1:"INACTIVE")
 .S DGMV0=$P($G(^DGRAM(10.99,DGMRACI,"VUID")),"^")
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
 F  Q:$G(DGSRAC)!$G(DGDONE)  D
 .K %ZIS,IOP,POP,ZTSK N I S DGION=$I,%ZIS="QM"
 .D ^%ZIS K %ZIS
 .I POP S IOP=DGION D ^%ZIS K IOP,DGION D  Q
 ..N DIR,X,Y
 ..S DIR(0)="YA",DIR("A",1)="  ** No Device Selected **",DIR("A")="Select a different device? (Y/N) " D ^DIR
 ..S:'Y DGSRAC=1
 .S DGDONE=1
 I $D(IO("Q")) D  Q 1
 .N ZTDESC,ZTSAVE,ZTRTN
 .S ZTDESC="Race to Race Master Mapping Report",ZTRTN="DQ^DGMFR10"
 .S ZTSAVE("DATE*")="",ZTSAVE("DG*")="",ZTSAVE("ZTREQ")="@"
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print!" K ZTSK
 Q:$G(DGSRAC) -1
 Q 0
 ;
HEADER ; page break and report header information
 N DGHDR,DGTAB,DGSPACE
 S DGSRAC=0
 I CRT,DGPGCNT>0,'$D(ZTQUEUED) D  Q:DGSRAC
 .N DIR,LIN
 .I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 .W !
 .S DIR(0)="E" D ^DIR K DIR
 .I 'Y S DGSRAC=1 Q
 S DGPGCNT=DGPGCNT+1
 W @IOF,!
 S $P(DGSPACE," ",132)=""
 S DGHDR=" Race to Race Master Report     "
 S DGHDR=DGHDR_"Page: "_DGPGCNT,DGTAB=132-$L(DGHDR)-1
 W ?DGTAB,DGHDR
 Q
 ;
PRINRAC(DGRACI)  ; Print Race file (#10) entry
 W !!,"Race: ",$P(DGRAC0,"^")
 N DGCT2
 I $G(DGSUM)=2 D
 .W !,"Abbreviation: ",$P(DGRAC0,"^",2)
 .W ?30,"Status: ",DGRACST
 .S DGCT=$P(DGRAC0,"^",3) I $L(DGCT) W !?3,"HL7 Value: ",DGCT
 .S DGCT2=$P(DGRAC0,"^",5) I $L(DGCT2) W ?27,"PTF Value: ",DGCT2
 S DGMRAC0=$G(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"MRACE"))
 S DGMRACI=+$P(DGMRAC0,"^",4)
 W !,"Mapped to Race Master: ",$S(DGMRACI:"YES",1:"NO")
 Q:'DGMRACI
 W !?3,"Race Master Name: ",$P(^TMP($J,"DGMFR10",DGRAC0,DGRACI,"MRACE"),"^")
 Q
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)=" This report prints Races from the RACE file (#10) and each"
 S MSG(2)=" race's mapping relationship to the RACE MASTER (#10.99) file."
 S MSG(3)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
