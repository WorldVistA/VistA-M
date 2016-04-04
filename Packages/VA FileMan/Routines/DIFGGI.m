DIFGGI ;SFISC/XAK,EDE(OHPRD)-FILEGRAM INITIALIZATION ;1/19/93  9:45 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; DIFGER values: 1 = required variable not passed
 ;                2 = variable form invalid
 ;                3 = variable content invalid
 ;
INIT ; INITIALIZATION
 K ^UTILITY("DIFG",$J),^UTILITY("DIFGLINK",$J)
 D SET1,REQ Q:DIFG("QFLG")
 D OPT Q:DIFG("QFLG")
 D FIRST
 Q
 ;
SET1 ; MISC SETS # 1
 S DIFGI=0,DILL=1 K DIFGER S U="^",DIFG("QFLG")=0
 Q
 ;
REQ ;
 ;
FE I '$D(DIFG("FE")) S DIFG("QFLG")=1 Q
 I DIFG("FE")'=+DIFG("FE") S DIFG("QFLG")=2 Q
FUNC I '$D(DIFG("FUNC")) S DIFG("QFLG")="1" Q
 I DIFG("FUNC")="" S DIFG("QFLG")=2 Q
 I "AMLD"'[DIFG("FUNC") S DIFG("QFLG")=3 Q
FGT I '$D(DIFGT) S DIFG("QFLG")=1 Q
 I DIFGT'=+DIFGT S DIFG("QFLG")=2 Q
 I '$D(^DIPT(DIFGT,0)) S DIFG("QFLG")=3 Q
 Q
 ;
OPT ;
 ;
FGR I '$D(DIFG("FGR")) S DIFG("FGR")="^UTILITY(""DIFG"",$J,"
 S X=DIFG("FGR")
 I "(,"'[$E(X,$L(X)) S DIFG("QFLG")=2 Q
 I $P(X,"(")["DIFG" S DIFG("QFLG")=3 Q
LC I $D(DILC),DILC'=+DILC S DIFG("QFLG")=2 Q
 S:'$D(DILC) DILC=0
PARM S:'$D(DIFG("PARM")) DIFG("PARM")="N"
TAB I $D(DITAB),DITAB'=+DITAB S DIFG("QFLG")=2 Q
 S:'$D(DITAB) DITAB=0
FUNCSFT I $D(DIFG("FUNC SFT")) F X=0:0 S X=$O(DIFG("FUNC SFT",X)) Q:X'=+X  D FUNCSFT2 Q:DIFG("QFLG")
 Q
 ;
FUNCSFT2 S Y=DIFG("FUNC SFT",X)
 I Y="" S DIFG("QFLG")=2 Q
 I "AMLD"'[Y S DIFG("QFLG")=3 Q
 Q
 ;
FIRST ; GET PRIMARY FILE VARIABLES
 S DIFGI=$O(^DIPT(DIFGT,1,DIFGI)) Q:DIFGI'=+DIFGI  S X=^(DIFGI,0)
 D FVARS
 I '$D(@(DIFG(DILL,"FGBL")_DIFG("FE")_",0)")) S DIFG("QFLG")=3 Q
 Q
 ;
FVARS ; SETUP FILE VARIABLES
 S DILL=$P(X,U,2),DITAB=2*(DILL-1),DIFG(DILL,"FILE")=+X
 S DIFG(DILL,"FNAME")=$O(^DD(DIFG(DILL,"FILE"),0,"NM",0))
 I DILL=1 S DIFG(DILL,"FE")=DIFG("FE"),DIFG(DILL,"FUNC")=DIFG("FUNC")
 E  S DIFG(DILL,"FUNC")=DIFG(DILL-1,"FUNC")
 I $D(DIFG("FUNC SFT",DIFG(DILL,"FILE"))) S DIFG(DILL,"FUNC")=DIFG("FUNC SFT",DIFG(DILL,"FILE"))
 I $P(X,U,4)=1 S DIFG(DILL,"FE")=DIFG(DILL-1,"FE") ; dinum back pointer
 S DIFG(DILL,"XREF")=$S($P(X,U,4)=4:$P(X,U,7),1:$P(X,U,4)),%=$P(X,U,5) ;Back pointer if $P=4 X-ref in $P7
 I $E(%,$L(%))=":" S DIFG(DILL,"NAV")=1 I $P(X,U,4)=2 S DIFG(DILL,"NAV")=2 D DIRECT K %,Y
 I $P(X,U,4)=3 S %=$P(X,U,3),%=$O(^DD(%,"SB",+X,0)),%=^DD(+$P(X,U,3),%,0),%=$P($P(^(0),U,4),";") S:+%'=% %=""""_%_"""" S DIFG(DILL,"FGBL")=DIFG(DILL-1,"FGBL")_DIFG(DILL-1,"FE")_","_%_"," K DIFG(DILL,"NAV") Q  ; multiple
 S DIFG(DILL,"FGBL")=^DIC(DIFG(DILL,"FILE"),0,"GL")
 D:$P(X,U,4)=5 LOOKUP
 Q
 ;
DIRECT ;DIRECT POINTER
 S DIFG(DILL,"FE")=0,%=$P(%,":")
 S:'$D(^DD(DIFG(DILL-1,"FILE"),"B",%)) %=$O(^(%))
 S %=$O(^DD(DIFG(DILL-1,"FILE"),"B",%,0))
 Q:%'=+%
 S Y=$P(^DD(DIFG(DILL-1,"FILE"),%,0),U,4),%("N")=$P(Y,";"),%("P")=$P(Y,";",2) S:+%("N")'=%("N") %("N")=""""_%("N")_""""
 I $D(@(DIFG(DILL-1,"FGBL")_DIFG(DILL-1,"FE")_","_%("N")_")")) S Y=@("^("_%("N")_")"),DIFG(DILL,"FE")=$P(Y,U,%("P"))
 Q
 ;
LOOKUP ;COMPUTED FIELD LOOKUP FOR FILE SHIFT
 S DIFG(DILL,"FE")=""
 S %=$O(^DD(DIFG(DILL,"FILE"),"B",$P($P(X,U,5),":"),0))
 Q:'%
 X $P(^DD(DIFG(DILL,"FILE"),%,0),U,5,99)
 I $D(X) S DIFG(DILL,"FE")=$S(X?1"`"1N.N:$E(X,2,99),X?1N.N:X,1:"")
 Q
