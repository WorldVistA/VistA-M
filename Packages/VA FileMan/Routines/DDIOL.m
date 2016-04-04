DDIOL ;SFISC/MKO-THE LOADER ;14JUN2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1038,1042**
 ;
 ;
EN(A,G,FMT) ;Write the text contained in local array A or global array G
 ;If one string passed, use format FMT
 N %,Y,DINAKED
 S DINAKED=$NA(^(0))
 ;
 S:'$D(A) A=""
 I $G(A)="",$D(A)<9,$G(FMT)="",$G(G)'?1"^"1A.7AN,$G(G)'?1"^"1A.7AN1"(".E1")" Q
 ;
 G:$D(DDS) SM
 G:$D(DIQUIET) LD
 ;
 N F,I,S
 I $D(A)=1,$G(G)="" D
 . S F=$S($G(FMT)]"":FMT,1:"!")
 . W @F,A
 ;
 E  I $D(A)>9 S I=0 F  S I=$O(A(I)) Q:I'=+$P(I,"E")  D
 . S F=$G(A(I,"F"),"!") S:F="" F="?0"
 . W @F,$G(A(I))
 ;
 E  S I=0 F  S I=$O(@G@(I)) Q:I'=+$P(I,"E")  D
 . S S=$G(@G@(I,0),$G(@G@(I)))
 . S F=$G(@G@(I,"F"),"!") S:F="" F="?0"
 . W @F,S
 ;
 I DINAKED]"" S DINAKED=$S(DINAKED["""""":$O(@DINAKED),1:$D(@DINAKED))
 Q
 ;
LD ;Load text into ^TMP
 N I,N,T
 S T=$S($G(DDIOLFLG)["H":"DIHELP",1:"DIMSG")
 S N=$O(^TMP(T,$J," "),-1)
 ;
 I $D(A)=1,$G(G)="" D
 . D LD1(A,$S($G(FMT)]"":FMT,1:"!"))
 ;
 E  I $D(A)>9 S I=0 F  S I=$O(A(I)) Q:I'=+$P(I,"E")  D
 . D LD1($G(A(I)),$G(A(I,"F"),"!"))
 ;
 E  S I=0 F  S I=$O(@G@(I)) Q:I'=+$P(I,"E")  D
 . D LD1($G(@G@(I),$G(@G@(I,0))),$G(@G@(I,"F"),"!"))
 ;
 K:'N @T S:N @T=N
 I DINAKED]"" S DINAKED=$S(DINAKED["""""":$O(@DINAKED),1:$D(@DINAKED))
 Q
 ;
LD1(S,F) ;Load string S, with format F
 ;In: N and T
 N C,J,L
 S:S[$C(7) S=$TR(S,$C(7),"")
 F J=1:1:$L(F,"!")-1 S N=N+1,^TMP(T,$J,N)=""
 S:'N N=1
 S:F["?" @("C="_+$P(F,"?",2))
 S L=$G(^TMP(T,$J,N))
 S ^TMP(T,$J,N)=L_$J("",$G(C)-$L(L))_S
 Q
 ;
SM ;Print text in ScreenMan's Command Area
 I $D(DDSID),$D(DTOUT)!$D(DUOUT) G SMQ
 N DDIOL
 S DDIOL=1
 ;
 I $D(A)=1&($G(G)="")!($D(A)>9) D
 . D MSG^DDSMSG(.A,"",$G(FMT))
 E  I $D(@G@(+$O(@G@(0)),0))#2 D
 . D WP^DDSMSG(G)
 E  D HLP^DDSMSG(G)
 ;
SMQ I DINAKED]"" S DINAKED=$S(DINAKED["""""":$O(@DINAKED),1:$D(@DINAKED))
 Q
