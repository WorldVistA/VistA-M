EDPFPTL ;SLC/KCM - Select Patient at Facility
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
MATCH(MATCH) ; return XML of matching patients
 S MATCH=$$UP^XLFSTR(MATCH)
 Q:MATCH=""
 ;
 S:+MATCH MATCH=$TR(MATCH,"-","")
 ;
 N LST S LST=0
 N LIMIT S LIMIT=100
 I MATCH?4N D BS(MATCH)
 I MATCH?1U4N D BS5(MATCH)
 I MATCH?9N.1U D SSN(MATCH)
 D LNAM(MATCH)
 I LST=0 D NONE("No matches found.")
 I LST>0 D LIST(.LST)
 I LIMIT<1 D
 . D NONE("Limit of 100 matches reached.")
 . D XML^EDPX("<matchesTruncated>true</matchesTruncated>")
 Q
 ;
NONE(MSG) ; create a "no match" entry
 N X
 S X("name")=MSG
 S X("ssn")="",X("dob")="",X("dfn")=0
 D XML^EDPX($$XMLA^EDPX("ptlk",.X))
 Q
LIST(LST) ; list names that match
 N I,X,DFN,NAME
 S NAME="" F  S NAME=$O(LST(NAME)) Q:NAME=""  D
 . S DFN=0 F  S DFN=$O(LST(NAME,DFN)) Q:'DFN  D
 .. S X("name")=NAME
 .. S X("ssn")=$$SSN^DPTLK1(DFN)  ; DG249
 .. S X("dob")=$$DOB^DPTLK1(DFN)  ; DG249
 .. S X("dfn")=DFN
 .. D XML^EDPX($$XMLA^EDPX("ptlk",.X))
 Q
BS(X) ; find matches on 9999 (BS)
 ; expects LST,LIMIT to be defined
 N DFN S DFN=0
 F  S DFN=$O(^DPT("BS",X,DFN)) Q:'DFN  D
 . S LIMIT=LIMIT-1 I LIMIT<1 Q
 . S LST=LST+1,LST($P(^DPT(DFN,0),U),DFN)=""
 Q
BS5(X) ; find matches on X9999 (BS5)
 ; expects LST,LIMIT to be defined
 N DFN S DFN=0
 F  S DFN=$O(^DPT("BS5",X,DFN)) Q:'DFN  D
 . S LIMIT=LIMIT-1 I LIMIT<1 Q
 . S LST=LST+1,LST($P(^DPT(DFN,0),U),DFN)=""
 Q
SSN(X) ; find matches on 999999999 (SSN)
 ; expects LST,LIMIT to be defined
 N DFN S DFN=0
 F  S DFN=$O(^DPT("SSN",X,DFN)) Q:'DFN  D
 . S LIMIT=LIMIT-1 I LIMIT<1 Q
 . S LST=LST+1,LST($P(^DPT(DFN,0),U),DFN)=""
 Q
LNAM(X) ; find matches on name (B)
 ; expects LST,LIMIT to be defined
 N DFN,NAME
 S NAME=$O(^DPT("B",X),-1)
 F  S NAME=$O(^DPT("B",NAME)) Q:$E(NAME,1,$L(X))'=X  Q:NAME=""  Q:LIMIT<1  D
 . S DFN=0 F  S DFN=$O(^DPT("B",NAME,DFN)) Q:'DFN  D
 .. S LIMIT=LIMIT-1 I LIMIT<1 Q
 .. S LST=LST+1,LST(NAME,DFN)=""
 Q
