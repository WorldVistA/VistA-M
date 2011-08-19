WVHS ;HCIOFO/FT-HEALTH SUMMARY INTERFACE ;3/1/99  11:28
 ;;1.0;WOMEN'S HEALTH;**5**;Sep 30, 1998
 ;
UD ; User Defined Health Summary. Called from [WV HS-USER DEFINED] option
 ; Select patient (DFN) and call HS supported call.
 S WVPOP=0 N DFN
 D PATIENT I WVPOP D KILL Q
 N GMP,GMPATT,GMTSPHDR
 I $T(MAIN^GMTSADOR)']"" D  D KILL Q
 .W !,"Sorry, the Health Summary package utility 'MAIN^GMTSADOR' does not exist.",!,"Please contact your IRM support person.",!
 .Q
 D MAIN^GMTSADOR
 D KILL
 Q
PATIENT ; Select a patient (can be male or female)
 N DIC,DTOUT,DUOUT
 S DIC="^DPT(",DIC(0)="AEMQZ"
 D ^DIC
 I Y<0!($D(DTOUT))!($D(DUOUT)) S WVPOP=1 Q
 S DFN=+Y
 Q
KILL ;
 K WVDFN,WVEND,WVPOP,WVSTART,WVTYPE,X,Y
 Q
