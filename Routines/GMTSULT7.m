GMTSULT7 ; SLC/KER - HS Type Lookup ("B" index)     ; 09/21/2001
 ;;2.7;Health Summary;**30,47**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10060  ^VA(200
 ;                      
 Q
B ; Search "B" Index
 ;                      
 ;   Needs GMTSEQ and GMTSEO
 ;                      
 ;     GMTSEQ=1 Exact match reqired
 ;              Stop search if found
 ;              Continue partial-exact search if not found
 ;                      
 ;     GMTSEO=1 Exact match, only one entry
 ;              Stop search if found and return single entry
 ;              Do not continue if not found
 ;                      
 D CLR^GMTSULT S X=$G(X) Q:'$L(X)  N GMTSKL1,GMTSKL2,GMTSIV,GMTSIEN,GMTSDS,GMTSD0,GMTSDW,GMTSC,GMTSE
 S GMTSKL1=$$LO($E(X,1)),GMTSKL2=$$UP(GMTSKL1),U="^",(GMTSE,GMTSC)=0
 S:$L($G(DIC("S")))&('$L($G(GMTSDICS))) GMTSDICS=$G(DIC("S")),GMTSDS=1
 S:$L($G(DIC(0)))&('$L($G(GMTSDIC0))) GMTSDIC0=$G(DIC(0)),GMTSD0=1
 S:$L($G(DIC("W")))&('$L($G(GMTSDICW))) GMTSDICW=$G(DIC("W")),GMTSDW=1
 D:$G(GMTSDIC0)'["M" CLR^GMTSULT
 S GMTSIV=$C($A(GMTSKL1)-1)_"~" F  S GMTSIV=$O(^GMT(142,"B",GMTSIV)) Q:GMTSIV=""!($E(GMTSIV,1)'=GMTSKL1)  Q:GMTSE  D  Q:GMTSE
 . Q:$$UP($E(X,1,30))'=$$UP($E(GMTSIV,1,$L(X)))  S GMTSIEN=0 F  S GMTSIEN=$O(^GMT(142,"B",GMTSIV,GMTSIEN)) Q:+GMTSIEN=0  Q:GMTSE  D CK  Q:GMTSE
 S GMTSIV=$C($A(GMTSKL2)-1)_"~" F  S GMTSIV=$O(^GMT(142,"B",GMTSIV)) Q:GMTSIV=""!($E(GMTSIV,1)'=GMTSKL2)  Q:GMTSE  D  Q:GMTSE
 . Q:$$UP($E(X,1,30))'=$$UP($E(GMTSIV,1,$L(X)))  S GMTSIEN=0 F  S GMTSIEN=$O(^GMT(142,"B",GMTSIV,GMTSIEN)) Q:+GMTSIEN=0  Q:GMTSE  D CK  Q:GMTSE
BQ ; Quit "B" Index search
 K:+($G(GMTSDS))>0 GMTSDICS K:+($G(GMTSD0))>0 GMTSDIC0 K:+($G(GMTSDW))>0 GMTSDICW
 D REO
 Q
 ;                      
 ; Build list
CK ;   Check Entry
 N GMTSCK,GMTSNM,GMTSTL,GMTSOW,GMTSCMP,GMTSOKS,GMTSDT,GMTSDT2 S GMTSTL=$P($G(^GMT(142,+GMTSIEN,"T")),U,1),GMTSNM=$P($G(^GMT(142,+GMTSIEN,0)),U,1)
 S GMTSDT=GMTSNM S:$$UP(GMTSNM)'=$$UP(GMTSTL)&($L(GMTSTL)) GMTSDT=GMTSNM_" ("_GMTSTL_")"
 S GMTSOW=+($P($G(^GMT(142,+GMTSIEN,0)),U,3)) S:GMTSOW<1 GMTSOW="" S:+GMTSOW>0 GMTSOW=$P($G(^VA(200,+GMTSOW,0)),U,1)
 S GMTSCMP=$$CM^GMTSULT2(GMTSIEN) S:$D(GMTSDICW) GMTSDT=GMTSNM S GMTSDT=$$MX(GMTSDT),GMTSOKS=+($$DICS^GMTSULT2($G(GMTSDICS),GMTSNM,+GMTSIEN)) Q:'GMTSOKS  S GMTSCK="GMTSNM"
 I +($G(GMTSEO)) I $L($G(X))>0,$$UP($G(X))=$$UP($G(GMTSNM)) S GMTSE=1,GMTSCK="GMTSNM" D EA Q
 I $L($G(X))>0,$$UP($G(X))=$$UP($G(GMTSNM)) S GMTSCK="GMTSNM" D EA Q
 D MA Q
MA ;   Add Match
 Q:$D(^TMP("GMTSULT2",$J,"IEN",+GMTSIEN))
 S GMTSC=+($G(GMTSC))+1,^TMP("GMTSULT2",$J,GMTSC)=$$ASM,^TMP("GMTSULT2",$J,0)=GMTSC,^TMP("GMTSULT2",$J,"B",(GMTSNM_" "),GMTSC)=""
 Q
EA ;   Add Exact Match
 S GMTSC=+($G(GMTSC))+1 S GMTSCMP=$$CM^GMTSULT2(GMTSIEN) S ^TMP("GMTSULT2",$J,"EM")=+GMTSIEN,^TMP("GMTSULT2",$J,"IEN",+GMTSIEN)="",^TMP("GMTSULT2",$J,"B",(GMTSNM_" "),GMTSC)="",^TMP("GMTSULT2",$J,"EMI")=GMTSC
 S ^TMP("GMTSULT2",$J,"EMB")=GMTSNM_" ",^TMP("GMTSULT2",$J,GMTSC)=$$ASM,^TMP("GMTSULT2",$J,0)=GMTSC,^TMP("GMTSULT2",$J,"B",(GMTSNM_" "))=""
 Q
ASM(X) ;   Assemble string to store in list
 N GMTST S GMTST=$G(GMTSTL) S:$L($G(GMTSDT))&($G(GMTSDT)'=$G(GMTST)) GMTST=GMTSDT
 S X=+($G(GMTSIEN)),X=X_U_$G(GMTSNM)_U_$G(GMTSTL)_U_$G(GMTSOW)_U_U_$G(GMTSCMP)_U_GMTST
 Q X
 ;                      
REO ; Reorder List
 N GMTSC,GMTSFND,GMTSG,GMTSI,GMTSIEN,GMTSKEY,GMTSL,GMTSCMP,GMTSOW,GMTSTTL,GMTSLOC,GMTSMN,GMTSNM
 S GMTSI=0,GMTSFND=""
 ;   Add exact match to the top of the selection list
 I '$D(^TMP("GMTSULT2",$J,"EMI")),+($G(GMTSEO)) K ^TMP("GMTSULT2",$J)
 I $D(^TMP("GMTSULT2",$J,"EMI")) D
 . S GMTSI=0,GMTSC=$G(^TMP("GMTSULT2",$J,"EMI")) D ADD
 . S ^TMP("GMTSULT",$J,0)=GMTSI K ^TMP("GMTSULT2",$J,"EMI")
 . ;   Kill global (quit) if Exact Match is found
 . ;     and DIR(0) either contains OE or X
 . K:+($G(GMTSEQ)) ^TMP("GMTSULT2",$J) K:+($G(GMTSEO)) ^TMP("GMTSULT2",$J)
 ;   Kill global (quit) if Exact Match is not 
 ;     found and DIR(0)["OE"
 I '$D(^TMP("GMTSULT2",$J,"EMI")),+($G(GMTSEO)) K ^TMP("GMTSULT2",$J)
 ;   Add other entries in Alphabetical Order
 S GMTSFND=0 Q:'$D(^TMP("GMTSULT2",$J,"B"))  F  S GMTSFND=$O(^TMP("GMTSULT2",$J,"B",GMTSFND)) Q:GMTSFND=""  D
 . S GMTSC=0 F  S GMTSC=$O(^TMP("GMTSULT2",$J,"B",GMTSFND,GMTSC)) Q:+GMTSC=0  D ADD
 D CLEAN^GMTSULT
 Q
ADD ;   Add to the reordered list
 N GMTS0,GMTS1,GMTS2,GMTS3,GMTS4,GMTS5,GMTS6,GMTS7
 S GMTSI=+($G(GMTSI))+1,GMTS0=$G(^TMP("GMTSULT2",$J,GMTSC)) S (GMTSG,GMTSMN,GMTS2)=$$MX($P(GMTS0,U,2)) S (GMTS1,GMTSIEN)=+($P(GMTS0,U,1)) S GMTSNM=$$UP(GMTSMN)
 S (GMTS4,GMTSOW)=$$MX($P(GMTS0,U,4)),GMTSOW=GMTSOW_")" S (GMTS3,GMTSTTL)=$$MX($P(GMTS0,U,3)),GMTSTTL=GMTSTTL_")" S (GMTS5,GMTSLOC)=$$MX($P(GMTS0,U,5)),GMTSLOC=GMTSLOC_")"
 S (GMTS6,GMTSCMP)=$P(GMTS0,U,6),GMTSL=$P(GMTS0,U,4),GMTSG=$P(GMTS0,U,7)
 S:$L(GMTSG)&(GMTSG'[")")&(GMTSG'["(")&(+GMTS6=0)&($L(GMTS6)) GMTSG=GMTSG_" ("_GMTS6_")"
 S GMTS7=GMTSG S ^TMP("GMTSULT",$J,GMTSI)=GMTS1_U_GMTS2_U_GMTS3_U_GMTS4_U_GMTS5_U_GMTS6_U_GMTS7
 S ^TMP("GMTSULT",$J,0)=GMTSI
 Q
 ;                  
 ; Miscellaneous
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
LO(X) ;   Lowercase
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
MX(X) ;   Mix Case
 Q $$EN^GMTSUMX(X)
DUP(X) ; Check for Duplicate
 S X=$G(X) Q:'$L(X) 0  N GMTSE,GMTSI S (GMTSE,GMTSI)=0
 F  S GMTSI=$O(^GMT(142,"B",$E(X,1,30),GMTSI)) Q:+GMTSI=0  D  Q:GMTSE
 . S GMTSN=$P($G(^GMT(142,+GMTSI,0)),"^",1) S:$$UP^GMTSULT2(X)=$$UP^GMTSULT2(GMTSN) GMTSE=1
 S X=+($G(GMTSE)) Q X
