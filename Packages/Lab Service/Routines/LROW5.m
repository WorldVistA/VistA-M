LROW5 ;SLC/CJS - LAB ORDER ENTRY, WARD ;2/6/91  13:59 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
NEXTCOL ;return LRODT, from LRORD, LROW
 S E=$D(^LAB(69.9,1,2,"AC",LRLLOC)),LRTXP=$S(E:"1^1^1^1^1^1^1",1:^LAB(69.9,1,5)),LRTX=$S(LRLWC="WC"!(LRLWC="SP"):"T",1:"T+"_$P(LRTXP,U,$H#7+1))
 S LRCOL=$O(^LAB(69.9,1,4,$P($H,",",2))) I LRCOL,LRLWC="LC" S LRTX="T"
 I LRLWC="LC",'$O(^LAB(69.9,1,4,0)) W !!?7,$C(7),"Routine Lab Collect is not available ",! Q
 S LRTXD=DT G W5:LRLWC'="LC" I 'E S X=LRTX,%DT="" D ^%DT S LRTXD=Y I '$P(LRPARAM,"^",10),$D(^HOLIDAY(Y,0)) S D=$P(X,"+",2),LRTX="T+"_(D+$P(^LAB(69.9,1,5),U,(D+$H)#7+1))
W4 I LRCOL>0&(LRLWC["LC") D OTHER W !,"Next collection order cut-off time at " S Y=$P(^LAB(69.9,1,4,LRCOL,0),U),LRTX="T" D TIME^LROW S %DT("B")=LRTX_"@"_$P(^LAB(69.9,1,4,LRCOL,0),"^",2)
 I 'LRCOL D OTHER W !,"Next collection order cut-off ",LRTX," at " S Y=$P(^LAB(69.9,1,4,$O(^LAB(69.9,1,4,0)),0),U) D TIME^LROW S %DT("B")=LRTX_"@"_$P(^LAB(69.9,1,4,$O(^LAB(69.9,1,4,0)),0),"^",2)
W5 S %DT("A")="SPECIMEN COLLECTION DATE/TIME: ",%DT("B")=$S(LRLWC="WC":"N",LRLWC="LC":$S($D(%DT("B")):%DT("B"),1:LRTX),1:LRTX)
 S %DT=$S(LRLWC="LC":"ETRX",1:"ET") D DATE^LRWU K %DT G LEND^LROW:Y<1 S LRORDTIM=$P(Y,".",2),Y=$P(Y,".",1)
 I $L(Y)=7,Y?7N,'+$E(Y,6,7) W !!?7,$C(7),"Please enter a date, ie. 4/1/90",!! G W5
 S X1=Y,X2=DT D ^%DTC I LRLWC="LC",$P(LRTXP,U,X+$H-1#7+1)'=1 W !,"Can't order for that date.",$C(7) G W4
 I 'E,LRLWC="LC",'$P(LRPARAM,"^",10),$D(^HOLIDAY(Y,0)) W !,"That's ",$P(^HOLIDAY(Y,0),U,2),"!",$C(7) S LRTX="" G W4
 I X>$S(LRLWC="LC":7,1:370) W !,"Can't order more than ",$S(LRLWC="LC":"one week",1:"12 months")," ahead!!",$C(7) G W4
 IF DT>Y W !,"Can't order in the past!!",$C(7) G:LRLWC="LC" W4 G W5
 I LRLWC="LC" S Z=LRORDTIM S Z=$E(Z_"00",1,2)*3600+(60*$E(Z_"0000",3,4)) I DT=Y,Z<$P($H,",",2) W !,"Can't order in the past!!",$C(7) G W4
 I LRLWC="LC" S J="",I=0 F  S I=$O(^LAB(69.9,1,4,"AC",I)) Q:I<1  S J=$O(^LAB(69.9,1,4,"AC",I,J)) I DT=Y,$P($H,",",2)<I,$P($H,",",2)>J,Z'>I W !,"Order cut-off time is expired." G W4
 I LRLWC="LC",$P($G(^LAB(69.9,1,4,+J,0)),U,3)<($E(LRORDTIM_"00",1,2)*3600+($E(LRORDTIM_"0000",3,4)*60)) W !,"Too late to make collection." G W4
 S LRODT=Y I LRLWC="LC",LRORDTIM>0 S X=3600*$E(LRORDTIM_"00",1,2)+(60*$E(LRORDTIM_"0000",3,4)) S Y=$S($D(^LAB(69.9,1,4,"AC",X)):$O(^(X,0)),1:0) I Y=0,$O(^LAB(69.9,1,4,"AC",X)) S X=$O(^LAB(69.9,1,4,"AC",X)),Y=$O(^(X,0))
 I LRLWC="LC",Y>0,LRORDTIM>0 W !,"Routinely collected at approximately: " S Y=$P(^LAB(69.9,1,4,Y,0),U,2) D TIME^LROW
 Q
OTHER W !!,?5,"Collection order cut-off times: " S I=0 F  S I=$O(^LAB(69.9,1,4,I)) Q:I<1  S Y=$P(^(I,0),U,2) W ?38 D TIME^LROW S Y=$P(^LAB(69.9,1,4,I,0),U) W " collection, cutoff time is " D TIME^LROW W !
 Q
