DGENLCD1 ;ALB/CJM,Zoltan,JAN,TGH - Enrollment Catastrophic Disability- Build List Area;13 JUN 1997
 ;;5.3;Registration;**121,232,387,850,894**;Aug 13,1993;Build 48
 ;
 ; DG*5.3*894 - Enhance Catastrophic Disability to use Descriptors rather than Diagnoses/Procedures/Conditions.
 ;
EN(DGARY,DFN,DGCNT) ;Entry point to build list area
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ; Output -- DGCNT    Number of lines in the list
 N DGCDIS,DGLINE
 I $$GET^DGENCDA(DFN,.DGCDIS) ;set-up catastrophic disability array
 S DGLINE=1,DGCNT=0
 D CD(DGARY,DFN,.DGCDIS,.DGLINE,.DGCNT)
 Q
 ;
CD(DGARY,DFN,DGCDIS,DGLINE,DGCNT) ;
 ;Description: Writes Catastrophic Disabilty info to list.
 ; Input  -- DGARY    Global array subscript
 ;           DFN      Patient IEN
 ;           DGCDIS    Enrollment array
 ;           DGLINE   Line number
 ; Output -- DGCNT    Number of lines in the list
 N DGSTART,HASCAT,PERM
 ;
 S DGSTART=DGLINE ; starting line number
 D SET^DGENL1(DGARY,DGLINE," Catastrophic Disability ",28,IORVON,IORVOFF,,,,.DGCNT)
 S DGLINE=DGLINE+2
 S HASCAT=$$HASCAT^DGENCDA(DFN)
 D SET^DGENL1(DGARY,DGLINE,$J("Veteran Catastrophically Disabled:   ",41)_$S(HASCAT:"YES",1:"NO"),1,,,,,,.DGCNT)
 ;
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Date of Decision:   ",41)_$$EXT^DGENCDU("DATE",DGCDIS("DATE")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Decided By:   ",41)_$$EXT^DGENCDU("BY",DGCDIS("BY")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Facility Making Determination:   ",41)_$$EXT^DGENCDU("FACDET",DGCDIS("FACDET")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Review Date:   ",41)_$$EXT^DGENCDU("REVDTE",DGCDIS("REVDTE")),1,,,,,,.DGCNT)
 S DGLINE=DGLINE+1
 D SET^DGENL1(DGARY,DGLINE,$J("Method of Determination:   ",41)_$$EXT^DGENCDU("METDET",DGCDIS("METDET")),1,,,,,,.DGCNT)
 ;
 ; Display reasons for CD Determination.
 I '$D(DGCDIS("DESCR")) Q
 S DGLINE=DGLINE+2
 D SET^DGENL1(DGARY,DGLINE," Reason(s) for CD Determination ",24,IORVON,IORVOFF,,,,.DGCNT)
 S DGLINE=DGLINE+1
 S (ITEM,SUBITEM)=""
 F  S ITEM=$O(DGCDIS("DESCR",ITEM)) Q:ITEM=""  D
 . S DGLINE=DGLINE+1
 . D SET^DGENL1(DGARY,DGLINE,$J("CD Descriptor:   ",25)_$$EXT^DGENCDU("DESCR",DGCDIS("DESCR",ITEM)),1,,,,,,.DGCNT)
 Q
 ;
DISP(Y) ; Patch DG*5.3*850
 ;called from 2.396 and 2.397 output transform, input y, output y
 N DFN,NODE,TYPE,LONG,OUTPUT,DDATE,IMPDATE,ICDVER
 S DFN=$S($G(DA(1))'="":DA(1),$G(DFN)'="":DFN,1:"")
 S NODE=$G(^DGEN(27.17,+Y,0)),LONG=$G(^DGEN(27.17,+Y,5))
 S TYPE=$P(NODE,U,2)
 I DFN="" Q $P(NODE,U,1)
 ;
 S DDATE=$P($G(^DPT(DFN,.39)),"^",2) ;Date of decision
 I $G(DGCDIS("DATE")) S DDATE=DGCDIS("DATE")
 I DDATE="" S DDATE=DT
 S IMPDATE=$P($$IMPDATE^DGPTIC10($G(CODESYS)),"^",1)
 S ICDVER=$S(DDATE<IMPDATE:9,1:10)
 I ICDVER=9 S OUTPUT=$P(NODE,U,4)_" "_$P(NODE,U,1)_$S($P(NODE,U,3)["CPT":" (CPT)",1:" (ICD-9-CM)")
 I ICDVER=10 D
 . I LONG'="" S OUTPUT=$P(NODE,U,4)_" "_LONG_$S(TYPE="D":" (ICD-10-CM)",1:" ICD-10-PCS")
 . I LONG="" S OUTPUT=$P(NODE,U,4)_" "_$P(NODE,U,1)_$S(TYPE="D":" (ICD-10-CM)",1:" ICD-10-PCS")
 Q OUTPUT
