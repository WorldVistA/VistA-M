LRTSTOUT ;SLC/CJS-JAM TESTS OFF ACCESSIONS ;8/11/97
 ;;5.2;LAB SERVICE;**100,121,153,202,221,337**;Sep 27, 1994;Build 2
 ;Cancel tests - Test are no longer deleted, instead the status is changed to Not Performed.
EN ;
 D ^LRPARAM Q:$G(LREND)
 I '$D(LRLABKY) W !?5,"You are not authorized to change test status.",!,$C(7) S LREND=1 Q
 K LRXX,LRSCNXB W @IOF
 F  S (LREND,LRNOP)=0 D FIX D  I $G(LREND) D END Q
 . I $G(LREND) D END S LREND=1 Q
 . K DIC D:'$G(LRNOP) CHG D END
 Q
FIX S (LREND,LRNOP)=0,LRNOW=$$NOW^XLFDT
 W ! S LRACC=1 D LRACC Q:$G(LRNOP)
 K LRACC,LRNATURE I $G(LRAN)<1 S LREND=1 Q
 I '$P($G(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0)),U,2) W !?5,"Accession has no Test ",! S LRNOP=1 Q
 L +^LRO(68,LRAA,1,LRAD,1,LRAN):1 I '$T W !,"Someone else is working on this accession",! S LRNOP=1 Q
 S LRX=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRACN=$P(^(.2),U),LRUID=$P(^(.3),U)
 S LRDFN=+LRX,LRSN=+$P(LRX,U,5),LRODT=+$P(LRX,U,4)
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX W !,PNM,?30,SSN
 S LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,5) L +^LR(LRDFN,LRSS,LRIDT):1 I '$T W !,"Someone else is working on this data." L -^LRO(68,LRAA,1,LRAD,1,LRAN) S LRNOP=1 Q
 I '$G(^LR(LRDFN,LRSS,LRIDT,0)) W !?5," Can't find Lab Data for this accession",! D UNLOCK S LRNOP=1 Q
 I LRODT,LRSN,$D(^LRO(69,LRODT,1,LRSN,0))#2 D
 . N LRACN,LRAA,LRAD
 . D SHOW^LROS
 K DIR S DIR(0)="E" D ^DIR S:$E(X)=U LRNOP=1 Q:$G(LRNOP)
FX1 ;
 D SHOWTST
 Q
CHG K LRCTST,DIC W !
 N LRIFN
 S:'$D(DIC("A")) DIC("A")="Change which LABORATORY TEST: "
 S DIC="^LRO(68,"_LRAA_",1,"_LRAD_",1,"_LRAN_",4,",DIC("S")="I '$L($P(^(0),U,5))",DIC(0)="AEMOQ"
 F  D ^DIC Q:Y<1  S LRCTST(+Y)=$P(^LAB(60,+Y,0),U),DIC("A")="Select another test: "
 K DIC I '$O(LRCTST(0)) D  Q
 . L -^LR(LRDFN,LRSS,LRIDT) L -^LRO(68,LRAA,1,LRAD,1,LRAN)
 . W !?5,"No Test Selected",!
 I '$L(LRODT)&'$L(LRSN) W !,"NO CHANGE" D UNLOCK,END Q
 K LRCCOM S LRCCOM="",LREND=0 I '$D(^LRO(69,LRODT,1,LRSN,0))#2 W !?5,"There is no Order for this Accession",! D UNLOCK,END Q
 W @IOF,!!?5,"Change Accession : ",LRACN,?40,"UID: ",LRUID
 S I=0 F  S I=$O(LRCTST(I)) Q:I<1  W !?10,LRCTST(I)
 D FX2 Q:$G(LREND)
 S LRTSTS=0 F  S LRTSTS=$O(LRCTST(LRTSTS)) Q:LRTSTS<1  D
 . Q:'$D(^LAB(60,LRTSTS,0))#2  S LRTNM=$P(^(0),U)
 . S LRORDTST=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSTS,0),U,9) D SET,CLNPENDG
 . W:'$G(LREND) !?5,"[ "_LRTNM_" ] ",$S('$D(LRLABKY):" Marked Canceled by Floor",1:" Marked Not Performed"),!
 S LREND=0 K LRCTST
 Q
SHOWTST ;
 N LRI,LRN,DIR,LRY,LRIC,X
 S DIR(0)="E"
 D DEMO
 S LRN=0,LRI=0 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:LRI<1!($G(LRY))  D
 . S LRIC=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0)),U,4,6) Q:'$D(^LAB(60,+LRI,0))#2  W !,?5,$P(^(0),U) S LRN=LRN+1 I LRIC  D
 . . W ?35,"  "_$S($L($P(LRIC,U,3)):$P(LRIC,U,3),1:"Completed")_"  "_$$FMTE^XLFDT($P(LRIC,U,2),"5FMPZ")_" by "_$P(LRIC,U)
 . I LRN>18 D ^DIR S:$E(X)=U LRY=1 Q:$G(LRY)  D DEMO S LRN=0
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRODT=$P(X,U,4),LRSN=$P(X,U,5)
 Q
