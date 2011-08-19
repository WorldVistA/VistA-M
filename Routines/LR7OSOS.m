LR7OSOS ;slc/dcm - Lab order status for OE/RR ;8/11/97
 ;;5.2;LAB SERVICE;**121,201,187,230**;Sep 27, 1994
EN(OMEGA,ALPHA) ;'...the last shall be first...the first shall be last'
 N LRODT,LRSN,LREND
 U IO
 S LRODT=$S($G(ALPHA):ALPHA,1:""),LREND=0
 F  S LRODT=$O(^LRO(69,"D",LRDFN,LRODT),-1) Q:LRODT<1!(LRODT<OMEGA)  D ENTRY Q:LREND
 Q
ENTRY D HED
 S LRSN=0
 F  S LRSN=$O(^LRO(69,"D",LRDFN,LRODT,LRSN)) Q:LRSN<1  D ORDER,HED:$Y>(IOSL-3) Q:LREND
 Q
ORDER ;call with LRODT,LRSN
 N LROD0,LROD1,LROD3,X,LRDOC,X4,I,LRACN,LRACN0
 K D,LRTT Q:'$D(^LRO(69,LRODT,1,LRSN,0))  S LROD0=^LRO(69,LRODT,1,LRSN,0),LROD1=$S($D(^(1)):^(1),1:""),LROD3=$S($D(^(3)):^(3),1:"")
 W !?2,"Lab Order # ",$S($D(^LRO(69,LRODT,1,LRSN,.1)):^(.1),1:"") S X=$P(LROD0,U,6) D DOC^LRX W ?45,"Provider: ",$E(LRDOC,1,25)
 S X=$P(LROD0,U,3),X=$S(X:$S($D(^LAB(62,+X,0)):$P(^(0),U),1:""),1:""),X4="" I $D(^LRO(69,LRODT,1,LRSN,4,1,0)),+^(0) S X4=+^(0),X4=$S($D(^LAB(61,X4,0)):$P(^(0),U),1:"")
 W !?2,X,"  " W:X'[X4 X4 S I=0 F  S I=$O(^LRO(69,LRODT,1,LRSN,6,I)) Q:I<1  W !?5,": ",^(I,0)
 S LRACN=0 F  S LRACN=$O(^LRO(69,LRODT,1,LRSN,2,LRACN)) Q:LRACN<1  I $D(^(LRACN,0))#2 S LRACN0=^(0) D TEST
 Q
TEST ;
 N LRY,LRURG,LRROD,Y,LRLL,LROT,LROS,LROOS,LROSD,LRURG,X3,X,X1,X2,LRACD,LRACC,LRTSTS
 S LRROD=$P(LRACN0,U,6),(Y,LRLL,LROT,LROS,LROSD,LRURG)="",X3=0
 I $P(LRACN0,"^",11) G CANC
 S X=$P(LROD0,U,4),LROT=$S(X="WC":"Requested (WARD COL)",X="SP":"Requested (SEND PATIENT)",X="LC":"Requested (LAB COL)",X="I":"Requested (IMM LAB COL)",1:"undetermined")
 S X=$P(LROD1,U,4),(LROOS,LROS)=$S(X="C":"Collected",X="U":"Uncollected, cancelled",1:"On Collection List") S:X="C" LROT="" I '(+LRACN0) W !!,"BAD ORDER ",LRSN,!,$C(7) Q
 G NOTACC:LROD1=""
TST1 S X1=+$P(LRACN0,U,4),X2=+$P(LRACN0,U,3),X3=+$P(LRACN0,U,5)
 G NOTACC:'$D(^LRO(68,X1,1,X2,1,X3,0)),NOTACC:'$D(^(3)) S LRACD=$S($D(^(9)):^(9),1:"")
 I '$D(LRTT(X1,X2,X3)) S LRTT(X1,X2,X3)="",I=0 F  S I=$O(^LRO(68,X1,1,X2,1,X3,4,I)) Q:I<.5  S LRACC=^(I,0),LRTSTS=+LRACC D TST2
 W:$L($P(LROD1,U,6)) !,?20,$P(LROD1,U,6)
 Q
