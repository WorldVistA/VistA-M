DDSMSG ;SFISC/MKO-PRINT MESSAGES ;3:14 PM  9 Feb 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**75**
 ;
ERR ;Print "DIERR" messages in help box
 N DDSE,DDSL,DDSLMT,DDSN
 K DDH,DDQ
 S DDSLMT=$G(DDC,15),DDSE=0
 ;
 W $C(7)
 S DDSN=0
 F  S DDSN=$O(^TMP("DIERR",$J,DDSN)) Q:'DDSN!DDSE  D
 . S DDSL=0
 . F  S DDSL=$O(^TMP("DIERR",$J,DDSN,"TEXT",DDSL)) Q:'DDSL!DDSE  D
 .. D LD($G(^TMP("DIERR",$J,DDSN,"TEXT",DDSL)),"!")
 .. I DDH'<DDSLMT D SC^DDSU S:$D(DTOUT)!($D(DUOUT)) DDSE=1
 ;
 I $G(DDH) S:$G(DDH(1,"T"))?1.C DDH(1,"T")="" D SC^DDSU
 S DDSKM=1
 K DIERR,^TMP("DIERR",$J)
 Q
 ;
HLP(DDSG) ;Print messages from @DDSG in help area
 N DDSE,DDSL,DDSLMT,DDSNXTF,DDST
 S:$G(DDSG)="" DDSG=$NA(@DDSREFT@("HLP"))
 ;
 K DDH
 I $G(DDQ)-1=DDSHBX,'$X K DDQ
 D:$G(DDQ)>DDSHBX SETDDH
 S DDSLMT=$G(DDC,15),(DDSE,DDSL)=0
 ;
 F  S DDSL=$O(@DDSG@(DDSL)) Q:'DDSL!DDSE  D
 . S DDST=$G(@DDSG@(DDSL))
 . I DDST="$$EOP" S DDH=$G(DDH)+1,DDH(DDH,"E")=""
 . E  D LD(DDST,$G(@DDSG@(DDSL,"F"),"!"))
 . S DDSNXTF=$G(@DDSG@(DDSL+1,"F"),"!")
 . I DDH'<DDSLMT,DDSNXTF["!"!(DDSNXTF'["?") D SC^DDSU S:$D(DTOUT)!($D(DUOUT)) DDSE=1
 ;
 I $G(DDH) S:$G(DDH(1,"T"))?1.C DDH(1,"T")="" D SC^DDSU
 K:DDSG=$NA(@DDSREFT@("HLP")) @DDSG
 S:'$D(DDSID) DDSKM=1
 Q
 ;
WP(DDSR) ;Print the contents of a wp field @DDSR in help area
 N DDSE,DDSL,DDSLMT,DDSNXTF
 ;
 K DDH
 I $G(DDQ)-1=DDSHBX,'$X K DDQ
 D:$G(DDQ)>DDSHBX SETDDH
 S DDSLMT=$G(DDC,15),(DDSE,DDSL)=0
 ;
 F  S DDSL=$O(@DDSR@(DDSL)) Q:'DDSL!DDSE  D
 . D LD($G(@DDSR@(DDSL,0)),$G(@DDSR@(DDSL,"F"),"!"))
 . S DDSNXTF=$G(@DDSR@(DDSL+1,"F"),"!")
 . I DDH'<DDSLMT,DDSNXTF["!"!(DDSNXTF'["?") D SC^DDSU S:$D(DTOUT)!($D(DUOUT)) DDSE=1
 ;
 I $G(DDH) S:$G(DDH(1,"T"))?1.C DDH(1,"T")="" D SC^DDSU
 S:'$D(DDSID) DDSKM=1
 Q
 ;
MSG(DDSMSG,DDSFLG,DDSFMT) ;Print local var or array DDSMSG in help area
 ;DDSFLG [ 1 : Write bell
 ;DDSFMT : Format if one line is sent
 N DDSL
 K DDH
 I $G(DDQ)-1=DDSHBX,'$X K DDQ
 D:$G(DDQ)>DDSHBX SETDDH
 ;
 I $D(DDSMSG)=1 D
 . D LD(DDSMSG,$S($G(DDSFMT)]"":DDSFMT,1:"!"))
 ;
 E  S DDSL=0 F  S DDSL=$O(DDSMSG(DDSL)) Q:'DDSL  D
 . D LD($G(DDSMSG(DDSL)),$G(DDSMSG(DDSL,"F"),"!"))
 Q:'$G(DDH)
 ;
 I $G(DDH) D
 . S:$G(DDH(1,"T"))?1.C DDH(1,"T")=""
 . S:$G(DDSFLG)[1 DDH(1,"T")=$C(7)_$G(DDH(1,"T"))
 . D SC^DDSU
 S:'$D(DDSID) DDSKM=1
 Q
 ;
SETDDH ;Setup DDH and DDQ for identifiers and executable help
 ;that called EN^DDIOL
 S:$X>IOM $X=IOM
 S DDH=1
 S DDH(1,"T")=$TR($J("",$X)," ",$C(0))
 S DDQ=$S(DY>(IOSL-1):IOSL-1,1:DY)-1_U_$X
 Q
 ;
LD(S,F) ;Load string S with format F into DDH array
 N A,C,J,L
 S DDH=+$G(DDH)
 F J=1:1:$L(F,"!")-1 S DDH=DDH+1,DDH(DDH,"T")=""
 S:'DDH DDH=1
 S:F["?" @("C="_$P(F,"?",2))
 S L=$G(DDH(DDH,"T"))
 S S=L_$J("",$G(C)-$L(L))_S
 ;
 D WRAP(S,.A,IOM-1)
 S DDH=DDH-1
 F A=1:1:A S DDH=$G(DDH)+1,DDH(DDH,"T")=A(A)
 Q
 ;
WRAP(L,A,M) ;Wrap line at word boundaries
 ; L    = Line of text
 ; M    = Margin width
 ;Return:
 ; A    = Number of lines
 ; A(n) = Array of text
 ;
 S:'$G(M) M=$S($G(IOM):IOM-5,1:75)
 N I,N
 S N=0
 F I=$L(L," "):-1:1 D  Q:L=""
 . I I=1 S N=N+1,A(N)=$E(L,1,M),L=$E(L,M+1,999) Q
 . I $L($P(L," ",1,I))'>M D
 .. S N=N+1,A(N)=$P(L," ",1,I),L=$P(L," ",I+1,999)
 S A=N
 Q
