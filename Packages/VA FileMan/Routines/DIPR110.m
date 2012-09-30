DIPR110 ;SFISC/MKO-PRE-INSTALL ROUTINE FOR PATCH DI*22*110 ;2:40 PM  11 Jul 2002
 ;;22.0;VA FileMan;**110**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Set the "NM" node for the MUMPS OPERATING SYSTEM file (#.7)
 K ^DD(.7,0,"NM")
 S ^DD(.7,0,"NM","MUMPS OPERATING SYSTEM")=""
 Q
