SDAMO0 ;ALB/MJK - AM Mgt Reports ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
CLINIC ; -- select clinics
 ; -- call generic clinic screen, correct division
 ;
 S DIC("S")="I $$CLINIC^SDAMU(Y),$S(VAUTD:1,$D(VAUTD(+$P(^SC(Y,0),U,15))):1,'+$P(^(0),U,15)&$D(VAUTD(+$O(^DG(40.8,0)))):1,1:0)"
 S DIC="^SC(",VAUTSTR="clinic",VAUTVB="VAUTC",VAUTNI=2
 D FIRST^VAUTOMA
 Q
 ;
DISP() ; -- display selection choices
 ;    input: all selection variables
 ;   output: none
 ; return: displayed w/o mishap [ 1|yes   0|no]
 ;
 D HOME^%ZIS W @IOF,*13
 W $$LINE^SDAMO("Report Specifications")
 W !!,"   Encounter Dates: ",$$FDATE^VALM1(SDBEG)," to ",$$FDATE^VALM1(SDEND)
 W !,"  Encounter Status: ",$P($T(SELECT+SDSEL^SDAMO2),";;",2)
 W:$D(SDSORT) !,"         Sorted By: ",$P($T(SORT+SDSORT^SDAMO2),";;",2)
 W !!?15,"Divisions",?55,$S(SDSORT=1!(SDSORT=2)!(SDSORT=5):"Clinics",1:"Stop Codes")
 W !?15,"---------",?55,"----------"
 S (D,C)=0
 I VAUTD!VAUTC S D=$S(VAUTD:"All",1:$O(VAUTD(0))),C=$S(VAUTC:"All",1:$O(VAUTC(0))) W !?15,$S(D:VAUTD(D),1:D),?55,$S(C:VAUTC(C),1:C)
 S D=+D,C=+C
 F I=1:1 S:D'="" D=$O(VAUTD(D)) S:C'="" C=$O(VAUTC(C)) Q:'D&('C)  W ! W:D ?15,VAUTD(D) W:C ?55,VAUTC(C) I I>9 S I=0 D PAUSE^VALM1 I 'Y G DISPQ
 W !,$$LINE^SDAMO("")
 S Y=1
DISPQ Q Y
