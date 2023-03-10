TIU341P ;SPFO/AJB - Environment Check & Post Install ;Jul 14, 2021@07:11:36
 ;;1.0;TEXT INTEGRATION UTILITIES;**341**;Jun 20, 1997;Build 23
 ;
 Q
 ;
POST ; clean up object(s) from previous installs & create new objects
 ; clean & rename object(s) if necessary
 N OBJECT,RES,X,Y F OBJECT="PULSE OXIMETRY","VA-WH EXPECTED DUE DATE" D
 . N IEN,METHOD
 . S IEN=0 F  S IEN=$O(^TIU(8925.1,"B",OBJECT,IEN)) Q:'+IEN  D
 . . I $P(^TIU(8925.1,IEN,0),U,4)'="O" Q  ; not an object
 . . S METHOD=$S(OBJECT="PULSE OXIMETRY":"S X=$$PO2^TIULO(+$G(DFN))",1:"S X=$$GETEDD^WVRPCPT(DFN)")
 . . N NODE9 S NODE9=$G(^TIU(8925.1,IEN,9))
 . . I METHOD=NODE9 D  Q
 . . . N DA,DIK S DA=IEN,DIK="^TIU(8925.1," D ^DIK ; remove object with same method
 . . ; different method, make a copy then remove
 . . N NODE0 S NODE0=$G(^TIU(8925.1,IEN,0)) I +$P(NODE0,U,5) N POWNER S POWNER=$P(NODE0,U,5)
 . . ; create a copy, increment copy until successful
 . . N COPY F COPY=1:1 S RES=$$CROBJ^TIUCROBJ($P(NODE0,U)_" COPY ("_COPY_")","","",NODE9,$G(POWNER)) Q:+RES
 . . N DA,DIK S DA=IEN,DIK="^TIU(8925.1," D ^DIK ; remove original
 ; install objects
 F X=1:1 S Y=$P($T(OBJECTS+X),";;",2) Q:Y=""  D
 . S RES=$$CROBJ^TIUCROBJ($P(Y,U),$P(Y,U,2),$P(Y,U,3),$P(Y,";",2))
 . I '+RES D BMES^XPDUTL(RES) S XPDABORT=2 Q
 . D BMES^XPDUTL($P(Y,U)_" object created successfully.")
 Q
 ;
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ;
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN))
 ;
OBJECTS ;
 ;;PULSE OXIMETRY^POX^^;S X=$$PO2^TIULO(+$G(DFN))
 ;;VA-WH EXPECTED DUE DATE^EDD^EXPECTED DUE DATE^;S X=$$GETEDD^WVRPCPT(DFN)
 Q
