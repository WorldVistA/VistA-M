PXRMDLRP ;SLC/AGP - Dialog reporting routine ;09/8/2010
 ;;2.0;CLINICAL REMINDERS;**12,18**;Feb 04, 2005;Build 152
 Q
 ;
ALL ;
 N CNT,FAIL,IEN,MESS
 S IEN=0 F  S IEN=$O(^PXRMD(801.41,"TYPE","R",IEN)) Q:IEN'>0  D
 .I +$P($G(^PXRMD(801.41,IEN,0)),U,3)>0 Q
 .K MESS
 .S FAIL=$$RETARR(IEN,.MESS)
 .I $D(MESS) D
 ..W !
 ..S CNT=0 F  S CNT=$O(MESS(CNT)) Q:CNT'>0  D
 ...W !,MESS(CNT)
 W !!,"**DONE**"
 Q
 ;
BUILDMSG(TEXTIN,CNT,MESS) ;
 N LINE,NOUT,TEXTOUT
 D FORMAT^PXRMTEXT(1,75,1,.TEXTIN,.NOUT,.TEXTOUT)
 S CNT=CNT+1,MESS(CNT)=""
 F LINE=1:1:NOUT D
 .S CNT=CNT+1,MESS(CNT)=TEXTOUT(LINE)
 Q
 ;
DITEMAR(DIEN,ARRAY,ERRCNT,ERRMSG,FAIL) ;
 ;DIEN is the IEN of the dialog top level
 ;Array contains the dialog elements and groups within the dialog.
 N CNT,IEN,NAME,REPIEN,RSCNT,RSIEN,TEXT,TYPE
 S CNT=0 F  S CNT=$O(^PXRMD(801.41,DIEN,10,CNT)) Q:CNT'>0  D
 .S IEN=$P($G(^PXRMD(801.41,DIEN,10,CNT,0)),U,2) I IEN'>0 D  Q
 ..S NAME=$P($G(^PXRMD(801.41,DIEN,0)),U)
 ..S TYPE=$$EXTERNAL^DILFD(801.41,4,"",$P($G(^PXRMD(801.41,DIEN,0)),U,4))
 ..S TEXT(1)="The "_TYPE_" "_NAME_" contains an incomplete sequence"
 ..D BUILDMSG(.TEXT,.ERRCNT,.ERRMSG)
 ..S FAIL="F"
 .;
 .S TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 .; Disregard Prompts and Forced Values
 .I TYPE="P"!(TYPE="F")!(TYPE="") Q
 .;Check Replacement Items first
 .S REPIEN=$P($G(^PXRMD(801.41,IEN,49)),U,3)
 .I REPIEN>0 D DITEMAR(REPIEN,.ARRAY,.ERRCNT,.ERRMSG,.FAIL)
 .;Check for Result Groups second
 .I $D(^PXRMD(801.41,IEN,51))>0 D
 ..S RSCNT=0
 ..F  S RSCNT=$O(^PXRMD(801.41,IEN,51,RSCNT)) Q:RSCNT'>0  D
 ...S RSIEN=$G(^PXRMD(801.41,IEN,51,RSCNT,0)) Q:RSIEN'>0
 ...D DITEMAR(RSIEN,.ARRAY,.ERRCNT,.ERRMSG,.FAIL)
 .;do subitem third
 .D DITEMAR(IEN,.ARRAY,.ERRCNT,.ERRMSG,.FAIL) ;
 .I '$D(ARRAY(IEN)) S ARRAY(IEN)=""
 I '$D(ARRAY(DIEN)) S ARRAY(DIEN)=""
 Q
 ;
