PXCETRT ;ISL/dee - Used to edit and display V TREATMENT ;3/19/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27**;Aug 12, 1996
 ;; ;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;     1         2             3                   4                                   5
 ;
 ;Followning lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special caces.
 ;  (The .01 field cannot have a special edit.)
 ;
FORMAT ;;Treatment~9000010.15~0,12,802,811,812~1~^AUPNVTRT
 ;;0~1~.01~Treatment:  ~Treatment:  ~~~~~B
 ;;0~6~.06~Provider Narrative:  ~Provider Narrative:  ~$$DNARRAT^PXCETRT~ENARRAT^PXCEPOV1(1,1,1,9999999.17,.01)~~~B
 ;;0~4~.04~How Many:  ~How Many:  ~~EQUAN^PXCECPT~~~D
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;802~1~80201~Provider Narrative Category:  ~Provider Narrative Category:  ~~ENARRAT^PXCEPOV1(0,2,0)~~C~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;PX SELECT TREATMENTS
 ;
 ;********************************
 ;Special cases for display.
 ;
DNARRAT(PNAR) ;Provider Narrative for Treatments
 N PXCEPNAR
 S PXCEPNAR=$P(^AUTNPOV(PNAR,0),"^")
 I $G(VIEW)="B",$D(ENTRY)>0 D
 . N DIC,DR,DA,DIQ,PXCEDIQ1
 . S DIC=9999999.17
 . S DR=.01
 . S DA=$P(ENTRY(0),"^",1)
 . S DIQ="PXCEDIQ1("
 . S DIQ(0)="E"
 . D EN^DIQ1
 . S:PXCEDIQ1(9999999.17,DA,.01,"E")=PXCEPNAR PXCEPNAR=""
 Q PXCEPNAR
 ;
 ;********************************
 ;Special cases for edit.
 ;
 ;********************************
 ;Display text for the .01 field which is a pointer to Treatment Type.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCETRT) ;
 Q $P($G(^AUTTTRT(+PXCETRT,0)),"^",1)
 ;
