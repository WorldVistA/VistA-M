PRCSEA ;WISC/SAW/DXH/BM/SC/DAP - CONTROL POINT ACTIVITY EDITS ;5/8/13  15:31
V ;;5.1;IFCAP;**81,147,150,174,196,204**;Oct 20, 2000;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*81 BMM 3/23/05 when a 2237 is canceled, in CT1, add code 
 ;to update Audit file (#414.02), and send update message to 
 ;DynaMed thru a call to rtn PRCVTCA.
 ;
 ;PRC*5.1*150 RGB 4/23/12 DO NOT allow the same temporary tx
 ;number to be used at all.  Previously, the same temp tx #
 ;could be used by different users, not same user.
 ;Also, Control the node 0 counter for file 410 kill (DIK)
 ;since DIK call does not handle descending file logic
 ;
 ;PRC*5.1*196  Check to move Date Required to Committed Date (MOP: 2-4)
 ;             to insure a later date is used for FMS document. Also,
 ;             added date check called from templates PRCSENR&NRS,
 ;             PRCSEN2237S & PRCSENPRS to insure dates are in same 
 ;             FY/FQ defined.
 ;
ENRS ;ENTER REQ
 S PRCSK=1,X3="H"
 D EN1F^PRCSUT(1) ; ask site,FY,QRTR,CP & set up PRC array, PRCSIP variable ; prc*5*197
 G W2:'$D(PRC("SITE")),EXIT:Y<0 ; unauthorized user or '^' entered
 D W6 ; display help on transaction# format
ENRS0 S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="ABELQX",D="H"   ;PRC*5.1*150
 S DIC("A")="Select TRANSACTION: "
 S DIC("S")="I '^(0),$P(^(0),U)'="""",$D(^PRCS(410,""B"",$P(^(0),U),+Y))" ; only temp tx number not defined will be allowed  ;PRC*5.1*150
 D ^PRCSDIC ; lookup & preliminary validity checking
 K DLAYGO,DIC("A"),DIC("S")
 G:Y<0 EXIT
 I $P(Y,U,3)'=1 W $C(7),"   Must be a new (unique) entry." G ENRS0     ;PRC*5.1*150
 ;*81 Check site parameter to see if issue books are allowed
 D CKPRM^PRCSEB
 W !!,PRCVY,!
 S (PDA,T1,DA)=+Y
 L +^PRCS(410,DA):1 I $T=0 W !,"File is being accessed...try a different transaction number or try later" G ENRS0
 S T(2)=$P(Y,U,2)
 D EN2A^PRCSUT3 ; saves CP,sta,substa,txn name,user,BBFY,RB stat,acct data in new txn (nodes 0,3,6,11 of file 410)
 S $P(^PRCS(410,DA,14),"^")=DUZ ; originator (entered by)
 S $P(^PRCS(410,DA,7),"^")=DUZ,$P(^PRCS(410,DA,7),"^",2)=$P($G(^VA(200,DUZ,20)),"^",3) ; requestor default
 I $G(PRCSIP) S $P(^PRCS(410,DA,0),"^",6)=PRCSIP,^PRCS(410,"AO",PRCSIP,DA)="" ; PRCSIP was set up in PRCSUT & is inventory distribution point
 S PRCS="" ; set PRCS=1 if CP is automated, i.e. it uses IFCAP to send requests to A&MM
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) S:$P(^(0),"^",11)="Y" PRCS=1
TYPE ;
 W !!,"This transaction is assigned temporary transaction number: ",T(2)
 S DIC("A")="FORM TYPE: ",DIC="^PRCS(410.5,",DIC(0)="AEQZ"
 S DIC("S")=PRCVX ; only allow selection of 2237's
 D ^DIC
 S DA=PDA
 ;if user didn't enter a form type, go ask whether to backout and act
 ;accordingly: go let them re-enter a form type or exit
 I Y<0 G:'$$BACKOUT(T(2),DA) TYPE L -^PRCS(420,DA) G EXIT
 ;
 I Y<2 W "??" G TYPE
 K PRCVX,PRCVY
 S $P(^PRCS(410,DA,0),"^",4)=+Y,X=+Y,PRCSTYP=X ; form type     ;PRC*5.1*196
 ; if CP is not automated (file 420), user's response will be overwritten with non-recuring (type 2). Although user's selection is changed 'behind the scenes', 
 ; the scenario is unlikely to occur because full implementation of IFCAP was made mandatory and sites are now automated.
 S:'PRCS&(X>2) $P(^PRCS(410,DA,0),"^",4)=2,X=2
 K PRCSERR ; flag denoting item info is missing
 S DIC(0)="AEMQ",(DIC,DIE)="^PRCS(410,"
 S PRCSTYP=X ; form type     ;PRC*5.1*196
 S (PRCSDR,DR)="["_$S(X=2:"PRCSEN2237S",X=3:"PRCSENPRS",X=4:"PRCSENR&NRS",1:"PRCSENIBS")_"]"
EN1 K DTOUT,DUOUT,Y
 D ^DIE
 S DA=PDA
 I $D(Y)!($D(DTOUT)) D DOR L -^PRCS(410,DA) G EXIT
CMDAT I PRCSTYP>1,PRCSTYP<5,$P($G(^PRCS(410,DA,4)),U,2)="" D          ;PRC*5.1*196, PRC*5.1*204 protect global with $G
 . S PRCOMDT=$S($P($G(^PRCS(410,DA,1)),U,4)'=DT:$P($G(^PRCS(410,DA,1)),U,4),1:DT)
 . S DR="21///^S X=PRCOMDT",DIE="^PRCS(410," D ^DIE
 . S DR=$G(PRCSDR) ;reset DR to template value, PRC*5.1*204
 D RL^PRCSUT1 ; sets up 'IT' & '10' nodes
 D ^PRCSCK I $D(PRCSERR),PRCSERR G EN1 ; missing required field ('item')
 D DOR ; populate date of request field if it is nil
 L -^PRCS(410,DA)
 S T="enter" D W5 G EXIT:%'=1
 W !! K PRCS("SUB")
 G ENRS
 ;
EDRS ;EDIT REQ
 ; following line commented out by PRC*5*140 - user responses not used to limit selection of txn and sometimes resulted in bad info being set into the selected txn
 ; S PRCSK=1 D EN1F^PRCSUT(1) G W2:'$D(PRC("SITE")),EXIT:Y<0 ; ask sta,FY,QRTR,CP ; prc*5*197
 ; if the above line is reactivated, programmer should note that the transaction selected may not be of the same FY,QRTR,sta, subst, and CP specified by the user
 D W6 ; format doc for txn#
 S X3="H" S DIC="^PRCS(410,",DIC(0)="AEQ",D="H"
 S DIC("A")="Select TRANSACTION: "
 S DIC("S")="I '^(0),$P(^(0),U,3)'="""",$P(^(0),U,4)'=1,^PRCS(410,""H"",$P(^(0),U,3),+Y)=DUZ!(^(+Y)="""")" ; request must be authored by user or unauthored & cannot be a 1358
 D ^PRCSDIC G EXIT:Y<0 K DIC("A"),DIC("S")
 S (PDA,DA,T1)=+Y
 L +^PRCS(410,DA):1 I $T=0 W !,"File is being accessed...please try later" G EDRS
 ; following line commented out in PRC*5*140 - PRCSUT3 needs PRC("SST") or MYY to do something, neither exists in this option
 ; D EN2B^PRCSUT3
 S PRC("SITE")=+$P(^PRCS(410,PDA,0),"^",5)
 S PRC("CP")=$P(^PRCS(410,PDA,3),"^")
 ;PRC*5.1*204 Creates arrays PRC("FY"),PRC("QTR), and PRC("BBFY") if needed
 I '$D(PRC("FY")) D FY^PRCSUT G EX^PRCSUT:PRC("FY")="^"
 I '$D(PRC("QTR")) D QT^PRCSUT G EX^PRCSUT:PRC("QTR")="^"
 I '$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP")) G EX^PRCSUT
 I $P(^PRCS(410,PDA,0),"^",6)="" D  ; prc*5*197
 . N PRCSIP D IP^PRCSUT
 . I $D(PRCSIP) S $P(^PRCS(410,DA,0),U,6)=PRCSIP  ;PRC*5.1*147 modified file set from ^PRC(410 to ^PRCS(410
 S X=+$P(^PRCS(410,DA,0),"^",4) I X<1 D FORM
 S PRCSTYP=X ; form type     ;PRC*5.1*196
 ;*81 Check site parameter to see if Issue Books are allowed
 D CKPRM
 I PRCVD=1 S PRCVZ=1
 I PRCVD'=1 S PRCVZ=0
 W !,"The form type for this transaction is ",$P($G(^PRCS(410.5,X,0)),"^"),!
 I PRCVZ=1,X=5 W !,"All Supply Warehouse requests must be processed in the new Inventory System.",!!,"Please cancel this IFCAP issue book order." S T="edit" D W5 G:%'=1 EXIT W !! K PRCS("SUB") G EDRS
 ;
 S DIC(0)="AEMQ",(DIC,DIE)="^PRCS(410,"
 ;P182--Modified next 3 lines to use new templates if supply fund FCP
 S (DR,PRCSDR)="["_$S(X=1:"PRCE NEW 1358S",X=2:"PRCSEN2237S",X=3:"PRCSENPRS",X=4:"PRCSENR&NRS",1:"PRCSENIBS")_"]"
ED1 K DTOUT,DUOUT,Y
 D ^DIE
 S DA=PDA
 I $D(Y)!($D(DTOUT)) L -^PRCS(410,DA) G EXIT
COMDT I PRCSTYP>1,PRCSTYP<5,$P($G(^PRCS(410,DA,4)),U,2)="" D          ;PRC*5.1*196, PRC*5.1*204 protect global with $G
 . S PRCOMDT=$S($P(^PRCS(410,DA,1),U,4)'=DT:$P(^PRCS(410,DA,1),U,4),1:DT)
 . S DR="21///^S X=PRCOMDT",DIE="^PRCS(410," D ^DIE
 . S DR=$G(PRCSDR) ;reset DR to template value, PRC*5.1*204
 D RL^PRCSUT1
 D ^PRCSCK I $D(PRCSERR),PRCSERR G ED1
 K PRCSERR S $P(^PRCS(410,DA,14),"^")=DUZ
 L -^PRCS(410,DA)
 S T="edit" D W5 G EXIT:%'=1
 W !! K PRCS("SUB")
 G EDRS
 ;
CT ;CANCEL A (PERMANENT) TRANS
 D EN3^PRCSUT
 G W2:'$D(PRC("SITE")),EXIT:Y<0
 S DIC="^PRCS(410,",DIC(0)="AEMQ"
 ;S DIC("S")="I $P(^(0),""^"",4)=.5!($S('$D(^(7)):1,1:$P(^(7),""^"",6)="""")) I +^(0)>0,$D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),""^"",5)=PRC(""SITE"") I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 S DIC("S")="I $P(^(0),U,2)=""O""!($P(^(0),U,2)=""A""&($P(^(0),U,4)=1)),$S('$D(^(7)):1,1:$P(^(7),""^"",6)=""""),$D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),U,5)=PRC(""SITE"") I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 S DIC("A")="Select TRANSACTION: "
 D ^PRCSDIC G EXIT:Y<0 K DIC("S"),DIC("A")
CT1 W !,"Cancel this transaction" S %=2 D YN^DICN G CT1:%=0,EXIT:%'=1
 S DA=+Y
 L +^PRCS(410,DA):1 I $T=0 W !,"File is being accessed...please try later" G CT
 S DIE="^PRCS(410,",DR="104////^S X=DUZ" D ^DIE K DIE,DR
 S T=$P(^PRCS(410,DA,0),"^")
 I T?1A.E D  G EXIT:%'=1 W !! G CT     ;PRC*5.1*150 Will DELETE entry if temporary transaction
 . S DIK="^PRCS(410,",PRCIENCT=$P(^PRCS(410,0),"^",3)+1
 . D ^DIK
 . S $P(^PRCS(410,0),"^",3)=PRCIENCT K PRCIENCT,DIK
 . S T="cancel" D W4
 S $P(^PRCS(410,DA,11),"^",3)="",$P(^PRCS(410,DA,0),"^",2)="CA",$P(^PRCS(410,DA,5),"^")=0,$P(^PRCS(410,DA,6),"^")=0
 K ^PRCS(410,"F",+T_"-"_+PRC("CP")_"-"_$P(T,"-",5),DA),^PRCS(410,"F1",$P(T,"-",5)_"-"_+T_"-"_+PRC("CP"),DA),^PRCS(410,"AQ",1,DA)
 K ZX
 I $D(^PRCS(410,DA,4)) S ZX=^(4),X=$P(ZX,"^",8) F I=1,3,6,8 S $P(ZX,"^",I)=0
 I $D(ZX) S ^PRCS(410,DA,4)=ZX K ZX
 I $D(^PRCS(410,DA,12,0)) S N=0 F I=0:0 S N=$O(^PRCS(410,DA,12,N)) Q:N'>0  S X=$P(^(N,0),"^",2) I X S DA(1)=DA,DA=N D TRANK^PRCSEZZ S DA=DA(1)
 D ERS410^PRC0G(DA_"^C")
 W !,"Enter comments for this cancellation",!
 S DIE=DIC,DR=60
 D ^DIE
 ;PRC*5.1*81 if DM trx, update Audit file and send msg to DM
 D EN^PRCVTCA(DA)
 L -^PRCS(410,DA)
 I $D(^PRC(443,DA,0)) S DIK="^PRC(443," D ^DIK K DIK
 S T="cancel" D W4 G EXIT:%'=1
 W !! G CT
 ;
DT ;DELETE A (TEMPORARY) TRANS
 S X3="H"
 D W6 ; format doc for txn#
 S DIC="^PRCS(410,",DIC(0)="AEQ",DIC("A")="Select TRANSACTION: ",D="H"
 S DIC("S")="S W=$P(^(0),""^"",5),W(1)=+^(3) I '^(0),$P(^(0),""^"",3)'="""",^PRCS(410,""H"",$P(^(0),""^"",3),+Y)=DUZ!(^(+Y)="""")!($D(^PRC(420,""A"",DUZ,W,W(1),1)))!($D(^(2)))"
 D ^PRCSDIC G EXIT:Y<0
 K DIC("S"),DIC("A")
 S DA=+Y
 L +^PRCS(410,DA):5 I $T=0 W !,"File is being accessed...please try later" G DT
DT1 W !,"Delete this transaction" S %=2 D YN^DICN G DT1:%=0,EXIT:%'=1
 ;The following line was commented out in patch 182; should NOT manually
 ;change or reset last assigned IEN # in node zero.
 ;S PRCSDA=$P(^PRCS(410,0),U,3),DIK=DIC
 S PRCIENCT=$P(^PRCS(410,0),"^",3)+1      ;PRC*5.1*150
 S DIK=DIC
 W !,"Okay....."
 D ^DIK K DIK
 S $P(^PRCS(410,0),"^",3)=PRCIENCT K PRCIENCT     ;PRC*5.1*150
 L -^PRCS(410,DA)
 ;The following line was commented out in patch 182; should NOT manually
 ;change or reset last assigned IEN # in node zero.
 ;S $P(^PRCS(410,0),U,3)=PRCSDA
 K PRCSDA
 W "It's deleted"
 S T="delete" D W4 G EXIT:%'=1
 W !! G DT
 ;
 ;
DOR ; Date of Request
 I $D(^PRCS(410,DA,1)),$P(^PRCS(410,DA,1),"^")'="" Q
 S %DT="X",X="T" D ^%DT S $P(^PRCS(410,DA,1),"^")=Y
 Q
FORM ;*81 Allow user to change txn to a valid form and check site parameter to see if issue books are allowed
 D CKPRM
 I PRCVD=1 S PRCVX1="I Y>1&(Y<5)",PRCVY1="The Issue Book and NO FORM type are not valid in this option."
 I PRCVD'=1 S PRCVX1="I Y>1",PRCVY1="The NO FORM type is not valid in this option."
 W !,PRCVY1,!
 W !,"Please enter another form type",!
 S PRCSDAA=DA,DIC="^PRCS(410.5,",DIC("A")="FORM TYPE: ",DIC(0)="AEQZ"
 S DIC("S")=PRCVX1
 D ^DIC
 S:Y=-1 Y=2
 S DA=PRCSDAA,$P(^PRCS(410,DA,0),"^",4)=+Y,X=+Y
 K DIC,PRCVX1,PRCVY1,PRCVD
 Q
 ;
 ;Allow user the option of re entering a form type.  If they decline,
 ;kill off the transaction and return 1; else return 0
BACKOUT(TRNNAME,TRNDA) ;
 N DIK,Y,%,DA
 W !!,"WARNING: WITHOUT A FORM TYPE, TRANSACTION """,TRNNAME,""" WILL BE DELETED!",$C(7)
 W !,"Are you sure you want to delete this transaction" S %=2 D YN^DICN
 I %=0 G BACKOUT
 I %=2 Q 0
 S DIK="^PRCS(410,",DA=TRNDA
 S PRCIENCT=$P(^PRCS(410,0),"^",3)+1      ;PRC*5.1*150
 D ^DIK
 S $P(^PRCS(410,0),"^",3)=PRCIENCT K PRCIENCT     ;PRC*5.1*150
 Q 1
 ;
W2 W !!,"You are not an authorized control point user.",!,"Contact control point official" R X:5 G EXIT
W3 Q  ; can this subroutine be deleted? commented out in patch PRC*5*140
 W !!,"This transaction is assigned temporary transaction number: ",X Q
W4 W !!,"Would you like to ",T," another transaction" S %=2 D YN^DICN G W4:%=0 Q
W5 W !!,"Would you like to ",T," another request" S %=1 D YN^DICN G W5:%=0 Q
W6 W !!,"For the transaction number, use an uppercase alpha as the first character,",!," and then 2-15 alphanumerics, as in 'ADP1'.",! Q
 ;*81 Site parameter pull 
CKPRM S PRCVD=$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 Q
 ;
EXIT K %,C,D,DA,DIC,DIE,DR,PRCS,PDA,PRCSL,T,X,Y,Z,T1,X3,TYPE,PRCVZ,PRCOMDT,PRCSTYP    ;PRC*5.1*196
 I $D(PRCSERR) K PRCSERR
 Q
