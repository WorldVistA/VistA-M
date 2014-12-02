VPRDJ00 ;SLC/MKB -- Patient demographics ;8/11/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DPT                         10035
 ; DGCV                          4156
 ; DGMSTAPI                      2716
 ; DGNTAPI                       3457
 ; DGPFAPI                       3860
 ; DGRPDB                        4807
 ; DIQ                           2056
 ; MPIF001                       2701
 ; SDUTL3                        1252
 ; VADPT                        10061
 ; VAFCTFU1                      2990
 ; VASITE                       10112
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, VPRID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
DPT1 ; -- Demographics [VPRSTART,VPRSTOP,VPRMAX,VPRID not currently used here]
 N PAT,SYS S SYS=$$SITE^VASITE
 D DEM,SVC,PRF,ATC,SUPP,ALIAS,FAC,PC
 I $D(PAT)>9 D ADD^VPRDJ("PAT")
 Q
 ;
DEM ;-demographic data
 N VADM,VA,VAERR,X
 S X=+$$GETICN^MPIF001(DFN) S:X>1 PAT("icn")=X
 D DEM^VADPT S X=VADM(1),PAT("fullName")=X
 S PAT("familyName")=$P(X,","),PAT("givenNames")=$P(X,",",2,99)
 S PAT("ssn")=$P(VADM(2),U),PAT("localId")=DFN
 S PAT("uid")=$$SETUID^VPRUTILS("patient",DFN,DFN)
 S:$D(VA("BID")) PAT("briefId")=$E(X)_VA("BID")
 S X=+$P($P(VADM(3),U),"."),PAT("dateOfBirth")=$$JSONDT^VPRUTILS(X)
 S X=$P(VADM(5),U),PAT("genderCode")="urn:va:pat-gender:"_X,PAT("genderName")=$$NAME(X,"gender")
 S X=+$P($P(VADM(6),U),".") S:X PAT("died")=$$JSONDT^VPRUTILS(X)
 S X=$$GET1^DIQ(38.1,DFN_",",2,"I") S:$L(X) PAT("sensitive")=$$BOOL(X)
 S X=+VADM(9) S:X PAT("religionCode")="urn:va:pat-religion:"_X,PAT("religionName")=$$NAME(X,"religion")
 S X=$P(VADM(10),U,2) I $L(X) D  ;PAT("maritalStatus")=$E(X)
 . S X=$E(X),X=$S(X="S":"L",X="N":"S",1:X)
 . S PAT("maritalStatuses",1,"code")="urn:va:pat-maritalStatus:"_X
 . S PAT("maritalStatuses",1,"name")=$$NAME(X,"maritalStatus")
 I VADM(11) D
 . N I S I=0
 . F  S I=$O(VADM(11,I)) Q:I<1  S X=+VADM(11,I),PAT("ethnicities",X,"ethnicity")=$$GET1^DIQ(2.06,X_","_DFN_",",".01:3")
 I VADM(12) D
 . N I S I=0
 . F  S I=$O(VADM(12,I)) Q:I<1  S X=+VADM(12,I),PAT("races",X,"race")=$$GET1^DIQ(2.02,X_","_DFN_",",".01:3")
 Q
SVC ;-service data
 N VAEL,VASV,VAERR,X,Y,I,AO,IR,PGF,HNC,MST,CV
 D 7^VADPT
 ; PAT("veteran")=VAEL(4)
 S PAT("veteran","serviceConnected")=$$BOOL(+VAEL(3))
 S:VAEL(3) PAT("veteran","serviceConnectionPercent")=+$P(VAEL(3),U,2)
 S X=+$G(^DPT(DFN,"LR")) S:X PAT("veteran","lrdfn")=X
 ;
 ; exposures
 S AO=VASV(2),IR=VASV(3)
 S PGF=VASV(11)!VASV(12)!VASV(13) ;OIF/OEF
 S X=$$GETCUR^DGNTAPI(DFN,"HNC"),X=+($G(HNC("STAT")))
 S HNC=$S(X=4:1,X=5:1,X=1:0,X=6:0,1:"")
 S X=$P($$GETSTAT^DGMSTAPI(DFN),U,2),MST=$S(X="Y":1,X="N":0,1:"")
 S X=$$CVEDT^DGCV(DFN),CV=$S(+X<0:"",+X=0:0,$P(X,U,3):1,1:0)
 S X=AO_U_IR_U_PGF_U_HNC_U_MST_U_CV
 F P=1:1:6 S I=$P(X,U,P),$P(X,U,P)=$S(I:"Yes",I=0:"No",1:"Unknown")
 S NM="agent-orange^ionizing-radiation^sw-asia^head-neck-cancer^mst^combat-vet"
 F P=1:1:6 S PAT("exposures",P,"uid")="urn:va:"_$P(NM,U,P)_":"_$E($P(X,U,P)),PAT("exposures",P,"name")=$P(X,U,P)
 ;
 ; rated disabilities [DGRPDB]
 N VPRDIS,DIS,NM,DX
 D RDIS^DGRPDB(DFN,.VPRDIS)
 S I=0 F  S I=$O(VPRDIS(I)) Q:I<1  D
 . S DIS=VPRDIS(I)
 . S NM=$$GET1^DIQ(31,+DIS_",",.01),DX=$$GET1^DIQ(31,+DIS_",",2)
 . S PAT("disability",+DX)=NM_U_$P(DIS,U,2,3) ;name^%^sc
 Q
