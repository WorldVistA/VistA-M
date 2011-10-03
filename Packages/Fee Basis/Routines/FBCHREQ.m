FBCHREQ ;AISC/DMK-USED FOR FEE NOTIFICATION/REQUEST ;13DEC88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ADD ;Entry point for entering a notification/request
 D FEE^DGREG G END:'$D(DFN)
 W ! S DIC="^FBAA(162.2,",DIC(0)="AQLMZ",DLAYGO=162.2,DIC("S")="I $P(^(0),U,4)=DFN" D ^DIC K DIC("S")
 G END:X=""!(X="^"),ADD:Y<0 S FBDA=+Y,FBN=$P(Y,"^",3)
 W *7,?55,$$DATX^FBAAUTL($P(Y,"^",2))
 I FBN="",$P(Y(0),U,15)=3 W !,*7,"This notification has a status of complete.  Cannot edit.",! K FBN D END G ADD
 I FBN="" S FBCHVEN=$P(^FBAA(162.2,FBDA,0),"^",2)
 D VENDOR^FBCHREQ1:FBN I '$D(FBCHVEN) S DA=FBDA G EN^FBCHREQ1
 W ! S DIE="^FBAA(162.2,",DA=FBDA,DR="[FBCH ENTER REQUEST]" D ^DIE
 G END:'$D(DA) I FBN G:$D(Y)'=0!($G(FBOUT)) EN^FBCHREQ1
 I FBLG>0 W !,*7,"Admission overlaps another request for this patient.",! G EN^FBCHREQ1
 I FBUP W !!,?15,"REPORT OF CONTACT INFORMATION",! D ^FBCHROC
 K DIC,DIE,DLAYGO,DA,DR,DFN,FBAUT,FBBEGDT,FBFLAG,FBLG,FBOUT,FBPROG,FBVT,Z,FBN,FBSW,VAL,FBX,HY,FBUP,FBAAPN,FBDA,FBDEL,FBPER,J,VA,X,X1,X2,D,FBCHTEL,FBCHVEN,FBDATE,FBVD,FBZZ,Y,ZZZ,FBDOA
 Q
 ;
LENT ;Entry point for enter/edit legal entitlement
 S DIC("S")="I $P(^(0),U,15)'=3" D ASKV G END:X="^"!(X="") S FBLENT=""
LENT1 S DFN=+$P(^FBAA(162.2,DA,0),"^",4),X=$G(^DPT(DFN,.361))
 I $P(X,"^")="" W !!,?10,"ELIGIBILITY HAS NOT BEEN DETERMINED NOR PENDING",!,?10,"CANNOT ENTER ENTITLEMENT." G END
ELIG I $D(^DPT(DFN,.32)),$P(^(.32),"^",4)=2 W !,?4,"VETERAN HAS A DISHONORABLE DISCHARGE, " S X=$S($D(^(.321)):$P(^(.321),"^",1),1:"") W $S(X="Y":"ONLY ELIGIBLE FOR AGENT ORANGE EXAM.",1:"NOT ELIGIBLE FOR BENEFITS.")
 I "N"[$E(X) S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT) I 'Y D INELI G END
 W !! S DIE=DIC,DR="8;S FBLENT=X;S:FBLENT']"""" Y=0;S:FBLENT=""Y"" Y=9;11///^S X=""N"";12////^S X=DT;14;S:X'=4 Y=9;15;9////^S X=DT;10////^S X=DUZ;100////^S X=$S(FBLENT=""N"":3,1:2)" D ^DIE G END:FBLENT="N"!(FBLENT="")
 ;
ASK S DIR(0)="Y",DIR("A")="Do you want to determine Medical Entitlement now",DIR("B")="YES" D ^DIR K DIR G END:$D(DIRUT)!'Y,MENT1:Y
 Q
 ;
MENT ;Entry point for enter/edit medical entitlement
 S DIC("S")="S FZ=^(0) I $P(FZ,U,9)=""Y""&($P(FZ,U,17)="""")&($S($P(FZ,U,12)="""":1,$P(FZ,U,12)=""Y"":1,1:0)) K FZ"
 D ASKV G END:X="^"!(X="")
MENT1 S FBMENT="" W !! S DIE=DIC,DR="11;S FBMENT=X;S:FBMENT']"""" Y=0;12////^S X=DT;S:FBMENT=""Y"" Y=13;14;S:X'=4 Y=13;15;13////^S X=DUZ;100////^S X=3" D ^DIE
 ;
SETUP I FBMENT="Y" S DIR(0)="Y",DIR("A")="Do you want to setup a 7078 now",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT)!'Y,EN^FBCH78:Y
END K DA,FBAUT,FBBEGDT,FBDA,FBOUT,FBFLAG,FBLG,FBPROG,FBVT,Z,FBADA,FBV,FBVT,FBLENT,FBDFN,FBNAME,FBSSN,FBMENT,FBX,DIC,DIE,DR,DLAYGO,D,DFN,VAL,X,Y,FBSUSP,FBUP,FBPHY,FBCHTEL,FBAAPN,FBAADT,DF,FBAUT,FBBEGDT,FBCHVEN,FBDEL,FBFLAG
 K FB,FB1,FBOUT,FBPER,FBPROG,FBSW,FBVD,VAL,D0,S,A,DIRUT,DUOUT,DTOUT,FBDOA,FBADDT
 Q
 ;
ASKV ;Look-Up call by veteran for file 162.2
 W ! S DIC="^FBAA(162.2,",DIC(0)="AEQMZ",DIC("A")="Select Patient: ",D="D" D IX^DIC K DIC("A"),DIC("S"),D Q:X="^"!(X="")  G ASKV:Y<0 S (DA,FBDA)=+Y
 S FBDFN=+$P(Y(0),"^",4) I $D(^DPT(FBDFN,0)) S FBNAME=$P(^(0),"^"),FBSSN=$TR($$SSN^FBAAUTL(FBDFN),"-","") Q
 Q
 ;
CHEK ;Check for another request for same pt. not completed
 S FBVT=DFN I $D(^FB7078("AC","I",FBVT)) S FB7078=$O(^FB7078("AC","I",FBVT,0)),FB7078=$S($D(^FB7078(FB7078,0)):$P(^(0),"^",1),1:"") G KILL
 Q
 ;
KILL W !!,"There is an incomplete 7078 for this patient.",!,"The reference number is "_FB7078 S DIK="^FBAA(162.2," D ^DIK S Y=0 W !!,?19,"< NEW REQUEST DELETED >" K FB7078,FBVT,DFN,DIK,DA,D,FBN Q
 ;
INELI S DIR(0)="162.2,14" D ^DIR G END:$D(DUOUT),H^XUS:$D(DTOUT)
 S FBSUSP=+Y G END:X=""!(X="^"),INELI:Y<0
 S DIE=DIC,DR="12////^S X=DT;7////^S X=DUZ;8////^S X=""N"";14////^S X=FBSUSP;S:X'=4 Y=9;15;9////^S X=DT;10////^S X=DUZ;11////^S X=""N"";100////^S X=3" D ^DIE Q
 ;
OUTP ;Entry to inquire about a notification/request
 D ASKV G END:X="^"!(X="") W !! S DR="0:99" D EN^DIQ
 G OUTP
