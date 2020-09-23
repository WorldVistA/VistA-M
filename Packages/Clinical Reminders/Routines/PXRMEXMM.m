PXRMEXMM ; SLC/PKR - Routines to select and deal with MailMan messages ;07/20/2020
 ;;2.0;CLINICAL REMINDERS;**12,26,74**;Feb 04, 2005;Build 5
 ;===============
CHECKOVF(TMPSUB,LINE,LNUM) ;Check for overflow lines.
 N DONE,LN,TEMP
 S DONE=0,LN=LNUM
 F  Q:DONE  D
 . S LN=LN+1
 . S TEMP=$G(^TMP(TMPSUB,$J,LN))
 . I $P(TEMP,U,1)'="OVF" S DONE=1 Q
 . S LINE=LINE_$P(TEMP,U,2)
 . S LNUM=LN
 Q
 ;
 ;===============
CMM(SUCCESS,LIST) ;Create a MailMan message containing the repository
 ;entries in LIST.
 ;Get a new MailMan message number.
 N EXCHIEN,ENTRY,IC,IND,JND,LC,LEN,LINE,LNUM,NENTRIES,NLINES,TEMP
 N TLC,XMSUB
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
 S NENTRIES=$L(LIST,",")-1
 F IND=1:1:NENTRIES D
 . S ENTRY=$P(LIST,",",IND)
 . S EXCHIEN=$$RIEN^PXRMEXU1(ENTRY)
 . S LC=$O(^PXD(811.8,EXCHIEN,100,""),-1)
 . S TLC=TLC+LC
 . F JND=1:1:LC D
 .. S LINE=^PXD(811.8,EXCHIEN,100,JND,0)
 .. S LEN=$L(LINE)
 .. I LEN>250 D OVERFLOW(XMZ,.IC,LEN,LINE) Q
 .. S IC=IC+1,^XMB(3.9,XMZ,2,IC,0)=^PXD(811.8,EXCHIEN,100,JND,0)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_TLC_"^"_TLC_"^"_DT
 ;
 ;Make the message information only.
 S $P(^XMB(3.9,XMZ,0),U,12)="Y"
 ;
 ;Get a list of who to send it to and send it.
 D ENT2^XMD
 Q
 ;
 ;===============
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
 ;===============
GETSUB() ;Prompt the user for a subject.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FAU"_U_"1:59"
 S DIR("A")="Enter a subject: "
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q ""
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q Y
 ;
 ;===============
