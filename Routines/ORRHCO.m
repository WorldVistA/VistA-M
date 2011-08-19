ORRHCO ; SLC/KCM - CPRS Query Tools - Orders ; [4/4/02 2:07pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**153,242**;Dec 17, 1997;Build 6
 ;
NXT() ; Increment ILST
 S ILST=ILST+1
 Q ILST
 ;
ORDITM(Y,FROM,DIR,XREF) ; Return a subset of orderable items
 ; .Return Array, Starting Text, Direction, Cross Reference (B or S.x)
 ; ^ORD(101.43,"S.xxx",UpperCase,DA)=Mne^MixedCase^InactvDt^.01IfMne
 ; Y(n)=IEN^.01 Name^.01 Name  -or-  IEN^Synonym <.01 Name>^.01 Name
 ; similar to ORDITM^ORWDX but does not screen inactives
 N I,X,IEN,CNT,SKIP S I=0,CNT=44,SKIP=0
 F  Q:I'<CNT  S FROM=$O(^ORD(101.43,XREF,FROM),DIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^ORD(101.43,XREF,FROM,IEN),DIR) Q:'IEN  D
 . . I XREF="B" D
 . . . I $D(^ORD(101.43,XREF,FROM,IEN))=1 S X=FROM
 . . . E  S X=FROM_"  <"_$P(^ORD(101.43,IEN,0),U,1)_">"
 . . . S I=I+1,Y(I)=IEN_U_X
 . . E  D
 . . . S X=^ORD(101.43,XREF,FROM,IEN)
 . . . I 'X S X=$P(X,U,2)
 . . . E  S X=$P(X,U,2)_"  <"_$P(X,U,4)_">"
 . . . I (XREF="S.CSLT"),($$UP^XLFSTR(X)["ALL SERVICE") Q
 . . . E  S I=I+1,Y(I)=IEN_U_X
 Q
CGRP(ORY) ;Return Consult Display Group
 S ORY="ALL SERVICES"_U_$O(^ORD(100.98,"B","CSLT",0))
 Q
OISETS(LST)     ; Return a list of sets for orderable items
 N DGNM,IEN,SHORT,IDX
 S LST(1)="^(no limit)",IDX=1
 S DGNM="" F  S DGNM=$O(^ORD(100.98,"B",DGNM)) Q:DGNM=""  D
 . S IEN=0 F  S IEN=$O(^ORD(100.98,"B",DGNM,IEN)) Q:'IEN  D
 . . I ^ORD(100.98,"B",DGNM,IEN)=1 Q
 . . S SHORT=$P(^ORD(100.98,IEN,0),U,3)
 . . I $D(^ORD(101.43,"S."_SHORT)) S IDX=IDX+1,LST(IDX)=SHORT_U_DGNM
 Q
ORDSTS(LST)     ; List order statuses
 N ILST,X,IEN S ILST=0
 S X="" F  S X=$O(^ORD(100.01,"B",X)) Q:X=""  D
 . S IEN=0 F  S IEN=$O(^ORD(100.01,"B",X,IEN)) Q:'IEN  D
 . . Q:$$SCREEN^XTID(100.01,,IEN_",")  ;inactive VUID
 . . S LST($$NXT)=IEN_U_X
 Q
SIGNSTS(LST)    ; List order signature statuses
 S LST(1)="0^ON CHART w/written orders"
 S LST(2)="1^ELECTRONIC"
 S LST(3)="2^NOT SIGNED"
 S LST(4)="3^NOT REQUIRED"
 S LST(5)="4^ON CHART w/printed orders"
 S LST(6)="5^NOT REQUIRED due to cancel"
 S LST(7)="6^SERVICE CORRECTION to signed order"
 S LST(8)="7^DIGITALLY SIGNED"
 Q
ABSTRT(Y,NIL) ;Return abnormal result start date
 S Y=$$GET^XPAR("SYS^PKG","ORHEPC ABNORMAL START",1,"I")
 Q
