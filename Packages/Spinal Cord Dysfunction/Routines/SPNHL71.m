SPNHL71 ;WDE/SAN-DIEGO;validate then build the segments
 ;;2.0;Spinal Cord Dysfunction;**10**;01/02/97
CHK(SPNFD0) ;
 ;      Called from the edit routine spnfedt0
 ;      Check entry and create the hl7 message
 ;      that is associated with file 154.1
 ; NOTE spnifn is the entry in 154.1
 ;--------------------------------------------------------------------
 ;check record type
 S SPNCHK=$$GET1^DIQ(154.1,SPNFD0_",",.02)
 I $G(SPNCHK)="" D ZAP Q
 ;check record date
 S SPNCHK=$$GET1^DIQ(154.1,SPNFD0_",",.04)
 I $G(SPNCHK)="" D ZAP Q
 ;the record passed the test and we want it
CREATE ;this label is also called from the tag auto
 S SPNFDFN=$$GET1^DIQ(154.1,SPNFD0_",",.01,"I")
 D EN^SPNHPID(SPNFDFN)
 D EN^SPNHL2(SPNFD0)  ;build the message
 ;at this point we have the HL7 and want to send it
 D INIT^SPNHL7
 I HLDAP="" D ZAP Q  ;init didn't find the HL7 interface
 I $P($G(^HL(771,HLDAP,0)),U,2)'="a" D ZAP Q  ;test for active/on
 D SEND^SPNHL7
ZAP ;
 K SPNFDFN,X,Y,HL,HLA,SPMSG,SPNTMP,HLA,HL,HLP,SPTMP,HLSAN,OBXCNT,OBRCNT,HLARYTYP,HLECH,HLFORMAT,HLFS,HLMTIEN,HLN,HLQ,HLRESLT
 Q
AUTO ;  Note that spnifn should be the patients dfn
 ;---------------------------------------------------------------------
 ;this tag is called from the SPNHL7 line auto and then some
 ;its function is to load all entrys for a particular patient
 ;You must know the dfn to entry here.  
 S SPNFD0=0 F  S SPNFD0=$O(^SPNL(154.1,"B",SPNIFN,SPNFD0)) Q:(SPNFD0="")!('+SPNFD0)  D
 .D CHK(SPNFD0)
 .Q
