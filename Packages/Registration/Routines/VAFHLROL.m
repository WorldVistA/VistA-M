VAFHLROL ;BP/JRP - BUILD HL7 ROLE SEGMENT;11/18/1997 ; 6/14/01 12:52pm
 ;;5.3;Registration;**160,215,389**;Aug 13, 1993
 ;
 ;Entry from top of routine not allowed - must use supported line tags
 Q
 ;
OUTPAT(PARAM,OUTARR,FIELDS,FLDSEP,ENCODE,NULL,MAXLEN) ;Build segment for
 ; transmission of outpatient data
 ;
 ;Input  : PARAM - Array, subscripted by paramter name, that contains
 ;                 information specific to building of segment
 ;                 (full global reference)
 ;               - Supported parameters/subscripts listed below
 ;         OUTARR - Output array (full global reference)
 ;                - Defaults to ^TMP("VAFHLROL",$J)
 ;         FIELDS - List of fields (sequence numbers) to include
 ;                  seperated by commas
 ;                - Defaults to all required fields (1-4)
 ;         FLDSEP - HL7 field seperator (1 character)
 ;                - Defaults to ^ (carrot)
 ;         ENCODE - HL7 encoding characters (4 characters)
 ;                - Defaults to ~|\& (tilde bar backslash ampersand)
 ;         NULL - HL7 null designation
 ;              - Defaults to "" (quote quote)
 ;         MAXLEN - Maximum length of a single line in the segment
 ;                  array (i.e. when to wrap to next node in output)
 ;                - Defaults to 245
 ;Output : None
 ;           OUTARR(0) will contain ROL segment (first MAXLEN characters)
 ;           OUTARR(1) will contain rest of ROL segment (if needed)
 ;
 ;           Errors associated to required data elements returned in
 ;             OUTARR("ERROR",Seq#,x) = Error text
 ;
 ;           Errors associated to optional data elements returned in
 ;             OUTARR("WARNING",Seq#,x) = Error text
 ;
 ;Subscripts for PARAM array :  (Sample use: @PARAM@("PTRVPRV")=1234)
 ;  PTR200 - Pointer to entry in NEW PERSON file (#200)
 ;         - ** Required if not using ROLE and PERSON parameters **
 ;         - Definition of calculated ROLE found in ROLE^VAFHLRO3()
 ;         - Definition of calculated PERSON found in PERSON^VAFHLRO3()
 ;  CODEONLY - Flag indicating if calculations for ROLE & PERSON should
 ;             only include their coded/table values
 ;                1 = Yes (internal only)
 ;                0 = No (internal & external) (default)
 ;           - Value not applied to input values of ROLE & PERSON
 ;  INSTID - Value to use for Role Instance ID (seq #1)
 ;         - ** Required **
 ;  ACTION - Value to use for Action Code (seq #2)
 ;         - AD (Add)   UP (Update)  DE (Delete)     CO (Correct)
 ;           LI (Link)  UN (Unlink)  UC (Unchanged)
 ;         - ** Required **
 ;  ROLE  - Value to use for first three components of Role (seq #3)
 ;        - Use this parameter to over-ride calculation based on PTR200
 ;  ALTROLE - Value to use for last three components of Role (seq #3)
 ;          - Use this parameter to include alternate role
 ;  PERSON - Value to use for Role Person (seq #4)
 ;         - Use this parameter to over-ride calculation based on PTR200
 ;         - note that only values for the 1st instance can be
 ;           passed, i.e., do not pass provider SSN
 ;  RDATE  - (optional) Use this parameter to obtain person role
 ;         - "as of" the date specified.  The current date will be used
 ;         - if this parameter is undefined.
 ;
 ;Notes  : Sequence numbers 5 - 8 are not currently supported
 ;       : OUTARR() will be initialized (i.e. KILLed) on input
 ;       : OUTARR(0) will be set to NULL on bad input
 ;       : The local array VAFHLROL() is internally used for building
 ;         of the segment and should not be used as the output array
 ;
 ;Check input
 S PARAM=$G(PARAM)
 S OUTARR=$G(OUTARR,$NA(^TMP("VAFHLROU",$J)))
 S FIELDS=$G(FIELDS,"1,2,3,4")
 S FLDSEP=$G(FLDSEP,"^")
 S:($L(FLDSEP)'=1) FLDSEP="^"
 S ENCODE=$G(ENCODE,"~|\&")
 S:($L(ENCODE)'=4) ENCODE="~|\&"
 S:('$D(NULL)) NULL=$C(34,34)
 S MAXLEN=+$G(MAXLEN)
 S:(MAXLEN<1) MAXLEN=245
 ;Call outpatient segment builder
 D OUTPAT^VAFHLRO2
 ;Done
 Q
