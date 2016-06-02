HMPDJ01 ;SLC/MKB,ASMR/RRB - Orders;Nov 12, 2015 14:33:52
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          ICR
 ; -------------------          -----
 ; ^OR(100                       5771
 ; ^ORA(102.4                    5769
 ; ^ORD(100.98                    873
 ; ^PXRMINDX                     4290
 ; ^RADPT                        2480
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; GMRCGUIB                      2980
 ; LR7OU1                        2955
 ; ORQ1,^TMP("ORR"               3154
 ; ORQ12,^TMP("ORR"              5704
 ; ORX8                          2467
 ; PSS51P1                       4546
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
OR1(ID) ; -- order ID >> ^TMP("ORR",$J,ORLIST,HMPN)
 N ORDER,CHILD,HMPC
 D ORX(ID,.ORDER)
 ;DE2818, ^OR(100) - ICR 5771
 S HMPC=0 F  S HMPC=$O(^OR(100,ID,2,HMPC)) Q:HMPC<1  D
 . K CHILD D ORX(HMPC,.CHILD)
 . M ORDER("children",HMPC)=CHILD
 S ORDER("lastUpdateTime")=$$EN^HMPSTMP("order") ;RHL 20141231
 S ORDER("stampTime")=ORDER("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("order",ORDER("uid"),ORDER("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("ORDER","order")
 Q
ORX(IFN,ORD) ; -- extract order IFN into ORD("attribute")
 N ORLIST,ORLST,X0,X8,LOC,X,I,DA
 S ORLST=$S(+$G(HMPN):HMPN-1,1:0) S:'$D(ORLIST) ORLIST=$H
 D GET^ORQ12(IFN,ORLIST,1)
 S X0=$G(^TMP("ORR",$J,ORLIST,ORLST))
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_IFN_" for the orders domain"
 ;
 S ORD("localId")=IFN,ORD("uid")=$$SETUID^HMPUTILS("order",DFN,IFN)
 S X=$$OI^ORX8(+X0) I $L(X) D
 . N ARRAY,NAME
 . S ARRAY("Code")=1_U_"oi",ARRAY("Name")=2,ARRAY("PackageRef")=3
 . D SPLITVAL^HMPUTILS(X,.ARRAY) S ORD("name")=ARRAY("Name")
 . S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  S ORD("oi"_NAME)=$G(ARRAY(NAME))
 S ORD("displayGroup")=$P(X0,U,2)
 S ORD("entered")=$$JSONDT^HMPUTILS($P(X0,U,3))
 S ORD("start")=$$TM($P(X0,U,4)),ORD("stop")=$$TM($P(X0,U,5))
 S ORD("statusCode")="urn:va:order-status:"_$P(X0,U,7)
 S ORD("statusName")=$P(X0,U,6)
 S ORD("statusVuid")="urn:va:vuid:"_$$STS^HMPDOR($P(X0,U,7))
 D SETTEXT^HMPUTILS($NA(^TMP("ORR",$J,ORLIST,ORLST,"TX")),$NA(^TMP("HMPTEXT",$J,IFN)))
 M ORD("content","\")=^TMP("HMPTEXT",$J,IFN)
 S X=$$GET1^DIQ(100,IFN_",",1,"I") I X D
 . S ORD("providerUid")=$$SETUID^HMPUTILS("user",,+X)
 . S ORD("providerName")=$$GET1^DIQ(200,X_",",.01)  ;DE2818, ICR 10060
 S LOC=+$$GET1^DIQ(100,IFN_",",6,"I"),FAC=$$FAC^HMPD(LOC) I LOC D
 . S ORD("locationName")=$$GET1^DIQ(44,LOC_",",.01)  ;DE2818, ICR 10040
 . S ORD("locationUid")=$$SETUID^HMPUTILS("location",,LOC)
 D FACILITY^HMPUTILS(FAC,"ORD")
 S ORD("service")=$$GET1^DIQ(100,IFN_",","12:1")
 S X=$$GET1^DIQ(100,IFN_",",9,"I") S:X ORD("predecessor")=$$SETUID^HMPUTILS("order",DFN,+X)
 S X=$$GET1^DIQ(100,IFN_",",9.1,"I") S:X ORD("successor")=$$SETUID^HMPUTILS("order",DFN,+X)
 D RESULTS
 ;DE2818, ICR 5771 for ^OR(100)
 ; sign/verify
 S X8=$G(^OR(100,IFN,8,1,0)),I=0 I $P(X8,U,6) D       ;(#6) DATE/TIME SIGNED
 . N PROV S PROV=$P(X8,U,5) S:PROV<1 PROV=$P(X8,U,3)  ;(#5) SIGNED BY or (#3) PROVIDER, if on chart,
 . D USER(.I,"S",PROV,$P(X8,U,6))                     ;   use provider
 I $P(X8,U,9)  D USER(.I,"N",$P(X8,U,8),$P(X8,U,9))   ;(#8) VERIFYING NURSE, (#9) DATE/TIME NURSE VERIFIED
 I $P(X8,U,11) D USER(.I,"C",$P(X8,U,10),$P(X8,U,11)) ;(#10) VERIFYING CLERK ,(#11) DATE/TIME CLERK VERIFIED
 I $P(X8,U,19) D USER(.I,"R",$P(X8,U,18),$P(X8,U,19)) ;(#18) CHART REVIEWED BY, (#19) DATE/TIME CHART REVIEWED
 Q
 ; acknowledgements, DE2818,^ORA(102.4) - ICR 5769
 S DA=0 F  S DA=$O(^ORA(102.4,"B",+IFN,DA)) Q:DA<1  D
 . S X0=$G(^ORA(102.4,DA,0)) Q:'$P(X0,U,3)  ;stub - not ack'd
 . S X=+$P(X0,U,2),X=$S(X:X_U_$$GET1^DIQ(200,X_",",.01),1:U)  ;DE2818, ICR 10060
 . S ORD("acknowledgement",DA)=X_U_$P(X0,U,3)
 Q
 ;
RESULTS ; -- add ORD("results",n,"uid") list
 N ORPK,ORPKG,ORDG
 ;DE2818, ^OR(100) - ICR 5771
 S ORPK=$G(^OR(100,IFN,4)),ORPKG=ORD("service"),ORDG=ORD("displayGroup")
 I ORPKG="GMRC" D  Q
 . N HMPD,I,N,X D DOCLIST^GMRCGUIB(.HMPD,+ORPK)
 . S N=1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("consult",DFN,+ORPK)
 . S I=0 F  S I=$O(HMPD(50,I)) Q:I<1  S X=$G(HMPD(50,I)) D
 .. Q:'$D(@(U_$P(X,";",2)_+X_")"))  ;text deleted
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("document",DFN,+X)
 . Q:ORDG'="PROC"
 . N HMPC D FIND^DIC(702,,"@","Q",+ORPK,,"ACON",,,"HMPC") ;CP
 . S I=0 F  S I=$O(HMPC("DILIST",2,I)) Q:I<1  D
 .. S X=+$G(HMPC("DILIST",2,I))_";MDD(702,"
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("procedure",DFN,X)
 I ORPKG="LR" D  Q
 . Q:$L(ORPK,";")'>3  ;no results yet, or parent order
 . N SUB,IDT,CDT,ITM,HMPT,ID,T,N,LRDFN,IDX
 . S SUB=$P(ORPK,";",4),IDT=$P(ORPK,";",5),CDT=9999999-IDT
 . I SUB="CH" D  Q
 .. S ITM=+$G(ORD("oiPackageRef")) D EXPAND^LR7OU1(ITM,.HMPT)
 .. S (T,N)=0 F  S T=$O(HMPT(T)) Q:T<1  S ID=$O(^PXRMINDX(63,"PI",DFN,T,CDT,"")) I $L(ID) S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("lab",DFN,$P(ID,";",2,9))
 . I SUB="MI" D  Q
 .. S ITM="M;A;",N=0,LRDFN=$$LRDFN^HMPXGLAB(DFN)  ;DE2818
 .. F  S ITM=$O(^PXRMINDX(63,"PI",DFN,ITM)) Q:$E(ITM,1,4)'="M;A;"  I $D(^(ITM,CDT)) D
 ... S IDX=LRDFN_";MI;"_IDT
 ... F  S IDX=$O(^PXRMINDX(63,"PI",DFN,ITM,CDT,IDX)) Q:IDX=""  S ID=$P(IDX,";",2,99),N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("lab",DFN,ID)
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("document",DFN,SUB_";"_IDT)
 . ; SUB:"AP" [AU,CY,EM,SP]
 . S ORD("results",1,"uid")=$$SETUID^HMPUTILS("lab",DFN,SUB_";"_IDT)
 . S ORD("results",2,"uid")=$$SETUID^HMPUTILS("document",DFN,SUB_";"_IDT)
 I ORPKG["PS" D  Q
 . S:ORPK ORD("results",1,"uid")=$$SETUID^HMPUTILS("med",DFN,IFN)
 ;DE2818, ^RADPT - ICR 2480
 I ORPKG="RA" D  Q
 . N IDT,CN S IDT=+$O(^RADPT("AO",+ORPK,DFN,0)) Q:'IDT
 . S CN=0 F  S CN=$O(^RADPT("AO",+ORPK,DFN,IDT,CN)) Q:CN<1  S ORD("results",CN,"uid")=$$SETUID^HMPUTILS("image",DFN,IDT_"-"_CN)
 ; rest should be generic (OR) orders
 I ORDG="NTX" S ORD("results",1,"uid")=$$SETUID^HMPUTILS("treatment",DFN,IFN) Q
 I ORDG="V/M" Q  ;no link
 Q
 ;
NTX1(IFN) ; -- extract nursing treatment order IFN into NTX("attribute")
 N NTX,X
 D ORX(IFN,.NTX) ;get basic order info
 S NTX("orderUid")=NTX("uid")
 S NTX("uid")=$$SETUID^HMPUTILS("treatment",DFN,IFN)
 S X=$$VALUE^ORX8(IFN,"COMMENT") S:$L(X) NTX("instructions")=X
 S X=$$VALUE^ORX8(IFN,"SCHEDULE") I X D
 . D ZERO^PSS51P1(X,,,,"HMPS")
 . S NTX("scheduleName")=$G(^TMP($J,"HMPS",X,.01))
 . S NTX("adminTimes")=$G(^TMP($J,"HMPS",X,1))
 . K ^TMP($J,"HMPS")
 S NTX("lastUpdateTime")=$$EN^HMPSTMP("treatment") ;RHL 20141231
 S NTX("stampTime")=NTX("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("treatment",NTX("uid"),NTX("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("NTX","treatment")
 Q
 ;
USER(N,ROLE,IEN,DATE) ; -- add signature/verification data
 S N=+$G(N)+1
 S ORD("clinicians",N,"signedDateTime")=$$JSONDT^HMPUTILS(DATE)
 S ORD("clinicians",N,"role")=$G(ROLE)
 Q:+$G(IEN)<1
 S ORD("clinicians",N,"uid")=$$SETUID^HMPUTILS("user",,IEN)
 S ORD("clinicians",N,"name")=$$GET1^DIQ(200,IEN_",",.01)  ;DE2818, ICR 10060
 Q
 ;
TM(X) ; -- strip seconds off a FM time
 N D,T,Y S D=$P(X,"."),T=$P(X,".",2)
 S Y=D_$S(T:"."_$E(T,1,4),1:"")
 S Y=$$JSONDT^HMPUTILS(Y)
 Q Y
 ;
