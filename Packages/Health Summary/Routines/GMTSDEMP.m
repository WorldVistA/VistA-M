GMTSDEMP ; SLC/DLT,KER - Demographic (Providers)   ; 08/27/2002
 ;;2.7;Health Summary;**55,56**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA 10035  ^DPT( (file #2)
 ;   DBIA  2056  $$GET1^DIQ (file #4, #200 and #404.51)
 ;   DBIA  1252  $$OUTPTTM^SDUTL3
 ;   DBIA  1252  $$OUTPTPR^SDUTL3
 ;   DBIA  1252  $$OUTPTAP^SDUTL3
 ;   DBIA 10103  $$DT^XLFDT
 ;                  
CD(DFN) ; Clinical Demographics (Provider Info)
 Q:$D(GMTSQIT)  N PAT,TEAM,TMPH,PROV,PHN,ANA,DIG,ASSP,PHN,ANA,DIG,IPRO
 N LF,IPPH,IPGA,IPGD,ATTN,ATPH,APGA,APGD S LF=1,(TEAM,PROV,ASSP,IPRO,ATTN)=0
 S (TMPH,PHN,ANA,DIG,PHN,ANA,DIG,IPPH,IPGA,IPGD,ATPH,APGA,APGD)=""
 S:+($G(DT))=0 DT=$$DT^XLFDT
 ;
TEAM ; PCMM TEAM
 S TEAM=$$OUTPTTM^SDUTL3(+($G(DFN)))
 I +($G(TEAM))>0 D  Q:$D(GMTSQIT)
 . N PHN S PHN=$$GET1^DIQ(404.51,(+TEAM_","),.02)
 . D LF Q:$D(GMTSQIT)
 . S TEAM=$E($P($G(TEAM),"^",2),1,31)
 . D:$L(TEAM)!($L(PHN)) WRT^GMTSDEM("PCMM Team",TEAM,"Phone",$G(PHN),1)
 ;
PROV ; PCMM Outpatient Provider
 S PROV=$$OUTPTPR^SDUTL3(+($G(DFN))) I +PROV>0 D  Q:$D(GMTSQIT)
 . N PHN,ANA,DIG Q:'$L($P(PROV,"^",2))  S (PHN,ANA,DIG)=""
 . S PHN=$$GET1^DIQ(200,(+($G(PROV))_","),.132)
 . S ANA=$$GET1^DIQ(200,(+($G(PROV))_","),.137)
 . S DIG=$$GET1^DIQ(200,(+($G(PROV))_","),.138)
 . D LF Q:$D(GMTSQIT)
 . D WRT^GMTSDEM("PCMM Provider",$E($P($G(PROV),"^",2),1,31),"Phone",$G(PHN),1)
 . I $L($G(ANA)) D
 . . D WRT^GMTSDEM("Analog Pager",ANA,$S($L(DIG):"Digital Pager",1:""),$S($L(DIG):DIG,1:""),1)
 . I '$L($G(ANA)),$L($G(DIG)) D
 . . D WRT^GMTSDEM("Digital Pager",DIG,"","",1)
 ;
ASSP ; PCMM Associate Provider
 S ASSP=$$OUTPTAP^SDUTL3(+($G(DFN))) I +ASSP>0&(+ASSP'=+PROV) D
 . N PHN,ANA,DIG S ASSP=+ASSP_"^"_$$GET1^DIQ(200,(+($G(ASSP))_","),.01)
 . Q:'$L($P(ASSP,"^",2))  S (PHN,ANA,DIG)=""
 . S PHN=$$GET1^DIQ(200,(+($G(ASSP))_","),.132),ANA=$$GET1^DIQ(200,(+($G(ASSP))_","),.137),DIG=$$GET1^DIQ(200,(+($G(ASSP))_","),.138)
 . D LF Q:$D(GMTSQIT)  S ASSP=$E($P($G(ASSP),"^",2),1,31)
 . D WRT^GMTSDEM("PCMM Assoc. Prov",ASSP,"Phone",$G(PHN),1)
 . I $L($G(ANA)) D WRT^GMTSDEM("Analog Pager",ANA,$S($L(DIG):"Digital Pager",1:""),$S($L(DIG):DIG,1:""),1)
 . I '$L($G(ANA)),$L($G(DIG)) D WRT^GMTSDEM("Digital Pager",DIG,"","",1)
 ;
IPAT ; Inpatient Provider/Attending
 S ATTN=$G(^DPT(+($G(DFN)),.1041))
 S IPRO=$G(^DPT(+($G(DFN)),.104)) I +IPRO>0 D
 . S IPRO=+IPRO_"^"_$$GET1^DIQ(200,(+($G(IPRO))_","),.01)
 . I '$L($P(IPRO,"^",2)) S IPRO=0,(IPPH,IPGA,IPGD)="" Q
 . S IPPH=$$GET1^DIQ(200,(+($G(IPRO))_","),.132)
 . S IPGA=$$GET1^DIQ(200,(+($G(IPRO))_","),.137)
 . S IPGD=$$GET1^DIQ(200,(+($G(IPRO))_","),.138)
 ;
ONEDOC ;   Inpatient Provider and Attending are the Same
 I +($G(IPRO))=+($G(ATTN)) D  Q:$D(GMTSQIT)
 . Q:$D(GMTSQIT)  I +IPRO>0 D  Q:$D(GMTSQIT)
 . . N PHN,ANA,DIG
 . . S PHN=$$GET1^DIQ(200,(+($G(IPRO))_","),.132)
 . . S ANA=$$GET1^DIQ(200,(+($G(IPRO))_","),.137)
 . . S DIG=$$GET1^DIQ(200,(+($G(IPRO))_","),.138)
 . . D LF Q:$D(GMTSQIT)
 . . D WRT^GMTSDEM("Inpat. Prov/Attn",$E($P($G(IPRO),"^",2),1,31),"Phone",$G(PHN),1) Q:$D(GMTSQIT)
 . . I $L($G(ANA)) D WRT^GMTSDEM("Analog Pager",ANA,$S($L(DIG):"Digital Pager",1:""),$S($L(DIG):DIG,1:""),1) Q:$D(GMTSQIT)
 . . I '$L($G(ANA)),$L($G(DIG)) D WRT^GMTSDEM("Digital Pager",DIG,"","",1) Q:$D(GMTSQIT)
 ;
TWODOCS ;   Inpatient Provider and Attending are Different
 I +($G(IPRO))'=+($G(ATTN)) D  Q:$D(GMTSQIT)
 . I +IPRO>0 D  Q:$D(GMTSQIT)
 . . N PHN,ANA,DIG
 . . S PHN=$$GET1^DIQ(200,(+($G(IPRO))_","),.132)
 . . S ANA=$$GET1^DIQ(200,(+($G(IPRO))_","),.137)
 . . S DIG=$$GET1^DIQ(200,(+($G(IPRO))_","),.138)
 . . D LF Q:$D(GMTSQIT)
 . . D WRT^GMTSDEM("Inpat. Provider",$E($P($G(IPRO),"^",2),1,31),"Phone",$G(PHN),1) Q:$D(GMTSQIT)
 . . I $L($G(ANA)) D WRT^GMTSDEM("Analog Pager",ANA,$S($L(DIG):"Digital Pager",1:""),$S($L(DIG):DIG,1:""),1) Q:$D(GMTSQIT)
 . . I '$L($G(ANA)),$L($G(DIG)) D WRT^GMTSDEM("Digital Pager",DIG,"","",1) Q:$D(GMTSQIT)
 . I +ATTN>0 D  Q:$D(GMTSQIT)
 . . S ATTN=+ATTN_"^"_$$GET1^DIQ(200,(+($G(ATTN))_","),.01)
 . . N PHN,ANA,DIG S (PHN,ANA,DIG)=""
 . . S PHN=$$GET1^DIQ(200,(+($G(ATTN))_","),.132)
 . . S ANA=$$GET1^DIQ(200,(+($G(ATTN))_","),.137)
 . . S DIG=$$GET1^DIQ(200,(+($G(ATTN))_","),.138)
 . . D LF Q:$D(GMTSQIT)
 . . D WRT^GMTSDEM("Inpat. Attending",$E($P($G(ATTN),"^",2),1,31),"Phone",$G(PHN),1) Q:$D(GMTSQIT)
 . . I $L($G(ANA)) D WRT^GMTSDEM("Analog Pager",ANA,$S($L(DIG):"Digital Pager",1:""),$S($L(DIG):DIG,1:""),1) Q:$D(GMTSQIT)
 . . I '$L($G(ANA)),$L($G(DIG)) D WRT^GMTSDEM("Digital Pager",DIG,"","",1) Q:$D(GMTSQIT)
 Q
LF ; Line Feed
 I +($G(LF))>0 S LF=0 D WRT^GMTSDEM("",,,,0) S LF=0
 Q
