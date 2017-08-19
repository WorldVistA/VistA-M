TIUABBV ;BPOIFO/EL - Input transforms for UNAUTHORIZED ABBREVIATIONS ;7/10/2015
 ;;1.0;TEXT INTEGRATION UTILITIES;**297**;JUN 20, 1997;Build 40
 ;
 ; External Reference DBIA#:
 ; -------------------------
 ; #10142 - DDIOL call (Supported)
 ; #10104 - XLFSTR call (Supported)
 ;
 Q
 ;
LABBV(X) ; LOCAL Unauthorized Abbreviation check
 ; Check and prevent National Abbreviation to be edited
 I $P($G(^TIU(8927.9,+$G(DA),0)),U,2)="N" D  Q 0
 . D EN^DDIOL("National Unauthorized Abbreviation cannot be altered.")
 ;
CKABBV ;NATIONAL AND LOCAL Unauthorized Abbreviation check 
 I $L(X)>30!($L(X)<1) D  Q 0
 .  D EN^DDIOL("Abbreviation has to be within 1 to 30 character(s)")
 I $F(X,"|")!$F(X,"^")!$F(X,"&")!$F(X,"~")!$F(X,"\") D  Q 0
 .  D EN^DDIOL("Abbreviation cannot contain the following punctuations: |^&~\:;,!?")
 I $F(X,":")!$F(X,";")!$F(X,",")!$F(X,"!")!$F(X,"?") D  Q 0
 .  D EN^DDIOL("Abbreviation cannot contain the following punctuations: |^&~\:;,!?")
 I $F(X," ") D  Q 0
 .  D EN^DDIOL("Abbreviation has to be one word without space.")
 I $L(X)=1,$A($$UP^XLFSTR(X))<65!($A($$UP^XLFSTR(X))>90) D  Q 0
 .  D EN^DDIOL("Abbreviation cannot be one non-alpha character.")
 I X?1P.P D  Q 0
 .  D EN^DDIOL("Abbreviation cannot contain all punctuations.")
 I ($G(Y)="-1"),'$D(^TIU(8927.9,"B",$G(X))) G SETABBV ;Q 1
 I $G(Y)=$G(X),($G(X)'="") G SETABBV ;Q 1
 I '$D(^TIU(8927.9,"B",$G(X))) G SETABBV ;Q 1
 I +$G(DA)>0,($G(^TIU(8927.9,+$G(DA),0),U)'=""),($G(Y)'=$G(X)) D  Q 0
 . D EN^DDIOL("Unauthorized Abbreviation cannot be modified once created but allows to inactivate STATUS.")
 I ($G(Y)'=$G(X)),$D(^TIU(8927.9,"B",$G(X))) D  G SETABBV
 . D EN^DDIOL("The abbreviation "_X_" already exists.")
SETABBV ; 
 S X=""""_X_""""
 Q 1
 ;
ABBV(X) ;NATIONAL ABBREVIATIONS check 
 G CKABBV
 ;
 ;
CLASS(X) ;NATIONAL ABBREVIATIONS CLASS check
 I ($P($G(^TIU(8927.9,+$G(DA),0)),U,2))=$G(X) Q 1
 I (DUZ(0)="@"),(X="N") Q 1
 I (DUZ(0)'="@"),(X="N") D  Q 0
 . D EN^DDIOL("You are not allowed to create NATIONAL Class.")
 G CKCLASS
 ;
 ;
LCLASS(X) ;LOCAL ABBREVIATIONS CLASS check
 I ($P($G(^TIU(8927.9,+$G(DA),0)),U,2)="N"),(X'="N") D  Q 0
 . D EN^DDIOL("National Abbreviation Class cannot be altered.")
CKCLASS ;
 I ($P($G(^TIU(8927.9,+$G(DA),0)),U,2))=$G(X) Q 1
 I (X'="L") D  Q 0
 . D EN^DDIOL("Local site can only create LOCAL Class.")
 Q 1
 ;
