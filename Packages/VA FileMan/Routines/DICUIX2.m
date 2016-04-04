DICUIX2 ;VEN/TOAD,SF/TKW - Lookup: Build Index Data ; 11 OCT 2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,28,67,168,1046**
 ;
 ;
 ; Contents
 ;
 ; COMMON1: Load Data-subscript Data into DINDEX
 ; $$BACKFROM: Return From Value for Backward Collation
 ; COMMON2: Load IEN-subscript Data into DINDEX
 ; DAT: Process FROM and PART for dates
 ; $$ORDERQ: Is File Like Order File: Dinumed but No B Index?
 ;
 ;
COMMON1 ; Load Data-subscript Data into DINDEX
 ;
 N DIFR,DIPRT
 S DIFR=$G(DIFROM(DISUB)),DIPRT=$G(DIPART(DISUB))
 I DINDEX(DISUB,"FILE")=DIFILE S DINDEX("FLIST")=DINDEX("FLIST")_"^"_DINDEX(DISUB,"FIELD")
 I DIFLAGS["q" D C3 Q
 S DINDEX(DISUB,"USE")=0 D
 . I DIFROM("IEN") S DINDEX(DISUB,"USE")=1 Q
 . S:$G(DIFROM(DISUB+1))]"" DINDEX(DISUB,"USE")=1
 ;
