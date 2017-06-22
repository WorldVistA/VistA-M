DIVRE1 ;SFISC/MWE-HELP LOGIC FOR REQ FLD(S) CHK ;1/17/91  3:11 PM
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
H W !!?5,"YES means that every entry in the file will be checked to see"
 W !?5,"that all the required fields have data."
 W !!?5,"NO means that ALL will be used to lookup an entry in the"
 W !?5,"file which begins with the letters ALL."
 Q
