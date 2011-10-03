XMGAPI0 ;(WASH ISC)/CAP-Validate/Get Subject APIs ;04/17/2002  08:56
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points (DBIA 1142):
 ; $$SUBCHK - Validate a proposed message subject
 ; $$SUBGET - Retrieve the subject of a message
ENT(Y,Z) ;Check Input Subject
 ;Param1=String
 ;Param2=Silent Flag
 N A S A=""
 I $L(Y)>65 S A=1,%="Entered SUBJECT too long, "_$L($E(Y,66,999))_" characters longer than 65." S Y=$E(Y,1,250) G S:Z Q "3-"_%_U_$E(Y,1,65)
 ;
 I Y[U S Y=$$ENCODEUP^XMCU1(Y)
 ;
 ;REMOVE LEADING BLANKS
B I Y?1" ".E S Y=$E(Y,2,99) G B
 ;
 ;REMOVE TRAILING BLANKS
E I $E(Y,$L(Y))=" " S Y=$E(Y,1,$L(Y)-1) G E
 ;
 G U:Y'?.E1C.E I 'Z Q "5-Subject cannot contain control characters.^"_Y
 F X=1:1 I $E(Y,X)?1C S Y=$E(Y,1,X-1)_$E(Y,X+1,99) Q:Y'?.E1C.E  S X=X-1
 W $C(7),!,"Control characters removed ("""_Y_""" is Subject accepted).",!
 ;
U I Y="" Q ""
 I Y="?" S A=1,%="Enter a Message Subject, between 3 & 65 characters long or '^' to exit." G S:Z Q "4-"_%_U_Y
 I $L(Y)<3 S A=1,%="SUBJECT must be at least 3 characters long." G S:Z Q "1-"_%_U_Y
 I Y?1"R"2N.N S A=1,%="Subject names of this format (1""R""1.N) are RESERVED" G S:Z Q "2-"_%_U_Y
Q Q A_U_Y
S W !,$C(7),%,!
 G Q
SUBGET(X) ;Return Subject of a Message (""=Error, Else returns Subject)
 S X=$P($G(^XMB(3.9,X,0)),U) I X="" Q ""
 Q $$DECODEUP^XMCU1(X)
SUBCHK(X,Z) ;Check Subject (""=Error, Else returns Subject)
 ;Param1=String
 ;Param2=Silent Flag (0=Silent, 1=Verbose)
 N Y S Y=X
 Q $$ENT(X,Z)
