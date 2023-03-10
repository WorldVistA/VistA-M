IBJTEP ;ALB/TJB - TP ERA/835 INFORMATION SCREEN ;20 Dec 2018 14:47:23
 ;;2.0;INTEGRATED BILLING;**530,609,633,639,642**;21-MAR-94;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IBJT ERA 835 INFORMATION
 D EN^VALM("IBJT ERA 835 INFORMATION")
 Q
 ;
HDR ; -- header code
 N IBRP,IBREJ S IBRP(U)=", "
 ; Add the EEOB, Reject and ECME indicators to the Bill
 S IBREJ=$S($$BILLREJ^IBJTU6(EPBILL):"c",1:"")
 S VALMHDR(1)=$$EEOB^IBJTLA1(IBIFN)_IBREJ_EPBILL_$$ECME^IBTRE(IBIFN)_"  "_$E(EPNM,1,20)_"  "_EPSS_" DOB: "_EPDOB_"  Subsc ID: "_EPSID
 S VALMHDR(2)="Svc Date: "_EPDOS_"  Orig Amt: "_EPAMT_"  ERA#: "_$$REPLACE^XLFSTR(ERALST,.IBRP)
 Q
 ;
INIT ; -- init variables and list array
 N AQ,EPIEN,EPTN,ERADA,ERAIEN,EPARR,EPPCT,EOBCT,EOBLST,EOBMX,FL,IBAR,IBI,IBCOL,IBEBERA,IBRX,IBSHEOB,IBSPEOB ; IB*2.0*633
 N II,LINE,QQ,RCBAMT,RCCOPY,RCRC,RCOIN,RCDED,RCERR,RCFLD,RMIEN,RCRDC,RCRLN,RCXY,RCMD,REMOVED,X,XX,Z
 S EOBMX=0
 S ERALST="",$P(SP80," ",80)=" "
 ; IBIFN comes in from the TPJI screen and will be cleaned up there
 I '$G(IBIFN) S VALMQUIT="" G INITQ
 K EPARR D BILL^IBRFN3(IBIFN,.EPARR) ; Get Bill information
 S EPBILL=EPARR("BN") ; K-Bill
 S EPPAT=$$GET1^DIQ(399,IBIFN_",",.02,"I") ; Get Patient IEN 
 S EPNM=$$GET1^DIQ(399,IBIFN_",",.02) ; Get Patient Name
 ; Get Total Charges and justify the amount
 S EPAMT=$J(+EPARR("TCG"),$L(+EPARR("TCG")),2)
 S EPSS=$E(EPNM)_$$GET1^DIQ(2,EPPAT_",",.364) ; Get Short SSN
 S EPDOB=$$GET1^DIQ(2,EPPAT_",",.03) ; Get DOB
 S EPSID=$P(EPARR("PIN"),U,6) ; Get Subscriber ID
 S EPDOS=$$FMTE^XLFDT(EPARR("STF"),"5DZ") ; Get Date of Service
 S:EPARR("STF")'=EPARR("STT") EPDOS=EPDOS_" - "_$$FMTE^XLFDT(EPARR("STT"),"5DZ") ; If Bill for date range
 ; Check to see if we may have an EEOB if not report no ERA Information for this K-Bill
 S EPIEN=$O(^IBM(361.1,"B",$G(IBIFN),"")) I EPIEN="" S VALMCNT=2 D SET^VALM10(1," "),SET^VALM10(2,"No ERA Information for Bill: "_EPBILL) G INITQ
 ; Get % Collected from AR claim - IA 1452 - IB*2.0*609
 S IBAR=$$BILL^RCJIBFN2(IBIFN),IBCOL=$P(IBAR,U,5)
 ; Collect all possible EOBs associated with this Claim
 S ERAIEN=""
 ; IB*2.0*633 - Start modified block
 S IBSHEOB=0,IBI=0,RCCOPY=0
 F  S IBI=$O(^IBM(361.1,"B",IBIFN,IBI)) Q:'IBI  D  ;
 . S IBSHEOB=IBSHEOB+1,IBSHEOB(IBI)=0
 . ; For each EOB get the associated ERAs from ADET index
 . S ERAIEN="" F  S ERAIEN=$O(^RCY(344.4,"ADET",IBI,ERAIEN)) Q:'ERAIEN  D  ;
 . . S IBSHEOB(IBI,ERAIEN)=""
 . ; PRCA*4.5*332 - Start modified code block
 . I $O(IBSHEOB(IBI,""))="" D  ; EOB not assocated with an ERA. Check if it was copied.
 . . I $$GET1^DIQ(361.1,IBI_",",.17,"I") Q  ; Ignore manually entered EOB
 . . S X=$O(^IBM(361.1,IBI,101,"A"),-1)
 . . I X,$$GET1^DIQ(361.1101,X_","_IBI_",",.05,"I")="C" D  ; EOB is a copy
 . . . S RCCOPY=RCCOPY+1
 . . . S RCCOPY(RCCOPY)=IBI
 ; IB*2.0*633 - End modified block
 ; Loop on the IEN for the EEOBs - exclude MRAs, but include all insurances 
 S EPIEN="",LINE=0,EOBCT=0
 F  S EPIEN=$O(IBSHEOB(EPIEN)) Q:EPIEN=""  S ERADA="" F  S ERADA=$O(IBSHEOB(EPIEN,ERADA)) Q:'ERADA  D  ; IB*2.0*633
 . Q:$P($G(^IBM(361.1,EPIEN,0)),U,4)=1  ; Get next because this is an MRA
 . S EPTN=$$GET1^DIQ(361.1,EPIEN_",",.07),ERAIEN=ERADA_"," ; IB*2.0*633
 . Q:U_ERALST_U[(U_ERAIEN_U)  ; Quit if we have already reported this ERA #
 . K IBEPAR,IBPLB
 . D GETS^DIQ(344.4,ERAIEN,".01;.02;.03;.04;.05;.06;.07;.08;.09;.1;.11;.12;.13;.14;.15;4.02;","E","IBEPAR")
 . D GETS^DIQ(344.4,ERAIEN,"2*;","E","IBPLB") ; ERA Level Adjustments
 . Q:$D(IBEPAR)'>0  ; No IBEPAR - no data done with this record.
 . S ERALST=$$PUSH(ERALST,ERAIEN) S XLN="ERA#: "_$G(IBEPAR("344.4",ERAIEN,".01","E")),XSP=$E(SP80,1,(22-$L(XLN)))
 . S EPPCT=$S($G(EPARR("TCG"))>0:($G(IBEPAR("344.4",ERAIEN,".05","E"))/EPARR("TCG"))*100,1:0)
 . D SET(.LINE,"** ERA SUMMARY DATA ** ")
 . D SET(.LINE,XLN_XSP_"TRACE#: "_$G(IBEPAR("344.4",ERAIEN,".02","E")))
 . ; Holding onto the line below because the change of calculation 
 . ; S XLN="ERA DATE (PAYER): "_$G(IBEPAR("344.4",ERAIEN,".04","E"))_"     TOTAL AMT PD: "_$J($G(IBEPAR("344.4",ERAIEN,".05","E")),9)_"   % COLLECTED: "_$J(EPPCT,6,2)
 . S XLN="ERA DATE (PAYER): "_$G(IBEPAR("344.4",ERAIEN,".04","E"))_"                 TOTAL AMT PD: "_$J($G(IBEPAR("344.4",ERAIEN,".05","E")),9)
 . D SET(.LINE,XLN)
 . D SET(.LINE,"PAYER NAME/TIN: "_$G(IBEPAR("344.4",ERAIEN,".06","E"))_"/"_$G(IBEPAR("344.4",ERAIEN,".03","E")))
 . D SET(.LINE,"FILE DATE/TIME: "_$G(IBEPAR("344.4",ERAIEN,".07","E")))
 . D SET(.LINE,"EFT MATCH STATUS: "_$G(IBEPAR("344.4",ERAIEN,".09","E")))
 . S XLN="ERA TYPE: "_$G(IBEPAR("344.4",ERAIEN,".1","E")),XSP=$E(SP80,1,(40-$L(XLN)))
 . D SET(.LINE,XLN_XSP_"INDIVIDUAL EOB COUNT: "_$G(IBEPAR("344.4",ERAIEN,".11","E")))
 . S XLN="MAIL MESSAGE: "_$G(IBEPAR("344.4",ERAIEN,".12","E")),XSP=$E(SP80,1,(40-$L(XLN)))
 . D SET(.LINE,XLN_XSP_"CHECK#: "_$G(IBEPAR("344.4",ERAIEN,".13","E")))
 . S XLN="DETAIL POST STATUS: "_$G(IBEPAR("344.4",ERAIEN,".14","E")),XSP=$E(SP80,1,(40-$L(XLN)))
 . D SET(.LINE,XLN_XSP_"EXPECTED PAYMENT METHOD CODE: "_$G(IBEPAR("344.4",ERAIEN,".15","E")))
 . D SET(.LINE," ")
 . D SET(.LINE,"********** ERA LEVEL ADJUSTMENTS **********")
 . I $D(IBPLB)=0 D SET(.LINE,"  -- NONE --")
 . D:$D(IBPLB)'=0  ; If we have PLB Data report it
 .. S FL="",RCF=0 F  S FL=$O(IBPLB(344.42,FL)) Q:FL=""  D
 ... I RCF'=0 D SET(.LINE," ")
 ... S RCF=RCF+1
 ... S XLN="   ADJUSTMENT REASON CODE: "_IBPLB(344.42,FL,.02,"E"),XSP=$E(SP80,1,(45-$L(XLN)))
 ... I $G(IBPLB(344.42,FL,.02,"E"))'="" S ACT=$$FIND1^DIC(345.1,,"B",IBPLB(344.42,FL,.02,"E")),ACT=$$GET1^DIQ(345.1,ACT,.05)
 ... D SET(.LINE,XLN_XSP_"ADJUSTMENT AMOUNT: "_$J(IBPLB(344.42,FL,.03,"E"),9))
 ... D SET(.LINE,"   ADJUSTMENT CODE TEXT: "_ACT)
 ... D SET(.LINE,"   REFERENCE: "_IBPLB(344.42,FL,.01,"E"))
 . D SET(.LINE," ")
 . K IBEBERA S ZZEPIEN=EPIEN D EEOB^IBJTEP1("IBEBERA",ERAIEN,EPBILL,1)
 . F EOBCT=1:1:IBEBERA D
 .. S EPIEN=$O(IBEBERA(EOBCT,""))
 .. I EPIEN,'$D(EOBLST(EPIEN)) D  ;
 ... D EOBDET(EPIEN,0,EOBCT,IBEBERA,ERAIEN) ; PRCA*4.5*332
 ... S EOBLST(EPIEN)=""
 . D SET(.LINE,$TR(SP80," ","="))
 . S EPIEN=ZZEPIEN
 I RCCOPY D  ;
 . S (X,XX)=0 F  S X=$O(RCCOPY(X)) Q:'X  D  ; Display copied EOBs - PRCA*4.5*332
 . . I '$D(EOBLST(RCCOPY(X))) D  ;
 . . . D EOBDET(RCCOPY(X),1,X,RCCOPY,"")
 . . . S EOBLST(RCCOPY(X))="",XX=XX+1
 . I XX D SET(.LINE,$TR(SP80," ","="))
 ; No EEOB IEN, then report that No ERA recieved for this bill
 I LINE=0 S VALMCNT=2 D SET^VALM10(1," "),SET^VALM10(2,"No ERA Information for Bill: "_EPBILL) G INITQ
 S VALMCNT=LINE
 ;
INITQ K IBEPAR,IBPLB,IBEOB,IBDGCR,IBGX,IBSPL,IBEERR,TT,AA,EE,RCPL,ACT,ACNT,CC,XLN,XSP,XSP1,TSDT,TEDT,TRX,TECME,RCF,SP80,X,ZZEPIEN
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K EPBILL,EPEOB,ERALST,EPPAT,EPNM,EPSS,EPDOB,EPDOS,EPSID,EPAMT,EPARR
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
PUSH(VAR,VALUE) ;
 S VALUE=$TR(VALUE,",") ; Remove Commas from string
 Q:$G(VAR)="" VALUE ; Empty variable
 ; If this VALUE is on the list don't add it a second time
 I U_VAR_U[(U_VALUE_U) Q VAR
 Q VAR_U_VALUE
 ;
 ; IB*2.0*642 - 2020/02/05:DM removed to meet SAC line limit
 ; Get the code modifier description
 ;MODC(MCD) ;
 ; Q:$G(MCD)="" "No Modifier Code Description"
 ; N ZZIEN,ZZDEC
 ; S ZZIEN=$$FIND1^DIC(81.3,,"BX","26","","","")
 ; S ZZDEC=$$GET1^DIQ(81.3,ZZIEN_",",.02)
 ; Q:ZZDEC="" "No Modifier Code Description"
 ; Q ZZDEC
 ;
SET(LINE,DATA) ; -- set arrays
 ; LINE = line number passed by reference
 ; DATA = string to add to displayed data
 S LINE=LINE+1
 D SET^VALM10(LINE,$G(DATA))
 Q
 ; PRCA*4.5*332 - Move EOB display into its own subroutine
EOBDET(EPIEN,TYPE,EOBCT,IBEBERA,ERAIEN) ; Add EOB detail to List Manager Array
 ; Input:  EPIEN - Internal entry number to file 361.1
 ;         TYPE - 0 - EEOB associated with an ERA, 1 - Copied EOB created by split/edit or link payment
 ;         EOBCT - Count# of this EOB within the ERA
 ;         IBEBERA - Number of EOBs for this bill in this ERA
 ;         ERAIEN - Internal entry number from file 344.4
 ;
 N IBEOB,IBGX,IBCL,IBDGCR,IBRX,IBSPL,IBEERR,RCTRACE
 D GETS^DIQ(361.1,EPIEN_",",".01;.02;.03;.04;.06;.07;.14;1.01;1.02;1.03;1.1;1.11;2.03;2.04;3.03;3.04;3.05;3.06;3.07;102;104","EI","IBEOB")
 D GETS^DIQ(361.1,EPIEN_",","10*;","EI","IBGX"),RESORT^IBJTEP1("IBGX",361.111),RESORT^IBJTEP1("IBGX",361.11) ; Claim Level Adjustments
 D GETS^DIQ(361.1,EPIEN_",","15*;","EI","IBCL") ; Line Level Adjustments
 D GETS^DIQ(361.1,EPIEN_",","8*;","EI","IBSPL") ; ERA Splits for this EEOB
 D GETS^DIQ(361.1,EPIEN_",","20;","","IBEERR") ; EOB Errors if they exist
 ; Make it easier to walk the data
 D RESORT^IBJTEP1("IBCL",361.11511),RESORT^IBJTEP1("IBCL",361.115),RESORT^IBJTEP1("IBCL",361.1151)
 D RESORT^IBJTEP1("IBCL",361.1152),RESORT^IBJTEP1("IBCL",361.1154)
 D GETS^DIQ(399,IBEOB(361.1,EPIEN_",",.01,"I")_",","460;","EI","IBDGCR")
 S RCTRACE=$G(IBEOB("361.1",EPIEN_",",".07","E"))
 I ERAIEN="",RCTRACE'="" S ERAIEN=$O(^RCY(344.4,"D",RCTRACE,""))
 D SET(.LINE,"********** "_$S(TYPE=0:"",1:"COPIED ")_"EOB/835 INFORMATION ("_EOBCT_" of "_IBEBERA_") **********")
 I $G(IBEOB("361.1",EPIEN_",","102","I")) D  Q  ; EOB Removed
 . D EOBREM^IBJTEP1(EPIEN,.LINE)
 . D SET(.LINE,$TR(SP80," ","-"))
 ;
 I $G(ERADA) D  ; ORIGINAL PATIENT NAME added in IB*2.0*639
 . S ERAIEN("p344.41")=$O(^RCY(344.4,ERADA,1,"AC",EPIEN,0))
 . I ERAIEN("p344.41") D  ; POINTER TO ERA DETAIL 344.41
 . .  S XLN="  Free Text Patient Name: "_$$GET1^DIQ(344.41,ERAIEN("p344.41")_","_ERADA_",",.15,"E")
 . .  D SET(.LINE,XLN)
 E  D  ;
 . S ERAIEN("p344.41")=$G(IBEOB("361.1",EPIEN_",","104","E"))
 . I ERAIEN("p344.41")'="" D  ;
 . .  S XLN="  Free Text Patient Name: "_$$GET1^DIQ(344.41,ERAIEN("p344.41"),.15,"E")
 . .  D SET(.LINE,XLN)
 ;
 S XLN="  EOB Type: "_$G(IBEOB("361.1",EPIEN_",",".04","E")),XSP=$E(SP80,1,(40-$L(XLN)))
 D SET(.LINE,XLN_XSP_"EOB Paid Date: "_$G(IBEOB("361.1",EPIEN_",",".06","E")))
 S TSDT=$$FMTE^XLFDT($G(IBEOB("361.1",EPIEN_",","1.1","I")),"2Z"),TEDT=$$FMTE^XLFDT($G(IBEOB("361.1",EPIEN_",","1.11","I")),"2Z"),XLN="  Svc From Date: "_TSDT,XSP=$E(SP80,1,(40-$L(XLN)))
 D SET(.LINE,XLN_XSP_"Svc to Date: "_TEDT)
 D SET(.LINE,"         ICN: "_$G(IBEOB("361.1",EPIEN_",",".14","E")))
 D SET(.LINE,"  Payer Name/TIN: "_$G(IBEOB("361.1",EPIEN_",",".02","E"))_"/"_$G(IBEOB("361.1",EPIEN_",",".03","E")))
 I ERAIEN D  ;
 . S XLN="     ERA #: "_$$GET1^DIQ(344.4,ERAIEN_",",".01","E"),XSP=$E(SP80,1,(40-$L(XLN)))
 . D SET(.LINE,XLN_XSP_"Auto-Post Status: "_$$GET1^DIQ(344.4,ERAIEN_",","4.02","E"))
 . D SET(.LINE,"   Trace #: "_$$GET1^DIQ(344.4,ERAIEN_",",".02","E"))
 E  D  ;
 . D SET(.LINE,"   Trace #: "_RCTRACE)
 S TECME=$P($G(IBDGCR(399,IBEOB(361.1,EPIEN_",",.01,"I")_",",460,"E")),";",1)
 D GETRX^IBJTEP1(EPIEN,.IBRX)
 S TRX=$$GET1^DIQ(52,+TECME_",",".01")_"/"_$G(IBRX("FILL"))_"/"_$G(IBRX("RELEASED STATUS"))
 I TECME="" S TRX=""
 S XLN=" ECME #: "_TECME,XSP=$E(SP80,1,(25-$L(XLN))),XSP1=$E(SP80,1,(39-$L(XLN_XSP_"DOS: "_$G(IBRX("DOS")))))
 D SET(.LINE,XLN_XSP_"DOS: "_$G(IBRX("DOS"))_XSP1_"Rx/Fill/Release Status: "_TRX)
 D SET(.LINE,"--------------------------------------------------------------------------------")
 D:$D(IBSPL)>1  ; This EEOB was split display split payment information
 . N SPL
 . D SET(.LINE,"** A/R CORRECTED PAYMENT DATA:")
 . D SET(.LINE,"   TOTAL AMT PD:          "_$J(IBEOB(361.1,EPIEN_",",1.01,"E"),9,2))
 . S SPL="" F  S SPL=$O(IBSPL(361.18,SPL)) Q:SPL=""  D
 .. D SET(.LINE,"     "_$S(IBSPL(361.18,SPL,.03,"I")'="":$$BN1^PRCAFN(IBSPL(361.18,SPL,.03,"I"))_$J("",8),1:"[suspense] "_IBSPL(361.18,SPL,.01,"E"))_"  "_$J(IBSPL(361.18,SPL,.02,"E"),9,2))
 . D SET(.LINE," ")
 D SET(.LINE,"CLAIM LEVEL PAY STATUS:")
 D SET(.LINE,"  Total Submitted Charges :"_$J($G(IBEOB("361.1",EPIEN_",","2.04","E")),11,2)_"  Payer Covered Amount    :"_$J($G(IBEOB("361.1",EPIEN_",","1.03","E")),11,2))
 D SET(.LINE,"  Payer Paid Amount       :"_$J($G(IBEOB("361.1",EPIEN_",","1.01","E")),11,2)_"  MEDICARE Allowed Amount :"_$J($G(IBEOB("361.1",EPIEN_",","2.03","E")),11,2))
 D SET(.LINE,"  Patient Responsibility  :"_$J($G(IBEOB("361.1",EPIEN_",","1.02","E")),11,2)_" %              Collected :"_$J(+IBCOL,11,0)_" %") ; IB*2.0*609
 D SET(.LINE,$TR(SP80," ","-"))
 D SET(.LINE,"CLAIM LEVEL ADJUSTMENTS:")
 S AA="",ACNT=0 F  S AA=$O(IBGX(361.11,AA)) Q:AA=""  S ACNT=ACNT+1,AQ="" D
 . S CC=AA F  S CC=$O(IBGX(361.111,CC)) Q:$E(CC,1,$L(AA))'=AA  D
 .. I AQ="" S AQ=$J(ACNT,3)_") "
 .. E  S ACNT=ACNT+1,AQ=$J(ACNT,3)_") "
 .. D SET(.LINE,AQ_"ADJ. AMT: "_$J(IBGX(361.111,CC,.02,"E"),9,2)_"  ADJ GROUP: "_IBGX(361.11,AA,.01,"I")_" => "_IBGX(361.11,AA,.01,"E"))
 .. S RMIEN=$$FIND1^DIC(345,"","BX",IBGX(361.111,CC,.01,"E"),"","","RCERR")
 .. I RMIEN'="" K RCERR,RCRDC,RCFLD S RCXY=$$GET1^DIQ(345,RMIEN_",",4,"","RCRDC","RCERR") D DLN^IBJTEP1("RCRDC","RCFLD",55,69)
 .. D SET(.LINE,"     ADJ. CODE: "_IBGX(361.111,CC,.01,"E")_" => "_RCFLD(1))
 .. I RCFLD>1 F II=2:1:RCFLD D SET(.LINE,"          "_RCFLD(II))
 I ACNT=0 D SET(.LINE,"  -- None --")
 D SET(.LINE,"CLAIM LEVEL REMARKS: ")
 S RCRC=0 F II="3.03","3.04","3.05","3.06","3.07" D:IBEOB("361.1",EPIEN_",",II,"E")'=""
 . ; Get IEN for this remark code - if no IEN then need to look at the data "RM1" to "RM5"
 . S RMIEN=$$FIND1^DIC(346,"","BX",IBEOB("361.1",EPIEN_",",II,"E"),"","","RCERR")
 . I RMIEN'="" K RCERR,RCRDC,RCFLD S RCXY=$$GET1^DIQ(346,RMIEN_",",4,"","RCRDC","RCERR") D DLN^IBJTEP1("RCRDC","RCFLD",57,69)
 . I RMIEN="" S RCFLD=$S(II="3.03":5.011,II="3.04":5.021,II="3.05":5.031,II="3.06":5.041,II="3.07":5.051,1:5.011) S RCRLN=$$GET1^DIQ(361.1,EPIEN_",",RCFLD)
 . S RCRC=RCRC+1 D SET(.LINE,"  --- REMARK CODE("_RCRC_"): "_IBEOB("361.1",EPIEN_",",II,"E")_" => "_RCFLD(1))
 . I RCFLD>1 F II=2:1:RCFLD D SET(.LINE,"          "_RCFLD(II))
 I RCRC=0 D SET(.LINE,"  -- None --")
 D SET(.LINE,$TR(SP80," ","-"))
 ; Walk through the line level information...
 D SET(.LINE,"EEOB LINE LEVEL ADJUSTMENTS:")
 K ^XTMP("IBJTEP",$J) M ^XTMP("IBJTEP",$J)=IBCL
 S RCPL=0,EE="" F  S EE=$O(IBCL(361.115,EE)) Q:EE=""  S RCPL=RCPL+1 D
 . S QQ=EE,RCMD="" F  S QQ=$O(IBCL(361.1152,QQ)) Q:$E(QQ,1,$L(EE))'=EE  S RCMD=IBCL(361.1152,QQ,.01,"I")
 . D SET(.LINE," #   SV DT  REVCD   PROC  MOD  UNITS   BILLED  DEDUCT   COINS    ALLOW     PYMT")
 . S RCBAMT=$$BILLN^IBJTEP1(IBEOB(361.1,EPIEN_",",.01,"I"),IBCL(361.115,EE,.1,"E"),IBCL(361.115,EE,.04,"E"))
 . S RCDED=$$ADJU^IBJTEP1("DEDUCT",.IBCL,EE),RCOIN=$$ADJU^IBJTEP1("COINS",.IBCL,EE) ; Get Deductable and Co-Insurance amts.
 . S XLN=$J(RCPL,2,0)_" "_$$FMTE^XLFDT(IBCL(361.115,EE,.16,"I"),"2Z")_" "_$$CJ^XLFSTR(IBCL(361.115,EE,.1,"E"),5)_" "_$$CJ^XLFSTR(IBCL(361.115,EE,.04,"E"),8)_$$CJ^XLFSTR(RCMD,5)_" "_$$CJ^XLFSTR(IBCL(361.115,EE,.11,"E"),3)
 . D SET(.LINE,XLN_" "_$J(RCBAMT,9,2)_$J(RCDED,8,2)_$J(RCOIN,8,2)_$J(IBCL(361.115,EE,.13,"E"),9,2)_$J(IBCL(361.115,EE,.03,"E"),9,2))
 . ; IB*2.0*642 - Add logic to display DRG/GRP Adjustment Weight
 . ; N SPL S SPL=$$SUPL^IBCECSA7($P(EE,",",2),$P(EE,",")) I SPL]"" D SET(.LINE,SPL)
 . D SET(.LINE," ")
 . D SET(.LINE,"  Product/Service Description:"_IBCL(361.115,EE,.09,"E"))
 . D SET(.LINE,"  Payer Policy Reference:"_$G(IBCL(361.11512,EE,.01,"E")))
 . D SET(.LINE," ")
 . S ACNT=0,AA=EE F  S AA=$O(IBCL(361.1151,AA)) Q:$E(AA,1,$L(EE))'=EE  D
 .. S ACNT=ACNT+1
 .. S CC=AA,RCRC=0 F  S CC=$O(IBCL(361.11511,CC)) Q:$E(CC,1,$L(AA))'=AA  D
 ... S RCRC=RCRC+1 D SET(.LINE,"  -> ADJ AMT: "_$J(IBCL(361.11511,CC,.02,"E"),9,2)_"  ADJ GROUP: "_IBCL(361.1151,AA,.01,"I")_" - "_IBCL(361.1151,AA,.01,"E")_"  "_$$CJ^XLFSTR("QTY: "_+$G(IBCL(361.11511,CC,.03,"E")),8))
 ... S RCXY=$$FIND1^DIC(345,"","BX",IBCL(361.11511,CC,.01,"E"),"","","RCERR")
 ... K RCRDC,RCERR S RCXY=$$GET1^DIQ(345,RCXY_",",4,"","RCRDC","RCERR")
 ... I $D(RCRDC)>0 K RCFLD D DLN^IBJTEP1("RCRDC","RCFLD",57,57)
 ... I $D(RCRDC)=0 K RCFLD S RCRDC(1)=IBCL(361.11511,CC,.04,"E") D DLN^IBJTEP1("RCRDC","RCFLD",57,57) ; If no data from file 345 use data from FMS
 ... D SET(.LINE,"      ADJ CODE: "_$$CJ^XLFSTR(IBCL(361.11511,CC,.01,"E"),5)_" "_RCFLD(1))
 ... I RCFLD>1 F II=2:1:RCFLD D SET(.LINE,"                      "_RCFLD(II))
 . ; Display RARC Codes for this Line Item
 . I $D(IBCL(361.1154))'=0 S QQ=EE,RCMD="" F  S QQ=$O(IBCL(361.1154,QQ)) Q:$E(QQ,1,$L(EE))'=EE  D
 .. K RCERR,RCRDC,RCFLD
 .. S RMIEN=$$FIND1^DIC(346,"","BX",IBCL(361.1154,QQ,.02,"E"),"","","RCERR")
 .. ; avoid "undefined" if RMIEN could not be found *642
 .. I 'RMIEN S RCFLD=1,RCFLD(1)="*["_IBCL(361.1154,QQ,.02,"E")_"] code is not on file."
 .. I RMIEN S RCXY=$$GET1^DIQ(346,RMIEN_",",4,"","RCRDC","RCERR") D DLN^IBJTEP1("RCRDC","RCFLD",57,68)
 .. D SET(.LINE,"  --- RARC: "_IBCL(361.1154,QQ,.02,"E")_" - "_RCFLD(1))
 .. I RCFLD>1 F II=2:1:RCFLD D SET(.LINE,"          "_RCFLD(II))
 . D SET(.LINE," ")
 I ACNT=0 D SET(.LINE,"  -- No Line Level Adjustments --")
 ; If there are EOB Errors add them to the screen 
 D:$D(IBEERR(361.1,EPIEN_",",20))>9
 . D SET(.LINE," "),SET(.LINE,"EEOB MESSAGE ERRORS:")
 . N II S II=0 F  S II=$O(IBEERR(361.1,EPIEN_",",20,II)) Q:(II="")!(II'=+II)  D SET(.LINE,$G(IBEERR(361.1,EPIEN_",",20,II)))
 Q
