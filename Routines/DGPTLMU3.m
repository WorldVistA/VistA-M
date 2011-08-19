DGPTLMU3 ;ALB/MTC - PTF ARCHIVE/PURGE LIST MAN UTILITIES CONT ; 9-23-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
SEL ; -- select routine for range of numbers not in continuous sequence
 K VALMY N DGX
 S BG=+$O(@VALMAR@("IDX",VALMBG,0))
 S LST=+$O(@VALMAR@("IDX",VALMLST,0))
 I 'BG W !!,*7,"There are no '",VALM("ENTITY"),"s' to select.",! S DIR(0)="E" D ^DIR K DIR G ENQ
 ;-- check for a selection passed in using XQORNOD(0), then validate
 S Y=$P(XQORNOD(0),"=",2) G:Y VAL
 ;
ASK ;--ask for entries
 W !,"Select PTF Record(s):  ("_BG_"-"_LST_"):" R Y:DTIME G:'$T!(Y["^") ENQ I 'Y D PAUSE^VALM1 G:'Y ENQ G ASK
 ;
VAL ;-- check for valid range
 S SDERR=0
 I Y["-" F I=1:1 S J=$P(Y,",",I) Q:'J  I J["-" D
 . I +J<BG!($P(J,"-",2)>LST) S SDERR=1 W !,!,*7,"Selection '",J,"' is not a valid range."
 ;-- check for valid entries
 F I=1:1 S J=$P(Y,",",I) Q:'J  I J'["-" D
 . I +J<BG!(J>LST) S SDERR=1 W !,!,*7,"Selection '",J,"' is not a valid choice."
 I SDERR D PAUSE^VALM1 G:'Y ENQ G ASK
 ;
 ;-- build 
 I Y["-" S X=Y,Y="" F I=1:1 S J=$P(X,",",I) Q:J']""  I +J>(BG-1),+J<(LST+1) S:J'["-" Y=Y_J_"," I J["-",+J,+J<+$P(J,"-",2) S SDERR=1 D  I SDERR D PAUSE^VALM1 G:'Y ENQ G ASK
 . F L=VALMBG:1:VALMLST S DGX=$O(@VALMAR@("IDX",L,0)) I DGX>(+J-1),DGX<(+$P(J,"-",2)+1) S Y=Y_DGX_",",SDERR=0
 . I SDERR W !,*7,"Selection '",J,"' is not a valid range." S SDERR=1
 ;
 ;-- load VALMY with entries
 F I=1:1 S X=$P(Y,",",I) Q:'X  S VALMY(X)=""
ENQ K Y,X,BG,SDERR,LST,DIRUT,DTOUT,DUOUT,DIROUT Q
 ;
