PXLEX ;SLC/PKR - Routines for PCE Lexicon functionality. ;09/22/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 84
 ;
 ;==========================================
CODESYSL(CODESYSL) ;Return the list of Lexicon coding systems supported
 ;by PCE.
 S CODESYSL("10D")="",CODESYSL("10P")=""
 S CODESYSL("CPC")="",CODESYSL("CPT")=""
 S CODESYSL("ICD")="",CODESYSL("ICP")=""
 S CODESYSL("SCT")=""
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
 D CODESYSL(.CODESYSL)
 S CODESYS="",NL=2
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 .;DBIA #5679
 . S TEMP=$$CSYS^LEXU(CODESYS)
 . S NL=NL+1,TEXT(NL)=CODESYS_" = "_$P(TEMP,U,4)_"; "_$P(TEMP,U,5)
 Q
 ;
 ;==========================================
ISCACT(CODESYS,CODE,DOI) ;Return 1 if the code was active on the date
 ;of interest DOI.
 I DOI>DT Q -1
 N HDATA,NEVENTS,SUB
 ;DBIA #5679
 S NEVENTS=$$HIST^LEXU(CODE,CODESYS,.HDATA)
 I $P(NEVENTS,U,1)=-1 Q -1
 S DOI=$$FMADD^XLFDT(DOI,0,0,0,1)
 S DATE=$O(HDATA(DOI),-1)
 I DATE=0 Q 0
 S SUB=$O(HDATA(DATE,""))
 ;If the second subscript is 0 then the code was inactived.
 Q $S(SUB=0:0,1:1)
 ;
 ;==========================================
SCCSL(CODESYSL) ;Return the list of coding systems supported in
 ;V STANDARD CODES.
 S CODESYSL("SCT")=""
 S CODESYSL(0)=1
 Q
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
VCODESYS(CODESYS) ;Make sure the coding system is supported.
 N CODESYSL,RESULT
 S CODESYS=$$UP^XLFSTR(CODESYS)
 ;ICR #5679
 S RESULT=$$CSYS^LEXU(CODESYS)
 I RESULT="-1^Coding System not found" D  Q 0
 . D EN^DDIOL("The "_CODESYS_" coding system is not supported by the Lexicon.")
 . H 3
 D CODESYSL^PXLEX(.CODESYSL)
 I '$D(CODESYSL(CODESYS)) D  Q 0
 . D EN^DDIOL(CODESYS_" is not a valid coding system for use with PCE.")
 . H 3
 Q 1
 ;
