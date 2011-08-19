SDUL2 ;ALB/MJK - List Manager Utilities; 4/22/92
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
SEL ; -- select w/XQORNOD(0) defined
 D EN(XQORNOD(0)) Q
 ;
EN(SDULNOD) ; -- generic selector
 ; input passed: SDULNOD := var in XQORNOD(0) format
 K SDULY
 S BG=+$O(@SDULAR@("IDX",SDULBG,0))
 S LST=+$O(@SDULAR@("IDX",SDULST,0))
 I 'BG W !!,*7,"There are no '",SDUL("ENTITY"),"s' to select.",! S DIR(0)="E" D ^DIR K DIR D OUT G ENQ
 S Y=$TR($P($P(SDULNOD,U,4),"=",2),"/\; .",",,,,,")
 I Y["-" S X=Y,Y="" F I=1:1 S J=$P(X,",",I) Q:J']""  I +J>(BG-1),+J<(LST+1) S:J'["-" Y=Y_J_"," I J["-",+J,+J<+$P(J,"-",2) F L=+J:1:+$P(J,"-",2) I L>(BG-1),L<(LST+1) S Y=Y_L_","
 I 'Y S DIR(0)="L^"_BG_":"_LST,DIR("A")="Select "_SDUL("ENTITY")_"(s)" D ^DIR K DIR I $D(DIRUT) D OUT G ENQ
 ;
 ; -- check was valid entries
 S SDERR=0 F I=1:1 S X=$P(Y,",",I) Q:'X  I X<BG!(X>LST) D
 .W:'SDERR ! W !,*7,"Selection '",X,"' is not a valid choice."
 .S SDERR=1
 I SDERR D PAUSE^SDUL1 G ENQ
 ;
 F I=1:1 S X=$P(Y,",",I) Q:'X  S SDULY(X)=""
ENQ K Y,X,BG,SDERR,LST,DIRUT,DTOUT,DUOUT,DIROUT Q
 ;
OUT ; -- set variables to quit
 S SDULBCK=$S(SDULCC:"",1:"R")
 Q
 ;
MENU ;
 N SDULX
 S SDULX=$G(^DISV($S($D(DUZ)#2:DUZ,1:0),"SDULMENU",SDUL("PROTOCOL"))) S:SDULX="" (SDULX,^(SDUL("PROTOCOL")))=1
 W ! S DIR(0)="Y",DIR("A")="Do you wish to turn auto-display "_$S(SDULX:"'OFF'",1:"'ON'")_" for this menu",DIR("B")="NO" D ^DIR K DIR
 I Y S (SDULMENU,^DISV($S($D(DUZ)#2:DUZ,1:0),"SDULMENU",SDUL("PROTOCOL")))='SDULX
 D FINISH^SDUL4
 Q
