PXCEPOV ;ISL/dee - Used to edit and display V POV ;04/18/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,121,124,170,168,199,211**;Aug 12, 1996;Build 244
 ;; ;
 ;
 ; Reference to LD^ICDEX supported by ICR #5747
 ;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;     1         2             3                   4                                   5
 ;
 ;Following lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR(?)~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8            ~          9                  ~       10
 ;The Display & Edit routines are for special cases.
 ;  (The .01 field cannot have a special edit.)
 ;
FORMAT ;;Diagnosis~9000010.07~0,12,800,802,811,812~1~^AUPNVPOV
 ;;0~1~.01~ICD Code or Diagnosis:  ~ICD Code:  ~$$DISPLY01^PXCEPOV~ICDCODE^PXCEPOV1~^D HELP^PXCEHELP~~B
 ;;0~4~.04~Provider Narrative:  ~Provider Narrative:  ~$$DNARRAT^PXCEPOV1~ENARRAT^PXCEPOV1(1,1,1,80,10,3)~~~B
 ;;0~12~.12~Is this Diagnosis Primary for the Encounter:  ~Primary or Secondary Diagnosis:  ~$$DPRIMSEC^PXCEPOV1~EPRIMSEC^PXCEPRV~~~B
 ;;0~17~.17~Is this Diagnosis Ordering, Resulting, or Both:  ~Ordering/Resulting Diagnosis:  ~~~~~B
 ;;0~6~.06~Modifier:  ~Modifier:  ~~~~~D
 ;;0~13~.13~Injury Date and (optional) Time~Date of Injury: ~~EINJURY^PXCEPOV1~~~D
 ;;12~1~1201~Event Date and Time:  ~Event Date and Time: ~~EVENTDT^PXCEPOV1~~~D
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;802~1~80201~Provider Narrative Category:  ~Provider Narrative Category:  ~$$DNARRAT^PXCEPOV1~ENARRAT^PXCEPOV1(0,2,0,80,5)~~C~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;812~2~81202~Package:  ~Package:  ~~SKIP^PXCEPOV~~~D
 ;;812~3~81203~Data Source:  ~Data Source:  ~~SKIP^PXCEPOV~~~D
 ;;800~1~80001~Service Connected:  ~Service Connected:  ~~GET800^PXCEC800~~~D
 ;;800~7~80007~Combat Veteran:  ~Combat Veteran:  ~~SKIP^PXCEPOV~~~D
 ;;800~2~80002~Agent Orange Exposure:  ~Agent Orange Exposure:  ~~SKIP^PXCEPOV~~~D
 ;;800~3~80003~Ionizing Radiation Exposure:  ~Ionizing Radiation Exposure:  ~~SKIP^PXCEPOV~~~D
 ;;800~4~80004~SW Asia Conditions:  ~SW Asia Conditions:  ~~SKIP^PXCEPOV~~~D
 ;;800~8~80008~Project 112/SHAD:  ~Project 112/SHAD:  ~~SKIP^PXCEPOV~~~D
 ;;800~5~80005~Military Sexual Trauma:  ~Military Sexual Trauma:  ~~SKIP^PXCEPOV~~~D
 ;;800~6~80006~Head and/or Neck Cancer:  ~Head and/or Neck Cancer:  ~~SKIP^PXCEPOV~~~D
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;DG SELECT ICD DIAGNOSIS CODES
 ;
 ;********************************
 ;Special cases for display.
 ;
 ;********************************
 ;Display text for the .01 field which is a pointer to ^ICD9.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEPOV,PXCEDT) ;
 N CODESYS,CODESYSP,ICDSTR,TEXT
 S ICDSTR=$$ICDDATA^ICDXCODE("DIAG",$P(PXCEPOV,"^"),PXCEDT,"I")
 S CODESYS=$P(ICDSTR,U,20)
 S CODESYSP=$P($$CSYS^LEXU(CODESYS),U,4)
 S TEXT=$P(ICDSTR,U,2)_" ("_CODESYSP_")"
 ;Use short description for ICD-9.
 I CODESYS=1 S TEXT=TEXT_"  "_$P(ICDSTR,"^",4)
 ;Use long description for ICD-10.
 I CODESYS=30 S TEXT=TEXT_" "_$$SENTENCE^XLFSTR($$LD^ICDEX(80,$P(PXCEPOV,"^"),PXCEDT))
 Q TEXT
 ;
SKIP ;
 Q
