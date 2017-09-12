DIPR26 ;SFISC/SO- PRE INSTALL ROUTINE FOR PATCH DI*22.0*26;12:23 PM  6 Jan 2000
 ;;22.0;VA FileMan;**26**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Make SCREEN field of Variable Pointer DD Required
 ;
 ; Current:
 ; ^DD(.12,1,0) = SCREEN^FX^^1;E1,240^K:$L(X)>240!...D:$D(X) ^DIM
 ;
 ; To:
 ; ^DD(.12,1,0) = SCREEN^RFX^^1;E1,240^K:$L(X)>240!...D:$D(X) ^DIM
 ;
 S $P(^DD(.12,1,0),"^",2)="RFX"
 Q
