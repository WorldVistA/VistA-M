PXRMICK1 ;SLC/PKR - Integrity checking routines continue. ;07/31/2020
 ;;2.0;CLINICAL REMINDERS;**45,42**;Feb 04, 2005;Build 245
 ;
 ;===============
OUTPUT(NOUT,TEXT) ;Output TEXT array.
 I $G(PXRMDONE) Q
 N ANS,EXIT,IND
 S EXIT=0
 F IND=1:1:NOUT D
 . W !,TEXT(IND)
 . I ($Y+2>IOSL),$E(IOST,1,2)="C-" D
 .. W !,"Press ENTER to continue or '^' to exit: "
 .. R ANS:DTIME
 .. S EXIT=('$T)!(ANS="^")
 .. I 'EXIT W #
 . I EXIT Q
 I EXIT S PXRMDONE=1
 Q
 ;
 ;===============
TERM(IEN,OUTPUT,WRITE) ;Definition integrity check. 0 is returned if the
 ;definition has fatal errors, otherwise 1 is returned.
 ;Warning and error text is stored in the OUTPUT array. If WRITE=1 then
 ;the contents of OUTPUT will be written out.
 N OK,NL
 S NL=0
 S OK=$$TERMCHK^PXRMICK1("",IEN,.NL,.OUTPUT)
 I OK S TEXT(1)="No fatal term errors were found."
 E  S TEXT(1)="This term has fatal errors and it will not work!"
 D ADDTEXT^PXRMICHK(1,.TEXT,.NL,.OUTPUT)
 I WRITE=1 D OUTPUT^PXRMICK1(NL,.OUTPUT)
 Q OK
 ;
 ;===============
TERMCHK(USAGE,TIEN,NL,OUTPUT) ;Check terms.
 ;TERMCHK(USAGE,TIEN,DEFARR,NL,OUTPUT) ;Check terms.
 N FI,FIEN,FNUM,GBL,JND,OK,TERMARR,TEXT,TNAME,TTEXT,ZNODE
 I '$D(^PXRMD(811.5,TIEN)) D  Q 0
 . S TEXT(1)="FATAL: Term IEN="_TIEN_" does not exist."
 . D ADDTEXT^PXRMICHK(1,.TEXT,.NL,.OUTPUT)
 S TNAME=$P(^PXRMD(811.5,TIEN,0),U,1)_" ("_TIEN_")"
 S TTEXT=" The term is "_TNAME_"."
 S OK=1
 D TERM^PXRMLDR(TIEN,.TERMARR)
 ;Check findings and finding modifiers.
 S JND=0
 F  S JND=+$O(TERMARR(20,JND)) Q:JND=0  D
 . S ZNODE=TERMARR(20,JND,0)
 . S FI=$P(ZNODE,U,1)
 . S FIEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . I (FIEN'=+FIEN)!(GBL="") D  Q
 .. K TEXT
 .. S TEXT(1)="FATAL: Term finding number "_JND_" is invalid."
 .. S TEXT(2)=TTEXT
 .. D ADDTEXT^PXRMICHK(2,.TEXT,.NL,.OUTPUT)
 .. S OK=0
 . S FNUM=$$GETFNUM^PXRMEXPS(GBL)
 . I '$$FIND1^DIC(FNUM,"","XU","`"_FIEN) D
 .. K TEXT
 .. S TEXT(1)="FATAL: Term finding number "_JND_", does not exist! It is entry number "_FIEN_" in file #"_FNUM_"."
 .. S TEXT(2)=TTEXT
 .. D ADDTEXT^PXRMICHK(2,.TEXT,.NL,.OUTPUT)
 .. S OK=0
 .;Check computed findings.
 . I (GBL="PXRMD(811.4,"),'$$CFCHK^PXRMICHK(USAGE,JND,FIEN,.TERMARR,"T",.NL,.OUTPUT) D
 ..;CFCHK issues the messages for the CF, let the user know the name
 ..;of the term.
 .. K TEXT
 .. S TEXT(1)=TTEXT
 .. D ADDTEXT^PXRMICHK(1,.TEXT,.NL,.OUTPUT)
 .. S OK=0
 Q OK
 ;
 ;===============
TCHKALL ;Check all terms.
 N IEN,NAME,OK,OUTPUT,POP,PXRMDONE,TEXT
 W #!,"Check the integrity of all reminder terms."
 D ^%ZIS Q:POP
 U IO
 S NAME="",PXRMDONE=0
 F  S NAME=$O(^PXRMD(811.5,"B",NAME)) Q:(NAME="")!(PXRMDONE)  D
 . S IEN=$O(^PXRMD(811.5,"B",NAME,""))
 . W !!,"Checking "_NAME_" (IEN="_IEN_")"
 . K OUTPUT
 . S OK=$$TERM^PXRMICK1(IEN,.OUTPUT,1)
 D ^%ZISC
 Q
 ;
 ;===============
TCHKONE ;Check selected terms.
 N DIC,DTOUT,DUOUT,IEN,OK,OUTPUT,Y
 S DIC="^PXRMD(811.5,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Reminder Term: "
GETTERM ;Get the term to check.
 W !
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 Q
 S IEN=$P(Y,U,1)
 W #
 K OUTPUT
 S OK=$$TERM^PXRMICK1(IEN,.OUTPUT,1)
 G GETTERM
 Q
 ;
