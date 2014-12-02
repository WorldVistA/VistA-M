PXRMEXU0 ;SLC/PKR - Reminder exchange general utilities, #0. ;08/05/2013
 ;;2.0;CLINICAL REMINDERS;**4,12,18,26**;Feb 04, 2005;Build 404
 ;====================================
CFOKTI(IEN,START,STOP) ;Check a computed finding to see if it can be
 ;installed. Called from IOKTI^PXRMEXFI.
 N INDICES,LN,OK,TEMP
 S OK=1
 F LN=STOP:-1:START D
 . S TEMP=^PXD(811.8,IEN,100,LN,0)
 . S INDICES=$P(TEMP,"~",1)
 . I $P(INDICES,";",1)'=811.4 Q
 .;Check for the Class field, if the value is NATIONAL then set OK=0.
 . I ($P(INDICES,";",3)=100) S LN=START,OK=$S($P(TEMP,"~",2)="NATIONAL":0,1:1)
 Q OK
 ;
 ;====================================
LOC(FDA) ;Process the FDA for location lists.
 ;Direct reads of ^DIC(40.7) covered by DBIA #537.
 N AMIS,IEN,IENS,SFN,STOP,TEMP,TEXT
 ;Stop Codes may not have a unique name, use the AMIS Reporting Stop
 ;code to determine which one to use.
 F SFN=810.9001,810.90011 D
 . S IENS=""
 . F  S IENS=$O(FDA(SFN,IENS)) Q:IENS=""  D
 .. S STOP=FDA(SFN,IENS,.01)
 .. S AMIS=FDA(SFN,IENS,.02)
 .. S IEN=$O(^DIC(40.7,"C",AMIS,""))
 .. S TEMP=$P(^DIC(40.7,IEN,0),U,1)
 .. I TEMP'=STOP D  Q
 ... S TEXT(1)="Name associated with AMIS stop code does not match the one in the"
 ... S TEXT(2)="packed reminder:"
 ... S TEXT(3)=" AMIS="_AMIS
 ... S TEXT(4)=" Site Name="_TEMP
 ... S TEXT(5)=" Name in packed reminder="_STOP
 ... D EN^DDIOL(.TEXT)
 .. S FDA(SFN,IENS,.01)="`"_IEN
 Q
 ;
 ;====================================
GETIEN(NFOUND,LIST) ;FIND^DIC has found multiple entries with the same name.
 ;NFOUND is the number found, LIST is the array returned by FIND^DIC.
 ;Ask the user which one they want to use.
 N DIR,FN,IND,NC,X,Y
 S DIR(0)="S^"
 F IND=1:1:NFOUND D
 . S DIR(0)=DIR(0)_IND_":"_LIST("DILIST",2,IND)_";"
 S DIR("L",1)="Select one of the following to use:"
 S NC=1
 F IND=1:1:NFOUND D
 . S NC=NC+1
 . S DIR("L",NC)=IND_"- "_LIST("DILIST",1,IND)_" IEN="_LIST("DILIST",2,IND)
 . S FN=$O(LIST("DILIST","ID",IND,""))
 . I FN="" Q
 . S NC=NC+1
 . S DIR("L",NC)="    "_LIST("DILIST","ID",IND,FN)
 . F  S FN=$O(LIST("DILIST","ID",IND,FN)) Q:FN=""  D
 .. I $L(LIST("DILIST","ID",IND,FN))=0 Q
 .. S NC=NC+1
 .. S DIR("L",NC)="    "_LIST("DILIST","ID",IND,FN)
 ;Truncate DIR("L") as required.
 S DIR("L")=DIR("L",NC) K DIR("L",NC)
 D ^DIR
 I Y="^" D
 . N TEXT
 . S TEXT(1)="Entering ""^"" tells Reminder Exchange the entry does not exist. You will be"
 . S TEXT(2)="ask for a replacement."
 . D EN^DDIOL(.TEXT)
 Q $S($D(Y(0)):Y(0),1:0)
 ;
 ;====================================
ISPCEFIL(FILENUM) ;Return true if FILENUM is a PCE file.
 I FILENUM=9999999.09 Q 1 ;EDUCATION TOPICS
 I FILENUM=9999999.15 Q 1 ;EXAM
 I FILENUM=9999999.64 Q 1 ;HEALTH FACTORS
 I FILENUM=9999999.14 Q 1 ;IMMUNIZATION
 I FILENUM=9999999.28 Q 1 ;SKIN TEST
 I FILENUM=9999999.17 Q 1 ;TREATMENT
 Q 0
 ;
 ;====================================
