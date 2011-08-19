XLFDT ;ISC-SF/STAFF - Date/Time Functions ;03/27/2003  14:09
 ;;8.0;KERNEL;**71,120,166,168,179,280**;Jul 10, 1995
 ;VA FileMan uses 2400 as midnight, many other system use 0000.
 ;This is true for $H and HL7, so a conversion has to adjust
 ;the day when converting Midnight.
 ;i.e. 3001225.24 is the same as HL7 '200012260000' and $H '58434,0'
 ;The range of accepted $H dates: "2,0" to "99999,85399".
 ;The range of accepted FM dates: 1410102 to 4141015 (any valid time).
 ;The range of accepted HL7 dates: 18410102 to 21141015 (any valid time).
 ;It is expected that input values are valid dates.
 ;
HTFM(%H,%F) ;$H to FM, %F=1 for date only
 N X,%,%T,%Y,%M,%D S:'$D(%F) %F=0
 I $$HR(%H) Q -1 ;Check Range
 I '%F,%H[",0" S %H=(%H-1)_",86400"
 D YMD S:%T&('%F) X=X_%T
 Q X
 ;
H2F(%H) ;Internal to this routine use
 N X,%,%T,%Y,%M,%D
 D YMD S:%T X=X_%T
 Q X
 ;
YMD ;21608 = 28 feb 1900, 94657 = 28 feb 2100, 141 $H base year
 S %=(%H>21608)+(%H>94657)+%H-.1,%Y=%\365.25+141,%=%#365.25\1
 S %D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1
 S X=%Y_"00"+%M_"00"+%D,%=$P(%H,",",2)
 S %T=%#60/100+(%#3600\60)/100+(%\3600)/100 S:'%T %T=".0"
 Q
 ;
FMTH(X,%F) ;FM to $H, %F=1 for date only
 N %Y,%H,%A S:'$D(%F) %F=0
 I $$FR(X) Q -1 ;$H range of 1 - 99999
 I '%F,X[".24" S %A=1
 D H S:%F %H=+%H I $D(%A) S %H=(%H+1)_",0"
 Q %H
 ;
F2H(X) ;Internal to this routine use
 N %Y,%H,%A
 D H
 Q %H
 ;
H ;Build %H from FM
 N %,%L,%M,%D,%T I X<1410101 S %H=0,%Y=-1 Q
 S %Y=$E(X,1,3),%M=$E(X,4,5),%D=$E(X,6,7)
 S %T=$E(X_0,9,10)*60+$E(X_"000",11,12)*60+$E(X_"00000",13,14)
 ;%L = (# leap years) - (# leap years before base)
 S %L=%Y+1700 S:%M<3 %L=%L-1 S %L=(%L\4)-(%L\100)+(%L\400)-446
 S %H=$P("^31^59^90^120^151^181^212^243^273^304^334","^",%M)+%D
 S %=('%M)!('%D),%Y=%Y-141,%H=(%H+(%Y*365)+%L+%)_","_%T,%Y=$S(%:-1,1:%H+4#7)
 Q
 ;
HTE(%H,%F) ;$H to external
 Q:$$HR(%H) %H ;Range Check
 N Y,%T,%R
 S %F=$G(%F,1) S Y=$$HTFM(%H,0) G T2
 ;
FMTE(Y,%F) ;FM to external
 Q:(Y<1000000)!(Y>9991231) Y ;Range Check
 N %T,%R S %F=$G(%F,1)
 ;Both HTE and FMTE come here.
T2 S %T="."_$E($P(Y,".",2)_"000000",1,7)
 D FMT^XLFDT1 Q %R
 ;
FR(%V) ;Check FM in valid range
 Q (%V<1410102)!(%V>4141015.235959)
HR(%V) ;Check $H in valid range
 Q (%V<2)!(%V>99999)
 ;
FMTHL7(%P1) ;Convert FM date/time to HL7 format
 N %T Q:'$L(%P1) "" S %P1=+%P1 ;Make sure a cononic number
 I $$FR(%P1) Q -1 ;Check range
 S %T=$P(%P1,".",2),%P1=$P(%P1,".")
 I %T=24 S %P1=$$FMADD($P(%P1,"."),1),%T="0000"
 S:%P1>1 %P1=%P1+17000000
 I $L(%T) S %T=$S($L(%T)>4:$E(%T_"00",1,6),1:$E(%T_"0000",1,4))
 I $L(%T) S %P1=%P1_%T_$$TZ()
 Q %P1
 ;
HL7TFM(%P1,%P2,%P3) ;Convert HL7 D/T to FM.
 ;%P1 is the value to convert
 ;%P2 is if output should be local or UCT time (L,U)
 ;%P3 is 1 if the input just a time value?
 N %TZ,%LTZ,%SN,%U,%H,%M,%T Q:'$L(%P1) ""
 S %T=$E(%P1_"0000",1,8)
 S %P2=$G(%P2),%P3=+$G(%P3),%TZ="",%LTZ=$$TZ()
 I '%P3 Q:(%T<18410102)!(%T>21141015) -1 ;Date Range Check
 F %SN="+","-" I %P1[%SN D  Q  ;Find the timezone
 . S %TZ=$P(%P1,%SN,2),%P1=$P(%P1,%SN) I %TZ'?4N S %TZ="" Q
 . S %TZ=%SN_%TZ
 . Q
 ;FM only supports time to seconds
 S %P1=$P(%P1,".")
 ;See it just a Time value
 I %P3 S %P1="20000104"_%P1 ;Add a date
 Q:($L(%P1)#2)!(%P1'?4.14N) -1 ;Length check
 I $L(%P1)<8 S %P1=$E(%P1_"00000000",1,8) ;Fill out to 8 digits
 I %TZ="" D
 . S:%P2["L" %P2="" ;If no TZ, assume local, don't need L.
 . S:%P2["U" %TZ=%LTZ ;give the local tz
 ;
 S %P1=$S($L(%P1)>8:$E(%P1,1,8)-17000000_"."_$E(%P1,9,14),1:%P1-17000000)
 ;%P1 is now in FM format
 I %P1[".",+$P(%P1,".",2)=0 S %P1=$$FMADD(+%P1,-1)_".24"
 ;If HL7 tz and local tz are the same
 I %P2["L",%TZ=%LTZ S %P2=""
 I (%P2["U")!(%P2["L"),%P1["." D  ;Build UCT from data
 . S %=$TR(%TZ,"+-","-+") ;Reverse the sign
 . S %H=$E(%,1,3),%M=$E(%,1)_$E(%,4,5)
 . S %P1=$$FMADD(%P1,,%H,%M) Q
 ;
 I %P2["L",%P1["." D  ;Build local from UCT
 . S %=$$TZ(),%H=$E(%,1,3),%M=$E(%,1)_$E(%,4,5)
 . S %P1=$$FMADD(%P1,,%H,%M) Q
 Q +$S(%P3:"."_$P(%P1,".",2),1:%P1)
 ;
DOW(X,Y) ;Day of Week
 N %Y,%M,%D,%H,%T D H I $G(Y) Q %Y
 Q $P("Sun^Mon^Tues^Wednes^Thurs^Fri^Satur","^",%Y+1)_"day"
 ;
FMDIFF(X1,X2,X3) ;FM diff in two dates. if X3=1 in days, if X3=2 in seconds.
 N %H,%Y,X
 S X1=$G(X1),X2=$G(X2),X3=$G(X3,1)
 S:$$FR(X1) X1=0 S:$$FR(X2) X2=0 ;Check range, Use 0 for bad values
 S X=X1 D H S X1=+%H,X1(1)=$P(%H,",",2),X=X2 D H
 ;Both FMDIFF and HDIFF come here.
D2 S X=(X1-%H) S:X3>1 X=X*86400+(X1(1)-$P(%H,",",2))
 I X3=3 S %=X,X="" S:%'<86400 X=(%\86400) S:%#86400 X=X_" "_(%#86400\3600)_":"_$E(%#3600\60+100,2,3)_":"_$E(%#60+100,2,3)
 Q X
 ;
HDIFF(X1,X2,X3) ;$H diff in two dates, X3 same as FMDIFF.
 N X,%H,%T
 S:$$HR(X1) X1="1,1" S:$$HR(X2) X2="1,1" ;Check range, use "1,1" for bad values
 S X3=$G(X3,1)
 S X1(1)=$P(X1,",",2),X1=+X1,%H=X2
 G D2
 ;
HADD(X,D,H,M,S) ;Add to $H date
 N %H,%T
 Q:$$HR(X) -1 ;Check Range
 S %H=+X,%T=$P(X,",",2) D A2 Q %H_","_%T
 ;
A2 S %H=%H+$G(D),%T=%T+($G(H)*3600)+($G(M)*60)+$G(S) ;add days and seconds
 ;S:%T'<86400 %H=%H+(%T\86400),%T=%T#86400 S:%T<0 %H=%H+(%T\86400)-1,%T=%T#86400
 S %H=%H+(%T\86400) I %T<0,(%T#86400'=0) S %H=%H-1 ;Adj for sec>day
 S %T=%T#86400
 Q
 ;
FMADD(X,D,H,M,S) ;Add to FM date
 N %H,%T,%P
 Q:$$FR(X) -1 ;Check Range
 S %P=X[".",%H=$$F2H(X),%T=$P(%H,",",2) D A2
 I %P,%T=0 S %H=%H-1,%T=86400
 Q $$H2F(%H_","_%T)
 ;
NOW() ;Current Date/time in FM.
 Q $$HTFM($H)
 ;
DT() ;Current Date in FM.
 Q $$HTFM($H,1)\1
 ;
SCH(SCH,LTM,FF) ;Find the next D/T given a schedule, start time.
 Q $$DECODE^XLFDT2
 ;
WITHIN(XLSCH,XLD) ;See if D/T is within schedule
 G WITHIN^XLFDT4
 ;
SEC(%) ;Convert $H to seconds.
 I %?7.N.".".N S %=$$FMTH(%) ;Check for FM date
 Q 86400*%+$P(%,",",2)
 ;
%H(%) ;Covert from seconds to $H
 Q (%\86400)_","_(%#86400)
 ;
TZ() ;Return current Time Zone from Mailman parameter file
 N %T,%S
 S %T=$P($G(^XMB(4.4,+$P($G(^XMB(1,1,0)),"^",2),0)),"^",3),%S=$S(%T["-":"-",1:"+"),%T=$TR(%T,"-+")
 Q %S_$E(100+%T,2,3)_$S(%T[".5":"30",1:"00")
