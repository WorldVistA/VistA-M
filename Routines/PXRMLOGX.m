PXRMLOGX ; SLC/PKR - Clinical Reminders logic cross-reference routines. ;08/29/2005
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;==================
BLDAFL(IEN,KI,NODEP) ;Build a list of findings that can change the
 ;frequency age range set. This is called by FileMan whenever the
 ;minimum age, maximum age, or frequency fields of the findings
 ;multiple are edited.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N FREQ,FLIST,FTYPE,IND,OK,NODE,NUM,STARTCHK
 S STARTCHK=$S($D(^PXD(811.9,IEN,25)):100,1:150)
 S FLIST="",OK=1,NUM=0
 F NODE=20,25 D
 . S FTYPE=$S(NODE=25:"FF",1:"")
 . S IND=0
 . F  S IND=$O(^PXD(811.9,IEN,NODE,IND)) Q:+IND=0  D
 ..;If an entry is being deleted skip it.
 .. I IND=$G(KI),NODE=NODEP Q
 .. S FREQ=$P(^PXD(811.9,IEN,NODE,IND,0),U,4)
 .. I FREQ'="" D
 ... S NUM=NUM+1
 ... I NUM>STARTCHK S OK=$$CHKSLEN(FLIST,";"_IND)
 ... I NUM>1 S FLIST=FLIST_";"
 ... I OK S FLIST=FLIST_FTYPE_IND
 S OK=$$CHKSLEN(FLIST,NUM_U)
 I OK S ^PXD(811.9,IEN,40)=NUM_U_FLIST
 E  D
 . S ^PXD(811.9,IEN,40)=-1
 . D ERRMSG("age")
 Q
 ;
 ;==================
BLDALL(IEN,KI,NODEP) ;Build all the findings lists.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 I '$D(^PXD(811.9,IEN)) Q
 D BLDPCLS^PXRMLOGX(IEN,KI,NODEP)
 D BLDRESLS^PXRMLOGX(IEN,KI,NODEP)
 D BLDAFL^PXRMLOGX(IEN,KI,NODEP)
 D BLDINFL^PXRMLOGX(IEN,KI,NODEP)
 Q
 ;
 ;==================
BLDINFL(IEN,KI,NODEP) ;Build the list of findings that are information only.
 ;This is called by the routines that build the resolution findings
 ;list, the patient cohort findings list, and the age finding list.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N FIA,FLIST,FTYPE,IND,NODE,NUM,OK,SUB,STARTCHK,TEMP
 S STARTCHK=$S($D(^PXD(811.9,IEN,25)):100,1:150)
 F NODE=20,25 D
 . S FTYPE=$S(NODE=25:"FF",1:"")
 . S IND=0
 . F  S IND=$O(^PXD(811.9,IEN,NODE,IND)) Q:+IND=0  D
 ..;If an entry is being deleted skip it.
 .. I IND=$G(KI),NODE=NODEP Q
 .. S SUB=FTYPE_IND
 .. S FIA(SUB)=""
 ;Remove the patient cohort findings.
 S TEMP=$G(^PXD(811.9,IEN,32))
 S NUM=+$P(TEMP,U,1)
 S FLIST=$P(TEMP,U,2)
 F IND=1:1:NUM D
 . S TEMP=$P(FLIST,";",IND)
 . I $D(FIA(TEMP)) K FIA(TEMP)
 ;Remove the resolution findings.
 S TEMP=$G(^PXD(811.9,IEN,36))
 S NUM=+$P(TEMP,U,1)
 S FLIST=$P(TEMP,U,2)
 F IND=1:1:NUM D
 . S TEMP=$P(FLIST,";",IND)
 . I $D(FIA(TEMP)) K FIA(TEMP)
 ;Remove the age findings.
 S TEMP=$G(^PXD(811.9,IEN,40))
 S NUM=+$P(TEMP,U,1)
 S FLIST=$P(TEMP,U,2)
 F IND=1:1:NUM D
 . S TEMP=$P(FLIST,";",IND)
 . I $D(FIA(TEMP)) K FIA(TEMP)
 ;What is left is the information findings.
 S FLIST="",OK=1
 S (IND,NUM)=0
 F  S IND=$O(FIA(IND)) Q:IND=""  D
 . S NUM=NUM+1
 . I NUM>STARTCHK S OK=$$CHKSLEN(FLIST,";"_IND)
 . I NUM>1 S FLIST=FLIST_";"
 . I OK S FLIST=FLIST_IND
 S OK=$$CHKSLEN(FLIST,NUM_U)
 I OK S ^PXD(811.9,IEN,42)=NUM_U_FLIST
 E  D
 . S ^PXD(811.9,IEN,42)=-1
 . D ERRMSG("information")
 Q
 ;
 ;==================
