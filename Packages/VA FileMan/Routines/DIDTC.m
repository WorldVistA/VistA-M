DIDTC ;SFISC/XAK-DATE/TIME OPERATIONS ;3JAN2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**14,36,71,117,164,1041**
 ;
D N %T
 I 'X1!'X2 S X="",%Y=0 Q
 S X=X1 D H S X1=%H,X=X2,X2=%Y+1 D H S X=X1-%H,%Y=%Y+1&X2
 K %H,X1,X2 Q
 ;
C N %,%T,%Y
 S X=X1,X2=$J($G(X2),0,0) I 'X S (X,%H)="" Q
 D H S %H=%H+X2 D YMD S:$P(X1,".",2) X=X_"."_$P(X1,".",2) K X1,X2 Q
S S %=%#60/100+(%#3600\60)/100+(%\3600)/100 Q
 ;
H ;called from DIG, DIP4
 I X<1410000 S (%H,%T)=0,%Y=-1 Q
 S %Y=$E(X,1,3),%M=$E(X,4,5),%D=$E(X,6,7)
 S %T=$E(X_0,9,10)*60+$E(X_"000",11,12)*60+$E(X_"00000",13,14)
TOH N DILEAP D
 . N Y S Y=%Y+1700 S:%M<3 Y=Y-1
 . S DILEAP=(Y\4)-(Y\100)+(Y\400)-446 Q
 S %H=$P("^31^59^90^120^151^181^212^243^273^304^334","^",%M)+%D
 S %=('%M!'%D),%Y=%Y-141
 S %H=(%H+(%Y*365)+DILEAP+%),%Y=$S(%:-1,1:%H+4#7)
 K %M,%D,% Q
 ;
DOW D H S Y=%Y K %H,%Y Q
 ;
DW D H S Y=%Y,X=$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR","^",Y+1)_"DAY"
 S:Y<0 X="" Q
 ;
7 I '%H S (%,X)="" Q
 S %=(%H>21608)+(%H>94657)+%H-.1,%Y=%\365.25+141,%=%#365.25\1
 S %D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1
 S X=%Y_"00"+%M_"00"+%D Q
 ;
YX ;called from DIV, etc
 D YMD S Y=X_% Q:Y=""  G DD^%DT
 ;
YMD ;called from DIP5. Documented entry point for converting a date/time %H in $H format into a date (in X) and time (in %) in FileMan internal format.
 I %H[",0" S %=%H N %H S %H=%-1_",86400"
 N %D,%M,%Y D 7 S %=$P(%H,",",2) D S
 Q
 ;
 ;
T ;from %DT
 F %=1:1 S Y=$E(X,%) Q:"+-"[Y  G 1^%DT:$E("TODAY",%)'=Y
 S X=$E(X,%+1,99) G PM:Y=""
 I X?1.N1"M" S %H=$H D MONTH G D^%DT
 I +X'=X D DMW S X=%
 G:'X 1^%DT
PM S @("%H=$H"_Y_X) D TT G 1^%DT:%I(3)'?3N,D^%DT
 ;
 ;
N ;from %DT
 F %=2:1 S Y=$E(X,%) Q:"+-"[Y  G 1^%DT:$E("NOW",%)'=Y
 I Y="" S %H=$H D %H G RT
 S X=$E(X,%+1,99)
 I X?1.N1"H" S X=X*3600,%H=$H,@("X=$P(%H,"","",2)"_Y_X),%=$S(X<0:-1,1:0)+(X\86400),X=X#86400,%H=$P(%H,",")+%_","_X G RT
 I X?1.N1"'" S X=X*60,%H=$H,@("X=$P(%H,"","",2)"_Y_X),%=$S(X<0:-1,1:0)+(X\86400),X=X#86400,%H=$P(%H,",")+%_","_X G RT
 I X?1.N1"M" S %H=$H D %H,MONTH G RT1
 D DMW G 1^%DT:'% S @("%H=$H"_Y_%),%H=%H_","_$P($H,",",2) D %H
RT D TT
RT1 S %=$P(%H,",",2) D S S %=X_$S(%:%,1:.24) I %DT'["S" S %=+$E(%,1,12)
 Q:'$D(%(0))  S Y=% G E^%DT
 ;
 ;
PF ;from %DT
 S %H=$H D YMD S %(9)=X,X=%DT["F"*2-1 I @("%I(1)*100+%I(2)"_$E("> <",X+2)_"$E(%(9),4,7)") S %I(3)=%I(3)+X
 Q
 ;
 ;
MONTH ;Add months to current date
 S Y=Y_+X
 D TT
 S %=%I(1)+Y,%I(1)=%-1#12+1,%I(3)=%I(3)+(%-$S(%>0:1,1:12)\12)
 S %="31^"_($$LEAP(%I(3))+28)_"^31^30^31^30^31^31^30^31^30^31"
 I %I(2)>$P(%,U,%I(1)) S %I(2)=$P(%,U,%I(1))
 S X=%I(3)_"00"+%I(1)_"00"+%I(2)
 Q
 ;
LEAP(X) ;Return 1 if leap year
 S:X<1700 X=X+1700
 Q '(X#4)&(X#100)!'(X#400)
 ;
TT N %M,%D,%Y D 7 S %I(1)=%M,%I(2)=%D,%I(3)=%Y
 Q
 ;
NOW S %H=$H,%H=$S($P(%H,",",2):%H,1:%H-1)
 D TT S %=$P(%H,",",2) D S S %=X_$S(%:%,1:.24) Q
 ;
DMW S %=$S(X?1.N1"D":+X,X?1.N1"W":X*7,X?1.N1"M":X*30,+X=X:X,1:0)
 Q
 ;
%H I '$P(%H,",",2) S %H=%H-1 Q
 I $P(%H,",",2)<60&(%DT'["S") S $P(%H,",",2)=60
 Q
 ;
COMMA ;
 S %D=X<0 S:%D X=-X S %=$S($D(X2):+X2,1:2),X=$J(X,1,%),%=$L(X)-3-$E(23456789,%),%L=$S($D(X3):X3,1:12)
 F %=%:-3 Q:$E(X,%)=""  S X=$E(X,1,%)_","_$E(X,%+1,99)
 S:$D(X2) X=$E("$",X2["$")_X S X=$J($E("(",%D)_X_$E(" )",%D+1),%L) K %,%D,%L
 Q
 ;
 ;
 ;
HELP S DDH=$S($D(DDH):DDH,1:0),A1="Examples of Valid Dates:" D %
 I %DT["M" D  G 0
 . S A1="  "_$S(%DT["I":1.1957,1:"JAN 1957 or JAN 57")_$S(%DT'["N":" or 0157",1:"") D %
 . S A1="  T    (for this month)" D %
 . S A1="  T+3M (for 3 months in the future)" D %
 . S A1="  T-3M (for 3 months ago)" D %
 . S A1="Only month and year are accepted. You must omit the precise day." D %
 S A1="  "_$S(%DT["I":"20.1.1957",1:"JAN 20 1957 or 20 JAN 57")_" or "_$S(%DT["I":"20/1",1:"1/20")_"/57"_$S(%DT'["N":" or "_$S(%DT["I":200157,1:"012057"),1:"") D %
 S A1="  T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7,  etc." D %
 S A1="  T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc." D %
 S A1="If the year is omitted, the computer " D  D %
 . I %DT["P" S A1=A1_"assumes a date in the PAST." Q
 . I %DT["F" S A1=A1_"assumes a date in the FUTURE." Q
 . S A1=A1_"uses CURRENT YEAR.  Two digit year" D %
 . S A1="  assumes no more than 20 years in the future, or 80 years in the past."
 . Q
 I %DT'["X" S A1="You may omit the precise day, as:  "_$S(%DT["I":1,1:"JAN,")_" 1957" D %
 I %DT'["T",%DT'["R" G 0
 S A1="If only the time is entered, the current date is assumed." D %
 S A1="Follow the date with a time, such as "_$S(%DT["I":"20.1",1:"JAN 20")_"@10, T@10AM, 10:30, etc." D %
 S A1="You may enter a time, such as NOON, MIDNIGHT or NOW." D %
 S A1="You may enter   NOW+3'  (for current date and time Plus 3 minutes" D %
 S A1="  *Note--the Apostrophe following the number of minutes)" D %
 I %DT["S" S A1="Seconds may be entered as 10:30:30 or 103030AM." D %
 I %DT["R" S A1="Time is REQUIRED in this response." D %
0 Q:'$D(%DT(0))
 S A1=" " D % S A1="Enter a date which is "_$S(%DT(0)["-":"less",1:"greater")_" than or equal to " D %
 S Y=$S(%DT(0)["-":$P(%DT(0),"-",2),1:%DT(0)) D DD^%DT:Y'["NOW"
 I '$D(DDS) W Y,"." K A1 Q
 S DDH(DDH,"T")=DDH(DDH,"T")_Y_"." K A1 Q
 ;
% I '$D(DDS) W !,"     ",A1 Q
 S DDH=DDH+1,DDH(DDH,"T")="     "_A1 Q
 Q
