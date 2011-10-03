RORTSK11 ;HCIOFO/SG - REPORT CREATION UTILITIES ; 11/14/06 1:16pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** ADDS THE ATTRIBUTE TO THE ELEMENT
 ;
 ; TASK          Task number
 ;
 ; ELMTIEN       IEN of the element
 ;
 ; NAME          Attribute name
 ;
 ; VALUE         Value of the attribute
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Invalid attribute name
 ;       >0  Attribute IEN
 ;
ADDATTR(TASK,ELMTIEN,NAME,VALUE) ;
 I $G(ELMTIEN)<0  Q:$QUIT 0  Q
 N IENS,RC,RORFDA,RORIEN,RORMSG
 I $D(^RORDATA(798.8,+TASK,"RI",+ELMTIEN))<10  Q:$QUIT 0  Q
 S IENS="?+1,"_(+ELMTIEN)_","_(+TASK)_","
 S (RORIEN(1),RORFDA(798.872,IENS,.01))=$$XEC(NAME)
 I RORIEN(1)'>0  Q:$QUIT 0  Q
 S RORFDA(798.872,IENS,1)=VALUE
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 I $G(DIERR)  D  Q:$QUIT RC  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.872,IENS)
 Q:$QUIT +$G(RORIEN(1))  Q
 ;
 ;***** ADDS THE TEXT ELEMENT TO THE REPORT
 ;
 ; TASK          Task number
 ;
 ; NAME          Element name
 ;
 ; [.]ROR8TXT    Either a closed root or a reference to an array
 ;               that contains the text in word processing format.
 ;
 ; [PARENT]      IEN of the parent element
 ;
 ; The text should be properly encoded beforehand (use the
 ; $$XMLENC^RORUTL03 function).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Invalid element name
 ;       >0  IEN of the report element
 ;
ADDTEXT(TASK,NAME,ROR8TXT,PARENT) ;
 I $G(PARENT)<0  Q:$QUIT 0  Q
 N IENS,RC,RORFDA,RORIEN,RORMSG,TMP
 S IENS="+1,"_(+TASK)_","
 S (RORFDA(798.87,IENS,.01),TMP)=$$XEC(NAME)
 I TMP'>0  Q:$QUIT 0  Q
 S RORFDA(798.87,IENS,.02)=+$G(PARENT)
 S RORFDA(798.87,IENS,3)=$S($D(ROR8TXT)>1:"ROR8TXT",1:ROR8TXT)
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 I $G(DIERR)  D  Q:$QUIT RC  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.87,IENS)
 Q:$QUIT +$G(RORIEN(1))  Q
 ;
 ;***** ADDS THE SINGLE-LINE ELEMENT TO THE REPORT
 ;
 ; TASK          Task number
 ;
 ; NAME          Element name
 ;
 ; [VALUE]       Value of the element
 ;
 ; [PARENT]      IEN of the parent element
 ;
 ; [SORTBY]      Parent element is sorted by the value of the element
 ;               that is being added:
 ;                 1  Sort "as is"
 ;                 2  Sort as strings
 ;                 3  Sort as numbers
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Invalid element name
 ;       >0  IEN of the report element
 ;
ADDVAL(TASK,NAME,VALUE,PARENT,SORTBY,ID) ;
 I $G(PARENT)<0  Q:$QUIT 0  Q
 N IENS,RC,RORFDA,RORIEN,RORMSG,TMP
 S IENS="+1,"_(+TASK)_","
 S (RORFDA(798.87,IENS,.01),TMP)=$$XEC(NAME)
 I TMP'>0  Q:$QUIT 0  Q
 S RORFDA(798.87,IENS,.02)=+$G(PARENT)
 S:$G(SORTBY) RORFDA(798.87,IENS,.03)=SORTBY
 S:$G(VALUE)'="" RORFDA(798.87,IENS,1)=VALUE
 D:$G(ID)'=""
 . S TMP="+2,"_IENS
 . S (RORIEN(2),RORFDA(798.872,TMP,.01))=$$XEC("ID")
 . S RORFDA(798.872,TMP,1)=ID
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 I $G(DIERR)  D  Q:$QUIT RC  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.87,IENS)
 Q:$QUIT +$G(RORIEN(1))  Q
 ;
 ;***** CHECKS IF THE ELEMENT HAS "CHILDREN"
 ;
 ; TASK          Task number
 ;
 ; ELMTIEN       IEN of the element
 ;
 ; Return Values:
 ;        0  Leaf element
 ;       >0  Has children
 ;
