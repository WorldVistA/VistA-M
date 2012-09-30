PXRMEXPD ;SLC/PKR - General packing driver. ;10/28/2011
 ;;2.0;CLINICAL REMINDERS;**12,17,16,18,22**;Feb 04, 2005;Build 160
 ;==========================
BLDDESC(USELLIST,TMPIND) ;If multiple entries have been selected
 ;then initialize the description with the selected list.
 N IEN,NL,NOUT,TEXT,TEXTOUT
 S TEXT(1)="The following Clinical Reminder items were selected for packing:\\"
 S FILENUM=0,NL=1
 F  S FILENUM=$O(USELLIST(FILENUM)) Q:FILENUM=""  D
 . I NL>1 S NL=NL+1,TEXT(NL)="\\"
 . S NL=NL+1,TEXT(NL)=$$GET1^DID(FILENUM,"","","NAME")_"\\"
 . S IEN=0
 . F  S IEN=+$O(USELLIST(FILENUM,"IEN",IEN)) Q:IEN=0  D
 .. S NL=NL+1,TEXT(NL)="  "_$$GET1^DIQ(FILENUM,IEN,".01")_"\\"
 D FORMAT^PXRMTEXT(1,70,NL,.TEXT,.NOUT,.TEXTOUT)
 K ^TMP(TMPIND,$J,"DESC")
 F IND=1:1:NOUT  S ^TMP(TMPIND,$J,"DESC",1,IND,0)=TEXTOUT(IND)
 Q
 ;
 ;==========================
BLDTEXT(TMPIND) ;Combine the source information and the user's input into the
 ;"TEXT" array.
 N IC,IND
 S (IC,IND)=0
 F  S IC=$O(^TMP(TMPIND,$J,"SRC",IC)) Q:+IC=0  D
 . S IND=IND+1
 . S ^TMP(TMPIND,$J,"TEXT",1,IND)=^TMP(TMPIND,$J,"SRC",IC)
 ;
 S IC=0
 F  S IC=$O(^TMP(TMPIND,$J,"TXT",1,IC)) Q:+IC=0  D
 . S IND=IND+1
 . S ^TMP(TMPIND,$J,"TEXT",1,IND)=^TMP(TMPIND,$J,"TXT",1,IC,0)
 Q
 ;
 ;==========================
CLDIQOUT(FILENUM,IEN,FIELD,IENROOT,DIQOUT) ;Clean-up the DIQOUT returned by
 ;the GETS^DIQ call.
 ;Remove edit history from all reminder files.
 D RMEH^PXRMEXPU(FILENUM,.DIQOUT)
 ;Convert the iens to the FDA adding form.
 D CONTOFDA^PXRMEXPU(.DIQOUT,.IENROOT)
 ;Remove hospital locations from location lists
 I FILENUM=810.9 K DIQOUT(810.944)
 ;TIU conversion for TIU/HS objects
 I FILENUM=8925.1,FIELD="**" D TIUCONV(FILENUM,IEN,.DIQOUT)
 Q
 ;
 ;==========================
CMPLIST(CMPLIST,SELLIST,FILELST,ERROR) ;Process the selected list and build a
 ;complete list of components to be packed.
 N CIEN,IND,JND,FNUM,LRD,NUM,PACKLIST,ROUTINE
 S ERROR=0
 F IND=1:1:FILELST(0) D
 . S FNUM=$P(FILELST(IND),U,1)
 . I '$D(SELLIST(FNUM)) Q
 . S ROUTINE=$$GETSRTN^PXRMEXPS(FNUM)_"(FNUM,CIEN,.PACKLIST)"
 . S NUM=0
 . F  S NUM=+$O(SELLIST(FNUM,NUM)) Q:NUM=0   S CIEN=SELLIST(FNUM,NUM) D @ROUTINE
 ;PACKLIST is built by following all pointers. Reversing the order
 ;for the Exchange install should allow resolution of pointers.
 S FNUM=""
 F  S FNUM=$O(PACKLIST(FNUM)) Q:FNUM=""  D
 . I $D(PACKLIST(FNUM,"ERROR")) D
 .. S IND=0,ERROR=ERROR+1
 .. I ERROR=1 W !
 .. F  S IND=+$O(PACKLIST(FNUM,"ERROR",IND)) Q:IND=0  W !,PACKLIST(FNUM,"ERROR",IND)," IEN=",IND
 . S IND="IEN",JND=0
 . F  S IND=+$O(PACKLIST(FNUM,IND),-1) Q:IND=0  S JND=JND+1,CMPLIST(FNUM,JND)=PACKLIST(FNUM,IND)
 ;If any definitions have a linked dialog add the linked dialog to the
 ;selection list so it can be marked as selected.
 I '$D(CMPLIST(811.9)) Q
 S NUM=$O(SELLIST(801.41,"IEN"),-1)
 S IND=0
 F  S IND=$O(CMPLIST(811.9,IND)) Q:IND=""  D
 . S LRD=$G(^PXD(811.9,CMPLIST(811.9,IND),51))
 . I LRD'="" S NUM=NUM+1,SELLIST(801.41,NUM)=LRD,SELLIST(801.41,"IEN",LRD)=NUM
 I ERROR D
 . W !,"Cannot create the packed file due to the above error(s)."
 . H 2
 Q
 ;
 ;==========================
