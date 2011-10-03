DGPTAPA4 ;ALB/MTC - PTF ARCHIVE HEADER ; 12-04-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;
MKHEAD ;-- write header
 N SEQ,OSEQ,REF,TXT
 S OSEQ=$G(^DGP(45.62,DGTMP,100,0)) Q:OSEQ']""
 S SEQ=$P(OSEQ,U,3),REF="^DGP(45.62,"_DGTMP_",100)",SEQ=SEQ+1
 F I=1:1 S TXT=$P($T(HEADTXT+I),";;",2) Q:TXT="END"  S @REF@(SEQ,0)="$"_TXT,SEQ=SEQ+1
 ;-- update
 S $P(^DGP(45.62,DGTMP,100,0),U,3,4)=SEQ_U_SEQ
 Q
 ;
HEADTXT ;-- This is the header text describing the format of the records.
 ;;Each archived PTF record may contain the following records in the
 ;;Archive File. These records correspond to the <101>, <401>, <501>
 ;;and <701> screens in PTF. Each field in the record is delimited
 ;;by a "^". All records begin with the original PTF record number
 ;;followed by the record type. For example:
 ;; <PTF #>^"501"^...
 ;; <PTF #>^"401"^...
 ;; All comments contained in the Archive file will have a "$" in the
 ;;first column.
 ;; All records are terminated by a <CR><LF>.
 ;;The following description will describe the "pieces" of each record
 ;;archived. A piece is a section deliminated by a "^".
 ;;The <101> and <701> data will be contained in the following record:
 ;; Piece #     Data
 ;;   1         PTF Record number
 ;;   2         Patient Name
 ;;   3         Admission Date
 ;;   4         Discharge Date
 ;;   5         Discharge Specialty
 ;;   6         Type of Disposition
 ;;   7         Discharge Status
 ;;   8         Outpatient Treatment
 ;;   9         ASIH Days
 ;;  10         C&P Status
 ;;  11         VA Auspices
 ;;  12         Income
 ;;  13-22      ICD Codes
 ;;  23         Suicide Indicator
 ;;  24         Legionnaire's Disease Indicator
 ;;  25         Substance Abuse
 ;;  26         Psychiatry Classification Severity
 ;;  27         Current Functional Assessment
 ;;  28         Highest Level Psych Classification
 ;;The <401> record will be contained in the following record format.
 ;;These records may not be present for the episode of care described
 ;;by this PTF record. In addition, for each <401> there may be an
 ;;associated <401P>.
 ;;<401> Record.
 ;; Piece #     Data
 ;;   1         PTF Record Number
 ;;   2         "401"
 ;;   3         Sequence Number (for multiple <401>s)
 ;;   4         Surgery Date
 ;;   5         Surgical Specialty
 ;;   6         Category of Chief Surgeon
 ;;   7         Category of First Assistant
 ;;   8         Principal Anesthetic
 ;;   9         Source of Payment
 ;;  10-14      ICD Codes
 ;;  15         Kidney Source
 ;;<401P> Record.
 ;; Piece #     Data
 ;;   1         PTF Record Number
 ;;   2         "401P"
 ;;   3         Sequence Number (will match a <401> record)
 ;;   4-9       Procedure Codes
 ;;There will be at least one <501> record for the episode of care
 ;;described by this PTF record.
 ;;<501> Record.
 ;; Piece #     Data
 ;;   1         PTF Record Number
 ;;   2         "501"
 ;;   3         Sequence Number
 ;;   4         Movement Date
 ;;   5         Treated for SC Condition
 ;;   6         Leave Days
 ;;   7         Pass Days
 ;;   8         Losing Specialty
 ;;   9-18      ICD Codes
 ;;  19         Suicide Indicator
 ;;  20         Legionnaire's Disease Indicator
 ;;  21         Substance Abuse
 ;;  22         Psychiatry Classification Severity
 ;;  23         Current Functional Assessment
 ;;  24         Highest Level Psych Classification
 ;;The <535> record is present only for ward specialty movements
 ;;for the patient if a transfer from one ward to another resulted
 ;;in a specialty change.
 ;;<535> Record.
 ;; Piece #     Data
 ;;   1         PTF Record Number
 ;;   2         "535"
 ;;   3         Sequence Number
 ;;   4         Movement Date
 ;;   5         Losing Ward Specialty
 ;;   6         Leave Days
 ;;   7         Pass Days
 ;;   8         Losing Ward
 ;;The <601> will not be present for all episodes of care.
 ;;<601> Record.
 ;; Piece #     Data
 ;;   1         PTF Record Number
 ;;   2         "601"
 ;;   3         Sequence Number
 ;;   4         Procedure Date
 ;;   5         Specialty
 ;;   6         Dialysis Type
 ;;   7         Number of Treatments
 ;;   8-12      Procedure Codes
 ;;END
