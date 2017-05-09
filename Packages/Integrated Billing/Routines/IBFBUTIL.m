IBFBUTIL ;ALB/RED - API for EDI-CPAC (IB*2.0*554) ;10/01/15
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; Routine cannot be called directly
 ;
 ;Special note: We are creating and using a few new global nodes in file #360 that are not defined in FM.
 ; If they are defined in FM we lose control over them, and a re-index could cause them to get reset causing possible data corruption.
 ; They only exist as temporary flags for our work list functionality.
 ;
 ;  ^IBFB(360,"DFN",DFN,DT,IEN,IBLOG)=""  Log cross reference by Patient
 ;  ^IBFB(360,"DT",DT,DFN,IEN,IBLOG)=""  Log cross reference by Date
 ;
EVENT(DFN) ;  IB*2.0*554
 ;Input: DFN
 ;Output: none
 Q  ; DO NOT LOG AUTHS FOR THE TIME BEING - WORKLIST HAS BEEN DISABLED
 N DIKIEN,AUTH,IENS,IBFBDT,FDA,IBIENS,IBEVENT,IBLOG,IBMOD,DELFLG,IENROOT,IEN,LOGIEN
 S (IEN,DIKIEN,IENS)=0
 S DELFLG=$G(D)  ;Kill entry flag
 I $G(DA)'="",DA'=DFN S AUTH=DA
 I $G(AUTH)="",$G(D1)'="" S AUTH=D1
 S DK=$G(DK)
 I 'DK,$G(DIVAL)="" S:$G(DIVALUE)'="" DIVAL=DIVALUE   ;(From Date verification)
 Q:'$G(DFN)
 Q:'$G(AUTH)
 S IBFBDT=$$NOW^XLFDT()  ;Used for date/time
 ;Add entry into IBFB TRACKING file (#360)
 S IBIENS="+1,",IENS=$P(^IBFB(360,0),U,3)+1
 ;For deleted Auth's remove a few entries and set a delete date
 I DELFLG D
 . K FDA
 . S DIKIEN=$O(^IBFB(360,"D",DFN,AUTH,0)) Q:DIKIEN=""
 . S FDA(360,DIKIEN_",",.03)="@",FDA(360,DIKIEN_",",.04)=IBFBDT  ;If Auth is deleted only delete the entry in that field, leaving the other entries
 . K ^IBFB(360,"IV",DIKIEN)
 ;Add/edit
 I 'DELFLG D
 . K FDA
 . S FDA(360,IBIENS,.01)=IENS,FDA(360,IBIENS,.02)=DFN,FDA(360,IBIENS,.03)=AUTH   ;,FDA(360,IBIENS,.09)=IBFBDT
 . S IENROOT="" ; Adding new entry)
 I 'DELFLG D UPDATE^DIE("","FDA","IENROOT")
 I DELFLG D UPDATE^DIE("","FDA")
 S IEN=+$G(IENROOT(1))
 I 'IEN,$G(DIKIEN)'="" S IEN=$G(DIKIEN)
 Q:'IEN
 D  ;SET LOG FILE ENTRIES
 . K FDA N IENROOT S IENROOT=""
 . S FDA(360.04,"+1,"_IEN_",",.01)=IBFBDT,FDA(360.04,"+1,"_IEN_",",.03)=DUZ
 . S IBMOD=0,IBLOG=$P($G(^IBFB(360,IENS,4,0)),U,3)
 . I IBLOG'="" S IBMOD=1
 . S IBEVENT=$S(DELFLG:"Auth deleted",IBMOD=0:"Auth log-IV queue",1:"Auth mod-IV queue")
 . S FDA(360.04,"+1,"_IEN_",",.02)=IBEVENT
 . D UPDATE^DIE("","FDA","IENROOT")
 ;LOG ENTRY AND CROSS REFERENCES 
 I 'DELFLG S IEN=IENROOT(1) D
 . ;Set IEN in IV field/cross-reference
 . K FDA
 . S FDA(360,IEN_",",2.01)="IV"
 . D UPDATE^DIE("","FDA")
 ; These cannot easily be set in FM, we don't have a date and we can't easily get the IBLOG IEN
 S LOGIEN=0,LOGIEN=$P(^IBFB(360,IEN,4,0),U,3)
 S ^IBFB(360,"DFN",DFN,IBFBDT,IEN,LOGIEN)="",^IBFB(360,"DT",IBFBDT,DFN,IEN,LOGIEN)=""
 Q
 ;
GETAUTH(IENS,AUTHARR) ;  API to call Authorization Data 
 D GETS^DIQ(161.01,IENS,".01;.02;.021;.03;.04;.055;.06;.065;.07;.08;.085;.086;.087;.095;.096;.097;101;104;105","IEN",AUTHARR)
 Q
 ;
