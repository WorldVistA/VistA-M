PXRMVPTR ; SLC/PKR - Routines for dealing with variable pointers. ; 02/06/2001
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
 ;==================================================
BLDALIST(FILE,FIELD,LIST) ;Build a list of variable pointer information
 ;indexed by the abbreviation.
 N ABBR,FN,IND,ROOT,TEMP
 S IND=0
 F  S IND=$O(^DD(FILE,FIELD,"V",IND)) Q:+IND=0  D
 . S TEMP=^DD(FILE,FIELD,"V",IND,0)
 . S FN=$P(TEMP,U,1)
 . S ROOT=$$ROOT^DILFD(FN)
 . S ROOT=$P(ROOT,"^",2)
 . S ABBR=$P(TEMP,U,4)
 . S LIST(ABBR)=TEMP
 Q
 ;
 ;==================================================
BLDNLIST(FILE,FIELD,LIST) ;Build a list of variable pointer information
 ;indexed by the file number.
 N FN,IND,ROOT,TEMP
 ;DBIA #2991
 S IND=0
 F  S IND=$O(^DD(FILE,FIELD,"V",IND)) Q:+IND=0  D
 . S TEMP=^DD(FILE,FIELD,"V",IND,0)
 . S FN=$P(TEMP,U,1)
 . S ROOT=$$ROOT^DILFD(FN)
 . S ROOT=$P(ROOT,"^",2)
 . S LIST(FN)=TEMP
 Q
 ;
 ;==================================================
BLDRLIST(FILE,FIELD,LIST) ;Build a list of variable pointer information
 ;indexed by the root.
 N FN,IND,ROOT,TEMP
 S IND=0
 F  S IND=$O(^DD(FILE,FIELD,"V",IND)) Q:+IND=0  D
 . S TEMP=^DD(FILE,FIELD,"V",IND,0)
 . S FN=$P(TEMP,U,1)
 . S ROOT=$$ROOT^DILFD(FN)
 . S ROOT=$P(ROOT,"^",2)
 . S LIST(ROOT)=TEMP
 Q
 ;
