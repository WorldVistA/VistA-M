PXRMP6IC ; SLC/PKR - Inits for PXRM*2.0*6 ;10/26/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;========================
MHCOND ;Check for definitions and terms that use an MH finding and a
 ;condition and convert the condition.
 N COND,FDA,FI,ICOND,IEN,IENS,MSG,NEWCOND,PTR
 D BMES^XPDUTL("Converting Conditions for MH findings in definitions and terms.")
 ;Check definitions.
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . I '$D(^PXD(811.9,IEN,20,"E","YTT(601.71,")) Q
 . S PTR=""
 . F  S PTR=$O(^PXD(811.9,IEN,20,"E","YTT(601.71,",PTR)) Q:PTR=""  D
 .. S FI=0
 .. F  S FI=$O(^PXD(811.9,IEN,20,"E","YTT(601.71,",PTR,FI)) Q:FI=""  D
 ... S COND=$P($G(^PXD(811.9,IEN,20,FI,3)),U,1)
 ... I COND="" Q
 ... W !,"811.9 - IEN=",IEN," FI=",FI," COND=",COND
 ... S NEWCOND=$$NEWCOND(COND)
 ... W !,NEWCOND
 ... K FDA,MSG
 ... S IENS=FI_","_IEN_","
 ...;Force it to file by deleting the value.
 ... S FDA(811.902,IENS,14)="@"
 ... D FILE^DIE("E","FDA","MSG")
 ... S FDA(811.902,IENS,14)=NEWCOND
 ... D FILE^DIE("E","FDA","MSG")
 ;Check terms
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . I '$D(^PXRMD(811.5,IEN,20,"E","YTT(601.71,")) Q
 . S PTR=""
 . F  S PTR=$O(^PXRMD(811.5,IEN,20,"E","YTT(601.71,",PTR)) Q:PTR=""  D
 .. S FI=0
 .. F  S FI=$O(^PXRMD(811.5,IEN,20,"E","YTT(601.71,",PTR,FI)) Q:FI=""  D
 ... S COND=$P($G(^PXRMD(811.5,IEN,20,FI,3)),U,1)
 ... I COND="" Q
 ... W !,"811.5 - IEN=",IEN," FI=",FI," COND=",COND
 ... S NEWCOND=$$NEWCOND(COND)
 ... W !,NEWCOND
 ... K FDA,MSG
 ... S IENS=FI_","_IEN_","
 ...;Force it to file by deleting the value.
 ... S FDA(811.902,IENS,14)="@"
 ... D FILE^DIE("E","FDA","MSG")
 ... S FDA(811.52,IENS,14)=NEWCOND
 ... D FILE^DIE("E","FDA","MSG")
 Q
 ;
 ;========================
NEWCOND(COND) ;Replace V with +V for MH conditions using scale.
 N CHAR,IND,NEWCOND
 S COND=$TR(COND,"+","")
 S NEWCOND=""
 F IND=1:1:$L(COND) D
 . S CHAR=$E(COND,IND)
 . I CHAR'="V" S NEWCOND=NEWCOND_CHAR Q
 .;If the condition is checking a response do not plus.
 . I $E(COND,(IND+3))="R" S NEWCOND=NEWCOND_CHAR Q
 . S NEWCOND=NEWCOND_"+"_CHAR
 Q NEWCOND
