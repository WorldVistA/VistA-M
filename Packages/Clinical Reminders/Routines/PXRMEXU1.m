PXRMEXU1 ; SLC/PKR/PJH - Reminder exchange repository utilities, #1.;10/23/2020
 ;;2.0;CLINICAL REMINDERS;**6,12,16,26,45,42**;Feb 04, 2005;Build 245
 ;=====================================================
DELETE(LIST) ;Delete the repository entries in LIST.
 N DA,DIK,IND,LNUM
 S DIK="^PXD(811.8,"
 F IND=1:1:$L(LIST,",")-1 D
 . S LNUM=$P(LIST,",",IND)
 . S DA=$$RIEN^PXRMEXU1(LNUM)
 . D ^DIK
 Q
 ;
 ;=====================================================
DELHIST(RIEN,IHIEN) ;Delete install history IHIEN in repository entry RIEN.
 N DA,DIK
 S DA=IHIEN,DA(1)=RIEN
 S DIK="^PXD(811.8,"_DA(1)_",130,"
 D ^DIK
 Q
 ;
 ;=====================================================
DESC(RIEN,DESL,DESC,KEYWORD) ;Build the description.
 N JND,LC,NKEYWL
 S LC=1,^PXD(811.8,RIEN,110,LC,0)="Source:      "_DESL("SOURCE")
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)="Date Packed: "_DESL("DATEP")
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)="Package Version: "_DESL("VRSN")
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)=""
 ;Add the user's description.
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)="Description:"
 F JND=1:1:+$P($G(@DESC@(1,0)),U,4) D
 . S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)=@DESC@(1,JND,0)
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)=""
 ;Add the keywords.
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)="Keywords:"
 S NKEYWL=+$P($G(@KEYWORD@(1,0)),U,4)
 F JND=1:1:NKEYWL D
 . S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)=@KEYWORD@(1,JND,0)
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)=""
 S LC=LC+1,^PXD(811.8,RIEN,110,LC,0)="Components:"
 S ^PXD(811.8,RIEN,110,0)=U_811.804_U_LC_U_LC
 Q
 ;
 ;=====================================================
RIEN(LNUM) ;Given the list number return the repository ien.
 N RIEN
 S RIEN=$G(^TMP("PXRMEXLR",$J,"SEL",LNUM))
 Q RIEN
 ;
 ;=====================================================
