DITC0 ;SFISC/XAK-COMPARE FILE ENTRIES ;12/3/90  12:38
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; Mandatory INPUT VARIABLES using entry point EN:
 ; DFF ...... File or subfile number
 ; DIT(1) ... Internal number of first entry
 ; DIT(2) ... Internal number of second entry
 ;
 ; Optional INPUT VARIABLES using entry point EN:
 ; DIMERGE ..... If defined, allows for merge; if not, does compare only
 ; DDSP ..... If defined, writes 'wait messages and dots' to the screen
 ; DDIF ..... If undefined displays all fields
 ; DDIF=1: displays discrepant only
 ; DDIF=2: displays discrepant and missing as well
 ; DDEF ..... Entry # (1 or 2) from which to take default values.
ERREND ;
 S DMSG=$P($T(ERRTXT+DMSG),";; ",2)_": "_DMSG(1) W !,DMSG
 G END^DITC
 Q
ERRTXT ;;
 ;; Undefined INPUT VARIABLE
 ;; Null INPUT VARIABLE
 ;; Nonexistent FILE
 ;; Incorrect INPUT VARIABLE specification
HELP ;;
 W ! F I=1:1 S J=$P($T(@("HTXT"_DMSG)+I),";; ",2) Q:'$L(J)  W !,J
 Q
HTXT1 ;;
 ;; Enter a 'N' if you wish only to compare and display the two
 ;; entries.  Enter a 'Y' if you wish to choose valid fields from each
 ;; entry and eventually do a merge into record selected for default.
HTXT2 ;;
 ;; Enter a 'N' if you wish to display all of the fields in each entry.
 ;; Enter a 'Y' if you wish to display only those fields which differ.
HTXT3 ;;
 ;; On merging, the default field value can be taken from entry #1 or #2.
 ;; You will later have the opportunity to modify this default selection
 ;; on a field by field basis.  Please note that the two records will
 ;; always be merged into the record selected as the default selection.
HTXT4 ;;
 ;; When the two entries are compared, all top level fields are displayed
 ;; and a summary for multiple level fields are displayed. If you also wish to
 ;; see a detailed comparison on the multiple level fields, enter 'Y'.
 ;;
 ;;
