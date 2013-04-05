LRVRMI5 ;DALOI/STAFF - LAB MICRO LEDI INTERFACE ;Jun 26, 2008
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
SETTMP ; Setup TMP global with accession to resend.
 ;
 N LA763,LA764,LA768,LA7CNT,LA7I,LA7NLT,LA7NLTN,LA7UID,LA7VDB,LA7X,LA7Y,LR60,LR61,X,ZFIL,ZFLD,ZPTR,ZEDTYP
 ;
 S LRSS=$P(^LRO(68,LRAA,0),"^",2)
 F LA7I=0,.2,.3,3 S LA768(LA7I)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,LA7I))
 S LA7UID=$P(LA768(.3),"^")
 ;
 ; Not a LEDI specimen
 ; 
 I '$P($G(LA768(.3)),"^",3) Q
 ;
 ; Check file #63 for order codes and results
 ; If no order NLT code found then use default NLT
 ; Check if test has been added to order then report results using NLT code of the added test.
 ; 
 S LRDFN=$P(LA768(0),"^"),LRODT=$P(LA768(0),"^",4),LRIDT=$P(LA768(3),"^",5)
 ;
 ; Check for date report completed.
 ;
 I '$$OK2SEND^LA7SRR D  Q
 . Q
 . N LA7X
 . S LA7X="No date report completed - Accession "_$P(LA768(.2),"^")_" ("_LA7UID_") skipped"
 . D EN^DDIOL(LA7X,"","!")
 ;
 K ^TMP("LA7S-RTM",$J)
 ;
 I LRSS="MI" D
 . S LR60=0
 . F  S LR60=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR60)) Q:'LR60  D
 . . S LA764=$P($G(^LAB(60,LR60,64)),"^")
 . . S LA7NLT=$$GET1^DIQ(64,LA764_",",1)
 . . S LRDB=$$GET1^DIQ(64,LA764_",",63)
 . . I LA7NLT'="" D
 . . . S LA7Y(LA7NLT)=""
 . . . I LRDB'="" S LA7Y(LA7NLT,LRDB)=""
 ;
 I LA7UID'="",$D(LA7Y) D
 . S LA7CNT=$G(LA7CNT)+1
 . S X=$P(LA768(.3),"^",1)_"^"_$P(LA768(.3),"^",2)_"^"_$P(LA768(.3),"^",5)_"^"_$P(LA768(.3),"^",3)_"^"_LRIDT_"^"_LRSS_"^"_LRDFN_"^"_LRODT
 . S ^TMP("LA7S-RTM",$J,LA7UID)=X
 . S LA7I=""
 . F  S LA7I=$O(LA7Y(LA7I)) Q:LA7I=""  M ^TMP("LA7S-RTM",$J,LA7UID,LA7I)=LA7Y(LA7I)
 S LA7CNT=0,LA7UID=""
 F  S LA7UID=$O(^TMP("LA7S-RTM",$J,LA7UID)) Q:LA7UID=""  D
 . K LA7X
 . S LA7X=^TMP("LA7S-RTM",$J,LA7UID)
 . S LA7NLT="",LA7CNT=LA7CNT+1
 . F  S LA7NLT=$O(^TMP("LA7S-RTM",$J,LA7UID,LA7NLT)) Q:LA7NLT=""  D
 . . S LA764=$$FIND1^DIC(64,"","MX",LA7NLT,"C")
 . . I 'LA764 Q
 . . S LA7NLTN=$$GET1^DIQ(64,LA764_",",.01)
 . . K LA7Y
 . . M LA7Y=^TMP("LA7S-RTM",$J,LA7UID,LA7NLT)
 . . ;
 . . ; Now send the message to LEDI for transmission to remote site
 . . ;  
 . . S ZPTR=0
 . . ;
 . . ; this is the TYPE: 1=NORMAL, 2=SUPPLEMENTAL, 3=CORRECTED
 . . S ZEDTYP=""
 . . S ZEDTYP=$O(^LR(LRDFN,"MI",LRIDT,32,ZEDTYP))
 . . S:$G(ZEDTYP) ZEDTYP=$P($G(^LR(LRDFN,"MI",LRIDT,32,ZEDTYP)),"^",4)
 . . ;
 . . I ZEDTYP=3 S LA7VDB(LA7NLT,ZPTR)="C"
 . . I 'ZEDTYP S LA7VDB(LA7NLT,ZPTR)=""
 . . D SET^LA7VMSG($P(LA7X,"^"),$P(LA7X,"^",2),$P(LA7X,"^",3),$P(LA7X,"^",4),LA7NLTN,LA7NLT,$P(LA7X,"^",5),$P(LA7X,"^",6),$P(LA7X,"^",7),$P(LA7X,"^",8),.LA7VDB,"ORU")
 ;
 K ^TMP("LA7S-RTM",$J)
 ;
 Q
 ;
 ;
 ;============================================================
 ;
 ;    DELETE EXTANT COMMENTS FROM SUBFILE
 ;   
 ;============================================================   
 ;
CLRCMNT(LRNDE,LRFIL) ;
 N LRFDA,LRIED,LRMSG
 S LRIEN=LRNO_","_LRIDT_","_LRDFN_","
 S LRFDA(LRNODE,LRFILE,LRIEN,.01)="@"
 D FILE^DIE("","LRFDA(LRNODE)","LRMSG")
 Q
