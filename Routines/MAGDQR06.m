MAGDQR06 ;WOIFO/EdM - Imaging RPCs for Query/Retrieve ; 17 Feb 2010 9:53 AM
 ;;3.0;IMAGING;**54,66**;Mar 19, 2002;Build 1836;Sep 02, 2010
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
Q0080050 ;R  Accession Number
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N WRKDT
 . S WRKDT=$$DT^XLFDT
 . S V(T)=$E(WRKDT,4,7)_$E(WRKDT,2,3)_"-0000"
 . Q
 ; no
 S V(T)=$G(ACCESSION)
 Q
 ;
Q0200010 ;R  Study ID
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S V(T)=$S(I:$S($G(REQ(T,I))]"":REQ(T,I),1:"0"),1:"0")
 . Q
 ; no
 D:TYPE="R"
 . S V(T)=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",1) ; IA # 1172
 . Q
 D:TYPE="C"
 . S V(T)=$P($G(ACCESSION),"-",2)
 . Q
 Q
 ;
Q0080062 ;O  SOP Classes in Study
 ; --- probably not supported --- ?
 ; ? ? ?
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0080090 ;O  Referring Physician's Name
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="IMAGPROVIDER,SENSITIVE"
 . Q
 ; no
 D:TYPE="R"
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",14) ; IA # 1172
 . S V(T)=$$GET1^DIQ(200,(+X)_",",.01)
 . Q
 D:TYPE="C"
 . N G0
 . I IMAGE="" S V(T)="" Q
 . S G0=$$GMRC($G(ACCESSION),MAGIEN) I 'G0 S V(T)="" Q
 . S V(T)=$$GET1^DIQ(123,G0,10,"E") ; IA # 4110
 . Q
 ; MLH: do not match per WP 3/25/09
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 S V(T)=$$VA2DCM^MAGDQR01(V(T)) ; return w/commas
 Q
 ;
Q0081030 ;O  Study Description
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 S V(T)=$$STYDESC^MAGUE001(IMAGE)
 S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0080100 ;O  >Code Value
 D:TYPE="R"
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",2) ; IA # 1172
 . S X=$P($G(^RAMIS(71,+X,0)),"^",9) ; IA # 1174
 . S X=$$CPT^ICPTCOD(+X) ; IA # 1995, supported reference
 . S V("0008,1030",1,T)=$P(X,"^",2)
 . Q
 D:TYPE="C"
 . N G0
 . I IMAGE="" S V(T)="" Q
 . S G0=$$GMRC($G(ACCESSION),IMAGE) I 'G0 S V(T)="" Q
 . S V(T)=$$GET1^DIQ(123,G0,4,"I") ; IA # 4110
 . Q
 Q
 ;
Q0080104 ;O  >Code Meaning
 D:TYPE="R"
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",2) ; IA # 1172
 . S X=$P($G(^RAMIS(71,+X,0)),"^",9) ; IA # 1174
 . S X=$$CPT^ICPTCOD(+X) ; IA # 1995, supported reference
 . S V("0008,1030",1,T)=$P(X,"^",3)
 . Q
 D:TYPE="C"
 . N G0
 . I IMAGE="" S V(T)="" Q
 . S G0=$$GMRC($G(ACCESSION),IMAGE) I 'G0 S V(T)="" Q
 . S V(T)=$$GET1^DIQ(123,G0,4,"E") ; IA # 4110
 . Q
 Q
 ;
Q0081060 ;O  Name of Physician(s) Reading Study
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="IMAGPROVIDER,SENSITIVE"
 . Q
 ; no
 D:TYPE="R"
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",17) ; IA # 1172
 . S X=$P($G(^RARPT(+X,0)),"^",9) ; IA # 1171
 . S V(T)=$$GET1^DIQ(200,(+X)_",",.01)
 . Q
 Q:TYPE="C"
 ; MLH:  do not match per WP 3/25/09
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 S V(T)=$$VA2DCM^MAGDQR01(V(T)) ; return w/commas
 Q
 ;
Q0081080 ;O  Admitting Diagnosis Description
 ; ? ? ?
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q01021B0 ;O  Additional Patient History
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 N D1,I,T0,X
 Q:TYPE="R"
 D:TYPE="C"
 . I IMAGE="" S V(T)="" Q
 . S X=$G(^MAG(2005,MAGIEN,2))
 . I $P(X,"^",6)'=8925 S V(T)="" Q
 . S X=$P($G(^TIU(8925,+$P(X,"^",7),15)),"^",2) ; Signed By field
 . S:X X=$$GET1^DIQ(200,(+X)_",",.01)
 . S V(T)=X
 . Q
 S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0104000 ;O  Patient Comments
 ; ? ? ?
 ; (there is a modality that passes the accession number in this field)
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
U008010C ;O  Interpretation Author
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="IMAGPROVIDER,SENSITIVE"
 . Q
 ; no
 D:TYPE="R"
 . S X=+$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",12) ; IA # 1172
 . S V(T)=$$GET1^DIQ(200,(+X)_",",.01)
 . Q
 D:TYPE="C"
 . I MAGIEN="" S V(T)="" Q
 . S X=$G(^MAG(2005,MAGIEN,2))
 . I $P(X,"^",6)'=8925 S V(T)="" Q
 . S X=$P($G(^TIU(8925,+$P(X,"^",7),15)),"^",2) ; Signed By field
 . S:X X=$$GET1^DIQ(200,(+X)_",",.01)
 . S V(T)=X
 . Q
 ; MLH:  do not match per WP 3/25/09
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
GMRC(ACCNUM,IMAGE) ; Return consult number for image
 N G0,P,T0,X
 S G0=+$TR($G(ACCNUM),"GMRCgmrc-") Q:G0 G0
 S X=$G(^MAG(2005,+IMAGE,2)),P=$P(X,"^",6) Q:P'=8925 0
 S T0=$P(X,"^",7) Q:'T0 0
 S X=$P($G(^TIU(8925,T0,14)),"^",5) Q:X'[";GMR(123," 0
 Q +X
