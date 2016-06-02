HMPDJ08A ;SLC/MKB,ASMR/RRB - TIU Documents continued;10/29/2015 12:08:30
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Called by HMPDJ08
 ;
 ;pass HMPXX from CP1 section 12.2.14 agilex/js
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LR                            525
 ; ^RADPT                        2480
 ; ^RARPT                        8000005
 ; ^SC                          10040
 ; ^TMP("MDHSP" [MDPS1]          4230
 ; ^VA(200                      10060
 ; %DT                          10003
 ; DIQ                           2056
 ; GMRCGUIB                      2980
 ; LR7OR1,^TMP("LRRR"            2503
 ; MCARUTL3                      3280
 ; PXAPI                         1894
 ; RAO7PC1                  2043,2265
 ; RAO7PC3                       2877
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 ;
 ; ------------------------------------------------------------------
 ; documentClass = CLINICAL PROCEDURES
 ; nationalTitle = 4696566^PROCEDURE REPORT
 ;       Service = 4696471^PROCEDURE
 ;          Type = 4696123^REPORT
 Q
 ;
CP(DFN,BEG,END,MAX) ; -- Medicine reports
 N HMPN,HMPX,RTN,TIUN,CONS,HMPD,I,DA,X,Y,%DT,DATE,GBL
 S DFN=+$G(DFN) Q:$G(DFN)<1
 D MDPS1^HMPDJ03(DFN,BEG,END,MAX)             ;gets ^TMP("MDHSP",$J)
 S HMPN=0 F  S HMPN=$O(^TMP("MDHSP",$J,HMPN)) Q:HMPN<1  S HMPX=$G(^(HMPN)) D
 . N $ES,$ET,ERRPAT,ERRMSG
 . S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 . S ERRMSG="A problem occurred converting a medicine report."
 . S RTN=$P(HMPX,U,3,4)  Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 . S TIUN=+$P(HMPX,U,14)
 . I TIUN D EN1^HMPDJ08(TIUN,38)              ;38=TIU Clinical Document
 . S CONS=+$P(HMPX,U,13) D:CONS DOCLIST^GMRCGUIB(.HMPD,CONS)
 . K DA S I=0 F  S I=$O(HMPD(50,I)) Q:I<1  D
 .. S DA=+HMPD(50,I) Q:DA=TIUN
 .. D EN1^HMPDJ08(DA,38)
 . Q:TIUN!$G(DA)                              ;done [got TIU note(s)]
 . Q:RTN="PR702^MDPS1"                        ;CP, but no TIU note yet
 . Q:RTN="PRPRO^MDPS4"                        ;non-CP procedure
 . ; find ID for pre-TIU report
 . S X=$P(HMPX,U,6),%DT="TXS" D ^%DT Q:Y'>0  S DATE=Y
 . S GBL=+$P(HMPX,U,2)_";"_$$ROOT^HMPDMC(DFN,$P(HMPX,U,11),DATE)
 . I GBL S X=$$CP1(DFN,GBL)
 . I $G(HMPXX)]"" D EN1^HMPDJ08(HMPXX,"CP") ;  pass HMPXX from CP1 section 12.2.14 js
 K ^TMP("MDHSP",$J),^TMP("HMPTEXT",$J)
 K HMPXX
 Q
 ;
CP1(DFN,ID) ; -- return report data as TIU string [$$RESOLVE] /DE2818
 S DFN=+$G(DFN),ID=$G(ID) I DFN<1!'$L(ID) Q ""
 N Y,HMPY,HMPFN,X,NAME,DATE,STS,USER,SIGN,TEXT
 S HMPFN=+$P(ID,"(",2) ; example 699.5
 D MEDLKUP^MCARUTL3(.HMPY,HMPFN,+ID)
 I HMPY<1 Q ""  ;error in CP
 S NAME=$P(HMPY,U,9),DATE=$P(HMPY,U,6)
 S X=$$GET1^DIQ(HMPFN,+ID_",",1506)
 S STS=$S($L(X):X,1:"COMPLETED")
 S X=+$$GET1^DIQ(HMPFN,+ID_",",701,"I"),(USER,SIGN)=""
 S:X USER=X_";;"_$P($G(^VA(200,X,0)),U) ;ICR 10060 DE2818 ASF 11/10/15
 S X=+$$GET1^DIQ(HMPFN,+ID_",",1503,"I")
 S:X SIGN="//"_X_";"_$P($G(^VA(200,X,0)),U)_";"_$$GET1^DIQ(HMPFN,+ID_",",1505,"I") ;ICR 10060 DE2818 ASF 11/10/15
 ; VST=$$GET1^DIQ(HMPFN,+ID_",",900,"I")
 S Y=ID_U_NAME_U_DATE_U_U_USER_U_U_STS_"^^^2461^"_SIGN
 S HMPXX=ID_U_NAME_U_DATE_U_U_USER_U_U_STS_"^^^2461^"_SIGN ; 12.2.14 js
 S:$G(HMPTEXT) TEXT=$$TEXT^HMPDMC(DFN,ID,NAME) ;^TMP("HMPTEXT",$J,ID)
 Q Y
 ;
 ; ------------------------------------------------------------------
 ; documentClass = LR LABORATORY REPORTS
 ; nationalTitle = 4697105^LABORATORY NOTE
 ;       Subject = 4697104^LABORATORY
 ;          Type = 4696120^NOTE
 ;
LR(DFN,BEG,END,MAX) ; -- Lab reports
 N HMPSUB,HMPIDT,HMPITM,HMPTIU,HMPXID,LRDFN,IVDT,HMPN,DA
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S LRDFN=+$G(^DPT(DFN,"LR")),IVDT=9999999-+$G(^LR(LRDFN,"AU")) ;LR7OB63D error
 K ^TMP("LRRR",$J,DFN) D RR^LR7OR1(DFN,,BEG,END,"MIAP",,,MAX)
 S HMPSUB="" F  S HMPSUB=$O(^TMP("LRRR",$J,DFN,HMPSUB)) Q:HMPSUB=""  D
 . S HMPIDT=0 F  S HMPIDT=$O(^TMP("LRRR",$J,DFN,HMPSUB,HMPIDT)) Q:HMPIDT<1  I $O(^(HMPIDT,0)) D
 .. S HMPTIU=$S(HMPSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,HMPSUB,HMPIDT,.05)))
 .. K HMPITM S HMPXID=HMPSUB_";"_HMPIDT
 .. I '$O(@HMPTIU@(0)) S HMPX=$$LR1(DFN,HMPXID) D EN1^HMPDJ08(HMPX,"LR") Q
 .. S HMPN=0 F  S HMPN=$O(@HMPTIU@(HMPN)) Q:HMPN<1  D  ;38=TIU Clin Doc
 ... S DA=+$P($G(@HMPTIU@(HMPN,0)),U,2)
 ... D:DA EN1^HMPDJ08(DA,38)
 K ^TMP("LRRR",$J,DFN),^TMP("HMPTEXT",$J)
 Q
 ;
