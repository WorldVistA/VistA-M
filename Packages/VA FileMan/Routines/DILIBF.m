DILIBF ;SFISC/STAFF-LIBRARY OF FUNCTIONS ;2013-08-09  10:11 AM; 12/1/12 3:12pm
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**48,71,169,1045**
 ;
HTFM(%H,%F) ;$H to FM
 N X,%,%Y,%M,%D S:'$D(%F) %F=0
 S:%H[",0" %H=%H-1_",86400"
 S %=(%H>21608)+(%H>94657)+%H-.1,%Y=%\365.25+141,%=%#365.25\1
 S %D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1
 S X=%Y_"00"+%M_"00"+%D,%=$P(%H,",",2)
 S %=%#60/100+(%#3600\60)/100+(%\3600)/100
 S:%&('%F) X=X_% Q X
 ;
FMTH(X,%F) ;FM to $H
 N %Y,%H S:'$D(%F) %F=0 D H S:%F %H=+%H Q %H
H ;
 N %,%M,%D,%T I X<1410000 S %H=0,%Y=-1 Q
 S %Y=$E(X,1,3),%M=$E(X,4,5),%D=$E(X,6,7)
 S %T=$E(X_0,9,10)*60+$E(X_"000",11,12)*60+$E(X_"00000",13,14)
 N DILEAP D
 . N Y S Y=%Y+1700 S:%M<3 Y=Y-1
 . S DILEAP=(Y\4)-(Y\100)+(Y\400)-446 Q
 S %H=$P("^31^59^90^120^151^181^212^243^273^304^334","^",%M)+%D
 S %='%M!'%D,%Y=%Y-141
 S %H=%H+(%Y*365)+DILEAP+%
 S:%T=86400 %H=%H+1,%T=0
 S %H=%H_","_%T
 S %Y=$S(%:-1,1:%H+4#7)
 Q
 ;
HTE(%H,%F) ;$H to external
 Q:%H'>0 %H N Y,%T,%R S %F=$G(%F) S Y=$$HTFM(%H,0) G T2
FMTE(Y,%F) ;FM to external
 Q:'$G(Y) $G(Y) S %F=$G(%F) Q:($G(DUZ("LANG"))>1) $$OUT^DIALOGU(Y,"FMTE",%F)
 N %T,%R
T2 S %T="."_$E($P(Y,".",2)_"000000",1,7) D @("F"_$S(%F<1:1,%F>7:1,1:+%F\1)) Q %R
DOW(X,Y) ;Day of Week
 N %Y,%M,%D,%H,%T D H I $G(Y) Q %Y
 Q $P("Sun^Mon^Tues^Wednes^Thurs^Fri^Satur","^",%Y+1)_"day"
 ;
FMDIFF(X1,X2,X3) ;FM diff in two dates in days if x3=1 seconds if x3=2.
 N %H,%Y,X S:'$D(X3) X3=1 S X=X1 D H S X1=+%H,X1(1)=$P(%H,",",2),X=X2 D H
D2 S X=(X1-%H) S:X3>1 X=X*86400+(X1(1)-$P(%H,",",2))
 I X3=3 D
 . S %=X,X=""
 . I %'<86400 S X=(%\86400)
 . I %<0 S:(-%)'<86400 X=(%\86400) S %=-%
 . S:%#86400 X=X_" "_(%#86400\3600)_":"_$E(%#3600\60+100,2,3)_":"_$E(%#60+100,2,3)
 . Q
 Q X
 ;
HDIFF(X1,X2,X3) ;$H diff in two dates, X3 same as FMDIFF.
 N X,%H,%T S:'$D(X3) X3=1 S X1(1)=$P(X1,",",2),X1=+X1,%H=X2
 G D2
HADD(X,D,H,M,S) ;Add to $H date
 N %H,%T S %H=+X,%T=$P(X,",",2) D A2 Q %H_","_%T
A2 S %H=%H+$G(D),%T=%T+($G(H)*3600)+($G(M)*60)+$G(S)
 S:%T'<86400 %H=%H+(%T\86400),%T=%T#86400 S:%T<0 %H=%H+(%T\86400)-1,%T=%T#86400
 Q
 ;
FMADD(X,D,H,M,S) ;Add to FM date
 N %H,%T S %H=$$FMTH(X,0),%T=$P(%H,",",2) D A2 Q $$HTFM(%H_","_%T)
 ;
CONVQQ(X) ; CONVERT SINGLE TO DOUBLE QUOTES IN STRING X
 N Q,F S Q=""""
 F F=0:0 S F=$F(X,Q,F) Q:F=0  S X=$E(X,1,F-2)_Q_Q_$E(X,F,256),F=F+1
 Q X
 ;
CONVQ(X) ; CONVERT DOUBLE TO SINGLE QUOTES IN STRING X
 N Q,F,D S Q="""",D=""""""
 F F=0:0 S F=$F(X,D,F) Q:F=0  S X=$E(X,1,F-3)_Q_$E(X,F,256),F=F-1
 Q X
 ;
QUOTE(X) ; PUT QUOTES AROUND STRING
 S X=""""_$G(X)_"""" Q X
 ;
FNO(X) ; gets a subfile's top level file number
 N Y S X=+X
 I $G(^DIC(X,0))]"" Q X
 F  S Y=+$G(^DD(X,0,"UP")) D  Q:'$D(X)!(Y'>0)
 . I $G(^DIC(Y,0))]"" K X Q
 . S X=Y
 . Q
 Q Y
 ;
GLO(Z) ; gets the file number from a global root
 I '$D(@(Z_"0)"))#2 Q 0
 N Y
 S Y=+$P($G(@(Z_"0)")),U,2)
 Q $$FNO(+Y)
 ;
UP(X) ; convert string X to uppercase
 I $G(DUZ("LANG"))>1 Q $$OUT^DIALOGU(X,"UC") ;INTERNATIONALIZED for GEKY to use LANGUAGE FILE
 I X?.UNP Q X
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
ROUEXIST(X) ; Execute routine existence test
 G:X="" QRER I '$D(DISYS) N DISYS D OS^DII
 I $G(^%ZOSF("TEST"))]"" X ^("TEST") Q $T
 I $G(^DD("OS",DISYS,18))]"" X ^(18) Q $T
QRER Q 0
 ;
 ;
F5 ;
F1 S %R=$P($S(%F'["U":$T(M),1:$T(MU))," ",$S($E(Y,4,5):$E(Y,4,5)+2,1:0))_$S($E(Y,4,5):" ",1:"")_$S($E(Y,6,7):$S((%F\1'=5):$E(Y,6,7),1:+$E(Y,6,7))_$E(", ",1,1+(%F\1'=5)),1:"")_($E(Y,1,3)+1700)
TM Q:%T'>0!(%F["D")
 I %F'["P" S %R=%R_$S(%F\1'=6:"@",1:" @ ")_$E(%T,2,3)_":"_$E(%T,4,5)_$S($E(%T,6,7)!(%F["S"):":"_$E(%T,6,7),1:$S(%F\1'=6:"",1:"   "))
 I %F["P" S %R=%R_" "_$S($E(%T,2,3)>12:$E(%T,2,3)-12,1:+$E(%T,2,3))_":"_$E(%T,4,5)_$S($E(%T,6,7)!(%F["S"):":"_$E(%T,6,7),1:"")_$S($E(%T,2,5)\1200=1:" pm",1:" am")
 Q
M ;; Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
MU ;; JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC
F2 S %R=+$E(Y,4,5)_"/"_(+$E(Y,6,7))_"/"_$E(Y,2,3)
 G TM
F3 S %R=+$E(Y,6,7)_"/"_(+$E(Y,4,5))_"/"_$E(Y,2,3)
 G TM
F4 S %R=$E(Y,2,3)_"/"_$E(Y,4,5)_"/"_$E(Y,6,7)
 G TM
F6 S %R=$S($E(Y,4,5):$E(Y,4,5)_"-",1:"")_$S($E(Y,6,7):$E(Y,6,7)_"-",1:"")_(1700+$E(Y,1,3))
 G TM
F7 S %R=$S($E(Y,4,5):+$E(Y,4,5)_"-",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_"-",1:"")_(1700+$E(Y,1,3))
 G TM
 ;
HKERR(DIFILE,DIIENS,DIFLD,DIHOOK) ;
 N DIEXT
 S DIEXT("FILE")=$G(DIFILE)
 S DIEXT("FIELD")=$G(DIFLD)
 S DIEXT("IENS")=$G(DIIENS)
 S DIEXT(1)=$G(DIHOOK)
 D BLD^DIALOG(120,DIHOOK,.DIEXT)
 Q
 ;
FILENUM(DIGREF) ;Return file/subfile number from open global reference
 Q:$G(DIGREF)'?1"^".1"%"1U.UN1"(".E ""
 I $E(DIGREF,1,8)="^DIC(.2," Q .2
 N F,X,DIFILE,S
 S DIFILE=+$P($G(@(DIGREF_"0)")),U,2) I DIFILE Q DIFILE
 S DIGREF=$$CREF^DILF(DIGREF)
 F X=$QL($NA(@DIGREF)):-2:0 S X(X)=$QS(DIGREF,X),X(X,0)=$$CREF^DILF($NA(@DIGREF,X))
 S X=$O(X("")) I X="" Q ""
 I X(X)="^DIC" S F=1
 E  I X(X)="^DD" S F=0
 E  S S=$P($G(@X(X,0)@(0)),U,2),F=+S I S="" Q ""
 F X=X:0 S X=$O(X(X)) Q:X=""  S DIFILE=$O(^DD(F,"GL",X(X),0,"")) Q:DIFILE=""  S (F,DIFILE)=+$P($G(^DD(F,DIFILE,0)),U,2) Q:'F
 Q DIFILE
 ;
 ;
