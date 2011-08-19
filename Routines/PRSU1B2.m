PRSU1B2 ;WOIFO/PLT-UTILITY ; 24-Aug-2005 10:34 AM
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified
 QUIT  ; invalid entry
 ;
 ;prsa date ~1=[label]^routine, ~2=task description
 ;prsb data ~1=variable name/global root, ~2...
 ;prsc data ~1=1 if ask start time, ~2=start time (fm time/$h-time), ~3=keep until time (fm/$h)
 ;          ~4=i/o device name, ~5=priority(1-10),
 ;          ~6=task uci, ~7=volume set,
TASK(PRSA,PRSB,PRSC) ;ef value ^1 task number, ^2=start time(fm/$h)
 ;task set-up
 N ZTRN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSK
 N A,B
 S ZTRTN=$P(PRSA,"~"),ZTDESC=$P(PRSA,"~",2)
 I $G(PRSB)]"" F A=1:1 Q:$P(PRSB,"~",A,999)=""  S B=$P(PRSB,"~",A) S:B]"" @("ZTSAVE("""_B_""")=""""")
 S ZTIO=""
 S PRSC=$G(PRSC) S:'PRSC ZTDTH=$S($P(PRSC,"~",2)="":$H,1:$P(PRSC,"~",2))
 I $P(PRSC,"~",3,999)]"" D
 . S:$P(PRSC,"~",3)]"" ZTKILL=$P(PRSC,"~",3)
 . S:$P(PRSC,"~",4)]"" ZTIO=$P(PRSC,"~",4)
 . S:$P(PRSC,"~",5)]"" ZTPRI=$P(PRSC,"~",5)
 . S:$P(PRSC,"~",6)]"" ZTUCI=$P(PRSC,"~",6)
 . S:$P(PRSC,"~",7)]"" ZTCPU=$P(PRSC,"~",7)
 . QUIT
 D ^%ZTLOAD
 QUIT $G(ZTSK)_"^"_$G(ZTSK("D"))
 ;
 ;PRSA data ^1=message subject, ^2=message sender's name (option)
 ;xmtext text array name with left parenthesis
 ;.xmy recipients ri/name, group array, return value ien of 3.9
 ;.xmrou routine name array
 ;.xmstrip striped character array
MM(PRSA,XMTEXT,XMY,XMROU,XMSTRIP) ;mail message sending
 N XMSUB,XMDUZ
 S XMSUB=$P(PRSA,"^") S:$P(PRSA,"^",2)]"" XMDUZ=$P(PRSA,"^",2)
 D ^XMD K XMY S XMY=XMZ K XMZ
 QUIT
 ;
 ;
 ;PRSA=package name (.01) in file 9.4
PKGVER(PRSA) ;ef - ^1=ri of file 9.4, ^2=version number from node version if defined
 ;     ^3=version number from node 22, ^4=version install date from node 22
 N A,B,C
 S (A,B)=""
 Q:$D(PRSPKVER(PRSA)) PRSPKVER(PRSA)
 S A=$O(^DIC(9.4,"B",PRSA,""))
 I A S PRSPKVER(PRSA)=A,$P(PRSPKVER(PRSA),"^",2)=$P($G(^DIC(9.4,A,"VERSION")),"^"),$P(PRSPKVER(PRSA),"^",3)=$P(PRSPKVER(PRSA),"^",2) D:$P(PRSPKVER(PRSA),"^",2)=""
 . D EN^DDIOL("Package is defined, but has not current version data.")
 . D EN^DDIOL("Please call IRM!")
 S:'A PRSPKVER(PRSA)=""
 QUIT PRSPKVER(PRSA)
 ;
 ;A=date/time, B='I' if fileman date/time, 'H' if $H date/time, 'E' if external date
 ;C="S" if second required
