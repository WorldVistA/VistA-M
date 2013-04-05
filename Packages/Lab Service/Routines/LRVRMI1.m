LRVRMI1 ;DALOI/STAFF - LAB MICRO HL7 INTERFACE ;Oct 29, 2008
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Extraction routine for the HL7 to Micro interface.  It processes incoming HL7I data by extracting the results
 ; data from the ^LAH global and storing that data into a "workbench" (^TMP("LRMI").  The workbench has the same structure
 ; as the Lab Data micro file (#63.05).  The first step in the process copies the instance of the Lab Data file in question
 ; into the Workbench.
 ; 
 Q
 ;
EN ;
 ; First work through the LAH global to find entries to extract
 N PARA,PFLG,IEN,LROLD,LRNEW,LRSTATUS,LRSTORE,LWL,LRX
 ; Check to see if a lab area exists
 K ^TMP("LRMI",$J),^TMP("LRPL",$J)
 ;
 I '$G(LRLL) D  Q
 . W !,"No Load/Work List has been identified"
 . S LREND=1
 ;
 S LWL=LRLL
 ;
 D SRCHEN
 S IEN=$O(^LAH(LWL,1,ISQN,"MI",99,""),-1)
 I IEN S ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,99)=^LAH(LWL,1,ISQN,"MI",99,IEN,0)
 D SETSTATS(.LRSTATUS)
 Q
 ;
 ;
SRCHEN ; This begins the search of LAH for new data
 N EOL,FID,ICN,LRIEN,LRNOW,LRTDFN,LRUID,ORCDT,ORDNLT,ORDP,PEB,PVB,SID
 ;
 S ISQN=LRISQN,LRLEDI=1,LRNOW=$$NOW^XLFDT
 I $P(^LRO(68,$P(^LAH(LWL,1,ISQN,0),U,3),0),U,2)'="MI" Q
 D HEAD^LRVRMI2
 D ACCN
 K LRSTATUS
 S ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,0)=^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 ;
 ; gram stain
 I $D(^LAH(LWL,1,ISQN,"MI",2)) D
 . N IEN
 . S IEN=0
 . F  S IEN=$O(^LAH(LWL,1,ISQN,"MI",2,IEN)) Q:IEN<1  D
 . . S LRX=$G(^LAH(LWL,1,ISQN,"MI",2,IEN,0,0))
 . . I $P(LRX,"^",5)'="" D BLDSTAT(11.5,$P(LRX,"^",5))
 . D USERDT^LRVRMI1A(1,$G(LRSTATUS(63.05,11.5)))
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,2)=^LAH(LWL,1,ISQN,"MI",2)
 ;
 ; bacteria
 I $D(^LAH(LWL,1,ISQN,"MI",3)) D
 . N IEN
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3)=^LAH(LWL,1,ISQN,"MI",3)
 . S IEN=0
 . F  S IEN=$O(^LAH(LWL,1,ISQN,"MI",3,IEN)) Q:IEN<1  D
 . . S LRX=$G(^LAH(LWL,1,ISQN,"MI",3,IEN,0,.01,0))
 . . I $P(LRX,"^")'="" D BLDSTAT(11.5,$P(LRX,"^"))
 . D USERDT^LRVRMI1A(1,$G(LRSTATUS(63.05,11.5)))
 ;
 ; bacteria remark
 I $D(^LAH(LWL,1,ISQN,"MI",4)) D
 . S LRX=$G(^LAH(LWL,1,ISQN,"MI",4,0))
 . I $P(LRX,"^",4)'="" D BLDSTAT(11.5,$P(LRX,"^",4))
 . D USERDT^LRVRMI1A(1,$G(LRSTATUS(63.05,11.5)))
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,4)=^LAH(LWL,1,ISQN,"MI",4)
 ;
 ; parasite 
 I $D(^LAH(LWL,1,ISQN,"MI",6)) D
 . N IEN
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,6)=^LAH(LWL,1,ISQN,"MI",6)
 . S IEN=0
 . F  S IEN=$O(^LAH(LWL,1,ISQN,"MI",6,IEN)) Q:IEN<1  D
 . . S LRX=$G(^LAH(LWL,1,ISQN,"MI",6,IEN,0,.01,0))
 . . I $P(LRX,"^")'="" D BLDSTAT(15,$P(LRX,"^"))
 . D USERDT^LRVRMI1A(5,$G(LRSTATUS(63.05,15)))
 ;
 ; parasite remark
 I $D(^LAH(LWL,1,ISQN,"MI",7)) D
 . S LRX=$G(^LAH(LWL,1,ISQN,"MI",7,0))
 . I $P(LRX,"^",4)'="" D BLDSTAT(15,$P(LRX,"^",4))
 . D USERDT^LRVRMI1A(5,$G(LRSTATUS(63.05,15)))
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,7)=^LAH(LWL,1,ISQN,"MI",7)
 ;
 ; mycology date approved
 I $D(^LAH(LWL,1,ISQN,"MI",8)) M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,8)=^LAH(LWL,1,ISQN,"MI",8)
 ;
 ; fungus/yeast
 I $D(^LAH(LWL,1,ISQN,"MI",9)) D
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,9)=^LAH(LWL,1,ISQN,"MI",9)
 . S IEN=0
 . F  S IEN=$O(^LAH(LWL,1,ISQN,"MI",9,IEN)) Q:'IEN  D
 . . S LRX=$G(^LAH(LWL,1,ISQN,"MI",9,IEN,0,.01,0))
 . . I $P(LRX,"^")'="" D BLDSTAT(19,$P(LRX,"^"))
 . D USERDT^LRVRMI1A(8,$G(LRSTATUS(63.05,19)))
 ;
 ; mycology remarks
 I $D(^LAH(LWL,1,ISQN,"MI",10)) D
 . S LRX=$G(^LAH(LWL,1,ISQN,"MI",10,0))
 . I $P(LRX,"^",4)'="" D BLDSTAT(19,$P(LRX,"^",4))
 . D USERDT^LRVRMI1A(8,$G(LRSTATUS(63.05,19)))
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,10)=^LAH(LWL,1,ISQN,"MI",10)
 ;
 ; TB Date approved, etc.
 I $D(^LAH(LWL,1,ISQN,"MI",11)) D
 . N AFS,AFQ
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,11)=^LAH(LWL,1,ISQN,"MI",11)
 . S LRX=$G(^LAH(LWL,1,ISQN,"MI",11,0)),AFS=$P(LRX,"^",3),AFQ=$P(LRX,"^",4)
 . S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,11),U,3)=AFS
 . S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,11),U,4)=AFQ
 . I AFS'="" D
 . . S LRX=$G(^LAH(LWL,1,ISQN,"MI",11,0,.01,0))
 . . I $P(LRX,"^")'="" D BLDSTAT(23,$P(LRX,"^"))
 . I AFQ'="" D
 . . S LRX=$G(^LAH(LWL,1,ISQN,"MI",11,0,.02,0))
 . . I $P(LRX,"^")'="" D BLDSTAT(23,$P(LRX,"^"))
 . D USERDT^LRVRMI1A(11,$G(LRSTATUS(63.05,23)))
 ;
 ; mycobacteria organism
 I $D(^LAH(LWL,1,ISQN,"MI",12)) D
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12)=^LAH(LWL,1,ISQN,"MI",12)
 . S LRIEN=0
 . F  S LRIEN=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRIEN)) Q:'LRIEN  D
 . . S LRX=$G(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRIEN,0,.01,0))
 . . I $P(LRX,"^")'="" D BLDSTAT(23,$P(LRX,"^"))
 . D USERDT^LRVRMI1A(11,$G(LRSTATUS(63.05,23)))
 ;
 ; TB remark
 I $D(^LAH(LWL,1,ISQN,"MI",13)) D
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,13)=^LAH(LWL,1,ISQN,"MI",13)
 . S LRX=$G(^LAH(LWL,1,ISQN,"MI",13,0))
 . I $P(LRX,"^",4)'="" D BLDSTAT(23,$P(LRX,"^",4))
 . D USERDT^LRVRMI1A(11,$G(LRSTATUS(63.05,23)))
 ;
 D SRCHEN2^LRVRMI1A
 Q
 ;
 ;
