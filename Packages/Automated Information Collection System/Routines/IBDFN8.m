IBDFN8 ;ALB/CJM - ENCOUNTER FORM - PCE GDI INPUT TRANSFORMS ;08/10/95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25,38,51,63**;APR 24, 1997;Build 80
 ;
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
INPUTICD(ICD) ;changes X, an ICD-9 code, into its ien
 ;
 ;S ICD=$$UPP(ICD)
 ;S X=$O(^ICD9("BA",ICD_" ",0)) I 'X K X Q
 ;;K:'X X
 ;
 ;(CSV) status 0-inactive 1-active
 ;I $P($$ICDDX^ICDCODE(X),U,10)'=1 K X
 N IBDCODE,IBDSTAT
 I $G(ICD)="" K X Q
 S IBDCODE=$$ICDDATA^ICDXCODE("ICD9",ICD,DT) S X=$P(IBDCODE,U) I 'X!(X<1) K X Q
 S IBDSTAT=$P(IBDCODE,U,10) I IBDSTAT'=1 K X
 Q
INPICD10(ICD) ;changes X, an ICD-10 code, into its ien
 ;-- does X point to a valid ICD-10 code? Kills X if not.
 ; -- input the icd code in X
 ;
 N IBDCODE,IBDSTAT
 I $G(ICD)="" K X Q
 S IBDCODE=$$ICDDATA^ICDXCODE("10D",ICD,DT) S X=$P(IBDCODE,U) I 'X!(X<1) K X Q
 S IBDSTAT=$P(IBDCODE,U,10) I IBDSTAT'=1 K X
 Q
 ;
UPP(X) ; -- convert lower case to upper case (especially when in codes above)
 Q $TR(X,"zxcvbnmlkjhgfdsaqwertyuiop","ZXCVBNMLKJHGFDSAQWERTYUIOP")