PATTR(IEN) ;Build the Packing Attribute list.
 N ATTRLIST,DONE,FDA,IENS,INDEXAT,LN,MSG,NATTR,TEXT
 S TEXT=^PXD(811.8,IEN,100,4,0)
 S INDEXAT=$$GETTAGV^PXRMEXU3(TEXT,"<INDEX_AT>",10)
 S (DONE,NATTR)=0
 S LN=10
 F  Q:DONE  D
 . S LN=LN+1
 . I LN=INDEXAT S DONE=1 Q
 . S TEXT=^PXD(811.8,IEN,100,LN,0)
 . I TEXT["</ATTRIBUTE>" S NATTR=NATTR+1,ATTRLIST(NATTR)=$$GETTAGV^PXRMEXU3(TEXT,"<ATTRIBUTE>",11)
 . I TEXT["</PACKING ATTRIBUTES>" S DONE=1 Q
 I NATTR=0 S NATTR=1,ATTRLIST(1)="NONE"
 F LN=1:1:NATTR D
 . S IENS="+"_LN_","_IEN_","
 . S FDA(811.805,IENS,.01)=ATTRLIST(LN)
 D UPDATE^DIE("S","FDA","","MSG")
 I $D(MSG) D
 . K TEXT
 . S TEXT(1)="Storage of the Packing Attributes failed."
 . S TEXT(2)="Examine the following error message for the reason."
 . S TEXT(3)=""
 . S TEXT(4)="The update failed, UPDATE^DIE returned the following error message:"
 . D MES^XPDUTL(.TEXT)
 . D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;=====================================================
SAVHIST ;Save the installation history in the repository.
 N ACTION,DATE,CMPNT,FTYPE,IND,INDEX,ITEM,JND,KND,NEWNAME
 N SUB,TEMP,TOTAL,TYPE,USER
 ;Find the first open spot in the Installation History node.
 S (IND,JND)=0
 F  S IND=+$O(^PXD(811.8,PXRMRIEN,130,IND)) S JND=JND+1 Q:(IND=0)!(IND>JND)
 S IND=JND
 S JND=0
 F SUB="PXRMEXIA","PXRMEXIAD" D
 . S INDEX=0
 . F  S INDEX=$O(^TMP(SUB,$J,INDEX)) Q:+INDEX=0  D
 .. S JND=JND+1
 .. S CMPNT=$O(^TMP(SUB,$J,INDEX,""))
 .. S ITEM=$O(^TMP(SUB,$J,INDEX,CMPNT,""))
 .. S ACTION=$O(^TMP(SUB,$J,INDEX,CMPNT,ITEM,""))
 .. S NEWNAME=$G(^TMP(SUB,$J,INDEX,CMPNT,ITEM,ACTION))
 .. S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,0)=INDEX_U_CMPNT_U_ITEM_U_ACTION_U_NEWNAME
 ..;Set the 0 node.
 .. S ^PXD(811.8,PXRMRIEN,130,IND,1,0)=U_"811.8031A"_U_JND_U_JND
 ..;Check for finding item changes and save them.
 .. S FTYPE=""
 .. I CMPNT["DEFINITION" S FTYPE="DEFF"
 .. I CMPNT["DIALOG" S FTYPE="DIAF"
 .. I CMPNT["TERM" S FTYPE="TRMF"
 .. I (FTYPE'=""),($D(^TMP(SUB,$J,FTYPE))) D
 ... N FI,FINDING,OFINDING
 ... S KND=2
 ... S FI=""
 ... F  S FI=$O(^TMP(SUB,$J,FTYPE,FI)) Q:FI=""  D
 .... S OFINDING=$O(^TMP(SUB,$J,FTYPE,FI,""))
 .... S FINDING=^TMP(SUB,$J,FTYPE,FI,OFINDING)
 .... I OFINDING=FINDING Q
 .... S KND=KND+1
 .... S TEMP=$E(OFINDING,1,33)
 .... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,KND,0)="    "_TEMP_$$INSCHR^PXRMEXLC((35-$L(TEMP))," ")_FINDING
 ... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,0)=U_"811.80315A"_U_KND_U_KND
 ... I KND>2 D
 .... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,1,0)="   Finding Changes"
 .... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,2,0)="     Original"_$$INSCHR^PXRMEXLC(27," ")_"New"
 ..;
 ..;Check for TIU template replacements and save them.
 .. I CMPNT["DIALOG" S FTYPE="DIATIU"
 .. E  S FTYPE=""
 .. I (FTYPE'=""),($D(^TMP(SUB,$J,FTYPE))) D
 ... N OTIUT,TIUT,TYPE
 ... S TYPE=""
 ... S KND=2
 ... F  S TYPE=$O(^TMP(SUB,$J,FTYPE,TYPE)) Q:TYPE=""  D
 .... S OTIUT=""
 .... F  S OTIUT=$O(^TMP(SUB,$J,FTYPE,TYPE,OTIUT)) Q:OTIUT=""  D
 ..... S TIUT=$G(^TMP(SUB,$J,FTYPE,TYPE,OTIUT))
 ..... I OTIUT=TIUT Q
 ..... I '$D(^TMP(SUB,$J,FTYPE,TYPE,OTIUT,ITEM)) Q
 ..... S KND=KND+1
 ..... S TEMP=$E(OTIUT,1,33)
 ..... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,KND,0)="    "_TEMP_$$INSCHR^PXRMEXLC((35-$L(TEMP))," ")_TIUT
 .... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,0)=U_"811.80315A"_U_KND_U_KND
 .... I KND>2 D
 ..... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,1,0)="   "_TYPE
 ..... S ^PXD(811.8,PXRMRIEN,130,IND,1,JND,1,2,0)="     Original"_$$INSCHR^PXRMEXLC(27," ")_"New"
 ;If JND is still 0 then there was nothing to save.
 I JND>0 D
 .;Save the header information.
 . S DATE=$$NOW^XLFDT
 . S TYPE=$G(^TMP("PXRMEXIA",$J,"TYPE"))
 . I TYPE="" S TYPE="INTERACTIVE"
 . S USER=$$GET1^DIQ(200,DUZ,.01,"")
 . S ^PXD(811.8,PXRMRIEN,130,IND,0)=DATE_U_USER_U_TYPE
 . S ^PXD(811.8,PXRMRIEN,130,"B",DATE,IND)=""
 .;Set the 0 node.
 . S (KND,TOTAL)=0
 . F  S KND=+$O(^PXD(811.8,PXRMRIEN,130,KND)) Q:KND=0  S TOTAL=TOTAL+1
 . S ^PXD(811.8,PXRMRIEN,130,0)=U_"811.803DA"_U_IND_U_TOTAL
 K ^TMP("PXRMEXIA",$J)
 K ^TMP("PXRMEXIAD",$J)
 Q
 ;
 ;=====================================================
