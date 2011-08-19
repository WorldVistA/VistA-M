IVMZ7CCD ;BAJ - HL7 Z07 CONSISTENCY CHECKER -- CATASTROPHIC DISABILITY SUBROUTINE ; 11/9/05 9:30am
 ;;2.0;INCOME VERIFICATION MATCH;**105,132**;JUL 8,1996;Build 1
 ;
 ; Catastrophic Disability Consistency Checks
 ; This routine checks the various elements of catastrophic disability information
 ; prior to building a Z07 record.  Any tests which fail consistency check will be
 ; saved to the ^DGIN(38.6 record for the patient.
 ;
 ;
 ; Must be called from entry point
 Q
 ;
EN(DFN) ; entry point.  Patient DFN is sent from calling routine.
 ; initialize working variables
 N RULE,Y,DGCDIS,PASS,FILERR
 ; patient array DGCDIS can be populated by a call to $$GET^DGENCDA(DFN,.DGCDIS) as follows:
 ;
 ; S PASS=$$GET^DGENCDA(DFN,.DGCDIS)
 ;
 ; and creates an array similar to this:
 ;       DGCDIS("BY")="DR. JOHN"
 ;       DGCDIS("COND",1)="48"
 ;       DGCDIS("DATE")="3050926"
 ;       DGCDIS("DIAG",1)="8"
 ;       DGCDIS("DTFACIRV")=""
 ;       DGCDIS("DTVETNOT")=""
 ;       DGCDIS("FACDET")="16660"
 ;       DGCDIS("METDET")="3"
 ;       DGCDIS("PERM",1)="1"
 ;       DGCDIS("REVDTE")="3050926"
 ;       DGCDIS("SCORE",1)="6"
 ;       DGCDIS("VCD")="Y"
 ;       DGCDIS("VETREQDT")=""
 ;
 ; if the patient has no CD data on file, the API will return the following:
 ;       DGCDIS=""
 ;       DGCDIS("BY")=""
 ;       DGCDIS("DATE")=""
 ;       DGCDIS("DTFACIRV")=""
 ;       DGCDIS("DTVETNOT")=""
 ;       DGCDIS("FACDET")=""
 ;       DGCDIS("METDET")=""
 ;       DGCDIS("REVDTE")=""
 ;       DGCDIS("VCD")=""
 ;       DGCDIS("VETREQDT")=""
 ;
 S PASS=$$GET^DGENCDA(DFN,.DGCDIS)
 ;
 ; In cases where patient is not listed as catastrophically disabled, routine should check to see if patient could potentially
 ; qualify for CD.  If patient qualifies and is not listed as CD, an inconsistency should be filed.  Otherwise continue.
 ; If patient is not listed as CD, regardless of potential, further checks are not necessary as the rest depend on CD="YES"
 ;
 I '$$CD(DGCDIS("VCD")="Y") D  Q
 . I $D(FILERR) D FILE
 ;
 ; loop through rules in INCONSISTENT DATA ELEMENTS file.
 ; execute only the rules where CHECK/DON'T CHECK and INCLUDE IN Z07 CHECKS fields are turned ON.
 ; 
 ; ***NOTE loop boundary (701-726) must be changed if rule numbers are added ***
 F RULE=701:1:726 I $D(^DGIN(38.6,RULE)) D
 . S Y=^DGIN(38.6,RULE,0)
 . I $P(Y,"^",6) D @RULE
 I $D(FILERR) D FILE
 Q
 ;
CD(VCD) ; Is Patient Catastrophically disabled?  If not, we need to examine patient's record to see if qualified for CD
 ; Whether qualified or not, if patient is listed as NOT CD, the rest of the rules should not be checked.  Therefore,
 ; if DGCDIS("VCD") does not = "Y" system will exit after this rule without checking any further.
 I VCD Q 1
 I $$ISCD^DGENCDA1(.DGCDIS) S FILERR(720)=""
 Q 0
 ;
701 ;Catastrophic Disability 'Decided By' Cannot be 'HINQ'
 I $G(DGCDIS("BY"))="HINQ" S FILERR(RULE)=""
 Q
 ;
702 ;Catastrophic Disability 'Decided By' not valid
 I ($L(DGCDIS("BY"))<3)!($L(DGCDIS("BY"))>35) S FILERR(RULE)=""
 Q
703 ;"Catastrophic Disability 'Decided By' required"
 I $G(DGCDIS("BY"))="" S FILERR(RULE)=""
 Q
 ;
704 ;"Catastrophic Disability Review Date Required"
 I $G(DGCDIS("REVDTE"))="" S FILERR(RULE)=""
 Q
 ;
705 ;"Catastrophic Disability Review Date Invalid"
 N RESULT
 D CHK^DIE(2,.394,,DGCDIS("REVDTE"),.RESULT)
 I RESULT="^" S FILERR(RULE)=""
 Q
 ;
706 ;"CD Condition Score not valid"
 N ITEM,ERR
 S ITEM="",ERR=0
 F  S ITEM=$O(DGCDIS("COND",ITEM)) Q:ITEM=""  D
 . I '$$VALID^DGENA5(DGCDIS("COND",ITEM),$G(DGCDIS("SCORE",ITEM))) S ERR=1
 I ERR S FILERR(RULE)=""
 Q
 ;
707 ;"CD Review Date greater than CD Date of Determination"
 I $G(DGCDIS("REVDTE"))>$G(DGCDIS("DATE")) S FILERR(RULE)=""
 Q
 ;
708 ;"CD Status Affected Extremity' Invalid"
 N ITEM,EIEN,ERR
 S ITEM="",ERR=0
 F  S ITEM=$O(DGCDIS("PROC",ITEM)) Q:ITEM=""  D
 . S EIEN="" F  S EIEN=$O(DGCDIS("EXT",ITEM,EIEN)) Q:EIEN=""  D
 . . I '$$LIMBOK^DGENA5(DGCDIS("PROC",ITEM),DGCDIS("EXT",ITEM,EIEN)) S ERR=1
 I ERR S FILERR(RULE)=""
 Q
 ;
709 ;"CD Status Diagnoses' Not Valid"
 ; .396 CD STATUS DIAGNOSES field (multiple):
 N ITEM,ERR
 S ITEM="",ERR=0
 F  S ITEM=$O(DGCDIS("DIAG",ITEM)) Q:ITEM=""  D
 . I $$TYPE^DGENA5(DGCDIS("DIAG",ITEM))'="D" S ERR=1
 I ERR S FILERR(RULE)=""
 Q
 ;
710 ;"'CD Status Procedure' Not Valid"
 ; .397 CD STATUS PROCEDURES field (multiple):
 N ITEM,ERR
 S ITEM="",ERR=0
 F  S ITEM=$O(DGCDIS("PROC",ITEM)) Q:ITEM=""  D
 . I $$TYPE^DGENA5(DGCDIS("PROC",ITEM))'="P" S ERR=1
 I ERR S FILERR(RULE)=""
 Q
 ;
711 ;"'CD Status Reason' Not Present"
 I '($D(DGCDIS("DIAG"))!$D(DGCDIS("PROC"))!$D(DGCDIS("COND"))) S FILERR(RULE)=""
 Q
 ;
712 ;"'Date Of Catastophic Disability Decision' Not Valid"
 N RESULT,OK,EXTERNAL
 S OK=0
 I $G(DGCDIS("DATE"))'="" S OK=1 D
 . S EXTERNAL=$$EXTERNAL^DILFD(2,.392,"",DGCDIS("DATE"))
 . I EXTERNAL="" S OK=0 Q
 . D CHK^DIE(2,.392,,EXTERNAL,.RESULT) I RESULT="^" S OK=0
 I 'OK S FILERR(RULE)=""
 Q
 ;
713 ;"'Date Of Catastophic Disability Decision' Required"
 I $G(DGCDIS("DATE"))="" S FILERR(RULE)=""
 Q
 ;
714 ;"'Facility Making Catastrophic Disability Determination' Not Valid"
 I DGCDIS("VCD")'=""!(DGCDIS("FACDET")'=""),$$EXTERNAL^DILFD(2,.393,"",$G(DGCDIS("FACDET")))="" S FILERR(RULE)=""
 Q
 ;
