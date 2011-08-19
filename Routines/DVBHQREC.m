DVBHQREC ;ALB/JLU This routine recompiles all the print and input templates. ;3/19/90
 ;;V4.0;HINQ;;03/25/92 
1 W !!!,DVBLN,!,?20,"Recompilation of '",$S(DVBF="^DIE(":"Edit' templates",1:"Print' templates"),!,DVBLN
 S DVBA="DVBHI" F DVB=1:1 S DVBA=$O(@(DVBF_"""B"",DVBA)")) Q:DVBA=""!($E(DVBA,1,5)'="DVBHI")  S DVBN=+$O(^(DVBA,0)) I DVBN>0,$D(@(DVBF_"+DVBN,""ROUOLD"")")),^("ROUOLD")]"",$D(^(0)) S X=$P(^("ROUOLD"),U) D 2
 Q
2 W !!,"----Recompiling '",DVBA,"' ",$S(DVBF["^DIE":"Input",1:"Output")," Template----"
 I ^%ZOSF("OS")["M/11" S DMAX=3500
 E  S DMAX=4000
 S Y=+DVBN D @($S(DVBF["^DIE":"EN^DIEZ",1:"EN^DIPZ")) I $D(@(DVBF_DVBN_",""ROU"")")) W !!,?3,"  '",DVBA,"' has been recompiled in the ",^("ROU"),"* routines.",!
 Q
E S:'$D(DTIME) DTIME=300 S $P(DVBLN,"*",80)="",%=1,U="^" W !,"Do you want to Recompile the HINQ edit and print templates" D YN^DICN G:%<0!(%=2) K1 I %=0 W !!,"A YES answer will recompile all the HINQ edit and print templates.",! G E
 ;start RT monitor 
 D:$D(XRTL) T0^%ZOSV
 S DVBF="^DIE(" D 1
 S DVBF="^DIPT(" D 1
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV
K1 K X,Y,DVB,DVBA,DVBF,DVBLN,DVBN,%,%Y Q
