PXRMEXSI ; SLC/PKR/PJH - Silent Exchange entry install. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**6,12,17**;Feb 04, 2005;Build 102
 ;
 ;=======================================
DELEXE(ENTRY,ROUTINE) ;If the Exchange File entry already exists delete it.
 N EXARRAY,IC,IND,LIST,LUVALUE,NUM
 D LDARRAY^PXRMEXSI("L",ENTRY,ROUTINE,.EXARRAY)
 S IC=0
 F  S IC=$O(EXARRAY(IC)) Q:'IC  D
 . S LUVALUE(1)=EXARRAY(IC,1)
 . D FIND^DIC(811.8,"","","U",.LUVALUE,"","","","","LIST")
 . I '$D(LIST) Q
 . S NUM=$P(LIST("DILIST",0),U,1)
 . I NUM'=0 D
 .. F IND=1:1:NUM D
 ... N DA,DIK
 ... S DIK="^PXD(811.8,"
 ... S DA=LIST("DILIST",2,IND)
 ... D ^DIK
 Q
 ;
 ;=======================================
EXFINC(Y,ENTRY,ROUTINE) ;Return a 1 if the Exchange file entry is in the list
 ;to include in the build. This is used in the build to determine which
 ;entries to include.
 N EXARRAY,FOUND,IEN,IC,LUVALUE
 D LDARRAY^PXRMEXSI("I",ENTRY,ROUTINE,.EXARRAY)
 S FOUND=0
 S IC=0
 F  S IC=+$O(EXARRAY(IC)) Q:(IC=0)!(FOUND)  D
 . M LUVALUE=EXARRAY(IC)
 . S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 . I IEN=Y S FOUND=1 Q
 Q FOUND
 ;
 ;=======================================
