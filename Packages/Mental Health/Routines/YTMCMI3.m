YTMCMI3 ;ALB/ASF,HIOFO/FT - MCMI3 ;5/1/13 10:28am
 ;;5.01;MENTAL HEALTH;**76,108**;Dec 30, 1994;Build 17
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to XLFDT APIs supported by DBIA #10103
 ;
 ;called from ^YTT(601,246,"R") and ^YTT(601.6,246,1)
MAIN ;displays the MCMI3 report text
 N A,B,G,I,L1,L2,N,X,YSANS,YSDAS,YSDAS1,YSIN,YSSID,YSTOUT,YSUOUT,YSVFLAG
 D PTVAR^YSLRP
 D RD
 D RAW
 D VALIDITY
 D BR
 D DCA,LIMIT
 D ADA,LIMIT
 D INPTAD,LIMIT
 D DENIAL,LIMIT
 D:YSTY["*" REPT^YTMCMI3R
 Q
RD ;retrieve answer codes
 N YS176177
 S X=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1)
 S YSINPT=$E(X,176),YSDUR=$E(X,177)
 I (YSINPT="")&(YSDUR="") D
 .S YS176177=$$INP(YSDFN,YSED)
 .S:$P(YS176177,U,1)]"" YSINPT=$P(YS176177,U,1)
 .S:$P(YS176177,U,2)]"" YSDUR=$P(YS176177,U,2)
 .;S YSINPT="I",YSDUR=0 ;for testing purposes only
 Q
VALIDITY ;check if ok to score
 S YSVFLAG=0
 I $L(X,"X")>11 S YSVFLAG="too many missing" Q
 I $P(R,U)>1 S YSVFLAG="V scale" Q
 I ($P(R,U,2)>178)!($P(R,U,2)<34) S YSVFLAG="X scale" Q
 I (YSAGE<18) S YSVFLAG="too young" Q
 I $P(R,U,29)>9 S YSVFLAG="W scale"
 Q
