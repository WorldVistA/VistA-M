PRCSCK ;SF-ISC/KSS/TKW/SC-CP INPUT TEMPLATE CHECK RTN ; 3/31/05 3:12pm
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;PRC*5.1*81-SC-Adding a display of DM date needed by data, only if 
 ;the trx. originated from DynaMed.
 ;
 ;PRCSF-(FLAG) SET IF ENTERING AT TOP OF ROUTINE
 ;
 S (PRCSF,PRCSERR)=0 F PRCSI=0:0 S PRCSI=$O(^PRCS(410,DA,"IT",PRCSI)) Q:'PRCSI  D 2 Q:PRCSERR  S PRCSERR=0 D 1 Q:PRCSERR  D ^PRCSCK1
 I $D(PRCSERR),PRCSERR G EX
 D SCP0^PRCSCK1
EX K PRCSI,PRCSF,PRCSQT,PRCSDA,PRCSDA1,PRCSDA2,PRCS Q
1 I $D(PRCSF) S PRCSDA2=DA,PRCSDA1=PRCSI,PRCSQT=$S($D(^PRCS(410,PRCSDA2,"IT",PRCSDA1,0)):$P(^(0),U,2),1:"") I PRCSQT D QRB2
 Q
2 ;ENTRY POINT WITHIN SUB-FIELD - (DA & DA(1)) DEFINED, OR
 ;SUBROUTINE OF ABOVE (PRCSI AND DA) DEFINED.PRCSF (FLAG) SET
 Q:'$D(DA)  I '$D(PRCSF) Q:'$D(DA(1))
 N SPEC,PRCSIDA,PRCSBOC S SPEC=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),"^",12)
 S PRCSERR=0,PRCSJ=DA S:'$D(PRCSF) PRCSI=DA,PRCSJ=DA(1)
 S:$D(^PRCS(410,PRCSJ,"IT",PRCSI,0)) PRCSVAR=^(0)
 D @$S(PRCSDR["2237":9,PRCSDR["IB":8,PRCSDR["NPR":8,1:7)
 I PRCSERR S PRCSL=$S(PRCSERR=2:"QUANTITY",PRCSERR=3:"UNIT OF PURCHASE",PRCSERR=4:"BOC",PRCSERR=5:"ITEM MASTER FILE NO.",PRCSERR=10:"INTERMEDIATE PRODUCT CODE",1:"ESTIMATED ITEM UNIT COST")
 I PRCSERR W !,?3,$C(7),"ITEM # "_$P(^PRCS(410,PRCSJ,"IT",PRCSI,0),U,1)_" "_PRCSL_" MISSING!" S Y="@1"
 K PRCSJ,PRCSL,PRCSVAR K:'$D(PRCSF) PRCSI Q
3 I $D(PRCSVAR) S PRCSERR=$S($P(PRCSVAR,U,2)="":2,$P(PRCSVAR,U,3)="":3,$P(PRCSVAR,U,7)="":7,1:0)
 Q
4 I $D(PRCSVAR),$P(PRCSVAR,U,4)="",($D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)))&($P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),U,12)'>1)!'$D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) S PRCSERR=4
 S PRCSIDA=+$P(^PRCS(410,PRCSJ,"IT",PRCSI,0),"^",5)
 Q
5 I $D(PRCSVAR),$P(PRCSVAR,U,2)="" S PRCSERR=2
 Q
6 I $D(PRCSVAR),$P(PRCSVAR,U,11)="",$D(^PRC(411,PRC("SITE"),0)),$P(^(0),U,18)="Y" S PRCSERR=10
 Q