BLDPCLS(IEN,KI,NODEP) ;Build the Internal Patient Cohort Logic string for a
 ;reminder. This is called by FileMan whenever the USE IN PATIENT COHORT
 ;LOGIC field is edited or the user defined Patient Cohort Logic is
 ;killed. Also builds the patient cohort logic list.
 ;If there is a user defined PATIENT COHORT LOGIC then don't do anything.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 I $L($G(^PXD(811.9,IEN,30)))>0 Q
 N FLIST,FTYPE,IND,NODE,NUM,OK,PCLOG,STARTCHK,TEMP,UPCLOG
 S STARTCHK=$S($D(^PXD(811.9,IEN,25)):100,1:150)
 S OK=1
 S PCLOG="(SEX)&(AGE)"
 S FLIST="SEX;AGE",NUM=2
 F NODE=20,25 D
 . S FTYPE=$S(NODE=20:"FI",NODE=25:"FF")
 . S IND=0
 . F  S IND=$O(^PXD(811.9,IEN,NODE,IND)) Q:+IND=0  D
 ..;If an entry is being deleted skip it.
 .. I IND=$G(KI),NODE=NODEP Q
 .. S TEMP=^PXD(811.9,IEN,NODE,IND,0)
 .. S UPCLOG=$P(TEMP,U,7)
 .. I UPCLOG'="" D
 ... S PCLOG=PCLOG_UPCLOG_FTYPE_"("_IND_")"
 ... S NUM=NUM+1
 ... I NUM>STARTCHK S OK=$$CHKSLEN(FLIST,";"_IND)
 ... I OK S FLIST=FLIST_";"_$S(NODE=25:"FF"_IND,1:IND)
 ;Save the internal string and the findings list.
 S OK=$$CHKSLEN(FLIST,NUM_U)
 I OK D
 . S ^PXD(811.9,IEN,31)=PCLOG
 . S ^PXD(811.9,IEN,32)=NUM_U_FLIST
 E  D
 . S ^PXD(811.9,IEN,32)=-1
 . D ERRMSG("cohort")
 Q
 ;
 ;==================
