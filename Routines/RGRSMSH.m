RGRSMSH ;ALB/RJS-REGISTRATION MESSAGE PARSER FOR CIRN ;03/8/96
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**4,8**;30 Apr 99
EN() ;
 ;This function call returns information from the MSH and EVN segments
 ;
 ; Output:
 ;    date received^event date from EVN segment^sending facility
 ;    (station # -or- station#~domain)
 ;
 N RGRSMSH,RGC,RGRSEVN,RECDATE,EVDATE,%,INSTNUM
 S RGC=$E(HL("ECH"))
 S RGRSMSH=$$SEG1^RGRSUTIL("MSH",1,"MSH")
 S RGRSEVN=$$SEG1^RGRSUTIL("EVN",1,"EVN")
 ;;S INSTNUM=$P(RGRSMSH,HL("FS"),4)
 ;; ^ changed 11/20/98 by cmc - MSH segment read into 2 array entries
 ;; need to use new supported variable HL("SFN")
 D NOW^%DTC
 S (RECDATE)=$G(%)
 S EVDATE=$P(RGRSEVN,HL("FS"),3)
 S EVDATE=$$FMDATE^HLFNC(EVDATE)
 ;
 ; HL("SFN") expected in one of the following formats:
 ; station # -or- station #~domain
 ;
 Q $G(RECDATE)_"^"_$G(EVDATE)_"^"_$G(HL("SFN"))
