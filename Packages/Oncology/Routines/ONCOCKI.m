ONCOCKI ;Hines OIFO/GWB - Edit checks/INPUT TRANSFORM edit checks ;06/23/10
 ;;2.2;ONCOLOGY;**1,4**;Jul 31, 2013;Build 5
 ;
11 S Y=$P(^ONCO(165.5,D0,0),U,2),Y=$S($D(^ONCO(160,+Y,1)):$P(^(1),U,2),1:"") Q:(Y=""!(X<Y)!(X=Y))
 S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_($E(Y,1,3)+1700) W !!,"*****DATE DX is after LAST DATE CONTACT***** ",Y,! K X,Y
 Q
ACN ;Accession Number check
 Q:$D(^ONCO(165.5,"AE",X,$P(^ONCO(165.5,D0,0),U,2)))  Q:'$D(^ONCO(165.5,"AE",X))  W *7,?50,"Number is already assigned!!" K X
 Q
SGAN ;SET GREATEST ACCESSION NUMBER @ ACCESSION YEAR
 S YR=$E(X,1,2) I '$D(^ONCO(165.5,"AGAN",YR)) S ^ONCO(165.5,"AGAN",YR)=X G EX
 S:X>^ONCO(165.5,"AGAN",YR) ^(YR)=X G EX
KGAN ;RESET GREATEST ACCESSION NUMBER @YEAR
 S YR=$E(X,1,2) G RE:'$D(^ONCO(165.5,"AGAN",YR)),EX:X<^(YR),GN:X=^(YR)
RE W !?10,"NEED TO RE-INITIALIAZE FILE" G EX
GN ;GET NEXT GREATEST ACCESSION NUMBER
 F AC=X-1:-1:YR_"0001" I $D(^ONCO(165.5,"AE",X)) S ^ONCO(165.5,"AGAN",YR)=AC G EX
 K ^ONCO(165.5,"AGAN",YR) G EX
KACD ;CHECK DELETED NUMBER
 S ^ONCO(165.5,"ACD",YR,$E(X,3,6))="" G EX ;THIS WILL LEAVE LARGE NUMBER IN DELGLED LIST IF NOT CHECKED
 ;
SEQ ;SEQUENCE NUMBER (165.5,.06)
 S XX=$P(^ONCO(165.5,D0,0),U,5)
 I XX="" K X,XX W !?50,"No ACCESSION NUMBER assigned",!! Q
 S XX=$E(XX,1,4)_"-"_$E(XX,5,9)_"/"_X Q:'$D(^ONCO(165.5,"D",XX))
 W !?25,XX," is already assigned.",! D SDP^ONCOCOM K X,XX Q
 Q
 ;
PSEX ;PATIENT NAME (165.5,.02) INPUT TRANSFORM
 S XX=$P(^ONCO(165.5,D0,0),U,1),XD0=X
SEX Q:(XX<43!(XX>52))
 N SG,SX
 S SX=$P(^ONCO(160,XD0,0),U,8)
 I SX=1 Q:((XX>49)&(XX<53))  D  K X Q
 .S SG=$P($G(^ONCO(164.2,XX,0)),U,1)
 .W !!?10,"SEX = Male.  SITE/GP ",SG," is inappropriate."
 I SX=2 Q:((XX>42)&(XX<49))  D  K X Q
 .S SG=$P($G(^ONCO(164.2,XX,0)),U,1)
 .W !!?10,"SEX = Female.  SITE/GP ",SG," is inappropriate."
 Q
 ;
EX ;Kill variables and Exit
 K AC,YR,XX,XD0
 Q
 ;
CLEANUP ;Cleanup
 K D0
