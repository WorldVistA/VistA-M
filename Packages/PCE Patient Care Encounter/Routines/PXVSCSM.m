PXVSCSM ;SLC/PKR - V Standard Codes ScreenMan routines ;01/20/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 84
 ;
 ;===================================
CODEPAOC(DA) ;Code Post-Action On Change.
 N CODE,CODESYS,EVENTDT,NEWCODE,SAVEDDS
 S CODE=$$GET^DDSVAL(9000010.71,.DA,.01)
 S CODESYS=$$GET^DDSVAL(9000010.71,.DA,.05)
 S EVENTDT=$$GET^DDSVAL(9000010.71,.DA,1201)
 I EVENTDT="" S EVENTDT=DT
 ;DBIA #5746 covers kill and set of DDS.
 I $D(DDS) S SAVEDDS=DDS K DDS
 ;Call the Lexicon search.
 S NEWCODE=$$GETCODE^PXLEXS(CODESYS,CODE,EVENTDT,0)
 ;Reset the screen so ScreenMan displays properly.
 I $D(SAVEDDS) D
 . N IOAWM0,X
 . S DDS=SAVEDDS
 . S X=0 X ^%ZOSF("RM"),^%ZOSF("TYPE-AHEAD")
 . S X="IOAWM0" D ENDR^%ZISS W IOAWM0
 . D REFRESH^DDSUTL
 D PUT^DDSVAL(9000010.71,.DA,.01,NEWCODE)
 Q
 ;
 ;===================================
CODEPRE(DA) ;Code pre-action.
 N CODESYS,TEXT
 S CODESYS=$$GET^DDSVAL(9000010.71,.DA,.05)
 ;DBIA #5679
 S CODESYS=$P($$CSYS^LEXU(CODESYS),U,4)
 S TEXT(1)="Input a search term or a "_CODESYS_" code."
 D EN^DDIOL(.TEXT)
 Q
 ;
 ;===================================
CSYSPRE() ;Coding System pre-action.
 N CODESYS,CODESYSL,NL,TEXT
 D SCCSL^PXLEX(.CODESYSL)
 S TEXT(1)="The available coding systems are:"
 S CODESYS=0,NL=1
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 .;DBIA #5679
 . S NL=NL+1,TEXT(NL)=" "_CODESYS_" - "_$P($$CSYS^LEXU(CODESYS),U,4)
 D EN^DDIOL(.TEXT)
 Q
 ;
 ;===================================
VCSYS(CODESYS) ;Coding System data validation.
 I CODESYS="" D  Q 0
 . D HLP^DDSUTL("The Coding System cannot be null.")
 N CODESYSL,VALID
 D SCCSL^PXLEX(.CODESYSL)
 S CODESYS=$$UP^XLFSTR(CODESYS)
 S VALID=$S($D(CODESYSL(CODESYS)):1,1:0)
 I 'VALID D HLP^DDSUTL(CODESYS_" is not a valid coding system.")
 Q VALID
 ;
 ;===================================
POSTACT(D0) ;Form Post Action
 Q
 N INACTIVE,INUSE,OUTPUT
 ;If the change was a deletion there is nothing else to do.
 I '$D(^AUTTEDT(D0)) Q
 ;If the education topic was inactivated check to see if it is being used.
 ;Need a new FileMan API to do this.
 S INACTIVE=$$GET^DDSVAL(9000010.71,D0,"INACTIVE FLAG")
 Q
 ;
 ;===================================
POSTSAVE(IEN) ;Form Post Save.
 Q
 ;
 ;===================================
SMANEDIT(IEN) ;ScreenMan edit for entry IEN.
 N DA,DDSCHANG,DDSFILE,DDSPARM,DDSSAVE,DEL,DIDEL,DIMSG,DR,DTOUT
 S (DDSFILE,DIDEL)=9000010.71,DDSPARM="CS",DR="[PX VSC EDIT]"
 S DA=IEN
 D ^DDS
 Q
 ;