TIUSRCH(GLOB,IEN,NODE,OLIST,TLIST) ;Extract TIU Objects/Templates
 ;from any WP text.
 N NIN,NOUT,OCNT,SUB,TCNT,TEXT,TEXTIN,TEXTOUT
 ;Add to existing arrays
 S NIN=0
 S OCNT=+$O(OLIST(""),-1),TCNT=+$O(TLIST(""),-1),SUB=0
 ;Scan WP fields
 F  S SUB=$O(@(GLOB_IEN_","_NODE_","_SUB_")")) Q:'SUB  D
 .;Get individual line
 .S TEXT=$G(@(GLOB_IEN_","_NODE_","_SUB_",0)")) Q:TEXT=""
 .S NIN=NIN+1
 .S TEXTIN(NIN)=TEXT
 D FORMAT^PXRMTEXT(0,80,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 F X=1:1:NOUT D
 .S TEXT=TEXTOUT(X)
 .;Most text lines will have no TIU link so ignore them
 .I (TEXT'["|")&(TEXT'["{FLD:") Q
 .;Templates are in format {FLD:fldname} (only applies to dialogs)
 .I GLOB[801.41 D TIUXTR("{FLD:","}",TEXT,.TLIST,.TCNT)
 .;Objects are in format |Objectname|
 .D TIUXTR("|","|",TEXT,.OLIST,.OCNT)
 Q
 ;
 ;=====================================================
TIUXTR(SRCH,SRCH1,TEXT,OUTPUT,CNT) ;
 N EXIST,IC,ONAME,TMP,TXT
 S TXT=TEXT
 F  D  Q:TXT'[SRCH
 .S TXT=$E(TXT,$F(TXT,SRCH),$L(TXT)) Q:TXT'[SRCH1
 .S ONAME=$P(TXT,SRCH1) Q:ONAME=""
 .I SRCH1="}" S TMP=$P(TXT,SRCH1,2) I $E(TMP,1,3)="FMT" Q
 .;
 .;Remove the valid item from the text string. This prevent problems
 .;with multiple objects on one line.
 .;
 .S TXT=$P(TXT,ONAME_SRCH1,2)
 .;Check if already selected
 .S EXIST=0,IC=0
 .F  S IC=$O(OUTPUT(IC)) Q:'IC  Q:EXIST  D
 ..I $G(OUTPUT(IC))=ONAME S EXIST=1
 .;Save array of object/template names
 .I 'EXIST S CNT=CNT+1,OUTPUT(CNT)=ONAME
 Q
 ;
