XVEMSF9 ;DJB/VSHL**DIWF [07/16/94];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIWF ;;;
 ;;; D I W F     Form Document Print
 ;;;
 ;;; DIWF uses contents of a word processing field as a target document into which
 ;;; data can be inserted at print time. The data may come from another file or be
 ;;; provided by the user interactively when the document is printed. The word
 ;;; processing text uses windows into which data from the target file gets
 ;;; inserted by DIWF. Any nonmultiple field label or computed expression can be
 ;;; used within a "|" window. If the expression can't be evaluated or the field
 ;;; doesn't exist, and the output is being sent to a different terminal than
 ;;; the one used to call up the output, then the user will be asked to type in
 ;;; a value for the window, for each data entry printed.
 ;;;
 ;;; 1. ENTRY POINT: ^DIWF
 ;;;    Invoking DIWF at the top results in an interactive dialogue:
 ;;;         Select Document File: FORM LETTER
 ;;;         Select DOCUMENT: APPOINTMENT REMINDER
 ;;;         Print from what FILE: EMPLOYEE
 ;;;         WANT EACH ENTRY ON A SEPARATE PAGE? YES//
 ;;;         SORT BY: NAME// FOLLOWUP DATE=MAY 1, 1986
 ;;;         DEVICE:
 ;;;    In this example, the word processing text found in the APPOINTMENT
 ;;;    REMINDER entry of the FORM LETTER file is used to print a sheet of output
 ;;;    for each entry in the EMPLOYEE file whose FOLLOWUP DATE equals May 1,1986.
 ;;;
 ;;;    If the document file contains a pointer field pointing to file #1, and if
 ;;;    the document entry selected has a value for that pointer, then the file
 ;;;    pointed to will be used to print from and the user will not be asked
 ;;;    "Print from what FILE:".
 ;;;    NOTE: Read access is checked for both files selected.
 ;;;
 ;;; 1. ENTRY POINT: EN1^DIWF
 ;;;    This entry point is used when calling program knows which file contains
 ;;;    the desired word processing text to be used as a target document.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC......Global root or file number.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y........-1 only if the DIC file doesn't contain a word processing field.
 ;;;
 ;;; 1. ENTRY POINT: EN2^DIWF
 ;;;    This entry point is used when calling program knows both the document file
 ;;;    and the entry within that file which contains the desired word processing
 ;;;    text to be used as a target document.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIWF......Global root at which text is stored. Thus, if APPOINTMENT
 ;;;    REMINDER is the third document in the FORM LETTER file (^DIZ(16001,) and
 ;;;    the word processing field is stored in subscript 1, you can:
 ;;;         SET DIWF="^DIZ(16001,3,1,"
 ;;;    DIWF(1)...If calling program wants to specifiy which file should be used
 ;;;    as a source for generating output, the number of the file should be in
 ;;;    DIWF(1). Otherwise, the user will be asked the "Print from what FILE:"
 ;;;    question.
 ;;;
 ;;;    After this point, EN1^DIP is invoked. The calling program can set the
 ;;;    usual BY, FR, and TO variables if it wants to control the SORT sequence.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y........Will be -1 if:
 ;;;                There is no data beneath the root passed in DIWF.
 ;;;                The file passed in DIWF(1) could not be found.
 ;;;***
