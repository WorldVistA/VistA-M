ISIIMPU3 ;ISI GROUP/MLS -- Data Import Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
CHNGNAME(DFN,NAME)
 ;Additonal utility for patient import called by ISIIMP03
 N MSG,FDA,tempFILE,tempFIELD,tempDFN
 K FDA
 S tempDFN=DFN
 S tempFILE="2"
 S tempFIELD=".01"
 S FDA(tempFILE,DFN_",",tempFIELD)=NAME
 D FILE^DIE("K","FDA","MSG")
 I $D(MSG) Q "-1^"_MSG
 Q 1
 ;
ADDALIAS(DFN,ALIAS)     
 ;Additonal utility for patient import called by ISIIMP03
 N MSG,FDA,tempFILE,tempFIELD,tempDFN
 k FDA
 S tempDFN=DFN
 s tempFILE="2"
 s tempFIELD=".01"
 s FDA(42,2.01,"+1,"_tempIEN_",",.01)=ALIAS
 d UPDATE^DIE("","FDA(42)","","MSG")
 I $D(MSG) Q "-1^"_MSG
 Q 1
 ;
CHNGUSER(IEN,NAME)
 ;Additonal utility for User import called by ISIIMP22
 N MSG,FDA,tempFILE,tempFIELD
 Q:'$D(^VA(200,IEN,0))
 K FDA
 S tempFILE="200"
 S tempFIELD=".01"
 S FDA(tempFILE,IEN_",",tempFIELD)=NAME
 D FILE^DIE("K","FDA","MSG")
 I $D(MSG) Q "-1^"_MSG
 Q 1
 
