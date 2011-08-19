LROS ;SLC/CJS/DALOI/FHS-LAB ORDER STATUS ;8/11/97
 ;;5.2;LAB SERVICE;**121,153,202,210,221,263**;Sep 27, 1994
 N LRLOOKUP S LRLOOKUP=1 ; Variable to indicate to lookup patients, prevent adding new entries in ^LRDPA
EN K DIC,LRDPAF,%DT("B") S DIC(0)="A"
 D ^LRDPA G:(LRDFN=-1)!$D(DUOUT)!$D(DTOUT) LREND D L0 G EN
L0 D ENT S %DT="" D DT^LRX
L1 S LREND=0,%DT="E",%DT("A")="DATE to begin review: " D DATE^LRWU G LREND:Y<1 S (LRSDT,LRODT)=Y S %DT="",X="T-"_$S($P($G(^LAB(69.9,1,0)),U,9):$P(^(0),U,9),1:30) D ^%DT S LRLDAT=Y
L2 S LRSN=$O(^LRO(69,LRODT,1,"AA",LRDFN,0)) I LRSN<1 S Y=LRODT D DD^LRX W !,"No orders for ",Y S X1=LRODT,X2=-1 D C^%DTC S LRODT=X I LRODT<LRLDAT W !!,"NO REMAINING ACTIVE ORDERS",! G LREND
 D WAIT:$Y>18 G LREND:LREND,L2:LRSN<1
 I LRSDT'=LRODT W !,"Orders for date: " S Y=LRODT D DD^LRX W Y," OK" S %=1 D YN^DICN I %'=1 G LREND
 D ENTRY G LREND:LREND S X1=LRODT,X2=-1 D C^%DTC S LRODT=X
 G L2
ENTRY D HED Q:LREND
 S LRSN=0 F  S LRSN=$O(^LRO(69,LRODT,1,"AA",LRDFN,LRSN)) Q:LRSN<1!($G(LREND))  D ORDER Q:$G(LREND)  D HED:$Y>(IOSL-2)
 Q
ORDER ;call with LRSN, from LROE, LROE1, LRORD1, LROW2, LROR1
 K D,LRTT S LREND=0
 Q:'$D(^LRO(69,LRODT,1,LRSN,0))  S LROD0=^LRO(69,LRODT,1,LRSN,0),LROD1=$S($D(^(1)):^(1),1:""),LROD3=$S($D(^(3)):^(3),1:"")
 W !?2,"-Lab Order # ",$S($D(^LRO(69,LRODT,1,LRSN,.1)):^(.1),1:"") S X=$P(LROD0,U,6) D DOC^LRX W ?45,"Provider: ",$E(LRDOC,1,25) D WAIT Q:$G(LREND)
 S X=$P(LROD0,U,3),X=$S(X:$S($D(^LAB(62,+X,0)):$P(^(0),U),1:""),1:""),X4="" I $D(^LRO(69,LRODT,1,LRSN,4,1,0)),+^(0) S X4=+^(0),X4=$S($D(^LAB(61,X4,0)):$P(^(0),U),1:"")
 I $E($P(LROD1,U,6))="*" W !?3,$P(LROD1,U,6) D WAIT Q:$G(LREND)
 I $G(^LRO(69,LRODT,1,LRSN,"PCE")) W !,?5,"Visit Number(s): ",$G(^("PCE")) D WAIT Q:$G(LREND)
 W !?2,X,"  " W:X'[X4 X4 S I=0 F  S I=$O(^LRO(69,LRODT,1,LRSN,6,I)) Q:I<1!($G(LREND))  W !?5,": ",^(I,0) D WAIT Q:$G(LREND)
 S LRACN=0 F  S LRACN=$O(^LRO(69,LRODT,1,LRSN,2,LRACN)) Q:LRACN<1!($G(LREND))  I $D(^(LRACN,0))#2 S LRACN0=^(0) D TEST
 Q
TEST N LRY,LRURG
 S LRROD=$P(LRACN0,U,6),(Y,LRLL,LROT,LROS,LROSD,LRURG)="",X3=0
 I $P(LRACN0,"^",11) G CANC
 S X=$P(LROD0,U,4),LROT=$S(X="WC":"Requested (WARD COL)",X="SP":"Requested (SEND PATIENT)",X="LC":"Requested (LAB COL)",X="I":"Requested (IMM LAB COL)",1:"undetermined")
 S X=$P(LROD1,U,4),(LROOS,LROS)=$S(X="C":"Collected",X="U":"Uncollected, cancelled",1:"On Collection List") S:X="C" LROT=""
 I '(+LRACN0) W !!,"BAD ORDER ",LRSN,!,$C(7) D WAIT Q
 G NOTACC:LROD1="" ;,NOTACC:$P(LROD1,"^",4)="U"
TST1 S X1=+$P(LRACN0,U,4),X2=+$P(LRACN0,U,3),X3=+$P(LRACN0,U,5)
 G NOTACC:'$D(^LRO(68,X1,1,X2,1,X3,0)),NOTACC:'$D(^(3)) S LRACD=$S($D(^(9)):^(9),1:"")
 I '$D(LRTT(X1,X2,X3)) S LRTT(X1,X2,X3)="",I=0 F  S I=$O(^LRO(68,X1,1,X2,1,X3,4,I)) Q:I<.5!($G(LREND))  S LRACC=^(I,0),LRTSTS=+LRACC D TST2
 I $E($P(LROD1,U,6))="*" W !,?20,$P(LROD1,U,6) D WAIT
 Q
