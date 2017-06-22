DDR4 ;SFCIOFO/DPC-FileMan Delphi Components' RPCs ;2/24/96  12:02
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
KEYVAL(DDROUT,DDRFDARW) ;
 N DDRFDA,DDRERR
 D FDASET2(.DDRFDARW,.DDRFDA)
 S DDROUT(1)=$$KEYVAL^DIEVK("","DDRFDA","DDRERR")
 Q
 ;
FDASET2(DDRFDARW,DDRFDA) ;
 N DDRI,DDRLINE,DDRFILE,DDRIENS,DDRFIELD
 F DDRI=1:1 S DDRLINE=$G(DDRFDARW(DDRI)) Q:DDRLINE=""  D
 . I DDRI#2 D
 . . S DDRFILE=$P(DDRLINE,U)
 . . S DDRIENS=$P(DDRLINE,U,2)
 . . S DDRFIELD=$P(DDRLINE,U,3)
 . E  D
 . . S DDRFDA(DDRFILE,DDRIENS,DDRFIELD)=$TR(DDRLINE,$C(13)_","_$C(10))
 Q