INSCOM(PXRMRIEN,ACTION,IND,TEMP,REMNAME,HISTSUB) ;Install component IND
 ;of PXRMRIEN.
 N ATTR,CSUM,END,EXISTS,FILENUM,IND120,JND120,NAME
 N PT01,RTN,SAME,START,TEXT
 S FILENUM=$P(TEMP,U,1),EXISTS=$P(TEMP,U,4)
 S IND120=$P(TEMP,U,2),JND120=$P(TEMP,U,3)
 I (IND120="")!(JND120="") Q
 S TEMP=^PXD(811.8,PXRMRIEN,120,IND120,1,JND120,0)
 ;If the component does not exist then the action has to be "I".
 ;If the component exists and the action is "I" change it to "O".
 ;If the component exists and the action is "M" leave it "M".
 ;If the component exists and the action is "O" leave it "O".
 S ACTION=$S('EXISTS:"I",ACTION="I":"O",1:ACTION)
 S SAME=0
 S START=$P(TEMP,U,2)
 S END=$P(TEMP,U,3)
 I FILENUM=0 D
 . D RTNLD^PXRMEXIC(PXRMRIEN,START,END,.ATTR,.RTN)
 . I EXISTS D
 .. D CHECKSUM^PXRMEXCS(.ATTR,START,END)
 .. S CSUM=$$RTNCS^PXRMEXCS(ATTR("NAME"))
 .. I ATTR("CHECKSUM")=CSUM S SAME=1,ACTION="S"
 . S ^TMP("PXRMEXIA",$J,IND,"ROUTINE",ATTR("NAME"),ACTION)=""
 E  D 
 . S TEMP=^PXD(811.8,PXRMRIEN,100,START,0)
 . S PT01=$P(TEMP,"~",2)
 .;Save reminder name for dialog install.
 . I FILENUM=811.9 S REMNAME=PT01
 . D SETATTR^PXRMEXFI(.ATTR,FILENUM,PT01)
 . I EXISTS D
 .. D CHECKSUM^PXRMEXCS(.ATTR,START,END)
 .. S CSUM=$$FILE^PXRMEXCS(ATTR("FILE NUMBER"),EXISTS)
 .. I ATTR("CHECKSUM")=CSUM S SAME=1,ACTION="S"
 .;Save what was done for the installation summary.
 . S ^TMP(HISTSUB,$J,IND,ATTR("FILE NAME"),PT01,ACTION)=""
 ;If the packed component and the installed component are the same
 ;there is nothing to do.
 I SAME Q
 ;Install this component.
 I FILENUM=0 D RTNSAVE^PXRMEXIC(.RTN,ATTR("NAME"))
 E  D FILE^PXRMEXIC(PXRMRIEN,EXISTS,IND120,JND120,ACTION,.ATTR,.PXRMNMCH)
 Q
 ;
 ;=======================================
INSDLG(PXRMRIEN,IND120,JND120,ACTION) ;Install dialog components directly
 ;from the "SEL" array.
 N IND,FILENUM,ITEMP,NAME,REMNAME,TEMP
 ;Build the selection array in ^TMP("PXRMEXLD",$J,"SEL"). For dialogs
 ;the selection array is: 
 ;file no.^FDA start^FDA end^EXISTS^IND120^JND120^NAME
 S FILENUM=801.41
 D DBUILD^PXRMEXLB(PXRMRIEN,IND120,JND120)
 D BLDDISP^PXRMEXDB(0)
 ;Work through the selection array installing the dialog parts
 ;in reverse order.
 S IND=""
 F  S IND=$O(^TMP("PXRMEXLD",$J,"SEL",IND),-1) Q:(IND="")!(PXRMDONE)  D
 . S TEMP=^TMP("PXRMEXLD",$J,"SEL",IND)
 . S FILENUM=$P(TEMP,U,1),NAME=$P(TEMP,U,7)
 .;Dialog elements may be used more than once in a dialog so make sure
 .;the element has not already been installed.
 . S ITEMP=$P(TEMP,U,1)_U_$P(TEMP,U,4,5)_U_$$EXISTS^PXRMEXIU(FILENUM,NAME)
 . D INSCOM(PXRMRIEN,ACTION,IND,ITEMP,.REMNAME,"PXRMEXIAD")
 Q
 ;
 ;=======================================
INSTALL(PXRMRIEN,ACTION,NOR) ;Install all components in a repository entry.
 ;If NOR is true do not install routines.
 N CLOK,DNAME,FILENUM,IND,PXRMDONE,PXRMNMCH,REMNAME,TEMP
 S PXRMDONE=0
 S NOR=$G(NOR)
 ;Initialize ^TMP globals.
 D INITMPG^PXRMEXLM
 ;Build the component list.
 K ^PXD(811.8,PXRMRIEN,100,"B")
 K ^PXD(811.8,PXRMRIEN,120)
 D CLIST^PXRMEXCO(PXRMRIEN,.CLOK)
 I 'CLOK Q
 ;Build the selectable list.
 D CDISP^PXRMEXLC(PXRMRIEN)
 ;Set the install type.
 S ^TMP("PXRMEXIA",$J,"TYPE")="SILENT"
 ;Initialize the name change storage.
 K PXRMNMCH
 S IND=0
 F  S IND=$O(^TMP("PXRMEXLC",$J,"SEL",IND)) Q:(IND="")!(PXRMDONE)  D
 . S TEMP=^TMP("PXRMEXLC",$J,"SEL",IND)
 . S FILENUM=$P(TEMP,U,1)
 .;If NOR is true do not install routines.
 . I FILENUM=0,NOR Q
 . ;Install dialog components
 . I FILENUM=801.41 D  Q
 .. N IND120,JND120,PXRMDONE
 .. S IND120=$P(TEMP,U,2),JND120=$P(TEMP,U,3),PXRMDONE=0
 .. D INSDLG(PXRMRIEN,IND120,JND120,ACTION)
 . ;Install component
 . E  D INSCOM(PXRMRIEN,ACTION,IND,TEMP,.REMNAME,"PXRMEXIA")
 ;
 ;Get the dialog name
 S DNAME=$G(^TMP("PXRMEXTMP",$J,"PXRMDNAME"))
 ;Link the dialog if it exists
 I DNAME'="" D
 . N DIEN,RIEN
 .;Get the dialog ien
 . S DIEN=$$EXISTS^PXRMEXIU(801.41,DNAME) Q:'DIEN
 .;Get the reminder ien
 . S RIEN=+$$EXISTS^PXRMEXIU(811.9,$G(REMNAME)) Q:'RIEN
 . I RIEN>0 D
 .. N DA,DIE,DIK,DR
 ..;Set reminder to dialog pointer
 .. S DR="51///^S X=DNAME",DIE="^PXD(811.9,",DA=RIEN
 .. D ^DIE
 ;
 ;Save the install history.
 D SAVHIST^PXRMEXU1
 ;If any components were skipped send the message.
 I $D(^TMP("PXRMEXNI",$J)) D
 . N NE,XMSUB
 . S NE=$O(^TMP("PXRMEXNI",$J,""),-1)+1
 . S ^TMP("PXRMEXNI",$J,NE,0)="Please review and make changes as necessary."
 . K ^TMP("PXRMXMZ",$J)
 . M ^TMP("PXRMXMZ",$J)=^TMP("PXRMEXNI",$J)
 . S XMSUB="COMPONENTS SKIPPED DURING SILENT MODE INSTALL"
 . D SEND^PXRMMSG("PXRMXMZ",XMSUB)
 ;Cleanup TMP globals.
 D INITMPG^PXRMEXLM
 Q
 ;
 ;=======================================
LDARRAY(MODE,ENTRY,ROUTINE,ARRAY) ;Load ARRAY with 
 ;MODE is a string that may contain any of the following:
 ; A = include action, stored in the third column of the ARRAY entry.
 ; I = include in build, used for the data screen in the KIDS build.
 ; If MODE contains I then the date and time are stored in the second
 ; column of the ARRAY entry.
 ; L = load action, store the name in the first column of the ARRAY
 ; entry. This is the default and both A and I imply L.
 ;ENTRY is the entry point in ROUTINE which is called to populate
 ;ARRAY.
 N RTN
 S RTN=ENTRY_"^"_ROUTINE_"(MODE,.ARRAY)"
 D @RTN
 Q
 ;
 ;=======================================
SMEXINS(ENTRY,ROUTINE) ;Silent mode install.
 N ACTION,EXARRAY,FMTSTR,IC,IEN,LUVALUE,NOUT,NTI,PXRMINST,TEXT,TEXTOUT
 S PXRMINST=1
 D LDARRAY^PXRMEXSI("IA",ENTRY,ROUTINE,.EXARRAY)
 S NTI=$O(EXARRAY(""),-1),NTI=$L(NTI)+1
 S FMTSTR=NTI_"R1^"_(77-NTI)_"L"
 S IC=0
 F  S IC=$O(EXARRAY(IC)) Q:'IC  D
 . S LUVALUE(1)=EXARRAY(IC,1),LUVALUE(2)=EXARRAY(IC,2)
 . S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 . I IEN=0 Q
 . S TEXT=IC_".^Installing Reminder Exchange entry "_LUVALUE(1)
 . K TEXTOUT
 . D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NOUT,.TEXTOUT)
 . D MES^XPDUTL(.TEXTOUT)
 . S ACTION=EXARRAY(IC,3)
 . D INSTALL^PXRMEXSI(IEN,ACTION,1)
 Q
 ;
