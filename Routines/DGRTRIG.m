DGRTRIG ;EG - RELATIONSHIP FILE TRIGGERS ;09/12/2005 12:05 PM
 ;;5.3;Registration;**656**;Aug 13, 1994;Build 9
 ;
 ;trigger patient transmsission status (file # 301.5) if edit to Income Relation file # 408.22 
E40822(IEN) ;
 ;input IEN of file # 408.22
 I '$G(IEN) Q
 N X,DFN
 S X=$G(^DGMT(408.22,IEN,0)) I X="" Q
 S DFN=$P(X,"^",1)
 I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to Income Person file # 408.13
E40813(IEN) ;
 ;input IEN of file # 408.13
 I '$G(IEN) Q
 N X,DFN
 S DFN=$O(^DGPR(408.12,"C",+IEN_";DGPR(408.13,",0)) I 'DFN Q
 S X=$G(^DGPR(408.12,DFN,0)) I X="" Q
 S DFN=$P(X,"^",1) I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to Patient Relation file # 408.12
E40812(IEN) ;
 ;input IEN of file # 408.12
 N X,DFN
 I '$G(IEN) Q
 S X=$G(^DGPR(408.12,IEN,0)) I X="" Q
 S DFN=$P(X,"^",1) I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to MST History file # 29.11
E2911(IEN) ;
 ;input IEN of file # 29.11
 N X,DFN
 I '$G(IEN) Q
 S X=$G(^DGMS(29.11,IEN,0)) I X="" Q
 S DFN=$P(X,"^",2) I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to Beneficiary Travel Certification file # 292.2
E3922(IEN) ;
 ;input IEN of file # 392.2
 N X,DFN
 I '$G(IEN) Q
 S X=$G(^DGBT(392.2,IEN,0)) I X="" Q
 S DFN=$P(X,"^",2) I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to Patient Enrollment # 27.11
E2711(IEN) ;
 ;input IEN of file # 27.11
 I '$G(IEN) Q
 N X,DFN
 S X=$G(^DGEN(27.11,IEN,0)) I X="" Q
 S DFN=$P(X,"^",2) I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to Billing Patient # 354
E354(IEN) ;
 ;input IEN of file # 354
 I '$G(IEN) Q
 N X,DFN
 S X=$G(^IBA(354,IEN,0)) I X="" Q
 S DFN=$P(X,"^",1) I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to Annual Means Test # 408.31
E40831(IEN) ;
 ;input IEN of file # 408.31
 I '$G(IEN) Q
 N X,DFN
 S X=$G(^DGMT(408.31,IEN,0)) I X="" Q
 S DFN=$P(X,"^",2) I DFN="" Q
 D EVENT^IVMPLOG(DFN)
 Q
 ;trigger patient transmission status (file # 301.5) if edit to Individual Annual Income # 408.21
E40821(IEN) ;
 ;input IEN of file 408.21
 I '$G(IEN) Q
 N X,DFN
 S X=$G(^DGMT(408.21,IEN,0)) I X="" Q
 S DFN=$P(X,"^",2) I DFN="" Q
 D E40812(DFN)
 Q