EN(DIEN,NAME,CNT,MESS,FAIL) ;
 ; entry point that loops through the dialog array and calls each
 ;validation line tag
 ;
 N DLGARR,DNAME,EXT,IEN,TYPE,UP
 D DITEMAR(DIEN,.DLGARR,.CNT,.MESS,.FAIL)
 S IEN="" F  S IEN=$O(DLGARR(IEN)) Q:IEN'>0  D
 .S DNAME=$P($G(^PXRMD(801.41,IEN,0)),U)
 .S TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 .S EXT=$$EXTERNAL^DILFD(801.41,4,"",TYPE)
 .;validate dialog item exist on the system
 . D VALIDITM(IEN,DNAME,EXT,.CNT,.MESS,.FAIL)
 .;validate findings data exist on the system
 . D VALIDFND(IEN,DNAME,EXT,TYPE,.CNT,.MESS,.FAIL)
 .;validate TIU Objects and Template Fields found in word processing
 .;fields exist on the system
 . D VALIDTXT(IEN,DNAME,EXT,TYPE,.CNT,.MESS,.FAIL)
 Q
 ;
ODDPIPES(DIEN,NAME,EXT,TYPE,CNT,MESS,FAIL) ;
 ;this line tag returns true/false and it builds an error message
 ;if the dialog text/alter PN text contains an odd number of pipes
 ;
 N AMOUNT,FLDNAM,NODE,NUM,PIPECNT,RESULT,TEXT
 S RESULT=0
 F NODE=25,35 D
 .K TEXT
 .S PIPECNT=0,NUM=0
 .F  S NUM=$O(^PXRMD(801.41,DIEN,NODE,NUM)) Q:NUM'>0  D
 ..S AMOUNT=$L(^PXRMD(801.41,DIEN,NODE,NUM,0),"|") I AMOUNT=1 Q
 ..S PIPECNT=PIPECNT+(AMOUNT-1)
 .I PIPECNT=0 Q
 .I PIPECNT#2=0 Q
 .S RESULT=1
 .S FLDNAM=$S(NODE=25:"Dialog/Progress Note Text",1:"Alternate Progress Note Text")
 .S TEXT(1)="The "_EXT_" "_DNAME_" contains an odd number of pipes (|) in the "_FLDNAM_" field. TIU Objects cannot be evaluated."
 .D BUILDMSG(.TEXT,.CNT,.MESS)
 .S FAIL="F"
 Q RESULT
 ;
RETARR(DIEN,MESS) ;
 ;This entry point is used by reminder exchange this returns an array
 ;for use in selecting a reminder dialog
 N CNT,FAIL,NAME,TYPE
 S CNT=0,FAIL=0
 S NAME=$P($G(^PXRMD(801.41,DIEN,0)),U)
 D EN(DIEN,NAME,.CNT,.MESS,.FAIL)
 I '$D(MESS) Q FAIL
 S MESS(1)=NAME_" contains the following errors."
 Q FAIL
 ;
SCREEN(DIEN) ;
 N NODE
 S NODE=$G(^PXRMD(801.41,DIEN,0))
 I $P(NODE,U,4)="P" Q 0
 I $P(NODE,U,4)="F" Q 0
 Q 1
 ;
SELECT ;
 ;this entry point is used from the option on the reminder dialog menu
 N DIC,Y
 S DIC="^PXRMD(801.41,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Dialog Definition: "
 S DIC("S")="I $$SCREEN^PXRMDLRP(Y)=1"
 ;Current dialog type only
 D ^DIC
 I Y>0 D WRITE(+Y)
 Q
 ;
