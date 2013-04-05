LA7VHLUA ;DALOI/JMC - HL7 SNOMED utility ;11/17/11  15:33
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Utility to resolve SNOMED CT, LOINC and local codes.
 ;
 Q
 ;
 ;
ADDSCT ; Add entry with SCT to local file
 ; Called from LA7VHLU6
 ;
 N FDA,LA7MSG,LRDIE,LRFPRIV
 ;
 S LRFPRIV=1
 S FDA(1,FILE,"+1,",.01)=TEXT
 S FDA(1,FILE,"+1,",.20)=CODE
 D UPDATE^DIE("","FDA(1)","FDAIEN","LRDIE(1")
 I $D(LRDIE) S LA7IEN="-1^Unable to add SNOMED CT to file"
 E  S LA7IEN=FDAIEN(1)
 ;
 ; Notify that entry has been added
 S LA7MSG="SNOMED CT term added to file #"_FILE
 D SENDBULL,SA
 Q
 ;
 ;
SENDBULL ; Send bulletin that local addition has occurred
 ; Ignore any restrictions (domain closed or protected by security key)
 ;
 ;
 N LA7BODY
 N XMBODY,XMDUZ,XMBNAME,XMERR,XMINSTR,XMPARM,XMTO,X,Y
 ;
 S XMBNAME="LA7 NEW TERM ADDED"
 S XMPARM(1)=LA7MSG
 S XMPARM(2)=$S($G(LA76248):$$GET1^DIQ(62.48,LA76248_",",.01),1:"UNKNOWN")
 S XMPARM(3)=$G(LA76429)
 ;
 S XMINSTR("ADDR FLAGS")="R"
 S XMINSTR("FROM")="LAB PACKAGE"
 ;
 S XMTO("G."_$$FAMG^LA7VHLU1(LA76248,1))=""
 D SENDBULL^XMXAPI(DUZ,XMBNAME,.XMPARM,$S($D(LA7BODY):"LA7BODY",1:""),.XMTO,.XMINSTR,.LA7TSK,"")
 ;
 Q
 ;
 ;
SA ; Send alert
 ;
 N XQA,XQAID,XQADATA,XQAFLAG,XQAMSG,XQAOPT,XQAROU
 S XQAMSG="Lab Messaging - Addition of new term - see mail bulletin"
 S XQAID="LA7-NEW-TERM"_$S($G(LA76248):"-"_$$GET1^DIQ(62.48,LA76248_",",.01),1:"")
 S XQA("G."_$$FAMG^LA7VHLU1($G(LA76248),1))=""
 D DEL^LA7UXQA(XQAID)
 D SETUP^XQALERT
 ;
 Q
