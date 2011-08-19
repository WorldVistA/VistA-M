LBRYCK4 ;ISC2/DJM-CHECK-IN QUEUEING & PRINTING ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2,13**;Mar 11, 1996
PARSE S LBRYL="" F I=1:1 S G=$P(X,",",I) G:G="" TOC D:G=+G ROUT Q:LBRYL=0  D:G["-" PARSE1
 Q
PARSE1 S G1=$P(G,"-",1),G2=$P(G,"-",2) I G2'<G1 F G=G1:1:G2 D ROUT Q:LBRYL=0
 Q
ROUT S NUM=$O(^LBRY(682,A(LBX),4,"B",G,0)) Q:NUM=""
 S LBXX=^LBRY(682,A(LBX),4,NUM,0) Q:"45"'[$P(LBXX,U,2)
 S DIC="^LBRY(682,A(LBX),4,",DA=NUM D LOCK^LBRYEDR Q:LBRYL=0
 S LBC=$P(LBXX,U,3),LBC=$P(^LBRY(681,LBC,1),U,6)
 S $P(^LBRY(682,A(LBX),4,NUM,0),U,2)=LBC,$P(^(0),U,7)=LDATE
 W !,"c",$P(LBXX,U)," RECEIVED." D COMP
 I $P(^LBRY(682,A(LBX),1),U,7)="" S $P(^(1),U,7)=LDATE
 I $G(LBRYPTR)="" D ^LBRYASK I $G(LBRYPTR)="" S LBRYL=0 Q
 I "12"[LBC,$P(^LBRY(680.6,LBRYPTR,0),U,5)="Y" W "  Queued to printer ",$P(^(0),U,3),"."
 L  Q
COMP I "12"[LBC,$P(LBXX,U,6)="" D
 . S ^LBRY(682,"A2",A(LBX),NUM)=""
 . S ^LBRY(682,"A4",LDATE,LBRYLOC,A(LBX),NUM)=""
 I LBC<4 S $P(^LBRY(682,A(LBX),4,NUM,0),U,7)=LDATE,$P(^(0),U,8)=DUZ,$P(^LBRY(682,A(LBX),1),U,7)=LDATE
 I $P(LBXX,U)'="ToC",$P(LBXX,U,2)=4 S $P(^LBRY(682,A(LBX),1),U,4)=$P(^LBRY(682,A(LBX),1),U,4)+1
 Q
TOC S NUM=$O(^LBRY(682,A(LBX),4,"B","ToC",0)) G:NUM="" QUEUE
 S LBXX=^LBRY(682,A(LBX),4,NUM,0),DIC="^LBRY(682,A(LBX),4,",DA=NUM
 D LOCK^LBRYEDR Q:LBRYL=0
 I $P(^LBRY(682,A(LBX),4,NUM,0),U,2)=5 D
 . S $P(^LBRY(682,A(LBX),4,NUM,0),U,2)=1,$P(^(0),U,7)=LDATE,LBC=1
 . W !,"ToC ROUTING LIST" W:$P(^LBRY(680.6,LBRYPTR,0),U,5)="Y" " queued to printer ",$P(^(0),U,3),"." D COMP
 L
QUEUE W !!,"Check-in completed." S LTST=$O(^LBRY(682,"A2",0)) G:LTST="" FINI
 S QUEUE=^LBRY(680.6,LBRYPTR,0),TERM=$P(QUEUE,U,3),QUEUE=$P(QUEUE,U,5)
 I QUEUE="Y",TERM]"" S ZTIO=TERM,ZTDTH=$H G QUEUE1
 S %ZIS="MQ",%IS("B")=$S(TERM]"":TERM,1:"") K IO("Q")
 D ^%ZIS G:POP FINI I '$D(IO("Q")) U IO D ^LBRYCK2 D ^%ZISC G FINI
QUEUE1 S ZTRTN="^LBRYCK2",ZTSAVE("LBRYPTR")="",ZTDESC="LBRY CHECK-IN REPORT"
 D ^%ZTLOAD D ^%ZISC K ZTSK
FINI S XZ="EXIT//" D PAUSE^LBRYCK0 G ^LBRYCK
ASK W !!,"Enter copy number/s separated by commas or a hyphen."
 W !,"Copy number/s: EXIT// " S Q=1
ASK0 S DTOUT=0,X="" R X:DTIME E  W $C(7) S DTOUT=1 G ^LBRYCK
 I X="^" G ^LBRYCK
 I X="" G DISPLAY^LBRYCK
 I X?.N G PARSE
ASK3 S G=$P(X,",",Q) G:G="" ASK1 G:G["-" ASK4 G:G'?.N ASK2 S Q=Q+1 G ASK3
ASK1 G PARSE
ASK2 W !!,"Please enter a copy number or a range of numbers separated by a hyphen '1-2'"
 W !,"or a combination of the two separated by a comma '1,2-4' or <CR> to EXIT."
 G ASK
ASK4 G:G'?1N.N1"-"1N.N ASK2 S Q=Q+1 G ASK3
