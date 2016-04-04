DIEZ3 ;SFISC/MKO-COMPILE INPUT TEMPLATE, BUILD CODE TO CHECK KEYS ;2:54 PM  15 Jul 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11**
 ;
 ;In:
 ;  DIEZKEY(uniqxref#) = count
 ;  DQ = item # in DR string
 ;
GETKEY(DIEZFIL,DIEZFLD,DIEZKEY,DQ) ;Build routine to check keys
 Q:'$D(DIEZKEY)
 N DIEZUI
 ;
 ;Build code to check field-level keys
 D L("K"_DQ_"() N DIMAXL,DIUIR,DIXR")
 S DIEZUI=0
 F  S DIEZUI=$O(DIEZKEY(DIEZUI)) Q:'DIEZUI  D
 . D BLD(DIEZFIL,DIEZFLD,DIEZUI,DQ,DIEZKEY(DIEZUI))
 Q
 ;
BLD(DIEZFIL,DIEZFLD,DIEZUI,DQ,DIEZCNT) ;Get code for one index DIEZXR
 N DIEZMAXL,DIEZSLIS,DIEZUIR
 D XRINFO^DIKCU2(DIEZUI,.DIEZUIR,"",.DIEZMAXL)
 ;
 D L(" S DIXR="_DIEZUI)
 D L(" S @DIEZTMP@(""V"","_DIEZFIL_",DIIENS,"_DIEZFLD_",""N"")=X")
 D L(" N X D C"_DQ_"X"_DIEZCNT_"(""N"")")
 D L(" K @DIEZTMP@(""V"","_DIEZFIL_",DIIENS,"_DIEZFLD_",""N"")")
 D L(" S DIUIR=$NA("_DIEZUIR_") Q:'$D(@DIUIR) 1")
 ;
 I $D(DIEZMAXL) D
 . N ORD,X
 . S X="S ",ORD=0
 . F  S ORD=$O(DIEZMAXL(ORD)) Q:'ORD  D
 .. S X=X_"DIMAXL("_ORD_")="_DIEZMAXL(ORD)_","
 . I X?.E1"," D L(" "_$E(X,1,$L(X)-1))
 ;
 D L(" Q $$UNIQUE^DIE17(.X,.DA,DIUIR,""C"_DQ_"X"_DIEZCNT_U_DNM_DRN_""""_$S($D(DIEZMAXL):",.DIMAXL",1:"")_")")
 Q
 ;
L(X) ;Add CODE to ^UTILITY
 S L=L+1,^UTILITY($J,0,L)=X,T=T+$L(X)+2
 Q
