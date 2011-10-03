GMRYUT13 ;HIRMFO/YH-INTRAVENOUS INFUSION PROTOCOL ;10/16/96
 ;;4.0;Intake/Output;;Apr 25, 1997
SEL S GSITE="" I GN=0 S GMROUT=1 K GN,GMRDATA Q
 S (II(1),II(3))=0 F II=1:1:GN Q:GMROUT!II(3)  D WRT S II(1)=II(1)+1 I II(1)>5 D
 . S II(2)="" W !,"Return to continue or ^ to quit listing " R II(2):DTIME I '$T S GMROUT=1 Q
 . I II(2)'="" S II(3)=1 Q
 . S II(1)=0 Q
 Q:GMROUT!$D(GFLAG)  W !!,$S(GOPT="TITER":"Select the number of solution & rate to be adjusted: ",1:"Select a number to be discontinued: ") S X="" R X:DTIME I '$T!(X["^") S GMROUT=1 K GMRDATA,GN,II Q
 I X="" S GMRZ(1)="" K GMRDATA,GN,II Q
 I X>0&(X<(GN+1)) D  K GN,GMRDATA,II Q
 .S GSITE=$P(GMRDATA(+X),"^",4),DA(1)=DFN,DA=+$P(GMRDATA(+X),"^",2),GMRZ=$P(GMRDATA(+X),"^",6),GMRZ(1)=$P(GMRDATA(+X),"^",3),GMRZ(2)=+$P(GMRDATA(+X),"^",7),GMRZ(3)=+$P(GMRDATA(+X),"^",9)
 . S GCATH=$P(GMRDATA(+X),"^",10),GCATH(1)=$P(GMRDATA(+X),"^",11)
 I X=""!(X["?") W !!,"Enter the number of IV which you wish to "_$S(GOPT="ADDSOL"!(GOPT="HANG"):"add a new solution ",GOPT="DCIV":"discontinue",GOPT="TITER":"readjust the rate",1:""),! G SEL
 W !,"Error entry!!!, Please enter a number between 1 and ",GN,! G SEL
 ;
WRT ;
 W !,II_". "_$P(GMRDATA(II),"^",4)_" - "_$P(GMRDATA(II),"^",10)_"   "_$P(GMRDATA(II),"^",11)
 N X S X=$S($P(GMRDATA(II),"^",3)["L":"LOCK/PORT",1:$P(GMRDATA(II),"^",6))
 S X=X_" "_$S($P(GMRDATA(II),"^",3)'["L":" ("_$P(GMRDATA(II),"^",3)_") "_$P(GMRDATA(II),"^",9),1:"")
 S X=X_"  "_$P(GMRDATA(II),"^",8)_" on " S Y=$P(GMRDATA(II),"^") S X=X_$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_"@" X ^DD("DD") S X=X_$P($P(Y,"@",2),":",1,2)
 S DIWR=70,DIWF="",DIWL=0 K ^UTILITY($J) D ^DIWP
 S I=0 F  S I=$O(^UTILITY($J,"W",0,I)) Q:I'>0  W !,?4,^UTILITY($J,"W",0,I,0)
 K ^UTILITY($J) W ! Q
