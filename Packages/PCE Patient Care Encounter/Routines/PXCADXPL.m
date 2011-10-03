PXCADXPL ;ISL/dee & LEA/Chylton - Validates & Translates data from the PCE Device Interface into a call to V POV & update Problem List ;3/14/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,33,115**;Aug 12, 1996
 Q
 ;
 ; Variables
 ;   PXCADXPL  Copy of a DIAGNOSIS/PROBLEM node of the PXCA array
 ;   PXCAPRV   Pointer to the provider (200)
 ;   PXCANUMB  Count of the number of POVs
 ;   PXCAINDX  Count of the number of Diagnoses for one provider
 ;   PXCADIAG  Flag for this entry is a Diagnosis
 ;   PXCAPROB  Flag for this entry is a Problem
 ;   PXCACLEX  IEN to Clinical Lexicon
 ;   PXCAITEM,PXCAITM2,PXCAITM3  Temporaries for item being checked
 ;
DXPL(PXCA,PXCABULD,PXCAERRS) ;Validation routine for POV & Problem List together
 I '$D(PXCA("DIAGNOSIS/PROBLEM")) Q
 N PXCADXPL,PXCAPRV,PXCANUMB,PXCAINDX
 N PXCAITEM,PXCAITM2,PXCAITM3
 N PXCADIAG,PXCAPROB
 S PXCAPRV=""
 S PXCANUMB=+$O(^TMP(+$G(PXCAGLB),$J,"POV",""),-1)
 F  S PXCAPRV=$O(PXCA("DIAGNOSIS/PROBLEM",PXCAPRV)) Q:PXCAPRV']""  D
 . I PXCAPRV>0 D
 .. I '$$ACTIVPRV^PXAPI(PXCAPRV,PXCADT) S PXCA("ERROR","DIAGNOSIS/PROBLEM",PXCAPRV,0,0)="Provider is not active or valid^"_PXCAPRV
 .. E  I PXCABULD!PXCAERRS D ANOTHPRV^PXCAPRV(PXCAPRV)
 . S PXCAINDX=0
 . F  S PXCAINDX=$O(PXCA("DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX)) Q:PXCAINDX']""  D
 .. S PXCADXPL=$G(PXCA("DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX))
 .. S PXCANUMB=PXCANUMB+1
 .. S PXCADNUM(PXCAPRV,PXCAINDX)=PXCANUMB
 .. I PXCADXPL="" S PXCA("ERROR","DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX,0)="DIAGNOSIS/PROBLEM data missing" Q
 .. ;
 .. D PART1^PXCADXP1 ;Pieces 1 through 5 and the NOTE
 .. D PART2^PXCADXP2 ;Pieces 6 through 16
 .. ;
 .. ;What is it?  I do not know.
 .. I '(PXCADIAG!PXCAPROB) S PXCA("ERROR","DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX,0)="DIAGNOSIS/PROBLEM is not used as a Diagnosis or as a Problem"
 .. ;
 .. ;Translate data for POV
 .. I PXCADIAG&PXCABULD&'$D(PXCA("ERROR","DIAGNOSIS/PROBLEM",PXCAPRV,PXCAINDX))!PXCAERRS D DX^PXCADX(PXCADXPL,PXCANUMB,PXCAPRV,PXCAERRS)
 Q
 ;
