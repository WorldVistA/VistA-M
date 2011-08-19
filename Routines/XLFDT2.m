XLFDT2 ;SEA/RDS - Library function Schedule  ;03/21/2006
 ;;8.0;KERNEL;**71,86,141,414**;Jul 10, 1995;Build 1
 ;
DECODE() ;SCH^XLFDT--Decode A Cycle Schedule String (Return Next Time)
 N %1,%D,%M,%T,%Y,Y,SCHL,LTMA,LTFM
 I $L(+LTM)>6 S LTFM=LTM,LTM=$$FMTH^XLFDT(LTM)
A D NEXT Q:Y="" Y
 I $G(FF),Y<$H S LTM=Y G A
 I $G(FF),(+Y=+$H),$P(Y,",",2)'>$P($H,",",2) S LTM=Y G A
 Q $$HTFM^XLFDT(Y)
 ;
NEXT ;
 I SCH?1.4N1"S" S Y=$P(SCH,"S")+$P(LTM,",",2),Y=(Y\86400+LTM)_","_(Y#86400) Q
 I SCH?1.4N1"H" S Y=$P(SCH,"H")*3600+$P(LTM,",",2),Y=(Y\86400+LTM)_","_(Y#86400) Q
 I SCH?1.3N1"D" S Y=($P(SCH,"D")+LTM)_","_$P(LTM,",",2) Q
 ;I SCH?1.3N1"D@".E S X=$P(SCH,"@",2),%DT="RS" D ^%DT Q:Y=-1  S X=Y D H^%DTC S Y=($P(SCH,"D")+LTM)_","_%T Q
 I SCH?1.2N1"M" D MONTH Q
 I SCH?1.2N1"M(".E1")" S SCHL=$P($P(SCH,")"),"(",2) D MONTH2^XLFDT3 Q
 I SCH?5.7N1P.5N.1";".E D LIST Q
 I "MTWRFSUDE"[$E(SCH),"@,"[$E(SCH,2),SCH]"" D WEEK Q
 S Y="" Q
 ;
MONTH ;DECODE--Simple Month Increment (Add x Months)
 N X,XL,XLA,%,%H,%Y,%M,%D,%T
 S %H=LTM D YMD^XLFDT ;Break into %Y %M %D
 S XL=$P(SCH,"M") F  Q:'XL  S %M=%M+1,XL=XL-1 I %M=13 S %Y=%Y+1,%M=1
 S XLA="31^"_($$LEAP(%Y)+28)_"^31^30^31^30^31^31^30^31^30^31"
 I %D>$P(XLA,"^",%M) S %D=$P(XLA,"^",%M)
 S Y=$$FMTH^XLFDT(%Y_"00"+%M_"00"+%D_%T) ;Note %T has a leading '.'
 Q
 ;
LIST ;DECODE--Find Next Run Time In List
 N %A,XL
 F %1=1:1 S XL=$P(SCH,";",%1) Q:XL=""  S:$L(+XL)<7 XL=$$HTFM^XLFDT(XL) S %A(XL)=""
 S Y=$O(%A($$NOW^XLFDT)) S:Y>0 Y=$$FMTH^XLFDT(Y)
 Q
 ;
WEEK ;DECODE--List Of Day Of Week Specifications
 N %A,%W,%Z,XL,XLT
 S XL=$P(LTM,",",2),%T=XL#60/100+(XL#3600\60)/100+(XL\3600)/100,%W=LTM+4#7+1,%Z="0"_%T,%Y=""
 F %1=1:1 S %Y=$P(SCH,",",%1) Q:%Y=""  D ARRAY S:%A]"" %A(%A+XLT)=""
 S %A=$O(%A(%T)),Y="" S:%A]"" XLT=%A#1,XLT=$E(XLT_0,2,3)*60+$E(XLT_"000",4,5)*60+$E(XLT_"00000",6,7),Y=%A\1+LTM_","_XLT Q
 ;
ARRAY ;WEEK Subroutine--Build Incident Array
 S XL=$E(%Y),XLT="" D TIME:$P(%Y,"@",2)]"" S:XLT="" XLT=%T
 S %A="" S:"UMTWRFS"[XL %A=$F("UMTWRFS",XL)-1,%A=$S(%A'=%W:6-%W+%A#7+1,XLT'>%T:6-%W+%A#7+1,1:0) S:XL="D" %A=$S(%W=1:1,%W=7:2,XLT'>%T:1+(%W=6*2),1:0)
 ;Mid week > Sat, Sat > Sun, Sun > Sat.
 S:XL="E" %A=$S(%W>1&(%W<7):7-%W,XLT'>%T:$S(%W=1:6,1:1),1:0) Q
 ;
TIME ;ARRAY--Build Time Node For Incidents That Include Times
 N %DT,X S %DT="RS",X="T@"_$P(%Y,"@",2) D ^%DT S XLT=$S(Y=-1:"",1:Y#1) Q
 ;
LEAP(%) ;Check if a Leap year
 S:%<1700 %=%+1700
 Q (%#4=0)&'(%#100=0)!(%#400=0)
