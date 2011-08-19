ONCOSCOM ;WASH ISC/SRR-COMPUTATIONAL SUBROUTINES ;4/16/92  18:25
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;This module contains entry points for the following computations:
 ; EXP     - compute the exponential
 ; LOG10   - compute log to base 10
 ; LOG2    - compute log to base 2
 ; SQ      - compute the square root
 ;
 ;
EXP ;compute the exponential EXP(X)
 ;in:  X = argument must be less than 55.26
 ;out: Y = EXP(X)
 ;     Z = 1 for any problem in evaluations, 0 otherwise
 N F,I,LE,LZ,S
 S LE=.434294482,LZ=X,X=LE*X
 S Z=0,S=0 I X=0 S Y=1 G QEXP
 I +X'=X S Z=1 G QEXP
 I X<0 S S=1,X=-X
 S F=X#1,I=X\1,I="1E"_$E("-",S&I)_I
 S Y=.00093264267*F+0.00255491796*F+0.01742111988*F+0.07295173666*F+0.25439357484*F+0.66273088429*F+1.15129277603*F+1
 S Y=Y*Y
QEXP S:S Y=1/Y S Y=+$J(Y+0.000000005,0,8),Y=Y*I,X=LZ
 Q
 ;
LOGE ;compute log to base E
 ;arguments same as LOG10
 D LOG2 I 'Z S Y=+$J(Y/1.44269504,0,8)
 Q
 ;
LOG10 ;compute log to base 10
 ;in:  X = argument
 ;out: Y = LOG10(X)
 ;     Z = 1 if Y not evaluated, 0 otherwise
 D LOG2 I 'Z S Y=+$J(Y/3.321928096,0,8)
 Q
 ;
LOG2 ;compute log to base 2
 ;arguments are as above
 N LU,LV,LZ
 I X'>0!(+X'=X) S Z=1 Q
 S LZ=$L($P(X,".",1))
 I LZ S X="."_$E(X,1,LZ)_$E(X,LZ+2,255),X=+X
 E  F LZ=LZ:-1 Q:X'<.1  S X=X*10
 F Y=0:1:3 Q:X'<.5  S X=X*2
 S LU=X-.707106781/(X+.707106781),LV=LU*LU
 S LU=.434259751292*LV+.576584342056*LV+.961800762286*LV+2.885390072738*LU
 S Y=+$J(LZ*3.321928096+LU-Y-.5,0,8),Z=0
 Q
 ;
SQ ;compute square root
 ;in:  X = argument for square root
 ;out: Y = sq root of X if X'<0, of -X if X<0
 ;     Z = 1 if X<0, 0 otherwise
 S Z=(X<0) I X=0 S Y=0 Q
 I Z S X=-X
 I X>1 S Y=X\1
 E  S Y=1/X
 S Y=$E(Y,1,$L(Y)+1\2)
 E  S Y=1/Y
 F %=1:1:6 S Y=X/Y+Y*.5
 Q
 ;
TEST ;test LOGE & EXP
 N I
 F I=1:1:20 W !,I,?10 S X=I*1.33333 W X D LOGE W ?25,Y S X=Y D EXP W ?40,Y,?60,Z
 Q
