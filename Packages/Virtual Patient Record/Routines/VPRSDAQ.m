VPRSDAQ ;SLC/MKB -- SDA queries ;11/8/18  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,20,26,25,27,28,30**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUTTHF                       4295
 ; ^GMR(120.86                   3449
 ; ^LR                            525
 ; ^PXRMINDX                     4290
 ; %DT                          10003
 ; GMPLUTL2                      2741
 ; GMRADPT                      10099
 ; GMRCSLM1, ^TMP("GMRCR",$J)    2740
 ; GMRVUT0, ^UTILITY($J)         1446
 ; IBBAPI                        4419
 ; LR7OR1, ^TMP("LRRR",$J)       2503
 ; MDPS1,^TMP("MDHSP",$J)        4230
 ; RMIMRP                        4745
 ; TIUPP3, ^TMP("TIUPPCV",$J)    2864
 ; TIUVPR                        6077
 ; WVRPCVPR, ^TMP("WVPREGST"     7199
 ;
 ; VistA application queries, return DLIST(#) = record ID
 ; Expects context variables from ^DDEGET [DFN, DSTRT, DSTOP, DMAX]
 ;
PROBLEMS ; -- Problem List
 N ID,VPRSTS,VPRPROB,VPRN,X
 S VPRSTS=$G(FILTER("status")) ;default = all problems
 D LIST^GMPLUTL2(.VPRPROB,DFN,VPRSTS)
 S VPRN=0 F  S VPRN=$O(VPRPROB(VPRN)) Q:(VPRN<1)!(VPRN>DMAX)  D
 . S X=$P(VPRPROB(VPRN),U,6) I X,(X<DSTRT)!(X>DSTOP) Q  ;last updated
 . S DLIST(VPRN)=+VPRPROB(VPRN)
 Q
 ;
ALLERGYS ; -- Allergies/Adverse Reactions
 N GMRA,VPRN,ID
 S VPRN=0,GMRA="0^0^111^0^1"
 I $L($T(EN2^GMRADPT)) D EN2^GMRADPT I 1
 E  D EN1^GMRADPT
 ;I 'GMRAL Q  ;D NKA^VPRDJ02 Q
 S ID=0 F  S ID=+$O(GMRAL(ID)) Q:ID<1  S VPRN=VPRN+1,DLIST(VPRN)=ID Q:VPRN'<DMAX
 Q
 ;
ASSESS ; -- get Assessment #120.86 for patient if none or NKA
 Q:'$G(DFN)  Q:$P($G(^GMR(120.86,DFN,0)),U,2)  ;has allergies
 S DLIST(1)=DFN
 Q
 ;
DOCUMENT ; -- Text Integration Utilities
 N VPRY,VPRI,VPRN
 D LIST^TIUVPR(.VPRY,DFN,38,DSTRT,DSTOP)
 S VPRN=0,VPRI="COUNT"
 F  S VPRI=$O(@VPRY@(VPRI),-1) Q:VPRI<1  D  Q:VPRN'<DMAX
 . S VPRN=VPRN+1,DLIST(VPRN)=+VPRI
 K @VPRY
 Q
 ;
ADVDIR ; -- Adv Directive (alerts)
 N I,AD,TIUD,CNT,STS,NXT
 D:$G(DFN) ENCOVER^TIUPP3(DFN)
 ; ^TMP = IEN^Acronym^Category Name^Optional Subject^Date/Time^Optional Addendum
 ; put AD in Ref D/T order
 S I=0 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:I<1  S AD=$G(^(I)) I $P(AD,U,2)="D" S TIUD($P(AD,U,5))=AD
 Q:'$O(TIUD(0))  ;no AD's for patient
 ; get latest AD, ck if in/active
 S I=+$O(TIUD(""),-1),AD=$G(TIUD(I)),STS="A",NXT=""
 I AD["RESCIND"!($L($P(AD,U,6))) D  ;inactive
 . N ADD,%DT,X,Y S ADD=$P(AD,U,6),STS="I"
 . S X=$P(AD,"addendum ",2),X=$P(X,")")
 . I $L(X) S %DT="TX" D ^%DT S:Y>0 NXT=Y ;end=addendum d/t
 S CNT=1,DLIST(CNT)=+AD_U_STS_U_NXT,NXT=$P(AD,U,5)
 ; add remaining AD's as inactive, using next AD's Ref D/T as its end
 S STS="I" F  S I=$O(TIUD(I),-1) Q:I<1  S AD=$G(TIUD(I)) D
 . S CNT=CNT+1,DLIST(CNT)=+AD_U_STS_U_NXT
 . S NXT=$P(AD,U,5)
 Q
 ;
LRAP ; -- LR Anatomic Pathology reports [expects LRDFN]
 N SUB,IDT,VPRN,CTR S VPRN=0
 D RR^LR7OR1(DFN,,DSTRT,DSTOP,"AP")
 S SUB="" F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) Q:SUB=""  D
 . S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  I $O(^(IDT,0)) D  Q:VPRN'<DMAX
 .. Q:$O(^LR(LRDFN,SUB,IDT,.05,0))        ;report in TIU
 .. Q:'$P($G(^LR(LRDFN,SUB,IDT,0)),U,11)  ;not final results
 .. S VPRN=VPRN+1,DLIST(VPRN)=IDT_","_LRDFN_"~"_SUB
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
LRMI ; -- LR Microbiology reports [expects LRDFN]
 N IDT,VPRN,CTR S VPRN=0
 D RR^LR7OR1(DFN,,DSTRT,DSTOP,"MI")
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,"MI",IDT)) Q:IDT<1  I $O(^(IDT,0)) D  Q:VPRN'<DMAX
 . ;Q:'$P($G(^LR(LRDFN,"MI",IDT,0)),U,3)  ;not final results
 . Q:'$$MI1^VPRSDAB(LRDFN,IDT)  ;not final results
 . S VPRN=VPRN+1,DLIST(VPRN)=IDT_","_LRDFN_"~MI"
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
CONSULTS ; -- Consult/Request Tracking
 N VPRN,VPRX,GMRCDA,GMRCGRP,GMRCSEX,TITLE
 D OER^GMRCSLM1(DFN,"",DSTRT,DSTOP,"") S VPRN=0
 F  S VPRN=$O(^TMP("GMRCR",$J,"CS",VPRN)) Q:VPRN<1!(VPRN>DMAX)  D
 . S VPRX=$G(^TMP("GMRCR",$J,"CS",VPRN,0)) Q:+VPRX<1
 . S DLIST(VPRN)=+VPRX
 K ^TMP("GMRCR",$J,"CS")
 Q
 ;
CPROCS ; -- Clinical Procedures
 N VPRN,VPRX,I,ID S VPRN=0
 D MDPS1^VPRDJ03(DFN,DSTRT,DSTOP,DMAX) ;gets ^TMP("MDHSP",$J)
 S I=0 F  S I=$O(^TMP("MDHSP",$J,I)) Q:I<1  S VPRX=$G(^(I)) I $P(VPRX,U,3)="PR702" D  Q:VPRN'<DMAX
 . Q:'$P(VPRX,U,14)  ;no document yet (so no enc#)
 . S ^TMP("MDHSP",$J,"IEN",+$P(VPRX,U,2))=I
 . S VPRN=VPRN+1,DLIST(VPRN)=+$P(VPRX,U,2)
 ;K ^TMP("MDHSP",$J)
 Q
 ;
IMMS ; -- V Immunizations
 N FNUM S FNUM=9000010.11 G PXRM
 ;
PXRM ; -- Search PXRM index
 N VPRSTART,VPRSTOP,VPRIDT,VPRN,ID
 S VPRSTART=DSTRT,VPRSTOP=DSTOP,VPRN=0
 D SORT^VPRDJ09 ;sort ^PXRMINDX into ^TMP("VPRPX",$J,IDT)
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRPX",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRN'<DMAX
 . S ID=0 F  S ID=$O(^TMP("VPRPX",$J,VPRIDT,ID)) Q:ID<1  D  Q:VPRN'<DMAX
 .. I FNUM=9000010.18,'$$VCPT^VPRSDAVF(ID) Q
 .. S VPRN=VPRN+1,DLIST(VPRN)=ID
 K ^TMP("VPRPX",$J)
 Q
 ;
ICR ; -- V Imm Contraindications/Refusals
 N ROOT,INDX,DATE,IDT,DA,TMP,VPRN S VPRN=0
 ; find records in ^PXRMINDX, sort by date
 S ROOT="^PXRMINDX(9000010.707,""PCI"","_DFN,INDX=ROOT_")",ROOT=ROOT_","
 F  S INDX=$Q(@INDX) Q:INDX'[ROOT  D
 . S DATE=$QS(INDX,6) Q:DATE<DSTRT  Q:DATE>DSTOP
 . S DA=$QS(INDX,8),IDT=9999999-DATE,TMP(IDT,DA)=""
 ; return [DMAX] entries
 S IDT=0 F  S IDT=$O(TMP(IDT)) Q:IDT<1  D  Q:VPRN'<DMAX
 . S DA=0 F  S DA=$O(TMP(IDT,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA
 Q
 ;
HFCVR ; -- V Health Factors, for COVID Vaccination Refusal
 N ITEM,NAME,DATE,DA,X,VPRN S VPRN=0
 S ITEM=+$O(^AUTTHF("B","VA-SARS-COV-2 VACCINE REFUSAL",0)) Q:ITEM<1  D CVR
 S NAME="VA-SARS-COV-2 IMM REFUSAL"
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:NAME'?1"VA-SARS-COV-2 IMM REFUSAL".E  S ITEM=+$O(^(NAME,0)) D CVR
 Q
CVR ;loop for ITEM
 S DATE=DSTRT F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1!(DATE>DSTOP)  D  Q:VPRN'<DMAX
 . S DA=0 F  S DA=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA Q:VPRN'<DMAX
 Q
 ;
HFS ; -- V Health Factors, for Social History
 N ITEM,DATE,DA,VPRN S VPRN=0
 S ITEM=0 F  S ITEM=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM)) Q:ITEM<1  I $$SOCHIST(ITEM) D  Q:VPRN'<DMAX
 . S DATE=DSTRT F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1!(DATE>DSTOP)  D  Q:VPRN'<DMAX
 .. S DA=0 F  S DA=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA_U_ITEM Q:VPRN'<DMAX
 Q
 ;
SOCHIST(IEN) ; -- find social history factors
 N X S X=$P($G(^AUTTHF(+IEN,0)),U)
 I (X["TOBACCO")!(X["SMOK") Q 1
 ;I (X["LIVES")!(X["LIVING") Q 1
 ;I (X["RELIGIO")!(X["SPIRIT") Q 1
 Q 0
 ;
WVPL ; -- Women's Health Pregnancy Log, for Social History
 K ^TMP("WVPREGST",$J)
 D BASELINE^WVRPCVPR(DFN)
 S:$D(^TMP("WVPREGST",$J,"BASELINE")) DLIST(1)=DFN
 ;S:$G(^TMP("WVPREGST",$J,"BASELINE","TO TIME"))'<$$FMADD^XLFDT(DT,-14) DLIST(1)=DFN
 Q
 ;
VITALS ; -- GMR Vital Measurements
 N GMRVSTR,VPRIDT,VPRTYP,ID,VPRN
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN"
 S GMRVSTR(0)=DSTRT_U_DSTOP_U_DMAX_"^1"
 D EN1^GMRVUT0 S VPRN=0
 S VPRIDT=0 F  S VPRIDT=$O(^UTILITY($J,"GMRVD",VPRIDT)) Q:VPRIDT<1  D  Q:VPRN'<DMAX
 . S VPRTYP="" F  S VPRTYP=$O(^UTILITY($J,"GMRVD",VPRIDT,VPRTYP)) Q:VPRTYP=""  D
 .. S ID=$O(^UTILITY($J,"GMRVD",VPRIDT,VPRTYP,0)) Q:'ID
 .. S VPRN=VPRN+1,DLIST(VPRN)=ID
 .. S ^TMP("VPRGMV",$J,ID)=$G(^UTILITY($J,"GMRVD",VPRIDT,VPRTYP,ID))
 K ^UTILITY($J,"GMRVD")
 Q
 ;
INS ; -- Insurance
 N NUM,I,VPRDT,VPRSTS,VPRX
 S VPRSTS=$G(FILTER("status"),"RB"),VPRDT=DT
 I VPRSTS["A" S VPRDT="" ;no date if requesting inactive policies
 S:$G(DFN) NUM=$$INSUR^IBBAPI(DFN,VPRDT,VPRSTS,.VPRX,"*") Q:NUM<1
 S I=0 F  S I=$O(VPRX("IBBAPI","INSUR",I)) Q:I<1  S DLIST(I)=I
 M VPRINS=VPRX("IBBAPI","INSUR")
 Q
 ;
FIM ; -- Functional Independence Measurements
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
NOQ ; -- tag for Entities that should not execute a query
 Q
