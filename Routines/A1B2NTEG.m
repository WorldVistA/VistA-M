A1B2NTEG ;AISC/MJK ODS Integrity Routine ; JAN 13,1991
 ;;Version 1.55 (local for MAS v5 sites);;
 W !!,"Integrity Check Started at: " D NOW^%DTC S Y=% X ^DD("DD") W Y,!!,"Integrity Routine",!,"-----------------"
 D CC F I=1:1 S X=$T(ROU+I),T=$P(X," ",1),U=$P(X,";;",2) Q:X=""  D TEST
 S U="^" W !!,"Integrity Check Finished at: " D NOW^%DTC S Y=% X ^DD("DD") W Y,! K %,%H,%I,X,Y
 Q
TEST W !,T X "ZL @T F Y=1:1:99 S L=$T(+Y),LN=$L(L) X CC S:'LN Y=99" W:U-T *7," Routine is off by ",U-T," BIT",$E("S",U'?.P1"1") W:'(U-T) ?10,"...ok"
 Q
CC S CC="F C=1:1:LN S T=$A(L,C)+T" Q
EN R !,"Routine: ",R:DTIME Q:R'?1"A1B2".U.N.U  I ($T(@R)']"") W !,"NO ROUTINE " Q
 S X=$T(@R),T=$P(X," ",1),U=$P(X,";;",2) D CC G TEST
ROU ;;
A1B2ADM ;;78130
A1B2BGJ ;;138838
A1B2MAIN ;;211790
A1B2MSP ;;113014
A1B2MUT ;;182043
A1B2OLC ;;88060
A1B2OSR ;;173825
A1B2OSR1 ;;236003
A1B2OSR2 ;;172943
A1B2OSR3 ;;122069
A1B2OSR4 ;;232135
A1B2PRE ;;52999
A1B2PST ;;205249
A1B2Q ;;224007
A1B2Q1 ;;76431
A1B2STAT ;;109671
A1B2SUP ;;165184
A1B2T1 ;;216643
A1B2T2 ;;210288
A1B2T3 ;;149456
A1B2UTL ;;96462
A1B2XFR ;;93017
