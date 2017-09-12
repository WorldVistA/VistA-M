ETSLNCIX ;O-OIFO/FM23 - ETS LOINC Set/Kill Index Utilities ;01/31/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SETLNC(ETSTEXT,ETSIEN) ; Set Long Common Name (129.1, #83) word index node D
 ;Standard Indexing input checks
 Q:'$D(ETSTEXT)!('$D(ETSIEN))
 ;
 ;New and initialize variables
 N ETSWORD,ETSLP,ETSLN
 ;
 ;Format the text string for parsing and indexing
 S ETSTEXT=$$PREPTEXT(ETSTEXT)
 S ETSLN=$L(ETSTEXT," ")
 ;
 ;Parse and index the text string
 F ETSLP=1:1:ETSLN D
 . S ETSWORD=$P(ETSTEXT," ",ETSLP)
 . Q:ETSWORD=""
 . S:'$D(^ETSLNC(129.1,"D",ETSWORD,ETSIEN)) ^ETSLNC(129.1,"D",ETSWORD,ETSIEN)=""
 ;
 ;Exit the indexing
 Q
 ;
KILLLNC(ETSTEXT,ETSIEN) ; Set Long Common Name (129.1, #83) word index node AWRD
 ;Standard Indexing input checks
 Q:'$D(ETSTEXT)!('$D(ETSIEN))
 ;
 ;New and initialize variables
 N ETSWORD,ETSLP,ETSLN
 ;
 ;Format the text string for parsing and indexing
 S ETSTEXT=$$PREPTEXT(ETSTEXT)
 S ETSLN=$L(ETSTEXT," ")
 ;
 ;Parse and remove the string from the index
 F ETSLP=1:1:ETSLN D
 . S ETSWORD=$P(ETSTEXT," ",ETSLP)
 . Q:ETSWORD=""
 . K:$D(^ETSLNC(129.1,"D",ETSWORD,ETSIEN)) ^ETSLNC(129.1,"D",ETSWORD,ETSIEN)
 ;
 Q
 ;
PREPTEXT(ETSTEXT) ;Prepare the Text for Indexing by
 ;  - excluding certain words (a, the, in, etc.)
 ;  - stop indexing when the [ or words IN, BY, or ON are reached
 ;  - strip terms that are punctuation only
 ;
 N ETSCT,ETSLP,ETSTERM,ETSNTEXT,ETSRM,ETSFLG,ETSWORD
 ;
 ;Note: ETSTEXT already validated as existing before 
 ;      coming to PREPTEXT
 ;
 ;Upper case the text string to check
 S ETSTEXT=$$UP^XLFSTR(ETSTEXT)
 ;
 S ETSCT=$L(ETSTEXT," ")
 ;
 ; Identify terms to remove
 S ETSFLG=0
 F ETSLP=1:1:ETSCT D  Q:ETSFLG
 . S ETSTERM=$P(ETSTEXT," ",ETSLP)
 . Q:ETSTERM=""
 . ;flag punctuation remove all punctuation
 . I ETSTERM?1.P S ETSRM(ETSLP)="" Q
 . ;flag excluded terms for removal
 . I $$EXCLUDED(ETSTERM) S ETSRM(ETSLP)="" Q
 . ;if term a stop term, set stop flag, reset text string and exit
 . I $E(ETSTERM,1)="[" S ETSFLG=1,ETSTEXT=$P(ETSTEXT," ",1,ETSLP-1) Q
 . I ETSTERM="BY" S ETSFLG=1,ETSTEXT=$P(ETSTEXT," ",1,ETSLP-1) Q
 . I ETSTERM="IN" S ETSFLG=1,ETSTEXT=$P(ETSTEXT," ",1,ETSLP-1) Q
 . I ETSTERM="ON" S ETSFLG=1,ETSTEXT=$P(ETSTEXT," ",1,ETSLP-1)
 ;
 ; Create text string with terms removed
 S ETSNTEXT=""
 ;
 ; Reset the Text Length Counter
 S ETSCT=$L(ETSTEXT," ")
 F ETSLP=1:1:ETSCT D
 . ;Add term to new string if not identified for removal
 . Q:$D(ETSRM(ETSLP))
 . S ETSWORD=$P(ETSTEXT," ",ETSLP)
 . Q:ETSWORD=""
 . S ETSNTEXT=ETSNTEXT_ETSWORD
 . ;Add space if not the last term in the text string
 . I ETSLP'=ETSCT S ETSNTEXT=ETSNTEXT_" "
 ;
 ; clean up string if last term was ignored or NULL
 S:$P(ETSNTEXT," ",$L(ETSNTEXT," "))="" ETSNTEXT=$P(ETSNTEXT," ",1,$L(ETSNTEXT," ")-1)
 ;
 ; Exit with new string
 Q ETSNTEXT
 ;
EXCLUDED(ETSTERM) ;Exclude certain terms
 ;
 ;If in Excluded Words - LOINC dictionary (129.4)
 ; then return true
 Q:$D(^ETSLNC(129.14,"B",ETSTERM)) 1
 ;
 ;else return false
 Q 0
 ;
