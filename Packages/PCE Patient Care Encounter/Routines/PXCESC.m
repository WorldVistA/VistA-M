PXCESC ;SLC/PKR - Used to edit and display V STANDARD CODES ;10/24/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 84
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
FORMAT ;;Standard Codes~9000010.71~0,12,220,300,811,812~1~^AUPNVSC
 ;;0~5~.05~Coding System:~Coding System: ~$$DISCSYS^PXCESC~SKIP^PXCESC~~~
 ;;0~1~.01~Code: ~Code: ~$$DISPLY01^PXCESC~EDITCODE^PXCESC(PXCEFIEN,PXCEVIEN)~^D HELP^PXCEHELP~~
 ;;12~1~1201~Event Date and Time: ~Event Date and Time: ~~SKIP^PXCESC~~~D
 ;;220~1~220~Magnitude: ~Magnitude: ~~SKIP^PXCESC~~~D
 ;;220~2~221~UCUM Code: ~UCUM Code: ~~SKIP^PXCESC~~~D
 ;;300~1~300~Mapped Source: ~Mapped Source: ~$$DISMAPS^PXCESC~SKIP^PXCESC~~~D
 ;;811~1~81101~Comments: ~Comments: ~~SKIP^PXCESC~~~D
 ;;
 ;********************************
ADDCODE(VISITIEN) ;Let the user select and add codes.
 N CODELIST,CODESYS,DFN,EVENTDT,FDA,FDAIEN,IND,MSG,SRCHTERM
 ;Setting PXCELOOP=1 causes ADDCODE to exit.
 S DFN=$P(^AUPNVSIT(VISITIEN,0),U,5)
 I DFN="" D  Q
 . W !,"Visit IEN=",VISITIEN," is missing the patient!"
 . W !,"Cannot create a new V STANDARD CODES entry."
 . H 2
 . S PXCELOOP=1
 ;Have the user select the coding system.
 S CODESYS=$$GETCSYS^PXCESC
 I CODESYS="" S PXCELOOP=1 Q
 ;Prompt the user for the Lexicon search term.
 S SRCHTERM=$$GETST^PXCESC
 I SRCHTERM="" S PXCELOOP=1 Q
 ;Prompt the user for the Event Date and Time.
 S EVENTDT=$$GEVENTDT^PXCESC
 ;Let the user select the code(s).
 D GETCODES^PXLEXS(CODESYS,SRCHTERM,EVENTDT,.CODELIST)
 I '$D(CODELIST) S PXCELOOP=1 Q
 ;For each selected code populate the FDA and call UPDATE^DIE.
 S IND=0
 F  S IND=$O(CODELIST(IND)) Q:IND=""  D
 . K FDA,FDAIEN
 . S FDA(9000010.71,"+1,",.01)=CODELIST(IND)
 . S FDA(9000010.71,"+1,",.02)=DFN
 . S FDA(9000010.71,"+1,",.03)=VISITIEN
 . S FDA(9000010.71,"+1,",.05)=CODESYS
 . S FDA(9000010.71,"+1,",1201)=EVENTDT
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 .;Start the ScreenMan editor
 . D SMANEDIT^PXVSCSM(FDAIEN(1))
 . S PXCEAFTR(0)=^AUPNVSC(FDAIEN(1),0)
 . S PXCEAFTR(12)=$G(^AUPNVSC(FDAIEN(1),12))
 . S PXCEAFTR(220)=$G(^AUPNVSC(FDAIEN(1),220))
 . S PXCEAFTR(300)=$G(^AUPNVSC(FDAIEN(1),300))
 . S PXCEAFTR(801)=$G(^AUPNVSC(FDAIEN(1),801))
 . S PXCEAFTR(811)=$G(^AUPNVSC(FDAIEN(1),811))
 . S PXCEAFTR(812)=$G(^AUPNVSC(FDAIEN(1),812))
 Q
 ;
 ;********************************
DISMAPS(PXCEEXT) ;If the Mapped Source exists, display the information.
 ;The argument is appended to the call in the FORMAT line by PXCEAE1.
 I PXCEEXT="" Q
 N ENTRY,FILENAM,FILENUM,IENS
 S FILENUM=$P(PXCEEXT,";",1)
 S IENS=$P(PXCEEXT,";",2)_","
 S FILENAME=$$GET1^DID(FILENUM,"","","NAME")
 S ENTRY=$$GET1^DIQ(FILENUM,IENS,.01)
 S TEXT=FILENAME_": "_ENTRY
 Q FILENAME_" - "_ENTRY
 ;
 ;********************************
