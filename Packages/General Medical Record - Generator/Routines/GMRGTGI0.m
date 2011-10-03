GMRGTGI0 ;CISC/RM-PRIME DOCUMENT EDIT (cont.) ;1/9/89
 ;;3.0;Text Generator;;Jan 24, 1996
CHK ; CHECK FOR DUPLICATE .01 FIELD, IF THE SAME SET GMRGOUT=1
 S GMRGDUP=0 Q:$P(GMRGINFO("CLAS"),"^",2)="PRIME DOCUMENT"  F X=0:0 S X=$O(^GMRD(124.2,"B",GMRGT,X)) Q:X'>0  I X'=GMRGINFO S GMRGDUP=1 Q
 S GMRGX=GMRGT
 I 'GMRGDUP F X=0:0 Q:GMRGDUP  S GMRGX=$O(^GMRD(124.2,"B",GMRGX)) Q:GMRGX=""!($E(GMRGX,1,$L(GMRGT))'=GMRGT)  F GMRGX(0)=0:0 S GMRGX(0)=$O(^GMRD(124.2,"B",GMRGX,GMRGX(0))) Q:GMRGX(0)'>0  D DF Q:GMRGDUP
 Q:'GMRGDUP
 S X=GMRGT,DIC(0)="",DIC="^GMRD(124.2,",DIC("S")="I +Y'=GMRGINFO,+$P(^(0),U,2)'<+$P(GMRGINFO(""TYPE""),U)" D ^DIC K DIC S GMRGDUP=$S(+Y>0:1,1:2)
 W !!,$C(7),"By changing '"_$P(GMRGINFO("TEXT"),"^")_"' to '"_GMRGT_"'",!,"you may have created a duplicate term."
DUPOK W !,"Would you like to look at the list of possible duplicates" S %=2 D YN^DICN S:%=-1 GMRGOUT=1 S:%=2 GMRGDUP=0 Q:%=-1!(%=2)
 I '% W !?3,$C(7),"Answer 'YES' if you think you may want to use one of the duplicates",!?3,"instead of this term, answer 'NO' if you want to change the text of",!?3,"the term you are presently editing." G DUPOK
 G:GMRGDUP=1 DUPRO
CHDUP ;
 W "  If you meant to use one of the ",!,"following selections instead enter the appropriate number, else press '^'.",!
 S DX=$X,DY=0 X ^%ZOSF("XY") S DIC="^GMRD(124.2,",X=GMRGT,DIC(0)="EZ",DIC("S")="I +Y'=GMRGINFO,+$P(^(0),U,2)'<+$P(GMRGINFO(""TYPE""),U)" D ^DIC I $D(DTOUT) S GMRGOUT=1 Q
 I +Y'>0 S GMRGDUP=0 Q
 G DUPFND
DUPRO ;
 W !!,GMRGT S DX=$X,DY=0 X ^%ZOSF("XY") S DIC("S")="I +Y'=GMRGINFO,+$P(^(0),U,2)'<+$P(GMRGINFO(""TYPE""),U)",DIC(0)="OZE",DIC="^GMRD(124.2,",X=GMRGT D ^DIC
DUPYN W !,"Did you mean to use the above selection instead" S %=0 D YN^DICN I %'=0 S:%=-1 GMRGOUT=1 S:%=2 GMRGDUP=0 Q:%=-1!(%=2)
 I '% W !?5,"Answer Yes if you want to use the above selection instead of creating",!?5,"a duplicate, answer No if you want to create a duplicate." G DUPYN
