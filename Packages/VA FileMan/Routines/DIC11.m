DIC11 ;SFISC/TKW-PROMPT USER FOR LOOKUP VALUES ;05:33 PM  11 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,13,40,67,999**
 ;
PROMPT N DIOUT S (DIVAL(0),DIOUT)=0
 F DISUB=1:1:DINDEX("#") D PR1 Q:DIOUT
 S X=$G(DIVAL(1))
 I DINDEX("#")>1 M X=DIVAL D  K X(0) ; W:$O(DIVAL(1)) !
 . I X?1"^"1.E K X S X=$G(DIVAL(1)) Q
 Q
 ;
PR1 S DIY=DIPRMT(DISUB),DIVAL(DISUB)="" N X
 I $G(DIY(DISUB))]"" S DIY=DIY_$S($D(DIY(DISUB,"EXT")):DIY(DISUB,"EXT"),1:DIY(DISUB))_"// "
 W DIY R X:$S($G(DTIME):DTIME,1:300)
 I '$T S (DIOUT,DTOUT)=1 W $C(7) K DIVAL S DIVAL(0)=0 Q
 I X'?.ANP D:DIC(0)["Q"  S DISUB=DISUB-1 Q
 . W $C(7),"  ",$$EZBLD^DIALOG(204),! Q
 I X?1.N.1"."1.N,($L($P(X,"."))>25!($L($P(X,".",2))>24)) D:DIC(0)["Q"  S DISUB=DISUB-1 Q
 . W $C(7),"  ",$$EZBLD^DIALOG(208),! Q
 I X="^"!($E(X)="^"&(DISUB>1)) S (DIOUT,DUOUT)=1 K DIVAL S DIVAL(0)=0,DIVAL(1)="^" Q
 I $L(X)>250 D:DIC(0)["Q"  S DISUB=DISUB-1 Q
 . W $C(7)," ",$$EZBLD^DIALOG(209),! Q
 I X?1."?" K DIVAL S DIVAL(1)=$E(X,1,2),DIVAL(0)=0,DIOUT=1 Q
 I (X?1"`".NP)!(X=" ") K DIVAL S DIVAL(1)=X,(DIVAL(0),DIOUT)=1 Q
 W:DINDEX("#")>1 !
 S DIVAL(DISUB)=X
 I X="",$G(DIY(DISUB))]"" S DIVAL(DISUB)=DIY(DISUB) S:DIC(0)'["O" DIC(0)=DIC(0)_"O"
 Q:DIVAL(DISUB)=""
 S DIVAL(0)=DIVAL(0)+1
 S:$E(X)="^" (DIOUT,DUOUT)=1
 Q
 ;
GETPRMT(DIC,DO,DINDEX,DIPRMT) ; Build list of prompts for each lookup value
 N DICA I $D(DIC("A")) S DICA(1)=$G(DIC("A")) M DICA=DIC("A")
 N DISUB,I,L,P S L=0
 F DISUB=1:1:DINDEX("#") D
 . I $G(DICA(DISUB))]"" D  I DIPRMT(DISUB)]""
 . . S DIPRMT(DISUB)=""
ANOTHER . . I DISUB=1,DINDEX("#")>1,DICA(DISUB)=$$EZBLD^DIALOG(8199) Q  ;**CCO/NI  'ANOTHER ONE:'
 . . S DIPRMT(DISUB)=DICA(DISUB) Q
 . E  D
 . . S P=$S(DISUB=1:$P(DO,U),1:"")
 . . I DISUB=1,$G(DICA(DISUB))=$$EZBLD^DIALOG(8199) S P=$$EZBLD^DIALOG(8050)_P
 . . I DINDEX("#")=1,D'="B"&(DIC(0)["M")!(D="B"&(DO(2)'>1.9)) S DIPRMT(DISUB)=$$EZBLD^DIALOG(8042,P) Q
 . . N X S X=DINDEX(DISUB,"PROMPT") I X]"" D
 . . . I DISUB=1 Q:DINDEX("#")=1&(P[X!(X[P))  S P=P_" "
 . . . S P=P_X Q
 . . I DISUB=1 S DIPRMT(DISUB)=$$EZBLD^DIALOG(8042,P)
 . . E  S DIPRMT(DISUB)=P_": "
 . . Q
 . S I=$L(DIPRMT(DISUB)) S:I>L L=I Q
 Q:DINDEX("#")=1
 S I="",$P(I," ",L)=""
 F DISUB=1:1:DINDEX("#") S DIPRMT(DISUB)=$E(I,1,(L-$L(DIPRMT(DISUB))))_DIPRMT(DISUB)
 Q
 ;
TRYADD(DIC,DIFILEI) ; Return 1 if user should be allowed to attempt to add record
 ; when lookup value `ien and .01 is a pointer.
 Q:DIC(0)'["L" 0
 N % S %=$P($G(^DD(DIFILEI,.01,0)),U,2)
 I %["P"!(%["V") Q 1
 Q 0
 ;
 ; Error messages
 ; 204  The input value contains control characters.
 ; 208  Input value is an illegal number.
 ; 209  Input value is too long.
 ;8042  Select |1|:
 ;8050  Another
 ;