DISPLY01(PXCESC) ;Display the code.
 ;The argument is appended to the call in the FORMAT line by PXCEAE1.
 N CODE,CODESYS,DATA,DATE,FSN,RESULT,TEXT
 S CODE=$P(PXCESC,U,1),CODESYS=$P(PXCESC,U,5)
 S TEXT=CODE_" ("_CODESYS_")"
 S DATE=$$VSCDATE^PXCESC(PXCEVIEN,PXCESC)
 ;DBIA #5679
 S RESULT=$$CSDATA^LEXU(CODE,CODESYS,DATE,.DATA)
 I RESULT=1 D
 . S FSN=$P(DATA("LEX",4),U,2)
 . I FSN="" S FSN=$P(DATA("LEX",3),U,2)
 . S TEXT=TEXT_" "_FSN
 Q TEXT
 ;
 ;********************************
DISCSYS(PXCESC) ;Display the coding system
 ;DBIA #5679
 Q $P($$CSYS^LEXU(PXCESC),U,4)
 ;
 ;********************************
EDITCODE(VSCIEN,VISITIEN) ;Edit the code.
 ;If VSCIEN is null then this is an add.
 I VSCIEN="" D ADDCODE(VISITIEN) Q
 N MAPSRC
 S MAPSRC=$P($G(^AUPNVSC(VSCIEN,300)),U,1)
 ;If the Mapped Source is not null then this entry cannot be edited
 ;since if was created by mapping and linking.
 I MAPSRC'="" D  Q
 . N TEXT
 . S TEXT(1)="This V STANDARD CODES entry was created by mapping a standard code"
 . S TEXT(2)="and linking it to the patient's data, therefore it cannot be edited."
 . D EN^DDIOL(.TEXT)
 . H 4
 ;Start the ScreenMan editor
 D SMANEDIT^PXVSCSM(VSCIEN)
 S PXCEAFTR(0)=^AUPNVSC(VSCIEN,0)
 S PXCEAFTR(12)=$G(^AUPNVSC(VSCIEN,12))
 S PXCEAFTR(220)=$G(^AUPNVSC(VSCIEN,220))
 S PXCEAFTR(300)=$G(^AUPNVSC(VSCIEN,300))
 S PXCEAFTR(801)=$G(^AUPNVSC(VSCIEN,801))
 S PXCEAFTR(811)=$G(^AUPNVSC(VSCIEN,811))
 S PXCEAFTR(812)=$G(^AUPNVSC(VSCIEN,812))
 Q
 ;
 ;********************************
GETCSYS() ;Let the user select a coding system.
 N CODESYS,CODESYSL,CODESYSN,DIR
 D SCCSL^PXLEX(.CODESYSL)
 I CODESYSL(0)=1 D  Q CODESYS
 . S CODESYS=$O(CODESYSL(0))
 . S $P(PXCEAFTR(0),U,5)=CODESYS
 . W !,CODESYS," is the only available coding system."
 S DIR(0)="S^",DIR("A")="Select a coding system"
 S DIR("A",1)="Enter '^' to exit."
 S CODESYS=0
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 .;DBIA #5679
 . S CODESYSN=$P($$CSYS^LEXU(CODESYS),U,4)
 . S DIR(0)=DIR(0)_CODESYS_":"_CODESYSN_";"
 D ^DIR
 I $D(DIRUT) S (X,Y)="" Q ""
 S (CODESYS,$P(PXCEAFTR(0),U,5))=$$UP^XLFSTR(X)
 Q CODESYS
 ;
 ;********************************
GEVENTDT() ;Let the user input an Event Date and Time.
 N DIR,DIRUT,X,Y
 S DIR(0)="DA^0:NOW:EST"
 S DIR("A",1)="Enter the event date and optional time:"
 S DIR("A")=""
 S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 D ^DIR
 I $D(DIRUT) Q ""
 Q Y
 ;
 ;********************************
GETST() ;Let the user input a Lexicon search term.
 N DIR,DIRUT,X,Y
 S DIR(0)="FA^2:240"
 S DIR("A")=""
 S DIR("A",1)="Input the Lexicon search term:"
 D ^DIR
 I $D(DIRUT) Q ""
 Q X
 ;
 ;********************************
SKIP ;Used to by-pass roll and scroll editing of a field.
 S (X,Y)=""
 Q
 ;
 ;********************************
VSCDATE(VIEN,VSCZNODE) ;If the EVENT D/T exists return it, otherwise
 ;return the VISIT/ADMIT DATE&TIME.
 N DATE,IEN,VSCIEN,ZN
 S (IEN,VSCIEN)=0
 F  S IEN=+$O(^AUPNVSC("AD",VIEN,IEN)) Q:(VSCIEN>0)!(IEN=0)  D
 . S ZN=^AUPNVSC(IEN,0)
 . I ZN=VSCZNODE S VSCIEN=IEN Q
 S DATE=$P($G(^AUPNVSC(IEN,12)),U,1)
 I DATE="" S DATE=$P(^AUPNVSIT(VIEN,0),U,1)
 Q DATE
 ;
