IBCOPV1 ;ALB/LDB - CPT LISTING IN MCCR ;30 APR 90
 ;;2.0;INTEGRATED BILLING;**106,260**;21-MAR-94
 ;
 ;MAP TO DGCROPV1
 ;
PRT ;
 N IBQUIT,IBNUM,IBDATE,Z1 S IBQUIT=0
 ;D:$D(DIR) HLP
 D HDR1,HDR F I=0:0 S I=$O(^UTILITY($J,"OPV","AP",I)) Q:'I  S IBNUM=I-1 W ! D SCR Q:IBQUIT  S IBNUM=I W ?1,I_")",?5 S (Y,I1)=+^UTILITY($J,"OPV","AP",I) D DT^DIQ S IBDATE=Y K Y D VT Q:IBQUIT
 ;W:DGCNT>30 !!,"THERE ARE MORE THAN TEN VISITS DURING THE PERIOD THAT THIS STATEMENT COVERS."
 F C=$Y:1:(IOSL-6) W !
 D:'IBQUIT PICK
 G Q2
 ;Q:$D(DIR)
PICK K Y S DIR("A")="Select visits to include in this bill (1-"_IBNUM_"): "
OK S DIR(0)="LAO^1:"_IBNUM_"^K:X[""."" X" D ^DIR
 I $D(DTOUT)!$D(DUOUT) S IBQUIT=1 Q
 Q:X=""
 I $P($$OPV1^IBCU41(IBIFN,1,($L(Y,",")-1)),U,2)'="" G OK
 ;I (DGCNT1+($L(Y,",")-1))>30 W !,"Maximum of 30 visits allowed per bill!",!,"The visits already on the bill along with those selected total more than 30." G OK
 ;I $D(^DIC(36,+^DGCR(399,IBIFN,"M"),0)),$P(^(0),"^",8),+$P(Y,",",2)>0!(DGCNT1&(+$E(Y)>0)) W !,*7,"THIS INSURANCE COMPANY WILL ONLY ACCEPT ONE VISIT PER BILL.",! G OK
OK1 I +Y W !,"YOU HAVE SELECTED VISIT(S) NUMBERED- ",$E(Y,1,$L(Y)-1),!,"IS THIS CORRECT" S %=1 D YN^DICN I %=-1 S IBOUT=1 G Q2
 I +Y,'% W !,"Enter 'Y'es to include these visits.",!,"Enter 'N'o to reselect." G OK1
 I +Y,%=2 G OK
 G:'Y Q1
 S IBVT=Y
 F I=1:1 S:$P(IBVT,",",I) DGAP=$P(IBVT,",",I) Q:$P(IBVT,",",I)']""  D VFILE
 D Q2 Q
VFILE S (DINUM,X)=+^UTILITY($J,"OPV","AP",DGAP)
VFILE1 S DA(1)=IBIFN,DIC(0)="L",DIC="^DGCR(399,"_DA(1)_",""OP"","
 S:'$D(^DGCR(399,DA(1),"OP",0)) ^(0)="^399.043DA^"
 I $D(^DGCR(399,DA(1),"OP",DINUM)) G VFILEQ
 I '$$OPV1^IBCU41(IBIFN,1)!('$$OPV2^IBCU41(DINUM,IBIFN,1)) D  S DGNOADD=1 G VFILEQ
 . W !,?10,"Can't add OP Visit Date of ",$$DAT2^IBOUTL(X)
 S Y=$$DUPCHK^IBCU41(DINUM,IBIFN,1)
 ;I $P(^DGCR(399,IBIFN,0),"^",19)'=2,$O(^DGCR(399,DA(1),"OP",0)),$D(^DGCR(399,"ASC2",DA(1))) W !?4,"Only 1 visit date allowed on bills with Amb. Surg. Codes!" S DGNOADD=1 G VFILEQ
 W !?4,"Adding OP Visit Date of ",$$DAT2^IBOUTL(X)
 K DD,DO D FILE^DICN L ^DGCR(399,IBIFN):1
