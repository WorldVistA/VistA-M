%ZTLOAD7 ;ISC-SF/RWF - TASKMAN Utilities ;02/25/98  10:46
 ;;8.0;KERNEL;**67**;JUL 10, 1995
 ;See XLFDT for notes.
HTFM(%H,%F) ;$H to FM
 N X,%,%Y,%M,%D S:'$D(%F) %F=0
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
 S %L=%Y+1700 S:%M<3 %L=%L-1 S %L=(%L\4)-(%L\100)+(%L\400)-446
 S %H=$P("^31^59^90^120^151^181^212^243^273^304^334","^",%M)+%D
 S %=('%M)!('%D),%Y=%Y-141,%H=(%H+(%Y*365)+%L+%)_","_%T,%Y=$S(%:-1,1:%H+4#7)
 Q
 ;
HTE(%H,%F) ;$H to external
 Q:%H'>0 %H N Y,%T,%R S %F=$G(%F) S Y=$$HTFM(%H,0) G T2
FMTE(Y,%F) ;FM to external
 Q:'Y Y N %T,%R S %F=$G(%F)
T2 S %T="."_$E($P(Y,".",2)_"000000",1,7) D @("EF"_$S(%F<1:1,%F>4:1,1:+%F\1)) Q %R
DOW(X,Y) ;Day of Week
 N %Y,%M,%D,%H,%T D H I $G(Y) Q %Y
 Q $P("Sun^Mon^Tues^Wednes^Thurs^Fri^Satur","^",%Y+1)_"day"
 ;
FMDIFF(X1,X2,X3) ;FM diff in two dates in days if x3=1 seconds if x3=2.
 N %H,%Y,X S:'$D(X3) X3=1 S X=X1 D H S X1=+%H,X1(1)=$P(%H,",",2),X=X2 D H
D2 S X=(X1-%H) S:X3>1 X=X*86400+(X1(1)-$P(%H,",",2))
 I X3=3 S %=X,X="" S:%>86400 X=(%\86400) S:%#86400 X=X_" "_(%#86400\3600)_":"_$E(%#3600\60+100,2,3)_":"_$E(%#60+100,2,3)
 Q X
HDIFF(X1,X2,X3) ;$H diff in two dates, X3 same as FMDIFF.
 N X,%H,%T S:'$D(X3) X3=1 S X1(1)=$P(X1,",",2),X1=+X1,%H=X2
 G D2
HADD(X,D,H,M,S) ;Add to $H date
 N %H,%T S %H=+X,%T=$P(X,",",2) D A2 Q %H_","_%T
A2 S %H=%H+$G(D),%T=%T+($G(H)*3600)+($G(M)*60)+$G(S)
 S:%T>86400 %H=%H+(%T\86400),%T=%T#86400 S:%T<0 %H=%H+(%T\86400)-1,%T=%T#86400
 Q
FMADD(X,D,H,M,S) ;Add to FM date
 N %H,%T S %H=$$FMTH(X,0),%T=$P(%H,",",2) D A2 Q $$HTFM(%H_","_%T)
 ;
EF1 S %R=$P($T(M)," ",$S($E(Y,4,5):$E(Y,4,5)+2,1:0))_" "_$S($E(Y,6,7):$E(Y,6,7)_", ",1:"")_($E(Y,1,3)+1700)
 S:$E(%R)=" " %R=$E(%R,2,99)
TM N % Q:%T'>0!(%F["D")
 I %F'["P" S %R=%R_"@"_$E(%T,2,3)_":"_$E(%T,4,5)_$S(%F["M":"",$E(%T,6,7)!(%F["S"):":"_$E(%T,6,7),1:"")
 I %F["P" D
 . S %R=%R_" "_$S($E(%T,2,3)>12:$E(%T,2,3)-12,1:+$E(%T,2,3))_":"_$E(%T,4,5)_$S(%F["M":"",$E(%T,6,7)!(%F["S"):":"_$E(%T,6,7),1:"")
 . S %R=%R_$S($E(%T,2,7)<120000:" am",$E(%T,2,3)=24:" am",1:" pm")
 . Q
 Q
M ;; Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
EF2 S %R=$J(+$E(Y,4,5),2)_"/"_$J(+$E(Y,6,7),2)_"/"_$E(Y,2,3)
 I %F'["F" S %R=$TR(%R," ")
 G TM
EF3 S %R=$J(+$E(Y,6,7),2)_"/"_$J(+$E(Y,4,5),2)_"/"_$E(Y,2,3)
 I %F'["F" S %R=$TR(%R," ")
 G TM
EF4 S %R=$E(Y,2,3)_"/"_$J(+$E(Y,4,5),2)_"/"_$J(+$E(Y,6,7),2)
 I %F'["F" S %R=$TR(%R," ")
 G TM
