PRCH7PUC ;Hines OIFO/RVD - GUI PURCHASE CARD PROS ORDER INTERFACE ;8/13/03  09:50
 ;;5.1;IFCAP;**68,123,141**;Oct 20, 2000;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is for Obligating and canceling a PO using a GUI interface.
 ;Line label UP1 is for MUMPS entry point.
 ;
 ; PRCSITE     - station number
 ; PRCVEN      - vendor
 ; RESULTS     - return variable
 ; PRCA        - IEN of Prosthetics Order file 664
 ; PRCB        - IEN of file 442
 ; PRCC        - Total Cost
 ; PRCRMPR   - Variable to quit in IFCAP E-Sig routine PRCUESIG
UP1(X,PRCA,PRCB,PRCC,PRCSITE,PRCVEN,PRCRMPR) ;ENTRY FOR GUI PURCHASING
 ;
 N PRCPROST,PRCHPC,PRCRI,A,B,Y,DIE
 N PRCHPO,PRCHTOT,PRCHBOCC,PRCHBOC1,PRCHN
 S PRC("PER")=+DUZ
 K X S X=$S('$D(^VA(200,+PRC("PER"),20)):"",1:^VA(200,+PRC("PER"),20))
 I $P(X,"^",2)="" S %X=$P(^VA(200,+PRC("PER"),0),"^"),%X=$P(%X,",",2)_" "_$P(%X,",")_$P(%X,",",3),$P(^VA(200,+PRC("PER"),20),"^",2)=%X,X=%X K %X
 S $P(PRC("PER"),"^",2,4)=$P(X,"^",2)_"^"_$P(X,"^",3)_"^"_$S($D(^VA(200,+PRC("PER"),.13)):$P(^(.13),"^",2),1:"")
 S PRCHVEN=PRCVEN
 S PRCPROST=3,PRCHPC=1
 S PRCRI(442)=PRCB
 S PRCHPO=PRCRI(442),PRCHTOT=PRCC
 S A=^PRC(440.5,$P(^PRC(442,PRCRI(442),23),"^",8),0),PRCHBOC1=$P(A,U,4)
 S DIE="^PRC(442,",DA=PRCHPO,DR="60////"_PRCHTOT_";91////"_PRCHTOT_";65////RMPR"_";7////"_RMPRDLVD D ^DIE K DR
 S PRCHN("SFC")=+$P(^PRC(442,PRCRI(442),0),U,19)
 S:'$D(^PRC(442,PRCHPO,2,0)) $P(^PRC(442,PRCHPO,2,0),U,2)=$P(^DD(442,40,0),U,2)
 S DA(1)=PRCHPO,DIE="^PRC(442,"_DA(1)_",2,",DA=1
 S DR=".01///^S X=1;1///Prosthetic Order;2///^S X=1;3///^S X=""EA"";5////^S X=PRCHTOT;3.1///^S X=1;9.7///^S X=1;9///^S X="""";8///^S X=9999;K PRCHBOCC;"
 S DR(1,442.01,1)="I PRCHN(""SFC"")=2 S PRCHBOCC=2696;I '$G(PRCHBOCC) S Y=""@87"";"
 S DR(1,442.01,2)="S PRCHBOCC=$P($G(^PRCD(420.2,PRCHBOCC,0)),U);3.5////^S X=PRCHBOCC;S Y=""@89"";@87;3.5////^S X=PRCHBOC1;@89;K PRCHBOCC"
 D ^DIE
 I '$D(Y) D PROS^PRCHNPO
 I $G(X)="#",$G(PRCRMPR)=1 D CANIC(PRCRI(442)) Q
 S X="" I PRCPROST=3 D CANIC(PRCRI(442)) S X="^"
 QUIT
 ;
CANIC(PRCA) ;cancel order, prca=ri of prosthetic order, prcb=ri file 442
 N PRCPROST,PRCHPC,A,B,X,Y
 S PRCPROST=99,PRCHPC=1
 D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCA,".5///^S X=45")
 S DA=PRCA D C2237^PRCH442A K DA,%A,%B,%
 QUIT
 ;
 ;PRCPONO - IEN of file #442
 ;PRCA    - IEN of file #664
 ;RESULTS  - a return value
 ;
 ;cancel a PO.  Call by Prosthetics GUI.
C1(PRCA) G C2
CAN(RESULTS,PRCPONO) ;broker entry point.
C2 ;
 N PRCPROST,PRCHPC,A,B,X,Y
 S PRCPROST=99,PRCHPC=1
 L +^PRC(442,PRCA):1
 I '$T S RESULTS="Unable to Access P.O. in IFCAP." Q
 D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCA,".5///^S X=45")
 S DA=PRCA D C2237^PRCH442A K DA,%A,%B,%
 S RESULTS(0)="P.O. has been cancelled."
 Q
 ;END
