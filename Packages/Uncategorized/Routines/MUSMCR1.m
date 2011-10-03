MUSMCR1 ;CREDIT MONITORING PROGRAM
 ;
 Q
CHK ;
 I $L(D)=9 S D1=D Q
 I $L(D)=8 S D1="0"_D Q
 I $L(D)=7 S D1="00"_D Q
 Q
 Q
EN10 ;
 R !,"Please Enter Directory where file exist: ",DIR Q:DIR="^"
 R !,"Please enter File to import: ",FILE Q:FILE="^"
EN11 R !,"(S)SN's or (P)romo codes: ",CODE Q:CODE="^"
 I "Ss"[$E(CODE,1) G SSN
 I "Pp"[$E(CODE,1) G CODE
 W !,"Please type S or P.........",!*7 G EN11
 Q
SSN ;
 S $ZT="EOF"
 S F=DIR_FILE
 S D=1 O F:("RW") F  U F R A U 0 S ^MUSMCRS1(D)=A,D=D+1
 Q
CODE ;
 S $ZT="EOF"
 S F=DIR_FILE
 S D=1 O F:("RW") F  U F R A U 0 S ^MUSMCRC1(D)=A,D=D+1
 Q
MERGE ;
 S M=0 F  S M=$O(^MUSMCRS1(M)) Q:M'>0  S D=^MUSMCRS1(M) D CHK S ^MUSMCRM(D1)=^MUSMCRC1(M)
 Q
PRT ;
 R !,"(I)ntial Letter or (P)romo Code Letter: ",LET Q:LET="^"
 R !,"(A)live or (D)eceased patients: ",AD Q:AD="^"
BEG1 S %ZIS="QF" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="QUE^MUSMCR1",ZTDESC="MONITOR PROGRAMS",ZTSAVE("LET")="",ZTSAVE("AD")="" D ^%ZTLOAD Q
 I IO'=IO(0) O IO U IO D QUE,^%ZISC Q
QUE ;
 S D=0 F  S D=$O(^MUSMCRM(D)) Q:D'>0  S DFN=$O(^DPT("SSN",D,0)) D  
 I "Dd"[$E(AD,1) I DFN]"",$D(^DPT(DFN,.35)) I $P(^(.35),"^",1)'="" D BEG^MUSMCR2
 .I "Aa"[$E(AD,1) I DFN]"" D  I $D(FLAG) K FLAG D BEG^MUSMCR3
 ..I $D(^DPT(DFN,.35)),$P(^DPT(DFN,.35),"^",1)="" S FLAG=1 Q
 ..I '$D(DPT(DFN,.35)) S FLAG=1 Q
 Q
EOF  ;
 U 0
 I $ZE["ENDOFFILE" W !,"End of File" S $ZT="" C F
 Q
