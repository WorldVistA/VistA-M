DINIT0F5 ;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;20JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,152,1044**
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT0F6 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.404,.00102,40,4,20)
 ;;=Y
 ;;^DIST(.404,.00102,40,4,21,0)
 ;;=^^1^1^2981102
 ;;^DIST(.404,.00102,40,4,21,1,0)
 ;;=Can user enter time along with date, as in 'FEB23, 1999@7:30'
 ;;^DIST(.404,.00102,40,5,0)
 ;;=25^CAN SECONDS BE ENTERED^2^^SECONDS
 ;;^DIST(.404,.00102,40,5,2)
 ;;=5,29^3^5,5
 ;;^DIST(.404,.00102,40,5,3)
 ;;=!M
 ;;^DIST(.404,.00102,40,5,3.1)
 ;;=S Y=$E("NY",$P(DICATT5,"""",2)["S"+1)
 ;;^DIST(.404,.00102,40,5,20)
 ;;=Y
 ;;^DIST(.404,.00102,40,6,0)
 ;;=26^IS TIME REQUIRED^2^^IS TIME REQUIRED
 ;;^DIST(.404,.00102,40,6,2)
 ;;=6,29^3^6,11
 ;;^DIST(.404,.00102,40,6,3)
 ;;=!M
 ;;^DIST(.404,.00102,40,6,3.1)
 ;;=S Y=$E("NY",$P(DICATT5,"""",2)["R"+1)
 ;;^DIST(.404,.00102,40,6,20)
 ;;=Y
 ;;^DIST(.404,.00102,40,6,21,0)
 ;;=^^1^1^2981102
 ;;^DIST(.404,.00102,40,6,21,1,0)
 ;;=Must user enter TIME along with DATE?
 ;;^DIST(.404,.00103,0)
 ;;=DICATT2^1
 ;;^DIST(.404,.00103,40,0)
 ;;=^.4044I^4^4
 ;;^DIST(.404,.00103,40,1,0)
 ;;=31^INCLUSIVE LOWER BOUND^2^^LOWER BOUND
 ;;^DIST(.404,.00103,40,1,2)
 ;;=1,38^20^1,15
 ;;^DIST(.404,.00103,40,1,3)
 ;;=!M
 ;;^DIST(.404,.00103,40,1,3.1)
 ;;=I DICATT5["X<" S Y=+$P(DICATT5,"X<",2)
 ;;^DIST(.404,.00103,40,1,4)
 ;;=1
 ;;^DIST(.404,.00103,40,1,20)
 ;;=F^^1:20
 ;;^DIST(.404,.00103,40,1,21,0)
 ;;=^^1^1^2990219
 ;;^DIST(.404,.00103,40,1,21,1,0)
 ;;=Enter the lowest allowable number
 ;;^DIST(.404,.00103,40,1,22)
 ;;=K:+X'=X!(X'["."&($L(X)>15))!(X["."&($L($P(+X,"."))+$L($P(+X,".",2))>15)) X
 ;;^DIST(.404,.00103,40,2,0)
 ;;=32^INCLUSIVE UPPER BOUND^2^^UPPER BOUND
 ;;^DIST(.404,.00103,40,2,2)
 ;;=2,38^20^2,15
 ;;^DIST(.404,.00103,40,2,3)
 ;;=!M
 ;;^DIST(.404,.00103,40,2,3.1)
 ;;=I DICATT5["X>" S Y=+$P(DICATT5,"X>",2)
 ;;^DIST(.404,.00103,40,2,4)
 ;;=1
 ;;^DIST(.404,.00103,40,2,20)
 ;;=F^^1:20
 ;;^DIST(.404,.00103,40,2,21,0)
 ;;=^^1^1^2990219
 ;;^DIST(.404,.00103,40,2,21,1,0)
 ;;=Enter the highest allowable number
 ;;^DIST(.404,.00103,40,2,22)
 ;;=K:+X'=X!(X'["."&($L(X)>15))!(X["."&($L($P(+X,"."))+$L($P(+X,"."))>15)) X
 ;;^DIST(.404,.00103,40,3,0)
 ;;=33^IS THIS A DOLLAR AMOUNT^2^^DOLLAR AMOUNT
 ;;^DIST(.404,.00103,40,3,2)
 ;;=3,38^3^3,13
 ;;^DIST(.404,.00103,40,3,3)
 ;;=!M
 ;;^DIST(.404,.00103,40,3,3.1)
 ;;=S Y=$E("NY",DICATT5["""$"""+1)
 ;;^DIST(.404,.00103,40,3,12)
 ;;=I X=1 D PUT^DDSVALF(34,,,2,"") S DDSBR="COM"
 ;;^DIST(.404,.00103,40,3,20)
 ;;=Y
 ;;^DIST(.404,.00103,40,4,0)
 ;;=34^MAXIMUM NUMBER OF FRACTIONAL DIGITS^2^^FRACTIONAL DIGITS
 ;;^DIST(.404,.00103,40,4,2)
 ;;=4,38^1^4,1
 ;;^DIST(.404,.00103,40,4,3)
 ;;=!M
 ;;^DIST(.404,.00103,40,4,3.1)
 ;;=S Y=$S(DICATT5["""$""":2,1:$P(DICATT5,"1"".""",2)-1) S:Y<0 Y=0
 ;;^DIST(.404,.00103,40,4,4)
 ;;=0
 ;;^DIST(.404,.00103,40,4,20)
 ;;=N^^0:9
 ;;^DIST(.404,.00104,0)
 ;;=DICATT4^1
 ;;^DIST(.404,.00104,40,0)
 ;;=^.4044I^3^3
 ;;^DIST(.404,.00104,40,1,0)
 ;;=68^MINIMUM LENGTH^2^^MINIMUM LENGTH
 ;;^DIST(.404,.00104,40,1,2)
 ;;=2,27^7^2,11
 ;;^DIST(.404,.00104,40,1,3)
 ;;=!M
 ;;^DIST(.404,.00104,40,1,3.1)
 ;;=S Y=+$P(DICATT5,"$L(X)<",2) S:'Y Y=""
 ;;^DIST(.404,.00104,40,1,4)
 ;;=1
 ;;^DIST(.404,.00104,40,1,20)
 ;;=F^^1:7
 ;;^DIST(.404,.00104,40,1,22)
 ;;=K:X'?1.N!'X X
 ;;^DIST(.404,.00104,40,2,0)
 ;;=69^MAXIMUM LENGTH^2^^MAXIMUM LENGTH
 ;;^DIST(.404,.00104,40,2,2)
 ;;=3,27^7^3,11
 ;;^DIST(.404,.00104,40,2,3)
 ;;=!M
 ;;^DIST(.404,.00104,40,2,3.1)
 ;;=S Y=+$P(DICATT5,"$L(X)>",2) S:'Y Y=""
 ;;^DIST(.404,.00104,40,2,4)
 ;;=1
 ;;^DIST(.404,.00104,40,2,20)
 ;;=F^^1:7
 ;;^DIST(.404,.00104,40,2,22)
 ;;=K:X'?1.N!(X<1) X I $D(X) K:X>($G(^DD("STRING_LIMIT"),255)-5) X
 ;;^DIST(.404,.00104,40,3,0)
 ;;=70^PATTERN MATCH (IN 'X')^2^^PATTERN MATCH
 ;;^DIST(.404,.00104,40,3,2)
 ;;=4,27^30^4,3
 ;;^DIST(.404,.00104,40,3,3)
 ;;=!M
 ;;^DIST(.404,.00104,40,3,3.1)
 ;;=D PRE4^DICATTD4
 ;;^DIST(.404,.00104,40,3,20)
 ;;=F^U^3:80
 ;;^DIST(.404,.00104,40,3,21,0)
 ;;=^^1^1^2981104
 ;;^DIST(.404,.00104,40,3,21,1,0)
 ;;=Example: "X?1.A"  or  "X'?.P"
 ;;^DIST(.404,.00104,40,3,22)
 ;;=S X="I "_X D ^DIM S:$D(X) X=$E(X,3,999)
 ;;^DIST(.404,.00105,0)
 ;;=DICATT5^1
 ;;^DIST(.404,.00105,40,0)
 ;;=^.4044I^2^2
 ;;^DIST(.404,.00105,40,1,0)
 ;;=75^SHALL THIS TEXT NORMALLY APPEAR IN WORD-WRAP MODE^2^^WORD-WRAP
 ;;^DIST(.404,.00105,40,1,2)
 ;;=2,53^3^2,2
 ;;^DIST(.404,.00105,40,1,3)
 ;;=!M
 ;;^DIST(.404,.00105,40,1,3.1)
 ;;=S Y=$E("YN",DICATT2["L"+1)
 ;;^DIST(.404,.00105,40,1,12)
 ;;=S DICATTMN="",DICATT2N="W"_$TR($G(DICATT2N),"WL")_$E("L",'X)
 ;;^DIST(.404,.00105,40,1,20)
 ;;=Y
 ;;^DIST(.404,.00105,40,1,21,0)
 ;;=^^4^4^2981120
 ;;^DIST(.404,.00105,40,1,21,1,0)
 ;;=Answer 'YES' if the text should normally be printed out in full lines,
 ;;^DIST(.404,.00105,40,1,21,2,0)
 ;;=breaking at word boundaries.
 ;;^DIST(.404,.00105,40,1,21,3,0)
 ;;=Answer 'NO' if the text should normally be printed out line-for-line as
 ;;^DIST(.404,.00105,40,1,21,4,0)
 ;;=it was entered.
 ;;^DIST(.404,.00105,40,2,0)
 ;;=76^SHALL "|" CHARACTERS IN THIS TEXT BE TREATED LIKE ANY OTHER CHARACTERS^2^^"|"
 ;;^DIST(.404,.00105,40,2,2)
 ;;=3,74^3^3,2
 ;;^DIST(.404,.00105,40,2,3)
 ;;=!M
 ;;^DIST(.404,.00105,40,2,3.1)
 ;;=S Y=$S(DICATT2["X"!(DICATT2["x")!(DICATT2=""):"Y",1:"N")
 ;;^DIST(.404,.00105,40,2,12)
 ;;=S DICATTMN="",DICATT2N="W"_$TR($G(DICATT2N),"WxX")_$E("x",X>0) I DUZ(0)="@",DICATT4="" S DDSSTACK=4
 ;;^DIST(.404,.00105,40,2,20)
 ;;=Y
 ;;^DIST(.404,.00105,40,2,21,0)
 ;;=^^4^4^2981120
 ;;^DIST(.404,.00105,40,2,21,1,0)
 ;;=Answer 'YES' if the internally-stored text may have "|" characters in it 
 ;;^DIST(.404,.00105,40,2,21,2,0)
 ;;=(such as HL7 messages) that need to display exactly as they are stored.
 ;;^DIST(.404,.00105,40,2,21,3,0)
 ;;=Answer 'NO' if the internal text should normally be printed out with
 ;;^DIST(.404,.00105,40,2,21,4,0)
 ;;=anything that is delimited by "|" characters interpreted as variable. 
 ;;^DIST(.404,.00106,0)
 ;;=DICATT6^1
 ;;^DIST(.404,.00106,40,0)
 ;;=^.4044I^8^8
 ;;^DIST(.404,.00106,40,1,0)
 ;;=78^^2^^COMPUTED EXPRESSION
 ;;^DIST(.404,.00106,40,1,2)
 ;;=3,2^73
 ;;^DIST(.404,.00106,40,1,3)
 ;;=!M
 ;;^DIST(.404,.00106,40,1,3.1)
 ;;=S Y=$G(^DD(DICATTA,DICATTF,9.1))
 ;;^DIST(.404,.00106,40,1,4)
 ;;=1
 ;;^DIST(.404,.00106,40,1,13)
 ;;=D VAL6^DICATTD6
 ;;^DIST(.404,.00106,40,1,20)
 ;;=F^U^1:250
 ;;^DIST(.404,.00106,40,1,21,0)
 ;;=^^3^3^2981118
 ;;^DIST(.404,.00106,40,1,21,1,0)
 ;;=A Computed Expression consists of Field Names, Operators (including "_"
 ;;^DIST(.404,.00106,40,1,21,2,0)
 ;;=for concatenation), Functions, and literal strings (e.g., "Name: ") and
 ;;^DIST(.404,.00106,40,1,21,3,0)
 ;;=digits.
 ;;^DIST(.404,.00106,40,2,0)
 ;;=77^COMPUTED-FIELD EXPRESSION:^1^^COMP
 ;;^DIST(.404,.00106,40,2,2)
 ;;=^^2,2
 ;;^DIST(.404,.00106,40,3,0)
 ;;=80^NUMBER OF FRACTIONAL DIGITS TO OUTPUT^2^^FRACTIONAL DIGITS
 ;;^DIST(.404,.00106,40,3,2)
 ;;=5,65^1^5,26
 ;;^DIST(.404,.00106,40,3,3)
 ;;=!M
 ;;^DIST(.404,.00106,40,3,3.1)
 ;;=S Y=$P($P(DICATT2,"J",2),",",2),Y=$S(Y?1N.E:+Y,1:"")
 ;;^DIST(.404,.00106,40,3,20)
 ;;=N^^0:9:0
 ;;^DIST(.404,.00106,40,3,21,0)
 ;;=^^2^2^2981118
 ;;^DIST(.404,.00106,40,3,21,1,0)
 ;;=Enter the number of digits that should normally appear to the
 ;;^DIST(.404,.00106,40,3,21,2,0)
 ;;=right of the decimal point when this Field's value is displayed.
 ;;^DIST(.404,.00106,40,4,0)
 ;;=79^TYPE OF RESULT^2^^COMPTYPE
 ;;^DIST(.404,.00106,40,4,2)
 ;;=4,29^17^4,13
 ;;^DIST(.404,.00106,40,4,10)
 ;;=D BR79^DICATTD6
 ;;^DIST(.404,.00106,40,4,20)
 ;;=S^M^D:DATE;N:NUMERIC;B:BOOLEAN;S:STRING;m:MULTIPLE-VALUED;mp:MULTIPLE POINTER;p:POINTER
 ;;^DIST(.404,.00106,40,4,21,0)
 ;;=^^4^4^2981118
 ;;^DIST(.404,.00106,40,4,21,1,0)
 ;;=The typical Computed Field is STRING-valued, i.e., alphanumeric.
 ;;^DIST(.404,.00106,40,4,21,2,0)
 ;;=If NUMERIC, the indented questions will be asked.
 ;;^DIST(.404,.00106,40,4,21,3,0)
 ;;=BOOLEAN values are "true-false".
 ;;^DIST(.404,.00106,40,4,21,4,0)
 ;;=If the computation returns a number that is actually an Entry number in a File, call it a POINTER.
 ;;^DIST(.404,.00106,40,8,0)
 ;;=83.1^POINT TO FILE^2
 ;;^DIST(.404,.00106,40,8,2)
 ;;=8,46^27^8,30
 ;;^DIST(.404,.00106,40,8,3)
 ;;=!M
 ;;^DIST(.404,.00106,40,8,3.1)
 ;;=S Y=+$P(DICATT2,"p",2),Y=$S(Y:$P($G(^DIC(Y,0)),U),1:"")
 ;;^DIST(.404,.00106,40,8,20)
 ;;=P^^1:EOFIZ
 ;;^DIST(.404,.00106,40,8,24)
 ;;=S DIR("S")="I $$OKFILE^DICOMPX(Y,""W"")"
