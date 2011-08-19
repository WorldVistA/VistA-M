ENTIRN ;WOIFO/SAB - Responsibility Notification ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
 ; called by option ENIT RESP NOTIFY during user sign-on
 Q:'$D(^ENG(6916.3,"AOA",DUZ))  ; user doesn't have active IT assignments
 ;
 N ENC,ENDA,ENEQ,ENSD
 S ENC("U")=0 ; init count of assignments that need to be signed
 S ENC("R")=0 ; init count of assignments that need to be re-signed
 ;
 ; loop thru active assignments for user
 S ENEQ=0 F  S ENEQ=$O(^ENG(6916.3,"AOA",DUZ,ENEQ)) Q:'ENEQ  D
 . S ENDA=0 F  S ENDA=$O(^ENG(6916.3,"AOA",DUZ,ENEQ,ENDA)) Q:'ENDA  D
 . . S ENSD=$P($P($G(^ENG(6916.3,ENDA,0)),"^",5),".") ; signed date
 . . I 'ENSD S ENC("U")=ENC("U")+1 Q
 . . I ENSD,$$FMDIFF^XLFDT(DT,ENSD)>359 S ENC("R")=ENC("R")+1
 ;
 I ENC("U")=0,ENC("R")=0 Q  ; no action required
 ;
 I ENC("U") D SET^XUS1A("!"_ENC("U")_" IT Assignment(s) need signature.")
 I ENC("R") D SET^XUS1A("!"_ENC("R")_" IT Assignment(s) need re-signature.")
 D SET^XUS1A("!Use the IT Owner Menu to sign for IT equipment.")
 ;
 Q
 ;
 ;ENTIRN
