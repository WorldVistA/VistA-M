HLFNC ;AISC/SAW/OAK-OIFO/RBN-Routine of Functions and Other Calls Used for HL7 Messages  ;03/26/2008  11:34
 ;;1.6;HEALTH LEVEL SEVEN;**38,42,51,66,141**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
HLNAME(X,HLECDE) ;Convert a name in DHCP format to HL7 format
 ; INPUT: X - Name in DHCP format
 ;        Optional - HLECDE - HL7 encoding chars 
 ;**** NOTE: ****
 ;If this function is called without HLECDE as parameter than HLECH
 ;must be define. 
 ;
 Q:'$D(X) ""  Q:X="" ""
 I '$D(HLECH),'$D(HLECDE) Q ""
 I $D(HLECDE) N HLECH S HLECH=HLECDE
 I '$D(HLECH) Q ""
 N %,X1,X2,Y
 S X1=$P(X,",",2),X2=$L(X1," "),Y=$P(X,",")_$E(HLECH)_$P(X1," ") I X2 F %=2:1:X2 Q:$P(X1," ",%)']""  S Y=Y_$E(HLECH)_$P(X1," ",%)
 Q Y
 ;
FMNAME(X,HLECDE) ;Convert a name in HL7 format to DHCP format
 ; INPUT: X - Name in HL7 format
 ;        Optional - HLECDE - HL7 encoding chars 
 ;**** NOTE: ****
 ;If this function is called without HLECDE as parameter than HLECH
 ;must be define. 
 ;
 Q:'$D(X) ""  Q:X="" ""
 I '$D(HLECH),'$D(HLECDE) Q ""
 I $D(HLECDE) N HLECH S HLECH=HLECDE
 I '$D(HLECH) Q ""
 N %,X1 S X1=$L(X,$E(HLECH)),Y="" F %=1:1:X1 D
 .I $P(X,$E(HLECH),%)]"",$P(X,$E(HLECH),%)'="""""" D
 ..;Only last name,first name.
 ..I %<3 S Y=Y_$P(X,$E(HLECH),%)_$S(%=1:",",1:"") Q
 ..S Y=Y_" "_$P(X,$E(HLECH),%)
 Q Y
 ;
HLDATE(X,Y) ;Convert date, date/time or time only in FM format to HL7 format
 ;Optional Variables:
 ;Y = The type of format to be returned if you want to force return of a
 ;    specific format.  Y must be equal to one of the following:
 ;    DT - Date only
 ;    TM - Time only
 ;    TS - Date and time
 I X="" Q ""
 S Y=$G(Y)
 N %,Z
 I $L(X)<7 D  Q % ;Time input
 . S %=$S(X=2400:"0000",$L(X)<4:$E(X_"000",1,4),1:X) S:$L(%)=5 %=%_0
 . Q
 I Y="TM" D  Q % ;Only time
 . S %=$P(X,".",2),%=$S(%="":"",$E(%,1,2)=24:"0000",$L(%)<4:$E(%_"000",1,4),1:%) S:$L(%)=5 %=%_0
 . Q
 S %=$$FMTHL7^XLFDT(X)
 Q $S(Y="DT":$E(%,1,8),1:%)
 ;
FMDATE(X) ; Convert a date, date/time or time only in HL7 format to FM format
 I X="" Q ""
 N %
 S %=$P($TR(X,"+-","^"),"^")
 I $L(X)<7 Q %
 Q $$HL7TFM^XLFDT(X)
 ;
M10(X,HLECDE) ; M10  check digit scheme
 ; INPUT : X - ID number
 ;        Optional HLECDE - Encoding chars
 ;**** NOTE: ****
 ;If this function is called without HLECDE as parameter then HLECH
 ;must be defined. 
 ;Return X if encoding character is not defined
 ;Return X with encoding characters concatenated if X is alphanumeric
 ;
 N HLCNT,HLODD,HLEVEN,HLX1,HLDIGIT
 Q:'$D(X) ""
 I $D(HLECDE) N HLECH S HLECH=HLECDE
 ;Return X if encoding character is not defined
 I '$D(HLECH) Q X
 ;Return X with encoding characters concatenated if X is alphanumeric
 I '(X?1.N) Q X_$E(HLECH)_$E(HLECH)
 ;
 S HLX1=+X
 S HLODD=""
 F HLCNT=$L(HLX1):-2:1 S HLODD=HLODD_$E(HLX1,HLCNT)
 S HLODD=HLODD*2
 S HLEVEN=""
 F HLCNT=($L(HLX1)-1):-2:1 S HLEVEN=HLEVEN_$E(HLX1,HLCNT)
 S HLX1=HLEVEN_HLODD
 S HLDIGIT=0
 F HLCNT=1:1:$L(HLX1) S HLDIGIT=HLDIGIT+$E(HLX1,HLCNT)
 S HLDIGIT=((HLDIGIT\10+1)*10-HLDIGIT)#10
 Q X_$E(HLECH)_HLDIGIT_$E(HLECH)_"M10"
 ;
