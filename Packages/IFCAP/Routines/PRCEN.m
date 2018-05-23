PRCEN ;WISC/CLH - ENTER/EDIT 1358 ;9/2/2010
V ;;5.1;IFCAP;**23,148,150,196,204**;Oct 20, 2000;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*150 RGB 4/23/12  Control the node 0 counter for file 410
 ;kill call since DIK call does not handle descending file logic
 ;
 ;PRC*5.1*196 Check Committed Date for 1358 against FY requested
 ;            to insure date is within the FY range.
 ;
EN ;new 1358 request
 N PRC,X,X1,DIC,DIE,DR,PRCS2,PRCSL,PRCSIP,DIR,DIRUT,PRCS,PRCSCP,PRCSN
 N PRCST,PRCST1,PRCSTT,PRC410,PRCUA,PRCAUTH,PRCAUTHS,PRCQ,PRCVEN,PRCONT
EN0 K PRC,X,X1,DIC,DIE,DR,PRCS2,PRCSL,PRCSIP,DIR,DIRUT,PRCS,PRCSCP,PRCSN
 K PRCST,PRCST1,PRCSTT,PRCAED,PRC410,PRCUA,PRCAUTHS
 D EN^PRCSUT I '$D(PRC("SITE")) W !!,"You are not an authorized control point user.",!,"Contact your control point official." H 3 Q
 Q:'$D(PRC("QTR"))!(Y<0)
 ;
 ; warn CP official, allow to quit
 Q:$$Q1358(PRC("SITE"),PRC("CP"))
 ;
 ; ask for 1358 Authority (need to preserve variables)
 S PRCQ=0 D
 . N X,Y,DTOUT,DUOUT,DIC
 . S DIC="^PRCS(410.9,",DIC(0)="AEMQ",DIC("S")="I Y<100,('$P(^(0),U,4)!($P(^(0),U,4)>DT))",DIC("A")="Select AUTHORITY OF REQUEST: " D ^DIC S PRCAUTH=+Y I Y<1 S PRCQ=1 Q
 . I $D(^PRCS(410.9,"AC",PRCAUTH)) S DIC("S")="I $P(^(0),U,3)=PRCAUTH,('$P(^(0),U,4)!($P(^(0),U,4)>DT))",DIC("A")="Select SUB-AUTHORITY OF REQUEST: " D ^DIC S PRCAUTHS=+Y I Y<1 S PRCQ=1
 Q:PRCQ
 D EN1^PRCSUT3 Q:'X
 S X1=X D EN2^PRCSUT3 Q:'$D(X1)  S X=X1 W !!,"This transaction is assigned Transaction number: ",X
 S PRC410=DA
 D  G:'$D(DA) EN0
 . L +^PRCS(410,DA):$S($D(DILOCKTM):DILOCKTM,1:3)
 . E  D EN^DDIOL("Transaction is being accessed by another user!") K DA
 . Q
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) S:$P(^(0),"^",11)="Y" PRCS2=1
 S DIC(0)="AEMQ",DIE=DIC,DR="3///1"_$S($D(PRCSIP):";4////"_PRCSIP,1:"")_";19////^S X=PRCAUTH"_$S($G(PRCAUTHS):";19.1////^S X=PRCAUTHS",1:""),X4=1 D ^DIE
 S PRCAED=1,PRCUA=""
 ; define if fields need to be required or not
 S PRCVEN=^PRCS(410.9,$S($G(PRCAUTHS):PRCAUTHS,1:PRCAUTH),0),PRCONT=$P(PRCVEN,"^",6),PRCVEN=$P(PRCVEN,"^",5)
 S DR="[PRCE NEW 1358]" D ^DIE
 I $D(Y)#10 S PRCUA=1 D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No") I Y=1 D
 . S PRCIENCT=$P(^PRCS(410,0),"^",3)+1      ;PRC*5.1*150
 . D DELETE^PRC0B1(.X,"410;^PRCS(410,;"_DA) S:X=1 PRCAED=-1
 . I X=1 S $P(^PRCS(410,0),"^",3)=PRCIENCT     ;PRC*5.1*150
 . K PRCIENCT     ;PRC*5.1*150
 . D EN^DDIOL(" **** NEW ENTRY IS "_$S(X=1:"",1:"NOT ")_"DELETED ****")
 . QUIT
 I PRCAED'=-1 D
 . D:$O(^PRCS(410,DA,12,0)) SCPC0^PRCSED
 . K PRCSF
 . D W1^PRCSEB
 . I $D(PRCS2),+^PRCS(410,DA,0),'PRCUA,$$CHECK(PRC410) D
 .. D W6^PRCSEB
 .. Q
 . Q
 L -^PRCS(410,PRC410)
 S DIR("B")="NO",DIR(0)="Y",DIR("A")="Do you want to enter another NEW request" D ^DIR Q:'Y!($D(DIRUT))
 W !! K PRCS2 G EN0
 Q
