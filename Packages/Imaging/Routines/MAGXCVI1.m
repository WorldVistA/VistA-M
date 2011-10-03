MAGXCVI1 ;WOIFO/SEB,MLH - Image Index Conversion Generate - subroutines ; 15 Jul 2004  9:01 AM
 ;;3.0;IMAGING;**17,25,31**;Mar 31, 2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
GENINEW ; SUBROUTINE - Called from GENIEN^MAGXCVI.
 ; generate new index values for a set of lookup fields not previously indexed on
 N INDXSPEC ; ----- specialty indexed to
 N FILEXT ; ------- file extension for type override checking
 N TYPE ; --------- type mapped to, for override checking
 ;
 F FLDNUM=16,10,6,100,3,8 I $G(MAGVALS(FLDNUM,"I"))]"" D GENFLD
 S FILEXT=$P($P($G(^MAG(2005,CHILD1,0)),U,2),".",2) ; for later checking
 ;
 I $P(INDXDATA,U)="" S $P(INDXDATA,U)="NONE"  ; package still has no value
 ;
 I $P(INDXDATA,U,2)="" D  ; class still has no value - base it on type
 . S TYPE=$P(INDXDATA,U,3)
 . I TYPE]"" S $P(INDXDATA,U,2)=$P($G(^MAG(2005.83,TYPE,0)),U,2)
 . Q
 ;
 ; if class is ADMIN, no procedure or specialty
 I $P(INDXDATA,U,2)=8 S $P(INDXDATA,U,4,5)=""
 ;
 I $P(INDXDATA,U,3)="" D  ; image type still has no value
 . S $P(INDXDATA,U,3)=$S(FILEXT="TIF":45,1:75) ; document/image
 . ; special check for documents
 . I MAGVALS(3,"I")]"",$P($G(^MAG(2005.02,MAGVALS(3,"I"),0)),U)="DOCUMENT" D
 . . I $P(INDXDATA,U,2)=1 D  ; clinical
 . . . S $P(INDXDATA,U,3)=$O(^MAG(2005.83,"B","MISCELLANEOUS DOCUMENT",""))
 . . . Q
 . . E  I $P(INDXDATA,U,2)=8 D  ; administrative
 . . . S $P(INDXDATA,U,3)=$O(^MAG(2005.83,"B","MISCELLANEOUS",""))
 . . . Q
 . . Q
 . Q
 ;
 ; if Type is ADVANCE DIRECTIVE or PHOTO ID: no Specialty;
 ; ADVANCE DIRECTIVE must always be Class CLIN/ADMIN;
 ; PHOTO ID must always be Class ADMIN/CLIN
 I "^67^84^"[("^"_$P(INDXDATA,U,3)_"^") D
 . S $P(INDXDATA,U,5)=""
 . S $P(INDXDATA,U,2)=$S($P(INDXDATA,U,3)=67:7,1:9)
 . Q
 ;
 ; if Type is ENDOSCOPY, delete Type if really non-Endo (i.e., from
 ; Medicine Package)
 I $P(INDXDATA,U,4)=6 D
 . I (" "_$TR($G(MAGVALS(6,"I")),"-","")_" ")[" NONENDO " S $P(INDXDATA,U,4)=""
 . Q
 ;
 ; if no Procedure or Specialty, then...
 ; if no type, or an image, default to CLIN Class if no Class
 I $P(INDXDATA,U,4)="",$P(INDXDATA,U,5)="" D
 . I "^^75^"[("^"_$P(INDXDATA,U,3)_"^"),$P(INDXDATA,U,2)="" D
 . . S $P(INDXDATA,U,2)=1
 . . Q
 . Q
 ;
 ; if Specialty is GI and parent file is ENDOSCOPY and current procedure isn't
 ; a GI procedure, map to ENDO Procedure
 I $P(INDXDATA,U,5)=3,MAGVALS(16,"I")=699 D
 . I '$D(^MAG(2005.85,+$P(INDXDATA,U,4),1,"B",3)) S $P(INDXDATA,U,4)=6
 . Q
 ;
 Q
 ;
GENFLD ; SUBROUTINE - Called from GENINEW.
 ; Generate indices for one field.
 N D0 ; ----------- scratch array index
 N I ; ------------ scratch string piece index
 N INDXVAL ; ------ the index value we compute
 N PRVVAL ; ------- the index value computed from a previous field mapping
 ;
 S MAPDATA=""
 I FLDNUM=3 D  ; object type
 . S MAGVALS(3,"I")=$$UCASE^MAGXCVP($$STRIP^MAGXCVP(MAGVALS(3,"I")))
 . S MAPDATA=$P($G(^XTMP("MAG30P25","MAPPING",3,MAGVALS(3,"I"))),U,2,999)
 . Q
 I FLDNUM=6 D GENF06 ; procedure
 I FLDNUM=8 D GENF08 ; image save by
 I FLDNUM=10 D GENF10 ; short description
 I FLDNUM=16 D  ; parent data file
 . S MAPDATA=$G(^MAG(2005.03,MAGVALS(16,"I"),2))
 . ; make sure TIUs map properly for CP
 . I MAGVALS(16,"I")=8925 D
 . . I (" "_MAGVALS(6,"I")_" ")[" CP " S $P(MAPDATA,U)="CP"
 . . Q
 . Q
 I FLDNUM=100 S MAPDATA=$G(^MAG(2005.81,MAGVALS(100,"I"),2)) ; doc category
 ; D0: 1=package, 2=class, 3=type, 4=procedure/event, 5=specialty, 6=origin
 F D0=1:1:6 D
 . S INDXVAL=$P($P(MAPDATA,U,D0),"-"),PRVVAL=$P(INDXDATA,U,D0)
 . I INDXVAL]"" D
 . . I $P(INDXDATA,U,D0)="" D
 . . . S $P(INDXDATA,U,D0)=INDXVAL
 . . . Q
 . . E  I D0=5,PRVVAL=48 D
 . . . ; override previous Specialty of 'SURGERY' if a more precise mapping
 . . . ; has been found
 . . . S $P(INDXDATA,U,D0)=INDXVAL
 . . . Q
 . . Q
 . Q
 Q
 ;
GENF06 ; generate indices based on field 6 (Procedure)
 ; expects MAGVALS, U; returns MAPDATA
 N TERM ; --- DICOM Modality Defined Term
 N I ; ------ scratch index
 N IVAL ; --- positional index value
 ;
 S MAGVALS(6,"I")=$$UCASE^MAGXCVP($$STRIP^MAGXCVP($G(MAGVALS(6,"I"))))
 I $E(MAGVALS(6,"I"),1,2)="+ " D
 . S MAGVALS(6,"I")=$E(MAGVALS(6,"I"),3,$L(MAGVALS(6,"I")))
 . Q
 I MAGVALS(6,"I")[" TEMPLATE" D
 . S MAGVALS(6,"I")=$P(MAGVALS(6,"I")," TEMPLATE")
 . Q
 I MAGVALS(6,"I")]"" D
 . S MAPDATA=$P($G(^XTMP("MAG30P25","MAPPING",6,MAGVALS(6,"I"))),U,2,999)
 . ; did they use a DICOM Modality Defined Term?
 . S TERM=MAGVALS(6,"I")
 . I $P(TERM," ")="RAD" S TERM=$P(TERM," ",2,999)
 . I TERM]"",$D(^RAMIS(73.1,"B",TERM)) D
 . . F I=1:1:6 D
 . . . S IVAL=$P(MAPDATA,U,I)
 . . . I IVAL]"" S $P(INDXDATA,U,I)=$P(IVAL,"-")
 . . . Q
 . . Q
 . Q
 I MAGVALS(6,"I")["NON VA" D
 . S $P(INDXDATA,U,6)="N"
 . Q
 Q
 ;
GENF08 ; generate indices based on field 8
 ; expects MAGVALS, U; returns MAPDATA
 ; logic:  strip trailing 'SERVICE', 'SECTION' and then trailing 'CARE';
 ;         do not tokenize; exact match on mapping
 N UTYPE ; ----- external value of service/section
 N SVSECTXT ; -- service/section name, all caps and tokenized
 ;
 S UTYPE=$$GET1^DIQ(200,MAGVALS(8,"I")_",",29,"E")
 I UTYPE]"" D  ; tokenize the service/section
 . S SVSECTXT=$$STRIP^MAGXCVP($$UCASE^MAGXCVP(UTYPE))
 . I UTYPE?.E1" SERVICE".1"S" S UTYPE=$P(UTYPE," SERVICE")
 . I UTYPE?.E1" SECTION" S UTYPE=$P(UTYPE," SECTION")
 . I UTYPE?.E1" CARE" S UTYPE=$P(UTYPE," CARE")
 . S MAPDATA=$P($G(^XTMP("MAG30P25","MAPPING",8,UTYPE)),U,2,999)
 . Q
 Q
 ;
GENF10 ; generate indices based on field 10 (Short Description)
 ; returns MAPDATA
 N CURMAP ; ---- current mapping value
 N NEWMAP ; ---- new mapping value
 N TOKSTR ; ---- a token string that we check for
 N SHDSCTXT ; -- short description text
 N TSTSPEC ; --- specialty mapped to, for override checking
 ;
 S TOKSTR="",MAPDATA=""
 S SHDSCTXT=(" "_$$SCRUBTKN^MAGXCVP($$UCASE^MAGXCVP(MAGVALS(10,"I")))_" ")
 F  S TOKSTR=$O(^XTMP("MAG30P25","MAPPING",10,TOKSTR)) Q:TOKSTR=""  D
 . ; Check *every* token - don't stop after the first hit.
 . ; Set up test string for checking on a standard token boundary (space).
 . S FLDDATA=$$UCASE^MAGXCVP($G(^XTMP("MAG30P25","MAPPING",10,TOKSTR)))
 . I SHDSCTXT[(" "_$P(FLDDATA,U)_" ") D
 . . F I=1:1:6 D
 . . . S CURMAP=$P(MAPDATA,U,I),NEWMAP=$P(FLDDATA,U,I+1)
 . . . ; overrides:
 . . . ;   map to a more precise Specialty than 'SURGERY'
 . . . I I=5,NEWMAP]"",CURMAP=48 S $P(MAPDATA,U,I)=NEWMAP Q
 . . . ;
 . . . I CURMAP="" D
 . . . . ; overrides:
 . . . . ;   don't map to Cardiac Cath if specialty other than Cardiology
 . . . . I I=4,+NEWMAP=1 S TSTSPEC=$P(INDXDATA,U,5) I TSTSPEC,TSTSPEC-2 Q
 . . . . S $P(MAPDATA,U,I)=NEWMAP
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