M11(X,HLECDE) ; M11 check digit scheme
 ; INPUT : X - ID number
 ;        Optional HLECDE - Encoding chars
 ;**** NOTE: ****
 ;If this function is called without HLECDE as parameter then HLECH
 ;must be defined. 
 ;Return X if encoding character is not defined
 ;Return X with encoding characters concatenated if X is alphanumeric
 ;
 N HLX1,HLCNT,HLWT,HLDIGIT
 Q:'$D(X) ""
 I $D(HLECDE) N HLECH S HLECH=HLECDE
 ;Return X if encoding character is not defined
 I '$D(HLECH) Q X
 ;Return X with encoding characters concatenated if X is alphanumeric
 I '(X?1N.N) Q X_$E(HLECH)_$E(HLECH)
 ;
 S HLX1=+X
 S HLDIGIT=0,HLWT=2
 F HLCNT=$L(HLX1):-1:1 D
 . I HLWT>7 S HLWT=2
 . S HLDIGIT=HLDIGIT+($E(HLX1,HLCNT)*HLWT)
 . S HLWT=HLWT+1
 S HLDIGIT=HLDIGIT#11
 I HLDIGIT=0 S HLDIGIT=1
 S HLDIGIT=(11-HLDIGIT)#10
 Q X_$E(HLECH)_HLDIGIT_$E(HLECH)_"M11"
 ;
