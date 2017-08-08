GMTSP98E ;WAT - ENV CHECK FOR GMTS*2.7*98 ;03/25/16  12:00
 ;;2.7;Health Summary;**98**;Oct 20, 1995;Build 88
 ;XPDUTL #10141
 W !," Verifying installation environment...",!!
 N GMTSABRT,GMTSRIEN,FLG18,FLG19 S (GMTSABRT,FLG18,FLG19)=0
 I $$PATCH^XPDUTL("GMTS*2.7*98") D  Q
 . ;ensure types are at correct IEN.
 . I +$O(^GMT(142,"B","REMOTE HT CLINICAL REMINDERS",""))=5000018 S FLG18=1
 . I +$O(^GMT(142,"B","REMOTE HT TRACKING",""))=5000019 S FLG19=1
 . I FLG18&(FLG19) W !,"  Verification complete; environment check passed  " Q
 . I 'FLG18 D MSG(5000018) S GMTSABRT=1
 . I 'FLG19 D MSG(5000019) S GMTSABRT=1
 . I GMTSABRT W !,"Please re-install HT TEMPLATES PROJECT 1.0 when necessary changes are complete." S XPDABORT=1 Q
 F GMTSRIEN=5000018,5000019 D
 .I $D(^GMT(142,GMTSRIEN)) D
 ..D MSG(GMTSRIEN) S GMTSABRT=1
 ..I +$G(GMTSABRT) W !,"Please re-install HT TEMPLATES PROJECT 1.0 when necessary changes are complete." S XPDABORT=1 Q
 I +$G(GMTSABRT)=0 W !,"  Verification complete; environment check passed  "
 Q
 ;
MSG(IEN) ;abort message to screen
 W !!,"!!! INSTALL ABORT !!!"
 W !,"HEALTH SUMMARY TYPE IEN ***"_$G(IEN)_"*** is occupied."
 W !,"This IEN is reserved for National REMOTE HEALTH SUMMARY TYPES and is expected"
 W !,"to be undefined so that GMTS*2.7*98 may install a new entry in that location."
 W !,"Please DO NOT delete the file entry at "_$G(IEN)
 W !!,"Please DO contact the National Help Desk at 1-888-596-4357 and request"
 W !,"a help desk ticket be created to the NTL SUP Clin 1 team."
 Q
 ;
