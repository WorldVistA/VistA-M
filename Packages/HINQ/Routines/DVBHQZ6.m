DVBHQZ6 ;ISC-ALBANY/JLU/PHH/PJH-print message ; 9/26/11 4:31pm
 ;;4.0;HINQ;**28,49,57,62**;03/25/92 ;Build 17
1 W @$S('$D(IOF):"#",IOF="":"#",1:IOF),!!!
2 D 2^DVBHUTIL
3 W !!!,?5,"Printout by (M)ultiple patients, (R)equestor, (D)ate/time?   Multiple//"
 R DVBA:DTIME G:DVBA="^"!('$T) K S:DVBA="" DVBA="M"
 S (DVBMM2,DVBMM)=1 D M:"Mm"[DVBA,R:"Rr"[DVBA,D:"Dd"[DVBA
 I "MRDmrd"'[DVBA W !!,*7,?10,"Answer with an 'M', 'R', 'D', <RET> for 'M', or '^' to quit." G 3
K K DVBI,R1,DVBLEN,DVBMM2,X,POP,DVBMM1,DVBA,DVBLP,DVB,DVBMM,DVBLP1,DIC,%,DFN,ZTRTN,ZTSAVE,ZTDESC,ZTIO,DVBJIO,POP,Y,ZTSK,DVBDXSC,DVBIXMZ,DVBUSER,R,DVBCS,%DT,DVBTO,DVBFR
K1 K DVBAL,DVBLP2,DVBIO,DVBLP1,DVBLP1,DVB,DVBMM,DVBJIO I '$D(ZTSK) X ^%ZIS("C")
 Q
M S DVB="",DIC="^DVB(395.5,",DIC(0)="AEMZQ"
 S DIC("S")="I $D(^(""RS"",0))",DIC("A")="Select patient from ""HINQ Suspense file"":"
 F DVBLP=1:1 D ^DIC Q:Y'>0  S DVB=DVB_+Y_"^"
 K DIC I Y'>0,DVB="" Q
 W ! S ZTRTN="M1^DVBHQZ6",ZTSAVE("DVB")=DVB,ZTSAVE("DVBLP")=DVBLP S:$D(DVBMM2) ZTSAVE("DVBMM2")=DVBMM2 S:$D(DVBMM) ZTSAVE("DVBMM")=DVBMM D LD:'$D(DVBMM1) Q:$D(IO("Q"))!(POP)
M1 F DVBLP1=1:1:DVBLP-1 S DFN=$P(DVB,U,DVBLP1),DVBJIO=$S(IO'=IO(0):IO,1:IO(0)) I $D(^DVB(395.5,DFN,0)),($D(^("RS"))) D TEM^DVBHIQR D:'$D(DVBERCS) EN^DVBHIQM,WRT1^DVBHQD1:'$D(DVBMM1) W:$D(DVBMM1) "." Q:X="^"
 Q
 ;
DT S %DT="TAEP",%DT("A")="From:" D ^%DT Q:Y<0  S DVBFR=Y,%DT("A")="To:" D ^%DT Q:Y<0  I DVBFR>Y W !,*7,*7,"TO date cannot be earlier than FROM date." G DT
 S DVBTO=9999999-(Y+.2400),DVBFR=9999999-(DVBFR-.000001) K %DT Q
 ;
R S DIC(0)="AQME",DIC=200 D ^DIC Q:Y<0  S DVBAL=+Y
 D DT Q:'$D(DVBFR)!('$D(DVBTO))
 S ZTSAVE("DVBMM2")=DVBMM2,ZTSAVE("DVBMM")=DVBMM,ZTSAVE("DVBAL")=DVBAL,ZTSAVE("DVBFR")=DVBFR,ZTSAVE("DVBTO")=DVBTO,ZTRTN="R1^DVBHQZ6" D LD Q:$D(IO("Q"))!(POP)
R1 S X="" F DVBLP=DVBTO:0:9999999 S DVBLP=$O(^DVB(395.5,"C",DVBLP)) Q:DVBLP>DVBFR!(X="^")!('DVBLP)  F DFN=0:0 S DFN=$O(^DVB(395.5,"C",DVBLP,DFN)) Q:'DFN!(X="^")  I $D(^DVB(395.5,"D",DVBAL,DFN,DVBAL)),$D(^DVB(395.5,DFN,0)),$D(^("RS")) D R3
 Q
 ;
R3 S DVBJIO=$S(IO'=IO(0):IO,1:IO(0)) D TEM^DVBHIQR D:'$D(DVBERCS) EN^DVBHIQM,WRT1^DVBHQD1 Q
 ;
D D DT Q:'$D(DVBFR)!('$D(DVBTO))
 S ZTSAVE("DVBMM2")=DVBMM2,ZTSAVE("DVBMM")=DVBMM,ZTSAVE("DVBFR")=DVBFR,ZTSAVE("DVBTO")=DVBTO,ZTRTN="D1^DVBHQZ6" D LD Q:$D(IO("Q"))!(POP)
D1 S X="" F DVBLP=DVBTO:0:9999999 S DVBLP=$O(^DVB(395.5,"C",DVBLP)) Q:DVBLP>DVBFR!(X="^")!('DVBLP)  F DFN=0:0 S DFN=$O(^DVB(395.5,"C",DVBLP,DFN)) Q:'DFN!(X="^")  I $D(^DVB(395.5,DFN,0)),$D(^("RS")) D R3
 Q
 ;
EM W !!,"Do you wish to create a mail message, to be sent to the requestors" S %=2 D YN^DICN I %=0 W *7,!,"'YES' to create a mail message  'NO' will not" G EM
 I %=1 S DVBMM1=1,POP=0 D M W:$D(DVBLP1) !,"Mail Sent."
 D K Q
 ;
LD S %IS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) S ZTDESC="This is the HINQ Print/Mail option.",ZTIO=ION D ^%ZTLOAD X ^%ZIS("C")
 Q
 ;
S1 ;
 I $D(DVBDX) D LABELS^DVBHS3
 F JU=0:0 S JU=$O(DVBDX(JU)) Q:'JU  I +DVBDX(JU),DVBDX(JU)'["-" D S2
 Q
S2 I ($Y+5)>IOSL,$E(IOST,1,2)="C-" D PAUSE^DVBHS3
 I $G(QUIT)=1 Q
 W !,$S($P(DVBDX(JU),U,2)="":$P(DVBDX(JU),U),$D(^DIC(31,$P(DVBDX(JU),U,2),0)):$E($P(^(0),U),1,40),1:"")
 W ?42,$S($P(DVBDX(JU),U,3)="X0":100,1:+$P(DVBDX(JU),U,3))
 W ?50,$P($G(DVBDX(JU)),U,4)
 ;DVB*4*54 - format date fields
 N DVBF,DVBFF
 F DVBF=5,6 S DVBFF=$P($G(DVBDX(JU)),U,DVBF) D
 . I $G(DVBFF)?8N D
 . . S M=$E(DVBFF,1,2)
 . . D MM^DVBHQM11
 . . S DVBF(DVBF)=M_" "_$S($E(DVBFF,3,4)]"":$E(DVBFF,3,4),1:"  ")_","_$E(DVBFF,5,8)
 W ?55,$G(DVBF(5)),?68,$G(DVBF(6))
 K QUIT
 Q
 ;
QB S %=2 W !!,"Would you like a HINQ message printed out " D YN^DICN I %<0!(%=2) Q
 I '% W !!,"A YES will result in a HINQ printout queued to the device you select." G QB
 W !,"I will queue all messages!"
 K IOP S %IS="NMQ",%IS("B")="" D ^%ZIS K %IS I POP W !,"No printout queued!" G EX
 S IOP=ION_";"_IOST_$S($D(IO("DOC")):";"_IO("DOC"),1:";"_IOM_";"_IOSL)
 I IO=IO(0) W !,"Can not queue to your HOME device." G QB
 I IO'=IO(0),'$D(IO("Q")) W !,"I am QUEUEING this report to run now." S IO("Q")=1,ZTDTH=$H
 S DVBMM2=1,ZTRTN="M1^DVBHQZ6",ZTIO=IOP,ZTSAVE("DVB")=DVB,ZTSAVE("DVBLP")=DVBLP,ZTSAVE("DVBMM")=DVBMM,ZTSAVE("DVBMM2")=DVBMM2,ZTDESC="This is the HINQ report." K IO("Q") D ^%ZTLOAD
EX S IOP="HOME" D ^%ZIS K DVB,DVBLP,DVBMM,DVBMM2,ZTRTN,ZTIO,ZTSAVE,ZTDESC,IOP Q
 ;
 ;APIs added for MSDS (DVB*4*62)
 ;------------------------------
 ;
DISP(DFN) ;Display episodes for [DVBHINQ PAT-HINQ COMP] template
 ;
 N ARRAY,MORE
 ;If no data exists in .3216 nodes display old data
 I '$O(^DPT(DFN,.3216,"B",0)) D OLD(DFN,.ARRAY)
 ;Otherwise use .3216 multiple
 E  D NEW(DFN,.ARRAY)
 ;
 ;Display MSE data
 N BOS,COMP,DATA,DISCH,EODATE,IEN,RADATE,SERVN
 S CNT=0
 F  S CNT=$O(ARRAY(CNT)) Q:'CNT  D
 .S DATA=$G(ARRAY(CNT)) Q:DATA=""
 .S DISCH=$P(DATA,U,6) ;Discharge
 .S:DISCH]"" DISCH=$P($G(^DIC(25,DISCH,0)),U)
 .S BOS=$P(DATA,U,3) ;Branch
 .S:BOS]"" BOS=$P($G(^DIC(23,BOS,0)),U)
 .S RADATE=$P(DATA,U) ;Entry Date
 .S RADATE=$$FMTE^XLFDT(RADATE)
 .S EODATE=$P(DATA,U,2) ;Separation Date
 .S EODATE=$$FMTE^XLFDT(EODATE)
 .S SERVN=$P(DATA,U,5) ;Service Number
 .I CNT=1 W !,?1,"Last episode"
 .I CNT=2 W !,?1,"NTL episode"
 .I CNT=3 W !,?1,"NNTL episode"
 .;Note that Service Component is not displayed
 .W !,?1,RADATE,?15,EODATE,?34,BOS,?48,DISCH,?62,SERVN
 .I CNT=3,$G(MORE) W !,?1,"<more episodes>"
 Q
 ;
NEW(DFN,ARRAY) ;Check for new MSE format data
 N CNT,SDAT
 S CNT=0,SDAT="A"
 F  S SDAT=$O(^DPT(DFN,.3216,"B",SDAT),-1) Q:'SDAT  D  Q:CNT>2
 .S IEN=$O(^DPT(DFN,.3216,"B",SDAT,0)) Q:'IEN
 .S DATA=$G(^DPT(DFN,.3216,IEN,0)) Q:DATA=""
 .S CNT=CNT+1,ARRAY(CNT)=DATA
 .I CNT=3,$O(^DPT(DFN,.3216,"B",SDAT),-1) S MORE=1
 Q
 ;
OLD(DFN,ARRAY) ;Get old format VistA data
 N DGRP,DGRPX,DGRPED,DGRPSD,DGRPBR,DGRPCO,DGRPSN,DGRPDI
 S DGRP(.32)=$G(^DPT(DFN,.32)),DGRP(.3291)=$G(^DPT(DFN,.3291))
 ;Last service episode (SL)
 D EPISODE(1,4,8)
 ;Next to last service episode (SNL)
 Q:$P(DGRP(.32),"^",19)'="Y"  D EPISODE(2,9,13)
 ;Prior episode (SNNL)
 I $P(DGRP(.32),"^",20)="Y" D EPISODE(3,14,18)
 Q
 ;
EPISODE(SUB,P1,P2) ;Get old VistA data and save
 S DGRPX=$P(DGRP(.32),U,P1,P2),DGRPCO=$P(DGRP(.3291),U,SUB)
 S DGRPDI=$P(DGRPX,U),DGRPBR=$P(DGRPX,U,2),DGRPED=$P(DGRPX,U,3)
 S DGRPSD=$P(DGRPX,U,4),DGRPSN=$P(DGRPX,U,5)
 ;Save in format of new .3216 multiple (no lock flag)
 S ARRAY(SUB)=DGRPED_U_DGRPSD_U_DGRPBR_U_DGRPCO_U_DGRPSN_U_DGRPDI_U
 Q
