LRUCSR ;DALOI/JMC - Code System Reference Utility ;11/24/09  15:21
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
 ;
SETREF(LRDFN,LRREF,LRDATA,LRACTION) ; Set reference to code system in file #63
 ; Call with LRDFN = File #63 IEN
 ;           LRREF = value of #.01 field in format LRDFN,LRSS,LRIDT,0 or other ending reference
 ;                   e.g. "123,SP,6919594.8946,0"
 ;                   e.g. "123,SP,6919594.8946,1;5" - 5th piece of 1 node
 ;                   if reference to other file then use format LRDFN,file #,other ending reference.
 ;                   e.g. "123,69,LRODT,LRSN,0"
 ;                   e.g. "123,68,LRAA,LRAD,LRAN,0"
 ;          LRDATA = array with data to store i.e LRDATA(field #)=value
 ;        LRACTION = 1-update if exists otherwise add
 ;                   2-always add
 ;
 N LRROLE,LRCODEID,LRCODESYSTEM
 ;
 I $G(LRREF)="" Q
 ;
 ; Determine role for this code.
 S LRROLE=$G(LRDATA(.02))
 I LRROLE<1 Q
 ;
 ; Determine what code system this code id is from.
 S LRCODESYSTEM=$G(LRDATA(.04))
 I LRCODESYSTEM="" Q
 ;
 S LRACTION=$G(LRACTION)
 I LRACTION<1 S LRACTION=1
 ;
 S LRCODEID=$G(LRDATA(.03))
 I LRCODEID="" Q
 ;
 ; Update existing entry for this role and code system
 I LRACTION=1,$D(^LR(LRDFN,"CSR","AE",LRREF,LRROLE,LRCODESYSTEM)) D UEE Q
 ;
 ; Create new entry
 D CNE
 ;
 Q
 ;
 ;
UEE ; Update existing entry
 ;
 N LRDIE,LRFDA,LRIEN
 ;
 ;ZEXCEPT: LRCODEID,LRCODESYSTEM,LRDATA,LRDFN,LRREF,LRROLE
 ;
 S LRIEN=$O(^LR(LRDFN,"CSR","AE",LRREF,LRROLE,LRCODESYSTEM,LRCODEID,0))
 ;
 I LRDATA(.01)'="",LRDATA(.01)'=LRREF S LRFDA(1,63.00014,LRIEN_","_LRDFN_",",.01)=LRDATA(.01)
 ;
 S LRFDA(1,63.00014,LRIEN_","_LRDFN_",",.02)=LRDATA(.02)
 S LRFDA(1,63.00014,LRIEN_","_LRDFN_",",.03)=LRDATA(.03)
 S LRFDA(1,63.00014,LRIEN_","_LRDFN_",",.035)=$G(LRDATA(.035))
 S LRFDA(1,63.00014,LRIEN_","_LRDFN_",",.04)=LRDATA(.04)
 S LRFDA(1,63.00014,LRIEN_","_LRDFN_",",.05)=$G(LRDATA(.05))
 S LRFDA(1,63.00014,LRIEN_","_LRDFN_",",.06)=$G(LRDATA(.06))
 ;
 D FILE^DIE("","LRFDA(1)","LRDIE(1)")
 Q
 ;
 ;
CNE ; Create new entry
 ;
 N LRDIE,LRFDA,LRIEN
 ;
 ;ZEXCEPT: LRDATA,LRDFN
 ;
 S LRFDA(1,63.00014,"+1,"_LRDFN_",",.01)=LRDATA(.01)
 S LRFDA(1,63.00014,"+1,"_LRDFN_",",.02)=LRDATA(.02)
 S LRFDA(1,63.00014,"+1,"_LRDFN_",",.03)=LRDATA(.03)
 I $G(LRDATA(.035))'="" S LRFDA(1,63.00014,"+1,"_LRDFN_",",.035)=LRDATA(.035)
 S LRFDA(1,63.00014,"+1,"_LRDFN_",",.04)=LRDATA(.04)
 I $G(LRDATA(.05))'="" S LRFDA(1,63.00014,"+1,"_LRDFN_",",.05)=LRDATA(.05)
 I $G(LRDATA(.06))'="" S LRFDA(1,63.00014,"+1,"_LRDFN_",",.06)=LRDATA(.06)
 ;
 D UPDATE^DIE("","LRFDA(1)","LRIEN","LRDIE(1)")
 Q
 ;
 ;
DEE(LRIENS) ; Delete existing entry
 ; Call with LRIENS = File #63 code system reference IENS
 ;
 N LRDIE,LRFDA
 ;
 S LRFDA(1,63.00014,LRIENS,.01)="@"
 D FILE^DIE("","LRFDA(1)","LRDIE(1)")
 Q
 ;
 ;
GETDATA(LRDATA,LRIENS) ; Retrieve information for a specific entry
 ; Call with LRDATA = array to return data, pass by reference
 ;          LRRIENS = File #63 code system reference IENS
 ;
 ; Returns data in standard FileMan DBS structure - See FileMan DBS documentation
 ;
 D GETS^DIQ(63.00014,LRIENS,"**","I","LRDATA")
 Q
 ;
 ;
GETALL(LRDATA,LRDFN,LRREF,LRROLE) ; Retrieve information for all entries related to a specific reference/role
 ; Call with LRDATA = array to return data, pass by reference
 ;            LRDFN = File #63 IEN
 ;            LRREF = value of #.01 field in format LRDFN,LRSS,LRIDT,0 or other ending reference
 ;                    e.g. "123,SP,6919594.8946,0"
 ;                    if reference to other file then use format LRDFN,file #,other ending reference.
 ;                    e.g. "123,69,LRODT,LRSN,0"
 ;                    e.g. "123,68,LRAA,LRAD,LRAN,0"
 ;           LRROLE = code system role
 ;
 ; Returns data in standard FileMan DBS structure - See FileMan DBS documentation
 ;
 N LRIEN,LRIENS
 ;
 S LRIEN=0
 F  S LRIEN=$O(^LR(LRDFN,"CSR","AD",LRREF,LRROLE,LRIEN)) Q:'LRIEN  D
 . S LRIENS=LRIEN_","_LRDFN_","
 . D GETS^DIQ(63.00014,LRIENS,"**","I","LRDATA")
 Q
