ORRHCT ; SLC/KCM - CPRS Query Tools - TIU ; [4/4/02 2:07pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**153**;Dec 17, 1997
 ;
NXT() ; Increment ILST
 S ILST=ILST+1
 Q ILST
 ;
DOCSTS(LST)     ; List document statuses
 N ILST,X,IEN S ILST=0
 S X="" F  S X=$O(^TIU(8925.6,"B",X)) Q:X=""  D
 . S IEN=0 F  S IEN=$O(^TIU(8925.6,"B",X,IEN)) Q:'IEN  D
 . . S LST($$NXT)=IEN_U_X
 Q
DOCCLS(Y)       ; Return a list of document classes
 ;  NEED TO GET A TIU RPC
 N IEN,I,X,IDX
 S IEN=$O(^TIU(8925.1,"B","CLINICAL DOCUMENTS",0)),I=0,IDX=0
 F  S I=$O(^TIU(8925.1,IEN,10,I)) Q:'I  D
 . S X=^TIU(8925.1,IEN,10,I,0)
 . Q:$P(X,U,4)="Addendum"
 . S IDX=IDX+1,Y(IDX)=$P(X,U,1)_U_$P(X,U,4)
 Q
