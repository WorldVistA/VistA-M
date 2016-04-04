DMSQE ;SFISC/EZ-DISPLAY ERRORS ;11/26/97  13:57
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
MAIN ; main driver
 N DMF,DMFI,DMFE,DMFNM,DMFINM,DMQ
 S DMQ=""
 D CHK,PRT:'DMQ
 Q
CHK ; check for existence of SQLI data in DMSQ global
 I '$O(^DMSQ("S",0)) W !?5,"Sorry, SQLI files are empty.",! S DMQ=1 Q
 I $$WAIT^DMSQT1 D  S DMQ=1 Q
 . W !?5,"Try later.  SQLI is being re-built right now."
 Q
PRT ; print errors along with file/subfile/field number/name
 S DIC=1.52192,L=0,BY="3",(FR,TO)=""
 S DMF="$P($G(^DMSQ(""EX"",D0,0)),U,1)"
 S DMFI="$P($G(^DMSQ(""EX"",D0,0)),U,2)"
 ;S DMFE="$P($G(^DMSQ(""EX"",D0,0)),U,5)"
 ;can include Dialog file codes/text at a later time, when SQLI does
 ;a better job of keeping hold of the error from DBS calls to the
 ;Updater, Filer, DD Retriver, etc.
 S DMFNM="$O(^DD("_DMF_",0,""NM"",0))"
 ; use NM node for files & subfiles 
 S DMFINM="$S("_DMFI_":$P($G(^DD("_DMF_","_DMFI_",0)),U,1),1:"""")"
 S DHIT="W ?11,@DMFNM,"" "",?40,@DMFI,"" "",?50,@DMFINM,!"
 S FLDS="INTERNAL(#.01);""FILE"";S,"" "";X,2;C12;"""""
 D EN1^DIP Q
