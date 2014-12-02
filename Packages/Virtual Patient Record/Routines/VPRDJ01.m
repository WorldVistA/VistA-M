VPRDJ01 ;SLC/MKB -- Orders ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
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
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
OR1(ID) ; -- order ID >> ^TMP("ORR",$J,ORLIST,VPRN)
 N ORDER,CHILD,VPRC
 D ORX(ID,.ORDER)
 S VPRC=0 F  S VPRC=$O(^OR(100,ID,2,VPRC)) Q:VPRC<1  D
 . K CHILD D ORX(VPRC,.CHILD)
 . M ORDER("children",VPRC)=CHILD
 D ADD^VPRDJ("ORDER","order")
 Q
ORX(IFN,ORD) ; -- extract order IFN into ORD("attribute")
 N ORLIST,ORLST,X0,X8,LOC,X,I,DA
 S ORLST=$S(+$G(VPRN):VPRN-1,1:0) S:'$D(ORLIST) ORLIST=$H
 D GET^ORQ12(IFN,ORLIST,1)
 S X0=$G(^TMP("ORR",$J,ORLIST,ORLST))
 ;
 S ORD("localId")=IFN,ORD("uid")=$$SETUID^VPRUTILS("order",DFN,IFN)
 S X=$$OI^ORX8(+X0) I $L(X) D
 . N ARRAY,NAME
 . S ARRAY("Code")=1_U_"oi",ARRAY("Name")=2,ARRAY("PackageRef")=3
 . D SPLITVAL^VPRUTILS(X,.ARRAY) S ORD("name")=ARRAY("Name")
 . S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  S ORD("oi"_NAME)=$G(ARRAY(NAME))
 S ORD("displayGroup")=$P(X0,U,2)
 S ORD("entered")=$$JSONDT^VPRUTILS($P(X0,U,3))
 S ORD("start")=$$TM($P(X0,U,4)),ORD("stop")=$$TM($P(X0,U,5))
 S ORD("statusCode")="urn:va:order-status:"_$P(X0,U,7)
 S ORD("statusName")=$P(X0,U,6)
 S ORD("statusVuid")="urn:va:vuid:"_$$STS^VPRDOR($P(X0,U,7))
 D SETTEXT^VPRUTILS($NA(^TMP("ORR",$J,ORLIST,ORLST,"TX")),$NA(^TMP("VPRTEXT",$J,IFN)))
 M ORD("content","\")=^TMP("VPRTEXT",$J,IFN)
 S X=$$GET1^DIQ(100,IFN_",",1,"I") I X D
 . S ORD("providerUid")=$$SETUID^VPRUTILS("user",,+X)
 . S ORD("providerName")=$P($G(^VA(200,+X,0)),U)
 S LOC=+$$GET1^DIQ(100,IFN_",",6,"I"),FAC=$$FAC^VPRD(LOC) I LOC D
 . S ORD("locationName")=$P($G(^SC(LOC,0)),U)
 . S ORD("locationUid")=$$SETUID^VPRUTILS("location",,LOC)
 D FACILITY^VPRUTILS(FAC,"ORD")
 S ORD("service")=$$GET1^DIQ(100,IFN_",","12:1")
 S X=$$GET1^DIQ(100,IFN_",",9,"I") S:X ORD("predecessor")=$$SETUID^VPRUTILS("order",DFN,+X)
 S X=$$GET1^DIQ(100,IFN_",",9.1,"I") S:X ORD("successor")=$$SETUID^VPRUTILS("order",DFN,+X)
 D RESULTS
 ; sign/verify
 S X8=$G(^OR(100,IFN,8,1,0)),I=0 I $P(X8,U,6) D       ;signed
 . N PROV S PROV=$P(X8,U,5) S:PROV<1 PROV=$P(X8,U,3)  ;if on chart,
 . D USER(.I,"S",PROV,$P(X8,U,6))                     ;   use provider
 I $P(X8,U,9)  D USER(.I,"N",$P(X8,U,8),$P(X8,U,9))   ;nurse
 I $P(X8,U,11) D USER(.I,"C",$P(X8,U,10),$P(X8,U,11)) ;clerk
 I $P(X8,U,19) D USER(.I,"R",$P(X8,U,18),$P(X8,U,19)) ;chart review
 Q
 ; acknowledgements
 S DA=0 F  S DA=$O(^ORA(102.4,"B",+IFN,DA)) Q:DA<1  D
 . S X0=$G(^ORA(102.4,DA,0)) Q:'$P(X0,U,3)  ;stub - not ack'd
 . S X=+$P(X0,U,2),X=$S(X:X_U_$P($G(^VA(200,X,0)),U),1:U)
 . S ORD("acknowledgement",DA)=X_U_$P(X0,U,3)
 Q
 ;
RESULTS ; -- add ORD("results",n,"uid") list
 N ORPK,ORPKG,ORDG
 S ORPK=$G(^OR(100,IFN,4)),ORPKG=ORD("service"),ORDG=ORD("displayGroup")
 I ORPKG="GMRC" D  Q
 . N VPRD,I,N,X D DOCLIST^GMRCGUIB(.VPRD,+ORPK)
 . S N=1,ORD("results",N,"uid")=$$SETUID^VPRUTILS("consult",DFN,+ORPK)
 . S I=0 F  S I=$O(VPRD(50,I)) Q:I<1  S X=$G(VPRD(50,I)) D
 .. Q:'$D(@(U_$P(X,";",2)_+X_")"))  ;text deleted
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^VPRUTILS("document",DFN,+X)
 . Q:ORDG'="PROC"
 . N VPRC D FIND^DIC(702,,"@","Q",+ORPK,,"ACON",,,"VPRC") ;CP
 . S I=0 F  S I=$O(VPRC("DILIST",2,I)) Q:I<1  D
 .. S X=+$G(VPRC("DILIST",2,I))_";MDD(702,"
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^VPRUTILS("procedure",DFN,X)
 I ORPKG="LR" D  Q
 . Q:$L(ORPK,";")'>3  ;no results yet, or parent order
 . N SUB,IDT,CDT,ITM,VPRT,ID,T,N,LRDFN,IDX
 . S SUB=$P(ORPK,";",4),IDT=$P(ORPK,";",5),CDT=9999999-IDT
 . I SUB="CH" D  Q
 .. S ITM=+$G(ORD("oiPackageRef")) D EXPAND^LR7OU1(ITM,.VPRT)
 .. S (T,N)=0 F  S T=$O(VPRT(T)) Q:T<1  S ID=$O(^PXRMINDX(63,"PI",DFN,T,CDT,"")) I $L(ID) S N=N+1,ORD("results",N,"uid")=$$SETUID^VPRUTILS("lab",DFN,$P(ID,";",2,9))
 . I SUB="MI" D  Q
 .. S ITM="M;A;",N=0,LRDFN=$G(^DPT(DFN,"LR"))
 .. F  S ITM=$O(^PXRMINDX(63,"PI",DFN,ITM)) Q:$E(ITM,1,4)'="M;A;"  I $D(^(ITM,CDT)) D
 ... S IDX=LRDFN_";MI;"_IDT
 ... F  S IDX=$O(^PXRMINDX(63,"PI",DFN,ITM,CDT,IDX)) Q:IDX=""  S ID=$P(IDX,";",2,99),N=N+1,ORD("results",N,"uid")=$$SETUID^VPRUTILS("lab",DFN,ID)
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^VPRUTILS("document",DFN,SUB_";"_IDT)
 . ; SUB:"AP" [AU,CY,EM,SP]
 . S ORD("results",1,"uid")=$$SETUID^VPRUTILS("lab",DFN,SUB_";"_IDT)
 . S ORD("results",2,"uid")=$$SETUID^VPRUTILS("document",DFN,SUB_";"_IDT)
 I ORPKG["PS" D  Q
 . S:ORPK ORD("results",1,"uid")=$$SETUID^VPRUTILS("med",DFN,IFN)
 I ORPKG="RA" D  Q
 . N IDT,CN S IDT=+$O(^RADPT("AO",+ORPK,DFN,0)) Q:'IDT
 . S CN=0 F  S CN=$O(^RADPT("AO",+ORPK,DFN,IDT,CN)) Q:CN<1  S ORD("results",CN,"uid")=$$SETUID^VPRUTILS("image",DFN,IDT_"-"_CN)
 ; rest should be generic (OR) orders
 I ORDG="NTX" S ORD("results",1,"uid")=$$SETUID^VPRUTILS("treatment",DFN,IFN) Q
 I ORDG="V/M" Q  ;no link
 Q
 ;
NTX1(IFN) ; -- extract nursing treatment order IFN into NTX("attribute")
 N NTX,X
 D ORX(IFN,.NTX) ;get basic order info
 S NTX("orderUid")=NTX("uid")
 S NTX("uid")=$$SETUID^VPRUTILS("treatment",DFN,IFN)
 S X=$$VALUE^ORX8(IFN,"COMMENT") S:$L(X) NTX("instructions")=X
 S X=$$VALUE^ORX8(IFN,"SCHEDULE") I X D
 . D ZERO^PSS51P1(X,,,,"VPRS")
 . S NTX("scheduleName")=$G(^TMP($J,"VPRS",X,.01))
 . S NTX("adminTimes")=$G(^TMP($J,"VPRS",X,1))
 . K ^TMP($J,"VPRS")
 D ADD^VPRDJ("NTX","treatment")
 Q
 ;
USER(N,ROLE,IEN,DATE) ; -- add signature/verification data
 S N=+$G(N)+1
 S ORD("clinicians",N,"signedDateTime")=$$JSONDT^VPRUTILS(DATE)
 S ORD("clinicians",N,"role")=$G(ROLE)
 Q:+$G(IEN)<1
 S ORD("clinicians",N,"uid")=$$SETUID^VPRUTILS("user",,IEN)
 S ORD("clinicians",N,"name")=$P($G(^VA(200,IEN,0)),U)
 Q
 ;
TM(X) ; -- strip seconds off a FM time
 N D,T,Y S D=$P(X,"."),T=$P(X,".",2)
 S Y=D_$S(T:"."_$E(T,1,4),1:"")
 S Y=$$JSONDT^VPRUTILS(Y)
 Q Y
