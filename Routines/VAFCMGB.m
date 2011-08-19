VAFCMGB ;ALB/JRP,PTD-DEMOGRAPHIC MERGE SCREEN BUILDER ;18-OCT-1996
 ;;5.3;Registration;**149,479**;Aug 13, 1993
 ;
 ;NOTE: The VAFCMGB* routines contain line tags used to build the
 ;      display screen of a List Manager interface.  All line tags
 ;      assume that the following variables are defined and contained
 ;      in the local partition.
 ;
 ;Input  : VAFCDFN - Pointer to entry in PATIENT file (#2) to merge
 ;                   data into
 ;         VAFCARR - Array contain data to merge (full global reference)
 ;                   VAFCARR() should be set as follows:
 ;                     VAFCARR(File,Field) = Value
 ;                       Where File = File number Value is from
 ;                             Field = Field number Value is from
 ;                             Value = Info to merge
 ;                       Notes: Dates must be in FileMan format
 ;                            : Special considerations for Value
 ;                                "@"  - Displays <DELETE> and deletes
 ;                                       local value if merged
 ;                                "^text"  - Displays text and ignores
 ;                                           field if merged
 ;                                NULL  - Displays <UNSPECIFIED> and
 ;                                        ignores field if merged
 ;                                Doesn't exist  - Displays <UNSPECIFIED>
 ;                                                 and ignores field
 ;                                                 if merged
 ;         VAFCFROM - Text denoting where merge data cam from (1-35)
 ;         VAFCEVDT - Date/time merge data was instantiated (FileMan)
 ;         VAFCDOTS - Flag indicating if progress dots should be printed
 ;                    0 = No
 ;                    1 = Yes
 ;         All variables set by List Manager Interface
 ;Output : Display area and variables required List Manager interface
 ;         Display
 ;           VALMAR(Line,0) = Line of text in display
 ;         Indexes
 ;           VALMAR("IDX",Line,Entry) = ""
 ;           VALMAR("E2F",Entry,N) = File^Field
 ;             N => Allows for multiple fields per entry (starts with 1)
 ;           VALMAR("E2G",Entry) = Group entry is contained in
 ;           VALMAR("GRP",Group) = First line of group in display
 ;             Note: The E2F and E2G indexes are only set if the data
 ;                   to merge does not match the local data
 ;Notes  : Existance/validity of input variables is assumed
 ;       : Dates are converted to internal format for comparison
 ;       : Phone # are converted to HL7 format for comparison & display
 ;
BLDALL ;Main entry point to build entire List Manager display
 ;
 ;Input  : See note above
 ;Output : See note above
 ;
 ;Declare variables
 N LASTNTRY
 ;Build logical group 1
 D GROUP1^VAFCMGB0
 ;White space
 S LASTNTRY=+$O(@VALMAR@("IDX",VALMCNT-1,0))
 S @VALMAR@(VALMCNT,0)=" "
 S @VALMAR@("IDX",VALMCNT,LASTNTRY)=""
 S VALMCNT=VALMCNT+1
 ;Build logical group 2
 D GROUP2^VAFCMGB1
 ;White space
 ;S LASTNTRY=+$O(@VALMAR@("IDX",VALMCNT-1,0))
 ;S @VALMAR@(VALMCNT,0)=" "
 ;S @VALMAR@("IDX",VALMCNT,LASTNTRY)=""
 ;S VALMCNT=VALMCNT+1
 ;Build logical group 3
 D GROUP3^VAFCMGB2
 ;White space - eliminated with **479
 ;S LASTNTRY=+$O(@VALMAR@("IDX",VALMCNT-1,0))
 ;S @VALMAR@(VALMCNT,0)=" "
 ;S @VALMAR@("IDX",VALMCNT,LASTNTRY)=""
 ;S VALMCNT=VALMCNT+1
 ;S @VALMAR@(VALMCNT,0)=" "
 ;S @VALMAR@("IDX",VALMCNT,LASTNTRY)=""
 ;S VALMCNT=VALMCNT+1
 ;Build logical group 4
 D GROUP4^VAFCMGB3
 ;Done
 Q
 ;
RBLDGRP(GROUP) ;Rebuild specified group in List Manager display
 ;
 ;Input  : GROUP - Number denoting which logical group in display
 ;                 should be rebuilt
 ;                 Groups 1, 2, 3, and 4 are currently supported
 ;         See above note on input variables
 ;Output : See above note on output
 ;
 ;Check input
 S GROUP=+$G(GROUP)
 ;Declare variables
 N VALMCNT
 ;Get starting line number of group
 S VALMCNT=+$G(@VALMAR@("GRP",GROUP))
 ;Rebuild logical group 1 - done
 I (GROUP=1) D GROUP1^VAFCMGB0 Q
 ;Rebuild logical group 2 - done
 I (GROUP=2) D GROUP2^VAFCMGB1 Q
 ;Rebuild logical group 3 - done
 I (GROUP=3) D GROUP3^VAFCMGB2 Q
 ;Rebuild logical group 4 - done
 I (GROUP=4) D GROUP4^VAFCMGB3 Q
 ;Done - did nothing
 Q
