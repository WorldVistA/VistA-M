LA7VHLUB ;DALOI/LMT - HL7 MI Bact Override Check ;03/18/11  12:23
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
BACTCHK(LA7ONLT,LA7AA,LA7AD,LA7AN,LA76247) ;
 ;
 ; Check if Organism should be stored under Bacteriology section instead of MI section determined by OBX-3 mapping.
 ; Used in cases where a Parasite, Fungus, Mycobacterium, or Virus was reported on a Bacterial culture.
 ;
 ; Call with  LA7ONLT = <opt> NLT WKLD code from OBR-4
 ;              LA7AA = Accession Area
 ;              LA7AD = Accession Date
 ;              LA7AN = Accession Number
 ;            LA76247 = File #62.47 IEN (Concept being used)
 ;
 ; Returns    LA76247 = File #62.47 IEN (Concept to be used)
 ;
 ; -------------------
 ; LA76247
 ;    3: BACTERIA
 ;    4: MYCOBACTERIA
 ;    5: VIRUS
 ;    8: PARASITE
 ;    9: FUNGUS
 ; -------------------
 ;
 N LA764,LA760,LA7X
 ;
 S LA764=""
 I $G(LA7ONLT) S LA764=$O(^LAM("E",LA7ONLT,0))
 ;
 ; Already using Bacteria concept - No need to check
 I LA76247=3 Q LA76247
 ;
 ; If current concept is not Mycobacteria, Virus, Parasite, or Fungus - quit
 I LA76247'?1(1"4",1"5",1"8",1"9") Q LA76247
 ;
 ; If LA7ONLT exists (from OBR-4), then use that to determine ordered test DB mapping
 I LA764 D  Q LA76247
 . ; If ordered test is mapped to bacteriology section, then use Bacteria concept
 . I $$NLT2SEC(LA764)=3 S LA76247=3
 ;
 I '$G(LA7AA)!('$G(LA7AD))!('$G(LA7AN)) Q LA76247
 ;
 ; If LA7ONLT does not exist, look at tests on accession
 ;  - If one of the tests is mapped to same MI section as concept being used, no need to override
 ;  - Else: if one of the tests is mapped to bacteriology section, then override with Bacteria concept
 S LA760=0
 F  S LA760=$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA760)) Q:'LA760  D
 . S LA764=$P($G(^LAB(60,LA760,64)),"^")
 . Q:'LA764
 . S LA7X($$NLT2SEC(LA764))=""
 ; One of tests is for same section as concept being used. No need to override.
 I $D(LA7X(LA76247)) Q LA76247
 ; Else: If one of the tests is mapped to bacteriology section, then use Bacteria concept
 I $D(LA7X(3)) S LA76247=3
 ;
 Q LA76247
 ;
 ;
NLT2SEC(LA764) ; Helper function (used by BACTCHK)
 ;
 ; Finds MI section that NLT is mapped to.
 ;
 ; Call with   LA764 = File #64 IEN
 ;
 ; Returns    LA7SEC = Section that #64 entry is mapped to (determined by MI/AP DATABASE CODE)
 ;                     3: BACTERIA
 ;                     4: MYCOBACTERIA
 ;                     5: VIRUS
 ;                     8: PARASITE
 ;                     9: FUNGUS
 ;                     0: Anything else
 ;
 N LA7SEC,LA764061,LA7MIDBCD,LA7MISB
 ;
 S LA7SEC=0
 ;
 I '$G(LA764) Q LA7SEC
 ;
 S LA764061=$P($G(^LAM(LA764,63)),"^",1)
 S LA7MIDBCD=$G(^LAB(64.061,+LA764061,63))
 ;
 ; If #64.061 entry Subscript is not 'MI' - quit
 I $P(LA7MIDBCD,"^")'="MI" Q LA7SEC
 ;
 S LA7MISB=$P(LA7MIDBCD,"^",2,3) ; File/Subfile^Field Number
 S LA7SEC=$S(LA7MISB="63.05^11":3,LA7MISB="63.05^22":4,LA7MISB="63.05^33":5,LA7MISB="63.05^14":8,LA7MISB="63.05^18":9,1:0)
 ;
 Q LA7SEC