715 ;"'Method Of Determination' Is A Required Value"
 I $G(DGCDIS("METDET"))="" S FILERR(RULE)=""
 Q
 ;
716 ;"'Method Of Determination' Not Valid"
 I ".2.3."'[("."_$G(DGCDIS("METDET"))_".") S FILERR(RULE)=""
 Q
 ;
717 ;"Not Enough Diagnoses/Procedures/Conditions To Qualify For CD Status"
 I '$$ISCD^DGENCDA1(.DGCDIS) S FILERR(RULE)=""
 Q
 ;
718 ;"Permanent Status Indicator' Not Valid"
 N ITEM
 S ITEM="" F  S ITEM=$O(DGCDIS("COND",ITEM)) Q:ITEM=""  D
 . I ".1.2.3."'[("."_DGCDIS("PERM",ITEM)_".") S FILERR(RULE)=""
 Q
 ;
719 ;"'Veteran Catastrophically Disabled?' Field Must Have A Response"
 ; .39 VETERAN CATASTROPHICALLY DISABLED? field.
 I DGCDIS("VCD")="" S FILERR(RULE)=""
 Q
 ;
720 ;"Veteran Has Enough Diagnoses/Procedures/Conditions To Qualify For CD Status"
 ; We check this rule at the beginning of the routine.  No need to check it here,
 ; but we need the label as a place holder.
 Q
 ;
723 ;"Catastrophic Disability Review date must be a precise date"
 N RESULT
 D CHK^DIE(2,.394,,DGCDIS("REVDTE"),.RESULT)
 I RESULT="^" S FILERR(RULE)=""
 Q
 ;
724 ;"Catastrophic Disability Date of Decision must be a precise date"
 N RESULT
 D CHK^DIE(2,.392,,DGCDIS("DATE"),.RESULT)
 I RESULT="^" S FILERR(RULE)=""
 Q
 ;
725 ;"Catastrophic Disability Procedure code must be accompanied with an Affected Extremity field"
 ; Procedure list = DGCDIS("PROC",ITEM)
 ; Affected Extremity list = DGCDIS("EXT",ITEM)
 ; This tag makes sure that there is at least one Affected Extremity for each procedure code.
 N ITEM,ERR
 S ERR=0,ITEM=""
 F  S ITEM=$O(DGCDIS("PROC",ITEM)) Q:ITEM=""  D
 . I '$D(DGCDIS("EXT",ITEM)) S ERR=1 Q
 . I $G(DGCDIS("EXT",ITEM))="" S ERR=1
 I ERR S FILERR(RULE)=""
 Q
 ;
726 ;"Catastrophic Disablity condition code requires a Score field"
 ; Condition list = DGCDIS("COND",ITEM)
 ; Score list = DGCDIS("SCORE",ITEM)
 N ITEM,ERR
 S ERR=0,ITEM=""
 F  S ITEM=$O(DGCDIS("COND",ITEM)) Q:ITEM=""  D
 . I '$D(DGCDIS("SCORE",ITEM)) S ERR=1 Q
 . I $G(DGCDIS("SCORE",ITEM))="" S ERR=1
 I ERR S FILERR(RULE)=""
 Q
 ; 
FILE ;file the inconsistencies in a temp global
 M ^TMP($J,DFN)=FILERR
 Q
 ;
