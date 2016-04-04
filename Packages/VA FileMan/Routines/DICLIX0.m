DICLIX0 ;SEA/TOAD,SF/TKW-FileMan: Continuation of DICLIX ;7/31/98  09:03
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
FINDMORE(DISUB,DIVAL,DIPART,DINDEX,DIMORE) ; Look across the numeric/string collation boundary
 ; Searching forwards
 N S,DIOUT S DIOUT=0
 I DINDEX(DISUB,"WAY")=1 D  Q
 . I +$P(DIVAL,"E")=DIVAL,DIPART'=0 F  D  Q:DIOUT!(+$P(DIVAL,"E")'=DIVAL)
 . . I DIPART<DIVAL,((DIPART[".")!(DIPART<0)) S DIVAL=" " Q
 . . D NXT(.DIVAL,DIPART,1,DINDEX(DISUB,"ROOT"),.DIOUT) Q
 . Q:DIOUT
 . S DIMORE=0
 . S S=$O(@DINDEX(DISUB,"ROOT")@(DIPART_" "),-1)
 . S S=$O(@DINDEX(DISUB,"ROOT")@(S))
 . Q:S'=""&(DIVAL]]S)  S DIVAL=S Q
 ; Searching backwards
 I +$P(DIVAL,"E")'=DIVAL S DIVAL=$O(@DINDEX(DISUB,"ROOT")@(" "),-1) Q:DIVAL=""
 I DIPART=0 S DIVAL=$S($D(@DINDEX(DISUB,"ROOT")@(0)):0,1:"") Q
 I DIPART>DIVAL,((DIPART[".")!(DIPART>0)) S DIVAL="" Q
 I DIPART<0,DIVAL>DIPART D
 . I $D(@DINDEX(DISUB,"ROOT")@(DIPART)) S DIVAL=DIPART Q
 . S DIVAL=$O(@DINDEX(DISUB,"ROOT")@(DIPART),-1) Q
 Q:$E(DIVAL,1,$L(DIPART))=DIPART!(DIVAL="")
 F  D  Q:DIOUT!(DIVAL="")
 . I DIPART>DIVAL,((DIPART[".")!(DIPART>0)) S DIVAL="" Q
 . D NXT(.DIVAL,DIPART,-1,DINDEX(DISUB,"ROOT"),.DIOUT) Q
 Q
NXT(DIVAL,DIPART,DIWAY,DIROOT,DIOUT) ; Skip values we don't need to look at within numeric entries
 N DIPART2,DIVAL2,I,P,V
 S DIPART2=$P(DIPART,"."),DIVAL2=$P(DIVAL,".")
 S P=$S(DIPART<0:-DIPART2,1:DIPART2)
 S V=$S(DIVAL<0:$E(DIVAL2,2,($L(P)+1)),1:$E(DIVAL2,1,$L(P)))
 S I=$L(DIVAL2)
 I DIWAY=1&(DIPART>0)!(DIWAY=-1&(DIPART<0)) D
 . S:V>P I=I+1 Q
 E  D
 . S DIPART2=DIPART2+$S(DIPART>0:1,1:-1)
 . I P>V,$L(DIPART2)=$L($P(DIPART,".")) S I=I-1
 S V="",I=I-$L(DIPART2)+1 S:I>1 $P(V,"0",I)=""
 S DIVAL=DIPART2_V
 I $E(DIVAL,1,$L(DIPART))=DIPART,$D(@DINDEX(DISUB,"ROOT")@(DIVAL)) S DIOUT=1 Q
 S DIVAL=$O(@DIROOT@(DIVAL),DIWAY)
 S:$E(DIVAL,1,$L(DIPART))=DIPART DIOUT=1
 Q
 ;
 ;
