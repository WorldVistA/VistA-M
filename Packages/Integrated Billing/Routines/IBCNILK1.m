IBCNILK1 ;ALB/DW - Insurance Company Selection (cont.) ; 02-JAN-2026
 ;;2.0;INTEGRATED BILLING;**827**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
 Q  ; no direct calls
 ;
GETFILT() ; Gets the Insurance company filter
 ; Due to routine size of IBCNILK, GETFILT^IBCNILK now calls this
 ; 
 ; Input:   None
 ; Returns: A^B^C Where:
 ;           A - 1 - Search for Insurance Companies that begin with
 ;                   the specified text (case insensitive)
 ;               2 - Search for Insurance Companies that contain
 ;                   the specified text (case insensitive)
 ;               3 - Search for Insurance Companies in a specified
 ;                   range (inclusive, case insensitive)
 ;           B - Begin with text if A=1, Contains Text if A=2 or
 ;               the range start if A=3
 ;           C - Range End text (only present when A=3)
 ;         -1 if a valid filter was not selected
 ;          ^ if user wants to exit
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILTER,X,XX,Y
 ;
 ; First ask what kind of filter to use
 W !
 S DIR(0)="SA^1:Begins with;2:Contains;3:Range"
 S DIR("A")="     SELECT 1, 2 or 3: "  ;IB*763/CKB
 S DIR("A",1)=" 1 - Select Insurance Companies that Begin with: XXX"
 S DIR("A",2)=" 2 - Select Insurance Companies that Contain: XXX"
 S DIR("A",3)=" 3 - Select Insurance Companies in Range: XXX - YYY"
 S DIR("B")=1
 S DIR("?",1)="Select the type of filter to determine what Insurance Companies"
 S DIR("?",2)="will be displayed as follows:"
 S DIR("?",3)="   Begins with - Displays all insurance companies that begin with"
 S DIR("?",4)="                 the specified text (inclusive, case insensitive)"
 S DIR("?",5)="   Contains    - Displays all insurance companies that contain"
 S DIR("?",6)="                 the specified text (inclusive, case insensitive)"
 S DIR("?",7)="   Range       - Displays all insurance companies within the "
 S DIR("?")="                 the specified range (inclusive, case insensitive)"
 S XX="1:Begins with;2:Contains;3:Range"
 D ^DIR
 I Y="^" Q Y                                ; allow user to exit
 I $D(DTOUT)!$D(DUOUT) Q -1                 ; No valid search selected
 S FILTER=Y
 ;
 ; Next ask for 'Begin with', 'Contains' or 'Range Start' text
 W !
 K DIR
 S DIR(0)="F^1;30"
 S XX=$S(FILTER=1:"that begin with",FILTER=2:"that contain",1:"Start of Range")
 S DIR("A")="     SELECT Insurance Companies "_XX
 I FILTER=1 D
 . S DIR("?")="Enter text that each Insurance Company name will begin with"
 I FILTER=2 D
 . S DIR("?")="Enter text that each Insurance Company name will contain"
 I FILTER=3 D
 . S DIR("?")="Enter the starting range text"
 D ^DIR K DIR
 I Y="^" Q Y                                ; allow user to exit
 I $D(DTOUT)!$D(DUOUT) Q -1                 ; No valid search selected
 S $P(FILTER,"^",2)=Y
 Q:$P(FILTER,"^",1)'=3 FILTER
 ;
 ; Finally, ask for 'Range End' text if using a range filter
 W !
 K DIR
 S DIR(0)="F^1;30"
 S DIR("A")="     SELECT Insurance Companies End of Range"
 S DIR("B")=$P(FILTER,"^",2)
 S DIR("?")="Enter the ending Range text"
 D ^DIR
 I Y="^" Q Y                                ; allow user to exit
 I $D(DTOUT)!$D(DUOUT) Q -1                 ; No valid search selected
 S $P(FILTER,"^",3)=Y
 Q FILTER
 ;
