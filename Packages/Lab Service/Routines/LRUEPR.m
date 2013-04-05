LRUEPR ;DALOI/JMC - External Package Reference Utility ;10/18/10  16:43
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Reference to SURGERY file (#130) supported by ICR #5268
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
 ;
SETREF(LRDFN,LRREF,LRDATA,LRACTION) ; Set reference to external package in file #63
 ; Call with LRDFN = File #63 IEN
 ;           LRREF = value of #.01 field in format LRDFN,LRSS,LRIDT,0 or other ending reference
 ;                   e.g. "123,SP,6919594.8946,0"
 ;                   if reference to other file then use format LRDFN,file #,other ending reference.
 ;                   e.g. "123,69,LRODT,LRSN,0"
 ;                   e.g. "123,68,LRAA,LRAD,LRAN,0"
 ;          LRDATA = array with data to store
 ;        LRACTION = 1-update if exists otherwise add
 ;                   2-always add
 ;
 N LRTYPE
 ;
 I $G(LRREF)="" Q
 ;
 S LRTYPE=$G(LRDATA(.02))
 I LRTYPE<1 Q
 ;
 S LRACTION=$G(LRACTION)
 I LRACTION<1 S LRACTION=1
 ;
 ; Update existing entry for this type
 I LRACTION=1,$D(^LR(LRDFN,"EPR","AD",LRREF,LRTYPE)) D UEE Q
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
 ;ZEXCEPT: LRDATA,LRDFN,LRREF,LRTYPE
 ;
 S LRIEN=$O(^LR(LRDFN,"EPR","AD",LRREF,LRTYPE,0))
 I LRDATA(.01)'="",LRDATA(.01)'=LRREF S LRFDA(1,63.00013,LRIEN_","_LRDFN_",",.01)=LRDATA(.01)
 S LRFDA(1,63.00013,LRIEN_","_LRDFN_",",.02)=LRDATA(.02)
 I $G(LRDATA(.03)) S LRFDA(1,63.00013,LRIEN_","_LRDFN_",",.03)=LRDATA(.03)
 I $G(LRDATA(1))'="" S LRFDA(1,63.00013,LRIEN_","_LRDFN_",",1)=LRDATA(1)
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
 S LRFDA(1,63.00013,"+1,"_LRDFN_",",.01)=LRDATA(.01)
 S LRFDA(1,63.00013,"+1,"_LRDFN_",",.02)=LRDATA(.02)
 I $G(LRDATA(.03)) S LRFDA(1,63.00013,"+1,"_LRDFN_",",.03)=LRDATA(.03)
 I $G(LRDATA(1))'="" S LRFDA(1,63.00013,"+1,"_LRDFN_",",1)=LRDATA(1)
 D UPDATE^DIE("","LRFDA(1)","LRIEN","LRDIE(1)")
 Q
 ;
 ;
DEE(LRIENS) ; Delete existing entry
 ; Call with LRRIENS = File #63 external package reference IENS
 ;
 N LRDIE,LRFDA
 S LRFDA(1,63.00013,LRIENS,.01)="@"
 D FILE^DIE("","LRFDA(1)","LRDIE(1)")
 Q
 ;
 ;
GETDATA(LRDATA,LRIENS) ; Retrieve information for a specific entry
 ; Call with LRDATA = array to return data, pass by reference
 ;          LRRIENS = File #63 external package reference IENS
 ;
 D GETS^DIQ(63.00013,LRIENS,"**","I","LRDATA")
 Q
 ;
 ;
SRCASE(LRDATA,LRSRTN) ; Retrieve related surgeon/attending for a surgical case
 ; Call with LRDATA = array to return data, pass by reference
 ;           LRSTRN = ien of case in SURGERY file #130
 ;
 N LRERR
 D GETS^DIQ(130,LRSRTN_",",".14;.164;123;124","I","LRDATA","LRERR")
 ;
 I $D(LRERR) D
 . I $G(LRERR("DIERR",1))=601 S LRDATA("ERR")="601^Related Surgical Case #"_LRSRTN_" has been removed from SURGERY package"
 . E  S LRDATA("ERR")=LRERR("DIERR",1)_"^"_LRERR("DIERR",1,"TEXT",1)
 ;
 Q
 ;
 ;
SRCASERR(LRREF,LRCDATA,LRERRMSG) ; Log/update surgical case ref when error occurs on retrieval.
 ; Call with LRREF = value of #.01 field in format LRDFN,LRSS,LRIDT,0 or other ending reference
 ;                   e.g. "123,SP,6919594.8946,0"
 ;
 ;         LRCDATA = current data on file
 ;        LRERRMSG = error message to add to current data
 ;
 N LRDATA
 ;
 ; If current data already contains error message then quit.
 I LRCDATA[LRERRMSG Q
 ;
 S LRDATA(.01)=LRREF
 S LRDATA(.02)=1
 S LRDATA(1)=LRCDATA_";"_LRERRMSG
 D SETREF^LRUEPR($P(LRREF,","),LRREF,.LRDATA,1)
 ;
 Q
