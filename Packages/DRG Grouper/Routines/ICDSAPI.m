ICDSAPI ;ISL/KER - ICD Search API ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;               
EN ; Main Entry Point
HELP ; Developer Help for an API
 D HLP^ICDEXH("SDD") Q
 ;
SEARCH(FILEID,SCREEN,DISFIL,DATE) ; 
 ;
 ; Input:
 ;
 ;    FILEID     This can be either a file number, a file root,
 ;               a file identifier, a coding system or a source
 ;               abbreviation that can be resolved to a file
 ;               number.  FILEID may be in the form of a file
 ;               number, a global root, a coding system (1, 2, 
 ;               30 OR 31), a source abbrevation (ICD, ICP,
 ;               10D or 10P) or a mnemonic (DIAG or PROC).
 ;      
 ;    SCREEN     This is a string of MUMPS code that is 
 ;               executed to screen an entry from selection.
 ;               It must contain an IF statement to set the
 ;               value of $T.  Those entries that the IF 
 ;               statement sets $T to 0 (false) will not be
 ;               displayed or selectable. 
 ;
 ;    DISFIL       A string of alphabetic characters which 
 ;               alter how the lookup responds. Default 
 ;               value "AEMQZ".  DIC(0) will be set to the
 ;               contents of this parameter.
 ; 
 ;               Parameters applicable to a versioned file
 ;               
 ;                 A   Ask the entry; if erroneous, ask again
 ;                 B   Only the B index is used
 ;                 E   Echo information
 ;                 F   Forget the lookup value
 ;                 I   Ignore the special lookup program
 ;                 M   Multiple-index lookup allowed
 ;                 N   Uppercase, IEN lookup allowed (not forced)
 ;                 O   Only find one entry if it matches exactly
 ;                 S   Suppresses display of .01
 ;                 T   Search until user selects or enters ^^
 ;                 X   EXact match required 
 ;                 Z   Zero node in Y(0), external form in Y(0,0)
 ;                 
 ;               Parameters not Applicable to a versioned file
 ;               and ignored by this lookup
 ;               
 ;                 C   Versioned cross-references not turned off
 ;                 K   Primary Key not established
 ;                 L   Learning a new entry LAYGO not allowed
 ;                 n   ICD has no pure numeric entries
 ;                 Q   Input is pre-processed, ?? not necessary
 ;                 U   All values are external
 ;                 V   Verification is not optional
 ;       
 ;    DATE        Versioning Date (Fileman format)
 ;    
 ;                  If supplied only active codes on that date
 ;                  will be included in the selection list.
 ;               
 ;                  If not supplied, the date will default to
 ;                  TODAY and all codes may be selected, active
 ;                  and inactive.
 ;               
 ;                  In both cases the display will be altered
 ;                  based on the date.
 ;    
 ;    ICDFMT     Output Format
 ;   
 ;                 1  Fileman, Code and Short Text (default)
 ;             
 ;                    250.00    DMII WO CMP NT ST UNCNTR
 ;                
 ;                 2  Fileman, Code and Description
 ;             
 ;                    250.00    DIABETES MELLITUS WITHOUT 
 ;                              MENTION OF COMPLICATION, TYPE 
 ;                              II OR UNSPECIFIED TYPE, NOT 
 ;                              STATED AS UNCONTROLLED
 ;                          
 ;                 3  Lexicon, Short Text and Code
 ;             
 ;                    DMII WO CMP NT ST UNCNTR (250.00)
 ;                
 ;                 4  Lexicon, Description and Code
 ;             
 ;                    DIABETES MELLITUS WITHOUT MENTION OF 
 ;                    COMPLICATION, TYPE II OR UNSPECIFIED TYPE,
 ;                    NOT STATED AS UNCONTROLLED (250.00)
 ;         
 ; Output:
 ; 
 ;    $$SEARCH   This is the value of Y (below)
 ;    
 ;    Y          IEN ^ Code           Fileman
 ;    
 ;               or
 ;               
 ;               -1 iF not found
 ;    
 ;    If DISFIL/DIC(0) containg the character "Z"
 ;    
 ;      Y(0)     0 Node               Fileman
 ;      Y(0,0)   Code                 Fileman
 ;      Y(0,1)   $$ICDDX or $$ICDOP   Non-Fileman
 ;      Y(0,2)   Long Description     Non-Fileman
 ;    
 N ROOT,FILE,SYS,ICDVDT
 S FILE=$$FILE^ICDEX($G(FILEID)) Q:+FILE'>0 -1
 S (DIC,ROOT)=$$ROOT^ICDEX(FILE) Q:'$L(ROOT) -1
 S DIC("S")=$S($L($G(SCREEN)):$G(SCREEN),1:"I 1")
 S:$G(DATE)?7N ICDVDT=$G(DATE)
 S SYS=$$SYS^ICDEX(FILE,$G(ICDVDT)) S:+SYS>0 ICDSYS=+SYS
 S DISFIL=$G(DISFIL,"AEMQZ") S DISFIL=$TR(DISFIL,"L","") K DLAYGO
 S DIC(0)=DISFIL D ^DIC S:+($G(Y))'>0 Y=-1 K DIC,ICDSYS,ICDFMT
 Q Y
