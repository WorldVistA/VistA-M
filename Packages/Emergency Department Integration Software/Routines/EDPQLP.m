EDPQLP ;SLC/KCM - Log Entry Patients
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
GET(AREA,TOKEN) ; Return lists for edit context
 ;
 ; don't rebuild the list if it is unchanged
 ;I $G(^EDPB(231.9,AREA,230))=TOKEN D  Q
 ;. D XML^EDPX("<logEntries status='same' />")
 ;
 ; build sequence based on bed sequence
 N IEN,X0,NAME,SSN,LAST4,BED,SEQ,DUP,LST,DFN
 D BLDDUP(.DUP,AREA)
 S IEN=0 F  S IEN=$O(^EDP(230,"AC",EDPSITE,AREA,IEN)) Q:'IEN  D
 . S X0=^EDP(230,IEN,0)
 . S NAME=$P(X0,U,4),LAST4=$P(X0,U,11),DFN=$P(X0,U,6)
 . S SSN="" I DFN S SSN=$P(^DPT(DFN,0),U,9)
 . S BED=$P($G(^EDP(230,IEN,3)),U,4)
 . S SEQ=0
 . I BED S SEQ=$P($G(^EDPB(231.8,BED,0)),U,5)
 . I 'SEQ S SEQ=999999
 . I BED S BED=$P(^EDPB(231.8,BED,0),U,6)
 . S LST(SEQ,IEN)=NAME_U_SSN_U_LAST4_U_BED_U_$$SIM(NAME,LAST4,.DUP)
 ;
 D XML^EDPX("<logEntries status='new' token='"_$G(^EDPB(231.9,AREA,230))_"' >")
 S SEQ=0 F  S SEQ=$O(LST(SEQ)) Q:'SEQ  D
 . S IEN=0 F  S IEN=$O(LST(SEQ,IEN)) Q:'IEN  D
 . . S X("id")=IEN
 . . S X("seq")=SEQ
 . . S X("name")=$P(LST(SEQ,IEN),U)
 . . S X("ssn")=$P(LST(SEQ,IEN),U,2)
 . . S X("last4")=$P(LST(SEQ,IEN),U,3)
 . . S X("bed")=$P(LST(SEQ,IEN),U,4)
 . . S X("same")=$P(LST(SEQ,IEN),U,5)
 . . D XML^EDPX($$XMLA^EDPX("log",.X))
 D XML^EDPX("</logEntries>")
 Q
BLDDUP(DUP,AREA) ; Build duplicate name/last4 counters
 ; called from GET^EDPQLP, GET^EDPQDB -- expect EDPSITE
 N X,IEN,CNT
 S X="" F  S X=$O(^EDP(230,"ADUP",EDPSITE,AREA,X)) Q:X=""  D
 . S IEN=0,CNT=0
 . F  S IEN=$O(^EDP(230,"ADUP",EDPSITE,AREA,X,IEN)) Q:'IEN  S CNT=CNT+1
 . S DUP(X)=CNT
 Q
SIM(NAME,LAST4,DUP) ; Return true if similar patient name/last4
 I $L(LAST4),$G(DUP(LAST4))>1 Q 1
 I $L(NAME),$G(DUP($P(NAME,",")))>1 Q 1
 Q 0
 ;
CLOSED(AREA,PARTIAL) ; find matches on name
 S PARTIAL=$$UP^XLFSTR(PARTIAL)
 Q:PARTIAL=""
 ;
 I PARTIAL?1U4N D BS5(PARTIAL) G XCLOSED
 I PARTIAL?9N.1U D SSN(PARTIAL) G XCLOSED
 I PARTIAL?1.2N1"/"1.2N1"/"2.4N D DAY(PARTIAL) G XCLOSED
 I PARTIAL?1"T"1"-"1.4N D DAY(PARTIAL) G XCLOSED
 I (PARTIAL="TODAY") D DAY(PARTIAL) ; fall thru LNAM in case TODAY is a name
 D LNAM(PARTIAL)
 ;
XCLOSED ; exit case statement
 Q
 ;
BS5(X) ; find matches by last inital, last 4
 N DFN,IEN
 S DFN=0 F  S DFN=$O(^DPT("BS5",X,DFN)) Q:'DFN  D
 . S IEN=0 F  S IEN=$O(^EDP(230,"PDFN",EDPSITE,AREA,DFN,IEN)) Q:'IEN  D ADDVST(IEN)
 Q
SSN(X) ; find matches by SSN
 N DFN,IEN
 S DFN=0 F  S DFN=$O(^DPT("SSN",X,DFN)) Q:'DFN  D
 . S IEN=0 F  S IEN=$O(^EDP(230,"PDFN",EDPSITE,AREA,DFN,IEN)) Q:'IEN  D ADDVST(IEN)
 Q
DAY(X) ; find matches by DATE
 N %DT,Y,DTOUT,END,INTS
 D ^%DT
 S INTS=$P(Y,"."),END=INTS_".999999"
 Q:INTS'>0
 F  S INTS=$O(^EDP(230,"ATI",EDPSITE,INTS)) Q:'INTS  Q:INTS>END  D
 . S IEN=0 F  S IEN=$O(^EDP(230,"ATI",EDPSITE,INTS,IEN)) Q:'IEN  D
 . . Q:$P(^EDP(230,IEN,0),U,3)'=AREA
 . . D ADDVST(IEN)
 Q
LNAM(PARTIAL) ; find matches by name
 N IEN,NAME,X,X0
 S NAME=$O(^EDP(230,"PN",EDPSITE,AREA,PARTIAL),-1)
 F  S NAME=$O(^EDP(230,"PN",EDPSITE,AREA,NAME)) Q:$E(NAME,1,$L(PARTIAL))'=PARTIAL  Q:NAME=""  D
 . S IEN=0 F  S IEN=$O(^EDP(230,"PN",EDPSITE,AREA,NAME,IEN)) Q:'IEN  D ADDVST(IEN)
 Q
ADDVST(IEN) ; add node for visit
 N X0,X,NAME
 S X0=^EDP(230,IEN,0),NAME=$P(X0,U,4)
 I '$P(X0,U,7) Q  ; not closed
 S X("id")=IEN,X("name")=NAME,X("inTS")=$P(X0,U,8)
 D XML^EDPX($$XMLA^EDPX("visit",.X))
 Q
