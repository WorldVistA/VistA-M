XU8P344 ;SFISC/SO- POST INSTALL ;7:01 AM  8 Jun 2005
 ;;8.0;KERNEL;**344**;Jul 10, 1995
 D P1
 D P2
 D P3
 Q
 ;
P1 ; Loop thru New Person file and change field #12.3 to 6/_year
 ; Then try and determine Training Facility
 D MES^XPDUTL("Begin Updating...")
 N IEN S IEN=0
 F  S IEN=$O(^VA(200,IEN)) Q:'IEN  I +$$GET1^DIQ(200,IEN_",",12.2,"I","","ZERR") D  ; Update record If And Only If 'Program Of Study'
 . N LASTYR S LASTYR=""
 . N DIVISION S DIVISION=0
 . N DNLT S DNLT=""
 . N YN S YN=""
 . ;
 . D  ; Last Training Month & Year
 .. N DIERR,Z,ZERR
 .. S LASTYR=$$GET1^DIQ(200,IEN_",",12.3,"I","Z","ZERR")
 .. I LASTYR'="",LASTYR'["/" D
 ... I $L(LASTYR)=5 S LASTYR=$E(LASTYR)_"/"_$E(LASTYR,2,5)
 ... I $L(LASTYR)=6 S LASTYR=$E(LASTYR,1,2)_"/"_$E(LASTYR,3,6)
 .. I LASTYR'="",LASTYR["/" D
 ... I $L(LASTYR,"/")=1 S LASTYR="6/"_LASTYR Q
 ... S LASTYR=$P(LASTYR,"/")_"/"_$P(LASTYR,"/",$L(LASTYR,"/")) Q
 ... Q
 .. Q
 . ;
 . D  ; VHA Training Facility
 .. N DIERR,Z,ZERR
 .. S DIVISION=+$$GET1^DIQ(200,IEN,12.4,"I","Z","ZERR")
 .. I DIVISION,$$SCRN4^XUOAAUTL(DIVISION) Q  ;VHA TRAINING FACILITY DEFINED
 .. I DIVISION S DIVISION=0 ;FAILED ABOVE CHECK
 .. D GETS^DIQ(200,IEN,"16*","I","Z","ZERR") ;Get Division multiple
 .. N DIEN S DIEN=""
 .. F  S DIEN=$O(Z(200.02,DIEN)) Q:DIEN=""  D
 ... I $G(Z(200.02,DIEN,1,"I")) S DIVISION=$G(Z(200.02,DIEN,.01,"I")) S DIVISION=$S($$SCRN4^XUOAAUTL(DIVISION):DIVISION,1:0) Q
 ... Q
 .. I 'DIVISION S DIVISION=$P($$NS^XUAF4($$KSP^XUPARAM("INST")),U,2),DIVISION=$$LKUP^XUAF4(DIVISION)
 .. Q
 . ;
 . D  ; Use Termination Date if necessary
 .. N DIERR,Z,ZERR
 .. S DNLT=$$GET1^DIQ(200,IEN_",",12.7,"I","Z","ZERR")
 .. I DNLT'="" S:DNLT'<DT DNLT="" Q  ;Date established and Not in the future
 .. S DNLT=$$GET1^DIQ(200,IEN_",",9.2,"I","Z","ZERR")
 .. S:DNLT'<DT DNLT="" ;Reset if a Future termination date
 .. Q
 . ;
 . D  ; Update Record
 .. N DIERR,FDA,ZERR
 .. S FDA(200,IEN_",",12.3)=LASTYR
 .. S FDA(200,IEN_",",12.4)=DIVISION
 .. S FDA(200,IEN_",",12.6)=$S(DNLT'="":"N",1:"Y")
 .. S FDA(200,IEN_",",12.7)=DNLT
 .. D FILE^DIE("I","FDA","ZERR")
 .. Q
 . Q
 D MES^XPDUTL("Finished updates.")
 Q
 ;
P2 ; Transmitt Data to OAA database
 I $E($G(XPDQUES("POS1")))="P" D  Q
 . ;Let's be sure eveone is accounted for
 . D MES^XPDUTL("Reindexing ""ATR"" cross reference...")
 . N DIK
 . S DIK="^VA(200,"
 . S DIK(1)="12.2^ATR"
 . D ENALL^DIK
 . D MES^XPDUTL("Done reindexing ""ATR"" cross reference.")
 . ;
 . D MES^XPDUTL("Begin transmission of OAA data...")
 . D OAA^XUOAAHL7
 . D MES^XPDUTL("Done with transmission of OAA data.")
 . Q
 D MES^XPDUTL("Non-production account.  No transmission of OAA data will take place.") K ^VA(200,"ATR") Q
 Q
 ;
P3 ; Change Rescheduling Frequency for XUOAA SEND HL7 MESSAGE to '1D'
 I $E($G(XPDQUES("POS1")))="P" D  Q
 . N DIERR,Z,ZERR
 . D FIND^DIC(19.2,"","@;.01","P","XUOAA SEND HL7 MESSAGE","","","","","Z","ZERR")
 . I $D(DIERR) D MES^XPDUTL("Can not find option ""XUOAA SEND HL7 MESSAGE"" in OPTION SCHEDULING(#19.2) file.") Q
 . I +Z("DILIST",0)>1 D MES^XPDUTL("More than one ""XUOAA SEND HL7 MESSAGE"" scheduled.  Can not reschedule.") Q
 . N IEN,FDA
 . S IEN=+Z("DILIST",1,0)_","
 . S FDA(19.2,IEN,6)="1D"
 . D FILE^DIE("E","FDA","ZERR")
 Q