VALIDFND(IEN,DNAME,EXT,TYPE,CNT,MESS,FAIL) ;
 N FIND,NODE,MHTEST,TEXT
 ;S DNAME=$P($G(^PXRMD(801.41,IEN,0)),U)
 ;
 ;disregard Reminder Dialogs and Result Elements
 I TYPE="R"!(TYPE="T") Q
 ;
 ;Result Groups only need to be check for MH Data
 I TYPE="S" D  Q
 .S NODE=$G(^PXRMD(801.41,IEN,50))
 .I +$P(NODE,U)'>0 D
 ..S TEXT(1)="The result group "_DNAME_" does not contain a valid MH Test."
 ..D BUILDMSG(.TEXT,.CNT,.MESS)
 ..S FAIL="F"
 .I +$P(NODE,U,2)'>0 D
 ..S TEXT(1)="The result group "_DNAME_" does not contain a valid MH Scale."
 ..D BUILDMSG(.TEXT,.CNT,.MESS)
 ..S FAIL="F"
 .I +$P(NODE,U)>0,$$VALIDENT($P(NODE,U)_";YTT(601.71,")=0 D
 ..S TEXT(1)="The result group "_DNAME_" does not contain a valid MH Test."
 ..D BUILDMSG(.TEXT,.CNT,.MESS)
 ..S FAIL="F"
 ;
 S NODE=$G(^PXRMD(801.41,IEN,1))
 ;check Orderable items
 I +$P(NODE,U,7)>0,$$VALIDENT(+$P(NODE,U,7)_";ORD(101.43,")=0 D
 .S TEXT(1)="The "_EXT_" "_DNAME_" contains a pointer to an Orderable Item that does not exist on the system."
 .D BUILDMSG(.TEXT,.CNT,.MESS)
 .S FAIL="F"
 ;
 ;check finding item
 I $P(NODE,U,5)'="",$$VALIDENT($P(NODE,U,5))=0 D
 .S TEXT(1)="The "_EXT_" "_DNAME_" contains an a pointer to the finding item that does not exist on the system."
 .D BUILDMSG(.TEXT,.CNT,.MESS)
 .S FAIL="F"
 ;
 ;check additional findings
 S FIND=0 F  S FIND=$O(^PXRMD(801.41,IEN,3,"B",FIND)) Q:FIND=""  D
 .I $$VALIDENT(FIND)=0 D
 ..S TEXT(1)="The "_EXT_" "_DNAME_" contains a pointer to an additional finding item that does not exist on the system."
 ..D BUILDMSG(.TEXT,.CNT,.MESS)
 ..S FAIL="F"
 Q
 ;
VALIDENT(FIND) ;
 N FILENUM,IEN
 S FILENUM=$$FNFR^PXRMUTIL(U_$P(FIND,";",2))
 Q $$FIND1^DIC(FILENUM,"","Q","`"_$P(FIND,";"))
 ;
VALIDITM(IEN,NAME,EXT,CNT,MESS,FAIL) ;
 N TEXT
 I '$D(^PXRMD(801.41,IEN)) D  Q
 .S TEXT(1)=NAME_" contains a pointer to an invalid dialog item."
 .D BUILDMSG(.TEXT,.CNT,.MESS)
 .S FAIL="F"
 I +$P(^PXRMD(801.41,IEN,0),U,3)>0 D
 .S TEXT(1)="The "_EXT_" "_NAME_" is disabled."
 .D BUILDMSG(.TEXT,.CNT,.MESS)
 .I $G(FAIL)'="F" S FAIL="W"
 Q
 ;
VALIDNAM(DIEN,DNAME,FIELD,EXT,TYPE,CNT,MESS,OLIST,TLIST,RETFAIL) ;
 N ARRAY,FAIL,FLDNAM,NAME,TCNT,TEXT
 ;determine field object/tiu template is in
 S FLDNAM=$S(FIELD=25:"Dialog Text",1:"Alternate Progress Note Text")
 S DNAME=$P($G(^PXRMD(801.41,DIEN,0)),U)
 ;
 I $D(OLIST)>0 D
 .S TCNT=0 F  S TCNT=$O(OLIST(TCNT)) Q:TCNT'>0  D
 ..S NAME=OLIST(TCNT)
 ..;do not check result element objects called SCORE
 ..I TYPE="T",NAME="SCORE" Q
 ..;dbia 5447
 ..S FAIL=$$OBJSTAT^TIUCHECK(NAME)
 ..I FAIL=-1 D  Q
 ...S TEXT(1)="The "_EXT_" "_DNAME_" contains a reference to a TIU Object "_NAME_" in the "_FLDNAM_" field. This TIU Object does not exist on the system."
 ...D BUILDMSG(.TEXT,.CNT,.MESS)
 ...S RETFAIL="F"
 ..I FAIL=0 D  Q
 ...S TEXT(1)="The "_EXT_" "_DNAME_" contains a reference to a TIU Object "_NAME_" in the "_FLDNAM_" field. This TIU Object is inactive."
 ...D BUILDMSG(.TEXT,.CNT,.MESS)
 ...I $G(RETFAIL)'="F" S RETFAIL="W"
 ;
 I $D(TLIST)>0 D
 .S TCNT=0 F  S TCNT=$O(TLIST(TCNT)) Q:TCNT'>0  D
 ..S NAME=TLIST(TCNT)
 ..;dbia 5447
 ..S FAIL=$$TEMPSTAT^TIUCHECK(NAME)
 ..I FAIL=-1 D  Q
 ...S TEXT(1)="The "_EXT_" "_DNAME_" contains a reference to a TIU Template field "_NAME_" in the "_FLDNAM_" field. This TIU Template field does not exist on the system."
 ...D BUILDMSG(.TEXT,.CNT,.MESS)
 ...S RETFAIL="F"
 ..I FAIL=0 D  Q
 ...S TEXT(1)="The "_EXT_" "_DNAME_" contains a reference to a TIU Template field "_NAME_" in the "_FLDNAM_" field. This TIU Template field is inactive."
 ...D BUILDMSG(.TEXT,.CNT,.MESS)
 ...I $G(RETFAIL)'="F" S RETFAIL="W"
 Q
 ;
 ;
