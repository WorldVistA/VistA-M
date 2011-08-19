%ZTPP ;SF/RWF - ROUTINE PRETTY PRINT OUTPUT ;12/06/96  15:53
 ;;7.3;TOOLKIT;**4,11,20,70**;Apr 25, 1995
 ;This program can produce routine listings in a paper-saving format
A W !,"Routine Print:"
 N FF,LN,ZTSK I $G(DTIME)'>0 N DTIME S DTIME=360
A2 R !,"Want to start each routine on a new page: Yes// ",FF:DTIME,! G EXIT:FF["^" I FF["?" W !,"Enter Yes to start each routine on a new page.",!?5,"No for the old way." G A2
A3 R !,"Want line numbers: No//",LN:DTIME,!
 G EXIT:LN["^" I LN["?" W !,"Enter Yes to have line numbers, O for offset numbers, No for no line numbers." G A3
 S FF=$TR($E(FF_"Y"),"YyNn","1100"),LN=$TR($E(LN_"N"),"YyNnOo","110022")
 K ^UTILITY($J) X ^%ZOSF("RSEL") I $O(^UTILITY($J," "))="" W !!,"NO routines selected." G EXIT
 K %ZIS,IOP,IOC,ZTIO S %ZIS="MQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^%ZTPP",ZTDTH="",ZTDESC="ROUTINE LIST" F I="FF","LN","^UTILITY($J," S ZTSAVE(I)=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED" G EXIT
DQ ;FF start each routine on a new page, LN line numbers
 N RN,ST,HDR,LC,PG
 S U="^" D NOW^%DTC S Y=% D DD S HDR(2)=Y
 X ^%ZOSF("UCI") S HDR(1)="UCI: "_Y_"    Site: "_$G(^DD("SITE"),"VAMC")
 S IOC=(IO=IO(0)),IOC2=$E(IOST,1,2)["C-"
 U IO W:IOC2 @IOF I 'IOC U IO(0) W !!
 S RN=" ",%Y=IOSL-(255\IOM+1) K %D,%T,%TIM
 F  S RN=$O(^UTILITY($J,RN)) Q:RN=""  D  I 'ST D %Z5:IOC2&IOC
 . S X=RN,XCNP=0,DIF="RTN(" K RTN X ^%ZOSF("LOAD") S LC=XCNP-1
 . IF 'IOC U IO(0) W $J(RN,10) W:$X>70 !
 . U IO S BYTECNT=0,PG=0,OF=0 F I=1:1:LC S BYTECNT=BYTECNT+$L(RTN(I,0))+2
 . D RSUM,%Z3
 . F LI=1:1:LC S X=RTN(LI,0) D:%Y'>$Y %Z3 S Y=$P(X," ",1),X=$P(X," ",2,999) D  ;
 . . I 'LN F J=1:1 W !,Y,?J>1+6," " W:$X>8 "--",!,?8 W $E(X,1,IOM-(J>1+8)) S X=$E(X,IOM-(J>1+7),999),Y="" Q:X=""
 . . I LN S OF=$S(LN=1:LI,$L(Y):0,1:OF+1),J1=$S(LN=1:$J(LI,3),$L(Y):"",1:"+"_OF)
 . . I LN F J=1:1 W !,J1,?4,Y,?J>1+10," " W:$X>12 "--",!,?12 W $E(X,1,IOM-(J>1+12)) S X=$E(X,IOM-(J>1+11),999),Y="",J1="" Q:X=""
 . . Q
 . W:$Y<IOSL !
 . Q
 U IO W !
EXIT K %,%Y,RN,RTN,ST,I,IOC,J,J1,%Z33,HDR,LC,PG,S,X,Y
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q
EXEC ;
RSUM N Y,Y2,%,%1,%2,%3 S (Y,Y2)=0
 F %=1,3:1:LC S %1=RTN(%,0),%3=$F(%1," "),%3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y,Y2=$A(%1,%2)*(%2+%)+Y2
 S RSUM=Y,RSUM2=Y2
 Q
%Z3 S PG=PG+1,ST=0 D:(PG>1)&IOC2&IOC %Z5 Q:ST
 W:((LC+9+$Y'<IOSL)!FF)&($Y>3)!(PG>1) @IOF
 W RN," * *  ",$S(PG>1:"(cont.)",1:LC_" LINES,  "_BYTECNT_" BYTES,  RSUM: "_RSUM_"/"_RSUM2_" "),?60,"Page ",PG,!,?8,HDR(1),?49,HDR(2),!
 Q
%Z5 R !,"Press RETURN to continue or '^' to exit: ",ST:600 S ST=$S(ST["^":1,1:0) S:ST LI=9999,LC=0,RN="zzzz",X=""
 Q