VFILEQ Q
Q2 S IBQUIT=1 K DIR,DIRUT G Q
Q1 S:$D(DUOUT)!$D(DTOUT) IBOUT=1 K DIR,DIRUT
Q K DA,DGBIL,DGCNT,DGCNT2,DGCOD,DGCT1,IBCD,DGCPT,DGCPT1,IBOPV,IBCOPV1,IBOPV2,IBOPV3,IBOPV4,DGCNT1,DGCNT2,DGDT,DGDT,DGDT1,DGFIL,DGMT,DGMT1,DGNO,DGNOD,DGTYP,DGTYPE,DIC,DIE,DINUM,DR,L,V,X,Y,IBCHG1,IBCHG2,IBRVCE,IBVDT
 K DGTE,I9,DGLP,DGCPT0,DGCPT2,DGCPT3,I7,P,IBVT,DGAP,Z,I4,DGASC,DGCPTS,DGBIL1,DGDIV,DGDAT,DGNOADD,IBFT,IBCODCL Q
 ;
HDR1 W @IOF,?25,"<<<OUTPATIENT VISITS>>>",!! S X="",$P(X,"=",80)="" W X Q
HDR W !,"NO.",?6,"VISIT DATE",?19,"ELIG/MT",?28,"PROVIDER",?45,"BILL# - TYPE",?65,"STOP CD/CLINIC"
 W !,"===",?6,"==========",?19,"=======",?28,"========",?45,"============",?65,"==============="
 Q
VT S I2="" F Z1=1:1 S I2=$O(^UTILITY($J,"OPV",I1,I2)) Q:I2=""!IBQUIT  S I3="" F I4=1:1 S I3=$O(^UTILITY($J,"OPV",I1,I2,I3)) Q:I3=""  S IBOPV3=^UTILITY($J,"OPV",I1,I2,I3) D VT1 Q:IBQUIT
 Q
VT1 D SCR Q:IBQUIT  I (Z1>1)!(I4>1) W:$X>1 ! W ?5,$G(IBDATE)
 W ?19,$P(IBOPV3,"^") W:$P(IBOPV3,"^",2)]"" "/"_$P(IBOPV3,"^",2)
 W:+$P(IBOPV3,U,8) ?28,$E($P($G(^VA(200,+$P(IBOPV3,U,8),0)),"^",1),1,15)
 I Z1=1,I4=1,$P(^UTILITY($J,"OPV","AP",I),"^",4)'="" W ?45,$J($P(^UTILITY($J,"OPV","AP",I),"^",4),7),"-",$P(^UTILITY($J,"OPV","AP",I),"^",5)
 W ?65,$E($P(^UTILITY($J,"OPV",I1,I2,I3),"^",6),1,15)
 W !
 I $P($G(^IBT(356,+$O(^IBT(356,"ASCE",+$P(^UTILITY($J,"OPV",I1,I2,I3),"^",9),0)),0)),"^",19) W ?7,$E("**RNB: "_$P($G(^IBE(356.8,+$P(^(0),"^",19),0)),"^"),1,30)
 I Z1=1,I4=1,$P(^UTILITY($J,"OPV","AP",I),"^",6)'="" W ?45,$J($P(^UTILITY($J,"OPV","AP",I),"^",6),7),"-",$P(^UTILITY($J,"OPV","AP",I),"^",7)
 W ?65,$E($P(^UTILITY($J,"OPV",I1,I2,I3),"^",7),1,15)
 I (Z1=1)&(I4=1) F P=8:2 Q:$P(^UTILITY($J,"OPV","AP",I),"^",P)=""  W !,?45,$J($P(^UTILITY($J,"OPV","AP",I),"^",P),7),"-",$P(^UTILITY($J,"OPV","AP",I),"^",P+1)
 Q
SCR Q:IBQUIT  I $E(IOST,1,2)["C-",$Y+6>IOSL F Y=$Y:1:IOSL-5 W !
 I  W !,"Press return to continue, ""^"" to exit display, or " D PICK I 'IBQUIT W @IOF D HDR1,HDR W !
 Q
HLP ;W !!,"Enter a number between 1 and ",DGCNT," or a list or range separated with commas",!,"or dashes, e.g., 1,3,5 or 2-4,8"
 ;W !,"The number(s) must correspond to a visit." R H:5 K H
 Q
CHG W:(Z1=1)&(I4=1) ?31,$J($P(^UTILITY($J,"OPV","AP",I),"^",2),8) Q
NOVT I 'DGCNT D HDR1 W !!,"NO OUTPATIENT VISITS FOUND DURING THE PERIOD COVERED BY THIS STATEMENT" D Q Q