CRE ;Pack a reminder component and store it in the repository.
 N CMPLIST,CNT,DIEN,DERRFND,DERRMSG,EFNAME,ERROR,FAIL,FAILTYPE,FILELST
 N OUTPUT,POA,RANK,SERROR,SELLIST,SUCCESS,TMPIND,USELLIST
 S TMPIND="PXRMEXPR"
 K ^TMP(TMPIND,$J)
 S FILELST(1)=811.4_U_$$GET1^DID(811.4,"","","NAME")
 S FILELST(2)=810.8_U_$$GET1^DID(810.8,"","","NAME")
 S FILELST(3)=811.9_U_$$GET1^DID(811.9,"","","NAME")
 S FILELST(4)=801.41_U_$$GET1^DID(801.41,"","","NAME")
 S FILELST(5)=810.7_U_$$GET1^DID(810.7,"","","NAME")
 S FILELST(6)=810.2_U_$$GET1^DID(810.2,"","","NAME")
 S FILELST(7)=810.4_U_$$GET1^DID(810.4,"","","NAME")
 S FILELST(8)=810.9_U_$$GET1^DID(810.9,"","","NAME")
 S FILELST(9)=811.6_U_$$GET1^DID(811.6,"","","NAME")
 S FILELST(10)=811.2_U_$$GET1^DID(811.2,"","","NAME")
 S FILELST(11)=811.5_U_$$GET1^DID(811.5,"","","NAME")
 S FILELST(12)=801_U_$$GET1^DID(801,"","","NAME")
 S FILELST(13)=801.1_U_$$GET1^DID(801.1,"","","NAME")
 S FILELST(0)=13
 D PACKORD(.RANK)
 ;
 ;Get the list to pack.
 D FSEL(.SELLIST,.FILELST)
 ;
 K VALMHDR
 I '$D(SELLIST) S VALMHDR(1)="No reminder items were selected!"  Q
 ;Save the user's selections.
 M USELLIST=SELLIST
 ;Process the selected list to build a complete list of components
 ;to be packed.
 D CMPLIST(.CMPLIST,.SELLIST,.FILELST,.ERROR)
 I ERROR K ^TMP(TMPIND,$J) Q
 ;
 ;Check reminder dialogs for errors
 N FAILTYPE
 S FAIL=0
 I $D(SELLIST(801.41)) D  I FAIL="F" K ^TMP(TMPIND,$J) Q
 .W !,"Checking reminder dialog(s) for errors."
 . S DIEN=0
 .;Check individual reminder dialogs 
 . F  S DIEN=$O(SELLIST(801.41,"IEN",DIEN)) Q:DIEN'>0  D
 .. I FAIL=0 W "."
 .. S FAILTYPE=$$RETARR^PXRMDLRP(DIEN,.OUTPUT) Q:'$D(OUTPUT)
 .. I FAILTYPE="F" S FAIL="F"
 .. I FAILTYPE="W",FAIL=0 S FAIL="W"
 .. W !!,$S(FAILTYPE="W":"**WARNING**",1:"**FATAL ERROR**")
 .. S CNT=0 F  S CNT=$O(OUTPUT(CNT)) Q:CNT'>0  W !,OUTPUT(CNT)
 .. K OUTPUT
 .;
 . I FAIL="W" H 2
 . I FAIL=0 W !,"No problems found." H 1 Q
 . I FAIL="F" W !!,"Cannot create the packed file. Please correct the above fatal error(s)." H 2
 ;
 ;Create the header information.
 D HEADER(TMPIND,.USELLIST,.SELLIST,.RANK,.EFNAME)
 I EFNAME=-1 Q
 ;
 ;Order the component list.
 D ORDER(.CMPLIST,.RANK,.POA)
 ;Pack the list
 D PACK(.CMPLIST,.POA,TMPIND,.SELLIST,.SERROR)
 I SERROR K ^TMP(TMPIND,$J) Q
 ;Add information to the description about quick orders, TIU health 
 ;summary objects, and health summaries that are included but are
 ;not exchangeable.
 D NEXINFO(TMPIND)
 D STOREPR^PXRMEXU2(.SUCCESS,EFNAME,TMPIND,.SELLIST)
 K ^TMP(TMPIND,$J)
 I SUCCESS D
 . S VALMHDR(1)=EFNAME_" was saved in the Exchange File."
 . D BLDLIST^PXRMEXLC(1)
 E  D
 . S VALMHDR(1)="Creation of Exchange File entry "_EFNAME
 . S VALMHDR(2)="failed; it was not saved!"
 Q
 ;
 ;==========================
