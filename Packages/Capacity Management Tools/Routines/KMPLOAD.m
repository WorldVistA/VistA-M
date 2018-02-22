KMPLOAD ;SF/KAK - Manager UCI Loader Routine ;16 JUL 1998  3:35 pm
 ;;1.0;CAPACITY MANAGEMENT;;Jul 21, 1998
EN ;
 S:'$D(DTIME) DTIME=120 S X=""
 I '$D(^%ZOSF("OS")) D   Q:X=""!(X="^")  G:X'?1N!(X<1)!(X>3) EN S X=$S(X=1:"O",X=2:"V",X=3:"M",1:"ERR") G:X="ERR" ERR G START
 .W !,"What is the operating system:",!,?3,"1. OpenM-NT",!,?3,"2. VMS",!,?3,"3. MSM",!,"Choose (1-3): "
 .R X:DTIME
 S X1=$P(^%ZOSF("OS"),"^") S X=$S(X1["VAX DSM":"V",X1="OpenM-NT":"O",X1["MSM":"M",1:"ERR") G:X="ERR" ERR
START ;
 S KMPLD="ZOSVKR"_X,KMPSV="%ZOSVKR" D MOVE
 S KMPLD="ZOSVKS"_X_"E",KMPSV="%ZOSVKSE" D MOVE
 S KMPLD="ZOSVKS"_X_"S",KMPSV="%ZOSVKSS" D MOVE
END ;
 W !!,"Finished",!
 K KMP1,KMP2,KMP3,KMPDL,KMPLD,KMPSV,X,X1
 Q
MOVE ;
 W !,"Loading ",KMPLD X "ZL @KMPLD ZS @KMPSV" W ?20,"Saved as ",KMPSV
 Q
ERR ;
 W !,"SAGG Program for this environment is NOT implemented !",*7,!
 Q
