LHSRPC ;ALB/BNT - LIGHTHOUSE RPCS ;30-MAR-2021
 ;;1.0;LIGHTHOUSE;****;30-MAR-2021;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; $$ACCESS^XQCHK               10078
 ;
 Q
 ;
OPT(RETURN,USER,OPTION) ; RPC: LHS CHECK OPTION ACCESS
 ; Input: USER   = DUZ of user being checked for access
 ;        OPTION = IEN or NAME of entry in the OPTION file #19
 ;
 ; -1:no such user in the New Person File 
 ; -2: User terminated or has no access code 
 ; -3: no such option in the Option File 
 ; 0: no access found in any menu tree the user owns 
 ; 
 ;     All other cases return a 4-piece string stating 
 ;     access ^ menu tree IEN ^ a set of codes ^ key 
 ; 
 ; O^tree^codes^key: No access because of locks (see XQCODES below) 
 ;   where 'tree' is the menu where access WOULD be allowed 
 ;   and 'key' is the key preventing access 
 ; 1^OpIEN^^: Access allowed through Primary Menu 
 ; 2^OpIEN^codes^: Access found in the Common Options 
 ; 3^OpIEN^codes^: Access found in top level of secondary option 
 ; 4^OpIEN^codes^: Access through a the secondary menu tree OpIEN.  
 ;
 ; XQCODES can contain: 
 ;   N=No Primary Menu in the User File (warning only) 
 ;   L=Locked and the user does not have the key (forces 0 in first piece) 
 ;   R=Reverse lock and user has the key (forces 0 in first piece) 
 ;
 S RETURN=$$ACCESS^XQCHK(USER,OPTION)
 Q
