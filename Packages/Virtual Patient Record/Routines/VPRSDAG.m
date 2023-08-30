VPRSDAG ;SLC/MKB -- SDA GMR utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**27,28,31**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNPROB                     5703
 ; ^GMPL(125.8                   2974
 ; DIQ                           2056
 ; GMPLEDT3                      2977
 ; GMPLUTL2                      2741
 ; GMRVUT0, ^UTILITY($J          1446
 ; GMVGETVT                      5047
 ; GMVUTL                        5046
 ; LEXTRAN                       4912
 ; RMIMRP                        4745
 ; TIULQ                         2693
 ; XLFDT                        10103
 ;
PROBLEMS ; -- Problem List query
 ; Expects DSTRT, DSTOP, DMAX from DDEGET and returns DLIST(#)=ien
 N ID,VPRSTS,VPRPROB,VPRN,X
 S VPRSTS=$G(FILTER("status")) ;default = all problems
 D LIST^GMPLUTL2(.VPRPROB,DFN,VPRSTS)
 S VPRN=0 F  S VPRN=$O(VPRPROB(VPRN)) Q:(VPRN<1)!(VPRN>DMAX)  D
 . S X=$P(VPRPROB(VPRN),U,6) I X,(X<DSTRT)!(X>DSTOP) Q  ;last updated
 . S DLIST(VPRN)=+VPRPROB(VPRN)
 Q
 ;
PROB1(IEN) ; -- get info for single problem [ID Action]
 I '$G(^AUPNPROB(IEN,0)) S DDEOUT=1 Q
 K GMPFLD,GMPORIG
 D GETFLDS^GMPLEDT3(IEN)
 Q
 ;
SCTTEXT(CODE,IEN) ; -- get Preferred Text for SCT Code
 N Y,GMPDT,LEX,LEXY S Y=""
 S GMPDT=$P($G(^AUPNPROB(IEN,0)),U,8) S:'GMPDT GMPDT=DT
 S LEXY=$$CODE^LEXTRAN(CODE,"SCT",GMPDT)
 S:LEXY>0 Y=$G(LEX("P")) ;preferred term
 Q Y
 ;
PROBCMT(IEN) ; -- return list of comments in
 ; DLIST(#) = id ^ date ^ user ^ type ^ facility ^ text
 N I,J,N,X,FAC S N=0
 S I=0 F  S I=$O(^AUPNPROB(IEN,11,I)) Q:I<1  S FAC=$G(^(I,0)) D
 . S J=0 F  S J=$O(^AUPNPROB(IEN,11,I,11,J)) Q:J<1  S X=$G(^(J,0)) D
 .. Q:$P(X,U,4)'="A"
 .. S Y=$P(X,U,5)_U_$P(X,U,6)_U_U_FAC_U_$P(X,U,3)
 .. S N=N+1,DLIST(N)=J_","_I_","_IEN_U_Y
 Q
 ;
DELETED(IEN,FLD) ; -- return 1 or 0, if FLD value was recently deleted
 N LAST,I,X,Y,WK2
 S IEN=+$G(IEN),FLD=+$G(FLD),Y=0
 S WK2=9999999-$$FMADD^XLFDT(DT,-14) ;Inv 2 weeks ago
 S LAST=+$O(^GMPL(125.8,"AD",IEN,0)) Q:LAST>WK2 Y
 S I=0 F  S I=$O(^GMPL(125.8,"AD",IEN,LAST,I)) Q:I<1  D  Q:Y
 . S X=$G(^GMPL(125.8,I,0))
 . I $P(X,U,2)=FLD,$L($P(X,U,5)),$P(X,U,6)="" S Y=1 Q
 Q Y
 ;
 ;
FIMQ ; -- Functional Independence Measurements query
 ; Expects DSTRT, DSTOP, DMAX from DDEGET
 ; Returns DLIST(#)=ien, VPRSITE array
 N VPRS,VPRN,VPRY,ADM,VPRCNT,RMIMTIME
 D PRM^RMIMRP(.VPRSITE) Q:'$O(VPRSITE(1))
 S DFN=+$G(DFN) Q:DFN<1
 S VPRCNT=0
 S VPRS=1 F  S VPRS=$O(VPRSITE(VPRS)) Q:VPRS<1  D
 . S VPRN=DFN_U_VPRSITE(VPRS)
 . D LC^RMIMRP(.VPRY,VPRN) Q:VPRY(1)<1
 . S VPRN=1 F  S VPRN=$O(VPRY(VPRN)) Q:VPRN<1  D  Q:VPRCNT'<DMAX
 .. S ADM=$$DATE($P(VPRY(VPRN),U,4)) Q:ADM<DSTRT  Q:ADM>DSTOP
 .. S VPRCNT=VPRCNT+1,DLIST(VPRCNT)=+VPRY(VPRN)
 Q
 ;
DATE(X) ; -- Return internal form of date X
 N %DT,Y
 S %DT="" D ^%DT S:Y<1 Y=X
 Q Y
 ;
FIM1(IEN) ; -- get info for one set of measurements [ID Action]
 I '$D(VPRSITE) D PRM^RMIMRP(.VPRSITE) I '$O(VPRSITE(1)) S DDEOUT=1 Q
 D GC^RMIMRP(.VPRM,IEN)
 ; S:'$G(DFN) ??
 N NOTE S NOTE=+$P($G(VPRM(1)),U,12) K VPRTIU
 D EXTRACT^TIULQ(NOTE,"VPRTIU",,"1201;1202;1302",,,"I")
 M VPRM("TIU")=VPRTIU(NOTE)
 Q
 ;
FIMS ; -- get DLIST(#)=name^value of each score
 ; Returns VPRFIMS = Assessment type(s) for ProblemDetail
 N I,J,N,X,NAMES,SCORES,SUM,TYPE
 S N=0,VPRFIMS=""
 S NAMES="Eating^Grooming^Bathing^Dressing - Upper Body^Dressing - Lower Body^Toileting^Bladder Management^Bowel Management^Bed, Chair, Wheelchair^Toilet^Tub, Shower^Walk/Wheelchair^Stairs"
 S NAMES=NAMES_"^Comprehension^Expression^Social Interaction^Problem Solving^Memory"
 S NAMES=NAMES_"^walkMode^comprehendMode^expressMode^Z"
 F I=5:1:9 I VPRM(I)'?1."^" D  ;has data
 . S SCORES=VPRM(I),SUM=$$TOTAL(SCORES) Q:'SUM
 . S TYPE=$S(I=5:"Admission",I=6:"Discharge",I=7:"Interim",I=8:"Follow up",1:"Goals")
 . S VPRFIMS=VPRFIMS_$S(VPRFIMS'="":", ",1:"")_TYPE
 . ; add score set to list
 . S N=N+1,DLIST(N)="Assessment Type^"_TYPE
 . F J=1:1:21 S X=$P(SCORES,U,J),N=N+1,DLIST(N)=$P(NAMES,U,J)_U_X
 . S N=N+1,DLIST(N)="FIM Total^"_SUM
 S:$L(VPRFIMS) VPRFIMS=VPRFIMS_" Assessment"_$S(VPRFIMS[",":"s",1:"")
 Q
 ;
TOTAL(NODE) ; -- Return total of scores, or "" if incomplete
 N SUM,I,X
 S SUM=0 F I=1:1:18 S X=$P(NODE,U,I) S:X SUM=SUM+X I X<1 S SUM="" Q
 Q SUM
 ;
VIT1(IEN) ; -- get info for one Vital measurement, returns VPRGMV=^(0)
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
