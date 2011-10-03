%ZTMOVE ;SF/STAFF - Easier Multi-CPU routine transfers ;12/27/94  09:26
 ;;8.0;KERNEL;;Jul 10, 1995
 S:'$D(DTIME) DTIME=120
OUT S U="^",MGR=$P(^%ZOSF("MGR"),",",1) X ^%ZOSF("UCI") S:Y'["," Y=Y_","_^%ZOSF("VOL") S HOME=Y,HOME("MGR")=MGR
 W !!,"This will move the complete text of the routines selected to",!,"the MGR account of the system being moved to."
 W !,"If you send a large number of routines you may run out of disk space",!,"on the target system.",!!
 W !,"From ",HOME," send what routines!" K ^UTILITY($J) X ^%ZOSF("RSEL") G EXIT:$O(^UTILITY($J,0))=""
 W !!,"You're in ",HOME
 K ZTSYS F ZTI=1:1 D WHERE G EXIT:$D(DUOUT) Q:X=""  W !!,"Then..."
 W !!,"Starting to send!"
 F ZTI=1:1 Q:'$D(ZTSYS(ZTI))  S X=ZTSYS(ZTI),ZTMODE=$P(X,U,1),SYS=$P(X,U,2),UCI=$P(X,U,3) D SEND
 W !!,"Summary" F ZTI=1:1 Q:'$D(ZTSYS(ZTI,1))  S X=ZTSYS(ZTI),Y=ZTSYS(ZTI,1) D
 . W !?3,"To ",$P(X,U,2)," ",$S('Y:Y,$E(X)="M":"as task # "_Y,1:"in UCI: "_$P(X,U,3))
 . Q
EXIT K ZTSK,ZTSYS,ZTI,ZTMODE,SYS,UCI,HOME,ANS,DEF,MGR,Y,X,DUOUT,^UTILITY($J)
 Q
 ;
WHERE W !,"To which Volume Set (2-7 letters or * for all) to send routines? " R SYS:DTIME G ALL:ZTI=1&(SYS="*"),ESC:'$T!(SYS["^"),WHEX:SYS'?2.7U
 I $P(HOME,",",2)=SYS W !,*7,"THIS IS THE SAME SYSTEM!!"
 R !,"Auto-load or Manual: Manual//",X:DTIME S ZTMODE=$E(X_"M") G ESC:'$T!(X["^"),WHERE:"AM"'[ZTMODE
 S UCI=MGR I ZTMODE="A" R !,"Enter UCI to unload into: ",UCI:DTIME G ESC:'$T!(UCI["^"),WHERE:UCI'?2.7U
 S ZTSYS(ZTI)=ZTMODE_U_SYS_U_UCI,X=1 Q
WHEX S X="" Q
ESC S X="",DUOUT=1 Q
ALL ;
 R !,"Auto-load or Manual: Manual//",X:DTIME S ZTMODE=$E(X_"M") G ESC:'$T!(X["^"),ALL:"AM"'[ZTMODE
 S HOME(1)=$P(HOME,","),HOME(2)=$P(HOME,",",2),SYS="",UCI=""
 F ZTI=1:1 S SYS=$O(^%ZIS(14.6,"AT",HOME(1),HOME(2),SYS)) Q:SYS=""  I SYS'=HOME(2) S UCI=$O(^(SYS,"")) I UCI]"" S ZTSYS(ZTI)=ZTMODE_U_SYS_U_UCI
 S X="" Q
SEND S MGR=HOME("MGR"),SYSM=SYS,X=$$LINK^%ZTM5(SYS) S:X]"" MGR=$P(X,","),SYSM=$P(X,",",2),ZTSYS(ZTI,2)=X
 G SENDLOC:$P(HOME,",",2)=SYS ;ELSE SENDREM
SENDREM S X="ERR",@^%ZOSF("TRAP"),X="^[MGR,SYSM]%ZTSK"
 W !!,">>ROUTINES WILL NOW BE SENT TO "_SYS_" MACHINE" D NODE W " AS TASK # ",ZTSK," <<",!
 W:$D(ZTSYS(ZTI,2)) "  accessed by uci,volume: ",ZTSYS(ZTI,2),!
 I ZTMODE="M" W !,"REMEMBER YOU MUST LOAD THE ROUTINES IN MANUALLY AT THE OTHER CPU",!,"WITH 'D IN^%ZTMOVE'"
 W !! S R=0
 X "F I=1:1 S R=$O(^UTILITY($J,R)) Q:R'?1AP.ANP  ZL @R W $J(R,10) S ^[MGR,SYSM]%ZTSK(ZTSK,I,0)=R F J=1:1 S T=$T(+J) Q:T=""""  S ^(J)=T"
 S ^[MGR,SYSM]%ZTSK(ZTSK,0,"ZTMOVE")=" routine"_$S(I-1'=1:"s",1:"")_" transfered from "_HOME,^[MGR,SYSM]%ZTSK(ZTSK,1)=I-1,ZTSYS(ZTI,1)=ZTSK
 I ZTMODE="A" L ^[MGR,SYSM]%ZTSCH S ^[MGR,SYSM]%ZTSCH($$H3^%ZTM($H),ZTSK)="" W "  Scheduled"
 L  Q
SENDLOC S X="ERR",@^%ZOSF("TRAP"),X="^%ZTSK" D NODE
 W !!,">>ROUTINES WILL NOW BE SENT TO THIS MACHINE AS TASK # ",ZTSK," <<",!
 I ZTMODE="M" W !,"REMEMBER YOU MUST LOAD THE ROUTINES IN MANUALLY ",!,"WITH 'D IN^%ZTMOVE'"
 W !! S R=0
 X "F I=1:1 S R=$O(^UTILITY($J,R)) Q:R'?1AP.ANP  ZL @R W $J(R,10) S ^%ZTSK(ZTSK,I,0)=R F J=1:1 S T=$T(+J) Q:T=""""  S ^(J)=T"
 S ^%ZTSK(ZTSK,0,"ZTMOVE")=" routine"_$S(I-1'=1:"s",1:"")_" transfered from "_HOME,^%ZTSK(ZTSK,1)=I-1,ZTSYS(ZTI,1)=ZTSK
 I ZTMODE="A" L ^%ZTSCH S ^%ZTSCH($H,ZTSK)="" L  W "  Scheduled"
 L  Q
 ;
NODE N %
 S ZNODE=$S(ZTMODE="M":"EXIT^%ZTMOVE",1:"AUTO^%ZTMOVE")_U_$G(DUZ)_U_UCI_U_$H_U_($H+2)_",1",$P(ZNODE,U,14)=SYS
 L +@X@(-1) S ZTSK=@X@(-1)+1 F ZTSK=ZTSK:1 Q:$D(@X@(ZTSK))=0
 S @X@(ZTSK,0)=ZNODE,@X@(ZTSK,.1)=$S(ZTMODE="M":"K",1:1)
 L +@X@(ZTSK),-@X@(-1)
 S @X@(ZTSK,.03)="ZTMOVE of routines to "_SYS
 Q
 ;
ERR W !,"CANNOT SEND TO '"_SYS_"'!",! S ZTSYS(ZTI,1)="Error exit" Q
 ;
IN ;
 S:$D(DTIME)[0 DTIME=30
 R !,"Task Number: ",ZTSK:DTIME G EXIT:'$T!(ZTSK="")!(ZTSK="^")
 I ZTSK'?1N.N W !,"Enter a number between ",$O(^%ZTSK(.1))," and ",^%ZTSK(-1),"!" G IN
 S DEL=0 R !,"Delete Task After Loading? ",YN:DTIME Q:'$T!(YN="^")
 S DEL=(YN["Y")
 I '$D(^%ZTSK(ZTSK)) W !!?3,*7,"No such task number exists.",! G IN
 I '$D(^%ZTSK(ZTSK,0,"ZTMOVE")) W !!?3,*7,"Not a 'ZTMOVE' task!" G IN
 X ^%ZOSF("UCI") S:Y'["," Y=Y_","_^%ZOSF("VOL") S N=^%ZTSK(ZTSK,1) W !!,N,^(0,"ZTMOVE"),!,"READY TO BE LOADED INTO '",Y
 R "' ...OK? YES// ",X:DTIME G EXIT:"Yy"'[$E(X_"Y")
 W ! S ZTL="W ""  "",R F I=1:1 Q:'$D(^(I))  ZI ^(I)"
 X "F J=1:1:N ZR  S R=^%ZTSK(ZTSK,J,0) X ZTL ZS @R" K:DEL ^%ZTSK(ZTSK)
 G EXIT
 ;
AUTO ;AUTO-LOAD
 I '$D(^%ZTSK(ZTSK,0,"ZTMOVE")) G EXIT
 S ZTL="F I1=1:1 Q:'$D(^(I1))  ZI ^(I1)"
 F I=.9:0 S I=$O(^%ZTSK(ZTSK,I)) Q:I'>0  S R=^%ZTSK(ZTSK,I,0) X "ZR  X ZTL ZS @R"
 S ZTREQ="@" G EXIT
