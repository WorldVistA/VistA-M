GMTSP55 ; CIO/SLC - Post Install GMTS*2.7*55    ; 04/30/2002
 ;;2.7;Health Summary;**55**;Oct 20, 1995
 ;                 
 ; External References
 ;   DBIA   122  ^VA(200,  (ending DBIA 122)
 ;   DBIA   122  ^DD(200,  (ending DBIA 122)
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10089  ^%ZISC
 ;                 
 Q
POST ; Post Install
 D HOME^%ZIS N GMTST,DIC,DIR,POP,X,Y,%,%ZIS,IOP,ZTRTN,ZTSAVE,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="NEWP^GMTSP55",ZTDESC="Running GMTS*2.7*55 Post-Install"
 S ZTIO="",ZTDTH=$H,GMTST=" GMTS*2.7*55 Post-Install"
 D ^%ZTLOAD,^%ZISC
 Q
NEWP ; Fix New Person file #200
 S:$D(ZTQUEUED) ZTREQ="@" Q:$D(^DD(200,"GL",100.1))  
 N GMTSI S GMTSI=0 F  S GMTSI=$O(^VA(200,GMTSI)) Q:+GMTSI=0  K ^VA(200,GMTSI,100.1)
 Q