OLDM10(X,HLECDE) ;Calculate M10 checksum
 ; INPUT : X - String to calc checksum
 ;        Optional HLECDE - Encoding chars
 ;**** NOTE: ****
 ;If this function is called without HLECDE as parameter than HLECH
 ;must be define. 
 ;
 Q:'$D(X) ""
 I '$D(HLECH),'$D(HLECDE) Q ""
 I $D(HLECDE) N HLECH S HLECH=HLECDE
 I '$D(HLECH) Q ""
 N %,Y
 S Y=0 F %=1:1:$L(X) S Y=Y+$E(X,%)
 Q X_$E(HLECH)_(Y#10)_$E(HLECH)_"M10"
 ;
OLDM11(X,HLECDE) ;Calculate M11 checksum
 ; INPUT : X - String to calc checksum
 ;        Optional HLECDE - Encoding chars
 ;**** NOTE: ****
 ;If this function is called without HLECDE as parameter than HLECH
 ;must be define. 
 ;
 Q:'$D(X) ""
 I '$D(HLECH),'$D(HLECDE) Q ""
 I $D(HLECDE) N HLECH S HLECH=HLECDE
 I '$D(HLECH) Q ""
 N %,Y S Y=0 F %=1:1:$L(X) S Y=Y+$E(X,%)
 Q X_$E(HLECH)_(Y#11)_$E(HLECH)_"M11"
UPPER(X) ;Convert lowercase letters to uppercase
 Q:'$D(X) ""
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
HLPHONE(X,B,C) ;Convert DHCP Phone Number to HL7 Format
 ;Required parameters:
 ;X = Seven digit phone number at a minimum.  Optionally, in addition,
 ;    a three digit area code, two digit country code and other
 ;    formatting characters (e.g., dashes)
 ;Optional Variables:
 ;B = Beeper number
 ;C = Comments
 Q:'$D(X) ""  Q:$L(X)<7 ""
 N I,Y,Y1,Z S B=$S('$D(B):"",1:"B"_B),C=$S('$D(C):"",1:"C"_C)
 ;
 ; patch HL*1.6*141 start
 ; S Y="" F I=1:1:$L(X) S Y=Y_$S($E(X,I)?1N:$E(X,I),"X,x"[$E(X,I)&('$D(Z)):"X",1:"") I "X,x"[$E(X,I) S Z=""
 N CH
 S Y=""
 F I=1:1:$L(X) D
 . S CH=$E(X,I)
 . ; Next line modified by RBN
 . ;S Y=Y_$S(CH?1N:CH,"Xx"[CH&('$D(Z)):"X",1:"")
 . S Y=Y_$S(CH?1N:CH,"Xx,*"[CH&('$D(Z)):"X",1:"")
 . I "Xx"[CH S Z=""
 ;
 ; the number, following "X" character, should be greater than 0
 I Y["X",+$P(Y,"X",2)<1 S Y=$P(Y,"X")
 ; patch HL*1.6*141 end
 ;
 I $L(Y)<7 Q ""
 S Y1=$S(Y["X":"X"_$P(Y,"X",2),1:""),Y=$P(Y,"X") I $L(Y)<7 Q ""
 I $L(Y)=8,189[$E(Y) S Y=$E(Y,2,8)
 I $L(Y)=11,189[$E(Y) S Y=$E(Y,2,11)
 I $L(Y)=7 Q $E($E(Y,1,3)_"-"_$E(Y,4,7)_Y1_B_C,1,40)
 I $L(Y)=10 Q $E("("_$E(Y,1,3)_")"_$E(Y,4,6)_"-"_$E(Y,7,10)_Y1_B_C,1,40)
 I $L(Y)=12 Q $E($E(Y,1,2)_" ("_$E(Y,3,5)_")"_$E(Y,6,8)_"-"_$E(Y,9,12)_Y1_B_C,1,40)
 Q ""
HLADDR(AD,GL,HLECDE) ;Convert DHCP address fields to HL7 address format
 ;Required parameters:
 ;AD = One to four street address lines separated by uparrows (^).
 ;GL = Three to four geographic location components separated by
 ;     uparrows (^).  City^State or Province^Zip Code^Country Code.
 ;     If the fourth component is not defined, it will be set to 'USA'.
 ;     The second component must be null or an IEN in the
 ;     State file (#5).  The third component must be null or pattern
 ;     match 5N, 9N or 5N1"-"4N.
 ;
 ;        Optional HLECDE - Encoding chars
 ;**** NOTE: ****
 ;If this function is called without HLECDE as parameter than HLECH
 ;must be define. 
 ;
 ;
 ;A string will be returned with six components separated by the HL7
 ;component separator.  The length of the string (including separators)
 ;may exceed 106 characters.
 ;
 Q:'$D(AD) ""  Q:'$D(GL) ""
 I '$D(HLECH),'$D(HLECDE) Q ""
 I $D(HLECDE) N HLECH S HLECH=HLECDE
 I '$D(HLECH) Q ""
 I $D(XRTL) D T0^%ZOSV
 N I,X,Y
 I $P(GL,"^",4)="" S $P(GL,"^",4)="USA"
 I $P(GL,"^",4)="USA" S X=$P(GL,"^",3) S:X?9N X=$E(X,1,5)_"-"_$E(X,6,9) S $P(GL,"^",3)=$S(X?5N!(X?5N1"-"4N):X,1:"")
 S X=+$P(GL,"^",2) S $P(GL,"^",2)=$S('X:"",$P($G(^DIC(5,X,0)),"^",2)]"":$E($P(^(0),"^",2),1,2),1:"")
 S Y=$E(HLECH)_$P(GL,"^")_$E(HLECH)_$P(GL,"^",2)_$E(HLECH)_$P(GL,"^",3)_$E(HLECH)_$P(GL,"^",4)
 S X=$P(AD,"^",1,4) F I=1,2 I X["^^" S X=$P(X,"^^")_"^"_$P(X,"^^",2,3)
 I $E(X,$L(X))="^" S X=$E(X,1,($L(X)-1))
 I $D(XRT0) S XRTN="HLFNC" D T1^%ZOSV
 I $L(X,"^")=1 Q $P(X,"^")_$E(HLECH)_Y
 I $L(X,"^")=2 Q $P(X,"^")_$E(HLECH)_$P(X,"^",2)_Y
 I $L(X,"^")=3 Q $P(X,"^")_", "_$P(X,"^",2)_$E(HLECH)_$P(X,"^",3)_Y
 I $L(X,"^")=4 Q $P(X,"^")_", "_$P(X,"^",2)_$E(HLECH)_$P(X,"^",3)_", "_$P(X,"^",4)_Y
