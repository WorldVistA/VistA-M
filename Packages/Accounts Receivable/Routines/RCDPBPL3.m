RCDPBPL3 ;EDE/YMG - bill profile special authority screen; 08/21/2025
 ;;4.5;Accounts Receivable;**462**;Mar 20, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
INIT ; initialization for list manager list
 ; requires RCBILLDA
 N DGNTARR,DFN,HNC,LN,STR,TMP,TMP1,TMPDT,VAL,VASV
 S DFN=$$GETDFN^RCDPBPL2(RCBILLDA)
 D SVC^VADPT
 S VAL=$S(VASV(2):"Yes",1:"No")
 S STR=$$SETSTR^VALM1("A/O Exposure: "_VAL,"",14,30)
 S VAL=$S(VASV(2)&VASV(2,1):$$FMTE^XLFDT(VASV(2,1),"2DZ"),VASV(2):"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("A/O Exposure Effective Date: "_VAL,STR,39,50)
 S LN=1 D SET^VALM10(LN,STR)
 S VAL=$S(VASV(3):"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Rad. Exposure: "_VAL,"",13,30)
 S VAL=$S(VASV(3)&VASV(3,1):$$FMTE^XLFDT(VASV(3,1),"2DZ"),VASV(3):"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("Rad. Exposure Effective Date: "_VAL,STR,38,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP=$$GET1^DIQ(2,DFN,.322013,"I")
 S VAL=$S(TMP="Y":"Yes",TMP="N":"No",1:"Unk")
 S STR=$$SETSTR^VALM1("SW Asia Exposure: "_VAL,"",10,30)
 S TMPDT=$$GET1^DIQ(2,DFN,.322014,"I")
 S VAL=$S(TMP="Y"&TMPDT:$$FMTE^XLFDT(TMPDT,"2DZ"),TMP="Y":"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("SW Asia Exposure Effective Date: "_VAL,STR,35,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP=$$GET1^DIQ(2,DFN,.321701,"I")
 S VAL=$S(TMP="Y":"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Camp Lejeune: "_VAL,"",14,30)
 S TMPDT=$$GET1^DIQ(2,DFN,.321702,"I")
 S VAL=$S(TMP="Y"&TMPDT:$$FMTE^XLFDT(TMPDT,"2DZ"),TMP="Y":"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("Camp Lejeune Effective Date: "_VAL,STR,39,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S HNC=$$GETCUR^DGNTAPI(DFN)
 S TMP=$P($G(DGNTARR("IND")),U)
 S VAL=$S(TMP="Y":"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Head/Neck Cancer: "_VAL,"",10,30)
 S TMPDT=$G(DGNTARR("VDT"))
 S VAL=$S(TMP="Y"&TMPDT:$$FMTE^XLFDT(TMPDT,"2DZ"),TMP="Y":"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("Head/Neck Cancer Effective Date: "_VAL,STR,35,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP=$$GETSTAT^DGMSTAPI(DFN,DT),TMP1=$P(TMP,U,2)
 S VAL=$S($P(TMP,U)>0:$S(TMP1="Y":"Yes",TMP1="N":"No",TMP1="D":"Dec",1:"Unk"),1:"N/A")
 S STR=$$SETSTR^VALM1("MST: "_VAL,"",23,30)
 S TMPDT=$P(TMP,U,3)
 S VAL=$S($P(TMP,U)>0:$S(TMP1="Y"&TMPDT:$$FMTE^XLFDT(TMPDT,"2DZ"),TMP1="Y":"Missing",1:"N/A"),1:"N/A")
 S STR=$$SETSTR^VALM1("MST Effective Date: "_VAL,STR,48,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S VAL=$S(VASV(14,1):"Yes",1:"No")
 S STR=$$SETSTR^VALM1("SHAD/Project 112: "_VAL,"",10,30)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP=$$GET1^DIQ(2,DFN,.32116,"I")
 S VAL=$S(TMP=1:"Yes",TMP=0:"No",1:"Unk")
 S STR=$$SETSTR^VALM1("TERA: "_VAL,"",22,30)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP=$$GET1^DIQ(2,DFN,.541,"I")
 S VAL=$S(TMP="Y":"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Medal of Honor: "_VAL,"",12,30)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S VAL=$S(VASV(9):"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Purple Heart: "_VAL,"",14,30)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP=$$DISABLED^DGENCDA(DFN)
 S VAL=$S(TMP:"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Catastrophically Disabled: "_VAL,"",1,30)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S VAL=$S(VASV(4):"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Prisoner of War: "_VAL,"",11,30)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S VALMCNT=LN
 Q
 ;
HDR ; list manager display header
 ; requires RCBILLDA
 N DATA,PRCOUT,RCDEBTDA
 S RCDEBTDA=$P(^PRCA(430,RCBILLDA,0),U,9),DATA=$$ACCNTHDR^RCDPAPLM(RCDEBTDA)
 ; get EEOB indicator for 1st/3rd party payment and attach to bill when applicable
 S PRCOUT=$$COMP3^PRCAAPR(RCBILLDA) S:PRCOUT'="%" PRCOUT=$$IBEEOBCK^PRCAAPR1(RCBILLDA)
 S VALMHDR(1)=$$LJ^XLFSTR("Bill #: "_PRCOUT_$$GET1^DIQ(430,RCBILLDA,.01),28)_$$LJ^XLFSTR("Account: "_$P(DATA,U)_$P(DATA,U,2),50)
 S VALMSG="|% EEOB | Enter ?? for more actions |"
 Q
 ;
EXIT ;  exit list manager
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