ED ;edit 1358
 N PRC410,PRC442,PRCHQ,PRCSDR,PRCSN,PRCST,PRCST1,Y,PRC,PRCS,TT,DIE,DA,DIC
 N DR,DIR,PRCSY,PRCSL,X,X1,T,T1,Z,PRCSDA,DTOUT,PRCVEN,PRCONT
ED0 K PRCHQ,PRCSDR,PRCSN,PRCST,PRCST1,Y,PRC,PRCS,TT,DIE,DA,DIC,DR,DIR,PRCSY
 K PRCSL,X,X1,T,T1,Z,PRCSDA
 D EN3^PRCSUT I '$D(PRC("SITE")) W !!,"You are not an authorized control point user.",!,"Contact your control point official." H 3 Q
 Q:Y<0
 S DIC="^PRCS(410,",DIE=DIC,DIC(0)="AEQM",DIC("S")="I $P(^(0),U,4)=1,+$P(^(0),U)'=0,$D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),""^"",5)=PRC(""SITE"") I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 D ^PRCSDIC Q:Y<0  K DIC("S") S (DA,PRCSY,PRCSDA)=+Y ;D LOCK^PRCSUT G ED0:PRCSL=0
 D  G:'$D(DA) ED0
 . L +^PRCS(410,DA):$S($D(DILOCKTM):DILOCKTM,1:3)
 . E  D EN^DDIOL("Another user is editing this transaction! Try Later") K DA
 . Q
 D NODE^PRCS58OB(DA,.TRNODE) S PRC410=DA
 S X=^PRCS(410,DA,0) S:+X PRC("FY")=$P(X,"-",2),PRC("QTR")=+$P(X,"-",3),TT=$P(X,"^",2)
 D EN2B^PRCSUT3
 I $D(^PRCS(410,DA,7)),$P(^(7),U,6)]"" D SCPE G OUT ;if obligated
