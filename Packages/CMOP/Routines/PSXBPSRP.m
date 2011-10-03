PSXBPSRP ;BHAM ISC/MFR - CMOP/ECME ACTIVITY REPORT ;09/01/2006
 ;;2.0;CMOP;**63,65**;11 Apr 97;Build 31
 ;External reference to ^PSRX( supported by IA #1221
 ;External reference to ^PSOBPSUT supported by IA #4701
 ;External reference to ^BPSUTIL supported by IA #4410
 ;External reference to ^IBNCPDPI supported by IA #4729
 ; 
EN ; Entry Point
 N %,%ZIS,EXCEL,STDT,TERM,ENDT,DIVDA,DIVNM,DTOUT,I,LINE,POP,VA,VAERR
 N TYPE,PATS
 N X,Y,ZTDESC,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 ;
BDT ; - Prompt to select Date Range (Return: Start Date^End Date) 
 S X=$$SELDATE() I X="^" S POP=1 G EXIT
 S STDT=$P(X,U),ENDT=$P(X,U,2)
 ;
TYPE ; - Get (S)ummary or (D)etailed report type
 S TYPE=$$SELTYPE() I TYPE="^" S POP=1 G EXIT
 ;
PATS ; - Get Patient array
 I $$SELPATS(.PATS)'=1 S POP=1 G EXIT
 ;
DIV ; - Get Division(s) (Return: DIVDA and DIVNM arrays)
 D SELDIV I '$D(DIVNM) S POP=1 G EXIT
 ;
SELREL ; - Get release, unreleased or all
 N RLNRALL S RLNRALL="",RLNRALL=$$SELRLNRL^PSXBPSR1(.RLNRALL) G EXIT:RLNRALL="^"
 ;
EXC ;- Prompt for Excel Capture
 S EXCEL=$$EXCEL^PSXBPSUT() I EXCEL="^" S POP=1 G EXIT
 ;
DEV ; - Prompt for Device
 W !! S %ZIS="MQ",%ZIS("A")="Select Printer: ",%ZIS("B")=""
 D ^%ZIS I POP S POP=1 G EXIT
 S TERM=$S($E($G(IOST),1,2)="C-":1,1:0)
 I '$D(IO("Q")) G START
 ;
QUE ; - Process queue device
 S ZTSAVE("*")=""
 S ZTRTN="START^PSXBPSRP"
 S ZTDESC="CMOP/ECME Activity Report"
 D ^%ZTLOAD
 W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 D HOME^%ZIS
 S TERM=$S($E($G(IOST),1,2)="C-":1,1:0)
 G EXIT
 ;
 ;Report Processing Tag
 ;
START N BPFND,STDTE,ENDTE,LINE,POP,Y
 S BPFND=0,LINE="W ! F I=1:1:80 W ""="""
 U IO
 ;
 ;Excel Display - Print Header Record
 I EXCEL D PLINEX
 ;
 S Y=STDT X ^DD("DD") S STDTE=Y
 S Y=ENDT X ^DD("DD") S ENDTE=Y
 ;
 ;Loop through divisions and display
 S DIVDA=0 F  S DIVDA=$O(DIVDA(DIVDA)) Q:DIVDA'>0  D ONEDIV(.BPFND,STDTE,ENDTE,.PATS) Q:$G(POP)
 ;
 ;Make sure a record was printed
 I '$G(POP),BPFND=0 D
 .I 'EXCEL D TITLE
 .W !,"NO DATA FOUND FOR CHOSEN PARAMETERS"
 .I TERM,'EXCEL D PAUSE2
 ;
 I '$G(POP),'EXCEL S POP=2
 G EXIT
 ;
ONEDIV(BPFND,STDTE,ENDTE,PATS) ; - Display information for one division
 N %,PSXDT,TRX,PS,Y,BATCHES,EPHFL
 S PSXDT=STDT-.1
 I TYPE="D" S EPHFL=1
 F  S PSXDT=$O(^PSX(550.2,"D",PSXDT)) Q:'PSXDT!(PSXDT>(ENDT+.24))  D  Q:$G(POP)
 .S (PS,TRX)=0 F  S TRX=$O(^PSX(550.2,"D",PSXDT,TRX)) Q:'TRX  D  Q:$G(POP)
 . . N TEMP,DATA
 . . D GETS^DIQ(550.2,TRX,".01;1;2;3;5;6;7;8;9;10;13;14","","TEMP")
 . . M DATA=TEMP(550.2,TRX_",")
 . . I $G(DATA(.01))="" Q
 ..I '$D(DIVNM(DATA(2))) Q
 ..I DATA(2)'=DIVDA(DIVDA) Q
 ..I TYPE="S" S EPHFL=$$CHKEPH(TRX)
 ..Q:'EPHFL
 ..;
 ..;Set flag that at least one record was found
 ..S BPFND=1
 ..;
 ..;Display Transmission Information - Normal Display Only
 ..I 'EXCEL D HEAD1
 ..;
 ..;Display Records in Normal Format
 ..I 'EXCEL D  Q
 ...S PS=$$PDET(TRX,.PATS) Q:$G(POP)
 ...I 'PS D CHKP(3) Q:$G(POP)  D NDAT
 ...I TERM,'EXCEL D PAUSE Q:$G(POP)
 ..;
 ..;Display Records in Excel Format
 ..D PDETEX(TRX,.PATS)
 Q
 ;
CHKEPH(TRX) ;check batch for ePharmacy Rx's
 N DATA,SEQ,RX,RFL,RELDAT,EPHARM,EDFN
 S (EPHARM,SEQ)=0 F  S SEQ=$O(^PSX(550.2,TRX,15,SEQ)) Q:SEQ=""!(EPHARM)  D  Q:EPHARM
 . Q:'$D(^PSX(550.2,TRX,15,SEQ,0))
 . S DATA=^PSX(550.2,TRX,15,SEQ,0),RX=$P(DATA,"^",1),RFL=$P(DATA,"^",2),EDFN=$P(DATA,"^",3)
 . Q:$$GOODPAT(EDFN,.PATS)=0
 . I RFL=0 S RELDAT=$$GET1^DIQ(52,RX,31,"I")
 . I RFL>0 S RELDAT=$$GET1^DIQ(52.1,RFL_","_RX,17,"I")
 . Q:RLNRALL=2&(RELDAT="")
 . Q:RLNRALL=3&(RELDAT'="")
 . I $$STATUS^PSOBPSUT(RX,RFL)'="" S EPHARM=1
 Q EPHARM
 ;
HEAD1 ;
 D TITLE
 I $G(TYPE)="D" D
 .W !!,?7,"TRANSMISSION:",?35,DATA(.01)
 .W !,?7,"STATUS:",?35,DATA(1)
 .W !,?7,"DIVISION:",?35,DATA(2)
 .W !,?7,"CMOP SYSTEM:",?35,DATA(3)
 .W !,?7,"TRANSMISSION DATE/TIME:",?35,DATA(5)
 .I DATA(6) W !,?7,"CREATED DATE/TIME:",?35,DATA(6)
 .I DATA(7) W !,?7,"RECEIVED DATE/TIME:",?35,DATA(7)
 .I DATA(8) W !,?7,"RETRANSMISSION #:",?35,DATA(8)
 .I DATA(9) W !,?7,"ORIGINAL TRANS.:",?35,DATA(9)
 .I DATA(10) W !,?7,"CLOSED DATE/TIME:",?35,DATA(10)
 .W !,?7,"TOTAL PATIENTS:",?35,DATA(13)
 .W !,?7,"TOTAL RXS:",?35,DATA(14)
 E  D
 .W !
 .W $$RJ^XLFSTR("TRANSMISSION:",15),$$RJ^XLFSTR(DATA(.01),3)
 .W $$RJ^XLFSTR("TRANSMISSION DATE/TIME: ",35),DATA(5)
 .W !
 .W $$RJ^XLFSTR("TOTAL PATIENTS:",15),$$RJ^XLFSTR(DATA(13),3)
 .W $$RJ^XLFSTR("TOTAL RXS: ",35),DATA(14)
 .W !
 Q
 ;Display Record(s) - Normal Format
PDET(TRX,PATS) N BIEN,DFN,RFL,M,N,NDCR,NDCS,RXS,PS,RDT,RXI,VA
 D PLINE
 S (PS,RXS)=0 F  S RXS=$O(^PSX(550.2,TRX,15,RXS)) Q:'RXS  D  Q:$G(POP)
 .S RXI=+$$GET1^DIQ(550.215,RXS_","_TRX,".01","I")
 .S RFL=+$$GET1^DIQ(550.215,RXS_","_TRX,".02","I")
 .S DFN=+$$GET1^DIQ(550.215,RXS_","_TRX,".03","I")
 .Q:$$GOODPAT(DFN,.PATS)=0
 .Q:$$STATUS^PSOBPSUT(RXI,RFL)=""
 .D CHKP(2) Q:$G(POP)
 .I RFL=0 S RELDAT=$$GET1^DIQ(52,RXI,31,"I")
 .I RFL>0 S RELDAT=$$GET1^DIQ(52.1,RFL_","_RXI,17,"I")
 .Q:RLNRALL=2&(RELDAT="")
 .Q:RLNRALL=3&(RELDAT'="")
 .S PS=1 D PID^VADPT
 .S BIEN=RXI_"."_$E($TR($J("",4-$L(RFL))," ","0")_RFL,1,4)_1
 .S RDT=$S(RFL=0:$$GET1^DIQ(52,RXI,31,"I"),1:$$GET1^DIQ(52.1,RFL_","_RXI_",",17,"I"))
 .W !,$E($$GET1^DIQ(2,DFN,.01),1,14)_" ("_$G(VA("BID"))_")"
 .W ?22,RXI_"/"_$$GET1^DIQ(52,RXI,.01)_$S($G(^PSRX(RXI,"IB")):"$",1:"")_$$ECME^PSOBPSUT(RXI)_"/"_RFL
 .S (NDCS,NDCR)="",(M,N)=0
 .F  S M=$O(^PSRX(RXI,4,M)) Q:'M  S N=^(M,0) I $P(N,"^",3)=RFL S NDCR=$P(N,"^",8),NDCS=$P(N,"^",9)
 .W ?45,$E(NDCS,1,13),?59,$E(NDCR,1,13),?73,$S(RDT:"D",1:"T")
 .W !,?3,$E($$GET1^DIQ(52,RXI,6),1,18),?22,$E($$BPSPLN^BPSUTIL(RXI,RFL),1,15)
 .W ?38,$E($$STATUS^PSOBPSUT(RXI,RFL),1,7),?48,$P($$BILLINFO^IBNCPDPI(RXI,RFL),"^",1)
 .W ?58,$S(RDT:$E(RDT,4,5)_"/"_$E(RDT,6,7)_"/"_$E(RDT,2,3),1:"")
 Q PS
 ;
 ;Display Record(s) - Excel Format
PDETEX(TRX,PATS) N BIEN,DFN,RFL,M,N,NDCR,NDCS,RXS,PS,RDT,RXI,VA
 S RXS=0 F  S RXS=$O(^PSX(550.2,TRX,15,RXS)) Q:'RXS  D
 .S RXI=+$$GET1^DIQ(550.215,RXS_","_TRX,".01","I")
 .S RFL=+$$GET1^DIQ(550.215,RXS_","_TRX,".02","I")
 .S DFN=+$$GET1^DIQ(550.215,RXS_","_TRX,".03","I")
 .Q:$$GOODPAT(DFN,.PATS)=0
 .Q:$$STATUS^PSOBPSUT(RXI,RFL)=""
 .I RFL=0 S RELDAT=$$GET1^DIQ(52,RXI,31,"I")
 .I RFL>0 S RELDAT=$$GET1^DIQ(52.1,RFL_","_RXI,17,"I")
 .Q:RLNRALL=2&(RELDAT="")
 .Q:RLNRALL=3&(RELDAT'="")
 .S PS=1 D PID^VADPT
 .S BIEN=RXI_"."_$E($TR($J("",4-$L(RFL))," ","0")_RFL,1,4)_1
 .S RDT=$S(RFL=0:$$GET1^DIQ(52,RXI,31,"I"),1:$$GET1^DIQ(52.1,RFL_","_RXI_",",17,"I"))
 .W !,DATA(.01),U  ;Transmission
 .W DATA(1),U  ;Status
 .W DATA(2),U  ;Division
 .W DATA(3),U  ;CMOP System
 .W DATA(5),U  ;Transmission Date/Time
 .W $E($$GET1^DIQ(2,DFN,.01),1,14),U  ;Name
 .W "("_$G(VA("BID"))_")",U  ;Pt.ID
 .W RXI,U                             ;ECME#
 .W $$GET1^DIQ(52,RXI,.01)_$S($G(^PSRX(RXI,"IB")):"$",1:"")_$$ECME^PSOBPSUT(RXI),U  ;RX#
 .W RFL,U                     ;RFL#
 .N NDCS,NDCR,M,N S (NDCS,NDCR)="",(M,N)=0
 .F  S M=$O(^PSRX(RXI,4,M)) Q:'M  S N=^(M,0) I $P(N,"^",3)=RFL S NDCR=$P(N,"^",8),NDCS=$P(N,"^",9)
 .W $E(NDCS,1,13),U          ;NDC SENT
 .W $E(NDCR,1,13),U          ;NDC RECVD
 .W $S(RDT:"D",1:"T"),U      ;CMOP-STAT
 .W $E($$GET1^DIQ(52,RXI,6),1,18),U  ;DRUG
 .W $$BPSPLN^BPSUTIL(RXI,RFL),U ;INSURANCE
 .W $E($$STATUS^PSOBPSUT(RXI,RFL),1,7),U  ;PAY-STAT
 .W $P($$BILLINFO^IBNCPDPI(RXI,RFL),"^"),U  ;BILL#
 .W $S(RDT:$E(RDT,4,5)_"/"_$E(RDT,6,7)_"/"_$E(RDT,2,3),1:"")  ;REL-DATE
 Q
 ;
 ;- Check Selected Patient Array
GOODPAT(DFN,PATS) ;
 I $G(PATS(-1))="^ALL" Q 1
 I $G(PATS(DFN))'="" Q 1
 Q 0
 ;
 ;- Display Header - Normal
PLINE W !,"NAME",?22,"ECME#/RX#/FL#",?45,"NDC SENT",?59,"NDC RECVD",?71,"CMOP-STAT"
 W !,"   DRUG",?22,"INSURANCE",?38,"PAY-STAT",?48,"BILL#",?58,"REL-DATE"
 X LINE
 Q
 ;
 ;- Display Header - Excel
PLINEX W !,"TRANSMISSION",U,"STATUS",U,"DIVISION",U,"CMOP SYSTEM",U,"TRANSMISSION DATE/TIME",U
 W "NAME",U,"Pt.ID",U,"ECME#",U,"RX#",U,"FL#",U,"NDC SENT",U,"NDC RECVD",U,"CMOP-STAT",U
 W "DRUG",U,"INSURANCE",U,"PAY-STAT",U,"BILL#",U,"REL-DATE"
 Q
 ;
EXIT I '$G(POP) D PAUSE2
 I $D(ZTQUEUED) S ZTREQ="@" Q
 I $G(POP)'=1 D ^%ZISC
 Q
 ;
 ;- Print message if no billable prescriptions
NDAT W !!,"********* BATCH HAS NO ECME BILLABLE PRESCRIPTIONS *******",!
 Q
 ;
TITLE W @IOF
 W $$CJ^XLFSTR("CMOP/ECME ACTIVITY REPORT "_$S($G(BPFND)=1:"for "_$E(DIVDA(DIVDA),1,24),1:""),80)
 W $$CJ^XLFSTR("For "_STDTE_"  thru  "_$P(ENDTE,"@")_"     Printed: "_$$FMTE^XLFDT($$NOW^XLFDT()),80)
 X LINE
 Q
 ;
CHKP(BPLINES) Q:$G(EXCEL)
 S BPLINES=BPLINES+1
 I $G(TERM) S BPLINES=BPLINES+2
 I $Y>(IOSL-BPLINES) D:$G(TERM) PAUSE Q:$G(POP)  D TITLE,PLINE Q
 Q
 ;                
SELDATE() Q $$SELDATE^PSXBPSR1()
 ;
SELDIV D SELDIV^PSXBPSR1 Q
 ;
SELECT(I) D SELECT^PSXBPSR1(I) Q
 ;
SELTYPE() Q $$SELTYPE^PSXBPSR1()
 ;
SELPATS(ARRAY) Q $$SELPATS^PSXBPSR1(.ARRAY)
 ;
 ;Display selected divisions
ALL D ALL^PSXBPSR1 Q
 ;
 ;Screen Pause 2
PAUSE2 Q:'$G(TERM)
 N X
 U IO(0) W !!,"Press RETURN to continue:"
 R X:$G(DTIME)
 U IO
 Q
 ;
 ;Screen Pause 1
 ;
 ; Return variable - BPQ = 0 Continue
 ;                         2 Quit
PAUSE N X
 U IO(0) W !!,"Press RETURN to continue, '^' to exit:"
 R X:$G(DTIME) S:'$T X="^" S:X["^" POP=2
 U IO
 Q
