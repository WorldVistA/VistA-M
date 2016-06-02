HMPEASU ;SLC/GRR,ASMR/RRB - Serve VistA reference data as JSON via RPC;10/18/12 6:26pm
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CLASS ; -- USR Class file #8930
 N PRV S PRV=+$G(HMPLAST)
 S HMPCNT=$$TOTAL^HMPEF("^USR(8930)")
 I PRV=0 S PRV=.9
 I $L(HMPID) D CLS1(HMPID) Q
 F  S PRV=$O(^USR(8930,PRV)) Q:PRV'>0  D CLS1(PRV) I HMPMAX,HMPI'<HMPMAX Q
 I PRV'>0 S HMPFINI=1
 Q
 ;
CLS1(IEN) ;
 N $ES,$ET,ERRMSG
 S ERRMSG=$$ERRMSG^HMPEF("User Class",IEN)
 S $ET="D ERRHDLR^HMPDERRH"
 N HMPV,FLDS,X,Y,INREC
 K HMPV S FLDS=".01:.05;1*"
 D GETS^DIQ(8930,IEN_",",FLDS,"IEN","HMPV")
 S Y=$NA(HMPV(8930,IEN_","))
 S INREC("name")=$G(@Y@(.01,"E"))
 S INREC("localId")=IEN,INREC("uid")=$$SETUID^HMPUTILS("asu-class",,IEN)
 S INREC("abbreviation")=$G(@Y@(.02,"E")),INREC("active")=$S($G(@Y@(.03,"I"))=1:"true",1:"false")
 S INREC("displayName")=$G(@Y@(.04,"E"))
 I $D(HMPV("8930.01")) D
 . N IEN2,ID,CNT
 . S IEN2="",CNT=0
 . F  S IEN2=$O(HMPV(8930.01,IEN2)) Q:IEN2=""  D
 . . S CNT=CNT+1,INREC("subClass",CNT,"name")=HMPV("8930.01",IEN2,".01","E")
 . . S ID=HMPV(8930.01,IEN2,.01,"I"),INREC("subClass",CNT,"uid")=$$SETUID^HMPUTILS("asu-class",,ID)
 D ADD^HMPEF("INREC") S HMPLAST=IEN
 Q
 ;
RULE ; -- USR Authorization/Subscription file #8930.1
 N PRV S PRV=+$G(HMPLAST)
 S HMPCNT=$$TOTAL^HMPEF("^USR(8930.1)")
 I PRV=0 S PRV=.9
 I $L(HMPID) D RULE1(HMPID) Q
 F  S PRV=$O(^USR(8930.1,PRV)) Q:PRV'>0  D RULE1(PRV) I HMPMAX,HMPI'<HMPMAX Q
 I PRV'>0 S HMPFINI=1
 Q
 ;
RULE1(IEN) ;
 N $ES,$ET,ERRMSG
 S ERRMSG=$$ERRMSG^HMPEF("ASU Rule",IEN)
 S $ET="D ERRHDLR^HMPDERRH"
 N HMPV,FLDS,X,Y,INREC,DESC
 K HMPV S FLDS=".01:1"
 D GETS^DIQ(8930.1,IEN_",",FLDS,"IEN","HMPV")
 S Y=$NA(HMPV(8930.1,IEN_","))
 S INREC("localId")=IEN,INREC("uid")=$$SETUID^HMPUTILS("asu-rule",,IEN)
 S X=$G(@Y@(.01,"I")) S:X INREC("docDefUid")=$$SETUID^HMPUTILS("doc-def",,X),INREC("docDefName")=$G(@Y@(.01,"E"))
 S X=$G(@Y@(.02,"I")) S:X INREC("statusUid")=$$SETUID^HMPUTILS("doc-status",,X),INREC("statusName")=$G(@Y@(.02,"E"))
 S X=$G(@Y@(.03,"I")) S:X INREC("actionUid")=$$SETUID^HMPUTILS("doc-action",,X),INREC("actionName")=$G(@Y@(.03,"E"))
 S X=$G(@Y@(.04,"I")) S:X INREC("userClassUid")=$$SETUID^HMPUTILS("asu-class",,X),INREC("userClassName")=$G(@Y@(.04,"E"))
 S X=$G(@Y@(.05,"I")),INREC("isAnd")=$S(X="&":"true",1:"false") ;,INREC("isOr")=$S(X="!":"true",1:"false")
 S X=$G(@Y@(.06,"I")) S:X INREC("userRoleUid")=$$SETUID^HMPUTILS("asu-role",,X),INREC("userRoleName")=$G(@Y@(.06,"E"))
 I $D(@Y@(1)) D
 . N I S I=0 F  S I=$O(@Y@(1,I)) Q:I<1  S DESC(I)=@Y@(1,I)
 . S INREC("description")=$$STRING^HMPD(.DESC)
 D ADD^HMPEF("INREC") S HMPLAST=IEN
 Q
 ;