DEMO W !,PNM,?50,SSN
 W !,"TESTS ON ACCESSION: ",LRACN,?40,"UID: ",LRUID
 Q
SET ;
 S:'$G(LRNOW) LRNOW=$$NOW^XLFDT
 S LRLLOC=$P(^LRO(69,LRODT,1,LRSN,0),U,7) D
 . N II,X,LRI,LRSTATUS,OCXTRACE
 . S:$G(LRDBUG) OCXTRACE=1
 . S LRI=0 F  S LRI=$O(^LRO(69,LRODT,1,LRSN,2,LRI)) Q:LRI<1  I $D(^(LRI,0))#2,LRTSTS=+^(0) S (LRSTATUS,II(LRTSTS))="" D  K II
 . . Q:$P(^LRO(69,LRODT,1,LRSN,2,LRI,0),U,11)  S ORIFN=$P(^(0),U,7)
 . . S X=1+$O(^LRO(69,LRODT,1,LRSN,2,LRI,1.1,"A"),-1),X(1)=$P($G(^(0)),U,4)
 . . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,X,0)=$P($G(LRNATURE),U,5)_": "_LRCCOM,X=X+1,X(1)=X(1)+1
 . . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,X,0)=$S($G(LRMERG):"*Merged:",'$D(LRLABKY):"*Cancel by Floor:",1:"*NP Action:")_$$FMTE^XLFDT(LRNOW,"5MZ")
 . . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,0)="^^"_X_"^"_X(1)_"^"_DT
 . . I $G(ORIFN),$D(II) D NEW^LR7OB1(LRODT,LRSN,$S($G(LRMSTATI)=""!($G(LRMSTATI)=1):"OC",1:"SC"),$G(LRNATURE),.II,LRSTATUS)
 . . I ORIFN,$$VER^LR7OU1<3 D DC^LRCENDE1
 . . S $P(^LRO(69,LRODT,1,LRSN,2,LRI,0),"^",9)="CA",$P(^(0),U,10)="L",$P(^(0),U,11)=DUZ
 . . S:$D(^LRO(69,LRODT,1,LRSN,"PCE")) ^LRO(69,"AE",DUZ,LRODT,LRSN,LRI)=""
 K ORIFN,ORSTS
 I $D(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0))#2,$D(^(4,$G(LRTSTS),0))#2 S $P(^(0),U,4,6)=DUZ_U_LRNOW_U_$S($G(LRMERG):"*Merged",1:"*Not Performed") D
 . S LROWDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),U,3) I LROWDT,LROWDT'=LRAD D ROL Q
 . S LROWDT=+$G(^LRO(68,LRAA,1,LRAD,1,LRAN,9)) I LROWDT D ROL
 I $G(LRIDT),$L($G(LRSS)),$L(LRCCOM),$G(^LR(LRDFN,LRSS,LRIDT,0)) D
 . D 63(LRDFN,LRSS,LRIDT,LRTNM,LRCCOM)
 . D:'$D(^LRO(68,LRAA,1,LRAD,1,"AD",DT,LRAN)) XREF^LRVER3A
 D EN^LA7ADL($P($G(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),.3)),"^")) ; Put in list to check for auto download.
 Q
ROL ;
 Q:+$G(^LRO(68,LRAA,1,LROWDT,1,LRAN,0))'=LRDFN  Q:'$D(^(4,LRTSTS,0))#2
 S $P(^LRO(68,LRAA,1,LROWDT,1,LRAN,4,LRTSTS,0),U,4,6)=DUZ_U_LRNOW_U_"*Not performed"
 Q
