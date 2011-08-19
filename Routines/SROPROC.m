SROPROC ;BIR/MAM - ENTER PRINCIPAL OPERATIVE PROCEDURE ;06/28/10
 ;;3.0; Surgery ;**1,38,86,174**;24 Jun 93;Build 8
OP Q:SRSOUT  W !!,"Enter the Principal Operative Procedure: " R SRSOP:DTIME S:'$T SRSOP="^" I SRSOP["^" S SRSOUT=1 Q
 I SRSOP="" W !!,"A principal operative procedure must be entered when creating a new case.",!!,"Press RETURN to enter a procedure, or '^' to quit.  " R X:DTIME S:'$T X="^" S:X["^" SRSOUT=1 G OP
 I SRSOP["@" W !!,"The principal operative procedure that you have entered contains a '@'.  This",!,"character cannot be contained in your answer." G OP
 I SRSOP[";" W !!,"The principal operative procedure cannot contain a semicolon (;).  Please",!,"re-enter the procedure, using commas in place of the semicolons." G OP
 I SRSOP?.E1C.E W !!,"Your answer contains a control character.  Please re-type the procedure name." G OP
 I SRSOP["?" W !!,"Enter the name of the principal operative procedure for this surgical case.",!,"If there is more than one procedure being performed by this surgical specialty,",!,"you will be prompted for 'OTHER OPERATIVE"
 I SRSOP["?" W " PROCEDURES'.  Your answer must be",!,"3 to 135 characters in length." G OP
 F  Q:$E(SRSOP)'=" "  S SRSOP=$E(SRSOP,2,200)
 I $L(SRSOP)>135 W !!,"The name of the principal operative procedure can be up to 135 characters in",!,"length.  Please re-enter the procedure name in an abbreviated form." G OP
 I $L(SRSOP)<3 W !!,"Your answer must be at least 3 characters in length.  Please enter more",!,"information in the procedure name." G OP
 I $L(SRSOP)>30 S X=SRSOP D PROC I '$D(X) G OP
 Q
PROC ; check for spaces
 I $E(X)=" " D EN^DDIOL("The first character must not be a space.","","!!,?5") K X Q
 I X["@" D EN^DDIOL("The procedure that you have entered contains a '@'. This character","","!!,?5"),EN^DDIOL("cannot be contained in your answer.","","!,?5") K X Q
 I X[";" D EN^DDIOL("The procedure cannot contain a semicolon (;). Please re-enter the","","!!,?5"),EN^DDIOL("procedure, using commas in place of the semicolons.","","!,?5") K X Q
 I X["^" D EN^DDIOL("The procedure that you have entered contains an up-arrow (^).","","!!,?5"),EN^DDIOL("This character cannot be contained in your answer.","","!,?5") K X Q
 I X?.E1C.E D EN^DDIOL("Your answer contains a control character. Please re-type the procedure","","!!,?5"),EN^DDIOL("name.","","!,?5") K X Q
 Q:$L(X)<30
 S SROP=X,SRFLG=0 F  D CHECK Q:SRFLG!($L(SROP)'>30)
 I '$D(X) D EN^DDIOL("Answer must contain at least one space in every 31 characters of length.","","!!,?5")
 I '$D(X) D EN^DDIOL("If you are using a comma (,) to separate information, leave a space after","","!,?5"),EN^DDIOL("it. Please re-enter the procedure name.","","!,?5")
 K SRBL,SROP,SRFLG
 Q
CHECK S SRBL=$F(SROP," ") I SRBL>32!('SRBL) S SRFLG=1 K X Q
 S SROP=$E(SROP,SRBL,$L(SROP))
 Q
WL ; input transform for waiting list procedure
 I X["?"!($L(X)<3)!($L(X)>75) D EN^DDIOL("Enter the name of the principal operative procedure for this surgical","","!!,?5"),EN^DDIOL("case. The procedure name must be 3 to 75 characters in length.","","!,?5") K X Q
 D PROC D:$D(X) EN^DDIOL("","","!")
 Q
