DIKKDD ;SFISC/MKO-DATA DICTIONARY CODE FOR KEY FILE ;1:49 PM  8 Sep 1997
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ITFLD ;Input transform for field
 Q:'$D(DA)  Q:'$D(DA(1))
 N DIKKFILE
 S DIKKFILE=$$GETFILE(.DA) I 'DIKKFILE K X Q
 ;
 N %,D,D0,DA,DDD,DIC,DICR,DIX,DO,DP,DZ,Y
 S DIC="^DD("_DIKKFILE_",",DIC(0)="EN",DIC("S")="I '$P(^(0),U,2)"
 D ^DIC
 I Y'>0 K X
 E  S X=+$P(Y,"E")
 Q
 ;
EHFLD ;Executable help for field
 Q:'$D(DA)  Q:'$D(DA(1))
 N DIKKFILE
 S DIKKFILE=$$GETFILE(.DA) Q:'DIKKFILE
 ;
 N %,D,D0,DA,DDD,DIC,DICR,DIX,DO,DP,Y
 S DIC="^DD("_DIKKFILE_",",DIC(0)="",D="B"
 S DIC("S")="I '$P(^(0),U,2)"
 S:$G(X)="??" DZ=X
 D DQ^DICQ
 Q
 ;
GETFILE(DA) ;
 Q:'$D(DA)  Q:'$D(DA(1))
 N DIKKFILE
 I $D(DDS) S DIKKFILE=$$GET^DDSVAL(.31,DA(1),.01)
 E  S DIKKFILE=$P($G(^DD("KEY",DA(1),0)),U)
 Q DIKKFILE
