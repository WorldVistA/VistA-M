DICL1 ;SEA/TOAD,SF/TKW-VA FileMan: Lookup: Lister, Part 2 ;10/15/98  14:19
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PREP ; set up subfile's DA array under DIEN, init how many found,
 ; set max, and init array of last entries returned.
 ;
 N DIEN D DA^DILF(DIFIEN,.DIEN)
 N DISUB,DIVAL,X,Y
 S DIDENT(-1)=0
 S DIDENT(-1,"MAX")=DINUMBER
 S DIDENT(-1,"JUST LOOKING")=0
 F DISUB=1:1:DINDEX("#")+1 S DIDENT(-1,"LAST",DISUB)=""
 S (DIDENT(-1,"LAST"),DIDENT(-1,"LAST","IEN"))=""
 ;
PTR ; if 1st indexed field is a pointer or var.ptr., and we're not doing
 ; a quick list, we build info for the
 ; pointer chain(s) to the end file(s) and do the search.
 ;
 I "VP"[DINDEX(1,"TYPE"),DIFLAGS'["Q",'$D(DINDEX("ROOTCNG",1)) D
 . D POINT^DICL10(.DIFILE,.DIFLAGS,.DINDEX,.DIDENT,.DIEN,DIFIEN,.DISCREEN,.DILIST)
 . Q
 ;
GETLIST ; build the output list when first subscript not a ptr. or var.ptr.
 ;
 E  D
 . I $D(DINDEX("ROOTCNG",1)) D BLDTMP^DICLIX1(.DINDEX,.DISCREEN,DIFLAGS,.DIDENT)
 . D WALK^DICLIX(DIFLAGS,.DINDEX,.DIDENT,.DIFILE,.DIEN,.DIFIEN,.DISCREEN,.DILIST,"","",.DIC)
 ;
DSPHLP ; If we're displaying entries for online ^DIC help, display the rest
 ;
 I DIFLAGS["h",$O(DICQ(0)) D
 . K DTOUT,DUOUT S DICQ(0,"MAP")=DIDENT(-3)
 . D DSP^DICQ1(.DINDEX,.DICQ,.DIC,.DIFILE)
 . I $G(DTOUT)!($G(DUOUT)) S (DINDEX("DONE"),DIDONE)=1 Q
 . S DIDENT(-1)=0
 . Q
 ;
KTMPIX ; if we've built temporary indexes, we delete them:
 D KILLB(.DIFILE)
 N DISUB S DISUB=$O(DINDEX("ROOTCNG","")) I DISUB K @DINDEX(DISUB,"ROOT")
 ;
FINAL ; cleanup after search.
 ;
 I $G(DIERR) K @DILIST D OUT^DICL Q
 ;
 ; set the output list header node and map node, output FROM values
 ; for last entries returned.
 ;
 I '$D(DIDENT(-1)) S DIDENT(-1)=0,DIDENT(-1,"MAX")=DINUMBER
 N DIHEADER S DIHEADER=DIDENT(-1)_U_DIDENT(-1,"MAX")_U_+$G(DIDENT(-1,"MORE?"))
 S @DILIST@(0)=DIHEADER_U_$S(DIFLAGS[2:"H",1:"")
 I DIFLAGS["P",$G(DIDENT(-3))]"" S @DILIST@(0,"MAP")=DIDENT(-3)
 E  D SETMAP(.DIDENT,DILIST)
 N I S I=0 F  S I=$O(DIDENT(-1,"LAST",I)) Q:'I  D
 . K DIDENT(-1,"LAST",I,"I")
 . Q:$G(DIDENT(-1,"MORE?"))
 . I I=1 S (DIDENT(-1,"LAST"),DIDENT(-1,"LAST","IEN"))=""
 . S DIDENT(-1,"LAST",I)=""
 . Q
 K DIFROM M DIFROM=DIDENT(-1,"LAST")
 ;
 ; Move arrays to output and QUIT.
 D OUT^DICL
 Q
 ;
KILLB(DIFILE) ; Kill temporary "B" index on current file DIFILE or pointed-to files.
 N DIROOT I $D(DIFILE(DIFILE,"NO B")) S DIROOT=DIFILE(DIFILE,"NO B")_")" K @DIROOT
 Q:'$O(DIFILE("STACK",0))
 N I,J,K
 F I=0:0 S I=$O(DIFILE("STACK",I)) Q:'I  F J=0:0 S J=$O(DIFILE("STACK",I,J)) Q:'J  F K=0:0 S K=$O(DIFILE("STACK",I,J,K)) Q:'K  I $D(DIFILE(K,"NO B")) D
 . S DIROOT=DIFILE(K,"NO B")_")"
 . K @DIROOT Q
 Q
 ;
SETMAP(DIDENT,DILIST) ; Set map node for unpacked format
 N I,J,K,DIMAP,DITMP S (DIMAP,I)=""
 F  S I=$O(DIDENT(-3,I)) Q:I=""  S DITMP="" D  D SETM2
 . I I S J="" F  S J=$O(DIDENT(-3,I,J)) Q:J=""  D
 . . I J?1.N.1"I" D
 . . . N K S K="FID("_I_")"_$P("I^",U,J["I")
 . . . K:$D(DIDENT(-3,I,K)) DIDENT(-3,I,K) Q
 . . S DITMP=DITMP_J_"^" Q
 . Q:I'=0
 . F J=0:0 S J=$O(DIDENT(-3,0,J)) Q:'J  S K="" F  D  Q:K=""
 . . S K=$O(DIDENT(-3,0,J,K)) S:K]"" DITMP=DITMP_K_"^" Q
 Q:DIMAP=""  S $E(DIMAP,$L(DIMAP))=""
 S @DILIST@(0,"MAP")=DIMAP
 Q
 ;
SETM2 N DILENGTH S DILENGTH=$L(DIMAP) Q:$E(DIMAP,DILENGTH-3,DILENGTH)="..."
 I $L(DITMP)+($L(DIMAP))>252 S DIMAP=DIMAP_"..." Q
 S DIMAP=DIMAP_DITMP Q
 ;
 ;
