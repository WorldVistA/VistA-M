PXCESC ;SLC/PKR - Used to edit and display V STANDARD CODES ;04/18/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
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
 ;;12~1~1201~Event Date and Time: ~Event Date and Time: ~~~~~D
 ;;220~1~220~Magnitude: ~Magnitude: ~~SKIP^PXCESC~~~D
 ;;220~2~221~UCUM Code: ~UCUM Description: ~~SKIP^PXCESC~~~D
 ;;300~1~300~Mapped Source: ~Mapped Source: ~$$DISMAPS^PXCESC~SKIP^PXCESC~~~B
 ;;811~1~81101~Comments: ~Comments: ~~SKIP^PXCESC~~~D
 ;;812~2~81202~Package:  ~Package: ~~SKIP^PXCESC~~~D
 ;;812~3~81203~Data Source:  ~Data Source: ~~SKIP^PXCESC~~~D
 ;;
 ;================================
ADDCODE(VISITIEN,VSCIEN) ;Let the user select and add codes.
 N CODE,CODESYS,EVENTDT,FDA,FDAIEN,HELP,MSG,PXCEDT,SRCHTERM
 ;Setting PXCELOOP=1 causes ADDCODE to exit.
 ;Have the user select the coding system.
 S CODESYS=$$GETCSYS^PXLEX
 I CODESYS="" S PXCELOOP=1 Q
 ;Prompt the user for the Lexicon search term.
 S SRCHTERM=$$GETST^PXLEX
 I SRCHTERM="" S PXCELOOP=1 Q
 ;Prompt the user for the Event Date and Time.
 S HELP="D EVDTHELP^PXCESC"
 S EVENTDT=$$EVENTDT^PXDATE(HELP)
 S PXCEDT=EVENTDT
 I PXCEDT="" S PXCEDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ;Let the user select the code(s), only return active codes.
 S CODE=$$GETCODE^PXLEXS(CODESYS,SRCHTERM,PXCEDT,1)
 I CODE="" S PXCELOOP=1 Q
 S FDA(9000010.71,"+1,",.01)=CODE
 S FDA(9000010.71,"+1,",.02)=DFN
 S FDA(9000010.71,"+1,",.03)=VISITIEN
 S FDA(9000010.71,"+1,",.05)=CODESYS
 S FDA(9000010.71,"+1,",1201)=EVENTDT
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D  Q
 . N SUBJECT
 . S SUBJECT="V STANDARD CODES entry failed for "_CODELIST(IND)_"."
 . D SENDEMSG^PXMCLINK(SUBJECT,.MSG)
 .;If this is being called from List Manager display the error on
 .;the screen.
 . I $D(VALMCC) D ERRORLM^PXKMCODE(SUBJECT,.MSG)
 . S PXCELOOP=1
 S VSCIEN=FDAIEN(1)
 S ^TMP("PXK",$J,"SC",1,"IEN")=FDAIEN(1)
 S ^TMP("PXK",$J,"SC",1,0,"AFTER")=^AUPNVSC(FDAIEN(1),0)
 S ^TMP("PXK",$J,"SC",1,12,"AFTER")=$G(^AUPNVSC(FDAIEN(1),12))
 S ^TMP("PXK",$J,"SC",1,220,"AFTER")=$G(^AUPNVSC(FDAIEN(1),220))
 S ^TMP("PXK",$J,"SC",1,300,"AFTER")=$G(^AUPNVSC(FDAIEN(1),300))
 S ^TMP("PXK",$J,"SC",1,801,"AFTER")=$G(^AUPNVSC(FDAIEN(1),801))
 S ^TMP("PXK",$J,"SC",1,811,"AFTER")=$G(^AUPNVSC(FDAIEN(1),811))
 S ^TMP("PXK",$J,"SC",1,812,"AFTER")=$G(^AUPNVSC(FDAIEN(1),812))
 S ^TMP("PXK",$J,"SC",1,0,"BEFORE")=""
 S ^TMP("PXK",$J,"SC",1,12,"BEFORE")=""
 S ^TMP("PXK",$J,"SC",1,220,"BEFORE")=""
 S ^TMP("PXK",$J,"SC",1,300,"BEFORE")=""
 S ^TMP("PXK",$J,"SC",1,801,"BEFORE")=""
 S ^TMP("PXK",$J,"SC",1,811,"BEFORE")=""
 S ^TMP("PXK",$J,"SC",1,812,"BEFORE")=""
 Q
 ;
 ;================================
DISMAPS(PXCEEXT,PXCEDT) ;If the Mapped Source exists, display the information.
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
DISCSYS(PXCESC,PXCEDT) ;Display the coding system
 ;DBIA #5679
 Q $P($$CSYS^LEXU(PXCESC),U,4)
 ;
 ;********************************
DISPLY01(PXCESC,PXCEDT) ;Display the code.
 ;The argument is appended to the call in the FORMAT line by PXCEAE1.
 N CODE,CODESYS,DATA,DATE,FSN,RESULT,TEXT
 S CODE=$P(PXCESC,U,1),CODESYS=$P(PXCESC,U,5)
 S TEXT=CODE_" ("_CODESYS_")"
 ;DBIA #5679
 S RESULT=$$CSDATA^LEXU(CODE,CODESYS,PXCEDT,.DATA)
 I RESULT=1 D
 . S FSN=$P(DATA("LEX",4),U,2)
 . I FSN="" S FSN=$P(DATA("LEX",3),U,2)
 . S TEXT=TEXT_" "_FSN
 Q TEXT
 ;
 ;********************************
EDITCODE(VSCIEN,VISITIEN) ;Edit the code.
 ;If VSCIEN is null then this is an add.
 I VSCIEN="" D ADDCODE(VISITIEN,.VSCIEN)
 I PXCELOOP=1 Q
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
EVDTHELP ;Event Date and Time help.
 N ERR,RESULT,TEXT
 S RESULT=$$GET1^DID(9000010.71,1201,"","DESCRIPTION","TEXT","ERR")
 D BROWSE^DDBR("TEXT(""DESCRIPTION"")","NR","V Standard Codes Event Date and Time Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
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
 S DATE=$P($G(^AUPNVSC(VSCIEN,12)),U,1)
 I DATE="" S DATE=$P(^AUPNVSIT(VIEN,0),U,1)
 Q DATE
 ;
