DPTLK7A ;OAK/MKO-MAS PATIENT LOOKUP ENTERPRISE SEARCH (cont) ;13 May 2020  1:13 PM
 ;;5.3;Registration;**1024**;Aug 13, 1993;Build 1
 ;**1024,Story 1258907 (mko): Routine created with subroutines ADDTF and CHKSRCID
 Q
 ;
ADDTF(DFN,IDS) ;Add the Treating Facility returned from the Enterprise Search
 ;In: DFN = DFN of patient
 ;    IDS(seq#,"ID")=Source ID
 ;    IDS(seq#,"IDTYPE")=Source ID Type (e.g., "PI")
 ;    IDS(seq#,"ISSUER")=Assigning Authority (e.g., "USVHA")
 ;    IDS(seq#,"SOURCE")=Facility (e.g., 500M, "200ESR")
 ;    IDS(seq#,"STATUS")=ID Status (e.g., "A", "H")
 N AA,IDSTAT,IDTYPE,SEQ,SRCID,STAIEN,STANUM
 D FILE^VAFCTFU(DFN,+$$SITE^VASITE,1,1,,,DFN,"A","USVHA","PI")
 S SEQ="" F  S SEQ=$O(IDS(SEQ)) Q:SEQ=""  D
 . S STANUM=$G(IDS(SEQ,"SOURCE"))
 . S STAIEN=$$IEN^XUAF4($G(IDS(SEQ,"SOURCE"))) Q:STAIEN'>0
 . S SRCID=$$CHKSRCID($G(IDS(SEQ,"ID")),STANUM) Q:SRCID=""
 . S IDSTAT=$G(IDS(SEQ,"STATUS"))
 . S AA=$G(IDS(SEQ,"ISSUER"))
 . S IDTYPE=$G(IDS(SEQ,"IDTYPE"))
 . D FILE^VAFCTFU(DFN,STAIEN,1,1,,,SRCID,IDSTAT,AA,IDTYPE)
 Q
 ;
CHKSRCID(SRCID,FCLTY) ;Strip leading and trailing 0s from 200ESR source IDs
 N CNT
 Q:$G(FCLTY)'="200ESR"!($G(SRCID)="") $G(SRCID)
 F CNT=1:1 Q:$E(SRCID,CNT)'=0
 S SRCID=$E(SRCID,CNT,999)
 S:SRCID?10N1"V"6N1."0" SRCID=$E(SRCID,1,17)
 Q SRCID