DT(A,B,C) ;ef value: -1 if wrong format,  ^1=fileman.time, ^2=$h date,time
 ;          ^3-week day, ^4=mm/dd/yy@time, ^5=alpha date@time
 N %DT,X,Y,Z,%H,%,%T,%Y
 S:'$D(C) C="" S Z=""
 I B="E" D  QUIT:Z=-1 Z
 . S %DT="T" S:C="S" %DT=%DT_"S"
 . S X=A D ^%DT S Z=Y
 I B="H" D
 . S %H=+A D YMD^%DTC S Z=X,%=$P(A,",",2) D S^%DTC S Z=Z_$S(%=0:".0000",C="S":%,1:$E(%,1,5))
 S:Z="" Z=A
 S X=Z D H^%DTC S $P(Z,"^",2)=%H_","_%T,$P(Z,"^",3)=%Y
 S Y=$P(Z,"^") S:C="S" %DT="S" D DD^%DT S $P(Z,"^",5)=Y,A=$P(Y,"@",2)
 S $P(Z,"^",4)=$E(Z,4,5)_"/"_$E(Z,6,7)_"/"_$E(Z,2,3)
 S:$P(Z,"^")["." $P(Z,"^",4)=$P(Z,"^",4)_"@"_$TR(A,":",""),$P(Z,"^")=+Z
 QUIT Z
 ;
 ;a - the date, b - date format:E - external, I - internal, H - $h
DTPP(A,B) ;ef - -1 if date in wrong format, day #^pay period yy-pp^pp start date cyymmdd^pp ending date cyymmdd^pp start $h date
 ;assume the pp '06-01' starting 1/8/2006 with $h=60273 and fm date 3060108
 N C,D,E,F,G
 S E="60273^3060108^06-01"
 S D=$$DT(A,B),F=+$P(D,U,2) I D=-1 QUIT D
 ;find the first pay period date of the year
 S D=$E(D,1,3)_"0101",B=$$DT(D,"I"),D=+$P(B,U,2) F G=D:1:D+14 QUIT:G-E#14=0
 I G'>F S $P(C,U,2)=$E(B,2,3)_"-"_$E(F-G\14+101,2,3)
 E  S D=$E(B,1,3)-1_"0101",B=$$DT(D,"I"),D=+$P(B,U,2) F G=D:1:D+14 I E-G#14=0 S $P(C,U,2)=$E(B,2,3)_"-"_$E(F-G\14+101,2,3) QUIT
 S $P(C,U)=F-G#14+1,$P(C,U,3)=$E($$DT(F-C+1,"H"),1,7),$P(C,U,4)=$E($$DT(F-C+14,"H"),1,7),$P(C,U,5)=F-C+1
 QUIT C
 ;
 ;a - pay period yyyy-nn or yy-nn, b - day #
PPDT(A,B) ;ef- -1 if a,b invalid, date of day # cyymmdd^pp start date cyymmdd^pp ending date^pp start $h date
 ;assume 19yy if yy>70 and 20yy if yy'>70
 ;assume the pp '06-01' starting 1/8/2006 with $h=60273 and fm date 3060108
 N C,D,E,F,G
 S E="60273^3060108^06-01"
 I A'?1(2N1"-"2N,4N1"-"2N)!(B'?1.2N)!(B>14)!(B<1) QUIT -1
 I $P(A,"-",2)<1!($P(A,"-",2)>27) QUIT -1
 S D=$P(A,"-") I D?2N S D=$S(D>70:1900,1:2000)+D
 ;find the first pay period date of the year
 S C=$$DT("1/1/"_D,"E"),F=$P(C,U,2) F G=F:1:F+14 QUIT:G-E#14=0
 S C=$P(A,"-",2)-1*14+G,C=$E($$DT(C+B-1,"H"),1,7)_U_$E($$DT(C,"H"),1,7)_U_$E($$DT(C+13,"H"),1,7)_U_C
 I $P(A,"-",2)>24 S F=$$DT("1/1/"_(D+1),"E"),F=$P(F,U,2) F B=F:1:F+14 I B-E#14=0 S:B-G/14<$P(A,"-",2) C="-1^"_(B-G/14) QUIT
 QUIT C
 ;
 ; a= ien of 450, b=pay period yyyy-pp or yy-pp or ien of file #458
RSHR(A,B) ;ef - ^1-first week recess hrs in file 458.8, ^2 - second week recess hrs
 N C
 S:B?1.N B=$P(^PRST(458,B,0),U) S:B?2N1"-".E B=$S(B<70:20,1:19)_B
 D RSPP^PRSARC05(.C,A,B)
 QUIT +$G(C(+$$PPDT(B,1)))_"^"_+$G(C(+$$PPDT(B,8)))
 ;
 ;a=8b string, b=week1 code^value length^week2 code^value length, c=1 if 3-digit hr
CD8B(A,B,C) ;ef - ^1=week 1 value (hours if c=1), ^2=week 2 value (hours if c=1)
 N D,E
 S D=$E(A,33,999),E=$P(D,$P(B,U),2),D=$P(D,$P(B,U,3),2)
 S:E]"" E=$E(E,1,$P(B,U,2)),E=$S(C=1:E/10+(E#10*.15),1:E) S:D]"" D=$E(D,1,$P(B,U,4)),D=$S(C=1:D/10+(D#10*.15),1:D)
 QUIT $G(E)_U_$G(D)