PRF ;-patient record flags
 N VPRPF,I,NAME,TEXT
 Q:'$$GETACT^DGPFAPI(DFN,"VPRPF")
 S I=0 F  S I=$O(VPRPF(I)) Q:I<1  D
 . S NAME=$P(VPRPF(I,"FLAG"),U,2)
 . M TEXT=VPRPF(I,"NARR")
 . S PAT("flags",I,"name")=NAME
 . S PAT("flags",I,"text")=$$STRING^VPRD(.TEXT)
 Q
ATC ;-address & telecom
 N VAPA,I,X,P,NM
 S VAPA("P")="" D ADD^VADPT ;permanent address
 S:$L(VAPA(1)) PAT("addresses",1,"streetLine1")=VAPA(1)
 S X=VAPA(2) I $L(X),$L(VAPA(3)) S X=X_" "_VAPA(3)
 S:$L(X) PAT("addresses",1,"streetLine2")=X
 S:$L(VAPA(4)) PAT("addresses",1,"city")=VAPA(4)
 S X=$P(VAPA(5),U,2) S:$L(X) PAT("addresses",1,"stateProvince")=X
 S X=$P(VAPA(11),U,2) S:$L(X) PAT("addresses",1,"postalCode")=X
 ; 
 ; X=home^cell^work phones
 S X=$$FORMAT(VAPA(8))_U_$$FORMAT($$GET1^DIQ(2,DFN_",",.134))_U_$$FORMAT($$GET1^DIQ(2,DFN_",",.132))
 S NM="H^MC^WP" F P=1:1:3 I $L($P(X,U,P)) D
 . S I=$P(NM,U,P),PAT("telecoms",P,"usageCode")=I
 . S PAT("telecoms",P,"usageName")=$S(I="WP":"work place",I="MC":"mobile contact",1:"home address")
 . S PAT("telecoms",P,"telecom")=$P(X,U,P)
 Q
SUPP ;-support contacts
 N VAOA,A,I,X,TYPE,S
 S S=0 F A="",1 K VAOA D
 . S:A VAOA("A")=A D OAD^VADPT Q:'$L($G(VAOA(9)))
 . S S=S+1,TYPE=$S(A=1:"ECON^Emergency Contact",1:"NOK^Next of Kin")
 . S PAT("supports",S,"contactTypeCode")="urn:va:pat-contact:"_$P(TYPE,U)
 . S PAT("supports",S,"contactTypeName")=$P(TYPE,U,2)
 . S:$L(VAOA(9)) PAT("supports",S,"name")=VAOA(9)
 . S:$L(VAOA(10)) PAT("supports",S,"relationship")=VAOA(10)
 . S:$L(VAOA(1)) PAT("supports",S,"addresses",1,"streetLine1")=VAOA(1)
 . S X=VAOA(2) I $L(X),$L(VAOA(3)) S X=X_" "_VAOA(3)
 . S:$L(X) PAT("supports",S,"addresses",1,"streetLine2")=X
 . S:$L(VAOA(4)) PAT("supports",S,"addresses",1,"city")=VAOA(4)
 . S X=$P(VAOA(5),U,2) S:$L(X) PAT("supports",S,"addresses",1,"stateProvince")=X
 . S X=$P(VAOA(11),U,2) S:$L(X) PAT("supports",S,"addresses",1,"postalCode")=X
 . S I=$S(A=1:.33011,1:.21011),X=$$FORMAT(VAOA(8))_U_U_$$FORMAT($$GET1^DIQ(2,DFN_",",I))
 . ; X=home^cell^work phones
 . S NM="H^MC^WP" F P=1:1:3 I $L($P(X,U,P)) D
 .. S I=$P(NM,U,P),PAT("supports",S,"telecomList",P,"usageCode")=I
 .. S PAT("supports",S,"telecomList",P,"usageName")=$S(I="WP":"work place",I="MC":"mobile contact",1:"home address")
 .. S PAT("supports",S,"telecomList",P,"telecom")=$P(X,U,P)
 Q
