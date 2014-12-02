MAGDQR06 ;WOIFO/EdM,MLH - Imaging RPCs for Query/Retrieve ; 03 Apr 2012 11:26 AM
 ;;3.0;IMAGING;**54,66,118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
Q0080050(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;R  Accession Number
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N WRKDT
 . S WRKDT=$$DT^XLFDT
 . S V(T)=$E(WRKDT,4,7)_$E(WRKDT,2,3)_"-0000"
 . Q
 ; no
 S V(T)=$G(^TMP("MAG",$J,"ACCESSION"))
 Q
 ;
Q0200010(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;R  Study ID
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S V(T)=$S(I:$S($G(REQ(T,I))]"":REQ(T,I),1:"0"),1:"0")
 . Q
 ; no
 S V(T)=$G(^TMP("MAG",$J,"ACCESSION"))
 S V(T)=$P(V(T),"-",$L(V(T),"-")) ; case # or consult # only
 Q
 ;
Q0080062(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  SOP Classes in Study
 ; --- probably not supported --- ?
 ; ? ? ?
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0080090(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Referring Physician's Name
 N IMGTYPE
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="IMAGPROVIDER,SENSITIVE"
 . Q
 ; no
 S IMGTYPE=TYPE
 D:IMGTYPE="N" FINDTYP(.IMGTYPE,MAGDFN,MAGIEN,.MAGRORD,.MAGINTERP) ; will reset IMGTYPE if successful
 D:IMGTYPE="R"
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",14) ; IA # 1172
 . S V(T)=$$GET1^DIQ(200,(+X)_",",.01)
 . Q
 D:IMGTYPE="C"
 . N G0
 . I MAGIEN="" S V(T)="" Q
 . S G0=$$GMRC($G(^TMP("MAG",$J,"ACCESSION")),MAGIEN) I 'G0 S V(T)="" Q
 . S V(T)=$$GET1^DIQ(123,G0,10,"E") ; IA # 4110
 . Q
 ; MLH: do not match per WP 3/25/09
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0081030(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Study Description
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 S V(T)=$$STYDESC2^MAGUE001(TYPE,MAGIEN)
 S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0080100(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  >Code Value
 N IMGTYPE
 S IMGTYPE=TYPE
 D:IMGTYPE="N" FINDTYP(.IMGTYPE,MAGDFN,MAGIEN,.MAGRORD,.MAGINTERP) ; will reset IMGTYPE if successful
 D:IMGTYPE="R"
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",2) ; IA # 1172
 . S X=$P($G(^RAMIS(71,+X,0)),"^",9) ; IA # 1174
 . S X=$$CPT^ICPTCOD(+X) ; IA # 1995, supported reference
 . S V("0008,1030",1,T)=$P(X,"^",2)
 . Q
 D:IMGTYPE="C"
 . N G0
 . I MAGIEN="" S V(T)="" Q
 . S G0=$$GMRC($G(^TMP("MAG",$J,"ACCESSION")),MAGIEN) I 'G0 S V(T)="" Q
 . S V(T)=$$GET1^DIQ(123,G0,4,"I") ; IA # 4110
 . Q
 Q
 ;
Q0080104(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  >Code Meaning
 N IMGTYPE
 S IMGTYPE=TYPE
 D:IMGTYPE="N" FINDTYP(.IMGTYPE,MAGDFN,MAGIEN,.MAGRORD,.MAGINTERP) ; will reset IMGTYPE if successful
 D:IMGTYPE="R"
 . N X
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",2) ; IA # 1172
 . S X=$P($G(^RAMIS(71,+X,0)),"^",9) ; IA # 1174
 . S X=$$CPT^ICPTCOD(+X) ; IA # 1995, supported reference
 . S V("0008,1030",1,T)=$P(X,"^",3)
 . Q
 D:IMGTYPE="C"
 . N G0
 . I MAGIEN="" S V(T)="" Q
 . S G0=$$GMRC($G(^TMP("MAG",$J,"ACCESSION")),MAGIEN) I 'G0 S V(T)="" Q
 . S V(T)=$$GET1^DIQ(123,G0,4,"E") ; IA # 4110
 . Q
 Q
 ;
Q0081060(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Name of Physician(s) Reading Study
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="IMAGPROVIDER,SENSITIVE"
 . Q
 ; no
 N IMGTYPE
 S IMGTYPE=TYPE
 D:IMGTYPE="N" FINDTYP(.IMGTYPE,MAGDFN,MAGIEN,.MAGRORD,.MAGINTERP) ; will reset IMGTYPE if successful
 D:IMGTYPE="R"
 . N X
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",17) ; IA # 1172
 . S X=$P($G(^RARPT(+X,0)),"^",9) ; IA # 1171
 . S V(T)=$$GET1^DIQ(200,(+X)_",",.01)
 . Q
 Q:IMGTYPE="C"
 ; MLH:  do not match per WP 3/25/09
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0081080(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Admitting Diagnosis Description
 ; ? ? ?
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q01021B0(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Additional Patient History
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 N D1,I,T0,X,IMGTYPE
 N IMGTYPE
 S IMGTYPE=TYPE
 D:IMGTYPE="N" FINDTYP(.IMGTYPE,MAGDFN,MAGIEN,.MAGRORD,.MAGINTERP) ; will reset IMGTYPE if successful
 Q:IMGTYPE="R"
 D:IMGTYPE="C"
 . S V(T)="",TIUIX=$$TIUIX(IMGTYPE,MAGIEN)
 . D:TIUIX
 . . S X=$P($G(^TIU(8925,TIUIX,15)),"^",2) ; Signed By field
 . . S:X X=$$GET1^DIQ(200,(+X)_",",.01)
 . . S V(T)=X
 . . Q
 . Q
 S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
Q0104000(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Patient Comments
 ; ? ? ?
 ; (there is a modality that passes the accession number in this field)
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
U008010C(TYPE,REQ,V,T,MAGDFN,MAGIEN,MAGRORD,MAGINTERP,SENSEMP,OK) ;O  Interpretation Author
 N X,IMGTYPE
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="IMAGPROVIDER,SENSITIVE"
 . Q
 ; no
 N IMGTYPE
 S IMGTYPE=TYPE
 D:IMGTYPE="N" FINDTYP(.IMGTYPE,MAGDFN,MAGIEN,.MAGRORD,.MAGINTERP) ; will reset IMGTYPE if successful
 D:IMGTYPE="R"
 . S X=+$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",12) ; IA # 1172
 . S V(T)=$$GET1^DIQ(200,(+X)_",",.01)
 . Q
 D:IMGTYPE="C"
 . N TIUIX
 . S V(T)="",TIUIX=$$TIUIX(IMGTYPE,MAGIEN)
 . D:TIUIX
 . . S X=$P($G(^TIU(8925,TIUIX,15)),"^",2) ; Signed By field
 . . S:X X=$$GET1^DIQ(200,(+X)_",",.01)
 . . S V(T)=X
 . . Q
 . Q
 ; MLH:  do not match per WP 3/25/09
 ;;;S:'$$COMPARE^MAGDQR03(T,V(T)) OK=0
 Q
 ;
GMRC(ACCNUM,IMAGE) ; Return consult number for image
 N X
 D  ; perform appropriate lookup for old / new database structure
 . N G0,T0
 . S G0=$$GMRCIEN^MAGDFCNV($G(ACCNUM)) I G0 S X=G0 Q
 . S TIUIX=$$TIUIX(TYPE,IMAGE) I 'TIUIX S X=0 Q
 . S X=$P($G(^TIU(8925,TIUIX,14)),"^",5) I X'[";GMR(123," S X=0 Q
 . S X=0 ; unresolvable IEN
 . Q
 Q +X
 ;
TIUIX(TYPE,STUDYIX) ; FUNCTION - find the TIU note index corresponding to a study's procedure
 ; perform appropriate lookup for old / new database structure
 D:TYPE'="N"  ; old structure
 . N X
 . S X=$G(^MAG(2005,STUDYIX,2))
 . S:$P(X,"^",6)=8925 TIUIX=+$P(X,"^",7)
 . Q
 D:TYPE="N"  ; new structure
 . N PROCIX
 . S PROCIX=$P($G(^MAGV(2005.62,STUDYIX,6)),"^",1) Q:'PROCIX
 . S:$P($G(^MAGV(2005.61,PROCIX,0)),"^",3)="TIU" TIUIX=$P(^(0),"^",1)
 . Q
 Q $G(TIUIX)
 ;
FINDTYP(IMGTYPE,MAGDFN,MAGIEN,MAGRORD,MAGINTERP) ; find type of image on new DB
 ; if found, will reset IMGTYPE for further processing
 N PROCIX,PROCREC,PROCTYP,PROCIDNT
 S PROCIX=$$PROCIX^MAGUE005(MAGIEN) Q:'PROCIX
 S PROCREC=$G(^MAGV(2005.61,PROCIX,0)) Q:PROCREC=""
 S PROCTYP=$P(PROCREC,"^",3),PROCIDNT=$P(PROCREC,"^",1)
 I PROCTYP="RAD" D  Q
 . N ACCARY,I
 . S I=$$ACCFIND^RAAPI(PROCIDNT,.ACCARY)
 . S I=""
 . F  S I=$O(ACCARY(I)) Q:'I  I $P(ACCARY(I),"^",1)=MAGDFN Q
 . I I S MAGRORD=$P(ACCARY(I),"^",2),MAGINTERP=$P(ACCARY(I),"^",3)
 . S IMGTYPE="R"
 . Q
 I PROCTYP="CON" D  Q
 . S IMGTYPE="C"
 . Q
 Q
