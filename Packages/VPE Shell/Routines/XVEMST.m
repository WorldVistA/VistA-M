XVEMST ;DJB/VSHL** VShell Tool Kit [03/02/95 10:28pm];2017-08-16  10:42 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Code written by Roger Ackerman, David Laliberte, David Bolduc dates unknown.
 ;
CALENDAR ;Author: Roger Ackerman   Albuquerque,NM
 NEW %H,%Y,AD,AL,DAYS,DOW,L,M,MM,N,X,Y,NY,NM
 I $G(%1)]"" S:%1'?1.2N!(%1<1)!(%1>12) %1=""
 I $G(DT)="" S DT=$$FMDATE^XVEMKDT()
 S NY=+$E(DT,1,3),NM=$S($G(%1)>0:%1,1:+$E(DT,4,5))
 F MM=-1:1:4 S Y=NM+MM,AD=$S(Y<1:(NY-1)_"12",Y>12:(NY+1)_"0"_(Y#12),1:NY_$S($L(Y)=1:"0",1:"")_Y)_"01",M=MM+2 D CAL
 W @XVV("IOF"),!?23,"S I X   M O N T H   P L A N N E R",?63,"Roger Ackerman"
 W !," ============================================================================",!!
 F L=1:1:8 W ?3,AL(1,L),?28,AL(2,L),?53,AL(3,L),!
 W !
 F L=1:1:8 W ?3,AL(4,L),?28,AL(5,L),?53,AL(6,L),!
 W:'$D(AL(6)) !
 W " ============================================================================",!
EXIT ;
 Q
 ;
CAL ;build calendar matrix (also called by ABOCE)
 S X=$E(AD,1,5)_"01" D H S DOW=%Y ; day-of-week month starts on
 S DAYS=$P("31^28^31^30^31^30^31^31^30^31^30^31","^",+$E(AD,4,5))
 S DAYS=DAYS+(+$E(AD,4,5)=2&'($E(AD,1,3)#4)) ;leap year
 S Y=$E(AD,1,5)_"00" D DD
 S AL(M,1)="       "_Y_"       "
 S AL(M,2)=" Su Mo Tu We Th Fr Sa "
 S L=3,X=$J("",3*DOW) ;BLANK SPACE FOR FIRST WEEK OF CALENDAR
 F N=1:1:DAYS S X=X_$J(N,3),DOW=DOW+1 I DOW=7 S DOW=0,AL(M,L)=X_" ",X="",L=L+1
 I DOW>0 S X=X_$J("",21-$L(X))_" ",AL(M,L)=X,L=L+1
 F N=L:1:8 S AL(M,N)=""
 Q
 ;
DD ;from ^DD("DD")
 S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q
H ;from H^%DTC
 NEW %M,%D,%
 S %Y=$E(X,1,3),%M=$E(X,4,5),%D=$E(X,6,7)
 S %H=%M>2&'(%Y#4)+$P("^31^59^90^120^151^181^212^243^273^304^334","^",%M)+%D
 S %='%M!'%D,%Y=%Y-141,%H=%H+(%Y*365)+(%Y\4)-(%Y>59)+%,%Y=$S(%:-1,1:%H+4#7)
 Q
XQH ;Help text for Kernel Menu Options
 I $T(^XQH)']""!('$D(^XUSEC(0))) D  Q
 . W $C(7),!?2,"Not in this UCI.",!
 I $G(DUZ)="" D ^XUP Q:$G(DUZ)=""
 W !!,"HELP Text for Kernel Menu Options"
 NEW DIC,X,XQH,Y
 I $G(%1)']"" S DIC="^DIC(19,",DIC(0)="QEAM" D ^DIC Q:Y<0  S %1=$P(Y,"^",2)
 S XQH=%1 D EN^XQH I $G(XQH)<0 W " This Option has no Help Text"
 Q
ASCII ;Author: David Laliberte   SF-ISC
 NEW I,B,X S B="|"
 W @XVV("IOF"),!?21,"A S C I I   C H A R A C T E R   S E T",!!
 F I=0:10:70 W ?I,"Dec  Chr"
 W !,"==============================================================================="
 F I=32:1:47 D  W ?19,B,$J(I,3),?25,$S(I>32:$C(I),1:"SP"),?29,B,$J(I+16,3),?35,$C(I+16),?39,B,$J(I+32,3),?45,$C(I+32),?49,B,$J(I+48,3),?55,$C(I+48),?59,B,$J(I+64,3),?65,$C(I+64),?69,B,$J(I+80,3),?75,$S(I+80<127:$C(I+80),1:"DEL")
 .S X=I-32 W !,$J(X,3),?5,$P($T(TXT+X),";",4),?9,B,$J($P($T(TXT+X),";",5),3),?15,$P($T(TXT+X),";",6) Q
 W !,"==============================================================================="
 Q
TXT ;;0;NUL;16;DLE
 ;;1;SOH;17;DC1
 ;;2;STX;18;DC2
 ;;3;ETX;19;DC3
 ;;4;EOT;20;DC4
 ;;5;ENQ;21;NAK
 ;;6;ACK;22;SYN
 ;;7;BEL;23;ETB
 ;;8;BS;24;CAN
 ;;9;HT;25;EM
 ;;10;LF;26;SUB
 ;;11;VT;27;ESC
 ;;12;FF;28;FS
 ;;13;CR;29;GS
 ;;14;SO;30;RS
 ;;15;SI;31;US
