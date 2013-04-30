LRWLST1A ;DALOI/JDB - ACCESSION SETUP CONT ;03/07/12  16:44
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
SLRSS ;
 ; 
 ; Originally in SLRSS^LRWLST11.
 ; Note: This subroutine gets called after AP Log-in (LRAP)
 ; as well as from other processes such as LEDI.
 ;
 ; Expects: LRAA,LRAD,LRAN,LRCDT,LRDFN,LREAL,LRIDT,LRLLOC,LRNT
 ; LRORU3,LRPRAC,LRSAMP,LRSPEC,LRSS,LRORDRR,LRRSITE,LROLLOC
 ;
 N FLD,FLDS,LRFILE,LRFLDS,LRDATA,DATA,X,I
 N LRFDA,LRIEN,LRMSG,DIERR
 S LRFILE=$S(LRSS="CH":63.04,LRSS="MI":63.05,LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,LRSS="BB":63.01,1:0)
 Q:'LRFILE
 ;
 ; Fields to use for each subfile
 S LRFLDS=""
 I LRSS="CH" D  ;
 . S LRFLDS=".01;.02;.05;.06;.09;.1;.11;.111;.112;.31;.32;.33;.34;.342"
 I LRSS="MI" D  ;
 . S LRFLDS=".01;.02;.05;.06;.07;.08;.09;.1;.055;.111;.112;.31;.32;.33;.34;.342"
 I LRSS="SP" D  ;
 . S LRFLDS=".01;.02;.06;.07;.08;.09;.1;.31;.32;.33;.34;.342"
 I LRSS="CY" D  ;
 . S LRFLDS=".01;.02;.06;.07;.08;.09;.1;.31;.32;.33;.34;.342"
 I LRSS="EM" D  ;
 . S LRFLDS=".01;.02;.06;.07;.08;.09;.1;.31;.32;.33;.34;.342"
 I LRSS="BB" D  ;
 . S LRFLDS=".01;.02;.05;.06;.07;.08;.09;.1;.055"
 Q:LRFLDS=""
 ;
 ; Get current values from database
 S LRIEN=LRIDT_","_LRDFN_","
 D GETS^DIQ(LRFILE,LRIEN,LRFLDS,"IN","LRDATA","LRMSG")
 M DATA=LRDATA(LRFILE,LRIEN)
 ; DATA(field#,"I")=value
 K LRDATA
 ;
 S FLD=""
 F I=1:1:$L(LRFLDS,";") S FLD=$P(LRFLDS,";",I) Q:'FLD  D  ;
 . ; skip if database already has a value
 . Q:$G(DATA(FLD,"I"))'=""
 . ;
 . ; dont process .01 field
 . I FLD=.01 Q
 . ;
 . I FLD=.02 I "CHMI"[LRSS D  Q  ;
 . . D MAKEFDA(.02,LREAL)
 . ;
 . ; Is there a pathologist variable available here?
 . ;I FLD=.02 I "^63.08^63.09^63.02^"[("^"_LRFILE_"^") D  Q  ;
 . ;I FLD=.02 I "SPCYEM"[LRSS D  Q  ;
 . ;. D MAKEFDA(.02,LREAL)
 . ;
 . I FLD=.05 I "CHMIBB"[LRSS D  Q  ;
 . . I LRSS="CH" D MAKEFDA(.05,LRSPEC)
 . . I LRSS'="CH" D  ;
 . . . S X=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0))
 . . . S X=$P(X,U,1)
 . . . D MAKEFDA(.05,X)
 . . ;
 . ;
 . I FLD=.055 I "MIBB"[LRSS D  Q  ;
 . . S X=$P(LRSAMP,";",1)
 . . D MAKEFDA(.055,X)
 . ;
 . I FLD=.06 D MAKEFDA(.06,LRACC) Q  ;
 . ;
 . ;FLD .07 handled below
 . ;FLD .08 handled below
 . ;
 . ;I FLD=.09 I "SPCYEMBB"[LRSS  D  Q  ;
 . ;. ;D MAKEFDA(.09,"????")  ; ???what goes here???
 . ;I FLD=.09 I LRSS="CH" D  Q  ;
 . ;. ;D MAKEFDA(.09,"????")  ;;???SUM REPROT NUM???
 . ;I FLD=.09 I LRSS="MI" D  Q  ;
 . ;. ;D MAKEFDA(.09,"????")  ;;???AMENDED REPORT???
 . ;
 . ; FLD .1 handled below
 . ; FLD .11 handled below
 . ;
 . I FLD=.111 I "CHMI"[LRSS  D  Q  ;
 . . S X=""
 . . I $G(LRORDRR)="R" I +$G(LRRSITE("RSITE")) D  ;
 . . . S X=+LRRSITE("RSITE")_";DIC(4,"
 . . I $G(LRORDRR)'="R" I $G(LROLLOC) D  ;
 . . . S X=LROLLOC_";SC("
 . . Q:X=""
 . . D MAKEFDA(.111,X)
 . ;
 . I FLD=.112 I "CHMI"[LRSS  D  Q  ;
 . . S X=$G(LRDUZ(2))
 . . I X="" S X=$G(DUZ(2))
 . . D MAKEFDA(.112,X)
 . ;
 . ;
 . I LRSS="CH" D  Q  ;
 . . I FLD=.07 Q 
 . . I FLD=.1 D MAKEFDA(.1,LRPRAC)
 . . I FLD=.11 D MAKEFDA(.11,LRLLOC)
 . ;
 . I "MICYSPEMBB"[LRSS D  Q  ;
 . . I FLD=.07 D MAKEFDA(.07,LRPRAC)
 . . I FLD=.08 D MAKEFDA(.08,LRLLOC)
 . . I FLD=.1 D MAKEFDA(.1,LRNT)
 . ;
 ;
 I $G(LRORU3)'="" I "CHMISPCYEM"[LRSS D  ;
 . D MAKEFDA(.31,$P(LRORU3,U))
 . D MAKEFDA(.32,$P(LRORU3,U,2))
 . D MAKEFDA(.33,$P(LRORU3,U,3))
 . D MAKEFDA(.34,$P(LRORU3,U,4))
 . D MAKEFDA(.342,$P(LRORU3,U,5))
 ;
 I $D(LRFDA(63)) D FILE^DIE("","LRFDA(63)","LRMSG")
 ;
 Q
 ;
MAKEFDA(FLD,VAL) ;
 ; Adds entries to the LRFDA array.
 ; Helper method for SLRSS method.
 ; (Private method)
 ; Requires LRFILE,LRIEN,DATA variables in symbol table
 ; Inputs
 ;   FLD : Field #
 ;   VAL : Value
 ;
 Q:$G(DATA(FLD,"I"))'=""
 Q:VAL=""
 S LRFDA(63,LRFILE,LRIEN,FLD)=VAL
 Q
 ;
SLRSSOLD ;
 Q
 ; For legacy documentation only
 ; This is the code that was in SLRSS^LRWLST11
 ;S FDAIEN(1)=LRIDT
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.01)=LRCDT
 ;S:"CYSPEM"'[LRSS FDA(63,LRX,LRIDT_","_LRDFN_",",.02)=LREAL
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.05)=$P(H8,U)
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.06)=$P(H8,U,2)
 ;I "MICYSPEMBB"[LRSS S FDA(63,LRX,LRIDT_","_LRDFN_",",.07)=LRPRAC
 ;I LRSS="CH" S FDA(63,LRX,LRIDT_","_LRDFN_",",.07)=$P(H8,U,3)
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.08)=$P(H8,U,4)
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.09)=$P(H8,U,5)
 ;I LRSS="CH" S FDA(63,LRX,LRIDT_","_LRDFN_",",.1)=LRPRAC
 ;I "MICYSPEMBB"[LRSS S FDA(63,LRX,LRIDT_","_LRDFN_",",.1)=LRNT
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.055)=$P(H8,U,7)
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.2)=$P(H8,U,8)
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.111)=$P(H8,U,9)
 ;S FDA(63,LRX,LRIDT_","_LRDFN_",",.112)=$P(H8,U,10)
 ;I $G(LRORU3)'="" D
 ;.S FDA(63,LRX,LRIDT_","_LRDFN_",",.31)=$P(LRORU3,U)
 ;.S FDA(63,LRX,LRIDT_","_LRDFN_",",.32)=$P(LRORU3,U,2)
 ;.S FDA(63,LRX,LRIDT_","_LRDFN_",",.33)=$P(LRORU3,U,3)
 ;.S FDA(63,LRX,LRIDT_","_LRDFN_",",.34)=$P(LRORU3,U,4)
 ;.S FDA(63,LRX,LRIDT_","_LRDFN_",",.342)=$P(LRORU3,U,5)
 ;I LRX D FILE^DIE("","FDA(63)","LRDIE(63)")
 Q
