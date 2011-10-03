LEXA2 ;ISL/KER-Look-up (Loud) Select ; 02/02/2006
 ;;2.0;LEXICON UTILITY;**38**;Sep 23, 1996
 ;
SELECT ; Select from List
 ; Display Help                 DH^LEXA3
 D DH^LEXA3
 ; Display List                 DL^LEXA3
 D DL^LEXA3
 ; Display Prompt               DP^LEXA3
 D DP^LEXA3
 ; Ask user for selection       ASK^LEXA2
 D ASK
 ; Interpret user response      EN^LEXAR(user response)
 D EN^LEXAR(LEXUR,$G(LEXVDT))
 Q
ASK ; Get users response
 R LEXUR:300 I '$T S LEXUR="^"
 I $L($G(DIC("B"))),LEXUR="" D 
 . S LEXUR=DIC("B") W " ",LEXUR
 . I +($G(LEX))=1,$D(LEX("LIST",1)) D
 . . W "  ",$P(LEX("LIST",1),"^",2) S LEXUR=1
 . I +LEXUR K DIC("B")
 . K DIC("B")
 Q
