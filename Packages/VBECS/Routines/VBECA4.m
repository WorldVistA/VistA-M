VBECA4 ;HINES OI/REL-APIs for Health Summary ;10/12/00  14:02
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Call to $$FMTE^XLFDT is supported by IA: 10103
 ; Call to EN^DIQ is supported by IA: 10004
 ; Call to $$NS^XUAF4 is supported by IA: 2171
 ; Reference to $$LRDFN^LR7OR1 supported by IA #2503
 ; 
 QUIT
 ;
 ; ----------------------------------------------------------------
 ;       Private Method Supports IA 3176
 ; ----------------------------------------------------------------
TRAN(DFN,TMPLOC,GMTS1,GMTS2) ; Get Transfusion Data for Health Summary
 ; Input variables:
 ;   DFN = Internal number of patient
 ;   TMPLOC = Node in ^TMP to be used for output data array
 ;   GMTS1 = Inverse end date of search
 ;   GMTS2 = Inverse start date of search
 ;
 ; Output is data array:
 ;   ^TMP(TMPLOC,$J,n)
 N LRDFN,IDT,CNTR,TR,PN,PRODUCT,UNITS,TDT,ITDT,ARR
 Q:$G(TMPLOC)=""
 K ^TMP(TMPLOC,$J)
 Q:'$G(DFN)
 S:'$G(GMTS1) GMTS1=5555555 S:'$G(GMTS2) GMTS2=9999999
 ;
 D TRAN^VBECA1B(DFN)
 S IDT=GMTS1-1 F  S IDT=$O(ARR(IDT)) Q:+IDT'>0!(IDT>GMTS2)  D
 . S ^TMP(TMPLOC,$J,IDT)=ARR(IDT)
 . S ^TMP(TMPLOC,$J,$P($P(ARR(IDT),"\",2),";"))=ARR($P($P(ARR(IDT),"\",2),";"))
 M ^TMP("ZBNT",$J)=^TMP(TMPLOC,$J)
 Q
 ;
 S LRDFN=$$LRDFN^LR7OR1(DFN) Q:'LRDFN
 S IDT=GMTS1-1 F  S IDT=$O(^LR(LRDFN,1.6,IDT)) Q:+IDT'>0!(IDT>GMTS2)  D
 . S TR=$G(^LR(LRDFN,1.6,IDT,0)) D SET
 S IDT=0 F  S IDT=$O(CNTR(IDT)) Q:+IDT'>0  D
 . S ^TMP(TMPLOC,$J,IDT)=9999999-IDT_U
 . S PN=0 F  S PN=$O(CNTR(IDT,PN)) Q:PN'>0  D
 . . S PRODUCT=$G(^LAB(66,+PN,0)),^TMP(TMPLOC,$J,$P(PRODUCT,U,2))=$P(PRODUCT,U)
 . . S ^TMP(TMPLOC,$J,IDT)=^TMP(TMPLOC,$J,IDT)_CNTR(IDT,PN)_"\"_$P(PRODUCT,U,2)_";"
 Q
 ; ------------------------------------------------------------------
 ;       Private Method Supports IA 3177
 ; ------------------------------------------------------------------
AVUNIT(DFN,TMPLOC,GMTS1,GMTS2,GMTSNDM) ; Get Available Units for Health Summary
 ; Input variables:
 ;   DFN = Internal number of patient
 ;   TMPLOC = Node in ^TMP to be used for output data array
 ;   GMTS1 = Inverse end date of search
 ;   GMTS2 = Inverse start date of search
 ;   GMTSNDM = Maximum number to be extracted
 ;
 ; Output is data array:
 ;   ^TMP(TMPLOC,$J,n)
 N LRDFN,IDT,UN,CNT,ABO,ADT,COMP,DTYP,EDT,EFLG,GMI,RH,UDIV,UID,ULOC,VOL,ARR
 Q:$G(TMPLOC)=""
 K ^TMP(TMPLOC,$J)
 Q:'$G(DFN)
 S:'$G(GMTS1) GMTS1=5555555 S:'$G(GMTS2) GMTS2=9999999 S:'$G(GMTSNDM) GMTSNDM=999
 ; VBECS Implementation
 D AVUNIT^VBECA1B("AVUNIT",DFN)
 Q:'$D(^TMP("AVUNIT",$J))
 S IDT=GMTS1-1+.0001 F  S IDT=$O(^TMP("AVUNIT",$J,IDT)) Q:+IDT'>0!(IDT>GMTS2)  D
 . S ^TMP(TMPLOC,$J,0)=^TMP("AVUNIT",$J,0)
 . S ^TMP(TMPLOC,$J,IDT)=^TMP("AVUNIT",$J,IDT)
 Q
 ;
 S LRDFN=$$LRDFN^LR7OR1(DFN) Q:'LRDFN
 I $L($P(^LR(LRDFN,0),U,5,6)) S ^TMP(TMPLOC,$J,0)=$P(^(0),U,5)_U_$P(^(0),U,6)
 S UN="",CNT=0 F  S UN=$O(^LRD(65,"AP",LRDFN,UN)) Q:UN=""!(CNT'<GMTSNDM)  D BASET
 ;K:'CNT ^TMP(TMPLOC,$J)
 Q
BASET ; Sets ^TMP with data elements
 S (EFLG,DTYP,ULOC)=""
 S UID=$P(^LRD(65,UN,0),U),EDT=$P(^(0),U,6),ABO=$P(^(0),U,7),RH=$P(^(0),U,8),VOL=$P(^(0),U,11),COMP=$P(^LAB(66,$P(^LRD(65,UN,0),U,4),0),U)
 S ADT=$P(^LRD(65,UN,2,LRDFN,0),U,2)
 S UDIV=$P(^LRD(65,UN,0),U,16),UDIV=$$NS^XUAF4(UDIV),UDIV=$P(UDIV,"^",1) ;Gets division unit is located at
 I $D(^LRD(65,UN,8)) D
 . S DIC=65,DIQ="DON",DIQ(0)="E",DR=8.3,DA=UN D EN^DIQ1
 . S:$D(DON) DTYP=DON(65,UN,8.3,"E") K DA,DIC,DIQ,DON,DR Q
 S GMI=$O(^LRD(65,UN,3,0)) I +GMI>0 D
 . S ULOC=$P($G(^LRD(65,UN,3,GMI,0)),U,4)
 ; If unit will expire w/in 48 hrs, flag with "*"; w/in 24 hrs, flag with "**"
 I EDT>DT S EFLG=$S(EDT-DT<2:"*",EDT-DT<1:"**",1:"")
 S IDT=9999999-ADT
 I $S(IDT<GMTS1:1,IDT>GMTS2:1,EDT<DT:1,1:0) Q
 S EDT=$TR($$FMTE^XLFDT(EDT,"5DZ"),"@"," ")
 F  Q:'$D(^TMP(TMPLOC,$J,IDT))  S IDT=IDT+.0001
 S ^TMP(TMPLOC,$J,IDT)=EFLG_U_EDT_U_UID_U_COMP_U_VOL_U_ABO_U_RH_U_DTYP_U_UDIV_U_ULOC
 S CNT=CNT+1
 Q
SET ; Sets CNTR w/appropriate data
 S TDT=9999999-IDT,ITDT=9999999-$P(TDT,".")
 S UNITS=+$P(TR,U,7) S:UNITS'>0 UNITS=1
 S CNTR(ITDT,+$P(TR,U,2))=+$G(CNTR(ITDT,+$P(TR,U,2)))+UNITS
 Q
