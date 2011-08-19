RMPOUTL0 ;NG/CAP - HOME OXYGEN FUNCTIONS ;7/24/98
 ;;3.0;PROSTHETICS;**29,44**;Feb 09, 1996
 ;
SITE(X) ;Set up RMPO site parameters.
 D HOSITE
 Q
 ;
HOSITE ;New entry point that should replace SITE(X).
 ;Initialize device.
 D HOME^%ZIS
 S QUIT=0
 ;Set up site variables.
 ;N RMPRSITE,RMPR
 K RMPO
 D DIV4^RMPRSIT
 I $D(Y),(Y<0) S QUIT=1 Q
 I '$G(RMPRSITE) S QUIT=1 Q
 S RMPRS=$P($G(^RMPR(669.9,RMPRSITE,4)),U,1)
 I '$G(RMPRS) W !,"***The IFCAP SITE is not defined, please check file #669.9.***" S QUIT=1 Q
 I $G(RMPRS),'$D(^PRC(411,RMPRS,0)) W !,"***The IFCAP SITE is not defined, please check file #411.***" S QUIT=1 Q
 M RMPO=RMPR
 S RMPOSITE=RMPO("STA")
 S (RMPOXITE,RMPOREC)=RMPRSITE
 Q
