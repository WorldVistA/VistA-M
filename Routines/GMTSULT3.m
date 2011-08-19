GMTSULT3 ; SLC/KER - HS Type Lookup (Save)          ; 08/27/2002
 ;;2.7;Health Summary;**30,32,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  2056  $$GET1^DIQ  (file #200)
 ;                     
 Q
SM ; Save match
 ;                      
 ;   GMTSIEN    Type Internal Entry Number
 ;   GMTSKWRD   Keyword from AW index
 ;   GMTSWRDS   Parsed word array
 ;   GMTSEO     Exact Match (One)      OE
 ;   GMTSEQ     Exact Match Required   X
 ;   GMTSIF     Interal Entry Number   N
 ;                      
 S GMTSIEN=+($G(GMTSIEN)),GMTSKWRD=$G(GMTSKWRD),GMTSEO=+($G(GMTSEO)),GMTSEQ=+($G(GMTSEQ)),GMTSIF=+($G(GMTSIF)),U="^"
 N GMTSCOMP,GMTSCF,GMTSWRD,GMTSWDS,GMTSEQ,GMTSLOK,GMTSOK,GMTSLT,GMTSLI,GMTSASM,GMTSI1,GMTSI2,GMTSI3,GMTSNAM,GMTSTTL,GMTSOW,GMTSLOC,GMTSCMP,GMTSRC
 S (GMTSNAM,GMTSTTL,GMTSOW,GMTSLOC,GMTSCMP,GMTSRC)="",GMTSLOK=0,GMTSRC="Name",GMTSWRD=$G(GMTSWRDS(1)),GMTSWDS=+($O(GMTSWRDS(" "),-1))
 ; Get Internal Entry Number (IEN)
 S GMTSI1=+($G(GMTSIEN)) Q:'$D(^GMT(142,GMTSI1,0))
 ; Check Screen - DIC("S")
 S GMTSOK=1 I $L($G(GMTSDICS)) S GMTSOK=$$DICS^GMTSULT2(GMTSDICS,X,GMTSI1) Q:'GMTSOK
 ; Get Health Summary Type
 ;   Components
 S GMTSCMP=$$CM^GMTSULT2(+GMTSI1)
 ;   Name
 S GMTSNAM=$P($G(^GMT(142,+GMTSI1,0)),U,1)
 ;   Title
 S GMTSTTL=$P($G(^GMT(142,+GMTSI1,"T")),U,1)
 S:$L(GMTSTTL) GMTSRC="Title"
 ;   Owner
 S GMTSOW=+($P($G(^GMT(142,+GMTSI1,0)),U,3)) S:GMTSOW<1 GMTSOW=""
 S:+GMTSOW>0 GMTSOW=$$GET1^DIQ(200,(+GMTSOW_","),.01)
 I $L($G(GMTSKWRD)) S:$L(GMTSOW)&(GMTSOW[GMTSKWRD) GMTSRC="Title/Owner"
 ;   Name/Title
 D NT^GMTSULT4
 ;   Location
 D LC^GMTSULT4
 S:'$L($G(GMTSLT("C")))&($L($G(GMTSLI("C")))) GMTSLOC=$G(GMTSLI("C"))
 ; Get Composite String
 D CMA^GMTSULT4
 ; Find words in string
 S (GMTSCF,GMTSFND)=0 I GMTSWDS>0 F GMTSI=1:1:GMTSWDS D
 . Q:'$L(GMTSWRDS(GMTSI))
 . S GMTSCF=+($$CHKW^GMTSULT4(GMTSWRDS(GMTSI)))
 . S:GMTSCF GMTSFND=GMTSFND+1
 . S:$L(GMTSOW)&(GMTSOW[$$UP^GMTSULT2(GMTSWRDS(GMTSI))) GMTSRC="Title/Owner"
 ;
 ; If input is not an Internal Entry Number    +GMTSIF=0
 ; and not all of the words were found          GMTSFND'=GMTSWDS
 ; then quit
 ;
 Q:'(+($G(GMTSIF)))&(GMTSFND'=GMTSWDS)
 ;                      
 ; Save Health Summary Type
 ;   Exact match only        DIC(0)["O" & DIC(0)["E"
 I '(+($G(GMTSIF))),+($G(GMTSEO)),($$UP^GMTSULT2(GMTSNAM)'=$$UP^GMTSULT2(X)&($$UP^GMTSULT2(GMTSLOC)'=$$UP^GMTSULT2(X))) Q
 S:$L(GMTSLOC) GMTSRC="Location"
 ;   Quit if Health Summary is already saved
 Q:$D(^TMP("GMTSULT2",$J,"IEN",+GMTSI1))&(+($G(^TMP("GMTSULT2",$J,"EM")))'=+GMTSI1)
 ;                      
 ;   Assemble string and store in TMP Global
 ;      IEN^Name^Title^Owner^Location^Components^Source
 S GMTSC=+($O(^TMP("GMTSULT2",$J," "),-1))+1
 S GMTSASM=GMTSI1_U_GMTSNAM_U_GMTSTTL_U_GMTSOW_U_GMTSLOC_U_GMTSCMP_U_GMTSRC
 S ^TMP("GMTSULT2",$J,"IEN",+GMTSI1)="",^TMP("GMTSULT2",$J,GMTSC)=GMTSASM,^TMP("GMTSULT2",$J,"B",(GMTSNAM_" "),GMTSC)=""
 S:+($G(^TMP("GMTSULT2",$J,"EM")))=GMTSI1 ^TMP("GMTSULT2",$J,"EMI")=GMTSC,^TMP("GMTSULT2",$J,"EMB")=GMTSNAM_" "
 Q
 ;                      
REO ; Reorder List
 S GMTSEO=+($G(GMTSEO)),GMTSEQ=+($G(GMTSEQ)),GMTSIF=+($G(GMTSIF))
 N GMTSC,GMTSFND,GMTSG,GMTSI,GMTSIEN,GMTSKEY,GMTSL,GMTSCMP,GMTSOW,GMTSTTL,GMTSLOC,GMTSMN,GMTSNM
 S GMTSI=0,GMTSFND=""
 ;   Add exact match to the top of the selection list
 I '$D(^TMP("GMTSULT2",$J,"E")),+($G(GMTSEO)) K ^TMP("GMTSULT2",$J)
 I $D(^TMP("GMTSULT2",$J,"E")) D
 . S GMTSI=0,GMTSC="E" D ADD
 . S ^TMP("GMTSULT",$J,0)=GMTSI
 . K ^TMP("GMTSULT2",$J,"E")
 . ;   Kill global (quit) if Exact Match is found
 . ;     and DIR(0) either contains OE or X
 . K:+($G(GMTSEQ)) ^TMP("GMTSULT2",$J) K:+($G(GMTSEO)) ^TMP("GMTSULT2",$J)
 ;   Kill global (quit) if Exact Match is not
 ;     found and DIR(0)["OE"
 I '$D(^TMP("GMTSULT2",$J,"E")),+($G(GMTSEO)) K ^TMP("GMTSULT2",$J)
 ;   Add remaining entries in Alphabetical Order
 F  S GMTSFND=$O(^TMP("GMTSULT2",$J,"B",GMTSFND)) Q:GMTSFND=""  D
 . S GMTSC=0 F  S GMTSC=$O(^TMP("GMTSULT2",$J,"B",GMTSFND,GMTSC)) Q:+GMTSC=0  D
 . . D ADD
 D CLEAN^GMTSULT
 Q
 ;                      
ADD ; Add to list in appropriate order
 N GMTS0,GMTS1,GMTS2,GMTS3,GMTS4,GMTS5,GMTS6,GMTS7
 S GMTSI=+($G(GMTSI))+1,GMTS0=$G(^TMP("GMTSULT2",$J,GMTSC))
 ;                      
 ;   Piece    Data Element
 ;                      
 ;     1      Internal Entry Number
 S (GMTS1,GMTSIEN)=+($P(GMTS0,U,1))
 ;     2      Health Summary Name
 S (GMTSG,GMTSMN,GMTS2)=$$MX^GMTSULT2($P(GMTS0,U,2))
 S GMTSNM=$$UP^GMTSULT2(GMTSMN)
 ;     3      Health Summary Title
 S (GMTS3,GMTSTTL)=$$MX^GMTSULT2($P(GMTS0,U,3)),GMTSTTL=GMTSTTL_")"
 ;     4      Health Summary Owner
 S (GMTS4,GMTSOW)=$$MX^GMTSULT2($P(GMTS0,U,4)),GMTSOW=GMTSOW_")"
 ;     5      Health Summary Location
 S (GMTS5,GMTSLOC)=$$MX^GMTSULT2($P(GMTS0,U,5)),GMTSLOC=GMTSLOC_")"
 ;     6      Health Summary Components
 S (GMTS6,GMTSCMP)=$P(GMTS0,U,6)
 S GMTSL=$P(GMTS0,U,4)
 ;     7      Recommended Display Text
 S GMTSKEY=$$UP^GMTSULT2($P(GMTS0,U,7))
 ;                      
 ;   Recommended Display Text
 D RDT^GMTSULT4
 ;                      
 ;   Assemble string and store in TMP Global
 ;      IEN^Name^Title^Owner^Location^Components^Display Text
 S:$L(GMTSG)&(GMTSG'[")")&(GMTSG'["(")&(+GMTS6=0)&($L(GMTS6)) GMTSG=GMTSG_" ("_GMTS6_")" S GMTS7=GMTSG
 S ^TMP("GMTSULT",$J,GMTSI)=GMTS1_U_GMTS2_U_GMTS3_U_GMTS4_U_GMTS5_U_GMTS6_U_GMTS7
 S ^TMP("GMTSULT",$J,0)=GMTSI
 Q
