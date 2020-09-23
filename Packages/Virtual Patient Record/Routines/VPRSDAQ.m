VPRSDAQ ;SLC/MKB -- SDA queries ;11/8/18  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,20**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^AUTTHF                       4295
 ; ^DGS(41.1                     3796
 ; ^LR                            525
 ; ^OR(100                       5771
 ; ^ORD(100.98                   6982
 ; ^PXRMINDX                     4290
 ; ^WV(790.05                    5772
 ; %DT                          10003
 ; DGPFAPI                       3860
 ; DIC                           2051
 ; DIQ                           2056
 ; GMPLUTL2                      2741
 ; GMRADPT                      10099
 ; GMRCSLM1, ^TMP("GMRCR",$J)    2740
 ; GMRVUT0, ^UTILITY($J)         1446
 ; IBBAPI                        4419
 ; LR7OR1, ^TMP("LRRR",$J)       2503
 ; MDPS1,^TMP("MDHSP",$J)        4230
 ; ORQ1, ^TM("ORR",$J)           3154
 ; RMIMRP                        4745
 ; SDAMA301, ^TMP($J)            4433
 ; SROESTV                       3533
 ; TIUPP3, ^TMP("TIUPPCV",$J)    2864
 ; TIUVPR                        6077
 ; VADPT2                         325
 ; XLFDT                        10103
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
 I 'GMRAL Q  ;D NKA^VPRDJ02 Q
 S ID=0 F  S ID=+$O(GMRAL(ID)) Q:ID<1  S VPRN=VPRN+1,DLIST(VPRN)=ID Q:VPRN'<DMAX
 Q
 ;
VISITS ; -- Visits
 N IDT,BEG,END,ID,VPRN,VAINDT,VADMVT,VAERR
 S BEG=DSTRT,END=DSTOP D IDT^VPRDVSIT
 S VPRN=0,IDT=BEG
 F  S IDT=$O(^AUPNVSIT("AA",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:VPRN'<DMAX
 . S ID=0 F  S ID=$O(^AUPNVSIT("AA",DFN,IDT,ID)) Q:ID<1  D
 .. I $P($G(^AUPNVSIT(ID,0)),U,7)="H" D  Q:$G(VADMVT)
 ... S VAINDT=(9999999-$P(IDT,"."))_"."_$P(IDT,".",2)
 ... K VADMVT D ADM^VADPT2
 .. S VPRN=VPRN+1,DLIST(VPRN)=ID
 Q
 ;
ADM ; -- Admissions (via Visits)
 N IDT,BEG,END,ID,VPRN,VAINDT,VADMVT,VAERR S VPRN=0
 S BEG=DSTRT,END=DSTOP D IDT^VPRDVSIT
 S IDT=BEG F  S IDT=$O(^AUPNVSIT("AAH",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:VPRN'<DMAX
 . S ID=0 F  S ID=$O(^AUPNVSIT("AAH",DFN,IDT,ID)) Q:ID<1  D
 .. S VAINDT=(9999999-$P(IDT,"."))_"."_$P(IDT,".",2)
 .. D ADM^VADPT2 Q:'$G(VADMVT)
 .. S VPRN=VPRN+1,DLIST(VPRN)=VADMVT_"~"_ID
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
CW ; -- Crisis/Warning notes (alerts) [replaced by CWQ^VPRSDAF in *23]
 N I,X,CNT
 D:$G(DFN) ENCOVER^TIUPP3(DFN)
 S (I,CNT)=0
 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:I<1  S X=$G(^(I)) I $P(X,U,2)="C"!($P(X,U,2)="W") S CNT=CNT+1,DLIST(CNT)=$P(X,U,1,2)
 Q
 ;
LRAP ; -- LR Anatomic Pathology reports [expects LRDFN]
 N SUB,IDT,VPRN,CTR S VPRN=0
 D RR^LR7OR1(DFN,,DSTRT,DSTOP,"AP",,,DMAX)
 S SUB="" F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) Q:SUB=""  D
 . S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  I $O(^(IDT,0)) D
 .. Q:$O(^LR(LRDFN,SUB,IDT,.05,0))        ;report in TIU
 .. Q:'$P($G(^LR(LRDFN,SUB,IDT,0)),U,11)  ;not final results
 .. S VPRN=VPRN+1,DLIST(VPRN)=IDT_","_LRDFN_"~"_SUB
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
LRMI ; -- LR Microbiology reports [expects LRDFN]
 N IDT,VPRN,CTR S VPRN=0
 D RR^LR7OR1(DFN,,DSTRT,DSTOP,"MI",,,DMAX)
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,"MI",IDT)) Q:IDT<1  I $O(^(IDT,0)) D
 . Q:'$P($G(^LR(LRDFN,"MI",IDT,0)),U,3)  ;not final results
 . S VPRN=VPRN+1,DLIST(VPRN)=IDT_","_LRDFN_"~MI"
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
ORDERS(DG) ; -- Orders by Display Group
 N ORDG,ORIGVIEW,ORKID,ORLIST,VPRI,VPRN,ORDER,X3,X4
 S DG=$G(DG,"ALL"),ORDG=+$O(^ORD(100.98,"B",DG,0))
 ; return original view, child orders for Lab
 S ORIGVIEW=2,ORKID=$S(DG="CH":1,DG="LAB":1,1:0)
 D EN^ORQ1(DFN_";DPT(",ORDG,6,,DSTRT,DSTOP,,,,ORKID) S VPRN=0
 S VPRI=0 F  S VPRI=$O(^TMP("ORR",$J,ORLIST,VPRI)) Q:VPRI<1  S ORDER=$G(^(VPRI)) D  Q:VPRN'<DMAX
 . I $P($P(ORDER,U),";",2)>1 Q  ;skip order actions
 . I $O(^OR(100,+ORDER,2,0)) Q  ;skip parent orders
 . S ORDER=+ORDER,X3=$G(^OR(100,ORDER,3)),X4=$G(^(4))
 . Q:$P(X3,U,3)=13  I X4["P",$P(X3,U,3)=1!($P(X3,U,3)=12) Q  ;cancelled
 . Q:$P(X3,U,3)=14              ;lapsed
 . I DG="RX",'$$RX(ORDER) Q     ;skip non-PS in RX group
 . I DG="LAB",$$BB(ORDER) Q     ;skip blood bank in Lab
 . S VPRN=VPRN+1,DLIST(VPRN)=ORDER
 K ^TMP("ORR",$J)
 Q
 ;
RX(ORIFN) ; -- is order really a med? (non-PS order in display group)
 N X,Y,PKG S Y=0
 S X=$P($G(^OR(100,+$G(ORIFN),0)),U,14),PKG=$$GET1^DIQ(9.4,+X_",",1)
 I $E(PKG,1,2)="PS" S Y=1
 Q Y
 ;
BB(ORIFN) ; -- return 1 or 0, if order is for Blood Bank
 N X,Y,DG S Y=0
 S X=$P($G(^OR(100,+$G(ORIFN),0)),U,11),DG=$P($G(^ORD(100.98,+X,0)),U,3)
 I DG="BB"!(DG?1"VB".E) S Y=1
 Q Y
 ;
NONORD ; -- Other orders: not Lab, Rad, or Med
 N ORDG,ORPKG,ORIGVIEW,ORLIST,VPRI,VPRN,ORDER,X
 S ORDG=+$O(^ORD(100.98,"B","ALL",0)) D ORPKG ;get list of pkgs to exclude
 S ORIGVIEW=2 ;get original view of order
 D EN^ORQ1(DFN_";DPT(",ORDG,6,,DSTRT,DSTOP) S VPRN=0
 S VPRI=0 F  S VPRI=$O(^TMP("ORR",$J,ORLIST,VPRI)) Q:VPRI<1  S ORDER=$G(^(VPRI)) D  Q:VPRN'<DMAX
 . I $P($P(ORDER,U),";",2)>1 Q         ;skip order actions
 . Q:$P($G(^OR(100,+ORDER,3)),U,3)=14  ;skip lapsed orders
 . S X=+$P($G(^OR(100,+ORDER,0)),U,14)
 . I $D(ORPKG(X)) Q                    ;skip Lab,Rad,Med
 . S VPRN=VPRN+1,DLIST(VPRN)=+ORDER
 K ^TMP("ORR",$J)
 Q
 ;
ORPKG ; -- get list of pkgs to exclude
 N NMSP,X
 F NMSP="LR","RA","PSG","PSIV","PSJ","PSO","PSH" D
 . S X=+$$FIND1^DIC(9.4,,"QX",NMSP,"C")
 . S:X>0 ORPKG(X)=""
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
SURGERYS ; -- Surgeries
 N VPRY,VPRN,I,X
 D LIST^SROESTV(.VPRY,DFN,DSTRT,DSTOP,DMAX,1)
 S VPRN=0 F  S VPRN=$O(@VPRY@(VPRN)) Q:VPRN<1  I $G(@VPRY@(VPRN)) D
 . S I=+$O(@VPRY@(VPRN,0)) Q:I<1
 . S X=$G(@VPRY@(VPRN,I)) ;TIU ien ^ $$RESOLVE^TIUSRVLO data string
 . I $P(X,U,7)'="completed",$P(X,U,7)'="amended" Q
 . I $P(X,U,2)["Addendum to " Q
 . S DLIST(VPRN)=+$G(@VPRY@(VPRN))
 K @VPRY
 Q
 ;
EXAMS ; -- V Exams (Physical Exams)
 N FNUM S FNUM=9000010.13 G PXRM
 ;
HFACTORS ; -- V Health Factors (Health Concerns)
 N FNUM S FNUM=9000010.23 G PXRM
 ;
CPT ; -- V CPT (Procedures)
 N FNUM S FNUM=9000010.18 G PXRM
 ;
POV ; -- V POV (Diagnosis)
 N FNUM S FNUM=9000010.07 G PXRM
 ;
IMMS ; -- Immunizations
 N FNUM S FNUM=9000010.11 G PXRM
 ;
PXRM ; -- Search PXRM index
 N VPRSTART,VPRSTOP,VPRIDT,VPRN,ID
 S VPRSTART=DSTRT,VPRSTOP=DSTOP,VPRN=0
 D SORT^VPRDJ09 ;sort ^PXRMINDX into ^TMP("VPRPX",$J,IDT)
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRPX",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRN'<DMAX
 . S ID=0 F  S ID=$O(^TMP("VPRPX",$J,VPRIDT,ID)) Q:ID<1  D  Q:VPRN'<DMAX
 .. S VPRN=VPRN+1,DLIST(VPRN)=ID
 K ^TMP("VPRPX",$J)
 Q
 ;
HFM ; -- V Health Factors, for Family History
 N ITEM,DATE,DA,X,VPRN S VPRN=0
 S ITEM=0 F  S ITEM=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM)) Q:ITEM<1  D  Q:VPRN'<DMAX
 . S X=$P($G(^AUTTHF(+ITEM,0)),U) I X'["FAMILY HISTORY",X'["FAMILY HX" Q
 . S DATE=DSTRT F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1!(DATE>DSTOP)  D  Q:VPRN'<DMAX
 .. S DA=0 F  S DA=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA_U_ITEM Q:VPRN'<DMAX
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
 N DA,X0
 S DA=$O(^WV(790.05,"C",DFN,""),-1) Q:'DA  ;last entry
 S X0=$G(^WV(790.05,DA,0))
 ; status=YES, future due date (allow past 14 days)
 I $P(X0,U,3),$P(X0,U,4)'<$$FMADD^XLFDT(DT,-14) S DLIST(1)=DA
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
APPTS ; -- Appointments
 N VPRX,VPRNUM,VPRDT,VPRN
 S VPRX(1)=DSTRT_";"_DSTOP,VPRX(4)=DFN
 S VPRX("FLDS")="1;2;3;10;11;12;22",VPRX("SORT")="P"
 ; appointments
 S VPRX(3)="R;I;NS;NSR;NT" ;no cancelled appt's
 S VPRNUM=$$SDAPI^SDAMA301(.VPRX),(VPRDT,VPRN)=0
 F  S VPRDT=$O(^TMP($J,"SDAMA301",DFN,VPRDT)) Q:VPRDT<1  D  Q:VPRN'<DMAX
 . S VPRN=VPRN+1,DLIST(VPRN)=VPRDT_","_DFN ;^TMP($J,"SDAMA301",DFN,VPRDT)
 ;K ^TMP($J,"SDAMA301",DFN)
 Q
 ;
SCHADMS ; -- Scheduled Admissions
 N VPRA,VPRN S VPRN=0
 S VPRA=0 F  S VPRA=$O(^DGS(41.1,"B",DFN,VPRA)) Q:VPRA<1  D  Q:VPRN'<DMAX
 . S VPRX=$G(^DGS(41.1,VPRA,0))
 . S X=$P(VPRX,U,2) Q:X<DSTRT!(X>DSTOP)  ;out of date range
 . Q:$P(VPRX,U,13)  ;Q:$P(VPRX,U,17)     ;cancelled or admitted
 . S VPRN=VPRN+1,DLIST(VPRN)=VPRA
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
PRF ; -- Patient Record Flags [replaced by PRFQ^VPRSDAF]
 N NUM,I,IEN
 S:$G(DFN) NUM=$$GETACT^DGPFAPI(DFN,"VPRF")
 S I=0 F  S I=$O(VPRF(I)) Q:I<1  I $G(VPRF(I,"CATEGORY"))["NATIONAL" D
 . S IEN=+$G(VPRF(I,"FLAG")) Q:IEN<1
 . S DLIST(I)=IEN_"~"_DFN,VPRF("IDX",IEN)=I
 Q
 ;
PTF ; -- PTF DXLS via ^PXRMINDX(45,"ICD","PNI",DFN,"DXLS",ICD,DATE,DA)
 N VPRSTART,VPRSTOP,VPRIDT,VPRN,ID,X,P80
 S VPRSTART=DSTRT,VPRSTOP=DSTOP,VPRN=0
 D PTF^VPRDJ09 ;sort ^PXRMINDX into ^TMP("VPRPX",$J,IDT)
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRPX",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRN'<DMAX
 . S ID=0 F  S ID=$O(^TMP("VPRPX",$J,VPRIDT,ID)) Q:ID<1  I ID["DXLS" D  Q:VPRN'<DMAX
 .. S VPRN=VPRN+1,DLIST(VPRN)=+ID
 K ^TMP("VPRPX",$J)
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
