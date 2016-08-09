DIKCDD ;SFISC/MKO-DATA DICTIONARY CODE FOR INDEX AND KEY FILES ;3:02 PM  5 Dec 2001
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ITFLD ;Input transform for field
 Q:'$D(DA)!'$D(DA(1))!'$D(DDS)
 N DIKCFILE
 S DIKCFILE=$$GETFILE(.DA) I 'DIKCFILE K X Q
 ;
 N %,D,D0,DA,DDD,DIC,DICR,DIX,DO,DP,DZ,Y
 S DIC="^DD("_DIKCFILE_",",DIC(0)="EN"
 S DIC("S")="I '$P(^(0),U,2)&($P(^(0),U,2)'[""C"")"
 D ^DIC
 I Y'>0 K X
 E  S X=+$P(Y,"E")
 Q
 ;
EHFLD ;Executable help for field
 Q:'$D(DA)!'$D(DA(1))!'$D(DDS)
 N DIKCFILE
 S DIKCFILE=$$GETFILE(.DA) Q:'DIKCFILE
 ;
 N %,D,D0,DA,DDD,DIC,DICR,DIX,DO,DP,Y
 S DIC="^DD("_DIKCFILE_",",DIC(0)="",D="B"
 S DIC("S")="I '$P(^(0),U,2)&($P(^(0),U,2)'[""C"")"
 S:$G(X)="??" DZ=X
 D DQ^DICQ
 Q
 ;
GETFILE(DA) ;
 Q:'$D(DA)!'$D(DA(1))!'$D(DDS)
 N DIKCFILE
 S DIKCFILE=$$GET^DDSVAL(.114,.DA,2)
 Q DIKCFILE
