LRAPALRT ;DALOI/CKA - SEND AN AP ALERT AFTER THE REPORT HAS BEEN RELEASED ;02/14/11  15:30
 ;;5.2;LAB SERVICE;**365,315,350**;Sep 27, 1994;Build 230
 ;
 ;
EN ; Entry point to send/resend an AP alert to additional recipients
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LRA,LRAC,LRADL,LRAU,LRDATA,LRDFN,LRH,LRI,LRIDT,LRJ,LRMSG,LREND,LRMANDO,LRMORE,LRQUIT,LRIENS,LRSF,LRSS,LRXQA,LRZ,XQA,Y
 S LRQUIT=0
 D SECTION^LRAPRES
 I LRQUIT D END Q
 D ACCYR^LRAPRES
 I LRQUIT D END Q
 D LOOKUP^LRAPUTL(.LRDATA,LRH(0),LRO(68),LRSS,LRAD,LRAA)
 I LRDATA<1 S LRQUIT=1
 I LRQUIT D END Q
 ;
 ; CPRS alerts only sent for "patients" related to PATIENT file (#2)
 I $P($G(^LR(LRDFN,0)),"^",2)'=2 D  Q
 . K DIR,DIRUT,DTOUT,DUOUT
 . S DIR(0)="E"
 . S DIR("A",1)="CPRS does not support alerts for non-PATIENT file (#2) patients."
 . S DIR("A")="Press any key to continue"
 . D ^DIR
 ;
 I 'LRAU D
 . S LRDFN=LRDATA,LRI=LRDATA(1)
 . S LRA=^LR(LRDFN,LRSS,LRI,0),LRZ(2)=$P(LRA,"^",11),LRAC=$P(LRA,"^",6)
 . I 'LRZ(2) D
 . . D EN^DDIOL($C(7)_"Report has not been released.  An alert cannot be sent.","","!!")
 . . S LRQUIT=1 Q
 ;
 I LRQUIT D END Q
 ;
 I LRAU D
 . S LRDFN=LRDATA
 . I $G(^LR(LRDFN,"AU"))="" D  Q
 . . D EN^DDIOL("No information found for this accession in the LAB DATA file (#63).","","!!")
 . . S LRQUIT=1 Q
 . S LRZ=$$GET1^DIQ(63,LRDFN_",",14.7,"I")
 . I 'LRZ D
 . . D EN^DDIOL($C(7)_"Report has not been released.  An alert cannot be sent.","","!!")
 . . S LRQUIT=1 Q
 . S LRA=^LR(LRDFN,"AU"),LRI=$P(LRA,U),LRAC=$P(LRA,"^",6)
 I LRQUIT D END Q
 ;
 K DIR
 S DIR(0)="YO",DIR("A")="Include previous mandatory recipients",DIR("B")="YES"
 D ^DIR
 I $D(DIRUT) D END Q
 ;
 S LRMANDO=+Y
 I LRMANDO D
 . N LRC,LRDOCS
 . D GETDOCS^LRAPUTL(.LRDOCS,LRDFN,LRSS,LRIDT,LRSF)
 . S LRC=0
 . F  S LRC=$O(LRDOCS(LRC)) Q:LRC<1  D
 . . I $D(XQA(+LRDOCS(LRC))) S XQA(+LRDOCS(LRC))=XQA(+LRDOCS(LRC))_"/"_$P(LRDOCS(LRC),"^",3) Q
 . . S XQA(+LRDOCS(LRC))=$P(LRDOCS(LRC),"^",3)
 ;
 D MORE^LRAPRES1
 I LRMORE D LOOKUP^LRAPRES1
 ;
 I $D(XQA) D
 . K DIR
 . S LRJ=0 D CHELP^LRAPRES1
 . S DIR(0)="YO",DIR("A")="Send Alert",DIR("B")="YES"
 . D ^DIR
 . I Y=1 S LRI=LRIDT D ALERT^LRAPRES1
 ;
END D END^LRAPRES
 Q
