XLFLTR ;SLC/RWF- PRINT BIG LETTERS ;7/11/94  11:18
 ;;8.0;KERNEL;;Jul 10, 1995
EN(STR,CNT) ;string to print, repeat count
 I '$D(^XTMP("XLFLTR",1,"A")) D ^XLFLTR1
 N %B,%C,%CNT,%I,%R,%S,%X,%Y
B1 S STR=$E(STR,1,6),CNT=$G(CNT,1),%B=$E("     ",1,IOM\36),%S=$E("XXXXX",1,IOM\36)
 S STR=$$UP^XLFSTR(STR)
 I STR'?1.6UNP S STR=$TR(STR,$C(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31))
 F %CNT=1:1:CNT D
 . W !
 . F %R=9:-1:1 W ! F %I=1:1:$L(STR) S %X=$G(^XTMP("XLFLTR",1,$E(STR,%I))) W "   " F %C=1:1:5 W $S($E(%X,(%C-1*9+%R)):%S,1:%B)
 . Q
 Q
