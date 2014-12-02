VPRDJ08A ;SLC/MKB -- Documents cont ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^LR                            525
 ; ^RADPT                        2480
 ; ^RARPT                        5605
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
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
 ; ------------------------------------------------------------------
 ; documentClass = CLINICAL PROCEDURES
 ; nationalTitle = 4696566^PROCEDURE REPORT
 ;       Service = 4696471^PROCEDURE
 ;          Type = 4696123^REPORT
 ;
CP(DFN,BEG,END,MAX) ; -- Medicine reports
 N VPRN,VPRX,RTN,TIUN,CONS,VPRD,I,DA,X,Y,%DT,DATE,GBL
 S DFN=+$G(DFN) Q:$G(DFN)<1
 D MDPS1^VPRDJ03(DFN,BEG,END,MAX)             ;gets ^TMP("MDHSP",$J)
 S VPRN=0 F  S VPRN=$O(^TMP("MDHSP",$J,VPRN)) Q:VPRN<1  S VPRX=$G(^(VPRN)) D
 . S RTN=$P(VPRX,U,3,4) ;Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 . S TIUN=+$P(VPRX,U,14)
 . I TIUN D EN1^VPRDJ08(TIUN,38)              ;38=TIU Clinical Document
 . S CONS=+$P(VPRX,U,13) D:CONS DOCLIST^GMRCGUIB(.VPRD,CONS)
 . K DA S I=0 F  S I=$O(VPRD(50,I)) Q:I<1  D
 .. S DA=+VPRD(50,I) Q:DA=TIUN
 .. D EN1^VPRDJ08(DA,38)
 . Q:TIUN!$G(DA)                              ;done [got TIU note(s)]
 . Q:RTN="PR702^MDPS1"                        ;CP, but no TIU note yet
 . Q:RTN="PRPRO^MDPS4"                        ;non-CP procedure
 . ; find ID for pre-TIU report
 . S X=$P(VPRX,U,6),%DT="TXS" D ^%DT Q:Y'>0  S DATE=Y
 . S GBL=+$P(VPRX,U,2)_";"_$$ROOT^VPRDMC(DFN,$P(VPRX,U,11),DATE)
 . I GBL S X=$$CP1(DFN,GBL) D EN1^VPRDJ08(X,"CP")
 K ^TMP("MDHSP",$J),^TMP("VPRTEXT",$J)
 Q
 ;
CP1(DFN,ID) ; -- return report data as TIU string [$$RESOLVE]
 S DFN=+$G(DFN),ID=$G(ID) I DFN<1!'$L(ID) Q ""
 N Y,VPRY,VPRFN,X,NAME,DATE,STS,USER,SIGN,TEXT
 S VPRFN=+$P(ID,"(",2)
 D MEDLKUP^MCARUTL3(.VPRY,VPRFN,+ID)
 I VPRY<1 Q ""  ;error in CP
 S NAME=$P(VPRY,U,9),DATE=$P(VPRY,U,6)
 S X=$$GET1^DIQ(VPRFN,+ID_",",1506)
 S STS=$S($L(X):X,1:"COMPLETED")
 S X=+$$GET1^DIQ(VPRFN,+ID_",",701,"I"),(USER,SIGN)=""
 S:X USER=X_";;"_$P($G(^VA(200,X,0)),U)
 S X=+$$GET1^DIQ(VPRFN,+ID_",",1503,"I")
 S:X SIGN="//"_X_";"_$P($G(^VA(200,X,0)),U)_";"_$$GET1^DIQ(VPRFN,+ID_",",1505,"I")
 ; VST=$$GET1^DIQ(VPRFN,+ID_",",900,"I")
 S Y=ID_U_NAME_U_DATE_U_U_USER_U_U_STS_"^^^2461^"_SIGN
 S:$G(VPRTEXT) TEXT=$$TEXT^VPRDMC(DFN,ID,NAME) ;^TMP("VPRTEXT",$J,ID)
 Q Y
 ;
 ; ------------------------------------------------------------------
 ; documentClass = LR LABORATORY REPORTS
 ; nationalTitle = 4697105^LABORATORY NOTE
 ;       Subject = 4697104^LABORATORY
 ;          Type = 4696120^NOTE
 ;
LR(DFN,BEG,END,MAX) ; -- Lab reports
 N VPRSUB,VPRIDT,VPRITM,VPRTIU,VPRXID,LRDFN,IVDT,VPRN,DA
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 S LRDFN=+$G(^DPT(DFN,"LR")),IVDT=9999999-+$G(^LR(LRDFN,"AU")) ;LR7OB63D error
 K ^TMP("LRRR",$J,DFN) D RR^LR7OR1(DFN,,BEG,END,"AP",,,MAX)
 S VPRSUB="" F  S VPRSUB=$O(^TMP("LRRR",$J,DFN,VPRSUB)) Q:VPRSUB=""  D
 . S VPRIDT=0 F  S VPRIDT=$O(^TMP("LRRR",$J,DFN,VPRSUB,VPRIDT)) Q:VPRIDT<1  I $O(^(VPRIDT,0)) D
 .. S VPRTIU=$S(VPRSUB="AU":$NA(^LR(LRDFN,101)),1:$NA(^LR(LRDFN,VPRSUB,VPRIDT,.05)))
 .. K VPRITM S VPRXID=VPRSUB_";"_VPRIDT
 .. I '$O(@VPRTIU@(0)) S VPRX=$$LR1(DFN,VPRXID) D EN1^VPRDJ08(VPRX,"LR") Q
 .. S VPRN=0 F  S VPRN=$O(@VPRTIU@(VPRN)) Q:VPRN<1  D  ;38=TIU Clin Doc
 ... S DA=+$P($G(@VPRTIU@(VPRN,0)),U,2)
 ... D:DA EN1^VPRDJ08(DA,38)
 K ^TMP("LRRR",$J,DFN),^TMP("VPRTEXT",$J)
 Q
 ;