TST2 ;
 N I
 S LRURG=+$P(LRACC,U,2) I LRURG>49 Q
 I 'LRTSTS W !!,"BAD ACCESSION TEST POINTER: ",LRTSTS Q
 S LROT="",LROS=LROOS,LRLL=$P(LRACC,U,3),Y=$P(LRACC,U,5) I Y S LROS=$S($E($P(LRACC,U,6))="*":$P(LRACC,U,6),1:"Test Complete") D DATE S LROSD=Y D WRITE,COM(1.1),COM(1) Q
 S Y=$P(LROD3,U) D DATE S LROSD=Y I LRLL S LROS="Testing In Progress"
 I $P(LROD1,"^",4)="U" S (LROS,LROOS)=""
 D WRITE,COM(1.1),COM(1)
 Q
WRITE ;
 W !?2,$S($D(^LAB(60,+LRTSTS,0)):$P(^(0),U),1:"BAD TEST POINTER")
 I $X>20 W ! D WAIT Q:(LREND)
 W ?20,$S($D(^LAB(62.05,+LRURG,0)):$P(^(0),U),1:"")," " D WAIT Q:$G(LREND)
 I $X>28 W ! D WAIT Q:$G(LREND)
 W ?28,LROT," ",LROS,?43," ",LROSD
 W:X3 ?60," ",$S($D(^LRO(68,X1,1,X2,1,X3,.2)):^(.2),1:"")
 I LRROD W !?46,"  See order: ",LRROD D WAIT
 Q
COM(LRMMODE) ;
 ;Write comments
 ;LRMMODE=comments node to display
 N LRTSTI
 S:'$G(LRMMODE) LRMMODE=1
 S LRTSTI=$O(^LRO(69,LRODT,1,LRSN,2,"B",+LRTSTS,0)) Q:'LRTSTI
 D COMWRT(LRODT,LRSN,LRTSTI,LRMMODE,3)
 Q
COMWRT(LRODT,LRSN,LRTSTI,NODE,TAB) ;
 ;Write comment node
 I $S('LRODT:1,'LRSN:1,'LRTSTI:1,'NODE:1,1:0) Q
 Q:'$D(^LRO(69,LRODT,1,LRSN,2,LRTSTI))
 S:'$G(TAB) TAB=3
 N LRI
 S LRI=0 F  S LRI=$O(^LRO(69,LRODT,1,LRSN,2,LRTSTI,NODE,LRI)) Q:LRI<1!($G(LREND))  W:$D(^(LRI,0)) !?TAB,": "_^(0) D WAIT
 Q
NOTACC I $G(LROD3)="" S LROS="" G NO2
 I $P(LROD3,U,2)'="" S LROS=" ",Y=$P(LROD3,U,2) G NO2
 S Y=$P(LROD3,U) S LROS=" "
NO2 S:'Y Y=$P(LROD0,U,8) S Y=$S(Y:Y,+LROD3:+LROD3,+LROD1:+LROD1,1:LRODT) D DATE S LROSD=Y
 S LRTSTS=+LRACN0,LRURG=$P(LRACN0,U,2)
 S LROS=$S(LRROD:"Combined",1:LROS) S:LROS="" LROS="for: "
 I LRTSTS D WRITE,COM(1.1),COM(1) ;second call for backward compatibility - can be removed in future years (1/98)
 I $L($P(LROD1,U,6)) W !,?20,$P(LROD1,U,6) D WAIT
 Q
DATE S Y=$$FMTE^XLFDT(Y,"5MZ") Q
HED D WAIT:$E(IOST,1)="C"&($Y>18) Q:$G(LREND)  W @IOF,!,"  Test",?20,"Urgency",?30,"Status",?64,"Accession"
ENT ;from LROE, LROE1, LRORD1, LROW2
 Q
LREND I $E(IOST)="P" W @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 K LRLDAT,LRURG,LROSD,LRTT,LROS,LROOS,LRROD,X1,X2,X3,%,A,DFN,DIC,I,K,LRACC,LRACN,LRACN0,LRDFN,LRDOC,LRDPF,LREND,LRLL,LROD0,LROD1,LROD3,LRODT,LROT,LRSDT,LRSN,LRTSTS,X,X4,Y,Z,%Y,DIWL,DIWR,DPF,PNM Q
SHOW ;call with LRSN,LRODT, from LRCENDEL, LRTSTJAN
 S LREND=0
 W !,"Order  Test",?20,"Urgency",?30,"Status",?64,"Accession" D ORDER Q
WAIT Q:$Y<(IOSL-3)  I $E(IOST)'="C" W @IOF Q
 W !,"  PRESS '^' TO STOP " R X:DTIME S:X="" X=1 S LREND=".^"[X Q:$G(LREND)  W @IOF
 Q
CANC ;For Canceled tests
 S LRTSTS=+$G(LRACN0),LROT="*Canceled by: "_$P(^VA(200,$P(LRACN0,"^",11),0),U)
 I LRTSTS D WRITE,COM(1.1),COM(1) ;second call for backward compatitility - can be removed in future years (1/98)
 Q
OERR(X) ;Get order status for predefined patient
 ;X=DFN;DPT(   <--ORVP FORMAT
 I '$G(X) W !!?5,"NO PATIENT SELECTED",! H 2 Q
 N DFN,LRDPA,LRDFN,LRDT0,VA200
 S DFN=+X,LRDPF=+$P(@("^"_$P(X,";",2)_"0)"),"^",2)_"^"_$P(X,";",2)
 D END^LRDPA
 Q:LRDFN=-1
 W !,"Lab test status for: "_$P(^DPT(DFN,0),"^")
 D L0
 Q