TST2 ;
 N I,LRURG,LROT,LROS,LRLL,Y,LROSD
 S LRURG=+$P(LRACC,U,2) I LRURG>49 Q
 I 'LRTSTS W !!,"BAD ACCESSION TEST POINTER: ",LRTSTS Q
 S LROT="",LROS=LROOS,LRLL=$P(LRACC,U,3),Y=$P(LRACC,U,5) I Y S LROS="Test Complete" D DATE S LROSD=Y D WRITE,COM(1) Q
 S Y=$P(LROD3,U) D DATE S LROSD=Y I LRLL S LROS="Testing In Progress"
 I $P(LROD1,"^",4)="U" S (LROS,LROOS)=""
 D WRITE,COM(1)
 Q
WRITE ;
 W !?2,$S($D(^LAB(60,+LRTSTS,0)):$P(^(0),U),1:"BAD TEST POINTER") W:$X>20 ! W ?20,$S($D(^LAB(62.05,+LRURG,0)):$P(^(0),U),1:"")," "
 W:$X>28 ! W ?28,LROT," ",LROS,?48," ",LROSD
 W:X3 ?62,"  ",$S($D(^LRO(68,X1,1,X2,1,X3,.2)):^(.2),1:"") W:LRROD !?46,"  See order: ",LRROD
 Q
COM(COMNODE) ;Write comment
 ;COMNODE=Comment node to write
 S:'$G(COMNODE) COMNODE=1
 I LRTSTS=+LRACN0 S I=0 F  S I=$O(^LRO(69,LRODT,1,LRSN,2,LRACN,COMNODE,I)) Q:I<1  W !?3,": "_^(I,0)
 Q
NOTACC I LROD3="" S LROS="" G NO2
 I $P(LROD3,U,2)'="" S LROS=" ",Y=$P(LROD3,U,2) G NO2
 S Y=$P(LROD3,U) S LROS=" "
NO2 S:'Y Y=$P(LROD0,U,8) S Y=$S(Y:Y,+LROD3:+LROD3,+LROD1:+LROD1,1:LRODT) D DATE S LROSD=Y
 S LRTSTS=+LRACN0,LRURG=$P(LRACN0,U,2)
 S LROS=$S(LRROD:"Combined",1:LROS) S:LROS="" LROS="for: "
 D WRITE:LRTSTS,COM(1)
 W:$L($P(LROD1,U,6)) !,?20,$P(LROD1,U,6)
 Q
DATE S Y=$$FMTE^XLFDT($P(Y,"."),"5Z")_$S(Y#1:" "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"") Q
HED D WAIT:$E(IOST,1)="C"&($Y>21) Q:LREND
 I $O(^LRO(69,"D",LRDFN,LRODT,0)) W !!,"Orders for date: " S Y=LRODT D DD^LRX W Y
 W @IOF,"  Test",?20,"Urgency",?30,"Status",?64,"Accession"
 Q
WAIT W !,"  PRESS '^' TO STOP " R X:DTIME S:X="" X=1 S LREND=".^"[X
 Q
CANC ;For Canceled tests
 N LRTSTS
 S LRTSTS=+LRACN0,LROT="Canceled by: "_$P(^VA(200,$P(LRACN0,"^",11),0),"^")
 D WRITE:LRTSTS,COM(1.1),COM(1) ;second call for backward compatibility - can be removed in future years (1/98)
 Q
OERR(X,ALPHA,OMEGA) ;Get order status for predefined patient
 ;X=DFN;DPT(   <--ORVP FORMAT
 ;ALPHA=start date
 ;OMEGA=end date
 I '$G(X) W !!?5,"NO PATIENT SELECTED",! H 2 Q
 Q:'$G(ALPHA)  Q:'$G(OMEGA)
 N DFN,LRDFN,LRDPF,LRDT0,VA200
 S DFN=+X,LRDPF=+$P(@("^"_$P(X,";",2)_"0)"),"^",2)_"^"_$P(X,";",2),LRDFN=$$LRDFN^LR7OR1(DFN)
 Q:'LRDFN
 W !,"Lab test status for: "_$P(^DPT(DFN,0),"^")
 D EN(ALPHA,OMEGA)
 Q
