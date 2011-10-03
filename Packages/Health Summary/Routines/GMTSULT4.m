GMTSULT4 ; SLC/KER - HS Type Lookup (Array)         ; 08/27/2002
 ;;2.7;Health Summary;**30,32,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  2056  $$GET1^DIQ  (file #200)
 ;   DBIA 10040  ^SC(  file #44
 ;                   
 Q
NT ; In Name/Title Array
 Q:$D(GMTSINPT)  Q:+GMTSWDS'>0  K GMTSLT D CMN
 S GMTSFND=0,GMTSLT("W")=+($G(GMTSWDS))
 N GMTSNT F GMTSI=1:1:GMTSWDS D
 . Q:'$L(GMTSWRDS(GMTSI))
 . S GMTSNT=+($$CHKW(GMTSWRDS(GMTSI)))
 . S:GMTSNT GMTSFND=GMTSFND+1,GMTSLT(GMTSI1)=(+($G(GMTSLT(GMTSI1)))+1)
 I GMTSFND>0,GMTSFND=GMTSWDS,'$D(GMTSLT(GMTSI1)) S GMTSLT(0)=+($G(GMTSLT(0)))+1
 ; Reorder
 S GMTSFND=0 F  S GMTSFND=$O(GMTSLT(GMTSFND)) Q:+GMTSFND=0  D
 . S:+($G(GMTSLT(GMTSFND)))>0&(+($G(GMTSLT(GMTSFND)))=+($G(GMTSLT("W")))) GMTSLT("B",+GMTSFND)=""
 . K:+($G(GMTSLT(GMTSFND)))>0&(+($G(GMTSLT(GMTSFND)))'=+($G(GMTSLT("W")))) GMTSLT(+GMTSFND)
 K GMTSLT("W") K:'$D(GMTSLT("B")) GMTSLT
 S:$D(GMTSLT("B")) GMTSLT("C")=$$MX($P($G(^GMT(142,+($G(GMTSIEN)),0)),"^",1))
 Q
LC ; Location Array  (Needs either GMTSIEN or GMTSI1)
 Q:$D(GMTSINPT)  Q:+GMTSWDS'>0
 I '$D(GMTSI1),$D(GMTSIEN),$D(^GMT(142,+($G(GMTSIEN)),0)) N GMTSI1 S GMTSI1=+($G(GMTSIEN))
 Q:'$D(GMTSI1)
 N GMTSF,GMTSI,GMTSI2,GMTSI3,GMTSL,GMTSLC K GMTSLI
 S GMTSI2=0  F  S GMTSI2=$O(^GMT(142,GMTSI1,20,GMTSI2)) Q:+GMTSI2=0  D
 . S GMTSI3=+($G(^GMT(142,GMTSI1,20,GMTSI2,0)))
 . S GMTSL=$P($G(^SC(+GMTSI3,0)),"^",1)
 . S GMTSF=0 I GMTSWDS>0 S GMTSLI("W")=+($G(GMTSWDS))
 . F GMTSI=1:1:GMTSWDS D
 . . Q:'$L(GMTSWRDS(GMTSI))
 . . S:$$UP(GMTSL)[$$UP(GMTSWRDS(GMTSI)) GMTSF=GMTSF+1
 . I GMTSF=GMTSWDS D
 . . S:'$D(GMTSLI(GMTSI1,GMTSI2)) GMTSLI(0)=+($G(GMTSLI(0)))+1
 . . S GMTSLI(GMTSI2)=GMTSF_"^"_GMTSL
 . . S GMTSLI("I")=GMTSI1
 S GMTSF=0 F  S GMTSF=$O(GMTSLI(GMTSF)) Q:+GMTSF=0  D
 . S:+($G(GMTSLI(GMTSF)))>0&(+($G(GMTSLI(GMTSF)))=+($G(GMTSLI("W")))) GMTSLI("B",+GMTSF)=""
 . K:+($G(GMTSLI(GMTSF)))>0&(+($G(GMTSLI(GMTSF)))'=+($G(GMTSLI("W")))) GMTSLI(+GMTSF)
 K:'$D(GMTSLI("B")) GMTSLI
 I $D(GMTSLI("B"))  D
 . N GMTSI,GMTSC,GMTST,GMTSE S (GMTSE,GMTSC)=0,GMTST=+($G(GMTSLI(0))) Q:GMTST=0
 . S GMTSI="",GMTSF=0 F  S GMTSF=$O(GMTSLI(GMTSF)) Q:GMTSE  Q:+GMTSF=0  D  Q:GMTSE
 . . I ($L($G(GMTSI))+$L($P($G(GMTSLI(GMTSF)),"^",2)))>60 S GMTSI="",GMTSE=1 Q
 . . S GMTSC=GMTSC+1
 . . S:GMTSI'=""&(GMTSC>1)&(GMTSC'=GMTST) GMTSI=GMTSI_", "_$$MX($P(GMTSLI(GMTSF),"^",2))
 . . S:GMTSI'=""&(GMTSC>1)&(GMTSC=GMTST) GMTSI=GMTSI_" and "_$$MX($P(GMTSLI(GMTSF),"^",2))
 . . S:GMTSI="" GMTSI=$$MX($P(GMTSLI(GMTSF),"^",2))
 . S:$L(GMTSI) GMTSLI("C")=GMTSI
 K:'$D(GMTSLI("C")) GMTSLI K GMTSLI("W")
 Q
CHKW(X) ; Check Words
 S X=$$UP($G(X)) Q:'$L(X) 0
 N I,OK S OK=0,I=0 F  S I=$O(GMTSCOMP(I)) Q:+I=0  S:$$UP($G(GMTSCOMP(I)))[X OK=1 Q:OK
 S X=+($G(OK)) Q X
 ;                             
CM ; Composite Array 
 K GMTSCOMP S GMTSIEN=+($G(GMTSIEN)) G:GMTSIEN=0 CMQ
 N GMTSWL,GMTSL,GMTS2
 D:$D(GMTSNAM) CMP($$UP($$UP(GMTSNAM))) D:'$D(GMTSNAM) CMP($$UP($P($G(^GMT(142,+GMTSIEN,0)),"^",1)))
 D:$D(GMTSTTL) CMP($$UP($G(GMTSTTL))) D:'$D(GMTSTTL) CMP($$UP($P($G(^GMT(142,+GMTSIEN,"T")),"^",1)))
 D:$D(GMTSOW) CMP($$UP($G(GMTSOW)))
 I '$D(GMTSOW),+($P($G(^GMT(142,+GMTSIEN,0)),"^",3))>1 D CMP($$UP($$GET1^DIQ(200,(+($P($G(^GMT(142,+GMTSIEN,0)),"^",3))_","),.01)))
 G:$D(GMTSNO) CMQ
 S GMTS2=0  F  S GMTS2=$O(^GMT(142,GMTSIEN,20,GMTS2)) Q:+GMTS2=0  D
 . S GMTSL=+($G(^GMT(142,GMTSIEN,20,GMTS2,0)))
 . S GMTSL=$P($G(^SC(+GMTSL,0)),"^",1) D CMP($$UP(GMTSL))
CMQ ;   Composite Array Quit
 D CMC Q
CMA ;   Composite Array (name only)
 N GMTSNO D CM Q
CMN ;   Composite Array (name only)
 N GMTSNO S GMTSNO="" D CM Q
CMP(X) ;   Composite Array Word Parse
 N GMTSX,GMTSP,GMTSC,GMTSW S GMTSX=$G(X) Q:'$L(GMTSX)
 S GMTSC=1 F GMTSP=1:1:$L(GMTSX)+1 D
 . S GMTSW=$E(GMTSX,GMTSP) I "(,.?! '-/&:;)"[GMTSW D
 . . S GMTSW=$E($E(GMTSX,GMTSC,GMTSP-1),1,30),GMTSC=GMTSP+1 I $L(GMTSW)>0 D
 . . . S:$L(GMTSW) GMTSWL(GMTSW)=""
 Q
CMC ;   Composite Array Compile
 S GMTSCOMP("B")="" N GMTSW,GMTSLI S GMTSW=""
 F  S GMTSW=$O(GMTSWL(GMTSW)) Q:GMTSW=""  D
 . I $L(GMTSCOMP("B")_" "_GMTSW)>200 D CMCA S GMTSCOMP("B")=GMTSCOMP("B")_" "_$$UP(GMTSW) K GMTSWL(GMTSW) Q
 . S GMTSCOMP("B")=GMTSCOMP("B")_" "_$$UP(GMTSW) K GMTSWL(GMTSW) Q
 F  Q:$E(GMTSCOMP("B"),1)'=" "  S GMTSCOMP("B")=$E(GMTSCOMP("B"),2,$L(GMTSCOMP("B")))
 S GMTSLI=+($O(GMTSCOMP(" "),-1)) I $D(GMTSCOMP("B")) S GMTSCOMP((GMTSLI+1))=GMTSCOMP("B") K GMTSCOMP("B")
 Q
CMCA ;   Composite Array Compile (Add String)
 N I S I=+($O(GMTSCOMP(" "),-1))+1 S GMTSCOMP(I)=GMTSCOMP("B"),GMTSCOMP("B")=""
 F  Q:$E(GMTSCOMP(I),1)'=" "  S GMTSCOMP(I)=$E(GMTSCOMP(I),2,$L(GMTSCOMP(I)))
 Q
 ;                                   
RDT ;   Recommended Display Text
 ;     Name (used by Location)
 I GMTSKEY["LOC" D
 . Q:'$L(GMTS5)
 . S:$$UP(GMTS2)'=$$UP(GMTS5) GMTSG=GMTSMN_" (used by "_GMTSLOC
 . S:$$UP(GMTSMN)=$$UP(GMTSLOC) GMTSG=GMTSMN
 ;     Name (Title)
 I GMTSKEY["TITL",GMTSKEY'["OWN" D
 . Q:'$L(GMTS3)
 . I $$UP(GMTS3)=$$UP(GMTS2) S GMTSG=GMTS2 Q
 . S:GMTSKEY["TITL"&($$UP(GMTSMN)'=$$UP(GMTSL)) GMTSG=GMTSMN_" ("_$$MX(GMTS3)_")"
 . S:GMTSKEY["TITL"&($$UP(GMTSMN)=$$UP(GMTSL)) GMTSG=GMTSMN
 I GMTSKEY["TITL",GMTSKEY["OWN" D
 . Q:'$L(GMTS3)
 . ;     Name (Title, Owner) if Title'=Name and Owner
 . S:$$UP(GMTSMN)'=$$UP(GMTS3)&($L(GMTS4)) GMTSG=GMTSMN_" ("_$$MX(GMTS3)_", HS Owner "_$$OW(GMTSOW)
 . ;     Name (Title) if Title'=Name and no Owner
 . S:$$UP(GMTSMN)'=$$UP(GMTS3)&('$L(GMTS4)) GMTSG=GMTSMN_" ("_$$MX(GMTSTTL)
 . ;     Name (Owner) if Title=Name and Owner
 . S:$$UP(GMTSMN)=$$UP(GMTS3)&($L(GMTS4)) GMTSG=GMTSMN_" (HS Owner "_$$OW(GMTSOW)
 . S:$$UP(GMTSMN)=$$UP(GMTS3)&('$L(GMTS4)) GMTSG=GMTSMN
 ;                      
 ;   Assemble string and store in TMP Global
 ;      IEN^Name^Title^Owner^Location^Components^Display Text
 S:$L(GMTSG)&(GMTSG'[")")&(GMTSG'["(")&(+GMTS6=0)&($L(GMTS6)) GMTSG=GMTSG_" ("_GMTS6_")" S GMTS7=GMTSG
 S ^TMP("GMTSULT",$J,GMTSI)=GMTS1_U_GMTS2_U_GMTS3_U_GMTS4_U_GMTS5_U_GMTS6_U_GMTS7
 S ^TMP("GMTSULT",$J,0)=GMTSI
 Q
 ;                      
 ; Miscellaneous
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
OW(X) ;   Mix Case (owner name)
 Q:$G(X)'["," $$EN^GMTSUMX($G(X))
 Q $$EN^GMTSUMX(($P($G(X),",",1)_", "_$P($G(X),",",2)))
MX(X) ;   Mix Case
 Q $$EN^GMTSUMX(X)
