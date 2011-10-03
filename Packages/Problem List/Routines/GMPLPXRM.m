GMPLPXRM ; SLC/PKR - Build Clinical Reminder indexes for AUPNPROB. ;02/27/2004
        ;;2.0;Problem List;**27**;Aug 25, 1994
 ;DBIA 4113 supports PXRMSXRM entry points. 
 ;DBIA 4114 supports setting and killing ^PXRMINDX(9000011)
 ;===============================================================
INDEX ;Build the indexes for PROBLEM LIST.
 N COND,DAS,DFN,DIFF,DLM,DONE,END,ENTRIES,ETEXT,GLOBAL,IND,NE,NERROR
 N PRIO,PROB,START,STATUS,TEMP,TENP,TEXT
 ;Don't leave any old stuff around.
 ;DBIA 4114
 K ^PXRMINDX(9000011)
 S GLOBAL=$$GET1^DID(9000011,"","","GLOBAL NAME")
 S ENTRIES=$P(^AUPNPROB(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes PROBLEM LIST")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DAS,DONE,IND,NE,NERROR)=0
 F  S DAS=$O(^AUPNPROB(DAS)) Q:DONE  D
 . I +DAS=0 S DONE=1 Q
 . I +DAS'=DAS D  Q
 .. S DONE=1
 .. S ETEXT="Bad ien: "_DAS_", cannot continue."
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=$G(^AUPNPROB(DAS,1))
 . S COND=$P(TEMP,U,2)
 .;Don't index Hidden problems.
 . I COND="H" Q
 . S PRIO=$P(TEMP,U,14)
 .;If there is no priority set it to "U" for undefined.
 . I PRIO="" S PRIO="U"
 . S TEMP=^AUPNPROB(DAS,0)
 . S PROB=$P(TEMP,U,1)
 . I PROB="" D  Q
 .. S ETEXT=DAS_" missing problem"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . I '$D(^ICD9(PROB)) D  Q
 .. S ETEXT=DAS_" invalid ICD9"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DFN=$P(TEMP,U,2)
 . I DFN="" D  Q
 .. S ETEXT=DAS_" missing DFN"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S DLM=$P(TEMP,U,3)
 . I DLM="" D  Q
 .. S ETEXT=DAS_" missing date laste modified"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR)
 . S STATUS=$P(TEMP,U,12)
 . I STATUS="" D  Q
 .. S ETEXT=DAS_" missing status"
 .. D ADDERROR^PXRMSXRM(GLOBAL,ETEXT,.NERROR) Q
 . S NE=NE+1
 . S ^PXRMINDX(9000011,"ISPP",PROB,STATUS,PRIO,DFN,DLM,DAS)=""
 . S ^PXRMINDX(9000011,"PSPI",DFN,STATUS,PRIO,PROB,DLM,DAS)=""
 S END=$H
 S TEXT=NE_" PROBLEM LIST results indexed."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(9000011,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(9000011,"BUILT BY")=DUZ
 S ^PXRMINDX(9000011,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
 ;===============================================================
KPROB(X,DA) ;Delete index for Problem List.
 N PRIO
 S PRIO=$S(X(5)="":"U",1:X(5))
 ;DBIA 4114
 K ^PXRMINDX(9000011,"ISPP",X(1),X(4),PRIO,X(2),X(3),DA)
 K ^PXRMINDX(9000011,"PSPI",X(2),X(4),PRIO,X(1),X(3),DA)
 Q
 ;
 ;===============================================================
SPROB(X,DA) ;Set index for Problem List.
 ;X(1)=DIAGNOSIS, X(2)=DFN, X(3)=DATE LAST MODIFIED, X(4)=STATUS
 ;X(5)=PRIORITY, X(6)=CONDITION
 ;Don't index Hidden problems.
 I X(6)="H" Q
 N PRIO
 S PRIO=$S(X(5)="":"U",1:X(5))
 ;DBIA 4114
 S ^PXRMINDX(9000011,"ISPP",X(1),X(4),PRIO,X(2),X(3),DA)=""
 S ^PXRMINDX(9000011,"PSPI",X(2),X(4),PRIO,X(1),X(3),DA)=""
 Q
 ;
