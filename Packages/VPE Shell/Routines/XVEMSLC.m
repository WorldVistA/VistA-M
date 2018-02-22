XVEMSLC ;DJB/VSHL**VA KERNEL Library Functions - Math [04/17/94];2017-08-15  5:03 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
MATH ;;;
 ;;; MATH FUNCTIONS - XLFMTH
 ;;;
 ;;; ABS(%X).......Absolute Value
 ;;;      Returns absolute value of the number in %X.
 ;;;
 ;;; MIN(%1,%2)....Minimum
 ;;;      Returns minimum value between numbers in %1 and %2.
 ;;;
 ;;; MAX(%1,%2)....Maximum
 ;;;      Returns maximum value between numbers in %1 and %2.
 ;;;
 ;;; LN(%X)........Natural Log
 ;;;      Returns natural log of %X (log base e).
 ;;;      Ex: W $$LN^XLFMTH(4.627426)  --> 1.532
 ;;;
 ;;; EXP(%X).......Exponents
 ;;;      Return e to the %X power.
 ;;;      Ex: W $$EXP^XLFMTH(1.532)  --> 4.627426
 ;;;
 ;;; PWR(%X,%Y)....Power
 ;;;      Raise %X to the %Y power.
 ;;;      Ex: W $$PWR^XLFMTH(3,2)   --> 9
 ;;;
 ;;; LOG(%X).......Log
 ;;;      Calculate logarithm (log base 10).
 ;;;      Ex: W $$LOG^XLFMTH(3.1415  --> .497137
 ;;;
 ;;; TAN(%X).......Tangent
 ;;;      Calculate tangent of %X (tan X = sin X / cos X) in radians.
 ;;;      Ex: W $$TAN^XLFMTH(.7853982)  --> 1.000
 ;;;
 ;;; SIN(%X).......Sine
 ;;;      Calculate sine of %X in radians.
 ;;;      Ex: W $$SIN^XLFMTH(.7853982)  --> .707107
 ;;;
 ;;; COS(%X).......Cosine
 ;;;      Calculate cosine of %X in radians.
 ;;;      Ex: W $$COS^XLFMTH(.7853982)  --> .707096
 ;;;
 ;;; DTR(%X)......Degrees to Radians
 ;;;      Convert numbers of degrees to number of radians.
 ;;;      Ex: W $$DTR^XLFMTH(45)  --> .7853982
 ;;;
 ;;; RTD(%X)......Radians to Degrees
 ;;;      Convert number of radians to number of degrees.
 ;;;
 ;;; PI().........PI=3.1415927
 ;;;      Returns Pi.
 ;;;
 ;;; E()..........e=2.718283
 ;;;      Returns e.
 ;;;
 ;;; SQRT(%X).....Square Root
 ;;;      Returns square root of %X.
 ;;;      Ex: W $$SQRT^XLFMTH(144)  --> 12
 ;;;
 ;;; SD...........Standard Deviation
 ;;;      Only available as a call: D SD^XTFN with input variables of
 ;;;      SX=sum, SSX=sum of squares, and N=count. Standard deviation
 ;;;      is returned in SD.
 ;;;***
