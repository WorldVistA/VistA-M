PSONVAP3 ;HPS/DSK - Non-VA Provider Updates ;June 26, 2018 11:20
 ;;7.0;OUTPATIENT PHARMACY;**481**;DEC 1997;Build 31
 ;
 ;continuation of routine PSONVAP2
 ;
 ;EXTERNAL REFERENCES
 ;    ^XUSEC                                - IA #10076 (Supported)
 ;    $$SENDMSG^XMXAPI                      - IA #2729  (Supported)
 ;    $$SETUP1^XQALERT                      - IA #10081 (Supported)
 ;
 Q
 ;
MAIL ;Send mail messages to holders of PSDMGR key
 ;variable for alerts must be XQA
 N TYPE,PSOMESNUM,PSOUSER,PSOMY,PSOALMSG,XQA
 S PSOUSER=0
 F  S PSOUSER=$O(^XUSEC("PSDMGR",PSOUSER)) Q:PSOUSER=""  S PSOMY(PSOUSER)=""
 ;
 S PSOMESNUM=$$MSEND("SUCCESS")
 I PSOMESNUM D
 . S PSOALMSG="MailMan message #"_PSOMESNUM_" lists providers successfully loaded"
 . D ALERT(PSOALMSG)
 S PSOMESNUM=$$MSEND("PROBLEM")
 I PSOMESNUM D
 . S PSOALMSG="MailMan message #"_PSOMESNUM_" lists providers with filing issues"
 . D ALERT(PSOALMSG)
 S PSOMESNUM=$$MSEND("PRENPI")
 I PSOMESNUM D
 . S PSOALMSG="MailMan message #"_PSOMESNUM_" lists provider NPI's already on file"
 . D ALERT(PSOALMSG)
 S PSOMESNUM=$$MSEND("DUPNPI")
 I PSOMESNUM D
 . S PSOALMSG="MailMan message #"_PSOMESNUM_" lists provider NPI's in spreadsheet multiple times"
 . D ALERT(PSOALMSG)
 S PSOMESNUM=$$MSEND("DUPNAME")
 I PSOMESNUM D
 . S PSOALMSG="MailMan message #"_PSOMESNUM_" lists providers for which name is already on file"
 . D ALERT(PSOALMSG)
 Q
 ;
