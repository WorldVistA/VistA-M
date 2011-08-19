DGOASIH ;ALB/VAD - LIST OF PATIENTS ON ASIH ;Sep 27 1999
 ;;5.3;Registration;**162,227**;Aug 13, 1993
 ;
 ; PATCH 5.3*227 ADDED SEP 27 1999 BY VAD
 ;   Rather than only allow for the entry of tomorrow's date, the
 ;   ability to enter any future date has been added.  However, if
 ;   a future date is entered, then a warning message will display
 ;   stating that the report should be tasked to prevent the printing
 ;   of a negative report.  Line EN3 has been split to allow for the
 ;   code for this patch to be added.
 ;
EN3 K TD,DGF S %DT="AEXPT",%DT("A")="Enter date of ASIH: " D ^%DT G QUIT:Y'>0
 ; *** Start of patched code inserted for 5.3*227 - VAD.
 I +Y>+DT D  G:DGU QUIT
 . W !!?10,$C(7),"You have entered a future date...to prevent the printing"
 . W !?10,"of a negative report, remember to task this request for"
 . W !?10,"the appropriate date."
 . S DGU=0 D RT
 ; *** End of patched code.
 ;
 S DGT=+Y,DGT=$S(DGT[".":DGT,1:DGT_".2400")
 S Y=DGT X ^DD("DD") S DGDAY=$P(Y,"@") S DGHD="ASIH LIST FOR "_Y,X1=DT,X2=-30 D C^%DTC S DGPG=0
 S DGVAR="DGT^DGPG^DGDAY^DGHD",DGPGM="START^DGOASIH" D ZIS^DGUTQ I 'POP U IO D START^DGOASIH
QUIT K DGHD,DGST I '$D(ZTQUEUED) D CLOSE^DGUTQ
QUIT1 K %,%I,%T,%DT,DFN,DG2,DGADM,DGCA,DGCD,DGCL,DGD,DGDAY,DGDV,DGFL,DGI,DGJ,DGLV,DGNO,DGP,DGPG,DGPGM,DGRT,DGSTART,DGT,DGTIME,DGTP,DGU,DGVAR,DGW,DGA,DGDAT,DGDFN,DGDT,DGIFN,DGNOW,DGTYP,DGX,DGY,POP,VA,VADAT,VADATE,VAERR,^UTILITY($J,"DG"),X,X1,X2,Y
 K M,VAIP,VAIP("D") Q
START D NOW^%DTC S Y=$E(%,1,12) S DGTIME=$$FMTE^XLFDT(Y,1) S $P(DGCL,"-",81)="",DGFL=0,X1=DGT,X2=-32 D C^%DTC S DGSTART=X
 D NOW^%DTC S DGNOW=%
 S DGA="^13^43^44^45^"
 S DGDAT=DGT,DGST=0,DGPG=0
 F DGDT=DGSTART:0 S DGDT=$O(^DGPM("AMV2",DGDT)) Q:'DGDT!(DGDT>DGDAT)  F DFN=0:0 S DFN=$O(^DGPM("AMV2",DGDT,DFN)) Q:'DFN  F DGIFN=0:0 S DGIFN=$O(^DGPM("AMV2",DGDT,DFN,DGIFN)) Q:'DGIFN  S DGASIH=1 D CK^DGPASS Q:DGFL
 K DGASIH I '$D(^UTILITY($J,"DG")) W !!?8,"*** THERE ARE NO PATIENTS OUT ON ASIH FOR "_DGDAY_" ***" G QUIT
 D WR
 G QUIT
HEAD S DGPG=DGPG+1 W @IOF,!,DGHD,?35,"PRINTED: ",DGTIME,?72," PAGE: "_DGPG
 W !!,"NAME",?22,"PT ID",?38,"LEFT",?54,"LOCATION"
 W !,DGCL,!!,?10,"DIVISION: ",$S(DGDV="ZUNKNOWN":"UNKNOWN",1:DGDV),!
 Q
WR S (DGU,DGDV,DGFL,DGP)=0
 F DGD=0:0 S DGDV=$O(^UTILITY($J,"DG",DGDV)) Q:DGDV=""!(DGU)  S DGPG=0 D:DGFL RT Q:DGU  D HEAD F M=0:0 S DGP=$O(^UTILITY($J,"DG",DGDV,DGP)) Q:DGP=""!(DGU)  D WRCNT
 W ! Q
WRCNT F DFN=0:0 S DFN=$O(^UTILITY($J,"DG",DGDV,DGP,DFN)) Q:'DFN!(DGU)  S DGNO=^UTILITY($J,"DG",DGDV,DGP,DFN) D WR1 S DGFL=1
 Q
WR1 I $Y+4>IOSL D:IOST?1"C-".E RT Q:DGU  D HEAD
 W !,$E(DGP,1,20),?22,$P(DGNO,"^"),?38 S X=$P(DGNO,"^",2) W X W ?54,$P(DGNO,"^",3) Q
RT Q:IOST'?1"C-".E
 F X=$Y:1:(IOSL-2) W !
 R !?22,"Enter <RET> to continue or ^ to Quit",X:DTIME S:X["^"!('$T) DGU=1 Q:DGU=1
 Q
