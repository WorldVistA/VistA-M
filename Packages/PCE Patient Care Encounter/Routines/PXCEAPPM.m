PXCEAPPM ;ISL/dee,ISA/KWP - Used to add a new visit from the appointment display and display a visit ;04/28/99
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22,74,111,130,124,168**;Aug 12, 1996;Build 14
 ;+The classifications are displayed with this routine when adding
 ;+an encounter from the appointment list
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (not used on visit)~File global name
 ;     1         2             3                   4                                        5
 ;
 ;Following lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special cases.
 ;
FORMAT ;;Encounter~9000010~0,21,150,800,811,812~~^AUPNVSIT
 ;;0~1~.01~Encounter Date and Time:  ~Encounter Date and Time:  ~~EVISITDT^PXCEVSIT(1)~~~B
 ;;0~18~.18~Check Out ~Check Out Date and Time:  ~~ECODT^PXCEVSIT~~~D
 ;;800~1~80001~Service Connected:  ~Service Connected:  ~~GET800^PXCEE800~~~D
 ;;800~7~80007~Combat Veteran:  ~Combat Veteran:  ~~SKIP^PXCEVSIT~~~D
 ;;800~2~80002~Agent Orange Exposure:  ~Agent Orange Exposure:  ~~SKIP^PXCEVSIT~~~D
 ;;800~3~80003~Ionizing Radiation Exposure:  ~Ionizing Radiation Exposure:  ~~SKIP^PXCEVSIT~~~D
 ;;800~4~80004~SW Asia Conditions:  ~SW Asia Conditions:  ~~SKIP^PXCEVSIT~~~D
 ;;800~8~80008~Project 112/SHAD:  ~Project 112/SHAD:  ~~SKIP^PXCEVSIT~~~D
 ;;800~5~80005~Military Sexual Trauma:  ~Military Sexual Trauma:  ~~SKIP^PXCEVSIT~~~D
 ;;800~6~80006~Head and/or Neck Cancer:  ~Head and/or Neck Cancer:  ~~SKIP^PXCEVSIT~~~D
 ;
 ;
 ;
 ;********************************
 ;Special cases for display of visit are in PXCEVSIT.
 ;
 ;********************************
 ;Special cases for edit of visit are in PXCEVSIT.
 ;
 ;********************************
 ;Display text for the .01 field which is a Date and Time.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEVSIT) ;
 Q $$DISPLY01^PXCESIT(PXCEVSIT)
 ;
