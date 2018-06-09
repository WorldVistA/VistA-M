PXRMEXCC ; SLC/PKR - Exchange component check. ;04/24/2018
 ;;2.0;CLINICAL REMINDERS;**47,42**;Feb 04, 2005;Build 80
 ;Used to find corrupted components, the indicator is when the Index
 ;is not at the proper line in the Exchange file.
 ;======================================================
COMPCHK(IEN) ;Check the components for the Exchange entry.
 N BADIND,CSTART,END,FILENAME,FILENUM,IND,INDEXAT,JND,LINE
 N LNUM,NCMPNT,START,SUB,TAG,TEXT,TYPE
 ;Find the Index
 S (IND,INDEXAT)=0
 F  S IND=$O(^PXD(811.8,IEN,100,IND)) Q:(INDEXAT>0)!(IND="")  D
 . S LINE=^PXD(811.8,IEN,100,IND,0)
 . I LINE="<INDEX>" S INDEXAT=IND
 S JND=INDEXAT+1
 S LINE=^PXD(811.8,IEN,100,JND,0)
 S NCMPNT=+$$GETTAGV^PXRMEXU3(LINE,"<NUMBER_OF_COMPONENTS>")
 ;Build the list of components.
 K ^TMP($J,"CMPNT")
 F IND=1:1:NCMPNT D
 . K END,START
 . F  S JND=JND+1,LINE=$G(^PXD(811.8,IEN,100,JND,0)) Q:(LINE="</COMPONENT>")!(LINE="")  D
 .. S TAG=$$GETTAG^PXRMEXU3(LINE)
 .. I TAG["START" S START(TAG)=+$$GETTAGV^PXRMEXU3(LINE,TAG)
 .. I TAG["END" S END(TAG)=+$$GETTAGV^PXRMEXU3(LINE,TAG)
 . I $D(START("<M_ROUTINE_START>")) D
 .. S CSTART=START("<M_ROUTINE_START>")
 .. S ^TMP($J,"CMPNT",IND,"TYPE")="ROUTINE"
 .. S LINE=^PXD(811.8,IEN,100,CSTART+1,0)
 .. S ^TMP($J,"CMPNT",IND,"NAME")=$$GETTAGV^PXRMEXU3(LINE,"<ROUTINE_NAME>")
 .. S ^TMP($J,"CMPNT",IND,"FILENUM")=0
 ..;Save the actual start and end of the code.
 .. S ^TMP($J,"CMPNT",IND,"START")=START("<ROUTINE_CODE_START>")
 .. S ^TMP($J,"CMPNT",IND,"END")=END("<ROUTINE_CODE_END>")
 . I $D(START("<FILE_START>")) D
 .. S CSTART=START("<FILE_START>")
 .. S LINE=^PXD(811.8,IEN,100,CSTART+1,0)
 .. S (^TMP($J,"CMPNT",IND,"TYPE"),^TMP($J,"CMPNT",IND,"FILENAME"))=$$GETTAGV^PXRMEXU3(LINE,"<FILE_NAME>",1)
 .. S LINE=^PXD(811.8,IEN,100,CSTART+2,0)
 .. S ^TMP($J,"CMPNT",IND,"FILENUM")=$$GETTAGV^PXRMEXU3(LINE,"<FILE_NUMBER>")
 .. S LINE=^PXD(811.8,IEN,100,CSTART+3,0)
 .. S (^TMP($J,"CMPNT",IND,"NAME"),^TMP($J,"CMPNT",IND,"POINT_01"))=$$GETTAGV^PXRMEXU3(LINE,"<POINT_01>",1)
 .. S LINE=^PXD(811.8,IEN,100,CSTART+6,0)
 .. S ^TMP($J,"CMPNT",IND,"SELECTED")=$$GETTAGV^PXRMEXU3(LINE,"<SELECTED>")
 ..;Save the actual start and end of the FileMan FDA.
 .. S ^TMP($J,"CMPNT",IND,"FDA_START")=START("<FDA_START>")
 .. S ^TMP($J,"CMPNT",IND,"FDA_END")=END("<FDA_END>")
 .. S ^TMP($J,"CMPNT",IND,"IEN_ROOT_START")=$G(START("<IEN_ROOT_START>"))
 .. S ^TMP($J,"CMPNT",IND,"IEN_ROOT_END")=$G(END("<IEN_ROOT_END>"))
 ;Look for missing TYPE, this is an indicator of an issue.
 S TEXT(1)="Component check for Exchange Entry IEN="_IEN_"."
 S BADIND=0,IND=1
 I $G(^TMP($J,"CMPNT",1,"TYPE"))="" S BADIND=1
 F  S IND=$O(^TMP($J,"CMPNT",IND)) Q:(BADIND)!(IND="")  D
 . S TYPE=$G(^TMP($J,"CMPNT",IND,"TYPE"))
 . I TYPE="" S BADIND=IND
 I BADIND=0 S TEXT(2)="Cannot determine the problem."
 I BADIND>0 D
 . S TEXT(2)="There appears to be a problem in this component area."
 . S LNUM=2
 . F IND=(BADIND-1):1:(BADIND+1) D
 .. S LNUM=LNUM+1,TEXT(LNUM)=""
 .. S LNUM=LNUM+1,TEXT(LNUM)="Component number "_IND
 .. S SUB=""
 .. F  S SUB=$O(^TMP($J,"CMPNT",IND,SUB)) Q:SUB=""  D
 ... S LNUM=LNUM+1,TEXT(LNUM)=" "_SUB_"="_^TMP($J,"CMPNT",IND,SUB)
 .. S LNUM=LNUM+1,TEXT(LNUM)=""
 .. S LNUM=LNUM+1,TEXT(LNUM)="The component details are:"
 .. S START=^TMP($J,"CMPNT",IND,"FDA_START")-2
 .. S END=^TMP($J,"CMPNT",IND,"FDA_END")+2
 .. F JND=START:1:END S LNUM=LNUM+1,TEXT(LNUM)=^PXD(811.8,IEN,100,JND,0)
 S LNUM=LNUM+1,TEXT(LNUM)=""
 S LNUM=LNUM+1,TEXT(LNUM)="If you need assistance with this, call the National Help Desk and have them"
 S LNUM=LNUM+1,TEXT(LNUM)="enter a ticket."
 D BROWSE^DDBR("TEXT","N","Corrupted Component Information")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 K ^TMP($J,"CMPNT")
 Q
