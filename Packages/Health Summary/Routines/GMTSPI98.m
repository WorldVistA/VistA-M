GMTSPI98 ;SLC/WAT - Post Install GMTS*2.7*98 ;03/02/17  11:13
 ;;2.7;Health Summary;**98**;Oct 20, 1995;Build 88
 ;;
 ;INTEGRATION CONTROL REGISTRATION
 ;UPDATE^DIE #2053
 ;FIND1^DIC  #3217
 ;FIND^DIC   #2051
 ;MES and $$PATCH^XPDUTL #10141
 ;^PXRMEXSI #4371
 ;READ OF REMINDER EXCHANGE FILE ^PXD(811.8  #4586
 ;;ENV CHECK - ensure IENs are empty before proceeding
 D BMES^XPDUTL(" Verifying installation environment...")
 N GMTSABRT,GMTSRIEN,FLG18,FLG19 S (GMTSABRT,FLG18,FLG19)=0
 I $$PATCH^XPDUTL("GMTS*2.7*98") D  Q
 . ;ensure types are at correct IEN.
 . I +$O(^GMT(142,"B","REMOTE HT CLINICAL REMINDERS",""))=5000018 S FLG18=1
 . I +$O(^GMT(142,"B","REMOTE HT TRACKING",""))=5000019 S FLG19=1
 . I FLG18&(FLG19) D BMES^XPDUTL("  Verification complete; environment check passed  ") Q
 . I 'FLG18 D MSG(5000018) S GMTSABRT=1
 . I 'FLG19 D MSG(5000019) S GMTSABRT=1
 . I GMTSABRT D BMES^XPDUTL("Please re-install HT TEMPLATES PROJECT 1.0 when necessary changes are complete.") S XPDABORT=1 Q
 F GMTSRIEN=5000018,5000019 D
 .I $D(^GMT(142,GMTSRIEN)) D
 ..D MSG(GMTSRIEN) S GMTSABRT=1
 ..I +$G(GMTSABRT) D BMES^XPDUTL("Please re-install HT TEMPLATES PROJECT 1.0 when necessary changes are complete.") S XPDABORT=1 Q
 D:+$G(GMTSABRT)=0 BMES^XPDUTL("  Verification complete; environment check passed  ")
 Q
 ;
MSG(IEN) ;abort message to screen
 D BMES^XPDUTL("!!! INSTALL ABORT !!!")
 D MES^XPDUTL("HEALTH SUMMARY TYPE IEN ***"_$G(IEN)_"*** is occupied.")
 D MES^XPDUTL("This IEN is reserved for National REMOTE HEALTH SUMMARY TYPES and is expected")
 D MES^XPDUTL("to be undefined so that GMTS*2.7*98 may install a new entry in that location.")
 D MES^XPDUTL("Please DO NOT delete the file entry at "_$G(IEN))
 D BMES^XPDUTL("Please DO contact the National Help Desk at 1-888-596-4357 and request")
 D MES^XPDUTL("a help desk ticket be created to the NTL SUP Clin 1 team.")
 Q
 ;
PRE ;housekeeping
 D DELEXE^PXRMEXSI("EXARRAY","GMTSPI98")
 D INSTUB
 Q
 ;
POST ;post
 D SMEXINS^PXRMEXSI("EXARRAY","GMTSPI98")
 D GMTSET
 Q
 ;
GMTSET ;reset ^GMT(142,0) to last low IEN
 N IEN,LIEN
 S IEN=0 F  S IEN=$O(^GMT(142,IEN)) D  Q:IEN'>0!(IEN=5000001)
 .I IEN<5000000 S LIEN=IEN
 I +$G(LIEN)>0 S $P(^GMT(142,0),U,3)=LIEN
 Q
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-HT REMOTE HEALTH SUMMARY TYPES"
 I MODE["I" S ARRAY(LN,2)="02/15/2017@06:55:47"
 I MODE["A" S ARRAY(LN,3)="O"
 Q
 ;
INSTUB ; create stubs for REMOTE types
 ;if already there, no need for stubs - rem exch will overwrite existing entries so always left with current
 ;ensure IENs are empty before adding new stubs
 I +$O(^GMT(142,"B","REMOTE HT CLINICAL REMINDERS",""))=5000018,+$O(^GMT(142,"B","REMOTE HT TRACKING",""))=5000019 Q
 N FDA,MSG,HSIEN
 I $D(^GMT(142,5000018,0))=0 D
 .S FDA(1,142,"+1,",.01)="REMOTE HT CLINICAL REMINDERS"
 .S HSIEN(1)=5000018
 .D UPDATE^DIE("S","FDA(1)","HSIEN","MSG")
 I $D(^GMT(142,5000019,0))=0 D
 .S FDA(1,142,"+1,",.01)="REMOTE HT TRACKING"
 .S HSIEN(1)=5000019
 .D UPDATE^DIE("","FDA(1)","HSIEN","MSG")
 .I $D(MSG)>0 D AWRITE("MSG")
 Q
 ;
AWRITE(REF) ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or ^TMP("PXRM",$J).
 ;coied from PXRMUTIL
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,TEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,TEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.TEXT)
 Q
 ;
