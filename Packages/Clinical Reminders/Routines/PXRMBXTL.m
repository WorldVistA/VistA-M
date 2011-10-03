PXRMBXTL ; SLC/PKR - Build expanded taxonomies. ;08/12/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;====================================================
CHECK(TAXIEN,KI) ;Check for expanded taxonomy, build it if it does not
 ;exist.
 N TEMP
 S TEMP=$G(^PXD(811.3,TAXIEN,0))
 I TEMP="" D EXPAND(TAXIEN,KI)
 Q
 ;
 ;====================================================
DELEXTL(TAXIEN) ;Delete an expanded taxonomy.
 I '$$LOCKXTL(TAXIEN) Q
 N DA,DIK
 S DIK="^PXD(811.3,"
 S DA=TAXIEN
 D ^DIK
 D ULOCKXTL(TAXIEN)
 Q
 ;
 ;====================================================
EXPALLO ;Rebuild all taxonomy expansions, used by option
 I '$D(^XUSEC("PXRM MANAGER",DUZ)) D  Q
 . W !,"You must hold the PXRM MANAGER key to use this option."
 D EXPALL^PXRMBXTL
 Q
 ;
 ;====================================================
EXPALL ;Rebuild all taxonomy expansions.
 N IEN,NAME
 D BMES^XPDUTL("Rebuilding all taxonomy expansions.")
 S IEN=0
 F  S IEN=+$O(^PXD(811.2,IEN)) Q:IEN=0  D
 . S NAME=$P(^PXD(811.2,IEN,0),U,1)
 . D MES^XPDUTL("Expanding "_NAME_"  (IEN="_IEN_")")
 . D DELEXTL^PXRMBXTL(IEN)
 . D EXPAND^PXRMBXTL(IEN,"")
 D BMES^XPDUTL("Done rebuilding taxonomy expansions.")
 Q
 ;
 ;====================================================
EXPAND(TAXIEN,KI) ;Build an expanded taxonomy. If KI is defined then
 ;entry KI is being deleted so skip it. KI is checked because this
 ;can be called by cross-references in 811.2.
 I '$$LOCKXTL(TAXIEN) Q
 N CPTDATE,DATEBLT,HIGH,ICD0DATE,ICD9DATE,IND,LOW
 N NICD0,NICD9,NICPT,NRCPT,TEMP,X,X1,X2
 K ^PXD(811.3,TAXIEN)
 S DATEBLT=$$NOW^XLFDT
 S $P(^PXD(811.3,TAXIEN,0),U,1)=TAXIEN
 S $P(^PXD(811.3,TAXIEN,0),U,2)=DATEBLT
 ;
 S (IND,NICD0)=0
 F  S IND=+$O(^PXD(811.2,TAXIEN,80.1,IND)) Q:IND=0  D
 . I KI=IND Q
 . S TEMP=^PXD(811.2,TAXIEN,80.1,IND,0)
 . S LOW=$P(TEMP,U,1)
 . S HIGH=$P(TEMP,U,2)
 . I HIGH="" S HIGH=LOW
 . D ICD0(TAXIEN,LOW,HIGH,.NICD0)
 S ICD0DATE=$$GET1^DID(80.1,"","","PACKAGE REVISION DATA")
 S ICD0DATE=$P(ICD0DATE,U,2)
 S $P(^PXD(811.3,TAXIEN,0),U,3,4)=NICD0_U_ICD0DATE
 ;
 S (IND,NICD9)=0
 F  S IND=+$O(^PXD(811.2,TAXIEN,80,IND)) Q:IND=0  D
 . I KI=IND Q
 . S TEMP=^PXD(811.2,TAXIEN,80,IND,0)
 . S LOW=$P(TEMP,U,1)
 . S HIGH=$P(TEMP,U,2)
 . I HIGH="" S HIGH=LOW
 . D ICD9(TAXIEN,LOW,HIGH,.NICD9)
 S ICD9DATE=$$GET1^DID(80,"","","PACKAGE REVISION DATA")
 S ICD9DATE=$P(ICD9DATE,U,2)
 S $P(^PXD(811.3,TAXIEN,0),U,5,6)=NICD9_U_ICD9DATE
 ;
 S (IND,NICPT,NRCPT)=0
 F  S IND=+$O(^PXD(811.2,TAXIEN,81,IND)) Q:IND=0  D
 . I KI=IND Q
 . S TEMP=^PXD(811.2,TAXIEN,81,IND,0)
 . S LOW=$P(TEMP,U,1)
 . S HIGH=$P(TEMP,U,2)
 . I HIGH="" S HIGH=LOW
 . D ICPT(TAXIEN,LOW,HIGH,.NICPT,.NRCPT)
 S CPTDATE=$$GET1^DID(81,"","","PACKAGE REVISION DATA")
 S CPTDATE=$P(CPTDATE,U,2)
 S $P(^PXD(811.3,TAXIEN,0),U,7,9)=NICPT_U_CPTDATE_U_NRCPT
 ;
 ;Create the patient data source.
 S (X1,X2)="TAX"
 S X=$P(^PXD(811.2,TAXIEN,0),U,4)
 D KPDS^PXRMPDS(X,X1,X2,TAXIEN)
 D SPDS^PXRMPDS(X,X1,X2,TAXIEN)
 ;
 D SZN
 D ULOCKXTL(TAXIEN)
 Q
 ;
 ;====================================================
