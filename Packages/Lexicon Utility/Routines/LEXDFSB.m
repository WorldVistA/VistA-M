LEXDFSB ; ISL Default Filter - Include/Exclude     ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDFSB
 ;
 ; Functions returns the Include/Exclude string for filters
 ; which use the semantic class and types.
 ;
 ; String format:
 ;
 ;     INC/INC/INC/INC/...ETC;EXC/EXC/EXC/EXC/...EXC
 ;
 ;     Where INC is a semantic class or type to include
 ;     in searches, and EXC is a semantic class or type to
 ;     exclude from searches
 ;
 ; LEXC     Counter
 ; LEXI     Include String
 ; LEXE     Exclude String
 ; LEXA     Local array containing include/exclude parameters
 ; LEXX     Include;Exclude string to be returned
 ;
EN(LEXX) ; Create the Semantic Type String
 I +$G(LEXA(0))>0 S LEXX="" D SET K LEXA Q LEXX
 S LEXX=$$EN^LEXDFSI K:LEXX[U LEXA
 I LEXX[U D  Q LEXX
 . S:LEXX["^^" LEXX="^^" Q:LEXX["^^"  S:LEXX[U LEXX="^No filter selected" K LEXA
 I $P(LEXX,U,1)="" S LEXX="^No filter selected" K LEXA Q LEXX
 D:+$G(LEXA(0))>0 SET
 K LEXA Q LEXX
 ;
SET ; Create Semantic Include and Exclude strings from the array
 ;
 Q:+($G(LEXA(0)))=0
 N LEXC,LEXT,LEXI,LEXE S (LEXI,LEXE)=""
 F LEXC=1:1:LEXA(0) D
 . I LEXA(LEXC,2,0)<LEXA(LEXC,1,0)!(LEXA(LEXC,2,0)=0) S LEXI=LEXI_"/"_LEXA(LEXC,0)
 . I LEXA(LEXC,2,0)<LEXA(LEXC,1,0)&(LEXA(LEXC,2,0)'=0) D 
 . . F LEXT=1:1:LEXA(LEXC,2,0) D
 . . . S LEXE=LEXE_"/"_LEXA(LEXC,2,LEXT,0)
 . I LEXA(LEXC,2,0)'<LEXA(LEXC,1,0)&(LEXA(LEXC,2,0)'=0) D 
 . . F LEXT=1:1:LEXA(LEXC,1,0) D
 . . . S LEXI=LEXI_"/"_LEXA(LEXC,1,LEXT,0)
 S:LEXI'["UNK" LEXI=LEXI_"/UNK" S:$E(LEXI,1)="/" LEXI=$E(LEXI,2,$L(LEXI))
 S:$E(LEXE,1)="/" LEXE=$E(LEXE,2,$L(LEXE)) S LEXX=LEXI_";"_LEXE
 K LEXA Q
