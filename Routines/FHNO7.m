FHNO7 ; HISC/REL - List Supplemental Fdgs. ;12/15/94  09:14 
 ;;5.5;DIETETICS;**5,8**;Jan 28, 2005;Build 28
 ;patch #5 - add outpatient SF. ;patch #8 - add allergy display
LIS ; Display Feeding
 S (FHLOCN,Y)=""
 I WARD'="" S NAM=$P($G(^DPT(DFN,0)),"^",1) D CUR^FHORD7
 I WARD="",'$G(ADM) Q
 I WARD="" D PATNAME^FHOMUTL S NAM=FHPTNM,FHDIET=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,2) D
 .S:FHDIET Y=$P($G(^FH(111,FHDIET,0)),U,7) I 'FHDIET S FHRNUM=ADM D DIETPAT^FHOMRR1 S Y=FHDIETP
 .S FHLOC=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,3) S:$G(FHLOC) FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1)
 W:$E(IOST,1,2)="C-" @IOF W !!,NAM,"  " W:WARD'="" "( ",WARD," )" W:FHLOCN'="" "( ",FHLOCN," )"
 I WARD="",$D(^FHPT(FHDFN,"OP",ADM,0)) S DTP=$P(^FHPT(FHDFN,"OP",ADM,0),U,1) D DTP^FH W ?50,"Outpatient Date: ",DTP
 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 D ALG^FHCLN W !,"   Allergies: ",$S(ALG="":"None on file",1:ALG)
 I WARD'="" S NO=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",7),Y=$S('NO:"",1:$G(^FHPT(FHDFN,"A",ADM,"SF",NO,0)))
 I WARD=""  S NO=$P($G(^FHPT(FHDFN,"OP",ADM,"SF",0)),"^",3),Y=$S('NO:"",1:$G(^FHPT(FHDFN,"OP",ADM,"SF",NO,0))) I $P(Y,"^",32)'="" S (NO,Y)=""
 I WARD="" W:$D(FHMEAL) ?50,"MEAL: ",$S(FHMEAL="B":"Breakfast",FHMEAL="N":"Noon",1:"Evening")
L1 ; Display SF Order
 I '$D(WARD) S WARD=""
 S NM=$P(Y,"^",4) W !,"Feeding Menu: ",$S('NM:"None",1:$P(^FH(118.1,NM,0),"^",1)) Q:'NO  S DTP=$P(Y,"^",30) D DTP^FH W ?50,"Reviewed: ",DTP
 I WARD'="" W !!,"10AM",?26,"2PM",?52,"8PM",!,"-----------------------   -----------------------   -----------------------"
 I WARD="",$D(FHMEAL),FHMEAL="B" W !!,"10AM",!,"----------------------------------------------------------------------------"
 I WARD="",$D(FHMEAL),FHMEAL="N" W !!,"2PM",!,"-----------------------------------------------------------------------------"
 I WARD="",$D(FHMEAL),FHMEAL="E" W !!,"8PM",!,"-----------------------------------------------------------------------------"
 K N F K1=1:1:3 F K2=1:1:4 S N(K1,K2)=""
 S L=4 F K1=1:1:3 S K=0 F K2=1:1:4 S Z=$P(Y,"^",L+1),Q=$P(Y,"^",L+2),L=L+2 I Z'="" S:'Q Q=1 S K=K+1,N(K1,K)=$J(Q,2)_" "_$P($G(^FH(118,Z,0)),"^",1)
 I WARD'="" F K2=1:1:4 W !,N(1,K2),?26,N(2,K2),?52,N(3,K2)
 I WARD="",$D(FHMEAL) F K2=1:1:4 W !,$S(FHMEAL="B":N(1,K2),FHMEAL="N":N(2,K2),1:N(3,K2))
 W:$P(Y,"^",34)'="" !!,"Diet Pattern Associated: ",$S($P(Y,"^",34)="Y":"YES",1:"NO")
 Q
EN2 ; Supplemental Feeding Inquiry
 K FHSFLG,FHDFN,FHPTNM,FHMEAL,ADM,NO,Y,X
 S FHALL=1 D ^FHOMDPA G:'FHDFN KIL
 S WARD="" I $G(DFN)'="" S WARD=$G(^DPT(DFN,.1)) I WARD'="" D LIS G EN2
 I WARD="" D SF
 I '$G(FHSFLG) W !,"NO OUTPATIENT DATA ON FILE for today's date and the future!!" G EN2
 D SF0
 D:$G(ADM) LIS G EN2
 ;
SF ;LIST outpatient SF
 W @IOF,!,"Outpatient Recurring Meals... "
 S FHQ=0
 F FHI=DT-1:0 S FHI=$O(^FHPT("RM",FHI)) Q:FHI'>0!FHQ  F FHJ=0:0 S FHJ=$O(^FHPT("RM",FHI,FHDFN,FHJ)) Q:FHJ'>0!FHQ  I ($P($G(^FHPT(FHDFN,"OP",FHJ,0)),U,15)'="C") D
 .S FHDA15=$G(^FHPT(FHDFN,"OP",FHJ,0))
 .S FHMEAL=$P(FHDA15,U,4),FHLOC=$P(FHDA15,U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHMEAL="B":"Break",FHMEAL="N":"Noon",1:"Even"),FH11=FHMEAL_"  "_FHLOCN
 .S Y=$P(FHDA15,U,1) X ^DD("DD") S DTP=Y
 .S (FHCOFLG,FHDATL,FHSF)=0
 .I $Y>(IOSL-5) K DIR S DIR(0)="E",DIR("A")="Enter RETURN to Continue or '^' to Quit Listing"  D ^DIR W:Y @IOF I 'Y S FHQ=1 Q
 .S FHSFLG=1
 .W !,DTP,?12,FH11
 .S FHDATL=$L(DTP)+13+$L(FH11)
 .S:$D(^FHPT(FHDFN,"OP",FHJ,"SF",0)) FHSF=$P(^FHPT(FHDFN,"OP",FHJ,"SF",0),U,3)
 .Q:'$G(FHSF)
 .S FHDA15SF=$G(^FHPT(FHDFN,"OP",FHJ,"SF",FHSF,0))
 .Q:$P(FHDA15SF,U,32)
 .S FHDASFNM=$P($G(^FH(118.1,$P(FHDA15SF,U,4),0)),U,1)
 .W ?40," (",FHDASFNM,")"
 W !
 Q
 ;
 ;K DIC
 ;S DIC("S")="I $P(^FHPT(FHDFN,""OP"",+Y,0),U,1)>(DT-1),($P(^(0),U,15)'=""C"")"
 ;S DIC("W")="S FHMEAL=$P(^(0),U,4),FHLOC=$P(^(0),U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHMEAL=""B"":""Break"",FHMEAL=""N"":""Noon"",1:""Even""),FH11=FHMEAL_""  ""_FHLOCN D EN^DDIOL(FH11,"""",""?3"")"
 ;S DIC="^FHPT(FHDFN,""OP"",",DIC(0)="Q",DA=FHDFN,X="??" D ^DIC
SF0 ;ask for outpatient SF.
 K DIC S DIC(0)="AEQM"
 S DIC("W")="S FHMEAL=$P(^(0),U,4),FHLOC=$P(^(0),U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHMEAL=""B"":""Break"",FHMEAL=""N"":""Noon"",1:""Even""),FH11=FHMEAL_""  ""_FHLOCN D EN^DDIOL(FH11,"""",""?3"")"
 S DIC("S")="I $P(^FHPT(FHDFN,""OP"",+Y,0),U,1)>(DT-1),($P(^(0),U,15)'=""C"")"
 S DIC="^FHPT(FHDFN,""OP"","
 S DIC("?")="Select a Date, '^' to exit"
 S DIC("A")="Select the Outpatient Date :" D ^DIC K DIC Q:(Y'>0)!$D(DTOUT)
 S ADM=+Y
 S FHMEAL=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,4)
 Q
 ;
OIS ;Outpatient Individualized SF
 Q:'NM
 I '$D(FHX) S FHX="ALL"
 I (FHX="ALL")!($L(FHX)=3) S FHIDI="BNE"
 I $L(FHX)=2 S FHIDI=$S(FHX="NB":"BN",FHX="EB":"BE",FHX="EN":"NE",1:FHX)
 I $L(FHX)=1 S FHIDI=FHX
 F FHII=1,2,3 S FHMEAL=$E(FHIDI,FHII) Q:FHII'>0!(FHMEAL="")  D G0
 D G6
 Q
G0 ;process each meals for individualized SF.
 S T1=$S(FHMEAL="B":"10am",FHMEAL="N":"2pm",1:"8pm")
 S KK=$S(FHMEAL="B":1,FHMEAL="N":5,1:9)
 ;I NM'=1 D CAN^FHNO5,ADD^FHNO5
 S DIC="^FH(118,",DIC(0)="EQM",DIC("S")="I $P(^(0),U,3)'=""Y"""
 ;
G1 G:KK>12 G5
 I ((WARD="")&(FHMEAL="B")&(KK>4))!((WARD="")&(FHMEAL="N")&(KK>8)) G G5
 ;I WARD'="" S T1=$P("10am^2pm^8pm","^",KK-1\4+1)
 S T2="#"_(KK-1#4+1),P1=KK*2+3
 S DIC("A")=T1_" Feeding "_T2_": "
 S OLD=$P(PNN,"^",P1) I OLD S DIC("A")=DIC("A")_$P(^FH(118,+OLD,0),"^",1)_"// "
 ;
G2 W !!,DIC("A") R X:DTIME G:'$T!(X["^") G5
 I X="" G:OLD G3 S KK=$S(KK<5:5,KK<9:9,1:13) G G1
 I OLD,X="@" S $P(PNN,"^",P1)="",$P(PNN,"^",P1+1)="" S KK=KK+1 G G1
 D ^DIC G:Y<1 G2 S Y=+Y,K1=$S(KK<5:1,KK<9:5,1:9)
 F L=K1:1:K1+3 I L'=KK,$P(PNN,"^",L*2+3)=Y W *7," .. DUPLICATE OF EXISTING ITEM!" G G2
 S:OLD'=Y $P(PNN,"^",P1)=Y
 ;
G3 S OLD=$P(PNN,"^",P1+1)
 ;
G4 W !,T1," ",T2," Qty: ",$S(OLD="":1,1:OLD),"// " R X:DTIME G:'$T!(X["^") G5
 S:X="@" X=0 I X="" S:OLD="" $P(PNN,"^",P1+1)=1 S KK=KK+1 G G1
 I X'?1N.N!(X>20) W *7," ??" S X="?"
 I X["?" W !?5,"Enter a whole number between 1 and 20" G G4
 I 'X S $P(PNN,"^",P1)="",$P(PNN,"^",P1+1)="" S KK=KK+1 G G1
 S $P(PNN,"^",P1+1)=X,KK=KK+1 G G1
 ;
G5 S KK=3,X="" F T1=0:1:2 S P1=T1*8-1 F T2=1:1:4 S KK=KK+2 I $P(PNN,"^",KK) S P1=P1+2,$P(X,"^",P1,P1+1)=$P(PNN,"^",KK,KK+1)
 ;I X="" D CAN^FHNO5 Q
 Q
 ;
G6 S P1=$P(PNN,"^",29) S:P1="" P1="D" W !!,"Dietary or Therapeutic? ",P1,"// " R Y:DTIME S:'$T!("^"[Y) Y=P1
 S:$P("dietary",Y,1)="" Y="D" S:$P("therapeutic",Y,1)="" Y="T"
 I $P("DIETARY",Y,1)'="",$P("THERAPEUTIC",Y,1)'="" W *7,!?5," Answer D for Dietary use or T for Therapeutic use" G G6
 S $P(X,"^",25)=$E(Y,1),PNN=$P(PNN,"^",1,4)_"^"_X
 ;G:$P(PNO,"^",5,29)=X UPD^FHNO5 D CAN^FHNO5
 S FHPNNSV=PNN
 S FHIDFLG=1
 Q
 ;
CPRSF ;check previous SF
 K PNN
 S (FHDAT,FHSF)=""
CPRS1 I FHSF="" S FHSF=$O(^FHPT(FHDFN,"OP",999999999),-1)
 E  S FHSF=$O(^FHPT(FHDFN,"OP",FHSF),-1)
 Q:'$G(FHSF)
 S FHDAT=$G(^FHPT(FHDFN,"OP",FHSF,0)),FHPRML=$P(FHDAT,U,4),FHPRCN=$P(FHDAT,U,15),FHLOCN=$P(FHDAT,U,3)
 I (FHPRML'=FHMEAL)!(FHPRCN="C")!'$D(^FHPT(FHDFN,"OP",FHSF,"SF",0)) G CPRS1
 S FHI=$P($G(^FHPT(FHDFN,"OP",FHSF,"SF",0)),U,3) Q:FHI'>0
 S PNN=$G(^FHPT(FHDFN,"OP",FHSF,"SF",FHI,0)),FHSFCX=$P(PNN,U,32)
 I $G(FHSFCX) K PNN G CPRS1
 I $P(PNN,U,34)="Y" K PNN Q
 S $P(PNN,U,3)=DUZ,FHNMSAV=$P(PNN,U,4)
 Q
PPRSF ;PROCESS previous SF
 Q:'$D(PNN)
 D NOW^%DTC S NOW=%
 D ADDOUT^FHNO5
 Q
SFEVNT ;
 S FHDTC=0
 S FHLOCN="" I $D(FHLOC),$G(FHLOC),$D(^FH(119.6,FHLOC,0)) S FHLOCN=$P(^(0),U,1)
 S FHDTC=FHDTC+1,DTP=FHOSTDT D DTP^FH S:FHDTC=1 FHDTP=DTP
 S DTP=$P(ENDT,".",1)  D DTP^FH
 I DTP'=FHDTP S FHDTP=FHDTP_" to "_DTP
 I FHADSFF=1 S FHACT="O",FHTXT="Outpatient Supplemental Feeding: "_FHSFMEN_" ("_FHMEAL_") , "_FHLOCN_", "_FHDTP D OPFILE^FHORX
 Q
 ;
KIL G KILL^XUSCLEAN
