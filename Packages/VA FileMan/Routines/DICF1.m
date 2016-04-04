DICF1 ;SEA/TOAD,SF/TKW-VA FileMan: Finder, Part 2 (Transform) ;1SEP2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**15,51,70,135,170,1050**
 ;
 ;
 ; Contents
 ;
 ; XFORM: Add Transformed Lookup Values & Screens, Main Loop
 ; VALUES/LOWER/CHK/COMMA/LONG: Alternate Lookup Values
 ; SPECIAL: Handle Selection by Record Number
 ; ENTRY: Screen & Accept a Record-number Match
 ; BACKFROM: Create From Values for Backward Collation
 ;
 ;
XFORM(DIFLAGS,DIVALUE,DISCREEN,DINDEX) ;
 ; FIND--produce array of values and screens by transforming input
 ; subroutine, DIVALUE, DINDEX, & DISCREEN passed by reference
 N DISUB F DISUB=1:1:DINDEX("#") D VALUES
 QUIT  ; end of XFORM
 ;
 ;
VALUES ; Alternate Lookup Values
 ;
 ; 1. Add Original Lookup Value to Arrays
 ;
 I $D(DIVALUE(DISUB,0,1)) S DIVALUE(DISUB)=DIVALUE(DISUB,0,1)
 N I F I="PART","FROM","TO" I $D(DIVALUE(DISUB,0,1,I)) D
 . S DINDEX(DISUB,I)=DIVALUE(DISUB,0,1,I) Q
 D
 . S I=-1 F  S I=$O(DIVALUE(DISUB,I)) Q:I=""  K DIVALUE(DISUB,I)
 . S I=-1 F  S I=$O(DISCREEN(DISUB,I)) Q:I=""  K DISCREEN(DISUB,I)
 S DIVALUE(DISUB,1)=DIVALUE(DISUB)
 Q:DIVALUE(DISUB)=""
 I DIFLAGS["Q" D LONG Q
 ;
LOWER ; 2. Add Upper-case Lookup Value to Array, If Needed
 ;
 I DIVALUE(DISUB)?.E1L.E,DIFLAGS'["X" D
 . S DIVALUE(DISUB,2)=$$OUT^DIALOGU(DIVALUE(DISUB),"UC")
 ;
CHK ; 3. Skip Remaining Transforms for Most Data Types
 ;
 ; Quit if data type not free-text, pointer or vp
 ; or if lookup value is numeric or a date
 ;
 Q:"PVF"'[$G(DINDEX(DISUB,"TYPE"))
 I DIVALUE(DISUB)?.NP D LONG Q  ;**170
 N Y D  Q:Y>0
 . N X S X=DIVALUE(DISUB) N %DT,DIFLAGS,DIVALUE,DISCREEN,DINDEX,DISUB
 . S %DT="T" D ^%DT
 ;
COMMA ; 4. Add Comma-piece Lookup Value to Arrays, If Needed
 ;
 I DIVALUE(DISUB)[",",DIFLAGS'["X" D
 . N DISTEMP,DIPIECE1 S DISTEMP="",DIPIECE1=$P(DIVALUE(DISUB),",")
 . Q:$L(DIPIECE1)>DINDEX(DISUB,"LENGTH")
 . Q:'$L(DIPIECE1)  ;SO
 . ;
21 . ; Handle Original Form of Comma-piece Lookup (C Flag)
 . ;
 . I DIFLAGS["C" D
 . . N DIPART1 S DIPART1=" I %?.E1P1"""
 . . N DIPART2 S DIPART2=""".E!(D'=""B""&(%?1"""
 . . N DIPART3 S DIPART3=""".E))"
 . . N DIOUT S DIOUT=0
 . . N DIPIECE,DIVPIECE F DIPIECE=2:1 D  I DIOUT Q
 . . . S DIVPIECE=$P(DIVALUE(DISUB),",",DIPIECE)
 . . . I DIVPIECE["""" Q
 . . . I $E(DIVPIECE)=" " S DIVPIECE=$E(DIVPIECE,2,$L(DIVPIECE))
 . . . I DIVPIECE="" S DIOUT=1 Q
 . . . I $L(DIVPIECE)*2+$L(DISTEMP)+33+14+34>255 S DIOUT=1 Q
 . . . S DISTEMP=DISTEMP_DIPART1_DIVPIECE_DIPART2_DIVPIECE_DIPART3
 . . . Q:DISTEMP=""
 . . . S DISTEMP="S %=DIVAL "_DISTEMP Q  ;22*135
 . . I DISTEMP="" Q
 . ;
22 . ; Handle New, Reduced Form of Comma-piece Lookup
 . ;
 . I DIFLAGS'["C" N DIPIECE2,DIPC2 D
 . . S (DIPC2,DIPIECE2)=$P(DIVALUE(DISUB),",",2)
 . . I DIPIECE2["""" S DIPC2=$$CONVQQ^DILIBF(DIPIECE2)
 . . S DISTEMP="S %=$P(DIVAL,"","",2) I $E(%,1,"_$L(DIPIECE2)_")="""_DIPC2_""""
 . ;
23 . ; Either Way, Add Value and Screen to Arrays
 . ;
 . S DIVALUE(DISUB,3)=DIPIECE1
 . S DISCREEN(DISUB,3)=DISTEMP
 . I DIFLAGS'["C" S DIVALUE(DISUB,3,"c")=DIPIECE2
 . ;
24 . ; Handle Combo of Comma-piecing and Lowercase
 . ;
 . I DIVALUE(DISUB)'?.E1L.E Q
 . S DIVALUE(DISUB,4)=$$OUT^DIALOGU(DIPIECE1,"UC")
 . S DISCREEN(DISUB,4)=$$OUT^DIALOGU(DISTEMP,"UC")
 . I DIFLAGS'["C" S DIVALUE(DISUB,4,"c")=$$OUT^DIALOGU(DIPIECE2,"UC")
 ;
LONG ; 5. Add Long Lookup Value to Arrays, If Needed
 ;
 I $L(DIVALUE(DISUB))'>DINDEX(DISUB,"LENGTH") Q
 N J,X,DISLONG,DISPART,DISXACT,DIREF
 F I=0:0 S I=$O(DIVALUE(DISUB,I)) Q:'I  D
 . N L,M S L=DINDEX(DISUB,"LENGTH")
 . Q:$L(DIVALUE(DISUB,I))'>L
 . S X=DIVALUE(DISUB,I) K DIVALUE(DISUB,I) S DIVALUE(DISUB,0,I)=X
 . I $G(DISCREEN(DISUB,I))]"" S X=DISCREEN(DISUB,I) K DISCREEN(DISUB,I) S DISCREEN(DISUB,0,I)=X
 . S DIVALUE(DISUB,I)=$E(DIVALUE(DISUB,0,I),1,L)
 . I I=1 D
 . . S (DIVALUE(DISUB),DINDEX(DISUB))=DIVALUE(DISUB,I)
 . . F J="PART","FROM","TO" S M=$L($G(DINDEX(DISUB,J))) D:M>L
 . . . S DIVALUE(DISUB,0,I,J)=DINDEX(DISUB,J)
 . . . S DINDEX(DISUB,J)=$E(DINDEX(DISUB,J),1,L)
 . S DISLONG=""
 . I $D(DISCREEN(DISUB,0,I)) S DISLONG=" X DISCREEN("_DISUB_",0,"_I_")"
DIREF . S DIREF="DINDEX("_DISUB_",0,"_I_"),DINDEX("_DISUB_")" ;GFT  TWO-SUBSCRIPT $G!
 . S DISPART="I $P(DIVAL,$G("_DIREF_"))="""""_DISLONG ;DI*22*70
 . S DISXACT="I $P(DIVAL,U)=$G("_DIREF_")"_DISLONG ;GFT
 . ;
L10 . ; Handle Combo of Long Input and Exact Matching
 . ;
 . I DIFLAGS["X" S DISCREEN(DISUB,I)=DISXACT Q
 . I DIFLAGS'["O" S DISCREEN(DISUB,I)=DISPART Q  ;"O"=Only exact matches
 . S DISCREEN(DISUB,I)=DISXACT ;THIS WILL BE XECUTED AT S+7^DICL2
 . S DISCREEN(DISUB,I,2)=DISPART
 ;
 QUIT  ; end of VALUES/LOWER/CHK/COMMA/LONG
 ;
SPECIAL(DIFILE,DIEN,DIFIEN,DIFLAGS,DIVALUE,DINDEX,DISCREEN,DIDENT,DIOUT,DILIST) ;
 ; Process space-bar return, 'IEN or DIVALUE equal to an IEN.
 S DIOUT=0
 ;
11 ; 1. Handle Space Lookup Value (Space-bar Recall)
 ;
 I DIVALUE=" " D  S DIOUT=1 Q
 . N DIROOT S DIROOT=$$ROOT^DIQGU(DIFILE,DIFIEN,"Q")
 . N DINODE S DINODE=$G(^DISV(DUZ,$E(DIROOT,1,28)))
 . N DINODEL S DINODEL=$L(DINODE,",")
 . I $P(DINODE,",",1,DINODEL-1)'=$E(DIROOT,29,9999) Q
 . S DIEN=$P(DINODE,",",DINODEL)
 . I 'DIEN S DIEN="" Q
 . D ENTRY
 ;
12 ; Handle Accent-grave Lookup Value
 ;
 I DIVALUE?1"`".NP D  Q:DIOUT=1
 . S DIEN=$E(DIVALUE,2,$L(DIVALUE)) Q:+DIEN'=DIEN
 . D ENTRY S DIOUT=1
 ;
13 ; Handle Pure Numeric Lookup Value (Possible IEN)
 ;
 I $S(DIVALUE?1.N:1,DIVALUE'?.NP:0,1:+DIVALUE=DIVALUE) D
 . N DI001 S DI001=$D(^DD(DIFILE,.001))
 . N DI01FLAG S DI01FLAG=$P($G(^DD(DIFILE,.01,0)),U,2)
 . I $D(@DIFILE(DIFILE)@(DIVALUE)) D
 . . I DIFLAGS'["A",'DI001,DI01FLAG["N"!($O(@DIFILE(DIFILE)@("A["))'="") Q
 . . S DIEN=DIVALUE
 . . D ENTRY
 . . I $G(DINDEX("DONE"))!($G(DIERR)) S DIEN="",DIOUT=1
 ;
 QUIT  ; end of SPECIAL
 ;
 ;
ENTRY ; Execute screens, and if entry passes, do ACCEPT to add it to output.
 N DI0NODE S DI0NODE=$G(@DIFILE(DIFILE)@(DIEN,0))
 Q:$$SCREEN^DICL2(.DIFILE,.DIEN,DIFLAGS,DIFIEN,.DISCREEN,.DINDEX,DI0NODE)
 D ACCEPT^DICL2(.DIFILE,.DIEN,.DIFLAGS,DIFIEN,.DINDEX,.DIDENT,.DILIST,DI0NODE)
 QUIT  ; end of ENTRY
 ;
 ;
BACKFROM(DIVALUE,DINDEX) ; create From values for backward collation
 ;
 ;;private;procedure;clean;silent;SAC compliant
 ; input:
 ;   .DINDEX("#") = # of lookup values supplied
 ;   .DIVALUE(subscript #) = default lookup value
 ;   .DIVALUE(subscript #,value #) = each additional lookup value
 ; output:
 ;   .DIVALUE("BACK",DISUB,...) = From values for backwards
 ; called only by:
 ;   LOOKUP^DICF
 ; calls:
 ;   $$BACKFROM^DICUIX2 to compute each From value for backwards
 ;
 N DISUB F DISUB=1:1:DINDEX("#") D  ; traverse lookup values
 . ;
 . M DIVALUE("BACK",DISUB)=DIVALUE(DISUB) ; initialize From values
 . ;
 . I DIVALUE(DISUB)'="" D  ; if default exists
 . . N B S B=$$BACKFROM^DICUIX2(DIVALUE(DISUB))
 . . S DIVALUE("BACK",DISUB)=B ; add default back-from value
 . ;
 . N DIVAL S DIVAL=0
 . F  D  Q:'DIVAL  ; traverse alternate values
 . . S DIVAL=$O(DIVALUE(DISUB,DIVAL)) ; each alternate
 . . Q:'DIVAL
 . . I $G(DIVALUE(DISUB,DIVAL))'="" D  ; if alternate exists
 . . . N B S B=$$BACKFROM^DICUIX2(DIVALUE(DISUB,DIVAL))
 . . . S DIVALUE("BACK",DISUB,DIVAL)=B ; add alternate back-from val
 ;
 QUIT  ; end of BACKFROM
 ;
 ;
EOR ; end of routine DICF1
