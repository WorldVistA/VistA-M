TIUFLLM3 ; SLC/MAM - Library; LM Related: Docmentation on Templs H,A,I,T,D,P, Arrays TIUF1/2/3/B, Variables TIUFTMPL,TIUFSTMP,TIUFWHO,TIUFACT, Variable CONTENT in BUFENTRY^TIUFLLM3 ;10/25/95  21:21
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
 ;                     ***GENERAL DOCUMENTATION***
 ; Note on Templates/Subtemplates:
 ;  As the words are used in the Document Definition Utility (TIUF):
 ;TIUF Templates/Subtemplates are distinguished by what sort of entity
 ;they display, e.g. they may display Document Definitions in Hierarchy,
 ;or Items, or complete information on one Document Definition.
 ; Variables TIUFTMPL/TIUFSTMP name the TIUF Sub/Template by letter
 ;according to the entity displayed, e.g. T for Items, D for Detailed
 ;Display, X for Boilerplate Text, H for Hierarchy (Edit DDEFS), A for
 ;Attribute (Sort DDEFS), C for Create.
 ; Template Actions CALL Subtemplates.  
 ;  LIST MANAGER TEMPLATES have a many to one relation to TIUF
 ;SUB/TEMPLATES:  LM Templates are distinguished from each other by
 ;1) what sort of entity they display, 2) what users they are intended
 ;for, 3) what actions may be taken/ how some actions behave, and 4) the 
 ;type of the entry in the case of detailed display.
 ;  Variables TIUFTMPL/TIUFSTMP describe the sort of entity displayed.
 ;TIUFWHO describes the intended user.  TIUFACT* describes actions, which
 ;may depend on the entry selected from a previous screen as well as on
 ;the user.  The LM Template called therefore may depend on all 3
 ;variables: TIUFTMPL/TIUFSTMP, TIUFWHO, and TIUFACT* as well as on the
 ;type of entry displayed.
 ;
 ; TIUF Templates are:    H, A, C, J
 ; TIUF Subtemplates are: D (called by H/A/C/J), X (called by H/A/C), and T (called by H/A,D).
 ;
 ; TIUF Template H corresponds to LM Templates:
 ;   TIUFH EDIT DDEFS CLIN,
 ;   TIUFH EDIT DDEFS MGR,
 ; TIUF Template A corresponds to LM Templates:
 ;   TIUFA SORT DDEFS CLIN,
 ;   TIUFA SORT DDEFS MGR,
 ; TIUF Template C corresponds to LM Templates:
 ;   TIUFC CREATE DDEFS MGR,
 ; TIUF Subtemplate D corresponds to LM Templates:
 ;   TIUFD DISPLAY CLIN,
 ;   TIUFD DISPLAY MGR,
 ;   TIUFD DISPLAY VIEW (for objects AND nonobjects),
 ;   TIUFDJ DISPLAY OBJECT MGR (for objects).
 ; TIUF Subtemplate X corresponds to LM Templates:
 ;   TIUFX BOILERPLATE TEXT
 ;   TIUFX BOILERPLATE TEXT VIEW
 ; TIUF Subtemplate T corresponds to LM Templates:
 ;   TIUFT ITEMS ADD/EDIT/VIEW MGR
 ;   TIUFT ITEMS EDIT/VIEW CLIN
 ;   TIUFT ITEMS VIEW NATL/MGR/CLIN
 ;
 ; Note on Variables: 
 ; Variables TIUFTMPL, TIUFSTMP, TIUFWHO, TIUFACT*
 ;   TIUFTMPL = :
 ;     H for Template Edit Document Definitions,
 ;     A for Template Sort Document Definitions,
 ;     C for Template Create Document Definitions
 ;     J for Template Create Objects
 ;       TIUFTMPL names the option originally chosen by the user.
 ;       If TIUFSTMP does not exist, then the user is currently in
 ;         TIUFTMPL.  If TIUFSTMP exists (along with TIUFTMPL), then
 ;         the user is currently in TIUFSTMP (and came from TIUFTMPL).
 ;       TIUFTMPL is set in Options TIUFH EDIT DDEFS, TIUFA SORT DDEFS, or TIUFC CREATE DDEFS, TIUFJ CREATE OBJECTS.
 ;   TIUFSTMP = :
 ;     T for Subtemplate Items,
 ;     D for Subtemplate Detailed Display,
 ;     X for Subtemplate Boilerplate Text
 ;       TIUFSTMP is set in rtns.
 ;   TIUFWHO = :
 ;     C for Clinician, M for Manager, N for National Developer.
 ;       TIUFWHO is set in Options TIUF/H/A/C/J EDIT/SORT/CREATE DDEFS
 ;       /OBJECTS.
 ;   TIUFACT*= :
 ;     For Subtemplate T:
 ;       TIUFACTT = A for TIUFT ITEMS ADD/EDIT/VIEW MGR
 ;                  E for TIUFT ITEMS EDIT/VIEW CLIN
 ;                  V for TIUFT ITEMS VIEW MGR/CLIN
 ;     For Subtemplate D:
 ;       TIUFACT = C for TIUFD DISPLAY CLIN
 ;                 M,N for TIUFD DISPLAY MGR
 ;                 V for TIUFD DISPLAY VIEW
 ;     For Subtemplate X:
 ;       TIUFACT = C,M,N for TIUFX BOILERPLATE TEXT
 ;       TIUFACT = V for TIUFX BOILERPLATE TEXT VIEW
 ;
 ;         TIUFACT* is set in rtns
 ;
 ;  In the TIUF Utility, LM Templates and Protocol Menus are named using
 ;TIUFTMPL or TIUFSTMP, and lengthened or abbreviated forms of TIUFWHO
 ;or TIUFACT.
 ;  EXAMPLE: Protocol TIUFA ACTION MENU CLIN is the Protocol Menu for 
 ;LM Template TIUFA SORT DDEFS CLIN, where A = TIUFTMPL = Sort DDEFs,
 ;CLIN = lengthened TIUFWHO.
 ;
 ; Note on Major TMP Arrays:
 ;   TIUF uses 3 sets of TMP arrays: ^TMP("TIUF1" and associated arrays,
 ;^TMP("TIUF2" and associated arrays, and ^TMP("TIUF3" and associated
 ;arrays.  It also uses a buffer array before setting data into the 3
 ;above arrays: ^TMP("TIUFB".  TMP arrays 1, 2, and 3 above are used for
 ;LM Templates.
 ;     ^TMP("TIUF1" is the LM array for TIUF Templates H, A, C and J.
 ;     ^TMP("TIUF3" is the LM array for TIUF Subtemplates D and X.
 ;     ^TMP("TIUF2" is the LM array for TIUF Subtemplate T.
 ;  Modules for ^TMP("TIUF1"/2 optionally handle hierarchy display,
 ;which updates the display for one entry when another entry is edited.
 ; TIUF also uses ^TMP("TIUF",$J), which contains setup variables.
 ;
 ; Note on variable CONTENT in BUFENTRY^TIUFLLM2:
 ;CONTENT is a string containing any of the following flags:
 ;   80   info is limited to 80 chars. 80 can be FOLLOWED by another
 ;flag, but it must be first.  Commas are not necessary.  Used to display
 ;parents of Shared Components, to display parent in Template A Edit/
 ;View.  Other flags are mutually exclusive, i.e., string can contain
 ;only one except for 80.
 ;   H    info is for Hierarchy LM Template: need +, need levels, omit Items Column in Screen Display.
 ;   C    info is for CREATE LM Template: need levels, omit Items Column in Screen Display.
 ;   A    info is for Attribute Template: need Items, omit levels.
 ;   J    info is for Object Template: omit levels, omit columns Type, In Use, Boiltext, Items
 ;   D    info is item fields from item subfile; Shortened Name for Template D, no Number
 ;   O    info is Name, Status, Owner, (IFN) of Title/Orphan Component with embedded Object; for Template D for Objects
 ;   T    info is item fields from item subfile; Whole Name for Template T.
 ;   W    Buffer array is not for insertion into LM array but only for
 ;writing to screen. +INFO=0, and Buffer array starts with line 0; No number.
