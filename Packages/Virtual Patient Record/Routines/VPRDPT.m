VPRDPT ;SLC/MKB -- Patient demographics extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DGSL(38.1                     767
 ; ^DIC(31                        733
 ; ^DIC(42                  723,10039
 ; ^DPT               3581,5597,10035
 ; DGCV                          4156
 ; DGMSTAPI                      2716
 ; DGNTAPI                       3457
 ; DGPFAPI                       3860
 ; DGRPDB                        4807
 ; DILFD                         2055
 ; DIQ                           2056
 ; MPIF001                       2701
 ; SDUTL3                        1252
 ; VADPT                        10061
 ; VAFCTFU1                      2990
 ; VASITE                       10112
 ; XUAF4                         2171
 ;
 ; ------------ Get data from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find current patient demographics
 ; [BEG,END,MAX,ID not currently used]
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 N PAT,SYS S SYS=$$SITE^VASITE
 D DEM,SVC,PRF,ATC,SUPP,ALIAS,FAC
 I $D(PAT)>9 D XML(.PAT)
 Q
 ;
DEM ;-demographic data
 N VADM,VA,VAERR,X
 S X=+$$GETICN^MPIF001(DFN) S:X>1 PAT("icn")=X
 D DEM^VADPT S X=VADM(1),PAT("fullName")=X
 S PAT("familyName")=$P(X,","),PAT("givenNames")=$P(X,",",2,99)
 S PAT("ssn")=$P(VADM(2),U),PAT("id")=DFN
 S:$D(VA("BID")) PAT("bid")=$E(X)_VA("BID")
 S PAT("dob")=+$P($P(VADM(3),U),".")
 S PAT("gender")=$P(VADM(5),U)
 S PAT("lrdfn")=+$G(^DPT(DFN,"LR"))
 S X=+$P($P(VADM(6),U),".") S:X PAT("died")=X
 S X=$$GET1^DIQ(38.1,DFN_",",2,"I") S:$L(X) PAT("sensitive")=X
 S X=+VADM(9) S:X PAT("religion")=X
 S X=$P(VADM(10),U,2) S:$L(X) PAT("maritalStatus")=$E(X)
 I VADM(11) D
 . N I S I=0
 . F  S I=$O(VADM(11,I)) Q:I<1  S X=+VADM(11,I),PAT("ethnicity",X)=$$GET1^DIQ(2.06,X_","_DFN_",",".01:3")
 I VADM(12) D
 . N I S I=0
 . F  S I=$O(VADM(12,I)) Q:I<1  S X=+VADM(12,I),PAT("race",X)=$$GET1^DIQ(2.02,X_","_DFN_",",".01:3")
 Q
SVC ;-service data
 N VAEL,VASV,VAERR,X,Y,I,AO,IR,PGF,HNC,MST,CV
 D 7^VADPT
 S PAT("veteran")=VAEL(4)
 S PAT("sc")=+VAEL(3) S:VAEL(3) PAT("scPercent")=+$P(VAEL(3),U,2)
 ;
 ; exposures
 S AO=VASV(2),IR=VASV(3)
 S PGF=VASV(11)!VASV(12)!VASV(13) ;OIF/OEF
 S X=$$GETCUR^DGNTAPI(DFN,"HNC"),X=+($G(HNC("STAT")))
 S HNC=$S(X=4:1,X=5:1,X=1:0,X=6:0,1:"")
 S X=$P($$GETSTAT^DGMSTAPI(DFN),U,2),MST=$S(X="Y":1,X="N":0,1:"")
 S X=$$CVEDT^DGCV(DFN),CV=$S(+X<0:"",+X=0:0,$P(X,U,3):1,1:0)
 S PAT("exposures")=AO_U_IR_U_PGF_U_HNC_U_MST_U_CV
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
 . S PAT("flag",I)=NAME_U_$$STRING^VPRD(.TEXT)
 Q
ATC ;-address & telecom
 N VAPA,I,X
 S VAPA("P")="" D ADD^VADPT ;permanent address
 S X="" F I=1:1:4 S X=X_VAPA(I)_U
 S X=X_$P(VAPA(5),U,2)_U_$P(VAPA(11),U,2)
 S PAT("address")=X ;street1^st2^st3^city^state^zip
 S X=$$FORMAT(VAPA(8))_U_$$FORMAT($$GET1^DIQ(2,DFN_",",.134))_U_$$FORMAT($$GET1^DIQ(2,DFN_",",.132))
 S PAT("telecom")=X ;home^cell^work phones
 Q
SUPP ;-support contacts
 N VAOA,A,I,X,TYPE
 F A="",1 K VAOA D
 . S:A VAOA("A")=A D OAD^VADPT Q:'$L($G(VAOA(9)))
 . S TYPE=$S(A=1:"ECON",1:"NOK")
 . S PAT("support",TYPE)=VAOA(9)_U_VAOA(10) ;name^relationship
 . S X="" F I=1:1:4 S X=X_VAOA(I)_U
 . S X=X_$P(VAOA(5),U,2)_U_$P(VAOA(11),U,2)
 . S PAT("support",TYPE,"address")=X ;street1^st2^st3^city^state^zip
 . S I=$S(A=1:.33011,1:.21011),X=$$FORMAT(VAOA(8))_U_U_$$FORMAT($$GET1^DIQ(2,DFN_",",I))
 . S PAT("support",TYPE,"telecom")=X ;home^cell^work phones
 Q
ALIAS ;-other names used
 N I,X
 S I=0 F  S I=$O(^DPT(DFN,.01,I)) Q:I<1  S X=$G(^(I,0)) D
 . S PAT("alias",I)=$P(X,U)
 Q
FORMAT(X) ; -- enforce (xxx)xxx-xxxx phone format
 S X=$G(X) I X?1"("3N1")"3N1"-"4N.E Q X
 N P,N,I,Y S P=""
 F I=1:1:$L(X) S N=$E(X,I) I N=+N S P=P_N
 S:$L(P)<10 P=$E("0000000000",1,10-$L(P))_P
 S Y=$S(P:"("_$E(P,1,3)_")"_$E(P,4,6)_"-"_$E(P,7,10),1:"")
 Q Y
FAC ;-treating facilities [see FACLIST^ORWCIRN]
 N IFN S DFN=+$G(DFN) Q:DFN<1
 N VPRY,HOME,I,X,IEN
 I $L($T(TFL^VAFCTFU1)) D TFL^VAFCTFU1(.VPRY,DFN)
 I $P($G(VPRY(1)),U)<0 D  Q  ;not setup
 . S X=$$SITE^VASITE,PAT("facility",+X)=$P(X,U,3)_U_$P(X,U,2)
 S HOME=+$P($G(^DPT(DFN,"MPI")),U,3) ;home facility
 S I=0 F  S I=$O(VPRY(I)) Q:I<1  D
 . S X=VPRY(I) Q:$P(X,U)=""  ;unknown
 . S IEN=+$$IEN^XUAF4($P(X,U))
 . I +X=776!(+X=200) S $P(X,U,2)="DEPT. OF DEFENSE"
 . S PAT("facility",IEN)=$P(X,U,1,3) ;stn# ^ name ^ last date
 . I IEN=HOME S $P(PAT("facility",IEN),U,4)=1
 Q
 ;
INPT ;-current inpt status data
 N ADM,X
 S ADM=+$G(^DPT(DFN,.105)) I ADM D
 . N VAIN,VAERR,HLOC,SVC
 . D INP^VADPT S PAT("admitted")=ADM_U_+VAIN(7)
 . S PAT("ward")=VAIN(4),PAT("roomBed")=VAIN(5)
 . S HLOC=+$G(^DIC(42,+VAIN(4),44)),SVC=$P($G(^(0)),U,3)
 . S PAT("location")=HLOC_U_$P(VAIN(4),U,2)
 . S:$L(SVC) PAT("locSvc")=SVC_U_$$EXTERNAL^DILFD(42,.03,,SVC)
 . S PAT("specialty")=VAIN(3)
 . S PAT("attending")=VAIN(11)
 . S X=$$FAC^VPRD(HLOC),PAT("site")=X
 S PAT("inpatient")=$S(ADM:"true",1:"false")
 S X=$$OUTPTPR^SDUTL3(DFN) S:X PAT("pcProvider")=X
 S X=$$OUTPTTM^SDUTL3(DFN) S:X PAT("pcTeam")=X
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(ITEM) ; -- Return patient data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,ID
 D ADD("<patient>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(ITEM(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I ATT="exposures" D:X["1"  S Y="" Q
 .. S I=0,Y="<exposures>" D ADD(Y)
 .. F ID="AO","IR","PG","HNC","MST","CV" S I=I+1 I $P(X,U,I) S Y="<exposure value='"_ID_"' />" D ADD(Y)
 .. D ADD("</exposures>")
 . I $L($O(ITEM(ATT,""))) D  Q  ;multiples
 .. S ID=$S($E(ATT,$L(ATT))="s":ATT_"es",$E(ATT,$L(ATT))="y":$E(ATT,1,$L(ATT)-1)_"ies",1:ATT_"s")
 .. D ADD("<"_ID_">")
 .. S I="" F  S I=$O(ITEM(ATT,I)) Q:I=""  D  D:$L(Y) ADD(Y)
 ... S X=ITEM(ATT,I),Y="<"_ATT_" "
 ... I ATT="support" D  S Y="" Q
 .... S Y=Y_"contactType='"_I_"' name='"_$$ESC^VPRD($P(X,U))_$S($L($P(X,U,2)):"' relationship='"_$$ESC^VPRD($P(X,U,2)),1:"")_"' >" D ADD(Y)
 .... S X=$G(ITEM(ATT,I,"address")) I $L(X) D ADDR(X)
 .... S X=$G(ITEM(ATT,I,"telecom")) I $L(X) D PHONE(X)
 .... D ADD("</support>")
 ... I ATT="alias" S Y=Y_"fullName='"_$$ESC^VPRD(X)_$S(X[",":"' familyName='"_$$ESC^VPRD($P(X,","))_"' givenNames='"_$$ESC^VPRD($P(X,",",2,99)),1:"")_"' />" Q
 ... I ATT="flag" S Y=Y_"name='"_$$ESC^VPRD($P(X,U))_"' text='"_$$ESC^VPRD($P(X,U,2))_"' />" Q
 ... I ATT="facility" S Y=Y_"code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_$S($P(X,U,3):"' latestDate='"_$P($P(X,U,3),"."),1:"")_$S($P(X,U,4):"' homeSite='1",1:"")_"' />" Q
 ... I ATT="disability" S Y=Y_"vaCode='"_I_"' printName='"_$$ESC^VPRD($P(X,U))_$S($P(X,U,3):"' sc='"_$P(X,U,3)_"' scPercent='"_$P(X,U,2),1:"")_"' />" Q
 ... S Y=Y_"value='"_$$ESC^VPRD(ITEM(ATT,I))_"' />"
 .. D ADD("</"_ID_">") S Y=""
 . S X=$G(ITEM(ATT)),Y="" Q:'$L(X)
 . I ATT="address" D ADDR(X) S Y="" Q
 . I ATT="telecom" D PHONE(X) S Y="" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"' />"
 D ADD("</patient>")
 Q
 ;
ADDR(X) ; -- XML address node from X=street1^st2^st3^city^state^zip
 N I,Y Q:$L(X)'>5  ;no data
 S Y="<address"
 F I=1,2,3 I $L($P(X,U,I)) S Y=Y_" streetLine"_I_"='"_$$ESC^VPRD($P(X,U,I))_"'"
 I $L($P(X,U,4)) S Y=Y_" city='"_$$ESC^VPRD($P(X,U,4))_"'"
 I $L($P(X,U,5)) S Y=Y_" stateProvince='"_$P(X,U,5)_"'"
 I $L($P(X,U,6)) S Y=Y_" postalCode='"_$P(X,U,6)_"'"
 S Y=Y_" />" D ADD(Y)
 Q
 ;
PHONE(X) ; -- XML telecom node from X=home^cell^work numbers
 N I,Y Q:$L(X)'>2  ;no data
 D ADD("<telecomList>")
 I $L($P(X,U,1)) S Y="<telecom usageType='H' value='"_$P(X,U,1)_"' />" D ADD(Y)
 I $L($P(X,U,2)) S Y="<telecom usageType='MC' value='"_$P(X,U,2)_"' />" D ADD(Y)
 I $L($P(X,U,3)) S Y="<telecom usageType='WP' value='"_$P(X,U,3)_"' />" D ADD(Y)
 D ADD("</telecomList>")
 Q
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
