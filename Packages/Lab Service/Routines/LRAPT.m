LRAPT ;AVAMC/REG/WTY - AP PATIENT RPT ;9/22/00
 ;;5.2;LAB SERVICE;**72,173,248**;Sep 27, 1994
 ;
 ;Reference to ^%DT supported by IA #10003
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to ^DIC( supported by IA #916
 ;Reference to $$DTIME^XUP supported by IA # -none available-
 ;
 D END S X="T",%DT="" D ^%DT S LRT=Y D D^LRU S LRTOD=Y
 S IOP="HOME" D ^%ZIS
 W @IOF,!?28,"Cum path data summaries"
 S DTIME=$$DTIME^XUP(DUZ),U="^"
ASK W !!?14,"1. DISPLAY cum path data summary for A patient"
 W !?14,"2. PRINT   cum path data summary for   patient(s)",!
 R "Select (1-2): ",X:DTIME G:X=""!(X[U) END
 G:X?1"1".E!(X?1"D".E) ^LRAPS
 I X'?1"2".E&(X'?1"P".E) W $C(7),!!,"Answer  1 or 2",! G ASK
 S LRDICS="SP",(LRDICS(1),LRDICS(2))=1 D ^LRAP G:'$D(Y) END
 D ^LRUL I '$O(^LRO(69.2,LRAA,7,DUZ,1,0)) D R^LRUL G END
 K DIC,DIE,DR S ZTRTN="QUE^LRAPT" D BEG^LRUTL
 D:POP R^LRUL G:POP!($D(ZTSK)) END
QUE U IO S (LRS(5),LRQ(9))=1 D L^LRU,S^LRU,EN^LRUA
 S PNM=0
 F PNM(1)=0:0 S PNM=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",PNM)) Q:PNM=""!(LR("Q"))  D
 .F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",PNM,LRDFN)) Q:'LRDFN!(LR("Q"))  D
 ..D LOOP
 K LRAU
 W:IOST'?1"C".E&($E(IOST,1,2)'="P-"!($D(LR("FORM")))) @IOF
 D R^LRUL,END^LRUTL,END
 Q
LOOP K ^LRO(69.2,LRAA,7,DUZ,1,LRDFN),^LRO(69.2,LRAA,7,DUZ,1,"C",PNM,LRDFN)
 L +^LRO(69.2,LRAA,7,DUZ):1 Q:'$T
 S X(1)=$O(^LRO(69.2,LRAA,7,DUZ,1,0)),X=^(0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 L -^LRO(69.2,LRAA,7,DUZ)
 S DR=1,LRQ=0,LRDPF=$P(^LR(LRDFN,0),U,2),LRPF=^DIC(LRDPF,0,"GL")
 S LRFLN=+$P(@(LRPF_"0)"),"^",2),DFN=$P(^LR(LRDFN,0),"^",3)
 S LRPPT=@(LRPF_DFN_",0)")
 S LRP=$P(LRPPT,"^"),SEX=$P(LRPPT,"^",2),Y=$P(LRPPT,"^",3),SSN=$P(LRPPT,"^",9) D D^LRU,SSN^LRU S DOB=$S(Y[1700:"",1:Y)
 S (LRADM,LRADX)=""
 S LRLLOC=$S($D(@(LRPF_DFN_",.1)")):^(.1),$D(^LR(LRDFN,.1)):^(.1),1:"")
 I LRPF="^DPT(",$D(VAIN) S LRADM=$P(VAIN(7),U,2),LRADX=VAIN(9)
 G:'$D(^LR(LRDFN,"SP"))&('$D(^LR(LRDFN,"CY")))&('$D(^LR(LRDFN,"EM"))) AU
 D ^LRAPT1 S LRV(1)=1
AU Q:LR("Q")  I $D(^LR(LRDFN,"AU")),+^("AU") S LRV(1)=1 D ^LRAPT2
 Q:LR("Q")  I '$D(LRV(1)) D H^LRAPT1 W !!,"NO PATHOLOGY ENTRIES IN LAB FILE !",!
 Q
H ;from LRAPT2, LRAPT3
 I $D(LR("F")),$E(IOST,1,2)["C-" D M^LRU Q:LR("Q")
 D F^LRU W !,"ANATOMIC PATHOLOGY" W:$D(LR("W")) !,LRAA(1)," QA from ",LRSTR," to ",LRLST W !,LR("%") Q
H1 D H Q:LR("Q")  W !,LRP,?32,SSN,?52,"DOB:",DOB Q
 ;
END D V^LRU Q
