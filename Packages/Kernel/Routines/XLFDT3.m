XLFDT3 ;SEA/RDS - Library Function Schedule ;02/09/2000  09:21
 ;;8.0;KERNEL;**71,120,141**;Jul 10, 1995
 ;
MONTH2 ;DECODE--Complex Month Increment Specification
 N %,%A,%B,%C,%D,%H,%L,%M,%O,%T,%Y,XL,XLCT,XLW,XLX,XLF,XLFS,XLL,XLLW,XLO,XLT
 S %H=LTM D YMD^XLFDT S %L=%Y+1700,%L=$$LEAP(%L)
 S LTMA="31^"_(%L+28)_"^31^30^31^30^31^31^30^31^30^31",%=$P(LTM,",",2),XLCT=%#60/100+(%#3600\60)/100+(%\3600)/100
 ;Check if a date in current month
 S XLF=LTM-%D+5#7+1,XLFS=2-XLF,XLL=$P(LTMA,"^",%M),XLLW=XLF-29+XLL S:XLLW=0 XLLW=7 S:XLLW>7 XLLW=XLLW#8+1
 K %A F XLX=1:1:$L(SCHL,",") D BUILD
 I $O(%A(%D+XLCT))]"" S XLO=$O(%A(%D+XLCT)),%1=XLO\1-%D,XLT=XLO#1,XLT=$E(XLT_0,2,3)*60+$E(XLT_"000",4,5)*60+$E(XLT_"00000",6,7),Y=LTM+%1_","_XLT Q
 ;Check the next months
 S %C=XLL-%D,XL=$P(SCH,"M")-1,%M=%M+1 S:%M=13 %Y=%Y+1,%M=1,$P(LTMA,"^",2)=28+$$LEAP(%Y)
 F  Q:'XL  S %C=%C+$P(LTMA,"^",%M),%M=%M+1,XL=XL-1 I %M=13 S %Y=%Y+1,%M=1,$P(LTMA,"^",2)=28+$$LEAP(%Y)
 S LTM=LTM+%C_","_$P(LTM,",",2),XLF=LTM+5#7+1,XLFS=2-XLF,XLL=$P(LTMA,"^",%M),XLLW=XLF-29+XLL S:XLLW=0 XLLW=7 S:XLLW>7 XLLW=XLLW#8+1
 K %A F XLX=1:1:$L(SCHL,",") D BUILD
 S %O=$O(%A("")) I %O="" S %O=$$FLD() ;Q  ;Bad input, force last day
 S %=%O#1,%=$E(%_0,2,3)*60+$E(%_"000",4,5)*60+$E(%_"00000",6,7),Y=%O\1+LTM_","_%
 Q
 ;
BUILD ;MONTH2--Building Array Of Run Incidents For Month
 S %B=$P(SCHL,",",XLX),XLT=""
 ;Build for a day in month (15)
 I $P(%B,"@")?1.2N S %A=%B\1 Q:%A>XLL!'%A  S XLT=$$TIME($P(%B,"@",2)) S %A(%A+XLT)="" Q
 ;Build for 1st.. DOW in month ("2W")
 I $P(%B,"@")?1N1U,"UMTWRFS"[$E(%B,2) S %A=XLFS+$F("UMTWRFS",$E(%B,2))-2,%A=%B-(%A>0)*7+%A\1 Q:%A>XLL!'%A  S XLT=$$TIME($P(%B,"@",2)) S %A(%A+XLT)="" Q
 ;Build for Last day of month ("L")
 I $P(%B,"@")="L" S %A=XLL,XLT=$$TIME($P(%B,"@",2)) S %A(%A+XLT)="" Q
 ;Build for last DOW in month ("LF") last friday
 I $P(%B,"@")?1"L"1U,"UMTWRFS"[$E(%B,2) S XLW=$F("UMTWRFS",$E(%B,2))-1,%A=XLL-$S(XLLW-XLW<0:XLLW+7-XLW,1:XLLW-XLW),XLT=$$TIME($P(%B,"@",2)) S %A(%A+XLT)="" Q
 Q
 ;
TIME(%X) ;BUILD--Build Time Node For Incidents That Include Times
 N %Y,%M,%D,%T,%DT,X,Y
 I %X="" Q XLCT ;use current time
 S %DT="RS",X="T@"_%X D ^%DT
 Q $S(Y=-1:XLCT,1:Y#1)
 ;
LEAP(%) ;Check if a Leap year
 S:%<1700 %=%+1700
 Q (%#4=0)&'(%#100=0)!(%#400=0)
 ;
FLD() ;Force to last day of month.
 S XLT=""
 F XLX=1:1:$L(SCHL,",") S %B=$P(SCHL,",",XLX) I +%B>XLL S XLT=$$TIME($P(%B,"@",2))
 Q XLL+XLT
