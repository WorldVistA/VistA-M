XTID    ;OAKCIOFO/JLG - API set for VUID-Term/Concepts in VistA ;08/18/2008 15:12
 ;;7.3;TOOLKIT;**93,108**;Apr 25, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;  API set for VUID Term/Concepts in VistA
 ; supported by IA # 4631
 ; official definition of API set can be viewed online
 ; in the VistA Document Library website
GETVUID(TFILE,TFIELD,TIREF) ;
 ;Function: Returns the VHA unique id (VUID) for a given term 
 ;  reference, TIREF.  TIREF is represented differently based 
 ;  in its context--the combined value of TFILE and TFIELD
 ; 
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (req)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TIREF =  term reference, as internal reference value.
 ; (req)    When TFIELD is defined (SET OF CODES), TIREF is the 
 ;          internal value used in the set of codes.
 ;          When TFIELD is not defined, TIREF is the IEN of the term
 ;          in TFILE.
 ; 
 ;Returns:  Returns the VHA unique id (VUID) as a number for
 ;  a given term reference.  On error, it returns  
 ;  "0^<error message>" 
 ;  
 G GETVUID^XTID1
 ;
SETVUID(TFILE,TFIELD,TIREF,TVUID) ;
 ;Function: Assigns (stores) a VHA unique id (VUID) to a given term
 ;  reference, TIREF.  TIREF is represented differently based in its 
 ;  context--the combined value of TFILE and TFIELD.
 ;  
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (req)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TIREF =  term reference, as internal reference value.
 ; (req)    When TFIELD is defined (SET OF CODES), TIREF is the 
 ;          internal value used in the set of codes.
 ;          When TFIELD is not defined, TIREF is the IEN of the term
 ;          in TFILE.
 ; TVUID =  The VUID number to assign to term reference.
 ; (req)
 ; 
 ;Returns:  Returns indication of operation as
 ;  1 for successful; or 
 ;  "0^<error message>" for unsuccessful
 ;           
 ;Modifies: updates or creates new entry in file 8985.1 or 
 ;          updates TFILE file
 ;  
 G SETVUID^XTID1
 ;
GETSTAT(TFILE,TFIELD,TIREF,TDATE) ;
 ;Function: Returns the status information for the given term (TIREF)
 ;  and date (TDATE). TIREF is represented differently based in its 
 ;  context--the combined value of TFILE and TFIELD
 ;  
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (req)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TIREF =  term reference, as internal reference value.
 ; (req)    When TFIELD is defined (SET OF CODES), TIREF is the 
 ;          internal value used in the set of codes.
 ;          When TFIELD is not defined, TIREF is the IEN of the term
 ;          in TFILE.
 ; TDATE =  FileMan date/time, defaults to NOW.
 ; (opt)
 ; 
 ;Returns:  Returns the status representation for a given 
 ;  term reference as
 ;  "<internal value>^<FileMan effective date/time>^<external value>"
 ;          where value is a set of codes (0:INACTIVE,1:ACTIVE).  
 ;          On error, it returns  
 ;  "^<error message>" 
 ;  
 G GETSTAT^XTID1
 ;
SETSTAT(TFILE,TFIELD,TIREF,TSTAT,TDATE) ;
 ;Function: Assigns (stores) status information (TSTAT and TDATE) 
 ;  to the given term reference, TIREF. TIREF is represented 
 ;  differently based in its context--the combined value of 
 ;  TFILE and TFIELD.
 ;  
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (req)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TIREF =  term reference, as internal reference value.
 ; (req)    When TFIELD is defined (SET OF CODES), TIREF is the 
 ;          internal value used in the set of codes.
 ;          When TFIELD is not defined, TIREF is the IEN of the term
 ;          in TFILE.
 ; TSTAT =  The status to assign (0 or 1).
 ; (req)    TSTAT is a set of codes (0:INACTIVE, 1:ACTIVE)
 ; 
 ; TDATE =  FileMan date/time, defaults to NOW.
 ; (opt)
 ;
 ;Returns:  Returns indication of operation
 ;  1:successful or or 
 ;  "0^<error message>" for unsuccessful
 ; 
 ;Modifies: updates entry in file 8985.1 or TFILE file
 ;  
 G SETSTAT^XTID1
 ;