ALIAS ;-other names used
 N I,X
 S I=0 F  S I=$O(^DPT(DFN,.01,I)) Q:I<1  S X=$G(^(I,0)) D
 . S PAT("aliases",I,"fullName")=$P(X,U)
 Q
FAC ;-treating facilities [see FACLIST^ORWCIRN]
 N IFN S DFN=+$G(DFN) Q:DFN<1
 N VPRY,HOME,LAST,I,X,IEN,VASITE
 S X=$$ALL^VASITE ;VASITE(stn#)=stn# for all local
 I $L($T(TFL^VAFCTFU1)) D TFL^VAFCTFU1(.VPRY,DFN)
 S HOME=+$P($G(^DPT(DFN,"MPI")),U,3) ;home facility
 I $P($G(VPRY(1)),U)<0 D  ;not setup
 . S X=$O(^AUPNVSIT("AA",DFN,0)),LAST=$S(X:9999999-$P(X,"."),1:"")
 . S X=$$SITE^VASITE
 . S VPRY(1)=$P(X,U,3)_U_$P(X,U,2)_U_LAST_U_$$GET1^DIQ(4,+X_",",60)
 S I=0 F  S I=$O(VPRY(I)) Q:I<1  D
 . S X=VPRY(I) Q:$P(X,U)=""  ;unknown
 . S IEN=+$$IEN^XUAF4($P(X,U))
 . I +X=776!(+X=200) S $P(X,U,2)="DEPT. OF DEFENSE"
 . S PAT("facilities",I,"code")=$P(X,U)    ;stn#
 . S PAT("facilities",I,"name")=$P(X,U,2)  ;name
 . S:IEN=HOME PAT("facilities",I,"homeSite")="true"
 . S:$L($P(X,U,3)) PAT("facilities",I,"latestDate")=$$JSONDT^VPRUTILS($P($P(X,U,3),"."))
 . I $D(VASITE(+X)) D
 .. S PAT("facilities",I,"localPatientId")=DFN
 .. S PAT("facilities",I,"systemId")=VPRSYS
 Q
PC ;-primary care assignments
 N X S X=$$OUTPTPR^SDUTL3(DFN) I X D
 . S PAT("pcProviderUid")=$$SETUID^VPRUTILS("user",,+X)
 . S PAT("pcProviderName")=$P(X,U,2)
 S X=$$OUTPTTM^SDUTL3(DFN) I X D
 . S PAT("pcTeamUid")=$$SETUID^VPRUTILS("team",,+X)
 . S PAT("pcTeamName")=$$GET1^DIQ(404.51,+X_",",.01)
 Q
 ;
FORMAT(X) ; -- enforce (xxx)xxx-xxxx phone format
 S X=$G(X) I X?1"("3N1")"3N1"-"4N.E Q X
 N P,N,I,Y S P=""
 F I=1:1:$L(X) S N=$E(X,I) I N=+N S P=P_N
 S:$L(P)<10 P=$E("0000000000",1,10-$L(P))_P
 S Y=$S(P:"("_$E(P,1,3)_")"_$E(P,4,6)_"-"_$E(P,7,10),1:"")
 Q Y
 ;
NAME(CODE,SET) ; -- Return expanded name for code set
 N Y S Y="",CODE=$G(CODE)
 I $G(SET)="gender" S Y=$S(CODE="F":"Female",CODE="M":"Male",1:"Unknown")
 I $G(SET)="maritalStatus" S Y=$S(CODE="D":"Divorced",CODE="M":"Married",CODE="W":"Widowed",CODE="L":"Legally Separated",CODE="S":"Never Married",1:"Unknown")
 I $G(SET)="religion" S Y=$$GET1^DIQ(13,CODE_",",.01)
 Q Y
 ;
BOOL(X) ;
 Q $S(X>0:"true",1:"false")
