PXLEX ;SLC/PKR - Routines for PCE Lexicon functionality. ;09/29/2020
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 454
 ;
 ;Reference to LEXU supported by ICR #5679.
 ;
 ;==========================================
CODESYSL(CODESYSL,MAP) ;Return the list of Lexicon coding systems supported
 ;by PCE.
 S CODESYSL("SCT")=""
 I 'MAP S CODESYSL(0)=1 Q
 ;If MAP is true then add the addtional coding systems that can be
 ;used for mapping.
 S CODESYSL("10D")="",CODESYSL("10P")=""
 S CODESYSL("CPC")="",CODESYSL("CPT")=""
 S CODESYSL("ICD")="",CODESYSL("ICP")=""
 S CODESYSL(0)=7
 Q
 ;
 ;=========================================
CSHELP ;Display help, used as executable help for coding systems fields.
 N DIR0,TEXT
 ;DBIA #5746 covers kill and set of DDS. DDS needs to be set or the
 ;Browser will kill some ScreenMan variables.
 D CSHTEXT(.TEXT)
 D BROWSE^DDBR("TEXT","NR","Supported PCE Coding Systems Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;=========================================
CSHTEXT(TEXT) ;Supported coding systems help text.
 N CODESYS,CODESYSL,NL,TEMP
 S TEXT(1)="The following coding systems are supported in PCE:"
 S TEXT(2)=""
 D CODESYSL(.CODESYSL,1)
 S CODESYS=0,NL=2
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 .;DBIA #5679
 . S TEMP=$$CSYS^LEXU(CODESYS)
 . S NL=NL+1,TEXT(NL)=CODESYS_" = "_$P(TEMP,U,4)_"; "_$P(TEMP,U,5)
 Q
 ;
 ;==========================================
GETCSYS(MAP) ;Let the user select a coding system.
 N CODESYS,CODESYSL,CODESYSN,DIR
 ;If MAP is true then CODESYSL will contain all the coding systems that
 ;can be used for mapping.
 D CODESYSL^PXLEX(.CODESYSL,MAP)
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
 ;==========================================
GETST() ;Let the user input a Lexicon search term.
 N DIR,DIRUT,X,Y
 S DIR(0)="FAO^2:240"
 S DIR("A")=""
 S DIR("A",1)="Input the Lexicon search term:"
 D ^DIR
 I $D(DIRUT) Q ""
 Q X
 ;
 ;==========================================
ISCACT(CODESYS,CODE,DOI) ;Return 1 if the code was active on the date
 ;of interest DOI, otherwise return 0.
 N DATE,HDATA,NEVENTS,SUB
 ;DBIA #5679
 S NEVENTS=$$HIST^LEXU(CODE,CODESYS,.HDATA)
 I $P(NEVENTS,U,1)=-1 Q 0
 S DOI=$$FMADD^XLFDT(DOI,0,0,0,1)
 S DATE=$O(HDATA(DOI),-1)
 I DATE=0 Q 0
 S SUB=$O(HDATA(DATE,""))
 ;If the second subscript is 0 then the code is inactive.
 Q $S(SUB=0:0,1:1)
 ;
 ;==========================================
VCODE(CODESYS,CODE) ;Check that a code in the specified coding system is valid.
 N DATA,IEN,RESULT,VALID
 S VALID=0
 ;DBIA #5679
 S RESULT=$$HIST^LEXU(CODE,CODESYS,.DATA)
 I $P(RESULT,U,1)'=-1 Q 1
 I (CODESYS="CPC")!(CODESYS="CPT") D
 .;DBIA #1995
 . S RESULT=$$CPT^ICPTCOD(CODE)
 . S IEN=$P(RESULT,U,1)
 . I IEN=-1 S VALID=0 Q
 . I IEN=CODE S VALID=0 Q
 . I CODESYS="CPC",$P(RESULT,U,5)="H" S VALID=1 Q
 . I CODESYS="CPT",$P(RESULT,U,5)="C" S VALID=1 Q
 I VALID=1 Q VALID
 ;DBIA #3990
 I CODESYS="ICD" S RESULT=$$ICDDX^ICDCODE(CODE,DT,"",0)
 I CODESYS="ICP" S RESULT=$$ICDOP^ICDCODE(CODE,DT,"",0)
 S IEN=$P(RESULT,U,1)
 I IEN=-1 S VALID=0
 I CODE=IEN S VALID=0
 Q VALID
 ;
 ;==========================================
VCODESYS(CODESYS,MF) ;Make sure the coding system is supported.
 N CODESYSL,RESULT
 S CODESYS=$$UP^XLFSTR(CODESYS)
 ;ICR #5679
 S RESULT=$$CSYS^LEXU(CODESYS)
 I RESULT="-1^Coding System not found" D  Q 0
 . I 'MF Q
 . D EN^DDIOL("The "_CODESYS_" coding system is not supported by the Lexicon.")
 . H 3
 D CODESYSL^PXLEX(.CODESYSL,1)
 I '$D(CODESYSL(CODESYS)) D  Q 0
 . I 'MF Q
 . D EN^DDIOL(CODESYS_" is not a valid coding system for use with PCE.")
 . H 3
 Q 1
 ;
