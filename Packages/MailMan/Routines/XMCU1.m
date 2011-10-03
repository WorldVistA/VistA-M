XMCU1 ;(WASH ISC)/CMW-Encode/Decode String APIs ;04/17/2002  08:30
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points (DBIA 1136):
 ; $$ENCODEUP - Convert all "^" to "~U~"
 ; $$DECODEUP - Convert all "~U~" to "^"
 ; $$STRAN    - Convert all control characters to printable ones
 ; $$RTRAN    - Undo the conversion done by $$STRAN
 ;
RTRAN(XXX) ; Extrinsic Function to decode control characters
 ;Input=STRING
 ;Output=STRING
 N XMESC,X,Y,X1,I
 S XMESC="~"
 Q:XXX'[XMESC
 S Y="",X1=XXX
R1 S I=$F(X1,XMESC) I I=0 S X=Y_X1 G SET
 S Y=Y_$E(X1,1,I-2)_$C($A($E(X1,I))-64#128),X1=$E(X1,I+1,999) G R1
SET Q X
STRAN(XXX) ; Extrinsic Function to encode control characters
 ;Input=STRING
 ;Output=STRING
 N XMESC,Y,X1,I
 S XMESC="~"
 S Y="" F I=1:1:$L(XXX) S X1=$E(XXX,I) S Y=Y_$S(X1=XMESC:XMESC_$C(62),X1?1C:XMESC_$C($A(X1)+64#128),1:X1)
 Q Y
ENCODEUP(XXX) ; Extrinsic Function to encode "^" into "~U~"
 ; Input=STRING
 ; Output=STRING
 F  Q:XXX'[U  S XXX=$P(XXX,U)_"~U~"_$P(XXX,U,2,999)
 Q XXX
DECODEUP(XXX) ; Extrinsic Function to decode "~U~" to "^"
 ; Input=STRING
 ; Output=STRING
 F  Q:XXX'["~U~"  S XXX=$P(XXX,"~U~")_"^"_$P(XXX,"~U~",2,999)
 Q XXX
