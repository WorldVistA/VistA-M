YTPXRM ; SLC/PKR - Build indexes for Mental Health. ;10/28/2003
 ;;5.01;MENTAL HEALTH;**77**;Dec 30, 1994
 ;DBIA 4113 supports PXRMSXRM entry points. 
 ;DBIA 4114 supports setting and killing ^PXRMINDX(601.2)
 ;===============================================================
INDEX ;Build the index for MENTAL HEALTH.
 N DAS,DAST,DATE,DFN,END,ENTRIES,GLOBAL,IND,INS,NE,NERROR
 N START,TENP,TEXT
 ;Dont leave any old stuff around.
 K ^PXRMINDX(601.2)
 S GLOBAL=$$GET1^DID(601.2,"","","GLOBAL NAME")
 S ENTRIES=$P(^YTD(601.2,0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for MENTAL HEALTH DATA")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DFN,IND,NE,NERROR)=0
 F  S DFN=+$O(^YTD(601.2,DFN)) Q:DFN=0  D
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S INS=0
 . F  S INS=$O(^YTD(601.2,DFN,1,INS)) Q:+INS=0  D
 .. S DAST=DFN_";1;"_INS_";1;"
 .. S DATE=0
 .. F  S DATE=$O(^YTD(601.2,DFN,1,INS,1,DATE)) Q:DATE=""  D
 ... S DAS=DAST_DATE
 ... S ^PXRMINDX(601.2,"IP",INS,DFN,DATE,DAS)=""
 ... S ^PXRMINDX(601.2,"PI",DFN,INS,DATE,DAS)=""
 ... S NE=NE+1
 S END=$H
 S TEXT=NE_" MENTAL HEALTH results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(601.2,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(601.2,"BUILT BY")=DUZ
 S ^PXRMINDX(601.2,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
KMH(X,DA) ;Delete index for Psych Instrument Patient File
 N DAS
 S DAS=DA(2)_";1;"_DA(1)_";1;"_X(1)
 K ^PXRMINDX(601.2,"IP",DA(1),DA(2),X(1),DAS)
 K ^PXRMINDX(601.2,"PI",DA(2),DA(1),X(1),DAS)
 Q
 ;
 ;===============================================================
SMH(X,DA) ;Set index for Psych Instrument Patient File
 ;DA=COMPLETION DATE, DA(1)=INSTRUMENT, DA(2)=DFN
 ;X(1)=COMPLETION DATE
 N DAS
 S DAS=DA(2)_";1;"_DA(1)_";1;"_X(1)
 S ^PXRMINDX(601.2,"IP",DA(1),DA(2),X(1),DAS)=""
 S ^PXRMINDX(601.2,"PI",DA(2),DA(1),X(1),DAS)=""
 Q
 ;