DEF ; -- TIU Document Definition file #8925.1
 N PRV S PRV=+$G(HMPLAST)
 S HMPCNT=$$TOTAL^HMPEF("^TIU(8925.1)")
 I PRV=0 S PRV=.9
 I $L(HMPID) D DEF1(HMPID) Q
 F  S PRV=$O(^TIU(8925.1,PRV)) Q:PRV'>0  D DEF1(PRV) I HMPMAX,HMPI'<HMPMAX Q  ;ICR 2700 DE2818 ASF 11/21/15
 I PRV'>0 S HMPFINI=1
 Q
 ;
DEF1(IEN) ;
 N $ES,$ET,ERRMSG
 S ERRMSG=$$ERRMSG^HMPEF("TIU Doc Def",IEN)
 S $ET="D ERRHDLR^HMPDERRH"
 N HMPV,FLDS,X,Y,I,INREC
 K HMPV S FLDS=".01:.14;1501"
 D GETS^DIQ(8925.1,IEN_",",FLDS,"IEN","HMPV")
 S Y=$NA(HMPV(8925.1,IEN_","))
 S INREC("name")=$G(@Y@(.01,"E"))
 S INREC("uid")=$$SETUID^HMPUTILS("doc-def",,IEN)
 S INREC("abbreviation")=$G(@Y@(.02,"E"))
 S INREC("displayName")=$G(@Y@(.03,"E"))
 S INREC("typeName")=$G(@Y@(.04,"E"))
 S INREC("typeUid")=$$SETUID^HMPUTILS("doc-type",,$G(@Y@(.04,"I")))
 S X=$G(@Y@(.05,"I")) I X D
 . S INREC("ownerUid")=$$SETUID^HMPUTILS("user",,X)
 . S INREC("ownerName")=$G(@Y@(.05,"E"))
 S X=$G(@Y@(.06,"I")) S:X INREC("classOwner")=$$SETUID^HMPUTILS("asu-class",,X)
 S X=$G(@Y@(.07,"I")) I X D
 . S INREC("statusUid")=$$SETUID^HMPUTILS("doc-status",,X)
 . S INREC("statusName")=$G(@Y@(.07,"E"))
 S X=$G(@Y@(.1,"I")) S:X INREC("shared")="true"
 S X=$G(@Y@(.13,"I")) S:X INREC("nationalStandard")="true"
 S X=$G(@Y@(.14,"I")) S:X INREC("postingCode")=$$SETUID^HMPUTILS("doc-posting",,X)
 S I=0 F  S I=$O(^TIU(8925.1,IEN,10,I)) Q:I<1  S X=+$G(^(I,0)) D  ;ICR 2700 DE2818 ASF 11/21/15
 . S INREC("item",I,"uid")=$$SETUID^HMPUTILS("doc-def",,X)
 . S INREC("item",I,"name")=$$GET1^DIQ(8925.1,X_",",.01)
 ; national title info
 S X=$G(@Y@(1501,"I")) I X D  ;National Title + attributes
 . N IENS,TIU,DA,FNUM,NAME
 . S IENS=X_"," D GETS^DIQ(8926.1,IENS,"*","IE","TIU")
 . S INREC("nationalTitle","vuid")="urn:va:vuid:"_$G(TIU(8926.1,IENS,99.99,"E"))
 . S INREC("nationalTitle","name")=$G(TIU(8926.1,IENS,.01,"E"))
 . F I=".04^Subject^2",".05^Role^3",".06^Setting^4",".07^Service^5",".08^Type^6" D
 .. S DA=+$G(TIU(8926.1,IENS,+I,"I")) Q:DA'>0
 .. S FNUM="8926."_+$P(I,U,3),NAME=$$LOW^XLFSTR($P(I,U,2))
 .. S INREC("nationalTitle"_$P(I,U,2),"vuid")="urn:va:vuid:"_$$VUID^HMPD(DA,FNUM)
 .. S INREC("nationalTitle"_$P(I,U,2),"name")=$G(TIU(8926.1,IENS,+I,"E"))
 ;
 D ADD^HMPEF("INREC") S HMPLAST=IEN
 Q
