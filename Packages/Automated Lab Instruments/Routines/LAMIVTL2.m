LAMIVTL2 ;DAL/HOAK 3rd vitek literal verification routine
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12**;Sep 27,1994
INIT ;
CONTROL ;
 S OK=1
 K LRBUX
 K LRKEEP
 D PROBE
 I 'OK QUIT
 K ^TMP($J,"LR"),^TMP($J,"LA"),^LAH(LRLL,1,"VITLIT"),^TMP($J,"LROUT")
 S LRIFN=0
 F  S LRIFN=$O(LRIFN(LRIFN)) Q:LRIFN'>0  D LAH Q:'OK
 D CALL
 S LRIFN=0
 W @IOF
 F  S LRIFN=$O(LRIFN(LRIFN)) Q:LRIFN'>0  D LAH1 Q:'OK
 D LAH2
 D ^LAMIVTL4  ;--->EDIT, OR enter itials
 Q
PROBE ;---------------------------------------------------------------------
 ; If data here it looks like ^LR(LRDFN,"MI",LRIDT,3,LRPIC,DRUGNODE)
 ; where LRPIC is not the IFN in etiology, that is found at
 ; $P(^(3,LRBUG,0),U)
 W !!,"Reviewing for previously entered results:"
 I '$D(^LR(LRDFN,LRSUB,LRIDT,3)) D  ;------NO DATA IN LR FOR THIS ACCN
 .  W !,"NO PREVIOUS DATA FOR THIS ACCN" QUIT
 S LRPIC=0
DISPLAY ;
 K LRDOS
 W @IOF
 K DIR
 S DIR(0)="E"
 F  S LRPIC=$O(^LR(LRDFN,LRSUB,LRIDT,3,LRPIC)) Q:LRPIC'>0!('OK)  D
 .  S LRBUG=$P(^LAB(61.2,+^LR(LRDFN,LRSUB,LRIDT,3,LRPIC,0),0),U)
 .  W !,"Isolate (",LRPIC," )" S LRDOS=1
 .  W !,"  ",LRBUG
 .  S LRRX=1
 .  F  S LRRX=$O(^LR(LRDFN,LRSUB,LRIDT,3,LRPIC,LRRX)) Q:+LRRX'>0  D
 ..  S LRNTRP=^LR(LRDFN,LRSUB,LRIDT,3,LRPIC,LRRX)
 ..  S LRDRUG=$P(^LAB(62.06,$O(^LAB(62.06,"AD",LRRX,0)),0),U)
 ..  W !,$E(LRDRUG,1,30),?32,$P(LRNTRP,U),?38,$P(LRNTRP,U,2)
 ..  S LRD0(LRRX)=LRNTRP
 .  D CHK Q:'OK
 K DIR
 Q
CHK ;
 Q:$GET(LRDOS)'>0
 ; what do you want to do if data in already in ^LR
 W !!,"Look what I found in ",PNM,"'S report.",!,"What do you want me to do with it?"
 S DIR(0)="S^1:Overwrite;2:Keep;3:Edit"
 S DIR("A")="Please choose one of the courses of actions:"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OK=0 QUIT
 ;I Y=3 D VERIFY^LAMIVTL4 QUIT  ;edit existing isolate in ^LR
 I Y=3 D EDIT^LAMIVTL6 D CHKG S LRKEEP(LRPIC)=1 QUIT  ;edit existing isolate in ^LR
 S LRKEEP(LRPIC)=$S(Y=1!(Y=""):0,1:1)
 I Y=1&($G(LRNOTO)=1) D   G CHK
 .  W !,"I will not overwrite verified Data!",*7,*7,!! Q
 Q
CHKG ;
 I $G(^LR(LRDFN,LRSUB,LRIDT,3,LRIDT)) K ^LR(LRDFN,LRSUB,LRIDT,3,LRIDT)
 Q
GETBUG ;
 D ASK  ;Q:'OK
 S $P(^LR(LRDFN,LRSUB,LRIDT,3,LRISO,0),U,2)=$G(LRQUANT(LRISO)),$P(^(0),U,3)=""
 S ^LR(LRDFN,LRSUB,LRIDT,3,LRISO,0)=$O(^LAB(61.2,"B",LRBUG,""))
 ;S ^LR(LRDFN,LRSUB,LRIDT,3,LRISO,1,0)="63.31A"
 ;S $P(^LR(LRDFN,LRSUB,LRIDT,3,LRISO,1,0),U,3)=1,$P(^(0),U,4)=1
 D ORGCOM
 Q
 ;----------------------------------------------------------------------
