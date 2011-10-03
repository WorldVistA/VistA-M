PSOPXRMI ; ISC/MFR - Build Reminders Indexes for PSRX ;06/18/2003
 ;;7.0;OUTPATIENT PHARMACY;**118**;DEC 1997
 ;External reference to PXRMSXRM is supported by DBIA 4113
 ;External reference to File ^PXRMINDX( supported by DBIA 4114
 ;
PSRX ;Build the index for the Prescription File.
 N DA,DA1,DAS,DATE,DSUP,DFN,DRUG,END,ENTRIES,GLOBAL,IDEN,IND,INS
 N NE,NERROR,RDATE,SDATE,START,TENP,TEXT
 ;Don't leave any old stuff around.
 K ^PXRMINDX(52)
 S GLOBAL=$$GET1^DID(52,"","","GLOBAL NAME")
 S ENTRIES=$P(^PSRX(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for PRESCRIPTION FILE")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DA1,IND,NE,NERROR)=0
 F  S DA1=+$O(^PSRX(DA1)) Q:DA1=0  D
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=$G(^PSRX(DA1,0))
 . S DFN=$P(TEMP,U,2)
 . I DFN="" D  Q
 .. S IDEN=DA1_" missing DFN"
 .. D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 . S DRUG=$P(TEMP,U,6)
 . I DRUG="" D  Q
 .. S IDEN=DA1_" missing drug"
 .. D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR) Q
 . S DSUP=$P(TEMP,U,8)
 . I DSUP="" D  Q
 .. S IDEN=DA1_" missing days supply"
 .. D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 . S RDATE=+$P($G(^PSRX(DA1,2)),U,13)
 . I RDATE>0 D
 .. S SDATE=+$$FMADD^XLFDT(RDATE,DSUP)
 .. S DAS=DA1_";2"
 .. S ^PXRMINDX(52,"IP",DRUG,DFN,RDATE,SDATE,DAS)=""
 .. S ^PXRMINDX(52,"PI",DFN,DRUG,RDATE,SDATE,DAS)=""
 .. S NE=NE+1
 .;Process the refill mutiple.
 . S DA=0
 . F  S DA=+$O(^PSRX(DA1,1,DA)) Q:DA=0  D
 .. S TEMP=$G(^PSRX(DA1,1,DA,0))
 .. S DSUP=+$P(TEMP,U,10)
 .. S RDATE=+$P(TEMP,U,18)
 .. I RDATE>0 D
 ... S SDATE=+$$FMADD^XLFDT(RDATE,DSUP)
 ... S DAS=DA1_";1;"_DA_";0"
 ... S ^PXRMINDX(52,"IP",DRUG,DFN,RDATE,SDATE,DAS)=""
 ... S ^PXRMINDX(52,"PI",DFN,DRUG,RDATE,SDATE,DAS)=""
 ... S NE=NE+1
 .;Process the partial fill multiple.
 . S DA=0
 . F  S DA=+$O(^PSRX(DA1,"P",DA)) Q:DA=0  D
 .. S TEMP=$G(^PSRX(DA1,"P",DA,0))
 .. S DSUP=+$P(TEMP,U,10)
 .. S RDATE=+$P(TEMP,U,19)
 .. I RDATE>0 D
 ... S SDATE=+$$FMADD^XLFDT(RDATE,DSUP)
 ... S DAS=DA1_";P;"_DA_";0"
 ... S ^PXRMINDX(52,"IP",DRUG,DFN,RDATE,SDATE,DAS)=""
 ... S ^PXRMINDX(52,"PI",DFN,DRUG,RDATE,SDATE,DAS)=""
 ... S NE=NE+1
 S END=$H
 S TEXT=NE_" PRESCRIPTION results indexed."
 D MES^XPDUTL(TEXT)
 S TEXT=NERROR_" errors were encountered."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(52,"GLOBAL NAME")=GLOBAL
 S ^PXRMINDX(52,"BUILT BY")=DUZ
 S ^PXRMINDX(52,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
