PXRMEXU3 ; SLC/PKR - Reminder exchange XML utilities, #3. ;12/22/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;===========================================
DESC(XMLSRC,DESC) ;Find the description in the XML source and load it
 ;into DESC.
 N DFOUND,DONE,IND,JND,SAVE,TAG,XMLLINE
 S (DFOUND,DONE,JND,SAVE)=0
 F IND=1:1  Q:DONE  D
 . S XMLLINE=@XMLSRC@(IND,0)
 . I 'DFOUND S TAG=$$GETTAG(XMLLINE)
 . I TAG="<DESCRIPTION>" S DFOUND=1,TAG=""
 . I DFOUND,'SAVE,XMLLINE["<![CDATA[" S SAVE=1 Q
 . I SAVE,XMLLINE["]]>" S SAVE=0
 . I 'SAVE,XMLLINE["</DESCRIPTION>" S DONE=1 Q
 . I SAVE S JND=JND+1,DESC(1,JND,0)=XMLLINE
 S DESC(1,0)=U_U_U_JND
 Q
 ;
 ;===========================================
FROMXML(TEXT) ;If text contains any of the XML predefined entity references
 ;convert them to the standard characters.
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"&amp;","&")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"&lt;","<")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"&gt;",">")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"&quot;","""")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"&apos;","'")
 Q TEXT
 ;
 ;===========================================
GETTAG(XMLLINE) ;Return the XML tag.
 N END,START,VALUE
 S START=$F(XMLLINE,"<",1)-1
 S END=$F(XMLLINE,">",START)-1
 S VALUE=$E(XMLLINE,START,END)
 Q VALUE
 ;
 ;===========================================
GETTAGV(XMLLINE,TAG,FROMXML) ;Return the value associated with the XML tag.
 N END,ENDTAG,START,TAGL,VALUE
 S TAGL=$L(TAG)
 S ENDTAG="</"_$E(TAG,2,TAGL)
 S START=$F(XMLLINE,TAG,1)
 S END=$F(XMLLINE,ENDTAG,START)-(TAGL+2)
 S VALUE=$E(XMLLINE,START,END)
 I $G(FROMXML) S VALUE=$$FROMXML(VALUE)
 Q VALUE
 ;
 ;===========================================
GETATTR(XMLLINE,ATTR) ;Return the value of attribute ATTR from the XML line
 ;XMLLINE
 N END,START,VALUE
 S ATTR=ATTR_"="""
 S START=$F(XMLLINE,ATTR,1)
 S END=$F(XMLLINE,"""",START)-2
 S VALUE=$E(XMLLINE,START,END)
 Q VALUE
 ;
 ;===========================================
KEYWORD(XMLSRC,KEYWORD) ;Find the keywords in the XML source and load it
 ;into KEYWORD.
 N DONE,IND,JND,TAG,XMLLINE
 S (DONE,JND)=0
 F IND=1:1  Q:DONE  D
 . S XMLLINE=@XMLSRC@(IND,0)
 . S TAG=$$GETTAG(XMLLINE)
 . I TAG="<KEYWORD>" D  Q
 .. S JND=JND+1
 .. S KEYWORD(1,JND,0)=$$GETTAGV(XMLLINE,TAG,1)
 . I TAG="</KEYWORDS>" S DONE=1 Q
 S KEYWORD(1,0)=U_U_U_JND
 Q
 ;
 ;===========================================
TOXML(TEXT) ;If text contains any of the XML markup characters convert
 ;them to the predefined entity reference.
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"&","&amp;")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"<","&lt;")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,">","&gt;")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"""","&quot;")
 S TEXT=$$STRREP^PXRMUTIL(TEXT,"'","&apos;")
 Q TEXT
 ;