LR1(DFN,ID) ; -- return report data as TIU string [$$RESOLVE]
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting lab report "_ID
 S DFN=+$G(DFN),ID=$G(ID) I DFN<1!'$L(ID) Q ""
 N Y,SUB,IDT,LRDFN,LR,NAME,LOC,USER,VST,SIGN,TEXT
 K ^TMP("HMPTEXT",$J,ID)
 S SUB=$P(ID,";"),IDT=+$P(ID,";",2),LRDFN=$G(^DPT(DFN,"LR")) ;ICR 10035 DE 2818 ASF 11/10/15
 S LR=$S(SUB="AU":$G(^LR(LRDFN,"AU")),1:$G(^LR(LRDFN,SUB,IDT,0)))
 S NAME="LR "_$$NAME^HMPDLRA(SUB)_" REPORT"
 S LOC=$P(LR,U,$S(SUB="AU":5,1:8)) D  ;look-up visit
 . N CDT,SC S CDT=9999999-IDT,SC="",X=0
 . S:$L(LOC) SC=+$O(^SC("B",LOC,0)) ;ICR 10040 DE2818 ASF 11/10/15
 . I CDT,LOC S X=$$GETENC^PXAPI(DFN,CDT,SC)
 . S:X VST=+X
 S X=+$P(LR,U,$S(SUB="AU":10,SUB="MI":4,1:2)) ;pathologist[author]
 S USER=$S(X:X_";;"_$P($G(^VA(200,X,0)),U),1:""),SIGN="" ;ICR 10060 DE2818 ASF 11/10/15
 S X=$S(SUB="AU":$P(LR,U,15,16),SUB="MI":$P(LR,U,3,4),1:$P(LR,U,11)_U_$P(LR,U,13)) ;released
 S:X SIGN="//"_+$P(X,U,2)_";"_$P($G(^VA(200,+$P(X,U,2),0)),U)_";"_+X ;ICR 10060 DE2818 ASF 11/10/15
 S Y=ID_U_NAME_U_(9999999-IDT)_U_U_USER_U_LOC_"^COMPLETED^"_$G(VST)_"^^2753^"_SIGN
 S:$G(HMPTEXT) TEXT=$$TEXT^HMPDLRA(DFN,SUB,IDT) ;^TMP("HMPTEXT",$J,ID)
 Q Y
 ;
 ; ------------------------------------------------------------------
 ; nationalTitle = 4695068^RADIOLOGY REPORT
 ;       Subject = 4693357^RADIOLOGY
 ;          Type = 4696123^REPORT
 ;
