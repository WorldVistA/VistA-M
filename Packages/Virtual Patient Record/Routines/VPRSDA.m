VPRSDA ;SLC/MKB -- SDA utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,16,20,26,28,29,30,31**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DIC(4                       10090
 ; ^SC                          10040
 ; %DT                          10003
 ; DILFD                         2055
 ; DIQ                           2056
 ; ETSLNC                        6731
 ; ETSRXN                        6758
 ; GMRVUT0, ^UTILITY($J          1446
 ; GMVGETVT                      5047
 ; GMVUTL                        5046
 ; ICPTCOD                       1995
 ; LEXTRAN                       4912
 ; VASITE                       10112
 ; XLFNAME                       3065
 ; XUAF4                         2171
 ; XUPARAM                       2541
 ;
INTDATE(X) ; -- Return internal form of date X
 N %DT,Y
 S %DT="TSX" D ^%DT
 Q Y
 ;
DATE(X,DTO) ; -- return FM date X as SDA Timestamp
 N D,T,Y
 S X=$G(X) I X'?7N.1".".7N Q ""
 S D=$P(X,"."),T=$P(X,".",2)
 ; validate date
 I '$$VALID(D) Q ""
 S Y=(1700+$E(D,1,3))_"-"_$E(D,4,5)_"-"_$E(D,6,7)
 ; if imprecise, add month or day of 01
 F I=2,3 I $P(Y,"-",I)="00" S $P(Y,"-",I)="01"
 I $G(DTO) Q Y  ;date only
 ;
 ; validate T = time
 I T=24 S T=235959 ;for SDA
 S:$L(T)<6 T=$E((T_"000000"),1,6)  ;pad the time to 6 digits
 I $E(T,1,2)>23 S T="000000"       ;invalid hours >> remove time
 I $E(T,3,4)>59 S $E(T,3,6)="0000" ;strip invalid minutes/seconds
 I $E(T,5,6)>59 S $E(T,5,6)="00"   ;strip invalid seconds
 S Y=Y_"T"_$E(T,1,2)_":"_$E(T,3,4)_":"_$E(T,5,6)
 Q Y
 ;
VALID(X) ; -- returns 1 or 0, if valid FM date
 N %DT,Y S %DT="",X=$G(X)
 I X["." S X=$P(X,".") ;ck date only
 D ^%DT I Y<1 Q 0
 ; check if out of HL7 range
 I (Y<1410102)!(Y>4141015) Q 0
 Q 1
 ;
NAMECOMP(NAME) ; -- return name as string of component pieces
 ; NAME -> FAMILY^GIVEN^MIDDLE^SUFFIX
 D NAMECOMP^XLFNAME(.NAME)
 N I,Y S Y=$G(NAME("FAMILY"))
 F I="GIVEN","MIDDLE","SUFFIX" S Y=Y_U_$G(NAME(I))
 Q Y
 ;
CODED ; -- ck Code Table ID for internal^external format
 ; called from DDEG for entity VPR CODE TABLE using variables:
 ;   FILE, FIELD, ID (read only, do NOT kill)
 Q:$G(ID)=""  Q:$L(ID,"^")>1  ;ok
 N X,NM S NM=ID
 I $G(FILE),$G(FIELD) D
 . S X=$$EXTERNAL^DILFD(FILE,FIELD,,ID)
 . S:X'="" NM=X
 S ID=ID_U_NM
 Q
 ;
CODE(IEN,FILE,CSYS,CDT) ; -- find CSYS code for IEN in FILE
 ; CSYS can be string of abbreviations to look for, in order
 N FLD,VPRC,SFN,S,SYS,NAMES,IENS,SFN1,I,X,Y
 S Y="",CDT=$G(CDT) S:CDT<1 CDT=DT
 S FLD=$$FLDNUM^DILFD(FILE,"CODING SYSTEM") Q:'FLD ""
 D GETS^DIQ(FILE,IEN_",",FLD_"*","NR","VPRC")
 S SFN=+$O(VPRC(0)) Q:'SFN ""  ;Sub-file# = Coding System multiple
 F S=1:1 S SYS=$P(CSYS,U,S) Q:SYS=""  D  Q:$L(Y)
 . S NAMES=$S(SYS="RXN":"RxNorm^RXNORM",SYS="NDF":"NDF-RT^NDFRT^NDF",SYS="SCT":"SNOMED CT^SNOMED-CT^SCT",SYS="LNC":"LOINC^LNC",SYS="UNI":"UNII^UNI",1:SYS)
 . S IENS="" F  S IENS=$O(VPRC(SFN,IENS)) Q:IENS=""  D  Q:$L(Y)
 .. S X=$G(VPRC(SFN,IENS,"CODING SYSTEM")) Q:X=""  Q:NAMES'[X
 .. S SFN1=$O(VPRC(SFN)),I=$O(VPRC(SFN1,""))
 .. S:I Y=$G(VPRC(SFN1,I,"CODE")) ;first code for system
 . I $L(Y) S Y=Y_U_$$DESC(Y)_U_$P(NAMES,U)
 Q Y
 ;
DESC(CODE) ; -- called from CODE, to return coding system text
 ; Expects all the variables used in CODE()
 N X,Y,LEX S Y=""
 I SYS="SCT" D
 . S X=$$CODE^LEXTRAN(CODE,"SCT",CDT)
 . S:X>0 Y=$G(LEX("P")) ;preferred term
 I SYS="RXN",$L($T(CSDATA^ETSRXN)) D
 . S X=$$CSDATA^ETSRXN(CODE,"RXN",CDT,.LEX)
 . S:X>0 Y=$P($G(LEX("LEX",1)),U,2)
 I SYS="LNC",$L($T(GETNAME^ETSLNC)) D
 . S X=$$GETNAME^ETSLNC(CODE,"C",.LEX)
 . S:X>0 Y=$G(LEX("LONGNAME"))
 I '$L($G(Y)) S Y=$$GET1^DIQ(FILE,IEN_",",.01)
 Q Y
 ;
NULL(N) ; -- return null string(s) to delete property
 N I,Y,QOT S N=+$G(N,1),QOT=""""""
 S Y=QOT I N>1 F I=1:1:(N-1) S Y=Y_U_QOT
 Q Y
 ;
CPT(IEN,DATE,LONG) ; -- return code^description^CPT-4 for #81 IEN
 N X0,VPRX,N,I,X,Y
 S IEN=+$G(IEN),DATE=$G(DATE) S:DATE<1 DATE=DT
 S X0=$$CPT^ICPTCOD(IEN,DATE) I X0<0 Q ""
 S Y=$P(X0,U,2,3)_"^CPT-4" ;CPT Code^Short Name
 I $G(LONG) D              ;CPT Description instead
 . S N=$$CPTD^ICPTCOD($P(Y,U),"VPRX",,DATE)
 . I N'>0!'$L($G(VPRX(1))) Q
 . S X=$G(VPRX(1)),I=1
 . F  S I=$O(VPRX(I)) Q:I<1  Q:VPRX(I)=" "  S X=X_" "_VPRX(I)
 . S $P(Y,U,2)=X
 Q Y
 ;
HLOC(X) ; -- return Hosp Loc #44 ien from location name X
 N Y S Y=0
 I $L($G(X)) S Y=+$O(^SC("B",X,0))
 Q Y
 ;
COUNTY(ST,CTY) ; -- return ien^name for a STate and CounTY
 N Y S Y=""
 I +$G(ST),+$G(CTY) S Y=$$GET1^DIQ(5.01,(+CTY_","_+ST_","),.01)
 S:$L(Y) Y=+CTY_U_Y
 Q Y
 ;
FAC(HLOC) ; -- return facility #4 ien for HospLOC #44 ien
 N X,Y S Y=""
 S HLOC=+$G(HLOC) I HLOC<1 S Y=$$SITE G FACQ
 S X=$$GET1^DIQ(44,HLOC,3,"I")
 S:X<1 X=$$GET1^DIQ(44,HLOC,"3.5:.07","I")
 S Y=$$CKFAC(X)
FACQ Q Y
 ;
CKFAC(IEN) ; -- validate #4 ien, return Parent if no stn#
 N VPRZ S IEN=+$G(IEN)
 I IEN<1 S Y=$$SITE Q Y
 I $L($P($G(^DIC(4,IEN,99)),U)) Q IEN  ;ok
 D PARENT^XUAF4("VPRZ","`"_IEN,2) S Y=$O(VPRZ("P",0))
 S:Y<1 Y=$$SITE
 Q Y
 ;
SITE() ; -- return current site#
 N Y S Y=+$$SITE^VASITE
 S:Y'>0 Y=$$KSP^XUPARAM("INST")
 Q Y
 ;
DEL1 ; -- ID Action for Delete entities, returns VPR0=data
 N SEQ,VST S VPR0=""
 S SEQ=+$G(FILTER("sequence")) I SEQ,$L($G(DIEN)) D
 . S VPR0=$G(^XTMP("VPR-"_SEQ,DIEN,0)) Q:$L(VPR0)  ;ok
 . ; else get visit# from header node
 . S VST=$P($G(^XTMP("VPR-"_SEQ,DIEN)),U,5) S:VST VPR0="^^"_VST
 Q
 ;
NOQ ; -- no query
 Q
 ;
 ;
VIT1(IEN) ; -- get info for one Vital measurement
 ; returns VPRV array, VPRGMV=VPRV(0), VPRANGE, VPRTYPE to entity
 S IEN=$G(IEN) I IEN="" S DDEOUT=1 Q
 D GETREC^GMVUTL(.VPRV,IEN,1)
 S VPRGMV=$G(VPRV(0)) I '$G(VPRV(0)) S DDEOUT=1 Q
 S VPRTYPE=$$FIELD^GMVGETVT(+$P(VPRGMV,U,3),2)
 I VPRTYPE="WT" D  ;get BMI for weight record
 . I $G(^TMP("VPRGMV",$J,IEN)) S $P(VPRGMV,U,14)=$P(^(IEN),U,14) Q
 . ; get BMI from query array if available, else call GMRVUT0
 . N GMRVSTR,DFN,IDT,BMI
 . S GMRVSTR=VPRTYPE,GMRVSTR(0)=+VPRGMV_U_+VPRGMV_"^1^1",DFN=+$P(VPRGMV,U,2)
 . D EN1^GMRVUT0 S IDT=9999999-(+VPRGMV)
 . S BMI=$P($G(^UTILITY($J,"GMRVD",IDT,VPRTYPE,IEN)),U,14)
 . S:BMI'="" $P(VPRGMV,U,14)=BMI
 . K ^UTILITY($J,"GMRVD")
 S VPRANGE=$S($L(VPRTYPE):$$RANGE^VPRDGMV(VPRTYPE),1:"")
 Q
 ;
VITQUAL ; -- build DLIST(#)=Qualifiers [code^name]
 N I,X,QUALS
 S QUALS=$G(VPRV(5))
 F I=1:1 S X=$P(QUALS,U,I) Q:X=""  S DLIST(I)=X
 Q
 ;
VITCODE(IEN,SFN) ; -- return [first] code for vital type
 ; SubFileNumber = 120.518 for Vital Type
 ;                 120.522 for Vital Qualifier
 N VPRC,IENS,Y
 D GETS^DIQ(SFN,"1,"_IEN_",","**",,"VPRC")
 S IENS=$O(VPRC(SFN_1,""))
 S Y=$S($L(IENS):$G(VPRC(SFN_1,IENS,.01,"I")),1:"")
 Q Y