ASK ; From LAMIAUT2 BY FHS
 K X2
 I $L($P(^LAH(LRLL,1,$P(LRNOD,U),3,$P(LRNOD,U,2),0),U,2)) S X2=$P(^(0),U,2)
 S LREND=0
 W !!,LRISO,". ENTER QUANTITY FOR ( "_LRBUG_" ) : " S LRORGCNT=LRORGCNT+1
 W $S($D(X2):X2_" // ",1:"  ")
 R X:DTIME S:X["^" LREND=1 S:LREND OK=0 Q:'OK
 I $D(X2),'$L(X),X'="@" S X=X2
 S:$E(X)="^" LREND=1 S:LREND OK=0 Q:'OK
 ;I X="@" S $P(^LAH(LRLL,1,LRIFN,3,LRISO,0),U,2)="" Q
 I $E(X)="?" W !?7,"Enter 2-68 characters or a Lab Description" K DIC S X="?",DIC="^LAB(62.5,",DIC(0)="Q",DIC("S")="I LRMICOMS[$P(^(0),U,4)" D ^DIC K DIC G ASK
 I $L(X) X LRMICOM I '$D(X) W !?7,"Enter 2-68 characters " G ASK
 I $L(X) W !,X_"  " S %=1 D YN^DICN G:%'=1 ASK I $L(X) D
 .  S $P(^LAH(LRLL,1,$P(LRNOD,U),3,$P(LRNOD,U,2),0),U,2)=X
 .  S LRQUANT(LRISO)=X
 Q
ORGCOM ;
 I $D(^LR(LRDFN,LRSUB,LRIDT,3,LRISO,1,1,0)) S LRCMNT=^(0)
 S X2=$G(LRCMNT)
 W !,"COMMENT: "
 W $S($D(X2):X2_" // ",1:"  ")
 R X:DTIME S:X["^" LREND=1 S:LREND OK=0 Q:'OK
 I $D(X2),'$L(X),X'="@" S X=X2
 S:$E(X)="^" LREND=1 S:LREND OK=0 Q:'OK
 I X="@" S ^LR(LRDFN,LRSUB,LRIDT,3,LRISO,1,1,0)="" G ORGCOM Q
 I $E(X)="?" W !?7,"Enter 2-68 characters or a Lab Description" K DIC S X="?",DIC="^LAB(62.5,",DIC(0)="Q",DIC("S")="I LRMICOMS[$P(^(0),U,4)" D ^DIC K DIC G ASK
 I $L(X) X LRMICOM I '$D(X) W !?7,"Enter 2-68 characters " G ASK
 I $L(X) W !,X_"  " S %=1 D YN^DICN G:%'=1 ASK I $L(X) D
 .  S ^LR(LRDFN,LRSUB,LRIDT,3,LRISO,1,1,0)=X
 Q
LAH ;
 ;W @IOF
 S LRISO=0
 S LRORGCNT=0
 ; Display all bugs at begining
BUILD F  S LRISO=$O(^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO)) Q:+LRISO'>0!('OK)  D
 .  I $G(LRKEEP(LRISO)) K ^LAH(LRLL,1,LRIFN(LRIFN),3) QUIT
 .  S LRRX=0
 .  S LRCMNT=$P($G(^LAH(LRLL,1,LRIFN(LRIFN),1,LRISO,1,0)),U)
 .  S LRBACT=$P($G(^LAH(LRLL,1,LRIFN(LRIFN),1,LRISO,1,0)),U,2)
 .  S LRBUG=$P(^LAB(61.2,+^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO,0),0),U)
 .  S ^TMP($J,"LR",LRISO,LRBUG)=LRIFN(LRIFN)_U_LRISO
 .  ;-----LIST TO CHECK FOR DUPS IN LAH <--------\/
 .  S LRBUX=^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO,0)
 .  S ^LAH(LRLL,1,"VITLIT",3,LRISO,LRIFN(LRIFN),+LRBUX_$P(LRBUX,U,3))=""
 QUIT
