DIR3 ;SFISC/DCM,RDS-READER-MAID (PROCESS RANGE/LIST) ;3MAY2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**5,30,999,164**
 ;
L ; LIST OR RANGE
 N %I,%I1,%I2,%BA,%X,%C,%1,%2,%3,%4,%
 K ^TMP($J,"DIR")
 S Y(0)="",%C=0,%I1=1,%I2=2,%BA=$S($D(DIR("S")):DIR("S"),1:"I 1")
 F %I=1:1 S %X=$P(X,",",%I) Q:%E!'$L($P(X,",",%I,999))  D
 . I %X'?.".".N.".".N."-".N.".".N S %E=4 Q
 . I $E(%X)="-" S %E=3 Q
 . I $L($P(%X,"."))>24 S %E=1 Q
 . I '%B3,$L($P(+%X,".",2)) S %E=2
 I '%E D @$S(%A["C"&'$D(DIR("S")):"LC",%A["C"&$D(DIR("S")):"LL",1:"LL")
 I '%E,Y(%C)="" S %E=4
 I $G(%E),'%N D
EGP .N I S %W=$P($T(@(%E)),";;",3) ;**CCO/NI  thru next 3 lines GET ERROR MESSAGE
 .I %E=1 S I(1)=+%B1,I(2)=%B2
 .I %E=2 S I(1)=+%B3
 .S %W=$$EZBLD^DIALOG(%W,.I)
 I $G(%E) K Y S Y="" Q  ; Prevent Erroneous Data
 S Y=Y(0)
 Q
 ;
LL ; handle uncompressed lists & screened compressed lists
 I %B3 D LCD
 F %I=1:1 S %X=$P(X,",",%I) Q:%E!'$L($P(X,",",%I,999))  D L0
 Q:%E
 I %A["C" D LIST
 Q
L0 N %J
 D LCK
 Q:%E  I %X?.N!(%X?1N.".".N) S %J=+%X G L1
 I %B3 D  Q
 . S %J=+%X D L1 S $P(%X,"-")=%X+%I1
 . F %J=+%X:%I1:$P(%X,"-",2) D L1
 F %J=$P(%X,"-"):1:$P(%X,"-",2) D L1
 Q
L1 I %A["C" D  Q
 . S Y=%J X %BA Q:'$T
 . S (%1,%2)=%J
 . D LC1
 I $L(Y(%C)_%J)>220 S %C=%C+1,Y(%C)=""
 F %=0:1:%C I ","_Y(%)_","[(","_%J_",") S %=-1 Q
 I %'<0 S Y=%J X %BA S:$T Y(%C)=Y(%C)_%J_","
 Q
 ;
 ; check one list element
 ;%A = $P#1 "^" of DIR(0)
 ;%B = $P#2 "^" of DIR(0)
 ;%B1 = $P#1 ":" Low Value
 ;%B2 = $P#2 ":" High Value
 ;%B3 = $P#3 ":" Number of Decimals; Null If Undefined
 ;%X = Range Entered, i.e. 2-4
 ;% = End of Range Entered i.e. 4
LCK I %X["-" D  Q
 . N % S %=$P(%X,"-",2) I '% S %E=4 Q
 . I %A'["I",%<+%X S %E=4 Q
 . I %A["I",%<+%X N %3 S %3=%,%=+%X,$P(%X,"-",2)=%,$P(%X,"-")=%3
 . I %<%B1!(+%X>%B2) S %E=1 Q
 . I +%X<%B1 S %E=1 Q
 . I +%>%B2 S %E=1 Q
 . I $L($P(+%X,".",2))>%B3!($L($P(+%,".",2))>%B3) S %E=2 Q
 I +%X<%B1!(+%X>%B2) S %E=1 Q
 I %B3,$L($P(+%X,".",2))>%B3 S %E=2 Q
 Q
 ;
LCD ; determine increment size for ranges (handle decimals)
 S %1="." I %B3>1 F %=1:1:%B3-1 S %1=%1_"0"
 S %I2=%1_2,%I1=%1_1
 Q
 ;
LC ; handle unscreened compressed lists (no DIR("S"))
 ; LC to LIST checks the user's list in X, building ^TMP($J,"DIR")
 I %B3 D LCD
 F %=1:1:$L(X,",") S %1=$P(X,",",%) D LC0 Q:%E
 Q:'$D(^TMP($J,"DIR"))
LIST ; transfer output list from ^TMP($J,"DIR") to Y
 S %1="",Y(%C)="" D
 . F  S %1=$O(^TMP($J,"DIR",%1)) Q:%1=""  D
 . . S:$D(^(%1))=1 Y(%C)=Y(%C)_%1_","
 . . S:$L(Y(%C))>220 %C=%C+1,Y(%C)=""
 . . I $D(^(%1))=10 S Y(%C)=Y(%C)_$O(^TMP($J,"DIR",%1,""))_"-"_%1_","
 I Y(%C)="" D  Q:%E
 . I %C=0 S %E=4
 . E  K Y(%C) S %C=%C-1
 K ^TMP($J,"DIR")
 Q
LC0 ; check one list element, calls LC1 to put it in ^TMP($J,"DIR")
 S %E=0,%X=%1 D LCK Q:%E  S (%1,%2)=%X
 I %1["-" S %1=+%1,%2=+$P(%2,"-",2)
 S %1=+%1,%2=+%2
 D LC1
 Q
LC1 ; modify ^TMP($J,"DIR") to incorporate a list element, handle overlap
 S %3=$O(^TMP($J,"DIR",%1-%I2)) I %3]"",%3<%2 D
 . I $D(^(%3))=1,%1-%I1=%3 S %1=%3
 . I $D(^(%3))>9 S %4=$O(^(%3,"")) I %4<%1 S %1=%4
 S %3=$O(^TMP($J,"DIR",%2-$S(%B3:%I1,1:1))) I %3]"" D
 . I $D(^(%3))=1,%2+%I1=%3 S %2=%3
 . I $D(^(%3))>9 S %4=$O(^(%3,"")) S:%4'>(%2+%I1) %2=%3 S:%4<%1 %1=%4
 S %3=%1-%I1 F  S %3=$O(^TMP($J,"DIR",%3)) Q:%3=""!(%3>%2)  K ^(%3)
 I %1'=%2 S ^TMP($J,"DIR",%2,%1)=""
 E  S ^TMP($J,"DIR",%1)=""
 Q
 ;
1 ;;Response should be no less than ; and no greater than;;212;;**CCO/NI thru 4 ERROR MESSAGES
2 ;;Response must be no more than ; decimal digit;;211
3 ;;Response must be a positive number;;210
4 ;;Invalid number or range;;208