HASCHLD(TASK,ELMTIEN) ;
 Q:ELMTIEN<0 0
 Q $D(^RORDATA(798.8,+TASK,"RI","APSV",+ELMTIEN))>1
 ;
 ;***** UPDATES VALUE OF THE ELEMENT
 ;
 ; TASK          Task number
 ;
 ; ELMTIEN       IEN of the element
 ;
 ; [VALUE]       Value of the element
 ;
 ; [SORTBY]      Parent element is sorted by the value of the element
 ;               that is being added:
 ;                 1  Sort "as is"
 ;                 2  Sort as strings
 ;                 3  Sort as numbers
 ;
 ; [IGNORE]      Do not render this element into the resulting XML
 ;               document.
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the report element
 ;
UPDVAL(TASK,ELMTIEN,VALUE,SORTBY,IGNORE) ;
 I $G(ELMTIEN)<0  Q:$QUIT 0  Q
 N IENS,RORFDA,RORIEN,RORMSG,TMP
 I $D(^RORDATA(798.8,+TASK,"RI",+ELMTIEN))<10  Q:$QUIT 0  Q
 S IENS=(+ELMTIEN)_","_(+TASK)_","
 S:$G(SORTBY) RORFDA(798.87,IENS,.03)=SORTBY
 S RORFDA(798.87,IENS,.04)=$S($G(IGNORE):1,1:"")
 S RORFDA(798.87,IENS,1)=$G(VALUE)
 D FILE^DIE(,"RORFDA","RORMSG")
 I $G(DIERR)  D  Q:$QUIT RC  Q
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.87,IENS)
 Q:$QUIT +$G(RORIEN(1))  Q
 ;
 ;***** DUMPS THE VARIABLE
 ;
 ; TASK          Task number
 ;
 ; ROOT          Closed root of the variable
 ;
 ; [PARENT]      IEN of the parent element (0, by default)
 ;
 ; [NAME]        Element name ("VARDUMP", by default)
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the element
 ;
VARDUMP(TASK,ROOT,PARENT,NAME) ;
 N DUMP,FLT,LFLT,PI
 S:$G(NAME)="" NAME="VARDUMP"
 S:$G(PARENT)'>0 PARENT=0
 ;---
 S LFLT=$L(ROOT)
 S:$E(ROOT,LFLT)=")" LFLT=LFLT-1
 S FLT=$E(ROOT,1,LFLT)
 ;---
 S DUMP=$$ADDVAL^RORTSK11(TASK,NAME,,PARENT)
 I DUMP<0  Q:$QUIT DUMP  Q
 S PI=ROOT
 F  S PI=$Q(@PI)  Q:$E(PI,1,LFLT)'=FLT  D
 . D ADDVAL^RORTSK11(TASK,"ITEM",PI_"="_@PI,DUMP)
 Q:$QUIT DUMP  Q
 ;
 ;***** RETURNS TYPE (CODE) OF THE ELEMENT
 ;
 ; NAME          Element name
 ;
XEC(NAME) ;
 S:'$D(RORCACHE("XMLENT",NAME)) RORCACHE("XMLENT",NAME)=+$O(^ROR(799.31,"B",$E(NAME,1,30),0))
 Q RORCACHE("XMLENT",NAME)
