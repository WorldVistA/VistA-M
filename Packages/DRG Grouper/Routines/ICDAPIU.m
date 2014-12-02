ICDAPIU ;DLS/DEK/KER - ICD UTILITIES FOR APIS ;04/21/2014
 ;;18.0;DRG Grouper;**6,11,12,15,57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    None
 ;               
 Q
EN ; Main Entry Point
HELP ; Developer Help for an API
 D HLP^ICDEXH("LEG") Q
 ;
DTBR(CDT,CS) ; Date Business Rules
 ;
 ; Input:   
 ; 
 ;     CDT   Code Date to check default TODAY
 ;     CS    Code System (Default 0 = ICD)
 ;     
 ; Output:  
 ; 
 ;     If CDT < ICD-9 Date and CS=0, use ICD-9 Date
 ;     If CDT < 2890101 and CS=1, use 2890101
 ;     If CDT < 2821001 and CS=2, use 2821001
 ;     If CDT is year only, use first of the year
 ;     If CDT is year and month only, use first of the month
 ;     
 Q $$DTBR^ICDEX($G(CDT),$G(CS))
MSG(CDT,CS) ; Inform of code text inaccuracy
 ;
 ; Input:   
 ; 
 ;     CDT   Code Date to check (FileMan format, Default = today)
 ;     CS    Code System (0:ICD, 1:CPT/HCPCS, 2:DRG, 3:LEX, Default=0)
 ;          
 ; Output:  
 ; 
 ;     User Alert
 ;     
 Q $$MSG^ICDEX($G(CDT),$G(CS))
STATCHK(CODE,CDT) ; Check Status of ICD Code
 ;
 ; Input:
 ; 
 ;     CODE  ICD Code
 ;     CDT   Date to screen against
 ;     
 ; Output:
 ; 
 ;     3-Piece String containing Status, IEN and Effective Date
 ;     
 Q $$STATCHK^ICDEX($G(CODE),$G(CDT))
NEXT(CODE) ; Next ICD Code (active or inactive)
 ;
 ; Input:
 ; 
 ;     CODE  ICD Code   REQUIRED
 ;     
 ; Output:  
 ; 
 ;     The Next ICD Code, Null if none
 ;     
 Q $$NEXT^ICDEX($G(CODE))
PREV(CODE) ; Previous ICD Code (active or inactive)
 ;
 ; Input:
 ; 
 ;     CODE   ICD Code   REQUIRED
 ;     
 ; Output:
 ; 
 ;     The Previous ICD Code, Null if none
 ;     
 Q $$PREV^ICDEX($G(CODE))
 ;
HIST(CODE,ARY)  ; Activation History
 ;
 ; Input:
 ; 
 ;     CODE   ICD Code                     REQUIRED
 ;    .ARY    Array, passed by Reference   REQUIRED
 ;   
 ; Output:
 ; 
 ;     Mirrors ARY(0) (or, -1 on error)
 ;     ARY(0) = Number of Activation History Entries
 ;     ARY(<date>) = status    where: 1 is Active
 ;     ARY("IEN") = <ien>
 ;     
 Q $$HIST^ICDEX($G(CODE),.ARY)
PERIOD(CODE,ARY) ; Return Activation/Inactivation Period in ARY
 ;
 ; Input:
 ; 
 ;     CODE  ICD Code (required)
 ;     ARY   Array, passed by Reference (required)
 ;     
 ; Output:
 ; 
 ;     ARY(0) = IEN ^ Selectable ^ Error Message
 ;          
 ;       Where IEN = -1 if error
 ;       Selectable = 0 for unselectable
 ;       Error Message if applicable
 ;            
 ;     ARY(Activation Date) = Inactivation Date^Short Name
 ;
 ;       Where the Short Name is versioned as follows:
 ;
 ;       Period is active   - Text for TODAY's date
 ;       Period is inactive - Text for inactivation date
 ;     
 N X S X=$$PERIOD^ICDEX($G(CODE),.ARY) Q
