XU8P387 ;SFISC/SO- POST INSTALL CLEAN UP XREF AUSER ;5:41 AM  30 Nov 2005
 ;;8.0;KERNEL;**384**;Jul 10, 1995;Build 8
 ;
 D ^XU8P387X ;Install the fixed xref
 ;
 ;Clean up AUSER xref
 ;
 N IEN S IEN=0
 N XUDT540 S XUDT540=$$HTFM^XLFDT($H-540,1)
 F  S IEN=$O(^VA(200,IEN)) Q:'IEN  D
 . I IEN<1 Q
 . N DIK,DA
 . S DA=IEN
 . S DIK="^VA(200,",DIK(1)=".01^AUSER"
 . D EN1^DIK
 . ;
 . ;Check to see if DISUERed, But last sign-on is within 540 days
 . I '$D(^VA(200,IEN,0))#2 Q  ;Missing Zeroth node
 . N NAME,LDATE,DISUER
 . S NAME=$P(^VA(200,IEN,0),U)
 . I NAME="" Q  ; Entry has null .01 field
 . S LDATE=$P($G(^VA(200,IEN,1.1)),U) ;Get last sign-on
 . S DISUSER=$P(^VA(200,IEN,0),U,7) ;DISUER FLAG
 . I $D(^VA(200,"AUSER",NAME,IEN)) Q  ;Entry already indexed
 . I $D(^XUSEC("XUORES",IEN)) S ^VA(200,"AUSER",NAME,IEN)="" Q
 . I DISUSER,LDATE'<XUDT540,DISUSER S ^VA(200,"AUSER",NAME,IEN)=""
 . Q
 Q
