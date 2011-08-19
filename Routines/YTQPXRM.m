YTQPXRM ; ALB/ASF - Build indexes for Mental Health MHA3 ; 3/13/07 1:43pm
 ;;5.01;MENTAL HEALTH;**85**;Dec 30, 1994;Build 48
 ;DBIA 4113 supports PXRMSXRM entry points. 
 ;DBIA ???? supports setting and killing ^PXRMINDX(601.84)
 ;===============================================================
INDEX ;Build the index for MENTAL HEALTH.
 N DAS,DAST,DATE,DFN,END,ENTRIES,GLOBAL,IND,INS,NE,NERROR
 N START,TENP,TEXT,IFN,COMP
 ;Dont leave any old stuff around.
 K ^PXRMINDX(601.84)
 S GLOBAL=$$GET1^DID(601.84,"","","GLOBAL NAME")
 S ENTRIES=$P(^YTT(601.84,0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for MHA3 DATA")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (IFN,DFN,IND,NE,NERROR)=0
 F  S IFN=$O(^YTT(601.84,IFN)) Q:IFN'>0  D
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S COMP=$P($G(^YTT(601.84,IFN,0)),U,9)
 . Q:COMP'="Y"  ;index only completed admins
 . S DFN=$P(^YTT(601.84,IFN,0),U,2)
 . S INS=$P(^YTT(601.84,IFN,0),U,3)
 . S DATE=$P(^YTT(601.84,IFN,0),U,4) ;date given
 . S DAS=IFN
 . S ^PXRMINDX(601.84,"IP",INS,DFN,DATE,DAS)=""
 . S ^PXRMINDX(601.84,"PI",DFN,INS,DATE,DAS)=""
 . S NE=NE+1
 S END=$H
 S TEXT=NE_" MHA3 results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(601.84,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(601.84,"BUILT BY")=DUZ
 S ^PXRMINDX(601.84,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
KMH(X,DA) ;Delete index for 601.84 MH ADMINISTRATIONS
 ;X(1)=Patient X(2)=Instrument X(3)=Date Given
 K ^PXRMINDX(601.84,"IP",X(2),X(1),X(3),DA)
 K ^PXRMINDX(601.84,"PI",X(1),X(2),X(3),DA)
 Q
 ;
 ;===============================================================
SMH(X,DA) ;Set index for 601.84 MH ADMINISTRATIONS
 ;X(1)=Patient X(2)=Instrument X(3)=Date Given
 S ^PXRMINDX(601.84,"IP",X(2),X(1),X(3),DA)=""
 S ^PXRMINDX(601.84,"PI",X(1),X(2),X(3),DA)=""
 Q
 ;