GETMASTR(TFILE,TFIELD,TIREF) ;
 ;Function: Returns the MASTER VUID flag for a given term 
 ;  reference, TIREF.  TIREF is represented differently based 
 ;  in its context--the combined value of TFILE and TFIELD
 ; 
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (req)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TIREF =  term reference, as internal reference value.
 ; (req)    When TFIELD is defined (SET OF CODES), TIREF is the 
 ;          internal value used in the set of codes.
 ;          When TFIELD is not defined, TIREF is the IEN of the term
 ;          in TFILE.
 ; 
 ;Returns:  Returns the MASTER VUID value (set of codes: 0,1)
 ;          On error, it returns  
 ;  "^<error message>" 
 ;  
 G GETMASTR^XTID1
 ;
SETMASTR(TFILE,TFIELD,TIREF,TMASTER) ;
 ;Function: Assigns the MASTER VUID flag to a given term
 ;  reference, TIREF.  TIREF is represented differently based in its 
 ;  context--the combined value of TFILE and TFIELD.
 ;  
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (req)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TIREF =  term reference, as internal reference value.
 ; (req)    When TFIELD is defined (SET OF CODES), TIREF is the 
 ;          internal value used in the set of codes.
 ;          When TFIELD is not defined, TIREF is the IEN of the term
 ;          in TFILE.
 ; TMASTER =  The MASTER VUID flag value to assign to term reference.
 ; (req)
 ; 
 ;Returns:  Returns indication of operation as
 ;  1 for successful; or 
 ;  "0^<error message>" for unsuccessful
 ;           
 ;Modifies: updates entry in file 8985.1 or TFILE file
 ;  
 G SETMASTR^XTID1
 ;
GETIREF(TFILE,TFIELD,TVUID,TARRAY,TMASTER) ;
 ;Function: Returns a list of Terms' internal references (IREF) for 
 ;  a given  VUID (TVUID).  A term's file (TFILE) and field limit 
 ;  the size of the list to those terms found in a given file/field.  
 ;  TIREF is represented differently based in its context--the 
 ;  combined value of TFILE and TFIELD.
 ;  
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (opt)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TVUID =  term's VHA unique id.
 ; (req)    
 ; 
 ;Output:
 ; TARRAY =  name of local or global array that will contain the 
 ; (opt)    list of terms as
 ; 
 ;       ARRAY(TFILE,TFIELD,TIREF)= status
 ;           on error it returns
 ;       ARRAY("ERROR")="<error message>"
 ;          
 G GETIREF^XTID1
 ;
SCREEN(TFILE,TFIELD,TIREF,TDATE,TCACHE) ;
 ;Function: Returns the screening condition for the given term (TIREF) 
 ;  and date (TDATE).  TIREF is represented differently based in its 
 ;  context--the combined value of TFILE and TFIELD.
 ;  
 ;Input:
 ; TFILE =  VistA file # where term is defined.
 ; (req)
 ; TFIELD = field #, in TFILE where term is defined.
 ; (opt)    When defined, it must be of type SET OF CODES.
 ;          When not defined, TFILE represents a "table" of terms
 ; TIREF =  term reference, as internal reference value.
 ; (req)    When TFIELD is defined (SET OF CODES), TIREF is the 
 ;          internal value used in the set of codes.
 ;          When TFIELD is not defined, TIREF is the IEN of the term
 ;          in TFILE.
 ; TDATE =  FileMan date/time, defaults to NOW.
 ; (opt)
 ; TCACHE = A local variable passed by reference.  It must be KILLed
 ; (opt)    before initiating each search query (e.g. before calling
 ;          the ^DIC).  Using this parameter speeds up the search
 ;          (especially in big files).
 ;          
 ;    Note: This parameter keeps internal values between calls to the
 ;          screen logic.  Do not make any assumptions regarding its
 ;          value and do not use it in your code!
 ; 
 ;Returns:  0 (i.e. don't screen) if the term is/was active or 
 ;          1 if the term is/was inactive (i.e. screen).
 ;          
 G SCREEN^XTID1
 ;
