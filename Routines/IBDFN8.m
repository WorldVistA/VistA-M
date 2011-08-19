IBDFN8 ;ALB/CJM - ENCOUNTER FORM - PCE GDI INPUT TRANSFORMS;AUG 10, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25,38,51**;APR 24, 1997
 ;
INPUTCPT(X) ;changes X,a CPT code, into its ien
 ;
 ;   --input: cpt code
 ;   
 ;   --output: ien of cpt code (file #81)
 ;
 S X=$$UPP(X)
 ;;S X=+$$CPT^ICPTCOD(X)
 S X=$$CPT^ICPTCOD(X)
 I +X=-1 K X Q
 I $P(X,U,7)'=1 K X ;(CSV) status 0-inactive 1-active
 Q
 ;
INPUTICD(ICD) ;changes X, an ICD9 code, into its ien
 ;
 S ICD=$$UPP(ICD)
 S X=$O(^ICD9("BA",ICD_" ",0)) I 'X K X Q
 ;;K:'X X
 ;
 ;(CSV) status 0-inactive 1-active
 I $P($$ICDDX^ICDCODE(X),U,10)'=1 K X
 Q
 ;
UPP(X) ; -- convert lower case to upper case (especially when in codes above)
 Q $TR(X,"zxcvbnmlkjhgfdsaqwertyuiop","ZXCVBNMLKJHGFDSAQWERTYUIOP")