DUPFND ;
 S GMRGNUP=$S($D(^TMP($J,"GMRGINFO",GMRGLEVL)):$P(^(GMRGLEVL),"^"),1:"") Q:GMRGNUP'>0
 S GMRGCYC(0)=+Y,GMRGND=GMRGNUP,GMRGCYC=0 D FNDPRM^GMRGRUT0 K:'GMRGCYC GMRGCYC I $D(GMRGCYC)!(+Y=GMRGNUP) W !?5,$C(7),"ADDING THIS TERM WOULD CREATE AN INVALID DATA CONDITION, CANNOT ADD!!" K GMRGCYC Q
 S GMRGANW=+Y W !,".replacing '",$P(GMRGINFO("TEXT"),"^"),"' with '",Y(0,0),"'."
 S GMRGDOL=$O(^GMRD(124.2,GMRGNUP,1,"B",GMRGINFO,0)) Q:GMRGDOL'>0  W "."
 S DA(1)=GMRGNUP,DA=GMRGDOL,DIK="^GMRD(124.2,DA(1),1," D ^DIK W "." S DIC=DIK,X=GMRGANW,DIC(0)="Q",DINUM=GMRGDOL K DD D FILE^DICN W "." I +Y>0 K GMRGINFO S GMRGINFO=$P(Y,"^",2) D INFOSET W "."
 Q
DF ;
 I GMRGX(0)'=GMRGINFO,$D(^GMRD(124.2,GMRGX(0),0)),+$P(^(0),"^",2)'<+$P(GMRGINFO("TYPE"),"^") S GMRGDUP=1 Q
 Q
INFOSET ; FOR AN AGGY TERM WITH ENTRY OF GMRGINFO, WILL SET GMRGINFO ARRAY
 S GMRGX=$S($D(^GMRD(124.2,GMRGINFO,0)):^(0),1:""),GMRGINFO("TEXT")=$P(GMRGX,"^")_"^"_$P(GMRGX,"^",5),GMRGINFO("TYPE")=$P(GMRGX,"^",2),GMRGINFO("PACK")=$P(GMRGX,"^",3)
 S GMRGINFO("CLAS")=$P(GMRGX,"^",4)_"^"_$S($P(GMRGX,"^",4)="":"",$D(^GMRD(124.25,$P(GMRGX,"^",4),0)):$P(^(0),"^"),1:""),GMRGINFO("MIN")=$P(GMRGX,"^",6),GMRGINFO("MAX")=$P(GMRGX,"^",7),GMRGINFO("FORM")=$P(GMRGX,"^",8)
 S GMRGINFO("ADD")=$P(GMRGX,"^",9),GMRGINFO("SPLIT")=$P(GMRGX,"^",10),GMRGINFO("TTOP")=$P(GMRGX,"^",11),GMRGINFO("SMES")=$P(GMRGX,"^",12)
 S GMRGINFO("LEAD")=$S($D(^GMRD(124.2,GMRGINFO,4)):$P(^(4),"^"),1:""),GMRGINFO("TRAIL")=$S($D(^GMRD(124.2,GMRGINFO,5)):$P(^(5),"^"),1:""),GMRGINFO("ACTS")=$S($D(^GMRD(124.2,GMRGINFO,7)):$E(^(7),1,245),1:"")
 S GMRGINFO("ACTF")=$S($D(^GMRD(124.2,GMRGINFO,8)):$E(^(8),1,245),1:""),GMRGY="",GMRGX=1
 F GMRGY(1)=0:0 S GMRGY=$O(^GMRD(124.2,GMRGINFO,1,"AC",GMRGY)) Q:GMRGY=""  F GMRGY(0)=0:0 S GMRGY(0)=$O(^GMRD(124.2,GMRGINFO,1,"AC",GMRGY,GMRGY(0))) Q:GMRGY(0)'>0  I $D(^GMRD(124.2,GMRGINFO,1,GMRGY(0),0)),'$P(^(0),"^",6) D SETSEL
 S GMRGINFO("SEL")=GMRGX-1
 Q
SETSEL ;
 S GMRGZ=^GMRD(124.2,GMRGINFO,1,GMRGY(0),0),GMRGZ(0)=$S(+GMRGZ'>0:"",$D(^GMRD(124.2,+GMRGZ,0)):^(0),1:""),GMRGINFO("SEL",GMRGX)=GMRGY(0)_"^"_+GMRGZ_"^"_$P(GMRGZ(0),"^")_"^"_$P(GMRGZ,"^",7),GMRGX=GMRGX+1
 Q
