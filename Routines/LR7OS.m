LR7OS ;slc/dcm - Silent Report utilities ;8/11/97
 ;;5.2;LAB SERVICE;**121**;Sep 27, 1994
S(X,Y,Z) ;Pad over
 ;X=Column #
 ;Y=Current length
 ;Z=Text
 ;SP=TEXT SENT
 ;CCNT=Line position after input text
 I '$D(Z) Q ""
 S SP=Z I X,Y,X>Y S SP=$E("                                                                             ",1,X-Y)_Z
 S CCNT=$$INC(CCNT,SP)
 Q SP
INC(X,Y) ;Character position count
 ;X=Current count
 ;Y=Text
 S INC=X+$L(Y)
 Q INC
