HMPDJ07 ;SLC/MKB,ASMR/RRB - Radiology,Surgery;6/25/12  16:11
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; RAO7PC1                  2043,2265
 ; SROESTV                       3533
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
RA1(ID) ; -- radiology exam ^TMP($J,"RAE1",DFN,ID)
 N EXAM,X0,SET,PROC,DATE,LOC,X,Y,IENS,ID3,N
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the radiology domain"
 ;
 S X0=$G(^TMP($J,"RAE1",DFN,ID)),SET=$G(^(ID,"CPRS")),PROC=$P(X0,U) Q:X0=""
 S EXAM("localId")=ID,EXAM("uid")=$$SETUID^HMPUTILS("image",DFN,ID)
 S EXAM("name")=PROC,EXAM("case")=$P(X0,U,2),EXAM("category")="RA"
 S DATE=9999999.9999-+ID,EXAM("dateTime")=$$JSONDT^HMPUTILS(DATE)
 I $P(X0,U,5) D  ;report exists
 . N NM S NM=$S(+SET=2:$P(SET,U,2),1:PROC) ;2 = shared report
 . S EXAM("results",1,"uid")=$$SETUID^HMPUTILS("document",DFN,ID)
 . S EXAM("results",1,"localTitle")=NM
 . S EXAM("verified")=$S($E($P(X0,U,3))="V":"true",1:"false")
 S:$L($P(X0,U,6)) EXAM("statusName")=$P($P(X0,U,6),"~",2)
 S X=$P(X0,U,7),LOC="" I $L(X) D
 . S EXAM("imageLocation")=X,EXAM("locationName")=X
 . S LOC=+$O(^SC("B",X,0)) ;ICR 10040 DE2818 ASF 11/10/15
 . S EXAM("locationUid")=$$SETUID^HMPUTILS("location",,LOC)
 S X=$$FAC^HMPD(LOC) D FACILITY^HMPUTILS(X,"EXAM")
 I $L($P(X0,U,8)) S X=$P($P(X0,U,8),"~",2),EXAM("imagingTypeUid")=$$SETVURN^HMPUTILS("imaging-Type",X)
 S X=$P(X0,U,10) I X D
 . N CPT S CPT=$$CPT^HMPDRA(X)
 . S (EXAM("typeName"),EXAM("summary"))=$P(CPT,U,2)
 . ;I $D(^TMP($J,"RAE1",DFN,ID,"CMOD")) M EXAM("modifier")=^("CMOD")
 I $P(X0,U,11) D
 . S EXAM("orderUid")=$$SETUID^HMPUTILS("order",DFN,+$P(X0,U,11))
 . S EXAM("orderName")=$S($L(SET):$P(SET,U,2),1:PROC)
 S EXAM("hasImages")=$S($P(X0,U,12)="Y":"true",1:"false")
 I $P(X0,U,4)="Y"!($P(X0,U,9)="Y") S EXAM("interpretation")="ABNORMAL"
 S IENS=$P(ID,"-",2)_","_+ID_","_DFN_","
 S X=$$GET1^DIQ(70.03,IENS,27,"I") I X D
 . S EXAM("encounterUid")=$$SETUID^HMPUTILS("visit",DFN,+X)
 . S EXAM("encounterName")=$$NAME^HMPDJ04(+X)
 S ID3=DFN_U_$TR(ID,"-","^") D EN3^RAO7PC1(ID3) D  ;get additional values
 . S EXAM("reason")=$G(^TMP($J,"RAE2",DFN,+$P(ID3,U,3),PROC,"RFS"))
 . S X=+$G(^TMP($J,"RAE2",DFN,+$P(ID3,U,3),PROC,"P")) D:X
 .. S EXAM("providers",1,"providerUid")=$$SETUID^HMPUTILS("user",,X)
 .. S EXAM("providers",1,"providerName")=$P($G(^VA(200,X,0)),U) ;ICR 10060 DE2818 ASF 11/10/15
 . S N=0 F  S N=$O(^TMP($J,"RAE2",DFN,+$P(ID3,U,3),PROC,"D",N)) Q:N<1  S X=$G(^(N)) D
 .. S EXAM("diagnosis",N,"code")=X
 .. S:N=1 EXAM("diagnosis",N,"primary")="true"
 .. N EXP S EXP=$$LEX(X) S:EXP EXAM("diagnosis",N,"lexicon")=X
 . K ^TMP($J,"RAE2",DFN)
 S EXAM("kind")="Imaging"
 S EXAM("lastUpdateTime")=$$EN^HMPSTMP("image") ;RHL 20150102
 S EXAM("stampTime")=EXAM("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("image",EXAM("uid"),EXAM("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("EXAM","image")
 Q
 ;
LEX(X) ; -- Return Lexicon ptr for a Dx Code
 N Y,DIC,LEX
 S DIC=78.3,DIC(0)="BFOXZ" D ^DIC
 S LEX=$P($G(Y(0)),U,6)
 Q LEX
 ;
SR1(ID) ; -- surgery
 N SURG,HMPX,HMPY,X,Y,I
 D ONE^SROESTV("HMPY",ID) S HMPX=$G(HMPY(ID)) Q:HMPX=""
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_ID_" for the surgery domain"
 ;
 S SURG("localId")=ID,SURG("uid")=$$SETUID^HMPUTILS("surgery",DFN,ID)
 S X=$P(HMPX,U,2),SURG("statusName")="COMPLETED"
 I X?1"* Aborted * ".E S X=$E(X,13,999),SURG("statusName")="ABORTED"
 S (SURG("typeName"),SURG("summary"))=X
 S SURG("dateTime")=$$JSONDT^HMPUTILS($P(HMPX,U,3))
 S X=$P(HMPX,U,4) I X D
 . S SURG("providers",1,"providerUid")=$$SETUID^HMPUTILS("user",,+X)
 . S SURG("providers",1,"providerName")=$P(X,";",2)
 S X=$$GET1^DIQ(130,ID_",",50,"I"),X=$$FAC^HMPD(X)
 D FACILITY^HMPUTILS(X,"SURG")
 S X=$$GET1^DIQ(130,ID_",",.015,"I") I X D
 . S SURG("encounterUid")=$$SETUID^HMPUTILS("visit",DFN,+X)
 . S SURG("encounterName")=$$NAME^HMPDJ04(+X)
 S X=$$GET1^DIQ(136,ID_",",.02,"I") I X D
 . S X=$$CPT^HMPDSR(X)
 . S (SURG("typeName"),SURG("summary"))=$P(X,U,2)
 . S SURG("typeCode")=$$SETNCS^HMPUTILS("cpt",+X)
 S I=0 F  S I=$O(HMPY(ID,I)) Q:I<1  S X=$G(HMPY(ID,I)) I X D
 . N LT S LT=$P(X,U,2) Q:$P(LT," ")="Addendum"
 . S SURG("results",I,"uid")=$$SETUID^HMPUTILS("document",DFN,+X)
 . S SURG("results",I,"localTitle")=LT
 S SURG("kind")="Surgery",SURG("category")="SR"
 K ^TMP("TIULIST",$J)
 S SURG("lastUpdateTime")=$$EN^HMPSTMP("surgery") ;RHL 20150102
 S SURG("stampTime")=SURG("lastUpdateTime") ; RHL 20150102
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("surgery",SURG("uid"),SURG("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("SURG","surgery")
 Q
