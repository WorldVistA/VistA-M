TIUFXHL1 ;SLC/MAM - ?? XQORM Help, ? COPY Help ;;7-6-95 9:00pm
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
MENU ; Help for protocol TIUF CHANGE SORT MENU
 W !," Enter 'S' to change the entry you want to Start the list with"
 I $P(TIUFTMPA,U)'="A" W !," Enter 'V' to change the Value of the ",$P(TIUFTMPA,U,2) ;Exclude All
 W !," Enter 'A' to change the sort Attribute to something other than ",$P(TIUFTMPA,U,2),!
 Q
ATTRIB ; Help for protocols TIUF SORT, TIUF CHANGE SORT ATTRIBUTE
 I $G(TIUFXNOD)["Sort" W !
 W !,"T    Type                 S    Status        P    Parentage"
 W !,"O    Owner                U    In Use        A    All Docmt Defs"
 I $G(TIUFXNOD)["Sort" W !
 W !," Enter the Attribute you want to sort by, or enter 'A' to get All Document",!,"Definitions",!
 I $G(TIUFXNOD)["Sort" W !
 Q
 ;
OWNER ; Help for protocol TIUF SORT BY OWNER
 I $G(TIUFXNOD)["Sort" W !
 W !,"Choose from:"
 W !,"P  Personal      C  Class       I  Individual      N  None",!
 I $G(TIUFXNOD)'["Sort" D PAUSE^TIUFXHLX G:$D(DIRUT) OWNEX
 W !," Enter 'P' to get entries personally owned by a particular Person"
 W !," Enter 'C' to get entries owned by a particular User Class"
 I $G(TIUFXNOD)'["Sort" W ! D PAUSE^TIUFXHLX G:$D(DIRUT) OWNEX
 W !," Enter 'I' to get entries owned by a particular Individual, either personally OR",!,"because the Individual belongs to an Owning User Class"
 W !," Enter 'N' to get entries with NO Owner.",!
 I $G(TIUFXNOD)'["Sort" D PAUSE^TIUFXHLX
OWNEX W !
 Q
 ;
PARENT ; Help for protocol TIUF SORT BY PARENTAGE
 I $G(TIUFXNOD)["Sort" W !
 W !,"Choose from:     O   Orphan            N   NonOrphan"
 I $G(TIUFXNOD)["Sort" W !
 W !," Enter 'O' for Orphans, entries which don't belong to the Clinical",!,"Documents Hierarchy."
 W !," Enter 'N' for NonOrphans, entries which DO belong to the Hierarchy.",!
 I $G(TIUFXNOD)["Sort" W !
 Q
 ;
USED ; Help for protocol TIUF SORT BY USED BY DOCMTS
 I $G(TIUFXNOD)["Sort" W !
 W !," Enter 'YES' if you want entries that are In Use by documents in the TIU",!,"Document file, i.e. that have TIU documents using them as their Document",!,"Definition.  Enter 'NO' if you want entries that are NOT In Use.",!!
 Q
 ;
NOP ; Help for protocol TIUFHA ACTION EDIT NAME/OWNER/PNAME
 W !,"Choose from: N   Name            O   Owner         P   Print Name",!
 Q
 ;
COPY ; Help for action Copy (Activate prompt)
 W !,"To determine whether the behavior has changed, compare inherited values on the"
 W !,"Detailed Display for the Copy with those on the Detailed Display for the old"
 W !,"Title.  Compare Upload information on the Detailed Displays for the new and old"
 W !,"DOCUMENT CLASSES.  Next, compare Business Rules for the new and old DOCUMENT"
 W !,"CLASSES.  This takes care of inheritance.  Then, since the copy action does NOT"
 W !,"copy Business Rules, check to see what Business Rules exist for the entry the"
 W !,"copy was copied FROM, and create the same rules for the COPY."
 Q
 ;
