ORPXRM ; SLC/PKR - Clinical Reminder index routines for file 100. ;8/13/06  14:19
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**157,260**;Dec 17, 1997;Build 26
 ;DBIA 4113 supports PXRMSXRM entry points. 
 ;DBIA 4114 supports setting and killing ^PXRMINDX
 ;=========================================================
INDEX ;Build the index for the ORDER file.
 N D0,D0P,D1,DAS,DFN,END,ENTRIES,ETEXT,FERROR,GLOBAL,IND,NE,NDUP,NERROR
 N OI,PROC,START,STRTDATE,STOP,TEMP,TENP,TEXT
 ;Don't leave any old stuff around.
 K ^PXRMINDX(100)
 S GLOBAL=$$GET1^DID(100,"","","GLOBAL NAME")
 S ENTRIES=$P(^OR(100,0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building index for ORDER file")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (D0,D0P,FERROR,IND,NDUP,NE,NERROR)=0
 F  S D0=$O(^OR(100,D0)) Q:(+D0=0)!(FERROR)  D
 . I D0'>D0P D  Q
 .. S FERROR=1
 .. S ETEXT=D0_" subscript is a bad, cannot continue!"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S D0P=D0
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=$G(^OR(100,D0,0))
 . I TEMP="" D  Q
 .. S ETEXT=D0_" bad entry no 0 node"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DFN=$P(TEMP,U,2)
 . I DFN="" D  Q
 .. S ETEXT=D0_" no DFN"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I DFN'["DPT(" Q
 . S DFN=$P(DFN,";",1)
 . S STRTDATE=$P(TEMP,U,8)
 .;If there is no start date get the release date for the new order.
 . I STRTDATE="" S STRTDATE=$$RDATE(D0)
 . I STRTDATE="" Q
 . S STOP=$P(TEMP,U,9)
 . S STOP=$S(STOP="":"U"_D0,1:STOP)
 . S D1=0
 . F  S D1=+$O(^OR(100,D0,.1,D1)) Q:D1=0  D
 .. S OI=^OR(100,D0,.1,D1,0)
 .. S DAS=D0_";.1;"_D1_";0"
 .. I OI="" D  Q
 ... S ETEXT=DAS_" no orderable item"
 ... D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 .. I $D(^PXRMINDX(100,"IP",OI,DFN,STRTDATE,STOP,DAS)) S NDUP=NDUP+1
 .. S ^PXRMINDX(100,"IP",OI,DFN,STRTDATE,STOP,DAS)=""
 .. S ^PXRMINDX(100,"PI",DFN,OI,STRTDATE,STOP,DAS)=""
 .. S NE=NE+1
 S END=$H
 S TEXT=NE_" ORDER results indexed."
 W !,"There were "_NDUP_" duplicates."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(100,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(100,"BUILT BY")=DUZ
 S ^PXRMINDX(100,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;=========================================================
GETDATA(ORIFN,DATA) ;Return data, for a specified order file entry.
 N ORUPCHUK
 D EN^ORX8(ORIFN)
 S ORUPCHUK("ORORDER")=$$OI^ORX8(ORIFN)
 S ORUPCHUK("ORREL")=$$RDATE(ORIFN)
 M DATA=ORUPCHUK
 Q
 ;
 ;=========================================================
KOR(X,DA) ;Kill index for Order file.
 N DAS,DFN,STOP
 I X(1)'["DPT" Q
 I 'X(2)!'X(3) Q
 S DFN=$P(X(1),";",1)
 S DAS=DA(1)_";.1;"_DA_";0"
 S STOP=$S(X(4)="":"U"_DA(1),1:X(4))
 K ^PXRMINDX(100,"IP",X(2),DFN,X(3),STOP,DAS)
 K ^PXRMINDX(100,"PI",DFN,X(2),X(3),STOP,DAS)
 Q
 ;=========================================================
RDATE(ORIFN) ;Return the release date for the new order action.
 N RDIEN
 S RDIEN=$O(^OR(100,ORIFN,8,"C","NW",""))
 I RDIEN="" Q ""
 Q $P(^OR(100,ORIFN,8,RDIEN,0),U,16)
 ;
 ;=========================================================
SOR(X,DA) ;Set index for Order file.
 ;X(1)=OBJECT OF ORDER, X(2)=ORDERABLE ITEM, X(3)=START DATE
 ;or release date, X(4)=STOP DATE
 N DAS,DFN,STOP
 I X(1)'["DPT" Q
 I 'X(2)!'X(3) Q
 S DFN=$P(X(1),";",1)
 S DAS=DA(1)_";.1;"_DA_";0"
 S STOP=$S(X(4)="":"U"_DA(1),1:+X(4))
 S ^PXRMINDX(100,"IP",X(2),DFN,+X(3),STOP,DAS)=""
 S ^PXRMINDX(100,"PI",DFN,X(2),+X(3),STOP,DAS)=""
 Q
 ;