LMM(SUCCESS,XMZ) ;Load repository entries from a MailMan message.
 N CSUM,DATEP,EXIEN,EXTYPE,FDA,FDAIEN,IENROOT,IND,LINE,LNUM,MSG
 N NENTRY,NLINES,RESULT,RETMP,RNAME,SITE,SOURCE,SSOURCE,TEMP
 N US,USER,VRSN,XMER
 ;Get the message information
 ;DBIA #1144
 S TEMP=$$HDR^XMGAPI2(XMZ,.XMVAR,0)
 I TEMP'=0 D  Q
 . W !,"This MailMan message has a corrupted header."
 . S SUCCESS=0
 . H 2
 ;Load the message
 W !,"Loading MailMan message number ",XMZ
 K ^TMP("PXRMEXMM",$J),^TMP("PXRMEXLMM",$J)
 S RESULT=$$GET1^DIQ(3.9,XMZ_",",3,"","^TMP(""PXRMEXMM"",$J)","MSG")
 I RESULT="" W !,"Could not load the message." Q
 S RETMP="^TMP(""PXRMEXLMM"",$J)"
 S (NENTRY,NLINES,SSOURCE)=0
 S LNUM=$$STARTLINE("PXRMEXMM")
 I LNUM=-1 D  Q
 . W !,"Could not locate the XML header."
 . K ^TMP("PXRMEXMM",$J),^TMP("PXRMEXLMM",$J)
 F  S LNUM=$O(^TMP("PXRMEXMM",$J,LNUM)) Q:LNUM=""  D
 . S LINE=^TMP("PXRMEXMM",$J,LNUM)
 .;Check for overflow lines.
 . D CHECKOVF("PXRMEXMM",.LINE,.LNUM)
 . S NLINES=NLINES+1
 . S ^TMP("PXRMEXLMM",$J,NLINES,0)=LINE
 . I LINE["<PACKAGE_VERSION>" S VRSN=$$GETTAGV^PXRMEXU3(LINE,"<PACKAGE_VERSION>")
 . I LINE["<EXCHANGE_TYPE>" S EXTYPE=$$GETTAGV^PXRMEXU3(LINE,"<EXCHANGE_TYPE>",1)
 . I LINE="<SOURCE>" S SSOURCE=1
 . I SSOURCE D
 .. I LINE["<NAME>" S RNAME=$$GETTAGV^PXRMEXU3(LINE,"<NAME>",1)
 .. I LINE["<USER>" S USER=$$GETTAGV^PXRMEXU3(LINE,"<USER>",1)
 .. I LINE["<SITE>" S SITE=$$GETTAGV^PXRMEXU3(LINE,"<SITE>",1)
 .. I LINE["<DATE_PACKED>" S DATEP=$$GETTAGV^PXRMEXU3(LINE,"<DATE_PACKED>")
 . I LINE="</SOURCE>" D
 .. S SSOURCE=0
 .. S SOURCE=USER_" at "_SITE
 .;See if the entry is loaded into the temporary storage.
 . I LINE="</REMINDER_EXCHANGE_FILE_ENTRY>" D
 .. S NLINES=0
 .. S NENTRY=NENTRY+1
 ..;Make sure it has the correct format.
 .. I (^TMP("PXRMEXLMM",$J,1,0)'["xml")!(^TMP("PXRMEXLMM",$J,2,0)'="<REMINDER_EXCHANGE_FILE_ENTRY>") D  Q
 ... W !,"There is a problem reading this MailMan message for entry ",NENTRY,", try it again."
 ... W !,"If it fails twice it is not in the proper reminder exchange format."
 ... S SUCCESS(NENTRY)=0
 ... H 2
 ..;Make sure this entry does not already exist.
 .. S EXIEN=$$REXISTS^PXRMEXIU(RNAME,DATEP) D
 .. I EXIEN>0 D
 ... W !,RNAME
 ... W !,"with a date packed of ",DATEP
 ... W !,"is already in the Exchange File, it will not be added again."
 ... ;S SUCCESS(NENTRY)=0
 ... S SUCCESS(NENTRY)=EXIEN_"A"
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
 ... W !,"Added Reminder Exchange entry ",RNAME H 2
 .. K ^TMP("PXRMEXLMM",$J)
 ;Check the success of the entry installs.
 K ^TMP("PXRMEXMM",$J),^TMP("PXRMEXLMM",$J)
 S SUCCESS=1
 S IND=""
 F  S IND=$O(SUCCESS(IND)) Q:+IND=0  D
 . I 'SUCCESS(IND) S SUCCESS=0 Q
 Q
 ;
 ;===============
OVERFLOW(XMZ,IC,LEN,LINE) ;MailMan does not allow lines longer than 255;
 ;to be safe, for lines longer than 250 break it into overflow segments.
 N CHUNK,END,N250,START
 S IC=IC+1,^XMB(3.9,XMZ,2,IC,0)=$E(LINE,1,250)
 S N250=((LEN-250)\246)+1
 S START=251,END=250+246
 F CHUNK=1:1:N250 D
 . S IC=IC+1,^XMB(3.9,XMZ,2,IC,0)="OVF^"_$E(LINE,START,END)
 . S START=START+246,END=END+246
 Q
 ;
 ;===============
STARTLINE(TMPSUB) ;Find the starting line by looking for the XML header.
 ;This will skip over extra header information created by things like
 ;copying, forwarding, or using p-message. Return the line previous
 ;to the header line so the first $O will be the header line.
 N DONE,LNUM,STARTLINE
 S DONE=0,LNUM=""
 F  S LNUM=$O(^TMP(TMPSUB,$J,LNUM)) Q:(DONE)!(LNUM="")  D
 . I ^TMP(TMPSUB,$J,LNUM)="<?xml version=""1.0"" standalone=""yes""?>" S DONE=1,STARTLINE=LNUM
 S STARTLINE=$S(LNUM="":-1,1:$O(^TMP(TMPSUB,$J,STARTLINE),-1))
 Q STARTLINE
 ;
