LR7OS ;DALOI/STAFF - Silent Report utilities ;May 14, 2008
 ;;5.2;LAB SERVICE;**121,350**;Sep 27, 1994;Build 230
 ;
S(X,Y,Z) ;Pad over
 ; X=Column #
 ; Y=Current length
 ; Z=Text
 ; SP=TEXT SENT
 ; CCNT=Line position after input text
 ;
 I '$D(Z) Q ""
 S SP=Z
 I X,Y,X>Y S SP=$$RJ^XLFSTR(" ",X-Y)_Z
 S CCNT=$$INC(CCNT,SP)
 Q SP
 ;
 ;
INC(X,Y) ;Character position count
 ; X=Current count
 ; Y=Text
 S INC=X+$L(Y)
 Q INC