RA(DFN,BEG,END,MAX) ; -- Radiology reports
 N HMPXID,STS,PSET
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)_"P"
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 S HMPXID="" F  S HMPXID=$O(^TMP($J,"RAE1",DFN,HMPXID)) Q:HMPXID=""  D
 . S STS=$P($G(^TMP($J,"RAE1",DFN,HMPXID)),U,3),PSET=$G(^(HMPXID,"CPRS"))
 . Q:STS="No Report"!(STS="Deleted")  ;!(STS["Draft")
 . I +PSET=2,$G(PSET(+HMPXID,$P(PSET,U,2))) Q  ;already have report
 . S HMPX=$$RA1(DFN,HMPXID) D EN1^HMPDJ08(HMPX,"RA")
 . I +PSET=2 S PSET(+HMPXID,$P(PSET,U,2))=$P(HMPXID,"-",2) ;parent
 K ^TMP($J,"RAE1"),^TMP("HMPTEXT",$J)
 Q
 ;
RA1(DFN,ID) ; -- return report data as TIU string [$$RESOLVE]
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting radiology report "_ID
 S DFN=+$G(DFN),ID=$G(ID) I DFN<1!'$L(ID) Q ""
 N EXAM,CASE,PROC,RAE3,RAE1,TEXT,I,X,Y,DATE,LOC,STS,IENS,VST,USER,SIGN
 K RPT,^TMP("HMPTEXT",$J,ID)
 S EXAM=DFN_U_$TR(ID,"-","^") D
 . N DFN D EN3^RAO7PC3(EXAM) ;report
 . D EN3^RAO7PC1(EXAM)       ;add'l values
 S CASE=$O(^TMP($J,"RAE3",DFN,0)),PROC=$O(^(CASE,"")),RAE3=$G(^(PROC))
 S RAE1=$G(^TMP($J,"RAE1",DFN,ID))
 I $G(HMPTEXT) D
 . S TEXT=$NA(^TMP("HMPTEXT",$J,ID))
 . S I=0 F  S I=$O(^TMP($J,"RAE3",DFN,CASE,PROC,I)) Q:I<1  S X=^(I),@TEXT@(I)=X
 S DATE=9999999.9999-(+ID),LOC=$P(RAE1,U,7),STS=$P(RAE3,U)
 S IENS=$P(ID,"-",2)_","_+ID_","_DFN_","
 S VST=$$GET1^DIQ(70.03,IENS,27,"I")
 S X=+$G(^TMP($J,"RAE2",DFN,CASE,PROC,"P")),(USER,SIGN)=""
 S:X USER=X_";;"_$P($G(^VA(200,X,0)),U) ;ICR 10060 DE2818 ASF 11/10/15
 S X=$G(^TMP($J,"RAE2",DFN,CASE,PROC,"V"))
 S:X SIGN="//"_+X_";"_$P($G(^VA(200,+X,0)),U)_";"_$$GET1^DIQ(74,+$P(RAE1,U,5)_",",7,"I") ;ICR 10060 DE2818 ASF 11/10/15
 I $D(^TMP($J,"RAE3",DFN,"PRINT_SET")) S PROC=$G(^("ORD")) ;use parent, if printset
 S Y=ID_U_PROC_U_DATE_U_U_USER_U_LOC_U_STS_U_VST_"^^1901^"_SIGN
 K ^TMP($J,"RAE3",DFN),^TMP($J,"RAE2",DFN)
 Q Y
