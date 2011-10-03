DVBHQZ6 ;ISC-ALBANY/JLU/PHH-print message ; 3/23/06 8:01am
 ;;4.0;HINQ;**28,49,57**;03/25/92 
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
