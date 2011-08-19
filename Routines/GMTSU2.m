GMTSU2 ; SLC/KER - Health Summary Utilities ; 08/27/2002
 ;;2.7;Health Summary;**29,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10035  ^DPT(  file #2
 ;   DBIA 10060  ^VA(200,
 ;   DBIA 10090  ^DIC(4,
 ;   DBIA  2056  $$GET1^DIQ  (file #200, 2 and 4)
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10112  $$SITE^VASITE
 ;   DBIA 10112  $$NAME^VASITE
 ;   DBIA  2541  $$KSP^XUPARAM
 ;   DBIA 10104  $$UP^XLFSTR
 ;                    
 Q
 ; User
USER(X) ;   Is a user (1 yes 0 no)     0;1
 N GMTS Q:+($G(X))=0 "" S GMTS=$$UNAM(+($G(X))),X=$S($L(GMTS)>0:1,1:0) Q X
UACT(X) ;   Active User (1 active)     0;11
 N GMTS,GMTSN Q:+($G(X))=0 0 S GMTS=$$USER(+($G(X))) Q:+GMTS=0 0
 S GMTS=+($$GET1^DIQ(200,+($G(X)),9.2,"I")) S GMTSN=$$NOW^XLFDT Q:GMTS>0&(GMTS<GMTSN) 0 Q 1
UNAM(X) ;   User Name                  0;1
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.01)
UHPH(X) ;   Home Phone               .13;1
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.132)
UOPH(X) ;   Office Phone             .13;2
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.132)
UPH3(X) ;   Phone Number #3          .13;3
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.133)
UPH4(X) ;   Phone Number #4          .13;4
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.134)
UCPH(X) ;   Commercial Phone         .13;5
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.135)
UFAX(X) ;   Fax Number               .13;6
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.136)
UAPG(X) ;   Analog Pager             .13;7
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.137)
UDPG(X) ;   Digital Pager            .13;8
 Q:+($G(X))=0 "" Q $$GET1^DIQ(200,+($G(X)),.138)
 ;                    
 ; Patient
PAT(X) ;   Is a patient (1 yes 0 no)  0;1
 N GMTS Q:+($G(X))=0 "" S GMTS=$$PNAM(+($G(X))),X=$S($L(GMTS)>0:1,1:0) Q X
PNAM(X) ;   Patient Name               0;1
 Q:+($G(X))=0 "" Q $$GET1^DIQ(2,+($G(X)),.01)
PMAR(X) ;   Patient Marital Status     0;5
 Q:+($G(X))=0 "" Q $$GET1^DIQ(2,+($G(X)),.05)
PWAR(X) ;   Patient has a Ward Location
 N GMTS Q:+($G(X))=0 "" S GMTS=PWLC(X),X=$S($L(GMTS):1,1:0) Q X
PWLC(X) ;   Ward Location
 Q:+($G(X))=0 "" Q $$GET1^DIQ(2,+($G(X)),.1)
PDIS(X,ARY) ;   Rated Disabilties       .372;0
 Q:+($G(X))=0 "" N GMTSI,GMTSC,GMTSR,GMTSD,GMTSS S (GMTSC,GMTSI)=0 F  S GMTSI=$O(^DPT(+($G(X)),.372,GMTSI)) Q:+GMTSI=0  D
 . S GMTSR=$$GET1^DIQ(2.04,(GMTSI_","_+($G(X))_","),.01),GMTSD=$$GET1^DIQ(2.04,(GMTSI_","_+($G(X))_","),2),GMTSS=$$GET1^DIQ(2.04,(GMTSI_","_+($G(X))_","),3),GMTSC=GMTSC+1,ARY(GMTSC)=GMTSR_"^"_GMTSD_"^"_GMTSS
 S X=+($G(GMTSC)) S:X>0 ARY(0)=X,ARY="Rated Disabilities (VA)^Disability Percent^Service Connected" Q X
PLAB(X) ;   Lab Patient               LR;1
 Q:+($G(X))=0 "" Q $$GET1^DIQ(2,+($G(X)),63)
 ;                    
 ; Health Summary
MSIT(X) ; Mix Case Site
 Q $$EN^GMTSUMX($$SITE)
SITE(X) ; Site
 N SITE,INTG,PRIM S U="^",X="" S SITE=$$KSP^XUPARAM("INST"),SITE=$$UP^XLFSTR($$GET1^DIQ(4,+($G(SITE)),.01)),INTG=$$UP^XLFSTR($$NAME^VASITE($$NOW^XLFDT)),PRIM=$$UP^XLFSTR($P($$SITE^VASITE($$NOW^XLFDT),"^",2))
 S:$L(SITE)&(PRIM=SITE) PRIM="" S:'$L(SITE)&($L(PRIM)) SITE=PRIM,PRIM="" I $L(SITE) S X=SITE S:$L(INTG)&(INTG'=SITE) X=INTG_" ("_SITE_")"
 S:'$L(SITE)&($L(INTG)) X=INTG
 Q X
TSIT(X) ; Site
 N SITE S U="^",X=""
 S SITE=$$KSP^XUPARAM("INST"),SITE=$$UP^XLFSTR($$GET1^DIQ(4,+($G(SITE)),.01))
 S X=SITE Q X