7 I $D(^PRCS(410,PRCSJ,3)),$P(^(3),U,4),$D(^(2)),$P(^(2),U,1)'="",$D(PRCSVAR)&($P(PRCSVAR,U,5)'="") D 5 Q:PRCSERR  D 4
 E  D 3 Q:PRCSERR  D 4
 Q:PRCSERR  D:PRCSDR["NR]" 6
 Q
8 I $D(^PRCS(410,PRCSJ,3)),$P(^(3),U,4),$D(^(2)),$P(^(2),U,1)'="",$D(PRCSVAR) S PRCSERR=$S($P(PRCSVAR,U,5)="":5,$P(PRCSVAR,U,2)="":2,1:0) Q:PRCSERR  D 4 Q:PRCSERR  I PRCSDR["IB]"!(PRCSDR["NPR]") D 6
 Q
9 D 3 Q:PRCSERR  D 4 Q:PRCSERR  D:PRCSDR["B" 6
 Q
RB S PRCST=$S($D(^PRCS(410,DA,4)):$P(^(4),U,8),1:"")
 W !,?50,"TRANSACTION BEG BAL: ",$S(PRCST:$J(PRCST,0,2),1:"0.00") G EXIT
RB1 S (PRCS,PRCS(1))=0 F PRCSII=0:0 S PRCS=$O(^PRCS(410,DA(1),12,PRCS)) Q:PRCS'>0  S PRCS(1)=PRCS(1)+$P(^(PRCS,0),U,2)
 D RB3
 I PRCS(2)>PRCST(1) S PRCS(3)=PRCS(2)-PRCST(1) W $C(7),!,"This is $ ",$J(PRCS(3),0,2)," more than the total available.",!,"Please re-edit your entries!" S Y=".01"
 E  D RB4
 G EXIT
RB3 S (PRCST(1),PRCS(2))=0,PRCST=$S($D(^PRCS(410,DA(1),4)):$P(^(4),U,8),1:""),PRCS(2)=PRCS(1),PRCST(1)=PRCST S:PRCS(1)["-"&(PRCST(1)["-") PRCS(2)=-PRCS(1),PRCST(1)=-PRCST Q
RB4 W ?29,"RUNNING TOTAL: ",$S(PRCS(2):$J(PRCS(2),0,2),1:"0.00"),?64,"BAL: ",$S(PRCST(1)-PRCS(2):$J(PRCST(1)-PRCS(2),0,2),1:"0.00") Q
EX1 K PRCSQT,PRCSDA,PRCSDA1,PRCSDA2 Q
EXIT K PRCSII,PRCSJJ,PRCS,PRCST Q
QRB S PRCSQT=$S($D(^PRCS(410,DA(1),"IT",DA,0)):$P(^(0),U,2),1:""),PRCSCST=$S($D(^PRCS(410,DA(1),"IT",DA,0)):$P(^(0),U,7),1:"")
 W !?50,"QTY BEG BAL: ",PRCSQT
 ;********************************************************************
 ;if DM system param. is set & Item Mult node 4 exists then display
 ;Date Needed By for DM trxs only - Patch PRC*5.1*81
 ;********************************************************************
 N PRCVDT,PRCVDN
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1,$D(^PRCS(410,DA(1),"IT",DA,4)) S PRCVDT=$P($G(^(4)),"^",2) S PRCVDN=$$FMTE^XLFDT(PRCVDT,1) W !?37,"DynaMed's DATE NEEDED BY: "_PRCVDN
 G EXIT
QRB1 S PRCSDA=DA,PRCSDA1=DA(1),PRCSDA2=DA(2) Q
QRB2 Q:'$D(PRCSQT)  Q:'PRCSQT  S PRCS=0,PRCS(1)=PRCSQT F PRCSJJ=1:1 S PRCS=$O(^PRCS(410,PRCSDA2,"IT",PRCSDA1,2,PRCS)) Q:PRCS'>0  S PRCS(2)=$S($D(^PRCS(410.6,+$P(^(PRCS,0),U,2),0)):$P(^(0),U,4),1:""),PRCS(1)=PRCS(1)-PRCS(2)
 I '$D(PRCSF) W ?55,"QTY RUN BAL: ",PRCS(1)
 S:PRCS(1)=0 PRCSERR="" I PRCS(1)<0 W !,$C(7),?15,"Total delivery schedule quantity exceeds item quantity by "_-(PRCS(1))_"." S PRCSERR=12 I '$D(PRCSF) S Y=3
 Q
ISSUPFCP(STA,FCP) ;RETURN 1 IF THIS IS A SUPPLY FUND FCP, 0 IF IT ISN'T
 Q ($P($G(^PRC(420,+STA,1,+FCP,0)),"^",12)=2)
 ;
SUPPLYCC() ;RETURN DEFAULT CC FOR SUPPLY FUND FCPS
 Q "615300 Inventory and Di"
 ;
SUPPLBOC() ;RETURN DEFAULT BOC FOR SUPPLY FUND FCPS
 Q 2696
 ;
SETY ;SETS BRANCHING LOGIC FOR INPUT TEMPLATE 'PRCPIB' AND 'PRCSENIB' (INPUT TEMPLATES FOR ISSUE BOOK REQUESTS)
 Q:'$D(PRCSERR)
 S Y=$S(PRCSERR=2:2,PRCSERR=4:4,PRCSERR=5:5,1:".01")
 Q
 ;
CHGCCBOC(CXLTXN,RPLTXN,OFCP,MUSTCHG) ;
 ;cxltxn = transaction # of cancelled transaction
 ;rpltxn = transaction# of replacement transaction
 ;ofcp =old fund control point if this was a temp transaction
 ;mustchg=user must change (currently not ever called with this set)
 ;returns 0 if no change required, 1 if change made,-1 if user must edit
 ;First get FCPs. If unchanged, quit
 N CXLCC,CXLFCP,CXLDA,CXLSTA,RPLCC,RPLFCP,RPLDA,RPLSTA,CCCNT,DONE,RV
 N RPLBOC,I,J,DA,DR,DIE,RPLFTYPE
 S CXLFCP=$$GETTXNCP(CXLTXN,.CXLDA,.CXLSTA)
 S RPLFCP=$$GETTXNCP(RPLTXN,.RPLDA,.RPLSTA)
 I (+CXLFCP'=+OFCP) S CXLFCP=OFCP
 I +CXLFCP=+RPLFCP Q 0
 S RPLFTYPE=$P($G(^PRCS(410,RPLDA,0)),U,4)
 ;Set CC. Stuff if there's only one good one.  Otherwise ask.
 S CCCNT=$$GETCCCNT^PRCSECP(RPLSTA,RPLFCP)
 I (+CCCNT=1) S RPLCC=$P(CCCNT,U,2),$P(^PRCS(410,RPLDA,3),U,3)=RPLCC W !!,"Cost Center updated to ",RPLCC,!
 E  D
 . S DA=RPLDA,DIE=410,DR="15.5R~Enter a Valid Cost Center"
 . S DIC("S")="S PRCSCC=$P(^(3),U,3) I $$VALIDCC^PRCSECP(RPLSTA,RPLFCP,+PRCSCC)"
 . D ^DIE
 . S RPLCC=$P(^PRCS(410,RPLDA,3),U,3)
 ;
 ;OK--time to deal with the BOCs now. Is there only one good one?
 S RV=1,NEWBOC=$$GETBOCNT^PRCSECP(RPLSTA,RPLFCP,+RPLCC)
 I +NEWBOC=1 S RPLBOC=$P(NEWBOC,U,2),DONE=1,RV=0 D
 . W !!,"BOC updated to ",RPLBOC," for the new document.",!!
 . I RPLFTYPE>1 D
 .. S I=0 F  S I=$O(^PRCS(410,RPLDA,"IT",I)) Q:I=""  D
 ... S $P(^PRCS(410,RPLDA,"IT",I,0),U,4)=RPLBOC
 . I RPLFTYPE=1 S $P(^PRCS(410,RPLDA,3),U,6)=RPLBOC
 I '$G(DONE) D
 . I RPLFTYPE>1 D
 .. S I=0 F  S I=$O(^PRCS(410,RPLDA,"IT",I)) Q:'(I?1N.N)  D
 ... S RPLBOC=$P(^PRCS(410,RPLDA,"IT",I,0),U,4)
 ... I RPLBOC]"" S RPLBOC(RPLBOC)=$G(RPLBOC(RPLBOC))_I_";"
 .. S I=""
 .. W !!,"  This document refers to the following BOC(s):",!
 .. I $O(RPLBOC(""))="" W "    [NONE]",!!
 .. F  S I=$O(RPLBOC(I)) Q:I=""  D
 ... W "    BOC: ",I,":"
 ... I '$$VALIDBOC^PRCSECP(RPLSTA,RPLFCP,RPLCC,I) W " ** INVALID **" S RV=-1
 ... W !,"    BOC ",+I," ITEM(S): ",$E(RPLBOC(I),1,$L(RPLBOC(I))-1)
 ... W !!
 . I RPLFTYPE=1 D
 .. S RPLBOC=$P($G(^PRCS(410,RPLDA,3)),U,6)
 .. W !!,"This document uses BOC ",RPLBOC
 .. I '$$VALIDBOC^PRCSECP(RPLSTA,RPLFCP,RPLCC,RPLBOC) W " ** INVALID **" S RV=-1
 . I RV<0,MUSTCHG W !,"You must edit this document to correct the BOC entries now.",!
 Q RV
 ;
OKCCBOC(TRANSXN) ;TRANSXN = transaction# of transaction to check
 ;returns 1 if no change required, 0 if user must edit
 ;First get FCP, Form type, Station, IEN and CC
 N A,CC,FCP,DA,STA,CCCNT,DONE,RV,GOODCC
 N BOC,BOCC,I,J,DR,DIE,FTYPE
 S FCP=$$GETTXNCP(TRANSXN,.DA,.STA)
 I 'DA!'STA Q 0
 S FTYPE=$P($G(^PRCS(410,DA,0)),U,4)
 S CC=+$P($G(^PRCS(410,DA,3)),U,3) I 'CC Q 0
 S GOODCC=$$VALIDCC^PRCSECP(STA,FCP,CC)
 I 'GOODCC D  Q 0
 . S A(1,"F")="!!?10",A(1)="An invalid Cost Center ("_+CC_") was entered."
 . S A(2,"F")="!?10",A(2)="You must re-edit this document before it can be approved."
 . S A(3)=$C(7)
 . D EN^DDIOL(.A)
 ;
 ;OK--time to deal with the BOCs now.  For 1358s, check the single BOC
 ;
 S BOCC=$$GETBOCNT^PRCSECP(STA,FCP,CC)
 S RV=1
 I FTYPE=1 D  Q RV
 . S BOC=$P($G(^PRCS(410,DA,3)),U,6)
 . I '$$VALIDBOC^PRCSECP(STA,FCP,CC,BOC) D  Q
 .. S A(1,"F")="!!?10",A(1)="An invalid BOC ("_+BOC_") was entered."
 .. I (+BOCC=1) S $P(PRCS(410,DA,3),U,6)=$P(BOCC,U,2),A(2)="It has been changed to "_+$P(BOCC,U,2)
 .. I (+BOCC'=1) S A(2)="You must re-edit this document before it can be approved."
 .. S A(2,"F")="!?10"
 .. S A(3)=$C(7)
 .. D EN^DDIOL(.A)
 .. S RV=0
 ;
 ;For the other form types, check all BOCs
 ;
 S (I,J)=0
 F  S I=$O(^PRCS(410,DA,"IT",I)) Q:'(I?1N.N)  D
 . S BOC=$P(^PRCS(410,DA,"IT",I,0),U,4)
 . I '$$VALIDBOC^PRCSECP(STA,FCP,CC,BOC) D
 .. S J=J+1,A(J)="An invalid BOC ("_+BOC_") was entered for item "_I_"."
 .. S A(J,"F")="!?10" I J=1 S A(J,"F")="!"_A(J,"F")
 .. I (+BOCC=1) S $P(^PRCS(410,DA,"IT",I,0),U,4)=$P(BOCC,U,2)
 I J S RV=0,J=J+1,A(J,"F")="!?10",A(J)=$S((+BOCC'=1):"You must re-edit this document before it can be approved.",1:"BOC(s) replaced with "_+$P(BOCC,U,2)),A(J+1)=$C(7) D EN^DDIOL(.A)
 Q RV
GETTXNCP(TRANSID,OUTIEN,OUTSTA) ;GET IEN AND CONTROL POINT # FOR TRANSACTION
 S OUTIEN=+$O(^PRCS(410,"B",TRANSID,""))
 S OUTSTA=$P($G(^PRCS(410,OUTIEN,0)),U,5)
 Q $P($G(^PRCS(410,OUTIEN,3)),U,1)
