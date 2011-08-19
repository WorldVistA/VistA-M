VAFCTR ;BIR/CMC,ERC,PTD-Monitoring fields for MPI/PD via DG field monitoring ; 3/30/07
 ;;5.3;Registration;**575,648,653,712**;Aug 13, 1993;Build 7
 Q  ; quit if called from the top
 ;
MPIPD ; protocol entry point for monitoring fields via DG field monitoring
 ; Currently monitoring for fields:
 ; 1 ALIAS - .01 of the multiple
 ; 2 RACE INFORMATION - .01 of the multiple
 ; 6 ETHNICITY INFORMATION - .01 of the multiple
 ; 994 MULTIPLE BIRTH INDICATOR
 ; .525 POW STAUTS INDICATED?
 ; .0906 PSEUDO SSN REASON
 ; .121 BAD ADDRESS INDICATOR
 ; .133 EMAIL ADDRESS
 ; .134 PHONE NUMBER [CELLULAR]
 ;
 I $G(DGFILE)'=2&($G(DGFILE)'=2.01)&($G(DGFILE)'=2.02)&($G(DGFILE)'=2.06) Q
 S DGFIELD=$G(DGFIELD)
 I DGFIELD'=.01&(DGFIELD'=994)&(DGFIELD'=.525)&(DGFIELD'=.0906)&(DGFIELD'=.121)&(DGFIELD'=.133)&(DGFIELD'=.134)  Q
 I $T(AVAFC^VAFCDD01)="" Q
 ;The fields below are not multiples
 I (DGFIELD=994)!(DGFIELD=.525)!(DGFIELD=.0906)!(DGFIELD=.121)!(DGFIELD=.133)!(DGFIELD=.134) S VAFCF=DGFIELD_";" D AVAFC^VAFCDD01(DGDA)
 ;The fields below ARE multiples
 I DGFILE=2.01 S VAFCF="1;" D AVAFC^VAFCDD01(DGDA(1)) ;ALIAS
 I DGFILE=2.02 S VAFCF="2.02,.01;" D AVAFC^VAFCDD01(DGDA(1)) ;RACE INFORMATION
 I DGFILE=2.06 S VAFCF="2.06,.01;" D AVAFC^VAFCDD01(DGDA(1)) ;ETHNICITY INFORMATION
 Q