VALIDTXT(DIEN,NAME,EXT,TYPE,CNT,MESS,FAIL) ;
 N OBJLIST,TEXT,TLIST
 I $$ODDPIPES(IEN,NAME,EXT,TYPE,.CNT,.MESS,.FAIL)=1 Q
 ;check dialog/progress note text
 D TIUSRCH^PXRMEXU1("^PXRMD(801.41,",DIEN,25,.OBJLIST,.TLIST)
 I $D(OBJLIST)>0!($D(TLIST)>0) D VALIDNAM(IEN,NAME,25,EXT,TYPE,.CNT,.MESS,.OBJLIST,.TLIST,.FAIL)
 K OBJLIST,TLIST
 ;Check alternate progress note text
 D TIUSRCH^PXRMEXU1("^PXRMD(801.41,",DIEN,35,.OBJLIST,.TLIST)
 I $D(OBJLIST)>0!($D(TLIST)>0) D VALIDNAM(IEN,NAME,35,EXT,TYPE,.CNT,.MESS,.OBJLIST,.TLIST,.FAIL)
 Q
 ;
TIUSRCH(DIEN) ;
 N CNT,DLGARR,DNAME,EXT,FAIL,IEN,MESS,NAME,OCNT,OBJLIST,OLIST,TLIST,TYPE
 S CNT=0,OCNT=0
 S NAME=$P($G(^PXRMD(801.41,DIEN,0)),U)
 D DITEMAR(DIEN,.DLGARR,.CNT,.MESS,.FAIL)
 S IEN="" F  S IEN=$O(DLGARR(IEN)) Q:IEN'>0  D
 .S DNAME=$P($G(^PXRMD(801.41,IEN,0)),U)
 .S TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 .S EXT=$$EXTERNAL^DILFD(801.41,4,"",TYPE)
 .I $$ODDPIPES(IEN,NAME,EXT,TYPE,.CNT,.MESS,.FAIL)=1 Q
 .;check dialog/progress note text
 .D TIUSRCH^PXRMEXU1("^PXRMD(801.41,",DIEN,25,.OBJLIST,.TLIST)
 .I $D(OBJLIST)>0 D
 ..D VALIDNAM(IEN,NAME,25,EXT,TYPE,.CNT,.MESS,.OBJLIST,.TLIST,.FAIL)
 Q
 ;
WRITE(DIEN) ;
 N CNT,FAIL,MESS,NAME
 S CNT=0
 S NAME=$P($G(^PXRMD(801.41,DIEN,0)),U)
 D EN(DIEN,NAME,.CNT,.MESS,.FAIL)
 I '$D(MESS) W !,"NO ERRORS FOUND" H 1 Q
 W !,NAME_" contains the following errors."
 S CNT=0 F  S CNT=$O(MESS(CNT)) Q:CNT'>0  D
 .W !,MESS(CNT)
 H 1
 Q
 ;
