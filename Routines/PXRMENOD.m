PXRMENOD ; SLC/PKR - Clinical Reminders "E" node routines. ;12/13/2006
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;========================================================
KENODE(X,DA,FILENUM) ;Kill the enode in the finding multiple for definitions
 ;and terms.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 N DAS,GLOBAL,IEN
 S IEN=$P(X,";",1)
 S GLOBAL=$P(X,";",2)
 I GLOBAL="LAB(60," D
 . N SUB
 .;DBIA #91-A
 . S SUB=$P(^LAB(60,IEN,0),U,4)
 . I SUB="CH" Q
 . I (SUB="BB")!(SUB="WK") S IEN="" Q
 . I SUB="MI" S IEN="M;T;"_IEN Q
 .;All other SUB values: AU, CY, EM, SP
 . S IEN="A;T;"_IEN
 S DAS=IEN
 I DAS="" Q
 I FILENUM=811.5 K ^PXRMD(811.5,DA(1),20,"E",GLOBAL,DAS,DA)
 I FILENUM=811.9 K ^PXD(811.9,DA(1),20,"E",GLOBAL,DAS,DA)
 Q
 ;
 ;========================================================
SENODE(X,DA,FILENUM) ;Set the enode in the finding multiple for definitions
 ;and terms.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 N DAS,GLOBAL,IEN,NAME
 S IEN=$P(X,";",1)
 S GLOBAL=$P(X,";",2)
 I GLOBAL="LAB(60," D
 . N SUB
 .;DBIA #91-A
 . S SUB=$P(^LAB(60,IEN,0),U,4)
 . I SUB="CH" Q
 . I (SUB="BB")!(SUB="WK") S IEN="" Q
 . I SUB="MI" S IEN="M;T;"_IEN Q
 .;All other SUB values: AU, CY, EM, SP
 . S IEN="A;T;"_IEN
 S DAS=IEN
 I DAS="" Q
 S NAME=""
 I FILENUM=811.5 S ^PXRMD(811.5,DA(1),20,"E",GLOBAL,DAS,DA)=NAME
 I FILENUM=811.9 S ^PXD(811.9,DA(1),20,"E",GLOBAL,DAS,DA)=NAME
 Q
 ;
