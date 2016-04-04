DDS10 ;SFISC/MKO-BLOCK SETUP ;21SEP2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**147,151**
 ;
SET(DDS1B,DDS1E,DA,DDP,DIE,DL,DDSDA) ;Get values for pointed-to block
 ;In:
 ;  DDS1B   = Block number or [Block name] (by ref)
 ;  DDS1E   = 1, if we're loading a pointed-to block and we want
 ;               interactive dialog (DIC(0)["E") in the lookup
 ;  DA      = Record array
 ;Returns:
 ;  DDS1B = Block number
 ;  DDP   = File number of block
 ;  DIE   = Global root based on DDP and DA
 ;  DL    = Level number (top=0)
 ;  DDSDA = DA,DA(1),...,
 ;
 D BK(.DDS1B,.DDP) Q:$G(DIERR)
 D GDA(DDS1B,DDS1E,.DA) Q:$G(DIERR)
 D GL(DDP,.DA,.DIE,.DL,.DDSDA,$P($G(^DIST(.403,+DDS,40,+$G(DDSPG),40,DDS1B,0)),U,4)'="d") Q:$G(DIERR)  ;Don't LOCK record if block is display-only
 Q
 ;
BK(DDSBK,DDP) ;Lookup block, get file number
 ;Input:
 ;  DDSBK = Block number or [Block name] (by ref)
 ;Returns:
 ;  DDSBK = Block number
 ;  DDP   = File number
 ;  DIERR
 ;
 I DDSBK=+$P(DDSBK,"E")  D  Q
 . I $D(^DIST(.404,DDSBK,0))[0 D BLD^DIALOG(3051,"#"_DDSBK) Q
 . S DDP=+$P(^DIST(.404,DDSBK,0),U,2)
 I DDSBK?1"["1.E1"]" D  Q
 . N X,Y,DIC
 . S X=$E(DDSBK,2,$L(DDSBK)-1),DIC="^DIST(.404,",DIC(0)="FZ"
 . D ^DIC I Y<0 D BLD^DIALOG(3051,"named "_X) Q
 . S DDSBK=+Y,DDP=+$P(Y(0),U,2)
 D BLD^DIALOG(3051,"#"_DDSBK)
 Q
 ;
GDA(DDS1B,DDS1E,DA) ;Find new DA
 ;Input:
 ;  DDS1B    = Block number
 ;  DDS1E    = 1:Interactive lookup
 ;  DDSDAORG = Original DA array
 ;  DDSDLORG = Original DL
 ;  DDSPG
 ;Returns:
 ;  DA      = Record number
 ;  DIERR
 ;
 N DDSDA,DDSI,X
 ;
 ;Set DA array to its original value
 S DA=DDSDAORG
 F DDSI=1:1:DDSDLORG S DA(DDSI)=DDSDAORG(DDSI)
 D DDSDA(.DA,DDSDLORG,.DDSDA)
 ;
 ;Xecute each PTB node
 F DDSI=1:1 Q:DA=""!'$D(@DDSREFS@(DDSPG,DDS1B,"PTB",DDSI))  X ^(DDSI) S:$G(X)'>0 DA=""
 ;
 ;Kill descendants of DA
 I '$G(DIERR) S DDSI=DA K DA S DA=DDSI
 S:DA'>0!$G(DIERR) DA=""
 Q
 ;
GL(F,DA,DIE,DL,DDSDA,DDSL) ;Get global root, level, and IEN
 ;Input variables:
 ;  F    = file #
 ;  DA   = array
 ;  DDSL = flag to lock record
 ;Returns:
 ;  DIE   = global root of file (null if error)
 ;  DL    = level (top=0) (null if error)
 ;  DDSDA = IEN
 ;  DIERR = Error flag
 ;
 I '$D(^DD(F)) D BLD^DIALOG(401,F) S (DIE,DL)="" Q
 I $D(^DIC(F,0,"GL"))#2 S DIE=^("GL"),DL=0
 E  D SUBGL Q:$G(DIERR)
 ;
 I '$G(DA) S DDSDA="0," Q
 D DDSDA(.DA,DL,.DDSDA)
 ;
 N DDSP S DDSP("FILE")=F,DDSP("IEN")=DDSDA
 ;
 I $D(@(DIE_DA_",0)"))[0 D BLD^DIALOG(601,"",.DDSP)
 I $D(@(DIE_DA_",-9)")) D BLD^DIALOG(602,"",.DDSP)
 ;
 I $G(DDSL),$D(^TMP("DDS",$J,"LOCK",DIE_DA_")"))[0 D  Q:$G(DIERR)
 . D LOCK^DILF(DIE_DA_")") E  D BLD^DIALOG(110,"",.DDSP) Q  ;**147
 . S ^TMP("DDS",$J,"LOCK",DIE_DA_")")=""
 Q
 ;
SUBGL ;Get root and level for subfile
 N D,I,S,U1
 S D=F
 F DL=0:1 Q:$D(^DD(D,0,"UP"))[0  S U1=^("UP") G:'$D(^DD(U1,"SB",D)) SUBER G:$D(^DD(U1,$O(^(D,"")),0))[0 SUBER S S(DL+1)=""""_$P($P(^(0),U,4),";")_"""",D=U1
 G:$D(^DIC(D,0,"GL"))[0 SUBER S DIE=^("GL")
 F I=DL:-1:1 G:$D(DA(I))[0 SUBER S DIE=DIE_DA(I)_","_S(I)_","
 Q
 ;
SUBER ;Come here if an error is encountered in GL
 S (DIE,DL)=""
 D BLD^DIALOG(309)
 Q
 ;
DDSDA(DA,DL,DDSDA) ;Determine DDSDA
 ;Input:
 ;  DA    = Record array
 ;  DL    = Level number (top=0)
 ;Output:
 ;  DDSDA = DA,DA(1),...,
 ;
 N I
 I DA="" S DDSDA="" Q
 S DDSDA=DA_"," F I=1:1:DL S DDSDA=DDSDA_DA(I)_","
 Q