FSEL(LIST,FILELST) ;Select file list.
 N ALIST,DIR,DIROUT,DIRUT,DONE,DTOUT,DUOUT,IND,X,Y
 F IND=1:1:FILELST(0) S ALIST(IND)=$$RJ^XLFSTR(IND,4," ")_" "_$P(FILELST(IND),U,2)
 M DIR("A")=ALIST
 S DIR("A")="Select a file"
 S DIR(0)="NO^1:"_FILELST(0)
 S DONE=0
 F  Q:DONE  D
 . W !!,"Select from the following reminder files:"
 . D ^DIR
 . I (Y="")!(Y["^") S DONE=1 Q
 . I $D(DIROUT)!$D(DIRUT) S DONE=1 Q
 . I $D(DUOUT)!$D(DTOUT) S DONE=1 Q
 . D IENSEL(.LIST,Y,.FILELST)
 Q
 ;
 ;==========================
IENSEL(LIST,ID,FILELST) ;Select entries from the selected file.
 N DIC,DIR,DIROUT,DIRUT,DONE,DTOUT,DUOUT,FILENUM,NUMF,X,Y
 S (DIC,FILENUM)=$P(FILELST(ID),U,1)
 S NUMF=+$O(LIST(FILENUM,""),-1)
 S DIC(0)="QEA"
 S DONE=0
 F  Q:DONE  D
 . D ^DIC
 . I Y=-1 S DONE=1 Q
 . I $D(DIROUT)!$D(DIRUT) S DONE=1 Q
 . I $D(DUOUT)!$D(DTOUT) S DONE=1 Q
 . S NUMF=NUMF+1
 . S LIST(FILENUM,NUMF)=+Y
 . S LIST(FILENUM,"IEN",+Y)=NUMF
 . W !,"Enter another one or just press enter to go back to file selection."
 Q
 ;
 ;==========================
GETTEXT(FILENUM,IEN,TMPIND,INDEX) ;Let the user input some text.
 N DIC,DWLW,DWPK,FIELDNUM,TYPE
 ;If this is the description text, (signfied by FILENUM>0) load the
 ;description or short description as the default.
 I FILENUM>0 D
 . S FIELDNUM=$$FLDNUM^DILFD(FILENUM,"DESCRIPTION"),TYPE="WP"
 . I FIELDNUM=0 S FIELDNUM=$$FLDNUM^DILFD(FILENUM,"SHORT DESCRIPTION"),TYPE="SD"
 E  S FIELDNUM=0
 I FIELDNUM>0 D
 . N MSG,WP,X
 . I TYPE="WP" D
 .. S X=$$GET1^DIQ(FILENUM,IEN,FIELDNUM,"Z","WP","MSG")
 .. M ^TMP(TMPIND,$J,INDEX,1)=WP
 . I TYPE="SD" D
 .. S X=$$GET1^DIQ(FILENUM,IEN,FIELDNUM,"","","MSG")
 .. S ^TMP(TMPIND,$J,INDEX,1,1,0)=X
 S DIC="^TMP(TMPIND,$J,"""_INDEX_""",1,"
 S DWLW=72,DWPK=1
 D EN^DIWE
 Q
 ;
 ;==========================
GDIQF(FILENUM,FILENAME,IEN,IND,TMPIND,SELLIST,SERROR) ;Save file entries into
 ;^TMP(TMPIND,$J).
 N CSUM,DIQOUT,IENROOT,FIELD,MSG,NUM
 K DIQOUT,IENROOT
 ;If the file entry is ok to install then get the entire entry,
 ;otherwise just get the .01.
 S FIELD=$S($$IOKTP^PXRMEXFI(FILENUM,IEN):"**",1:.01)
 ;
 ;Items from file 142, 142.5, and 8925.1 need to be added to the
 ;SELLIST array if $$IOKTP returns "**". These items are IEN specific
 ;and the check needs to be done at time of packing this is why they
 ;are added to SELLIST.
 I ((FILENUM=142)!(FILENUM=142.5)!(FILENUM=8925.1))&(FIELD="**") D
 .S NUM=$O(SELLIST(FILENUM,"IEN",""),-1)
 .S NUM=NUM+1,SELLIST(FILENUM,"IEN",IEN)=NUM,SELLIST(FILENUM,NUM)=IEN
 ;
 D GETS^DIQ(FILENUM,IEN,FIELD,"N","DIQOUT","MSG")
 I $D(MSG) D  Q
 . S SERROR=1
 . N ETEXT
 . S ETEXT="GETS^DIQ failed for "_FILENAME_", ien="_IEN_";"
 . W !,ETEXT
 . W !,"it returned the following error:"
 . D AWRITE^PXRMUTIL("MSG")
 . H 2
 . K MSG
 D CLDIQOUT(FILENUM,IEN,FIELD,.IENROOT,.DIQOUT)
 S ^TMP("PXRMEXCS",$J,IND,FILENAME)=$$DIQOUTCS^PXRMEXCS(.DIQOUT)
 ;Load the converted DIQOUT into TMP.
 M ^TMP(TMPIND,$J,IND,FILENAME)=DIQOUT
 M ^TMP(TMPIND,$J,IND,FILENAME_"_IENROOT")=IENROOT
 Q
 ;
 ;==========================
GRTN(ROUTINE,TMPIND,SERROR) ;Save routines into ^TMP(TMPIND,$J).
 N DIF,IEN,IND,RA,TEMP,X,XCNP
 S X=ROUTINE
 X ^%ZOSF("TEST")
 I $T D
 . K RA
 . S DIF="RA("
 . S XCNP=0
 . X ^%ZOSF("LOAD")
 . S ^TMP("PXRMEXCS",$J,"ROUTINE",X)=$$ROUTINE^PXRMEXCS(.RA)
 . M ^TMP(TMPIND,$J,"ROUTINE",X)=RA
 E  D
 . S SERROR=1
 . W !,"Warning could not find routine ",X
 . H 2
 Q
 ;
 ;==========================
HEADER(TMPIND,USELLIST,SELLIST,RANK,EFNAME) ;Create the Exchange file header
 ;information.
 N DIR,EXTYPE,IEN,IND,FILENAME,FILENUM,NFNUM,NIEN,PNAME,Y
 S (FILENAME,FILENUM,IEN,NIEN)="",NFNUM=0
 F  S FILENUM=$O(USELLIST(FILENUM)) Q:FILENUM=""  S NFNUM=NFNUM+1
 I NFNUM=1 D
 . S FILENUM=$O(USELLIST(""))
 . S IND="",NIEN=0
 . F  S IND=$O(USELLIST(FILENUM,IND)) Q:IND="IEN"  S NIEN=NIEN+1
 . I NIEN=1 D
 .. S IND=$O(USELLIST(FILENUM,""))
 .. S IEN=USELLIST(FILENUM,IND)
 .. S NAME=$$GET1^DIQ(FILENUM,IEN,.01)
 .. S FILENAME=$$GET1^DID(FILENUM,"","","NAME")
 ..;If only one item was selected make it the default.
 .. S DIR("B")=NAME
 ;Get the Exchange file entry name.
 S DIR(0)="FAU^3:64"
 S DIR("A")="Enter the Exchange File entry name: "
 D ^DIR
 I (Y="")!($D(DTOUT))!($D(DUOUT)) S EFNAME=-1 Q
 S EFNAME=Y
 K DIR
 ;Save the source information.
 D PUTSRC(FILENAME,EFNAME,TMPIND)
 S PNAME=$S(NIEN=1:FILENAME,1:"Exchange File entry")
 ;If multiple items were selected for packing initialize the
 ;description with the selection list.
 I (NFNUM>1)!(NIEN>1) D BLDDESC(.USELLIST,TMPIND)
 ;If a single item was selected the description will be initialized
 ;with the selected item's description. In either case the user can
 ;input additional description text.
 W !,"Enter a description of the ",PNAME," you are packing." H 2
 D GETTEXT(FILENUM,IEN,TMPIND,"DESC")
 ;
 ;Have the user input keywords for indexing the entry.
 W !,"Enter keywords or phrases to help index the entry you are packing."
 W !,"Separate the keywords or phrases on each line with commas." H 2
 D GETTEXT(0,0,TMPIND,"KEYWORD")
 ;
 ;Combine the source and input text into the "TEXT" array.
 D BLDTEXT(TMPIND)
 Q
 ;
 ;==========================
NEXINFO(TMPIND) ;Add information to the description about quick orders,
 ;TIU health summary objects, and health summaries that are included
 ;but are not exchangeable.
 N NL,NLS
 S (NL,NLS)=$P($G(^TMP(TMPIND,$J,"DESC",1,0)),U,4)
 I $D(^TMP($J,"ORDER DIALOG")) D
 . I NL>NLS S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=""
 . S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)="Non-exchangeable order dialog(s):"
 . D NEXINFOA(TMPIND,"ORDER DIALOG",.NL)
 I $D(^TMP($J,"TIU OBJECT")) D
 . I NL>NLS S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=""
 . S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)="Non-exchangeable TIU object(s):"
 . D NEXINFOA(TMPIND,"TIU OBJECT",.NL)
 I $D(^TMP($J,"HS OBJECT")) D
 . I NL>NLS S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=""
 . S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)="Non-exchangeable health summary object(s):"
 . D NEXINFOA(TMPIND,"HS OBJECT",.NL)
 I $D(^TMP($J,"HS TYPE")) D
 . I NL>NLS S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=""
 . S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)="Non-exchangeable health summary type(s):"
 . D NEXINFOA(TMPIND,"HS TYPE",.NL)
 I $D(^TMP($J,"HS COMP")) D
 . I NL>NLS S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=""
 . S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)="Non-exchangeable health summary component(s):"
 . D NEXINFOA(TMPIND,"HS COMP",.NL)
 I $D(^TMP($J,"LOCATION LIST")) D
 . I NL>NLS S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=""
 . S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)="Non-exchangeable location list hospital locations:"
 . D NEXINFOA(TMPIND,"LOCATION LIST",.NL)
 I NL>NLS S $P(^TMP(TMPIND,$J,"DESC",1,0),U,3,4)=NL_U_NL
 Q
 ;
 ;==========================
NEXINFOA(TMPIND,SUB,NL) ;
 N IEN,LNUM
 I SUB'["ORDER" S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=$$REPEAT^XLFSTR("-",79)
 S IEN=0
 F  S IEN=$O(^TMP($J,SUB,IEN)) Q:IEN'>0  D
 .S LNUM=0
 .F  S LNUM=$O(^TMP($J,SUB,IEN,LNUM)) Q:LNUM=""  D
 ..S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=^TMP($J,SUB,IEN,LNUM)
 I SUB'["ORDER" S NL=NL+1,^TMP(TMPIND,$J,"DESC",1,NL,0)=$$REPEAT^XLFSTR("-",79)
 K ^TMP($J,SUB)
 Q
 ;
 ;==========================
ORDER(CMPLIST,RANK,POA) ;Order the component list so pointers can be resolved.
 N FILENUM,ORDER,PORDER
 S FILENUM="",ORDER=0
 F  S FILENUM=$O(CMPLIST(FILENUM)) Q:FILENUM=""  D
 . S PORDER=$G(RANK("FN",FILENUM))
 . I PORDER="" S ORDER=ORDER+1,PORDER=ORDER
 . S POA(PORDER)=FILENUM
 Q
 ;
 ;==========================
PACK(CMPLIST,POA,TMPIND,SELLIST,SERROR) ;Create the packed entry, store it in
 ;^TMP(TMPIND,$J). TMPIND should be namespaced and set by the caller.
 N IEN,IND,JND,KND,FILENAME,FILENUM,ROUTINE
 W !,"Packing components ..."
 S (KND,SERROR)=0
 S IND=""
 F  S IND=$O(POA(IND)) Q:IND=""  D
 . S FILENUM=POA(IND)
 . S FILENAME=$S(FILENUM=0:"ROUTINE",1:$$GET1^DID(FILENUM,"","","NAME"))
 . S JND=""
 . F  S JND=$O(CMPLIST(FILENUM,JND)) Q:JND=""  D
 .. S IEN=CMPLIST(FILENUM,JND)
 .. I FILENUM=0 W !,"Adding routine ",IEN
 .. E  W !,"Adding ",FILENAME," ",$$GET1^DIQ(FILENUM,IEN,.01),", IEN=",IEN
 .. I FILENUM=0 D GRTN(IEN,TMPIND,.SERROR)
 .. I FILENUM>0 S KND=KND+1 D GDIQF(FILENUM,FILENAME,IEN,KND,TMPIND,.SELLIST,.SERROR)
 ;
 S ^TMP(TMPIND,$J,"NUMF")=KND
 W !,"Packing is complete."
 ;If there were any errors saving the data kill the ^TMP array.
 I SERROR K ^TMP(TMPIND,$J)
 Q
 ;
 ;==========================
PACKORD(RANK) ;
 S RANK("FN",801.41)=7000,RANK(7000)=801.41
 S RANK("FN",810.2)=11000,RANK(11000)=810.2
 S RANK("FN",810.4)=8000,RANK(8000)=810.4
 S RANK("FN",810.7)=10000,RANK(10000)=810.7
 S RANK("FN",810.8)=9000,RANK(9000)=810.8
 S RANK("FN",810.9)=4000,RANK(4000)=810.9
 S RANK("FN",811.2)=3000,RANK(3000)=811.2
 S RANK("FN",811.4)=2000,RANK(2000)=811.4
 S RANK("FN",811.5)=5000,RANK(5000)=811.5
 S RANK("FN",811.6)=1000,RANK(1000)=811.6
 S RANK("FN",811.9)=6000,RANK(6000)=811.9
 S RANK("FN",142.1)=100000,RANK(100000)=142.1
 S RANK("FN",142)=100100,RANK(100100)=142
 S RANK("FN",142.5)=100200,RANK(100200)=142.5
 S RANK("FN",8925.1)=100300,RANK(100300)=8925.1
 S RANK("FN",801)=100500,RANK(100500)=801
 S RANK("FN",801.1)=100400,RANK(100400)=801.1
 Q
 ;
 ;==========================
PUTSRC(FILENAME,NAME,TMPIND) ;Save the source information.
 N LOC
 S LOC=$$SITE^VASITE
 I FILENAME'="" S ^TMP(TMPIND,$J,"SRC","FILENAME")=FILENAME
 S ^TMP(TMPIND,$J,"SRC","NAME")=NAME
 S ^TMP(TMPIND,$J,"SRC","USER")=$$GET1^DIQ(200,DUZ,.01)
 S ^TMP(TMPIND,$J,"SRC","SITE")=$P(LOC,U,2)
 S ^TMP(TMPIND,$J,"SRC","DATE")=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 Q
 ;
 ;==========================
TIUCONV(FILENUM,IEN,ARRAY) ;Convert health summary object to external.
 N HSO,IENS,NAME
 S IENS="+"_IEN_","
 ;Allows non-objects to be packed up
 I ARRAY(FILENUM,IENS,.04)'="OBJECT" Q
 ;
 I $G(ARRAY(FILENUM,IENS,9))'["$$TIU^GMTSOBJ" D  Q
 . S ARRAY(FILENUM,IENS,9)="NOT A HS OBJECT"
 S HSO=$P(ARRAY(FILENUM,IENS,9),",",2)
 S HSO=$P(HSO,")")
 ;Handle corrupted health summary object names.
 I +HSO>0 S NAME=$P($G(^GMT(142.5,HSO,0)),U,1)
 E  S NAME="MISSING"
 S ARRAY(FILENUM,IENS,9)="S X=$$TIU^GMTSOBJ(DFN,"_NAME_")"
 S ARRAY(FILENUM,IENS,99)=""
 Q
 ;
