PXRMEXMM ; SLC/PKR - Routines to select and deal with MailMan messages ;01/18/2008
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;=============================================================
CMM(SUCCESS,LIST) ;Create a MailMan message containing the repository
 ;entries in LIST.
 ;Get a new MailMan message number.
 N IC,IND,LC,LIEN,RIEN,TEMP,TLC,XMSUB
 S TEMP=$$GETSUB
 I (TEMP["^")!(TEMP="") Q
 S XMSUB="CREX: "_TEMP
 S TEMP=$$SUBCHK^XMGAPI0(XMSUB,0)
 I $P(TEMP,U,1)'="" S XMSUB=$E(XMSUB,1,65)
RETRY ;
 D XMZ^XMA2
 I XMZ<1 G RETRY
 S SUCCESS("XMZ")=XMZ
 S SUCCESS("SUB")=XMSUB
 ;
 S (IC,TLC)=0
 S LIEN=""
 F  S LIEN=$O(LIST(LIEN)) Q:+LIEN=0  D
 . S RIEN=$$RIEN^PXRMEXU1(LIEN)
 . S LC=$O(^PXD(811.8,RIEN,100,""),-1)
 . S TLC=TLC+LC
 . F IND=1:1:LC D
 .. S IC=IC+1
 .. S ^XMB(3.9,XMZ,2,IC,0)=^PXD(811.8,RIEN,100,IND,0)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_TLC_"^"_TLC_"^"_DT
 ;
 ;Make the message information only.
 S $P(^XMB(3.9,XMZ,0),U,12)="Y"
 ;
 ;Get a list of who to send it to and send it.
 D ENT2^XMD
 Q
 ;
 ;=============================================================
GETMESSN() ;Get the message number.
 N BSKT,DIC,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,ZN
 S DIC("A")="Select a MailMan message: "
 S DIC=3.9
 S DIC(0)="EQV"
 ;Look for messages that start with "C" for either CREX or Copy of.
 S X="CREX:"
 ;DBIA #2736 for XMXUTIL2
 S DIC("S")="S BSKT=$$BSKT^XMXUTIL2(DUZ,+Y) I BSKT>0,BSKT'=.5"
 S DIC("W")="S ZN=$$ZNODE^XMXUTIL2(+Y) W !,""         "",$$FROM^XMXUTIL2(ZN),"" "",$$DATE^XMXUTIL2(ZN),!"
 W !
 D ^DIC K DIC
 I X=(U_U) S DTOUT=1
 I $D(DIROUT)!$D(DIRUT) Q ""
 I $D(DTOUT)!$D(DUOUT) Q ""
 I +Y'=-1 Q $P(Y,U,1)
 ;
 S DIC("A")="Select a MailMan message: "
 S DIC=3.9
 S DIC(0)="EQV"
 S X="Copy of: CREX:"
 ;DBIA #2736 for XMXUTIL2
 S DIC("S")="S BSKT=$$BSKT^XMXUTIL2(DUZ,+Y) I BSKT>0,BSKT'=.5"
 S DIC("W")="S ZN=$$ZNODE^XMXUTIL2(+Y) W !,""         "",$$FROM^XMXUTIL2(ZN),"" "",$$DATE^XMXUTIL2(ZN),!"
 W !
 D ^DIC K DIC
 I X=(U_U) S DTOUT=1
 I $D(DIROUT)!$D(DIRUT) Q ""
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q $P(Y,U,1)
 ;
 ;=============================================================
GETSUB() ;Prompt the user for a subject.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FAU"_U_"1:59"
 S DIR("A")="Enter a subject: "
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q ""
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q Y
 ;
 ;=============================================================
LMM(SUCCESS,XMZ) ;Load repository entries from a MailMan message.
 N CSUM,DATEP,EXTYPE,FDA,FDAIEN,IENROOT,IND,LINE,MSG,NENTRY,NLINES,RETMP
 N RNAME,SITE,SOURCE,SSOURCE,TEMP,US,USER,VRSN,XMER,XMPOS,XMRG,XMVAR
 ;Get the message information
 ;DBIA #1144
 S TEMP=$$HDR^XMGAPI2(XMZ,.XMVAR,0)
 I TEMP'=0 D  Q
 . W !,"This MailMan message has a corrupted header."
 . S SUCCESS=0
 . H 2
 ;Load the message
 W !,"Loading MailMan message number ",XMZ
 K ^TMP("PXRMEXLMM",$J)
 S RETMP="^TMP(""PXRMEXLMM"",$J)"
 S (NENTRY,NLINES,SSOURCE)=0
 S XMPOS=$$STARTPOS(XMZ)
 F  D REC^XMS3 Q:+$G(XMER)=-1  D
 . S NLINES=NLINES+1
 . S ^TMP("PXRMEXLMM",$J,NLINES,0)=XMRG
 . I XMRG["<PACKAGE_VERSION>" S VRSN=$$GETTAGV^PXRMEXU3(XMRG,"<PACKAGE_VERSION>")
 . I XMRG["<EXCHANGE_TYPE>" S EXTYPE=$$GETTAGV^PXRMEXU3(XMRG,"<EXCHANGE_TYPE>",1)
 . I XMRG="<SOURCE>" S SSOURCE=1
 . I SSOURCE D
 .. I XMRG["<NAME>" S RNAME=$$GETTAGV^PXRMEXU3(XMRG,"<NAME>",1)
 .. I XMRG["<USER>" S USER=$$GETTAGV^PXRMEXU3(XMRG,"<USER>",1)
 .. I XMRG["<SITE>" S SITE=$$GETTAGV^PXRMEXU3(XMRG,"<SITE>",1)
 .. I XMRG["<DATE_PACKED>" S DATEP=$$GETTAGV^PXRMEXU3(XMRG,"<DATE_PACKED>")
 . I XMRG="</SOURCE>" D
 .. S SSOURCE=0
 .. S SOURCE=USER_" at "_SITE
 .;See if the entry is loaded into the temporary storage.
 . I XMRG="</REMINDER_EXCHANGE_FILE_ENTRY>" D
 .. S NLINES=0
 .. S NENTRY=NENTRY+1
 ..;Make sure it has the correct format.
 .. I (^TMP("PXRMEXLMM",$J,1,0)'["xml")!(^TMP("PXRMEXLMM",$J,2,0)'="<REMINDER_EXCHANGE_FILE_ENTRY>") D  Q
 ... W !,"There is a problem reading this MailMan message for entry ",NENTRY,", try it again."
 ... W !,"If it fails twice it is not in the proper reminder exchange format."
 ... S SUCCESS=0
 ... H 2
 ... S XMER=-1
 ..;Make sure this entry does not already exist.
 .. I $$REXISTS^PXRMEXIU(RNAME,DATEP) D
 ... W !,RNAME," with a date packed of ",DATEP
 ... W !,"is already in the Exchange File, it will not be added again."
 ... S SUCCESS(NENTRY)=0
 ... H 2
 .. E  D
 ... K FDA,IENROOT
 ... S FDA(811.8,"+1,",.01)=RNAME
 ... S FDA(811.8,"+1,",.02)=SOURCE
 ... S FDA(811.8,"+1,",.03)=DATEP
 ... D UPDATE^PXRMEXPU(.US,.FDA,.IENROOT)
 ... S SUCCESS(NENTRY)=US
 ...;Create the description and save the data.
 ... N DESL,DESCT,KEYWORDT
 ... D DESC^PXRMEXU3(RETMP,.DESCT)
 ... D KEYWORD^PXRMEXU3(RETMP,.KEYWORDT)
 ... S DESL("RNAME")=RNAME,DESL("SOURCE")=SOURCE,DESL("DATEP")=DATEP
 ... S DESL("VRSN")=VRSN
 ... D DESC^PXRMEXU1(IENROOT(1),.DESL,"DESCT","KEYWORDT")
 ... M ^PXD(811.8,IENROOT(1),100)=^TMP("PXRMEXLMM",$J)
 ... W !,"Added Exchange entry ",RNAME H 2
 .. K ^TMP("PXRMEXLMM",$J)
 ;Check the success of the entry installs.
 S SUCCESS=1
 S IND=""
 F  S IND=$O(SUCCESS(IND)) Q:+IND=0  D
 . I 'SUCCESS(IND) S SUCCESS=0 Q
 Q
 ;
 ;=============================================================
STARTPOS(XMZ) ;Find the starting position by looking for the xml header.
 ;This will skip over extra header information created by things like
 ;copying or using p-message.
 N XMPOS,XMER,XMRG
 S XMPOS=.99
 F  D REC^XMS3 Q:(XMRG="<?xml version=""1.0"" standalone=""yes""?>")!(+$G(XMER)=-1)
 S XMPOS=$S($G(XMER)=-1:-1,1:XMPOS-1)
 Q XMPOS
 ;