BLDRESLS(IEN,KI,NODEP) ;Build the Internal Resolution Logic string for a
 ;reminder. This is called by FileMan whenever the USE IN RESOLUTION
 ;LOGIC field is edited or the user defined Resolution Logic is killed.
 ;If there is a user defined RESOLUTION LOGIC then don't do
 ;anything.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 I $L($G(^PXD(811.9,IEN,34)))>0 Q
 N FLIST,FTYPE,IND,NODE,NUM,OK,RESLOG,STARTCHK,TEMP,URESLOG
 S STARTCHK=$S($D(^PXD(811.9,IEN,25)):100,1:150)
 S OK=1
 S (FLIST,RESLOG)="",NUM=0
 F NODE=20,25 D
 . S FTYPE=$S(NODE=20:"FI",NODE=25:"FF")
 . S IND=0
 . F  S IND=$O(^PXD(811.9,IEN,NODE,IND)) Q:+IND=0  D
 ..;If an entry is being deleted skip it.
 .. I IND=$G(KI),NODE=NODEP Q
 .. S TEMP=^PXD(811.9,IEN,NODE,IND,0)
 .. S URESLOG=$P(TEMP,U,6)
 .. I URESLOG'="" D
 ... S RESLOG=RESLOG_URESLOG_FTYPE_"("_IND_")"
 ... S NUM=NUM+1
 ... I NUM>STARTCHK S OK=$$CHKSLEN(FLIST,";"_IND)
 ... I NUM>1 S FLIST=FLIST_";"
 ... I OK S FLIST=FLIST_$S(NODE=25:"FF"_IND,1:IND)
 ;Save as the internal string and the findings list.
 I RESLOG="" S ^PXD(811.9,IEN,35)=""
 E  D
 . S TEMP=$E(RESLOG,1,1)
 . S RESLOG=$S(TEMP="&":"(1)",TEMP="!":"(0)",1:"")_RESLOG
 . S ^PXD(811.9,IEN,35)=RESLOG
 S OK=$$CHKSLEN(FLIST,NUM_U)
 I OK S ^PXD(811.9,IEN,36)=NUM_U_FLIST
 I 'OK  D
 . S ^PXD(811.9,IEN,36)=-1
 . D ERRMSG("resolution")
 ;Check the resolution logic to see if it can be satisfied solely
 ;by function findings.
 I NUM>0,FLIST["FF",RESLOG'="" D CRESLOG^PXRMFFDB(NUM,FLIST,RESLOG)
 Q
 ;
 ;==================
CHKSLEN(STRING,WORD) ;Determine if appending WORD to STRING will cause
 ;string to exceed the maximum string length.
 N MAXSLEN S MAXSLEN=512
 I ($L(STRING)+$L(WORD))>MAXSLEN Q 0
 Q 1
 ;
 ;==================
CPPCLS(IEN,X) ;Copy the user input Patient Cohort Logic string to the
 ;Internal Patient Cohort Logic string.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 S ^PXD(811.9,IEN,31)=X
 ;Get the list of findings.
 N FLIST,IND,NUM,OK,OPER,STACK,STARTCHK,T1,T2
 S STARTCHK=$S($D(^PXD(811.9,IEN,25)):100,1:150)
 S OPER="'!&<>,",NUM=0,OK=1,FLIST=""
 D POSTFIX^PXRMSTAC(X,OPER,.STACK)
 F IND=1:1:STACK(0) D
 . S T1=STACK(IND)
 . I OPER[T1 Q
 . I (T1="AGE")!(T1="SEX") D  Q
 .. I NUM>0 S FLIST=FLIST_";"
 .. S NUM=NUM+1,FLIST=FLIST_T1
 . I (T1="FF")!(T1="FI") D
 .. S IND=IND+1
 .. S T2=STACK(IND)
 .. I NUM>0 S FLIST=FLIST_";"
 .. S NUM=NUM+1
 .. I NUM>STARTCHK S OK=$$CHKSLEN(FLIST,";"_IND)
 .. I OK S FLIST=FLIST_$S(T1="FF":"FF"_T2,1:T2)
 S OK=$$CHKSLEN(FLIST,NUM_U)
 I OK S ^PXD(811.9,IEN,32)=NUM_U_FLIST
 E  D
 . S ^PXD(811.9,IEN,32)=-1
 . D ERRMSG("cohort")
 Q
 ;
 ;==================
CPRESLS(IEN,X) ;Copy the user input Resolution Logic string to the
 ;Internal Resolution Logic string.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 S ^PXD(811.9,IEN,35)=X
 ;Build the list of findings
 ;Get the list of findings.
 N FLIST,IND,NUM,OK,OPER,STACK,STARTCHK,T1,T2
 S STARTCHK=$S($D(^PXD(811.9,IEN,25)):100,1:150)
 S OPER="'!&<>",OK=1,NUM=0,FLIST=""
 D POSTFIX^PXRMSTAC(X,OPER,.STACK)
 F IND=1:1:STACK(0) D
 . S T1=STACK(IND)
 . I OPER[T1 Q
 . S IND=IND+1
 . S T2=STACK(IND)
 . S NUM=NUM+1
 . I NUM>STARTCHK S OK=$$CHKSLEN(FLIST,";"_IND)
 . I NUM>1 S FLIST=FLIST_";"
 . I OK S FLIST=FLIST_$S(T1="FF":"FF"_T2,1:T2)
 S OK=$$CHKSLEN(FLIST,NUM_U)
 I OK D
 . S ^PXD(811.9,IEN,36)=NUM_U_FLIST
 .;Check the resolution logic to see if it can be satisfied solely
 .;by function findings.
 . I NUM>0,FLIST["FF",X'="" D CRESLOG^PXRMFFDB(NUM,FLIST,X)
 I 'OK D
 . S ^PXD(811.9,IEN,40)=-1
 . D ERRMSG("resolution")
 Q
 ;
 ;==================
DELNXR(X2) ;For a new style cross-reference check X2 to determine
 ;if a delete is being done. If it is a delete all the X2 elements will
 ;be null.
 N IND,X2NULL
 S X2NULL=1
 S IND=0
 F  S IND=$O(X2(IND)) Q:(+IND=0)!('X2NULL)  D
 . I X2(IND)'="" S X2NULL=0
 Q X2NULL
 ;
 ;==================
EDITNXR(X1,X2) ;For a new style cross-reference check X1 and X2 to determine
 ;if an edit is being done.
 N ADD,AREDIFF,EDIT,IND,X1NULL,X2NULL
 S AREDIFF=0
 S (X1NULL,X2NULL)=1
 S IND=0
 F  S IND=$O(X1(IND)) Q:+IND=0  D
 . I X1(IND)'="" S X1NULL=0
 . I X2(IND)'="" S X2NULL=0
 . I X1(IND)'=X2(IND) S AREDIFF=1
 I X1NULL&'X2NULL S ADD=1
 E  S ADD=0
 I 'X1NULL&'X2NULL&AREDIFF S EDIT=1
 E  S EDIT=0
 Q (ADD!EDIT)
 ;
 ;==================
ERRMSG(FTYPE) ;Display too many findings error message.
 N TEXT
 S TEXT(1)=" "
 S TEXT(2)="Error - The number of "_FTYPE_" findings exceeds the maximum allowed!"
 S TEXT(3)="The reminder will not function properly until some are removed."
 S TEXT(4)=" "
 D EN^DDIOL(.TEXT)
 Q
 ;