SFNFTC(IEN) ;Set the found/not found text line counts in the reminder
 ;definition.
 D SNMLA^PXRMFNFT(IEN)
 D SNMLF^PXRMFNFT(IEN,20)
 D SNMLF^PXRMFNFT(IEN,25)
 D SNMLL^PXRMFNFT(IEN)
 Q
 ;
 ;====================================
TAX(FDA,NODE) ;Process the FDA for taxonomies. This is for the conversion from
 ;the pointer based structure to Lexicon based structure.
 N CODE,CODEIEN,HIGH,IENS,LOW
 K ^TMP($J,NODE)
 ;ICD codes.
 S IENS=""
 F  S IENS=$O(FDA(811.22102,IENS)) Q:IENS=""  D
 . S LOW=FDA(811.22102,IENS,.01)
 . S HIGH=$G(FDA(811.22102,IENS,1))
 . I HIGH="" S HIGH=LOW
 . S ^TMP($J,NODE,"ICD",LOW,HIGH)=""
 ;
 ;ICP codes.
 S IENS=""
 F  S IENS=$O(FDA(811.22103,IENS)) Q:IENS=""  D
 . S LOW=FDA(811.22103,IENS,.01)
 . S HIGH=$G(FDA(811.22103,IENS,1))
 . I HIGH="" S HIGH=LOW
 . S ^TMP($J,NODE,"ICP",LOW,HIGH)=""
 ;
 ;CPT codes.
 S IENS=""
 F  S IENS=$O(FDA(811.22104,IENS)) Q:IENS=""  D
 . S LOW=FDA(811.22104,IENS,.01)
 . S HIGH=$G(FDA(811.22104,IENS,1))
 . I HIGH="" S HIGH=LOW
 . S ^TMP($J,NODE,"CPT",LOW,HIGH)=""
 ;
 ;Selectable ICD codes.
 S IENS=""
 F  S IENS=$O(FDA(811.23102,IENS)) Q:IENS=""  D
 . S CODE=FDA(811.23102,IENS,.01)
 . S CODE=$TR(CODE," ","")
 . S ^TMP($J,NODE,"SDX",CODE)=""
 . S CODEIEN=+$$EXISTS^PXRMEXIU(80,CODE,"BX")
 . I CODEIEN>0 S FDA(811.23102,IENS,.01)="`"_CODEIEN
 ;
 ;Selectable CPT codes.
 S IENS=""
 F  S IENS=$O(FDA(811.23104,IENS)) Q:IENS=""  D
 . S CODE=FDA(811.23104,IENS,.01)
 . S CODE=$TR(CODE," ","")
 . S FDA(811.23104,IENS,.01)=CODE
 . S ^TMP($J,NODE,"SPR",CODE)=""
 ;
 ;If these fields no longer exist in the DD remove them from the FDA.
 ;ICD9 range of codes.
 S LABEL=$$GET1^DIQ(811.2,2103,"","LABEL")
 I LABEL="" K ^FDA(811.22102)
 ;
 ;ICD0 range of codes.
 S LABEL=$$GET1^DID(811.2,2103,"","LABEL")
 I LABEL="" K ^FDA(811.22103)
 ;
 ;CPT range of codes.
 S LABEL=$$GET1^DID(811.2,2104,"","LABEL")
 I LABEL="" K ^FDA(811.22104)
 ;
 ;Selectable diagnosis.
 S LABEL=$$GET1^DID(811.2,3102,"","LABEL")
 I LABEL="" K ^FDA(811.23102)
 ;
 ;Selectable procedure.
 S LABEL=$$GET1^DID(811.2,3104,"","LABEL")
 I LABEL="" K ^FDA(811.23104)
 Q
 ;
 ;====================================
TAX30(IEN) ;Make sure the Use in Dialog Codes multiple is built during
 ;a Reminder Exchange Install.
 I $D(^PXD(811.2,IEN,30)) Q
 I '$D(^PXD(811.2,IEN,20,"AUID")) Q
 N CODE,CODESYS
 S CODESYS=""
 F  S CODESYS=$O(^PXD(811.2,IEN,20,"AUID",CODESYS)) Q:CODESYS=""  D
 . S CODE=""
 . F  S CODE=$O(^PXD(811.2,IEN,20,"AUID",CODESYS,CODE)) Q:CODE=""  D
 .. D SAVEUIDC^PXRMTAXD(IEN,CODESYS,CODE)
 Q
 ;
