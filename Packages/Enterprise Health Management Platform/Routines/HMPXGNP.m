HMPXGNP ; ASMR/hrubovcak - NEW PERSON file (#200) data retrieval ;Nov 03, 2015 18:23:03
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; IA 10060 - All NEW PERSON fields supported for read via FileMan
 ;
TOP(HMPRSLT,HMPNPIEN,HMPFLDS,HMPFLG) ; return top-level fields, null fields not returned
 ; HMPRSLT - result array, closed reference, required
 ; HMPNPIEN - IEN of NEW PERSON, required
 ; HMPFLDS - field list, required, FileMan convention 
 ; HMPFLG - data flag, optional, FileMan convention
 ;
 Q:'$L($G(HMPRSLT))
 ;
 K @HMPRSLT  ; clear all results
 ; error data is found in -1 subscript
 I '($G(HMPNPIEN)>0) S @HMPRSLT@(-1,$T(+0))="NEW PERSON IEN required" Q
 I $G(HMPFLDS)="" S @HMPRSLT@(-1,$T(+0))="NEW PERSON fields required" Q
 I '$L($G(HMPFLG)) N HMPFLG S HMPFLG="EIN"
 N DA,DIC,DIQ,DR,FLAGS  ; FileMan variables
 S DIC=200,DR=HMPFLDS,DA=HMPNPIEN,DIQ=HMPRSLT,DIQ(0)=HMPFLG,FLAGS=HMPFLG
 D EN^DIQ1
 Q
 ;
