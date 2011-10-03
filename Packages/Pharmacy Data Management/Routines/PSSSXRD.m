PSSSXRD ; BIR/PKR - Build indexes for drug files. ;08/30/2004
 ;;1.0;PHARMACY DATA MANAGEMENT;**62,89**;9/30/97
 ;
 ;Reference to ^PXRMINDX supported by DBIA #4114
 ;Reference to ADDERROR^PXRMSXRM supported by DBIA #4113
 ;Reference to DETIME^PXRMSXRM supported by DBIA #4113
 ;Reference to COMMSG^PXRMSXRM supported by DBIA #4113
 Q
 ;===============================================================
PSPA ;Build the index for the Pharmacy Patient File.
 N ADD,DA,DA1,DAS,DATE,DFN,DRUG,END,ENTRIES,GLOBAL,IDEN,IND,INS,NE
 N NERROR,POI,SDATE,SOL,START,STARTD,TEMP,TENP,TEXT
 S GLOBAL=$$GET1^DID(55,"","","GLOBAL NAME")
 ;Don't leave any old stuff around.
 K ^PXRMINDX(55),^PXRMINDX("55NVA")
 S ENTRIES=$P(^PS(55,0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for PHARMACY PATIENT FILE")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (DFN,IND,NE,NERROR)=0
 F  S DFN=+$O(^PS(55,DFN)) Q:DFN=0  D
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 .;Process Unit Dose.
 . S DA=0
 . F  S DA=+$O(^PS(55,DFN,5,DA)) Q:DA=0  D
 .. S TEMP=$G(^PS(55,DFN,5,DA,2))
 .. S STARTD=$P(TEMP,U,2)
 .. I STARTD="" D  Q
 ... S IDEN="DFN="_DFN_" D1="_DA_" Unit Dose missing start date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 .. S SDATE=$P(TEMP,U,4)
 .. I SDATE=1 Q
 .. I SDATE="" D  Q
 ... S IDEN="DFN="_DFN_" D1="_DA_" Unit Dose missing stop date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,5,DA,1,DA1)) Q:DA1=0  D
 ... S DRUG=$P(^PS(55,DFN,5,DA,1,DA1,0),U,1)
 ... I DRUG="" D  Q
 .... S IDEN="DFN="_DFN_" D1="_DA_" D2="_DA1_" Unit Dose missing drug"
 .... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 ... S DAS=DFN_";5;"_DA_";1;"_DA1_";0"
 ... S ^PXRMINDX(55,"IP",DRUG,DFN,STARTD,SDATE,DAS)=""
 ... S ^PXRMINDX(55,"PI",DFN,DRUG,STARTD,SDATE,DAS)=""
 ... S NE=NE+1
 .;Process the IV multiple.
 . S DA=0
 . F  S DA=+$O(^PS(55,DFN,"IV",DA)) Q:DA=0  D
 .. S TEMP=$G(^PS(55,DFN,"IV",DA,0))
 .. S STARTD=$P(TEMP,U,2)
 .. I STARTD="" D  Q
 ... S IDEN="DFN="_DFN_" D1="_DA_" IV missing start date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 .. S SDATE=$P(TEMP,U,3)
 .. I SDATE=1 Q
 .. I SDATE="" D  Q
 ... S IDEN="DFN="_DFN_" D1="_DA_" IV missing stop date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 ..;Process Additives
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,"IV",DA,"AD",DA1)) Q:DA1=0  D
 ... S ADD=$P(^PS(55,DFN,"IV",DA,"AD",DA1,0),U,1)
 ... I ADD="" D  Q
 .... S IDEN="DFN="_DFN_" D1="_DA_" D2="_DA1_" IV missing additive"
 .... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 ... S DRUG=$P($G(^PS(52.6,ADD,0)),U,2)
 ... I DRUG="" D  Q
 .... S IDEN="DFN="_DFN_" D1="_DA_" D2="_DA1_" IV additive missing drug"
 .... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 ... S NE=NE+1
 ... S DAS=DFN_";IV;"_DA_";AD;"_DA1_";0"
 ... S ^PXRMINDX(55,"IP",DRUG,DFN,STARTD,SDATE,DAS)=""
 ... S ^PXRMINDX(55,"PI",DFN,DRUG,STARTD,SDATE,DAS)=""
 ..;Process Solutions
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,"IV",DA,"SOL",DA1)) Q:DA1=0  D
 ... S SOL=$P(^PS(55,DFN,"IV",DA,"SOL",DA1,0),U,1)
 ... I SOL="" D  Q
 .... S IDEN="DFN="_DFN_" D1="_DA_" D2="_DA1_" IV-SOL missing solution"
 .... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 ... S DRUG=$P($G(^PS(52.7,SOL,0)),U,2)
 ... I DRUG="" D  Q
 .... S IDEN="DFN="_DFN_" D1="_DA_" D2="_DA1_" IV-SOL missing Drug"
 .... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 ... S NE=NE+1
 ... S DAS=DFN_";IV;"_DA_";SOL;"_DA1_";0"
 ... S ^PXRMINDX(55,"IP",DRUG,DFN,STARTD,SDATE,DAS)=""
 ... S ^PXRMINDX(55,"PI",DFN,DRUG,STARTD,SDATE,DAS)=""
 .;Process the NVA multiple.
 . S DA=0
 . F  S DA=+$O(^PS(55,DFN,"NVA",DA)) Q:DA=0  D
 .. S TEMP=$G(^PS(55,DFN,"NVA",DA,0))
 .. S STARTD=$P(TEMP,U,9)
 .. I STARTD="" S STARTD=$P(TEMP,U,10)
 .. I STARTD="" D  Q
 ... S IDEN="DFN="_DFN_" D1="_DA_" NVA missing start date"
 ... D ADDERROR^PXRMSXRM(GLOBAL,IDEN,.NERROR)
 .. S SDATE=$P(TEMP,U,7)
 .. I SDATE="" S SDATE="U"_DFN_DA
 .. S DAS=DFN_";NVA;"_DA_";0"
 .. S POI=$P(TEMP,U,1)
 .. S ^PXRMINDX("55NVA","IP",POI,DFN,STARTD,SDATE,DAS)=""
 .. S ^PXRMINDX("55NVA","PI",DFN,POI,STARTD,SDATE,DAS)=""
 S END=$H
 S TEXT=NE_" PHARMACY PATIENTS results indexed."
 D MES^XPDUTL(TEXT)
 S TEXT=NERROR_" errors were encountered."
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(55,"GLOBAL NAME")=$$GET1^DID(55,"","","GLOBAL NAME")
 S ^PXRMINDX(55,"BUILT BY")=DUZ
 S ^PXRMINDX(55,"DATE BUILT")=$$NOW^XLFDT
 S ^PXRMINDX("55NVA","GLOBAL NAME")=^PXRMINDX(55,"GLOBAL NAME")
 S ^PXRMINDX("55NVA","BUILT BY")=^PXRMINDX(55,"BUILT BY")
 S ^PXRMINDX("55NVA","DATE BUILT")=^PXRMINDX(55,"DATE BUILT")
 Q
