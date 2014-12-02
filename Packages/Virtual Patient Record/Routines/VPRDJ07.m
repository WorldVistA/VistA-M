VPRDJ07 ;SLC/MKB -- Radiology,Surgery ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
RA1(ID) ; -- radiology exam ^TMP($J,"RAE1",DFN,ID)
 N EXAM,X0,SET,PROC,DATE,LOC,X,Y,IENS,ID3,N
 S X0=$G(^TMP($J,"RAE1",DFN,ID)),SET=$G(^(ID,"CPRS")),PROC=$P(X0,U) Q:X0=""
 S EXAM("localId")=ID,EXAM("uid")=$$SETUID^VPRUTILS("image",DFN,ID)
 S EXAM("name")=PROC,EXAM("case")=$P(X0,U,2),EXAM("category")="RA"
 S DATE=9999999.9999-+ID,EXAM("dateTime")=$$JSONDT^VPRUTILS(DATE)
 I $P(X0,U,5) D  ;report exists
 . N NM S NM=$S(+SET=2:$P(SET,U,2),1:PROC) ;2 = shared report
 . S EXAM("results",1,"uid")=$$SETUID^VPRUTILS("document",DFN,ID)
 . S EXAM("results",1,"localTitle")=NM
 . S EXAM("verified")=$S($E($P(X0,U,3))="V":"true",1:"false")
 S:$L($P(X0,U,6)) EXAM("statusName")=$P($P(X0,U,6),"~",2)
 S X=$P(X0,U,7),LOC="" I $L(X) D
 . S EXAM("imageLocation")=X,EXAM("locationName")=X
 . S LOC=+$O(^SC("B",X,0))
 . S EXAM("locationUid")=$$SETUID^VPRUTILS("location",,LOC)
 S X=$$FAC^VPRD(LOC) D FACILITY^VPRUTILS(X,"EXAM")
 I $L($P(X0,U,8)) S X=$P($P(X0,U,8),"~",2),EXAM("imagingTypeUid")=$$SETVURN^VPRUTILS("imaging-Type",X)
 S X=$P(X0,U,10) I X D
 . N CPT S CPT=$$CPT^VPRDRA(X)
 . S (EXAM("typeName"),EXAM("summary"))=$P(CPT,U,2)
 . ;I $D(^TMP($J,"RAE1",DFN,ID,"CMOD")) M EXAM("modifier")=^("CMOD")
 I $P(X0,U,11) D
 . S EXAM("orderUid")=$$SETUID^VPRUTILS("order",DFN,+$P(X0,U,11))
 . S EXAM("orderName")=$S($L(SET):$P(SET,U,2),1:PROC)
 S EXAM("hasImages")=$S($P(X0,U,12)="Y":"true",1:"false")
 I $P(X0,U,4)="Y"!($P(X0,U,9)="Y") S EXAM("interpretation")="ABNORMAL"
 S IENS=$P(ID,"-",2)_","_+ID_","_DFN_","
 S X=$$GET1^DIQ(70.03,IENS,27,"I") I X D
 . S EXAM("encounterUid")=$$SETUID^VPRUTILS("visit",DFN,+X)
 . S EXAM("encounterName")=$$NAME^VPRDJ04(+X)
 S ID3=DFN_U_$TR(ID,"-","^") D EN3^RAO7PC1(ID3) D  ;get additional values
 . S X=+$G(^TMP($J,"RAE2",DFN,+$P(ID3,U,3),PROC,"P")) Q:'X
 . S EXAM("providers",1,"providerUid")=$$SETUID^VPRUTILS("user",,X)
 . S EXAM("providers",1,"providerName")=$P($G(^VA(200,X,0)),U),N=0
 . F  S N=$O(^TMP($J,"RAE2",DFN,+$P(ID3,U,3),PROC,"D",N)) Q:N<1  S X=$G(^(N)) D
 .. S EXAM("diagnosis",N,"code")=X
 .. S:N=1 EXAM("diagnosis",N,"primary")="true"
 .. N EXP S EXP=$$LEX(X) S:EXP EXAM("diagnosis",N,"lexicon")=X
 . K ^TMP($J,"RAE2",DFN)
 S EXAM("kind")="Imaging"
 D ADD^VPRDJ("EXAM","image")
 Q
 ;
LEX(X) ; -- Return Lexicon ptr for a Dx Code
 N X,Y,DIC,LEX
 S DIC=78.3,DIC(0)="BFOXZ" D ^DIC
 S LEX=$P($G(Y(0)),U,6)
 Q LEX
 ;
SR1(ID) ; -- surgery
 N SURG,VPRX,VPRY,X,Y,I
 D ONE^SROESTV("VPRY",ID) S VPRX=$G(VPRY(ID)) Q:VPRX=""
 S SURG("localId")=ID,SURG("uid")=$$SETUID^VPRUTILS("surgery",DFN,ID)
 S X=$P(VPRX,U,2),SURG("statusName")="COMPLETED"
 I X?1"* Aborted * ".E S X=$E(X,13,999),SURG("statusName")="ABORTED"
 S (SURG("typeName"),SURG("summary"))=X
 S SURG("dateTime")=$$JSONDT^VPRUTILS($P(VPRX,U,3))
 S X=$P(VPRX,U,4) I X D
 . S SURG("providers",1,"providerUid")=$$SETUID^VPRUTILS("user",,+X)
 . S SURG("providers",1,"providerName")=$P(X,";",2)
 S X=$$GET1^DIQ(130,ID_",",50,"I"),X=$$FAC^VPRD(X)
 D FACILITY^VPRUTILS(X,"SURG")
 S X=$$GET1^DIQ(130,ID_",",.015,"I") I X D
 . S SURG("encounterUid")=$$SETUID^VPRUTILS("visit",DFN,+X)
 . S SURG("encounterName")=$$NAME^VPRDJ04(+X)
 S X=$$GET1^DIQ(136,ID_",",.02,"I") I X D
 . S X=$$CPT^VPRDSR(X)
 . S (SURG("typeName"),SURG("summary"))=$P(X,U,2)
 . S SURG("typeCode")=$$SETNCS^VPRUTILS("cpt",+X)
 S I=0 F  S I=$O(VPRY(ID,I)) Q:I<1  S X=$G(VPRY(ID,I)) I X D
 . N LT,NT S LT=$P(X,U,2) Q:$P(LT," ")="Addendum"
 . S NT=$$GET1^DIQ(8925,+X_",",".01:1501")
 . S SURG("results",I,"uid")=$$SETUID^VPRUTILS("document",DFN,+X)
 . S SURG("results",I,"localTitle")=LT
 . S:$L(NT) SURG("results",I,"nationalTitle")=NT
 S SURG("kind")="Surgery",SURG("category")="SR"
 K ^TMP("TIULIST",$J)
 D ADD^VPRDJ("SURG","surgery")
 Q