LR1(DFN,ID) ; -- return report data as TIU string [$$RESOLVE]
 S DFN=+$G(DFN),ID=$G(ID) I DFN<1!'$L(ID) Q ""
 N Y,SUB,IDT,LRDFN,LR0,NAME,LOC,USER,VST,SIGN,TEXT
 K ^TMP("VPRTEXT",$J,ID)
 S SUB=$P(ID,";"),IDT=+$P(ID,";",2),LRDFN=$G(^DPT(DFN,"LR"))
 S LR0=$S(SUB="AU":$G(^LR(LRDFN,"AU")),1:$G(^LR(LRDFN,SUB,IDT,0)))
 S NAME="LR "_$$NAME^VPRDLRA(SUB)_" REPORT"
 S LOC=$P(LR0,U,$S(SUB="AU":5,1:8)) D  ;look-up visit
 . N CDT,SC S CDT=9999999-IDT,SC="",X=0
 . S:$L(LOC) SC=+$O(^SC("B",LOC,0))
 . I CDT,LOC S X=$$GETENC^PXAPI(DFN,CDT,SC)
 . S:X VST=+X
 S X=+$P(LR0,U,$S(SUB="AU":10,1:2)) ;pathologist[author]
 S USER=$S(X:X_";;"_$P($G(^VA(200,X,0)),U),1:""),SIGN=""
 S X=$S(SUB="AU":$P(LR0,U,15,16),1:$P(LR0,U,11)_U_$P(LR0,U,13)) ;released
 S:X SIGN="//"_+$P(X,U,2)_";"_$P($G(^VA(200,+$P(X,U,2),0)),U)_";"_+X
 S Y=ID_U_NAME_U_(9999999-IDT)_U_U_USER_U_LOC_"^COMPLETED^"_$G(VST)_"^^2753^"_SIGN
 S:$G(VPRTEXT) TEXT=$$TEXT^VPRDLRA(DFN,SUB,IDT) ;^TMP("VPRTEXT",$J,ID)
 Q Y
 ;
 ; ------------------------------------------------------------------
 ; nationalTitle = 4695068^RADIOLOGY REPORT
 ;       Subject = 4693357^RADIOLOGY
 ;          Type = 4696123^REPORT
 ;
RA(DFN,BEG,END,MAX) ; -- Radiology reports
 N VPRXID,STS,PSET
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)_"P"
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,BEG,END,MAX)
 S VPRXID="" F  S VPRXID=$O(^TMP($J,"RAE1",DFN,VPRXID)) Q:VPRXID=""  D
 . S STS=$P($G(^TMP($J,"RAE1",DFN,VPRXID)),U,3),PSET=$G(^(VPRXID,"CPRS"))
 . Q:STS="No Report"!(STS="Deleted")  ;!(STS["Draft")
 . I +PSET=2,$G(PSET(+VPRXID,$P(PSET,U,2))) Q  ;already have report
 . S VPRX=$$RA1(DFN,VPRXID) D EN1^VPRDJ08(VPRX,"RA")
 . I +PSET=2 S PSET(+VPRXID,$P(PSET,U,2))=$P(VPRXID,"-",2) ;parent
 K ^TMP($J,"RAE1"),^TMP("VPRTEXT",$J)
 Q
 ;
RA1(DFN,ID) ; -- return report data as TIU string [$$RESOLVE]
 S DFN=+$G(DFN),ID=$G(ID) I DFN<1!'$L(ID) Q ""
 N EXAM,CASE,PROC,RAE3,RAE1,TEXT,I,X,Y,DATE,LOC,STS,IENS,VST,USER,SIGN
 K RPT,^TMP("VPRTEXT",$J,ID)
 S EXAM=DFN_U_$TR(ID,"-","^") D
 . N DFN D EN3^RAO7PC3(EXAM) ;report
 . D EN3^RAO7PC1(EXAM)       ;add'l values
 S CASE=$O(^TMP($J,"RAE3",DFN,0)),PROC=$O(^(CASE,"")),RAE3=$G(^(PROC))
 S RAE1=$G(^TMP($J,"RAE1",DFN,ID))
 I $G(VPRTEXT) D
 . S TEXT=$NA(^TMP("VPRTEXT",$J,ID))
 . S I=0 F  S I=$O(^TMP($J,"RAE3",DFN,CASE,PROC,I)) Q:I<1  S X=^(I),@TEXT@(I)=X
 S DATE=9999999.9999-(+ID),LOC=$P(RAE1,U,7),STS=$P(RAE3,U)
 S IENS=$P(ID,"-",2)_","_+ID_","_DFN_","
 S VST=$$GET1^DIQ(70.03,IENS,27,"I")
 S X=+$G(^TMP($J,"RAE2",DFN,CASE,PROC,"P")),(USER,SIGN)=""
 S:X USER=X_";;"_$P($G(^VA(200,X,0)),U)
 S X=$G(^TMP($J,"RAE2",DFN,CASE,PROC,"V"))
 S:X SIGN="//"_+X_";"_$P($G(^VA(200,+X,0)),U)_";"_$$GET1^DIQ(74,+$P(RAE1,U,5)_",",7,"I")
 I $D(^TMP($J,"RAE3",DFN,"PRINT_SET")) S PROC=$G(^("ORD")) ;use parent, if printset
 S Y=ID_U_PROC_U_DATE_U_U_USER_U_LOC_U_STS_U_VST_"^^1901^"_SIGN
 K ^TMP($J,"RAE3",DFN),^TMP($J,"RAE2",DFN)
 Q Y