MSEND(TYPE) ;Send local e-mail
 ;
 N DIFROM,PSOA,PSOB,PSOTEXT,PSODUZ,PSOSUB,PSOTEXT,PSOMZ,PSOMIN,PSOSTR,PSOHIT,PSOSTR2
 N PSOPAD,PSOMAIL
 S PSOPAD="                    "
 S PSOMAIL="PSO_MAIL "_TYPE_" "_PSOJOB
 ;
 ;Keeping MailMessages in ^XTMP for 60 days in case needed later
 S ^XTMP(PSOMAIL,0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^Non-VA Provider Update Mail Message - "_TYPE
 ;
 S PSOHIT=0
 ; Returns: Message number
 I TYPE="SUCCESS" D
 . S PSOSUB="VACAA: Filing Success"
 . S PSOHIT=1
 . S ^XTMP(PSOMAIL,1)="This message lists new Non-VA Providers successfully uploaded into the VistA"
 . S ^XTMP(PSOMAIL,2)="NEW PERSON file (#200) for VACAA."
 . S ^XTMP(PSOMAIL,3)=" "
 . I $O(^XTMP(PSOJOB,PSODT,"SUCCESS",PSOTM,0))="" D  Q
 . . S ^XTMP(PSOMAIL,4)=" "
 . . S ^XTMP(PSOMAIL,5)="**** NO NEW PROVIDERS SUCCESSFULLY UPLOADED ****"
 . . S ^XTMP(PSOMAIL,6)="**** SEE SEPARATE MESSAGES CONCERNING FILING PROBLEMS ****"
 . . S ^XTMP(PSOMAIL,7)="**** AND INFORMATION ON PROVIDERS WHICH ARE ALREADY ON FILE ****"
 . . S ^XTMP(PSOMAIL,8)=" "
 . S ^XTMP(PSOMAIL,4)="IEN            Provider"
 . S ^XTMP(PSOMAIL,5)="------------   -----------------------------------"
 . S PSOB=6
 . S PSOA=0 F  S PSOA=$O(^XTMP(PSOJOB,PSODT,"SUCCESS",PSOTM,PSOA)) Q:PSOA=""  D
 . . S ^XTMP(PSOMAIL,PSOB)=$G(^XTMP(PSOJOB,PSODT,"SUCCESS",PSOTM,PSOA))
 . . S PSOB=PSOB+1
 I TYPE="PROBLEM",$O(^XTMP(PSOJOB,PSODT,"PROBLEM",PSOTM,0)) D
 . S PSOHIT=1
 . S PSOSUB="VACAA: Filing Problem(s)"
 . S ^XTMP(PSOMAIL,1)="This message lists Non-VA Provider(s) that failed to load into the VistA"
 . S ^XTMP(PSOMAIL,2)="NEW PERSON file (#200) for VACAA (described below)."
 . S ^XTMP(PSOMAIL,3)=" "
 . S ^XTMP(PSOMAIL,4)="A provider might be listed in both the SUCCESS and PROBLEM messages"
 . S ^XTMP(PSOMAIL,5)="if not all fields in the NEW PERSON (#200) file were able to be populated."
 . S ^XTMP(PSOMAIL,6)=" "
 . S ^XTMP(PSOMAIL,7)="Error Message                                          Provider"
 . S ^XTMP(PSOMAIL,8)="-------------                                          ---------------------"
 . S PSOB=9
 . S PSOA=0 F  S PSOA=$O(^XTMP(PSOJOB,PSODT,"PROBLEM",PSOTM,PSOA)) Q:PSOA=""  D
 . . S ^XTMP(PSOMAIL,PSOB)=$G(^XTMP(PSOJOB,PSODT,"PROBLEM",PSOTM,PSOA))
 . . S PSOB=PSOB+1
 I TYPE="PRENPI",$O(^XTMP(PSOJOB,PSODT,"PRENPI",PSOTM,0)) D
 . S PSOHIT=1
 . S PSOSUB="VACAA: NPI(s) Already On File"
 . S ^XTMP(PSOMAIL,1)="This message lists Non-VA Provider(s) that failed to load into the VistA"
 . S ^XTMP(PSOMAIL,2)="NEW PERSON file (#200) because the NPI was already on file."
 . S ^XTMP(PSOMAIL,3)=" "
 . S ^XTMP(PSOMAIL,4)="NPI                 Provider"
 . S ^XTMP(PSOMAIL,5)="----------          --------------------"
 . S PSOB=6
 . S PSOA=0 F  S PSOA=$O(^XTMP(PSOJOB,PSODT,"PRENPI",PSOTM,PSOA)) Q:PSOA=""  D
 . . S PSOSTR=$G(^XTMP(PSOJOB,PSODT,"PRENPI",PSOTM,PSOA))
 . . S ^XTMP(PSOMAIL,PSOB)=$P(PSOSTR,",",12)_"          "_$P(PSOSTR,",",1,2)
 . . S PSOB=PSOB+1
 I TYPE="DUPNPI",$O(^XTMP(PSOJOB,PSODT,"DUPNPI",PSOTM,0)) D
 . S PSOHIT=1
 . S PSOSUB="VACAA: NPI(s) Listed Multiple Times in Spreadsheet"
 . S ^XTMP(PSOMAIL,1)="This message lists Non-VA Provider data that failed to load into the VistA"
 . S ^XTMP(PSOMAIL,2)="NEW PERSON file (#200) because the NPI was listed in the spreadsheet multiple"
 . S ^XTMP(PSOMAIL,3)="times - possibly under multiple addresses."
 . S ^XTMP(PSOMAIL,4)=" "
 . S ^XTMP(PSOMAIL,5)="NPI            Provider               Street Address"
 . S ^XTMP(PSOMAIL,6)="----------     --------------------   -------------------"
 . S PSOB=7
 . S PSOA=0 F  S PSOA=$O(^XTMP(PSOJOB,PSODT,"DUPNPI",PSOTM,PSOA)) Q:PSOA=""  D
 . . S PSOSTR=$G(^XTMP(PSOJOB,PSODT,"DUPNPI",PSOTM,PSOA)),PSOSTR2=$E($P(PSOSTR,",",1,2),1,20)
 . . S ^XTMP(PSOMAIL,PSOB)=$P(PSOSTR,",",12)_"     "_PSOSTR2
 . . S ^XTMP(PSOMAIL,PSOB)=^XTMP(PSOMAIL,PSOB)_$S($L(PSOSTR2)<20:$E(PSOPAD,1,20-$L(PSOSTR2)),1:"")_"   "_$P(PSOSTR,",",6)
 . . S PSOB=PSOB+1
 I TYPE="DUPNAME",$O(^XTMP(PSOJOB,PSODT,"DUPNAME",PSOTM,0)) D
 . S PSOHIT=1
 . S PSOSUB="VACAA: Name(s) already on file in the New Person (#200) file"
 . S ^XTMP(PSOMAIL,1)="This message lists Non-VA Provider data that failed to load into the VistA"
 . S ^XTMP(PSOMAIL,2)="NEW PERSON file (#200) because the name is already on file"
 . S ^XTMP(PSOMAIL,3)=" "
 . S ^XTMP(PSOMAIL,4)="NPI            Provider               Street Address"
 . S ^XTMP(PSOMAIL,5)="----------     --------------------   -------------------"
 . S PSOB=6
 . S PSOA=0 F  S PSOA=$O(^XTMP(PSOJOB,PSODT,"DUPNAME",PSOTM,PSOA)) Q:PSOA=""  D
 . . S PSOSTR=$G(^XTMP(PSOJOB,PSODT,"DUPNAME",PSOTM,PSOA)),PSOSTR2=$E($P(PSOSTR,",",1,2),1,20)
 . . S ^XTMP(PSOMAIL,PSOB)=$P(PSOSTR,",",12)_"     "_PSOSTR2
 . . S ^XTMP(PSOMAIL,PSOB)=^XTMP(PSOMAIL,PSOB)_$S($L(PSOSTR2)<20:$E(PSOPAD,1,20-$L(PSOSTR2)),1:"")_"   "_$P(PSOSTR,",",6)
 . . S PSOB=PSOB+1
 I 'PSOHIT Q 0
 S PSODUZ=PSOSAVDUZ
 S PSOTEXT="^XTMP(""PSO_MAIL ""_TYPE_"" ""_PSOJOB)"
 S PSOMIN("FROM")="Non-VA Provider Updates"
 D SENDMSG^XMXAPI(PSODUZ,PSOSUB,PSOTEXT,.PSOMY,.PSOMIN,.PSOMZ,"")
 Q $G(PSOMZ)
 ;
ALERT(XQAMSG) ;send alerts
 ;variables must be prefixed with "X"
 N XQAID,XALERT
 S XQAID="Non-VA Provider Updates"
 M XQA=PSOMY
 S XALERT=$$SETUP1^XQALERT
 Q
 ;
