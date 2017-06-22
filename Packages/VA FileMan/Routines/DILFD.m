DILFD ;SFISC/STAFF-LIBRARY OF FUNCTIONS ;11/18/94  11:05
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
ROOT(DIC,DA,CP,ERR) ;
 G ENROOT^DIQGU
 ;
FLDNUM(DIEFF,DIEFFDNM) ;
 G FLDNUMX^DIEF1
 ;
VFILE(F,FLAG) ;
 G VFILEX^DIEFU
 ;
VFIELD(F,FLD,FLAG) ;
 G VFIELDX^DIEFU
 ;
RECALL(DIFILE,DIEN,DIUSER) ;SEA/TOAD
 G RECALLX^DICU
 ;
EXTERNAL(DIFILE,DIFIELD,DIFLAGS,DINTERNL,DIMSGA) ;SEA/TOAD
 G XTRNLX^DIDU
 ;
PRD(DIFRFILE,DIFRPRD) ;DCL
 G EN^DIFROMSV
 ;
