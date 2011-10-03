YTQQI001 ;ASF/ALB- MH3 PATCH 85 INIT ; 7/27/07 2:16pm
 ;;5.01;MENTAL HEALTH;**85**;;Build 48
 Q:'DIFQ(601.751)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(601.751,0,"GL")
 ;;=^YTT(601.751,
 ;;^DIC("B","MH CHOICETYPES",601.751)
 ;;=
 ;;^DIC(601.751,"%",0)
 ;;=^1.005^^0
 ;;^DIC(601.751,"%D",0)
 ;;=^1.001^7^7^3050309^^^
 ;;^DIC(601.751,"%D",1,0)
 ;;=This file contains a collection of choices from MH CHOICES file (#601.75) 
 ;;^DIC(601.751,"%D",2,0)
 ;;=and their display sequence.  This allows sets of choices to be specified by 
 ;;^DIC(601.751,"%D",3,0)
 ;;=the MH QUESTIONS file (#601.72). 
 ;;^DIC(601.751,"%D",4,0)
 ;;=
 ;;^DIC(601.751,"%D",5,0)
 ;;=An example of an entry would be: 1. True 2. False 3. Undecided        
 ;;^DIC(601.751,"%D",6,0)
 ;;=Each multiple choice question must specify a ChoiceType. In this way a
 ;;^DIC(601.751,"%D",7,0)
 ;;=ChoiceType can be used by multiple instruments and multiple questions.
 ;;^DD(601.751,0)
 ;;=FIELD^^3^4
 ;;^DD(601.751,0,"DDA")
 ;;=N
 ;;^DD(601.751,0,"DT")
 ;;=3030912
 ;;^DD(601.751,0,"IX","ACT",601.751,2)
 ;;=
 ;;^DD(601.751,0,"IX","B",601.751,.01)
 ;;=
 ;;^DD(601.751,0,"NM","MH CHOICETYPES")
 ;;=
 ;;^DD(601.751,0,"VRPK")
 ;;=YS
 ;;^DD(601.751,.01,0)
 ;;=CHOICETYPE ID^RNJ7,0^^0;1^K:+X'=X!(X>9999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(601.751,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(601.751,.01,1,1,0)
 ;;=601.751^B
 ;;^DD(601.751,.01,1,1,1)
 ;;=S ^YTT(601.751,"B",$E(X,1,30),DA)=""
 ;;^DD(601.751,.01,1,1,2)
 ;;=K ^YTT(601.751,"B",$E(X,1,30),DA)
 ;;^DD(601.751,.01,3)
 ;;=Type a Number between 1 and 9999999, 0 Decimal Digits
 ;;^DD(601.751,.01,21,0)
 ;;=^^1^1^3040507^
 ;;^DD(601.751,.01,21,1,0)
 ;;=This is the NON-unique identifier for the ChoiceType.
 ;;^DD(601.751,.01,"DT")
 ;;=3031114
 ;;^DD(601.751,1,0)
 ;;=SEQUENCE^RNJ3,0^^0;2^K:+X'=X!(X>999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(601.751,1,3)
 ;;=Type a Number between 1 and 999, 0 Decimal Digits
 ;;^DD(601.751,1,21,0)
 ;;=^.001^1^1^3040507^^^
 ;;^DD(601.751,1,21,1,0)
 ;;=Order in which the Choice alternative is displayed.
 ;;^DD(601.751,1,"DT")
 ;;=3031114
 ;;^DD(601.751,2,0)
 ;;=CHOICE ID^RP601.75'^YTT(601.75,^0;3^Q
 ;;^DD(601.751,2,1,0)
 ;;=^.1
 ;;^DD(601.751,2,1,1,0)
 ;;=601.751^ACT
 ;;^DD(601.751,2,1,1,1)
 ;;=S ^YTT(601.751,"ACT",$E(X,1,30),DA)=""
 ;;^DD(601.751,2,1,1,2)
 ;;=K ^YTT(601.751,"ACT",$E(X,1,30),DA)
 ;;^DD(601.751,2,1,1,"DT")
 ;;=3031114
 ;;^DD(601.751,2,3)
 ;;=
 ;;^DD(601.751,2,21,0)
 ;;=^^2^2^3050223^
 ;;^DD(601.751,2,21,1,0)
 ;;=Pointer to the MH CHOICES file (#601.75) to associate a choice with this
 ;;^DD(601.751,2,21,2,0)
 ;;=choice type.
 ;;^DD(601.751,2,"DT")
 ;;=3050223
 ;;^DD(601.751,3,0)
 ;;=CHOICE TEXT^CJ50^^ ; ^X ^DD(601.751,3,9.2) S Y(601.751,3,101)=$S($D(^YTT(601.75,D0,1)):^(1),1:"") S X=$P(Y(601.751,3,101),U,1) S D0=Y(601.751,3,80)
 ;;^DD(601.751,3,9)
 ;;=^
 ;;^DD(601.751,3,9.01)
 ;;=601.75^3;601.751^2
 ;;^DD(601.751,3,9.1)
 ;;=CHOICE ID:MH CHOICES:CHOICE TEXT
 ;;^DD(601.751,3,9.2)
 ;;=S Y(601.751,3,80)=$G(D0),Y(601.751,3,1)=$S($D(^YTT(601.751,D0,0)):^(0),1:"") S X=$P(Y(601.751,3,1),U,3) K DIC S DIC="^YTT(601.75,",DIC(0)="MF" D ^DIC S (D,D0)=+Y
 ;;^DD(601.751,3,21,0)
 ;;=^.001^1^1^3040507^^
 ;;^DD(601.751,3,21,1,0)
 ;;=DISPLAYS choices text via this computed field
 ;;^DD(601.751,3,"DT")
 ;;=3030911