LRACC K LRAN
 S LREND=0,LREXMPT=1 D ^LRWU4 K LREXMPT
 Q:'$G(LRAA)!('$G(LRAN))!('$D(^LRO(68,LRAA,0))#2)
 S DA(2)=LRAA,DA(1)=LRAD,LRSS=$P(^LRO(68,LRAA,0),U,2)
 I '$L(LRSS) S LRAN=0,LRNOP=1 W !?5,"No Subscript for this Accession Area ",!!
 Q
LREND S LREND=1 Q
UNLOCK ;
 L -(^LR($G(LRDFN),$G(LRSS),$G(LRIDT)),^LRO(68,$G(LRAA),1,$G(LRAD),1,$G(LRAN))) D END Q
EXIT ;
 K LRSCNX,LRNOECHO,LRACN,LRLABRV,LRNOW
END ;
 K LRCCOM0,LRCCOM1,LRCCOMX,LREND,LRI,LRL,LRNATURE,LRNOP,LRSCN,LRMSTATI,LRORDTST,LROWDT,LRPRAC,LRTSTS,LRUID
 K Q9,LRXX,DIR,LRCOM,LRAGE,DI,LRCTST,LRACN,LRACN0,LRDOC,LRLL,LRNOW
 K LROD0,LROD1,LROD3,LROOS,LROS,LROSD,LROT,LRROD,LRTT,X4
 D KVA^VADPT,END^LRTSTJAM
 Q
FX2 ;
 S LREND=0
 I '$L($G(LRNATURE)) D DC^LROR6() I $G(LRNATURE)="-1" W !!,$C(7),"Nothing Changed",! S LREND=1 Q
 S LRL=52 I '$D(LRLABKY) G FX3
 K DIR S (LRCOM,LRCCOM1)="" W !
 S DIR(0)="62.5,5",DIR("A")="Select NP comment Lab Description screen  " S:$L($G(LRSCNXB)) DIR("B")=LRSCNXB
 S DIR("?")="Select Lab Description file screen to be used to expand your NP reason."
 S DIR("?",1)=" Press return to accept the default expansion screens."
 S DIR("?",2)="  "
 S DIR("?",3)="Select the Lab Description file expansion screen."
 S DIR("?",4)="The default expansion screens are GENERAL, ORDER and LAB"
 S DIR("?",5)="You may select addition lab description expansion screens"
 S DIR("?",6)="Press return if you want to only use the default screens"
 S DIR("?",7)=" "
 K LRSCNXB,LRNOECHO
 S:'$D(LRSCN) LRSCN="AKL"
 D ^DIR I $E(X)=U S LREND=1 Q
 I $E(X)="@" S LRSCN="AKL",LRSCNXB="" G FX2
 I $L(X) S LRSCNXB=Y(0),LRSCN=LRSCN_Y
FX3 K DIR W !
 S DIR("A")=$S('$D(LRLABKY):"Reason for Cancel",1:"Not Perform Reason ") S:$L($G(LRXX)) DIR("B")=$G(LRXX)
 S DIR(0)="FU^1:"_LRL_"^"
 D ^DIR I $E(X)=U S LREND=1 Q
 I '$L(X) W !,"You must enter Reason",! G FX2
 I $D(LRLABKY) S LRXX=Y,Q9="1,"_LRL_","_LRSCN D COM^LRNUM
 I '$D(X) G FX2
 I $E(X,$L(X))=" " S X=$E(X,1,($L(X)-1))
 S (LRCCOM,LRCCOMX)=X
 I '$D(LRLABKY) W !,"("_LRCCOM_")"
 K DIR S DIR(0)="Y",DIR("A")="Satisfactory Comment ",DIR("B")="Yes"
 D ^DIR W ! K DIR
 I Y'=1 G FX2
 S LRCCOM=$E($S('$D(LRLABKY):"*Floor Cancel Reason:",1:"*NP Reason:")_LRCCOM,1,68)
 Q
 ;
63(LRDFN,LRSS,LRIDT,LRTNM,LRCCOM) ;
 N X,Y,D0,D1,DA,DR,DIC,DIE,LRCCOM0,LRNOECHO,DLAYGO
 S DLAYGO=63,DIC(0)="SL"
 S:'$G(LRNOW) LRNOW=$$NOW^XLFDT
 S LRNOECHO=1
 S LRCCOM0=$E("*"_LRTNM_$S($G(LRMERG):" Merged: ",'$D(LRLABKY):" Floor Canceled: ",1:" Not Performed: ")_$$FMTE^XLFDT(LRNOW,"5FMPZ")_" by "_DUZ,1,68)
 S DA=LRIDT,DA(1)=LRDFN,DIE="^LR("_LRDFN_","""_LRSS_""","
 S LRCCOM0=$TR(LRCCOM0,";","-") ; Strip ";" - FileMan uses ";" to parse DR string.
 S DR=".99///^S X="_""""_LRCCOM0_"""" D ^DIE
 Q:LRSS="MI"
631 K D0,D1,DA,DR,DIC,DIE
 S DIC(0)="SL"
 S DA=LRIDT,DA(1)=LRDFN,DIE="^LR("_LRDFN_","""_LRSS_""",",DIC=DIE
 S LRCCOM=$TR(LRCCOM,";","-") ; Strip ";" - FileMan uses ";" to parse DR string.
 S LRCCOM=$TR(LRCCOM,"""","'") ; Change " to ' -- " causes FileMan error.
 S DR=".99///^S X="_""""_LRCCOM_""""
 D ^DIE
 Q
CLNPENDG ;Remove pending from Lab test when set to not performed
 N LRIFN
 S LRIFN=$P($G(^LAB(60,LRTSTS,.2)),U)
 Q:LRIFN=""
 S:$P($G(^LR(LRDFN,LRSS,LRIDT,LRIFN)),U)="pending" $P(^LR(LRDFN,LRSS,LRIDT,LRIFN),U)=""
 Q
