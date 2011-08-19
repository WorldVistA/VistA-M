PXRMLIST ; SLC/PKR/PJH - Clinical Reminders list functions. ;07/17/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;Used in the reminder exchange utility for building lists of
 ;reminders, Exchange File entries, etc.
 ;=======================================================
FRDEF(NAME,PNAME) ;Format the reminder name and print name.
 N IND,TEMP
 S TEMP=$$LJ^XLFSTR(NAME,40," ")
 S TEMP=TEMP_PNAME
 Q TEMP
 ;
 ;=======================================================
FMT(NUMBER,NAME,SOURCE,DATE,FMTSTR,NL,OUTPUT) ;Format  entry number, name,
 ;source, and date packed for LM display.
 N TEMP,TSOURCE
 S TEMP=NUMBER_U_NAME
 S TSOURCE=$E($P(SOURCE,",",1),1,12)_"@"_$E($P(SOURCE," at ",2),1,12)
 S TEMP=TEMP_U_TSOURCE
 S DATE=$$FMTE^XLFDT(DATE,"5Z")
 S TEMP=TEMP_U_DATE
 D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NL,.OUTPUT)
 Q
 ;
 ;=======================================================
LIST ;Print a list of location lists.
 N BY,DIC,FLDS,FR,L,PXRMEDOK
 S PXRMEDOK=1
 S BY=".01"
 S DIC="^PXRMD(810.9,"
 S FLDS="[PXRM LOCATION LIST LIST]"
 S FR=""
 S L=0
 D EN1^DIP
 Q
 ;
 ;=======================================================
MRKINACT(TEXT) ;Append the inactive mark to TEXT in column 77.
 N IC,NSPA
 S NSPA=77-$L(TEXT)
 F IC=1:1:NSPA S TEXT=TEXT_" "
 S TEXT=TEXT_"X"
 Q TEXT
 ;
 ;=======================================================
QUERYAO() ;See if the user wants only active reminders listed.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA"
 S DIR("A")="List active reminders only? "
 S DIR("B")="Y"
 W !
 D ^DIR
 Q Y
 ;
 ;=======================================================
RDEF(DEFLIST,ARO) ;Build a list of the name and print name of all
 ;reminder definitions.
 N INACTIVE,IEN,NAME,PNAME,REMINDER
 S INACTIVE=""
 ;Build the list of reminders in alphabetical order.
 S VALMCNT=0
 S NAME=""
 F  S NAME=$O(^PXD(811.9,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.9,"B",NAME,""))
 . S REMINDER=^PXD(811.9,IEN,0)
 . S INACTIVE=$P(REMINDER,U,6)
 . I (ARO)&(INACTIVE) Q
 . S VALMCNT=VALMCNT+1
 . S PNAME=$P(REMINDER,U,3)
 . S DEFLIST(VALMCNT,0)=$$FRDEF(NAME,PNAME)
 . I INACTIVE D
 .. S DEFLIST(VALMCNT,0)=$$MRKINACT(DEFLIST(VALMCNT,0))
 S DEFLIST("VALMCNT")=VALMCNT
 Q
 ;
 ;=======================================================
REXL(RLIST) ;Build a list of exchange repository entries.
 N DATE,EXIEN,FMTSTR,IND,NAME,NL,NUM,OUTPUT,SOURCE,STR
 ;Build the list in alphabetical order.
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLL")
 S (NUM,VALMCNT)=0
 S NAME=""
 F  S NAME=$O(^PXD(811.8,"B",NAME)) Q:NAME=""  D
 . S DATE=""
 . F  S DATE=$O(^PXD(811.8,"B",NAME,DATE)) Q:DATE=""  D
 .. S EXIEN=$O(^PXD(811.8,"B",NAME,DATE,""))
 .. S SOURCE=$P(^PXD(811.8,EXIEN,0),U,2)
 .. S NUM=NUM+1
 .. S ^TMP(RLIST,$J,"SEL",NUM)=EXIEN
 .. D FMT(NUM,NAME,SOURCE,DATE,FMTSTR,.NL,.OUTPUT)
 .. F IND=1:1:NL D
 ... S VALMCNT=VALMCNT+1,^TMP(RLIST,$J,VALMCNT,0)=OUTPUT(IND)
 ... S ^TMP(RLIST,$J,"IDX",VALMCNT,NUM)=""
 S ^TMP(RLIST,$J,"VALMCNT")=VALMCNT
 Q
 ;
 ;=======================================================
SPONSOR ;Print a list of Sponsors.
 N BY,DIC,FLDS,FR,L,PXRMEDOK
 S PXRMEDOK=1
 S BY=".01"
 S DIC="^PXRMD(811.6,"
 S FLDS="[PXRM SPONSOR LIST]"
 S FR=""
 S L=0
 D EN1^DIP
 Q
 ;