ED1 I TT="CA" S DR="[PRCSENCT]",DIE=DIC D ^DIE S DA=PRCSY L -^PRCS(410,PRCSY) G ED0
 ; warn CP offical and allow to quit
 I $$Q1358(PRC("SITE"),PRC("CP"),$G(TT),$G(DA)) L -^PRCS(410,PRCSY) G ED0
 ;
 ;  patch 23, fix problem of not able to exit with "^"
 I TT'="O" S DR="[PRCSENA 1358]" S DIE=DIC D ^DIE L:$D(Y)>9 -^PRCS(410,PRCSY) G:$D(Y)>9 ED0 S DA=PRCSY
 I TT="A" S PRC442=$P($G(^PRCS(410,PRC410,10)),U,3) I PRC442 G:$$EN1^PRCE0A(PRC410,PRC442,1) ED1
 I TT="A",$P(^PRCS(410,DA,0),U,4)=1 S X=$P(^(4),U,6),X1=$P(^(3),U,7) I $J(X,0,2)'=$J(X1,0,2)!('X)!('X1) W $C(7),!,"Adj $ Amt does not equal the total of BOC $ Amts.",!,"Please correct the error.",! K DR G ED1
 D:TT="A"&($O(^PRCS(410,PRCSY,12,0))) SCPC0^PRCSED
 I TT="A" D REV D:$$CHECK(PRC410) W6^PRCSEB G OUT
 ;
 S DR="[PRCE NEW 1358]" D ^DIE,REV D:$$CHECK(PRC410) W6^PRCSEB
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to edit another request" D ^DIR G OUT:'Y!($D(DIRUT))
 L -^PRCS(410,PRCSDA)
 G ED0
SCPE ;sub control point edit
 S DR="[PRCSEDS]" D ^DIE
REV W !!,"Would you like to review this request" S %=2 D YN^DICN G REV:%=0 Q:%'=1  S (N,PRCSZ)=DA,PRCSF=1 D PRF1^PRCSP1 S DA=PRCSZ K X,PRCSF,PRCSZ Q
OUT L -^PRCS(410,PRCSDA) Q
 ;
CHECK(PRC410) ; - Check out a 1358 410 entry for required fields
 N PRCX,PRC0,PRC11,PRCER,PRC3,PRC1
 Q:'$G(PRC410) -1
 ;
 ; get data
 F PRCX=0,1,3,11 S @("PRC"_PRCX)=$G(^PRCS(410,PRC410,PRCX))
 S PRCX=$G(^PRCS(410.9,$S(+$P(PRC11,"^",5):+$P(PRC11,"^",5),1:+$P(PRC11,"^",4)),0))
 S PRCER=0
 ;
 ; make sure I have a 1358
 I $P(PRC0,"^",4)'=1 Q 1
 ;
 ; start checking out data
 I '$D(^PRCS(410,PRC410,8,1,0)) D CKER("PURPOSE is Missing")
 ;
 ; done checking if not an obligation
 I $P(PRC0,"^",2)'="O" G CKEX
 ;
 ; continue checking
 I '$P(PRC11,"^",4) D CKER("AUTHORITY is Missing")
 I $P(PRC11,"^",5),'$D(^PRCS(410.9,"AC",$P(PRC11,"^",4),$P(PRC11,"^",5))) D CKER("SUB-AUTHORITY does not correspond to AUTHORITY")
 I '$P(PRC11,"^",5),$O(^PRCS(410.9,"AC",+$P(PRC11,"^",4),0)) D CKER("SUB-AUTHORITY is Missing")
 I $P(PRCX,"^",5),'$P(PRC3,"^",4) D CKER("VENDOR is Missing")
 I $P(PRCX,"^",6),'$L($P(PRC3,"^",10)) D CKER("CONTRACT is Missing")
 I '$P(PRC1,"^",6) D CKER("Service Start Date is Missing")
 I '$P(PRC1,"^",7) D CKER("Service End Date is Missing")
 ;
CKEX I PRCER S PRCER=0 F  S PRCER=$O(PRCER(PRCER)) Q:'PRCER  W !?5,PRCER(PRCER),"!!!"
 Q $S($O(PRCER(0)):0,1:1)
 ;
CKER(X) ;
 S PRCER=PRCER+1
 S PRCER(PRCER)=X
 Q
 ;
Q1358(PRCSTA,PRCFCP,PRCTT,PRCDA) ; Quit 1358 Process
 ; This API warns a control point offical that they will be set as
 ; the requestor on the 1358 and thus cannot also approve it.
 ; The API will return 1 (true) if the user decided to quit the
 ; current process before being set as the requestor.
 ;
 ; inputs
 ;   PRCSTA - station number
 ;   PRCFCP - fund control point
 ;   PRCTT  - (optional) transaction type, pass "A" for adjustment
 ;   PRCDA  - (optional) file 410 ien of 1358 when editing 1358
 ; returns boolean value (0 or 1)
 ;   = 0 to proceed with process
 ;   = 1 to quit process
 ;
 N RET
 S RET=0 ; init value to return
 ;
 ; if user is control point official for input station and FCP
 I $G(PRCSTA)]"",$G(PRCFCP)]"",$D(^PRC(420,"A",DUZ,PRCSTA,+PRCFCP,1)) D
 . N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . ;
 . ; don't warn when editing a 1358 if user is already the requestor
 . I $G(PRCDA),$P($G(^PRCS(410,PRCDA,7)),"^")=DUZ Q
 . ;
 . I $G(PRCTT)'="A" D
 . . W !,"WARNING: The system will assign you as the CP Clerk (Requestor) of this 1358."
 . . W !,"You will be unable to approve a 1358 on which you are the REQUESTOR due to"
 . . W !,"segregation of duties."
 . I $G(PRCTT)="A" D
 . . W !,"WARNING: The system will assign you as the CP Clerk (Requestor) of this 1358"
 . . W !,"Adjustment.  You will be unable to approve a 1358 Adjustment on which you"
 . . W !,"are the REQUESTOR due to segregation of duties."
 . ;
 . S DIR(0)="Y",DIR("A")="Do you want to proceed (Y/N)",DIR("B")="NO"
 . D ^DIR K DIR I $D(DIRUT)!'Y S RET=1
 . W !
 ;
 Q RET
COMCHK ;Check Committed Date to insure it is within the FY/FQ range during option entry for 'NEW 1358'    ;PRC*5.1*196
 N PRCDT,PRCDT1
 I $G(PRCBBMY) S PRCCKERR=0 Q
 I '$D(PRC("BBFY"))!(+$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^",12)>0)!($P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^",3)["X") S PRC("BBFY")=PRC("FY")+2000
 S PRCCKERR=0,PRCDT=(PRC("BBFY")-1701)_$P("10:01:04:07",":",PRC("QTR"))_"01",PRCDT1=(PRC("BBFY")-1700)_"0930"
 I PRCCOMDT<PRCDT!(PRCCOMDT>PRCDT1) D
 . S PRCCKERR=1
 . W !!," ** Date Committed must be specified for time **",!," ** period covered by fiscal year ",PRC("BBFY"),"        **",!
 Q