C1 ; 1. Decide which direction to traverse this subscript
 ;
 S DINDEX(DISUB,"WAY")=DIWAY*DINDEX("WAY") ; calculate direction
 I DIFLAGS[4,DIFLAGS'["l" S DINDEX(DISUB,"WAY")=1 ; override?
 I $G(DINDEX("WAY","REVERSE")) S DITO(DISUB)=DIFR,DIFR=""
 ;
C2 ; 2. Adjust From & To to fit max subscript length
 ;
 I DIFLAGS[4 S DINDEX(DISUB,"LENGTH")=DILENGTH
 I DIFLAGS[3 D
 . S DIFR=$E(DIFR,1,DILENGTH)
 . S DIPRT=$E(DIPRT,1,DILENGTH)
 . I $D(DITO(DISUB)) S DITO(DISUB)=$E(DITO(DISUB),1,DILENGTH)
 ;
C3 ; 3. Build code to extract indexed field from data
 ;
 I 'DINDEX(DISUB,"FILE")!('DINDEX(DISUB,"FIELD")) S DINODE="",DICODE="DINDEX(DISUB)"
 E  D GET^DICUIX1(DIFILE,DINDEX(DISUB,"FILE"),DINDEX(DISUB,"FIELD"),.DINODE,.DICODE)
 I $G(DIERR) D
 . S DINODE="",DICODE="DINDEX(DISUB)"
 . D BLD^DIALOG(8099,DINDEX)
 S DINDEX(DISUB,"GET")="DIVAL="_DICODE
 ;
C4 ; 4. Find & record subscript data-type info
 ;
 S DITYPE=$P(DINODE,U,2)
 N % S %="F" D  S DINDEX(DISUB,"TYPE")=%
 . Q:DIFLAGS["Q"
 . I DITYPE["P" S %="P" S:$$ORDERQ(+$P(DITYPE,"P",2)) %="F",DITYPE="F" Q  ;TRICK:  TREAT FILE 100 POINTERS AS FREE-TEXT!
 . I DITYPE["D" S %="D" Q
 . I DITYPE["S" S %="S" Q
 . I DITYPE["V" S %="V" Q
 . I DITYPE["N" S %="N"
 ;
 Q:DIFLAGS["q"
 I DISUB=1 D
 . S DITEMP=$S($D(DIFILE(DIFILE,"NO B")):DIFILE(DIFILE,"NO B"),1:DIFILE(DIFILE,"O")_"DINDEX")
 . I "VP"[DINDEX(DISUB,"TYPE") D
 . . S DINDEX(1,"NODE")=DINODE Q:DIFLAGS[4
 . . I DIFLAGS'["Q",$$CHKP^DICUIX1(.DIFILE,.DINDEX,+$G(DINUMBER),DIFR_DIPRT,.DISCREEN) D  Q
 . . . D TMPIDX^DICUIX1(1,.DITEMP,.DITEMP2,.DINDEX)
 . . S DINDEX("AT")=2
 ;
 I DISUB>1 D
 . I DIFLAGS[4,"VP"[DINDEX(DISUB,"TYPE") S DINDEX(DISUB,"GET")="DIVAL=$G(DINDEX(DISUB,""EXT""))"
 . I DIFLAGS[3,"VP"[DINDEX(DISUB,"TYPE"),DIFLAGS'["Q",'$D(DINDEX("ROOTCNG")) D TMPIDX^DICUIX1(DISUB,.DITEMP,.DITEMP2,.DINDEX) Q
 . S DITEMP=DITEMP_"DINDEX("_(DISUB-1)_")"
 ;
 S DINDEX(DISUB,"ROOT")=DITEMP_")",DITEMP=DITEMP_","
 I $D(DITEMP2) D
 . S:DISUB>1 DITEMP2=DITEMP2_"DIX("_(DISUB-1)_")"
 . S DINDEX(DISUB,"IXROOT")=DITEMP2_")",DITEMP2=DITEMP2_","
 ;
C5 ; 5. Set Any More?
 ;
 S DINDEX(DISUB,"MORE?")=0
 I +$P(DIPRT,"E")=DIPRT,DITYPE'["D" D
 . ;
 . Q:DIFLAGS["X"  ; no partial-numeric matches if require exact
 . N PNM S PNM=0 ; suppress PNM for pointers or variable pointers?
 . I "VP"[$E(DITYPE) D  Q:'PNM  ; at least for these cases:
 . . I DIFLAGS["l",DIC(0)["U" Q  ; classic, untransformed lookup
 . . I DIFLAGS[3,DIFLAGS["Q" Q  ; Lister, quick list
 . . I DIFLAGS[4,DIFLAGS["Q" Q  ; Finder, quick lookup
 . . S PNM=1 ; otherwise, allow it on ptrs or vptrs
 . ;
 . I DINDEX(DISUB,"WAY")=-1 S DINDEX(DISUB,"MORE?")=1 Q
 . I +$P(DIFR,"E")=DIFR!(DIFR="") S DINDEX(DISUB,"MORE?")=1
 ;
C6 ; 6. Handle partial matches, incl. setting From
 ;
 I DIPRT]"" D
 . I DIFLAGS[4,"VP"[DINDEX(DISUB,"TYPE") Q:DIFLAGS'["l"  Q:DISUB>1
 . I DITYPE["D",DIFLAGS[3 D  Q
 . . N I S I=$S(DINDEX(DISUB,"WAY")=1:"0000000",1:9999999)
 . . D DAT(.DIFR,DIPRT,I,DINDEX(DISUB,"WAY"),.DIOUT)
 . Q:$E(DIFR,1,$L(DIPRT))=DIPRT
 . I DINDEX(DISUB,"WAY")=1 D  Q
 . . I DIFR]](DIPRT_$S(+$P(DIPRT,"E")=DIPRT:" ",1:"")) S DIOUT=1 Q
 . . I +$P(DIPRT,"E")=DIPRT,DIPRT<0 S DIFR=$S(DIPRT[".":$P(DIPRT,".")-1,1:"")  Q
 . . I +$P(DIPRT,"E")=DIPRT,+$P(DIFR,"E")=DIFR,DIFR>DIPRT Q
 . . S DINDEX(DISUB,"USE")=1
 . . S DIFR=DIPRT_$S(+$P(DIPRT,"E")'=DIPRT:"",DIFR]]DIPRT:" ",1:"")
 . ;
 . I DIFR'="",DIPRT]]DIFR S DIOUT=1 Q
 . I +$P(DIPRT,"E")=DIPRT,DIFR?.1"-"1.N.E Q
 . S DINDEX(DISUB,"USE")=1
 . S DIFR=$$BACKFROM(DIPRT) ; start from end of partial matches
 ;
 S (DINDEX(DISUB),DINDEX(DISUB,"FROM"))=DIFR
 I DIPRT]"" S DINDEX(DISUB,"PART")=DIPRT
 I $D(DITO(DISUB)) S DINDEX(DISUB,"TO")=DITO(DISUB)
 ;
C7 ; 7. Handle subscripts with data-type transforms
 ;
 I $G(DIDENT(-5)) D
 . I $D(DINDEX(DISUB,"TRANOUT")) S DINDEX(DISUB,"GETEXT")=DIGET Q
 . N T S T=DITYPE I T'["D",T'["S",T'["P",T'["V",T'["O" Q
 . I DIFLAGS[3,"PV"[DINDEX(DISUB,"TYPE"),(DISUB>1!($D(DINDEX("ROOTCNG",1)))) D
 . . I DINDEX(DISUB,"FILE")'=DIFILE S DIGET=0 Q
 . . S DIGET=2
 . S DINDEX(DISUB,"GETEXT")=DIGET
 ;
 QUIT  ; end of COMMON1
 ;
 ;
BACKFROM(DIPART) ; Return From Value for Backward Collation
 ;
 ;;private;function;clean;silent;SAC compliant
 ; input: DIPART = the partial-match value
 ; output = From value for backward collation
 ; called by:
 ;   COMMON1, at C6+18
 ;   BACKFROM^DICF1
 ; calls: none
 ;
 N DIFROM S DIFROM=DIPART_"{{{{{{{{{{"
 ;
 QUIT DIFROM ; return From value ; end of $$BACKFROM
 ;
 ;
COMMON2 ; Load IEN-subscript Data into DINDEX
 ;
 N DIEN S DIEN=DINDEX("#")+1
 S:DINDEX'="#" DINDEX(DIEN,"ROOT")=DITEMP_"DINDEX("_(DIEN-1)_"))"
 I $D(DITEMP2) S DINDEX(DIEN,"IXROOT")=DITEMP2_"DIX("_(DIEN-1)_"))"
 I $G(DINDEX("WAY","REVERSE")),DIFROM("IEN") S DINDEX(DIEN,"TO")=DIFROM("IEN"),DIFROM("IEN")=""
 S DINDEX(DIEN)=DIFROM("IEN")
 I DINDEX(DIEN)=0,DINDEX("WAY")=-1 S DINDEX(DIEN)=""
 I DIFROM("IEN") S DINDEX(DIEN,"FROM")=DIFROM("IEN")
 S DINDEX(DIEN,"WAY")=DINDEX("WAY")
 ;
 QUIT  ; end of COMMON2
 ;
 ;
DAT(DIFR,DIPRT,DIAPP,DIWAY,DIOUT) ; Process FROM and PART for dates
 ;
 N L,P,DIPART S L=$L(DIFR),P=$L(DIPRT),DIPART=DIPRT
 I L<P S DIFR=DIFR_$E(DIPART,L+1,P)
 I $L(DIFR)<7 S DIFR=$E(DIFR_DIAPP,1,7)
 Q:$E(DIFR,1,P)=DIPART
 I P<7 S DIPART=$E(DIPART_DIAPP,1,7)
 I DIWAY=1,DIFR]]DIPART S DIOUT=1 Q
 I DIWAY=-1,DIPART]]DIFR S DIOUT=1 Q
 S $E(DIFR,1,P)=DIPRT
 S DINDEX(DISUB,"USE")=1
 ;
 QUIT  ; end of DAT
 ;
 ;
ORDERQ(FILENUM) ; Is File Like Order File: Dinumed but No B Index?
 ;
 I $P($G(^DD(+FILENUM,.01,0)),U,5,99)["DINUM=X",$P(^(0),U,2)'["P",$P(^(0),U,2)'["D",'$D(^DD(+FILENUM,0,"IX","B")) Q 1
 ;
 QUIT 0 ; end of $$ORDERQ
 ;
 ;
EOR ; end of routine DICUIX2
