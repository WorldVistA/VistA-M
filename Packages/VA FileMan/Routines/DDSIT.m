DDSIT ;SFISC/MKO-INPUT TRANSFORMS ;09:07 AM  24 Oct 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PFIELD ;Input transform for the PARENT FIELD field of the PAGE multiple
 ;of the Form file.
 N DDSMF
 S DDSMF=$$GETFLD^DDSLIB($P(X,","),$P(X,",",2),$P(X,",",3),DA(1))
 G QUIT
 ;
PLINK ;Input transform for POINTER LINK field of the BLOCK multiple of
 ;the PAGE MULTIPLE of the Form file.
 N DDP,DDSCD,DDSERR,DDS
 ;
 S DDP=$P($G(^DIST(.403,DA(2),0)),U,8)
 I 'DDP D  G QUIT
 . N P
 . S P(1)="PRIMARY FILE",P(2)="FORM"
 . D BLD^DIALOG(3011,.P)
 ;
 S DDS=DA(2)_U_$P(^DIST(.403,DA(2),0),U)
 D:X?1"FO(".E FO^DDSPTR(DDP,X,DA(2),DA(1))
 D:X'?1"FO(".E DD^DDSPTR(DDP,X,DA)
 G QUIT
 ;
CEXPR ;Input transform for COMPUTED EXPRESSION field
 N DDP,DDSX,DDSNEXP
 S DDP=$P($G(^DIST(.404,DA(1),0)),U,2)
 D PARSE^DDSCOMP(DDP,X,DA(1),.DDSNEXP) G:$G(DIERR) QUIT
 ;
 S DDSX=X,X=DDSNEXP D ^DIM S:$D(X) X=DDSX
 Q
 ;
QUIT ;Check error and quit
 I $G(DIERR) N DDSERR D MSG^DIALOG("AB",.DDSERR),EN^DDIOL(.DDSERR) K X
 Q