GETST(IEN) ; Get Start Date using Invoice
 N IBFLDS,IBINIEN,IBINLN1,IBFBLN2,IBFPNO1
 S IBINV=$$GET1^DIQ(360,IEN_",",1.03,"I")  ; Invoice #
 S IBFPNO=$$GET1^DIQ(161.01,IBIEN_",",.03,"I")  ; NVC IEN (Type) on FEE BASIS PROGRAM File (#161.8)
 ; For Billing Worklist Only, NVC may have changed -- Check Fee Basis Payment File (#162)
 I IBINV'="" D
 . S IBINIEN=$O(^FBAAC("C",IBINV,DFN,""))
 . S IBINLN1=$O(^FBAAC("C",IBINV,DFN,IBINIEN,""))
 . S IBINLN2=$O(^FBAAC("C",IBINV,DFN,IBINIEN,IBINLN1,""))
 . S IBFPNO1=$$GET1^DIQ(162.03,IBINLN2_","_IBINLN1_","_IBINIEN_","_DFN_",",23,"I")
 . S IBFPNOT=$$GET1^DIQ(162.03,IBINLN2_","_IBINLN1_","_IBINIEN_","_DFN_",",23,"E")
 . S IBFPNUM=IBFPNO1
 . I $G(IBFPNOT)'="" S IBFP=IBFPNOT
 . S IBST=$$GET1^DIQ(162.02,IBINLN1_","_IBINIEN_","_DFN_",",".01","I") ; Initial Treatment Date
 Q
 ; 
GETPAY(IEN) ; Get NVC Payment Data using Invoice
 N IBFLDS,IBINIEN,IBINLN1,IBINLN2,IBFPNO1,IBFBVP
 S IBINV=$$GET1^DIQ(360,IEN_",",1.03,"I")  ; Invoice #
 S IBFPNO=$$GET1^DIQ(161.01,IBIEN_",",.03,"I")  ; NVC IEN (Type) on FEE BASIS PROGRAM File (#161.8)
 ; For Billing Worklist Only, NVC may have changed -- Check Fee Basis Payment File (#162)
 I IBINV'="" D
 . S IBINIEN=""
 . F  S IBINIEN=$O(^FBAAC("C",IBINV,DFN,IBINIEN)) Q:IBINIEN=""  D
 .. S IBINLN1=""
 .. F  S IBINLN1=$O(^FBAAC("C",IBINV,DFN,IBINIEN,IBINLN1)) Q:IBINLN1=""  D
 ... S IBINLN2=""
 ... F  S IBINLN2=$O(^FBAAC("C",IBINV,DFN,IBINIEN,IBINLN1,IBINLN2)) Q:IBINLN2=""  D
 .... S IBFPNO1=$$GET1^DIQ(162.03,IBINLN2_","_IBINLN1_","_IBINIEN_","_DFN_",",23,"I")
 .... I $G(IBFPNO1)'="" S IBFPNO=IBFPNO1
 .... S IBFBVP=$$GET1^DIQ(162.03,IBINLN2_","_IBINLN1_","_IBINIEN_","_DFN_",",24,"I")
 .... I IBFBVP="VP" Q
 .... S IBFLDS=".01;2;26;28;63;64;65"
 .... D GETS^DIQ(162.03,IBINLN2_","_IBINLN1_","_IBINIEN_","_DFN_",",IBFLDS,"I","IBRET")  ; Get Payment Data
 Q
 ;
CHKBILL(IBIN) ;Check for prior bill
 N IBINV,IBFBDT,IBCLM,IBFBAU
 S IBINV=$TR(IBIN," ","")
 S IBFBDT=""
 F  S IBFBDT=$O(^IBFB(360,"DFN",DFN,IBFBDT)) Q:IBFBDT=""  D
 . S IBFBAU=""
 . F  S IBFBAU=$O(^IBFB(360,"DFN",DFN,IBFBDT,IBFBAU)) Q:IBFBAU=""  D
 .. I $P($G(^IBFB(360,IBFBAU,1)),U,3)=IBINV D
 ... S IBCLM=$$GET1^DIQ(360,IBFBAU_",",1.01,"I")
 ... I IBCLM'="" S FBINAU=$$PRECRT^IBTRC1(IBCLM,18)
 ... S FBBILL=$$GET1^DIQ(360,IBFBAU_",",1.02,"I")
 ... I FBBILL'="" S FBSKIP=1
 Q
 ;
GETDTS(IBIEN) ;Get Begin and End Dates from Authorization 
 S IBST=$$GET1^DIQ(161.01,IBIEN_",",.01,"I")
 S IBEND=$$GET1^DIQ(161.01,IBIEN_",",.02,"I")
 Q
 ;