CALL ;
 ;-----------------ALL BUGS AT ONCE---------------
 S LRISO=0
 F  S LRISO=$O(^TMP($J,"LR",LRISO)) Q:LRISO'>0  D
 .  S LRBUG=0
 .  F  S LRBUG=$O(^TMP($J,"LR",LRISO,LRBUG)) Q:LRBUG=""  S LRNOD=^(LRBUG) D
 ..  D GETBUG Q:'OK
 QUIT
 ;-----------------------------------------------------------------------
LAH1 ; Display drugs
 ;W @IOF
 S LRISO=0
 F  S LRISO=$O(^LAH(LRLL,1,"VITLIT",3,LRISO)) Q:+LRISO'>0!('OK)  D
 .  Q:$G(LRKEEP(LRISO))
 .  S LRNORK=0
 .  F  S LRNORK=$O(^LAH(LRLL,1,"VITLIT",3,LRISO,LRNORK)) Q:LRNORK'>0  D
 ..  S LRBUX=""
 ..  S LRBUX=$O(^LAH(LRLL,1,"VITLIT",3,LRISO,LRNORK,LRBUX))
 ..  S ^TMP($J,"LROUT",LRISO,LRBUX)=LRNORK
 .  D PRESTO
 .  S LRRX=0
 .  S LRBUG=$P(^LAB(61.2,+^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO,0),0),U)
 .  S LRBUX=^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO,0)
 .  S ^TMP($J,"LA",3,LRISO,LRIFN(LRIFN),+LRBUX_$P(LRBUX,U,3))=""
 .  D CHKLAH^LAMIVTL3 Q:'LRNOT
 QUIT
LAH2 ;
 ; Print drugs
 S LRISO=0
 F  S LRISO=$O(^TMP($J,"LROUT",LRISO)) Q:LRISO'>0  D
 .  S LRPIN=0
 .  F  S LRPIN=$O(^TMP($J,"LROUT",LRISO,LRPIN)) Q:LRPIN=""  S LRIFN=^(LRPIN),LRIFN(LRIFN)=LRIFN D
 ..  K ^TMP("VITNAME")
 ..  S LRBUG=$P(^LAB(61.2,+LRPIN,0),U)
 ..  W @IOF
 ..  W !,"Isolate (",LRISO," )"
 ..  W !,"   ",LRBUG
 ..  W !,"   ","CARD "_$P(^LAH(LRLL,1,LRIFN(LRIFN),2,2),U,2)
 ..  S LRRX=1
 ..  F  S LRRX=$O(^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO,LRRX)) Q:LRRX=""  D
 ...  S LRNTRP=^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO,LRRX)
 ...  S LRDRUG=$P(^LAB(62.06,$O(^LAB(62.06,"AD",LRRX,0)),0),U)
 ...  S ^TMP("VITNAME",LRDRUG)=LRNTRP
 ...  ;W !,$E(LRDRUG,1,30),?32,LRNTRP
 .. S LRDRUG="" F  S LRDRUG=$O(^TMP("VITNAME",LRDRUG)) Q:LRDRUG=""  D
 ... W !,$E(LRDRUG,1,30),?32,$P(^TMP("VITNAME",LRDRUG),U),?52,$P(^(LRDRUG),U,2),?65,$P(^(LRDRUG),U,3) D CHKPAGE Q:'OK
 ..  Q:'OK
 ..  D PAUSE
 ..  D SET^LAMIVTL3
 Q:'OK
 Q:'$G(LRIFN)  S:$G(LRINTER) LRIFN(LRIFN)=LRINTER
 Q
PRESTO ;
 ; ---    KEEP LRIFN FOR FUTURE USE---------------<<<<<<<<
 S LRINTER=LRIFN(LRIFN)
 S LRPLK=0
 S LRPLK=$O(^LAH(LRLL,1,"VITLIT",3,LRISO,LRPLK))
 S LRIFN(LRIFN)=LRPLK
 Q
PAUSE ;
 S LRDIE=$G(^LAH(LRLL,1,LRIFN(LRIFN),3,LRISO,1,0))  ;SET COMMENT
 S LRCMNT=$P(LRDIE,U)
 S LRBACT=$P(LRDIE,U,2)
 ;R !!,"Touch enter to continue",DHZX:DTIME
 K DIR
 S DIR(0)="E"
 D ^DIR
 I $D(DUOUT) S OK=0
 Q
CHKPAGE ;
 I IOSL-$Y>4 QUIT
 K DIR
 S DIR(0)="E"
 D ^DIR
 I Y["^" S OK=0 QUIT
 W @IOF
 Q
