DIAXGI ;SFISC/DCM-EXTRACT INITIALIZATION ;11/10/92  2:56 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
INIT S DIAXI=0,DILL=1
 D FIRST
 Q
 ;
FIRST S DIAXI=$O(^DIPT(DIARP,1,DIAXI)) Q:DIAXI'=+DIAXI
 S X=^(DIAXI,0)
 D FVARS
 Q
 ;
FVARS S DILL=$P(X,U,2),DIAX(DILL,"FILE")=+X,DIAXET(DILL,"FILE")=$P(X,U,9),(DIAXET(DILL,"PRT"),DIAXET(DIAXET(DILL,"FILE")))=$P(X,U,10)
 I DILL=1 S DIAX(DILL,"FE")=DIAXFE
 I $P(X,U,4)=1 S DIAX(DILL,"FE")=DIAX(DILL-1,"FE")
 S DIAX(DILL,"XREF")=$S($P(X,U,4)=4:$P(X,U,7),1:$P(X,U,4)),%=$P(X,U,5)
 I $E(%,$L(%))=":" S DIAX(DILL,"NAV")=1 I $P(X,U,4)=2 S DIAX(DILL,"NAV")=2 D DIRECT K %,Y
 I $P(X,U,4)=3 S %=$P(X,U,3),%=$O(^DD(%,"SB",+X,0)),%=^DD(+$P(X,U,3),%,0),%=$P($P(^(0),U,4),";") S:+%'=% %=""""_%_"""" S DIAX(DILL,"FGBL")=DIAX(DILL-1,"FGBL")_DIAX(DILL-1,"FE")_","_%_"," K DIAX(DILL,"NAV") D FGBL Q
 S DIAX(DILL,"FGBL")=^DIC(DIAX(DILL,"FILE"),0,"GL") D FGBL
 Q
 ;
DIRECT S DIAX(DILL,"FE")=0,%=$P(%,":")
 S:'$D(^DD(DIAX(DILL-1,"FILE"),"B",%)) %=$O(^(%))
 S %=$O(^DD(DIAX(DILL-1,"FILE"),"B",%,0))
 Q:%'=+%
 S Y=$P(^DD(DIAX(DILL-1,"FILE"),%,0),U,4),%("N")=$P(Y,";"),%("P")=$P(Y,";",2) S:+%("N")'=%("N") %("N")=""""_%("N")_""""
 I $D(@(DIAX(DILL-1,"FGBL")_DIAX(DILL-1,"FE")_","_%("N")_")")) S Y=@("^("_%("N")_")"),DIAX(DILL,"FE")=$P(Y,U,%("P"))
 Q
 ;
FGBL S DIAXFI=+$P(X,U,10) I 'DIAXFI Q
 I DILL=1 S ^TMP("DIAX",$J,DIAXET(DILL,"FILE"),"GL")=^DIC(DIAXET(DILL,"FILE"),0,"GL") Q
 S ^TMP("DIAX",$J,DIAXET(DILL,"FILE"),"GL")=^TMP("DIAX",$J,DIAXFI,"GL")_$S(DIAXET(DILL,"FILE")'=DIAXFI:^TMP("DIAX",$J,DIAXFI,"DA")_$S($P(X,U,11)]"":","""_$P($P(X,U,11),";")_""",",1:","),1:"")
 S:$D(^TMP("DIAX",$J,DIAXET(DILL,"FILE"),"WP")) ^("DTO(1)")=^("GL") S ^("DA(1)")=DIAXET(DIAXFI,"DA")
 I $G(DIAXET(DIAXFI,"DA(1)"))]"" F DIAXII=1:1 Q:'$D(DIAXET(DIAXFI,"DA("_DIAXII_")"))  S ^TMP("DIAX",$J,DIAXET(DILL,"FILE"),"DA("_(DIAXII+1)_")")=DIAXET(DIAXFI,"DA("_DIAXII_")")
 K DIAXFI,DIAXII
 Q
