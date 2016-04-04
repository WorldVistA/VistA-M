DIKD2 ;SFISC/MKO-DELETE A NEW-STYLE INDEX ;4JAN2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**12,95,1042**
 ;
DELIXN(DIFIL,DIXR,DIFLG,DIKDOUT,DIKDMSG) ;Delete new-style index
DELIXNX ;Come here from DELIXN^DDMOD
 N %,DIC,DIF,DIFLIST,DIINDEX,DIQUIT,DITOP,X,Y
 ;
 ;Init
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 S DIFLG=$G(DIFLG)
 S DIF=$E("D",DIFLG'["d")
 I DIFLG'["c" D CHK G:$G(DIQUIT) END
 S DITOP=DIFIL F  Q:'$D(^DD(DITOP,0,"UP"))  S DITOP=^("UP")
 D GETFLIST^DIKCUTL(DIXR,.DIFLIST)
 D LOADXREF^DIKC1("","","K",DIXR,"","DIINDEX")
 ;
 ;Delete data in index
 D:DIFLG["K" KILL(DITOP,.DIINDEX,DIFLG)
 ;
 ;Delete index, recompile
 D DELDEF(DIXR)
 D DIEZ(.DIFLIST,DIFLG,$G(DIKDOUT))
 D DIKZ^DIKD(DITOP,DIFLG,$G(DIKDOUT))
 ;
END ;Move error message if necessary and quit
 D:$G(DIKDMSG)]"" CALLOUT^DIEFU(DIKDMSG)
 Q
 ;
DELDEF(DIXR) ;Delete index definition
 N DIK,DA
 W:$G(DIFLG)["W" !,"Deleting index definition ..."
 S DIK="^DD(""IX"",",DA=DIXR D ^DIK
 Q
 ;
DIEZ(DIFLIST,DIFLG,DIKDOUT) ;Recompile input templates containing field
 N DIFIL,DIFLD,DIKTEML
 S DIFIL=0 F  S DIFIL=$O(DIFLIST(DIFIL)) Q:'DIFIL  D
 . S DIFLD=0 F  S DIFLD=$O(DIFLIST(DIFIL,DIFLD)) Q:'DIFLD  D
 .. D DIEZ^DIKD(DIFIL,DIFLD,DIFLG,$G(DIKDOUT),.DIKTEML)
 Q
 ;
CHK ;Check input parameters
 I '$G(DIFIL) D:DIF["D" ERR^DIKCU2(202,"","","","FILE") D QUIT
 I $G(DIXR)]"" D
 .N I F I=0:0 S I=$O(^DD("IX","IX",DIXR,I)) Q:'I  I +$G(^DD("IX",I,0))=$G(DIFIL) Q
 .I 'I K DIXR
 I $G(DIXR)="" D:DIF["D" ERR^DIKCU2(202,"","","","CROSS-REFERENCE") D QUIT
 D:'$$VFLAG^DIKCU1(DIFLG,"KWcd",DIF) QUIT
 Q:$G(DIQUIT)
 S DIXR=$O(^DD("IX","BB",DIFIL,DIXR,0))
 D:'DIXR QUIT
 Q
 ;
QUIT ;Set flag to quit
 S DIQUIT=1
 Q
 ;
KILL(DITOP,DIINDEX,DIFLG) ;Delete index data
 N DIFIL,DITYP,DICTRL,DIXR
 ;
 Q:'$D(DIINDEX)
 S DIFIL=$O(DIINDEX(0)) Q:'DIFIL
 S DIXR=$O(DIINDEX(DIFIL,0)) Q:'DIXR
 S DITYP=$P(DIINDEX(DIFIL,DIXR),U,4)
 ;
 I $G(DIFLG)["W" D
 . I DITYP="R" W !,"Removing index ..."
 . E  W !,"Executing kill logic ..."
 ;
 ;Call INDEX^DIKC to execute the kill logic
 S DICTRL="K"_$S(DITOP'=DIFIL:"W"_DIFIL,1:"")
 S DICTRL("LOGIC")="DIINDEX"
 D INDEX^DIKC(DITOP,"","",DIXR,.DICTRL)
 Q