ICD0(TAXIEN,LOW,HIGH,NICD0) ;Build the list of internal entries for ICD0
 ;(File 80.1). Use of ICDAPIU: DBIA #3991
 N CODE,IEN,TEMP
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . S TEMP=$$STATCHK^ICDAPIU(CODE,"")
 . S IEN=$P(TEMP,U,2)
 . I IEN'=-1,'$D(^PXD(811.3,TAXIEN,80.1,"ICD0P",IEN)) D
 .. S NICD0=NICD0+1
 .. S ^PXD(811.3,TAXIEN,80.1,NICD0,0)=IEN
 .. S ^PXD(811.3,TAXIEN,80.1,"ICD0P",IEN,NICD0,0)=""
 . S CODE=$$NEXT^ICDAPIU(CODE)
 Q
 ;
 ;====================================================
ICD9(TAXIEN,LOW,HIGH,NICD9) ;Build the list of internal entries for ICD9
 ;(File 80). Use of ICDAPIU: DBIA #3991
 N CODE,IEN,TEMP
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . S TEMP=$$STATCHK^ICDAPIU(CODE,"")
 . S IEN=$P(TEMP,U,2)
 . I IEN'=-1,'$D(^PXD(811.3,TAXIEN,80,"ICD9P",IEN)) D
 .. S NICD9=NICD9+1
 .. S ^PXD(811.3,TAXIEN,80,NICD9,0)=IEN
 .. S ^PXD(811.3,TAXIEN,80,"ICD9P",IEN,NICD9,0)=""
 . S CODE=$$NEXT^ICDAPIU(CODE)
 Q
 ;
 ;====================================================
ICPT(TAXIEN,LOW,HIGH,NICPT,NRCPT) ;Build the list of internal entries
 ;for ICPT (File 81). Use of ICDAPIU: DBIA #3991
 N CODE,IEN,RADIEN,TEMP
 S CODE=LOW
 F  Q:(CODE]HIGH)!(CODE="")  D
 . S TEMP=$$STATCHK^ICPTAPIU(CODE,"")
 . S IEN=$P(TEMP,U,2)
 . I IEN'=-1,'$D(^PXD(811.3,TAXIEN,81,"ICPTP",IEN)) D
 .. S NICPT=NICPT+1
 .. S ^PXD(811.3,TAXIEN,81,NICPT,0)=IEN
 .. S ^PXD(811.3,TAXIEN,81,"ICPTP",IEN,NICPT,0)=""
 ..;Determine if this is a radiology procedure.
 ..;DBIA #586.
 .. S RADIEN=""
 .. F  S RADIEN=+$O(^RAMIS(71,"D",IEN,RADIEN)) Q:RADIEN=0  D
 ... S NRCPT=NRCPT+1
 ... S ^PXD(811.3,TAXIEN,71,NRCPT,0)=IEN_U_RADIEN
 ... S ^PXD(811.3,TAXIEN,71,"RCPTP",RADIEN,NRCPT,0)=IEN
 . S CODE=$$NEXT^ICPTAPIU(CODE)
 Q
 ;
 ;====================================================
LOCKXTL(TAXIEN) ;Lock the expanded taxonomy entry. This may be called during
 ;reminder evalution in which case PXRMXTLK will be defined or during
 ;a taxonomy edit in which case PXRMXTLK will be undefined.
 N IND,LC,LOCK
 I $D(PXRMXTLK) S LC=3
 E  S LC=2
 S LOCK=0
 F IND=1:1:LC Q:LOCK  D
 . L +^PXD(811.3,TAXIEN):1
 . S LOCK=$T
 ;If we can't a get a lock take appropriate action.
 I 'LOCK D
 . I $D(PXRMXTLK) S PXRMXTLK=TAXIEN
 . E  D
 .. N TEXT
 .. S TEXT="Could not get lock for expanded taxonomy "_TAXIEN_", try again later."
 .. D EN^DDIOL(TEXT)
 Q LOCK
 ;
 ;====================================================
SELEXP ;Entry point for the option selected taxonomy expansion.
 N TAXIEN
 S TAXIEN=+$$SELECT^PXRMINQ("^PXD(811.2,","Select a taxonomy to expand: ")
 I TAXIEN=-1 Q
 D EXPAND(TAXIEN,"")
 Q
 ;
 ;====================================================
SZN ;Set 0 node.
 N IEN,TOTAL
 S (IEN,TOTAL)=0
 F  S IEN=+$O(^PXD(811.3,IEN)) Q:IEN=0  S TOTAL=TOTAL+1
 ;Third piece is last number entered, fourth piece is the number
 ;of entries.
 S $P(^PXD(811.3,0),U,3,4)="1^"_TOTAL
 Q
 ;
 ;====================================================
ULOCKXTL(TAXIEN) ;Unlock the expanded taxonomy.
 L -^PXD(811.3,TAXIEN)
 Q
 ;
