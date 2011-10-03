PSOARC ;BHAM ISC/LGH - archiving driver menu ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 D DT^DICRW I ^DOPT("PSOAC",5,0)'["LIST ARCHIVED PRESCRIPTION NUMBERS" K ^DOPT("PSOAC") S DIK="^DOPT(""PSOAC""," S DTIME=$S($D(DTIME):DTIME,1:300)
 G:$D(^DOPT("PSOAC",4)) A S ^DOPT("PSOAC",0)="OP ARCHIVING OPTION^1N^" F I=1:1 S X=$T(@I) Q:X=""  S ^DOPT("PSOAC",I,0)=$P(X,";",2,99)
 D IXALL^DIK
A W !! S DIC="^DOPT(""PSOAC"",",DIC(0)="QEAM" D ^DIC K DIC D:Y<0 END^PSOARCS2 G:Y<0 EXIT D @+Y G A
1 ;find
 G ^PSOARCCO
2 ;save to tape
 G ^PSOARCSV
3 ;tape retrieve
 G ^PSOARCIN
4 ;save to hfs file
 G ^PSOARCF4
5 ;hfs file retrieve
 G ^PSOARCF1
6 ;purge
 G ARC^PSOARCS2
7 ;list archived prescription numbers
 G ^PSOARCLT
EXIT K Y,X,I Q
