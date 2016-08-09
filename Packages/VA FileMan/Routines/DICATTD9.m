DICATTD9 ;SFISC/GFT - MUMPS FIELDS ;10:55 AM  26 Jan 2001
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
2 S DICATT2N="K",DICATT3N=""
 S DICATT5N="K:$L(X)>245 X D:$D(X) ^DIM",DICATTLN=245
 S DICATTMN="Enter Standard MUMPS code" D CHNG
 D PUT^DDSVALF(7,,,"@","") ;no WRITE ACCESS
 Q
 ;
CHNG I DICATT5N=DICATT5 K DICATTMN ;No DICATTMN means no change
 D:$D(DICATTMN) PUT^DDSVALF(98,"DICATT",1,DICATTMN)
 Q
 ;