ACCN ; Get the LRIDT
 S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,5)
 Q
 ;
 ;
MAKEISO(LR4,ISOID) ;
 ; Creates the "unique id" portion for an isolate id
 ; Inputs
 ;    LR4 : File #4 IEN
 ;  ISOID : Isolate ID
 ; Output
 ;    "99VA4:"_#4 info_":"_ISOID
 ;
 N LRNVAF,LRY
 Q:$TR(ISOID," ","")="" ISOID
 I ISOID?1"99VA4:"0.E1":"0.E Q ISOID
 S LRNVAF=$$NVAF^LA7VHLU2(LR4)
 S LRY=$$ID^XUAF4($S(LRNVAF=1:"DMIS",LRNVAF=2:"ASUFAC",1:"VASTANUM"),LR4)
 I LRY="" D
 . S LRY=$$KSP^XUPARAM("INST") ;default institution IEN
 . S LRY=$$NS^XUAF4(LRY)
 . S LRY=$P(LRY,"^",2)
 . S LRY=LRY_"#"_LR4
 Q "99VA4:"_LRY_":"_ISOID
 ;
 ;
BLDSTAT(FLD,VAL) ;
 ; Convenience method
 D BLDSTAT^LRVRMI4A(63.05,FLD,VAL,.LRSTATUS)
 Q
 ;
 ;
SETSTATS(DATA) ;
 ; Goes thru DATA array and sets the status(es)
 ; Inputs
 ;   DATA <byref> : DATA(file#,field#)=status  ie DATA(63.05,19)="P"
 ;
 N NODE,FN,FLD,STAT,DATA2TMP,X,SUB,POS
 S DATA2TMP(63.05,11.5)="1^2" ;SUB^POS
 S DATA2TMP(63.05,15)="5^2"
 S DATA2TMP(63.05,19)="8^2"
 S DATA2TMP(63.05,23)="11^2"
 S DATA2TMP(63.05,34)="16^2"
 S NODE="DATA(0)"
 F  S NODE=$Q(@NODE) Q:NODE=""  D  ;
 . S FN=$QS(NODE,1)
 . S FLD=$QS(NODE,2)
 . S STAT=DATA(FN,FLD)
 . I STAT="C" S STAT="F"
 . S X=$G(DATA2TMP(63.05,FLD))
 . Q:X=""
 . S SUB=$P(X,"^",1),POS=$P(X,"^",2)
 . I SUB,POS S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,SUB),"^",POS)=STAT
 Q