RAW ; raw scores
 S R="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 F N=1,3:1:28 D
 . S G=^YTT(601,YSTEST,"S",N,"K",1,0),I=1
 . F  S YSIN=$P(G,U,I),YSANS=$E($P(G,U,I+1),1),YSWT=$P($P(G,U,I+1),";",2),I=I+2 Q:YSIN=""  S:$E(X,YSIN)=YSANS $P(R,U,N)=$P(R,U,N)+YSWT
 F I=5:1:15 S:I'=10 $P(R,U,2)=$P(R,U,2)+$P(R,U,I) S:I=10 $P(R,U,2)=$P(R,U,2)+($P(R,U,I)*.666666)
 S G=$P(R,U,2) S $P(R,U,2)=$S(G#1>.49999999:G\1+1,1:G\1)
 D WSCALE
 Q
BR ;base rate scores
 S S="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 F I=3:1:28 S $P(S,U,I)=$P(^YTT(601,YSTEST,"S",I,YSSEX),U,$P(R,U,I)+1)
 I $P(R,U,2)<39 S $P(S,U,2)=0 Q
 I $P(R,U,2)>174 S $P(S,U,2)=100 Q
 I $P(R,U,2)<105 S $P(S,U,2)=$P(^YTT(601,YSTEST,"S",2,"M"),U,$P(R,U,2)-37)
 I $P(R,U,2)>104 S $P(S,U,2)=$P(^YTT(601,YSTEST,"S",2,"MS"),U,$P(R,U,2)-104)
 Q
DCA ;disclosure adjustment
 ;1-8B
 S G=^YTT(601,YSTEST,"S",2,"MK")
 S X=$P(R,U,2)
 I X<37 S YSDVA=20
 I (X>36)&(X<61) S YSDVA=$P(G,U,X-36)
 I (X>60)&(X<124) S YSDVA=0
 I (X>123)&(X<172) S YSDVA=$P(G,U,X-98)*-1
 S:X>171 YSDVA=-20
 F I=5:1:15 S $P(S,U,I)=$P(S,U,I)+YSDVA S:$P(S,U,I)<0 $P(S,U,I)=0 S:$P(S,U,I)>115 $P(S,U,I)=115
 ;S-PP
 S G=^YTT(601,YSTEST,"S",2,"FK")
 I X<39 S YSDVA1=10
 I (X>38)&(X<61) S YSDVA1=$P(G,U,X-38)
 I (X>60)&(X<124) S YSDVA1=0
 I (X>123)&(X<172) S YSDVA1=$P(G,U,X-100)*-1
 S:X>171 YSDVA1=-11
 F I=16:1:28 S $P(S,U,I)=$P(S,U,I)+YSDVA1
 Q
ADA ;anxiety/depression adjust
 S YSAX=$P(S,U,19),YSDD=$P(S,U,22)
 I (YSAX<75)&(YSDD<75) Q  ;-->out
 I (YSAX>74)&(YSDD<75) S YSADA=YSAX-75
 I (YSDD>74)&(YSAX<75) S YSADA=YSDD-75
 I (YSAX>74)&(YSDD>74) S YSADA=(YSAX-75)+(YSDD-75)
 I (YSINPT'="I")!(YSDUR>2) D T2
 I (YSINPT="I")&(YSDUR=1) D T3
 I (YSINPT="I")&(YSDUR=2) D T4
 I (YSINPT="I")&(YSDUR=0) D T2
 Q
T2 ;non inpt/long axis1
 S X=YSADA
 S X1=$S(X<10:1,X<15:2,X<20:3,X<25:4,X<30:5,X<35:6,X<40:7,X<45:8,X<50:9,X<55:10,X<60:11,X<65:12,X<70:13,X<75:14,X<81:15,1:0)
 F I=7,15,17 S $P(S,U,I)=$P(S,U,I)-X1
 S X1=$S(X<16:1,X<24:2,X<32:3,X<40:4,X<48:5,X<56:6,X<64:7,X<72:8,X<80:9,X=80:10,1:0)
 F I=6,16 S $P(S,U,I)=$P(S,U,I)-X1
 Q
T3 ;inpt dur<1 week
 S X=YSADA
 S X1=$S(X<5:1,X<8:2,X<10:3,X<13:4,X<15:5,X<18:6,X<20:7,X<23:8,X<25:9,X<28:10,X<30:11,X<33:12,X<35:13,X<38:14,X<81:15,1:0)
 F I=7,15,17 S $P(S,U,I)=$P(S,U,I)-X1
 S X1=$S(X<8:1,X<12:2,X<16:3,X<20:4,X<24:5,X<28:6,X<32:7,X<36:8,X<40:9,X<44:10,X<48:11,X<53:12,X<56:13,X<60:14,X<81:15,1:0)
 F I=6,16 S $P(S,U,I)=$P(S,U,I)-X1
 Q
T4 ;inpt dur1-4
 S X=YSADA
 S X1=$S(X<7:1,X<10:2,X<14:3,X<17:4,X<20:5,X<24:6,X<27:7,X<30:8,X<34:9,X<37:10,X<40:11,X<44:12,X<47:13,X<50:14,X<81:15,1:0)
 F I=7,15,17 S $P(S,U,I)=$P(S,U,I)-X1
 S X1=$S(X<11:1,X<16:2,X<22:3,X<27:4,X<32:5,X<38:6,X<43:7,X<48:8,X<54:9,X<59:10,X<64:11,X<70:12,X<75:13,X<80:14,X=80:15,1:0)
 F I=6,16 S $P(S,U,I)=$P(S,U,I)-X1
 Q
LIMIT ;set 0-115 range
 F I=1:1:28 S:$P(S,U,I)<0 $P(S,U,I)=0 S:$P(S,U,I)>115 $P(S,U,I)=115
 Q
INPTAD ;inpatient adjustment
 I (YSINPT="I")&(YSDUR=1) S $P(S,U,26)=$P(S,U,26)+6,$P(S,U,27)=$P(S,U,27)+10,$P(S,U,28)=$P(S,U,28)+4
 I (YSINPT="I")&(YSDUR=2) S $P(S,U,26)=$P(S,U,26)+4,$P(S,U,27)=$P(S,U,27)+8,$P(S,U,28)=$P(S,U,28)+2
 Q
DENIAL ;denial/complaint
 S YSBR="",YSHI="" F I=7,11,15,12,6,14,13,9,10,8,5 S:$P(S,U,I)>YSBR YSBR=$P(S,U,I),YSHI=I
 Q:(YSHI'=9)&(YSHI'=10)&(YSHI'=13)
 S YSBR="",YSHI="" F I=13,9,10 S:$P(S,U,I)>YSBR YSBR=$P(S,U,I),YSHI=I
 S $P(S,U,YSHI)=$P(S,U,YSHI)+8
 Q
INP(YSDFN,YSDOT) ;Determine if inpatient and duration
 ;  Input: YSDFN = dfn
 ;         YSDOT = date of test
 ; Output: piece1^piece2 
 ;         where piece 1 = I for Inpatient or O for Outpatient
 ;               piece 2 = duration of stay before test given
 ;                         0 = more than 4 weeks
 ;                         1 = less than 1 week
 ;                         2 = 1- 4 weeks
 N DFN,VAINDT,YSADMDT,YSDAYS,YSFLAG,X,Y
 S YSDFN=$G(YSDFN),YSDOT=$G(YSDOT),YSFLAG="O^"
 I YSDFN="" Q YSFLAG
 I YSDOT="" Q YSFLAG
 S DFN=YSDFN,VAINDT=YSDOT
 D IN5^VADPT
 S YSADMDT=$P(VAIP(3),U,1) ;admission date/time
 D KVAR^VADPT
 I YSADMDT="" Q YSFLAG
 S YSDAYS=+$$FMDIFF($P(YSDOT,".",1),$P(YSADMDT,".",1),1)
 I YSDAYS="" Q YSFLAG
 I YSDAYS<7 Q "I^1"
 I YSDAYS>27 Q "I^0"
 I (YSDAYS>6)&(YSDAYS<28) Q "I^2"
 Q YSFLAG
 ;
FMDIFF(YSX1,YSX2,YSX3) ;Calculate number of days between admission and
 ;date test was given
 ;  Input: YSX1 = date/time patient was admitted
 ;         YSX2 = date/time patient was given test
 ;         YSX3 = flag for count of days
 ; Output: number of days between YSX1 and YSX2
 S YSX1=$G(YSX1),YSX2=$G(YSX2),YSX3=$G(YSX3,1)
 I YSX1="" Q ""
 I YSX2="" Q ""
 Q $$FMDIFF^XLFDT($P(YSX1,".",1),$P(YSX2,".",1),YSX3)
 ;
WSCALE ;calculate Inconsistent responses
 N YSWA1,YSWA2,YSWI,YSWNODE,YSWP,YSWPAIR,YSWQ1,YSWQ2,YSWQA1,YSWQA2
 F YSWI=1:1:5 D
 .S YSWNODE=$G(^YTT(601,YSTEST,"S",29,"K",YSWI,0))
 .F YSWP=1:1:$L(YSWNODE,U) D
 ..S YSWPAIR=$P(YSWNODE,U,YSWP)
 ..S YSWQA1=$P(YSWPAIR,"-",1),YSWQA2=$P(YSWPAIR,"-",2)
 ..S YSWQ1=$P(YSWQA1,";",1),YSWA1=$P(YSWQA1,";",2)
 ..S YSWQ2=$P(YSWQA2,";",1),YSWA2=$P(YSWQA2,";",2)
 ..I ($E(X,YSWQ1)=YSWA1)&($E(X,YSWQ2)=YSWA2) S $P(R,U,29)=$P(R,U,29)+1
 Q
