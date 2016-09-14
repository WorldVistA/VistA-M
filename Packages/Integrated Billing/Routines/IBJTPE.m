IBJTPE ;ALB/TJB - TP ERA/835 PRINT EEOB INFORMATIN SCREEN ;20-MAY-2015
 ;;2.0;INTEGRATED BILLING;**530**;21-MAR-94;Build 71
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; ;
EN ; -- main entry point for IBJT 835 EEOB PRINT
 D EN^VALM("IBJT 835 EEOB PRINT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="IBJT 835 EEOB PRINT."
 S VALMHDR(2)="Print EEOBs for further investigation"
 Q
 ;
INIT ; -- init variables and list array
 ; Array IBEBERA (From IBJTEP) contains the the EEOBs for this KBILL
 N IBRP,IBEIEN,CT,DIR,EOBLST,IBEBERA,IBPERA,JJ,X,Y,DTOUT,DUOUT,DIROUT,DIRUT,IBNUM,IBPEOB,IBALL
 S IBNUM=1,(CT,EOBLST,IBALL)=0,JJ=""
 D FULL^VALM1
IN1 ;
 S IBRP(U)=", "
 ; ERALST is from IBJTEP and will be cleaned up there
 I $L(ERALST)=0 W !,"No ERA Information for Bill: "_EPBILL K DIR S DIR(0)="E" D ^DIR K DIR G INITQ
 I $L(ERALST,U)=1 S IBPERA=ERALST G IN2
 S DIR("A")="Enter a SINGLE ERA# or (A)LL ERAs/All EEOBs to print: ",DIR(0)="FA^1:15"
 S DIR("A",1)="This claim has EEOBs on multiple ERAs. Enter a SINGLE ERA# from the following"
 S DIR("A",2)="list or enter ALL to print ALL associated EEOBS from all ERAs in the list."
 S DIR("A",3)="Available ERAs: "_$$REPLACE^XLFSTR(ERALST,.IBRP)
 S DIR("PRE")="S X=$$UP^XLFSTR(X)"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S VALMQUIT="" G INITQ
 I Y=$E("ALL",1,$L(Y)) S IBALL=1 G IND ; Print All EOBs for All ERAs
 S IBPERA=Y I (U_ERALST_U)'[(U_Y_U) W !!,"ERA: "_Y_" not a valid selection. Please try again...",! S X="",IBPERA="" G IN1
IN2 ;
 ; EPBILL is from IBJTEP and will be cleaned up there
 K IBEBERA D EEOB^IBJTEP1("IBEBERA",IBPERA,EPBILL,1) S JJ="" F  S JJ=$O(IBEBERA(JJ)) Q:JJ=""  S CT=CT+1,EOBLST(CT)=$O(IBEBERA(JJ,""))
 I CT=1 S IBPEOB="1," G IND
 ; Get the EOB to Print if more than one.
 S IBRNG="1-"_IBEBERA
 S DIR("A")="Select EEOB# to Print ("_IBRNG_"), (A)ll EEOBs or (E)xit: ",DIR(0)="LA^1:"_IBEBERA
 S DIR("PRE")="S X=$S(""Aa""[$E(X):"""_IBRNG_""",""Ee""[$E(X):""^"",1:X)"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S VALMQUIT=1 G INITQ
 ; IBPEOB will be a list of numbers to print
 S IBPEOB=Y
 ; Ask device
IND N POP S %ZIS="QM" D ^%ZIS I POP S VALMQUIT="" G INITQ
 I $D(IO("Q")) D  S VALMQUIT="" G INITQ
 . S ZTRTN=$S(IBALL=1:"EOBALL^IBJTPE",1:"EOBOUT^IBJTPE"),ZTDESC="AR EDI - Print EEOB Detail from 835 Information"
 . S ZTSAVE("IB*")="",ZTSAVE("EOB*")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ; If IBALL set, print all EOBs on all ERAs otherwise print just selected EOBs/ERAs
 G EOBALL:IBALL,EOBOUT
 ;
INITQ ;
 S VALMQUIT=""
 K IBEOB,EOBLST,IBRNG
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
EOBALL ; Entry point to print all ERAs and all EOBs
 N ZQ,ZQL,IBPERA,JJ,IBEBERA,IBPEOB,CT,IBSL,IBPG,BB,BC,IBQUIT,IBREPG
 S (IBPG,IBQUIT,IBREPG,IBSL)=0,ZQL=$L(ERALST,U)
 F ZQ=1:1 S IBPERA=$P(ERALST,U,ZQ) Q:IBPERA=""  S:IBPG>0 IBREPG=1 D  Q:IBQUIT
 . K IBEBERA D EEOB^IBJTEP1("IBEBERA",IBPERA,EPBILL,1) S JJ="",CT=0 F  S JJ=$O(IBEBERA(JJ)) Q:JJ=""  S CT=CT+1,EOBLST(CT)=$O(IBEBERA(JJ,""))
 . I CT=1 S IBPEOB="1,"
 . E  S IBPEOB="1-"_IBEBERA
 . S IBSL=0 ; Print new page because we are switching ERA #s
 . F BC=1:1 S BB=$P(IBPEOB,",",BC) Q:BB=""  S IBEIEN=EOBLST(BB) D EBO Q:IBQUIT
 . I ZQ<ZQL D ASK(.IBQUIT)
 I 'IBQUIT D SET("      ***  END OF REPORT  ***"),ASK(.IBQUIT)
 G INITQ
 Q
EOBOUT ; Entry for either queued or screen print of EEOB
 N AA,AQ,BB,BC,CC,EE,II,QQ,IBDT,IBPG,IBSL,IBQUIT,IBEOB,IBGX,IBCL,IBSPL,IBEERR,IBDGCR,IBEPAR,ACNT,IBQUIT,IBRDC,IBPERR,XLN,XSP,RCBAMT,RCDED,RCMD,RCOIN
 N RCPL,RCRC,RCRLN,RCXY,RMIEN,SP80,TDOS,TECME,TEDT,TRX,TSTAT,TSDT,XSP1,IBREPG
 S (IBQUIT,IBSL,IBPG,IBREPG)=0
 S BB="" F BC=1:1 S BB=$P(IBPEOB,",",BC) Q:BB=""  S IBEIEN=EOBLST(BB) D EBO Q:IBQUIT
 I 'IBQUIT D SET("      ***  END OF REPORT  ***"),ASK(.IBQUIT)
 G INITQ
 Q
EBO ; Display the EOB DATA for IBEIEN
 S SP80=$J("",IOM),IBDT=$$FMTE^XLFDT($$NOW^XLFDT,1) ; Date format Mon dd, yyyy@hh:mm:ss see kernel documentation
 I (IBSL=0)&(IBPG=0) D RHDR(IBPERA,IBDT,.IBPG)
 I IBREPG=1 S IBREPG=0 D RHDR(IBPERA,IBDT,.IBPG)
 K IBEOB,IBGX,IBCL,IBDGCR,IBEPAR,IBSPL,IBEERR
 D GETS^DIQ(361.1,IBEIEN_",",".01;.02;.03;.04;.06;.14;1.01;1.02;1.03;1.1;1.11;2.03;2.04;3.03;3.04;3.05;3.06;3.07;","EI","IBEOB")
 D GETS^DIQ(361.1,IBEIEN_",","10*;","EI","IBGX"),RESORT^IBJTEP1("IBGX",361.111),RESORT^IBJTEP1("IBGX",361.11) ; Claim Level Adjustments
 D GETS^DIQ(361.1,IBEIEN_",","15*;","EI","IBCL") ; Line Level Adjustments
 D GETS^DIQ(361.1,IBEIEN_",","8*;","EI","IBSPL") ; ERA Splits for this EEOB
 D GETS^DIQ(361.1,IBEIEN_",","20;","","IBEERR") ; EOB Errors if they exist
 ; Make it easier to walk the data
 D RESORT^IBJTEP1("IBCL",361.11511),RESORT^IBJTEP1("IBCL",361.115),RESORT^IBJTEP1("IBCL",361.1151)
 D RESORT^IBJTEP1("IBCL",361.1152),RESORT^IBJTEP1("IBCL",361.1154)
 D GETS^DIQ(399,IBEOB(361.1,IBEIEN_",",.01,"I")_",","460;","EI","IBDGCR")
 D GETS^DIQ(344.4,IBPERA_",",".01;.02;.03;.04;.05;.06;.07;.08;.09;.1;.11;.12;.13;.14;.15;4.02;","E","IBEPAR")
 ;
 D SET("**********  EOB/835 INFORMATION ("_BB_" of "_IBEBERA_") **********") Q:IBQUIT
 S XLN="  EOB Type: "_$G(IBEOB("361.1",IBEIEN_",",".04","E")),XSP=$E(SP80,1,(40-$L(XLN)))
 D SET(XLN_XSP_"EOB Paid Date: "_$G(IBEOB("361.1",IBEIEN_",",".06","E"))) Q:IBQUIT
 S TSDT=$$FMTE^XLFDT($G(IBEOB("361.1",IBEIEN_",","1.1","I")),"2Z"),TEDT=$$FMTE^XLFDT($G(IBEOB("361.1",IBEIEN_",","1.11","I")),"2Z"),XLN="  Svc From Date: "_TSDT,XSP=$E(SP80,1,(40-$L(XLN)))
 D SET(XLN_XSP_"Svc to Date: "_TEDT) Q:IBQUIT
 D SET("         ICN: "_$G(IBEOB("361.1",IBEIEN_",",".14","E"))) Q:IBQUIT
 D SET("  Payer Name/TIN: "_$G(IBEOB("361.1",IBEIEN_",",".02","E"))_"/"_$G(IBEOB("361.1",IBEIEN_",",".03","E"))) Q:IBQUIT
 S XLN="     ERA #: "_$G(IBEPAR("344.4",IBPERA_",",".01","E")),XSP=$E(SP80,1,(40-$L(XLN)))
 D SET(XLN_XSP_"Auto-Post Status: "_$G(IBEPAR("344.4",IBPERA_",","4.02","E"))) Q:IBQUIT
 D SET("   Trace #: "_$G(IBEPAR("344.4",IBPERA_",",".02","E"))) Q:IBQUIT
 ; Access to PSOORDER supported by DBIA #1878
 S TECME=$P($G(IBDGCR(399,IBEOB(361.1,IBEIEN_",",.01,"I")_",",460,"E")),";",1),TDOS=$$FMTE^XLFDT($$DOS^PSOBPSU1(+TECME),"2Z")
 ;Reference to $$STATUS^BPSOSRX supported by IA 4412
 S TRX=$$GET1^DIQ(52,+TECME_",",".01")
 S TSTAT=$P($$STATUS^BPSOSRX(TRX,$$LSTRFL^PSOBPSU1(+TECME)),"^")
 S TRX=TRX_"/"_$$LSTRFL^PSOBPSU1(+TECME)_"/"_TSTAT
 I TECME="" S TDOS="",TRX=""
 S XLN=" ECME #: "_TECME,XSP=$E(SP80,1,(25-$L(XLN))),XSP1=$E(SP80,1,(39-$L(XLN_XSP_"DOS: "_TDOS)))
 D SET(XLN_XSP_"DOS: "_TDOS_XSP1_"Rx/Fill/Release Status: "_TRX) Q:IBQUIT
 D SET("--------------------------------------------------------------------------------") Q:IBQUIT
 D:$D(IBSPL)>1  Q:IBQUIT  ; This EEOB was split display split payment information
 . N SPL
 . D SET("** A/R CORRECTED PAYMENT DATA:") Q:IBQUIT
 . D SET("   TOTAL AMT PD:          "_$J(IBEOB(361.1,IBEIEN_",",1.01,"E"),9,2)) Q:IBQUIT
 . S SPL="" F  S SPL=$O(IBSPL(361.18,SPL)) Q:SPL=""  D  Q:IBQUIT
 .. D SET("     "_$S(IBSPL(361.18,SPL,.03,"I")'="":$$BN1^PRCAFN(IBSPL(361.18,SPL,.03,"I"))_$J("",8),1:"[suspense] "_IBSPL(361.18,SPL,.01,"E"))_"  "_$J(IBSPL(361.18,SPL,.02,"E"),9,2)) Q:IBQUIT
 . D SET(" ") Q:IBQUIT
 D SET("CLAIM LEVEL PAY STATUS:") Q:IBQUIT
 D SET("  Total Submitted Charges :"_$J($G(IBEOB("361.1",IBEIEN_",","2.04","E")),11,2)_"  Payer Covered Amount    :"_$J($G(IBEOB("361.1",IBEIEN_",","1.03","E")),11,2)) Q:IBQUIT
 D SET("  Payer Paid Amount       :"_$J($G(IBEOB("361.1",IBEIEN_",","1.01","E")),11,2)_"  MEDICARE Allowed Amount :"_$J($G(IBEOB("361.1",IBEIEN_",","2.03","E")),11,2)) Q:IBQUIT
 D SET("  Patient Responsibility  :"_$J($G(IBEOB("361.1",IBEIEN_",","1.02","E")),11,2)) Q:IBQUIT
 D SET("--------------------------------------------------------------------------------") Q:IBQUIT
 D SET("CLAIM LEVEL ADJUSTMENTS:") Q:IBQUIT
 S AA="",ACNT=0 F  S AA=$O(IBGX(361.11,AA)) Q:AA=""  S ACNT=ACNT+1,AQ="" D  Q:IBQUIT
 . S CC=AA F  S CC=$O(IBGX(361.111,CC)) Q:$E(CC,1,$L(AA))'=AA  D  Q:IBQUIT
 .. I AQ="" S AQ=$J(ACNT,3)_") "
 .. E  S ACNT=ACNT+1,AQ=$J(ACNT,3)_") "
 .. D SET(AQ_"ADJ. AMT: "_$J(IBGX(361.111,CC,.02,"E"),9,2)_"  ADJ GROUP: "_IBGX(361.11,AA,.01,"I")_" => "_IBGX(361.11,AA,.01,"E")) Q:IBQUIT
 .. S RMIEN=$$FIND1^DIC(345,"","BX",IBGX(361.111,CC,.01,"E"),"","","IBPERR")
 .. I RMIEN'="" K IBPERR,RCRDC,RCFLD S RCXY=$$GET1^DIQ(345,RMIEN_",",4,"","RCRDC","IBPERR") D DLN^IBJTEP("RCRDC","RCFLD",57,69)
 .. D SET("     ADJ. CODE: "_IBGX(361.111,CC,.01,"E")_" => "_RCFLD(1)) Q:IBQUIT
 .. I RCFLD>1 F II=2:1:RCFLD D SET("          "_RCFLD(II)) Q:IBQUIT
 I ACNT=0 D SET("  -- None --") Q:IBQUIT
 D:'IBQUIT SET("CLAIM LEVEL REMARKS: ") Q:IBQUIT
 S RCRC=0 F II="3.03","3.04","3.05","3.06","3.07" D:IBEOB("361.1",IBEIEN_",",II,"E")'=""  Q:IBQUIT
 . ; Get IEN for this remark code - if no IEN then need to look at the data "RM1" to "RM5"
 . S RMIEN=$$FIND1^DIC(346,"","BX",IBEOB("361.1",IBEIEN_",",II,"E"),"","","IBPERR")
 . I RMIEN'="" K IBPERR,RCRDC,RCFLD S RCXY=$$GET1^DIQ(346,RMIEN_",",4,"","RCRDC","IBPERR") D DLN^IBJTEP("RCRDC","RCFLD",50,68)
 . I RMIEN="" S RCFLD=$S(II="3.03":5.011,II="3.04":5.021,II="3.05":5.031,II="3.06":5.041,II="3.07":5.051,1:5.011) S RCRLN=$$GET1^DIQ(361.1,IBEIEN_",",RCFLD)
 . S RCRC=RCRC+1 D SET("  --- REMARK CODE("_RCRC_"): "_IBEOB("361.1",IBEIEN_",",II,"E")_" => "_RCFLD(1)) Q:IBQUIT
 . I RCFLD>1 F II=2:1:RCFLD D SET("          "_RCFLD(II)) Q:IBQUIT
 I RCRC=0 D SET("  -- None --") Q:IBQUIT
 D:'IBQUIT SET("--------------------------------------------------------------------------------") Q:IBQUIT
 ; Walk through the line level information...
 D SET("EEOB LINE LEVEL ADJUSTMENTS:") Q:IBQUIT
 S RCPL=0,EE="" F  S EE=$O(IBCL(361.115,EE)) Q:EE=""  S RCPL=RCPL+1 D  Q:IBQUIT
 . S QQ=EE,RCMD="" F  S QQ=$O(IBCL(361.1152,QQ)) Q:$E(QQ,1,$L(EE))'=EE  S RCMD=IBCL(361.1152,QQ,.01,"I")
 . D SET(" #   SV DT  REVCD   PROC  MOD  UNITS   BILLED  DEDUCT   COINS    ALLOW     PYMT") Q:IBQUIT
 . S RCBAMT=$$BILLN^IBJTEP1(IBEOB(361.1,IBEIEN_",",.01,"I"),IBCL(361.115,EE,.1,"E"),IBCL(361.115,EE,.04,"E"))
 . S RCDED=$$ADJU^IBJTEP1("DEDUCT",.IBCL,EE),RCOIN=$$ADJU^IBJTEP1("COINS",.IBCL,EE) ; Get Deductable and Co-Insurance amts.
 . S XLN=$J(RCPL,2,0)_" "_$$FMTE^XLFDT(IBCL(361.115,EE,.16,"I"),"2Z")_" "_$$CJ^XLFSTR(IBCL(361.115,EE,.1,"E"),5)_" "_$$CJ^XLFSTR(IBCL(361.115,EE,.04,"E"),8)_$$CJ^XLFSTR(RCMD,5)_" "_$$CJ^XLFSTR(IBCL(361.115,EE,.11,"E"),3)
 . D SET(XLN_" "_$J(RCBAMT,9,2)_$J(RCDED,8,2)_$J(RCOIN,8,2)_$J(IBCL(361.115,EE,.13,"E"),9,2)_$J(IBCL(361.115,EE,.03,"E"),9,2)) Q:IBQUIT
 . D SET(" ") Q:IBQUIT
 . D SET("  Product/Service Description:"_IBCL(361.115,EE,.09,"E")) Q:IBQUIT
 . D SET("  Payer Policy Reference:"_$G(IBCL(361.11512,EE,.01,"E"))) Q:IBQUIT
 . D SET(" ") Q:IBQUIT
 . S ACNT=0,AA=EE F  S AA=$O(IBCL(361.1151,AA)) Q:$E(AA,1,$L(EE))'=EE  D  Q:IBQUIT
 .. S ACNT=ACNT+1
 .. S CC=AA,RCRC=0 F  S CC=$O(IBCL(361.11511,CC)) Q:$E(CC,1,$L(AA))'=AA  D  Q:IBQUIT
 ... S RCRC=RCRC+1 D SET("  -> ADJ. AMT: "_$J(IBCL(361.11511,CC,.02,"E"),9,2)_"  ADJ GROUP: "_IBCL(361.1151,AA,.01,"I")_" - "_IBCL(361.1151,AA,.01,"E")_"  "_$$CJ^XLFSTR("QTY: "_+$G(IBCL(361.11511,CC,.03,"E")),8)) Q:IBQUIT
 ... S RCXY=$$FIND1^DIC(345,"","BX",IBCL(361.11511,CC,.01,"E"),"","","RCERR")
 ... K RCRDC,RCERR S RCXY=$$GET1^DIQ(345,RCXY_",",4,"","RCRDC","RCERR")
 ... I $D(RCRDC)>0 K RCFLD D DLN^IBJTEP("RCRDC","RCFLD",57,57)
 ... I $D(RCRDC)=0 K RCFLD S RCRDC(1)=IBCL(361.11511,CC,.04,"E") D DLN^IBJTEP("RCRDC","RCFLD",57,57) ; If no data from file 345 use data from FMS
 ... D SET("      ADJ CODE: "_$$CJ^XLFSTR(IBCL(361.11511,CC,.01,"E"),5)_" "_RCFLD(1)) Q:IBQUIT
 ... I RCFLD>1 F II=2:1:RCFLD D SET("                      "_RCFLD(II)) Q:IBQUIT
 . ; Display RARC Codes for this Line Item
 . I $D(IBCL(361.1154))'=0 S QQ=EE,RCMD="" F  S QQ=$O(IBCL(361.1154,QQ)) Q:$E(QQ,1,$L(EE))'=EE  D  Q:IBQUIT
 .. S RMIEN=$$FIND1^DIC(346,"","BX",IBCL(361.1154,QQ,.02,"E"),"","","IBERR")
 .. I RMIEN'="" K IBPERR,RCRDC,RCFLD S RCXY=$$GET1^DIQ(346,RMIEN_",",4,"","RCRDC","IBPERR") D DLN^IBJTEP("RCRDC","RCFLD",50,68)
 .. D SET("  --- RARC: "_IBCL(361.1154,QQ,.02,"E")_" - "_RCFLD(1)) Q:IBQUIT
 .. I RCFLD>1 F II=2:1:RCFLD D SET("          "_RCFLD(II)) Q:IBQUIT
 . D:ACNT'=0 SET(" ") Q:IBQUIT
 I ACNT=0 D SET("  -- No Line Level Adjustments --") Q:IBQUIT
 ; If there are EOB Errors add them to the Report
 D:$D(IBEERR(361.1,IBEIEN_",",20))>9
 . D SET(" ") Q:IBQUIT  D SET("EEOB MESSAGE ERRORS:") Q:IBQUIT
 . N II S II=0 F  S II=$O(IBEERR(361.1,IBEIEN_",",20,II)) Q:II=""  D SET($G(IBEERR(361.1,IBEIEN_",",20,II))) Q:IBQUIT
 D:'IBQUIT SET("================================================================================") Q:IBQUIT
 ;
 Q
SET(DATA,NEW) ;
 I $G(NEW)="" S NEW=1
 W DATA,! S IBSL=IBSL+1
 I IBSL'<(IOSL-4) S IBQUIT=$$NEWPG(.IBPG,NEW,.IBSL,IBPERA)
 Q
RHDR(IBSCR,IBDT,IBPG) ;Prints EOB detail report heading
 ; IBSCR - IEN of the ERA; IBDT - Report Date; IBPG - page #, passed by reference.
 N Z
 S Z=$G(^RCY(344.4,IBSCR,0))
 I IBPG!($E(IOST,1,2)="C-") W @IOF,*13
 S IBPG=IBPG+1
 D HDRP("EDI EEOB DETAIL - 835 INFORMATION SCREEN "_$$FMTE^XLFDT(IBDT,2),1,"Page: "_IBPG)
 D HDRP($E(" ERA NUMBER: "_IBSCR_$J("",25),1,25)_" ERA DATE: "_$$FMTE^XLFDT($P(Z,U,4)),1)
 D HDRP("INS COMPANY: "_$P(Z,U,6)_"/"_$P(Z,U,3),1)
 D HDRP("ERA TRACE #: "_$P(Z,U,2),1)
 W !,$TR($J("",IOM)," ","="),!
 S IBSL=5
 Q
 ;
NEWPG(IBPG,IBNEW,IBSL,IBSCR) ; Check for new page needed, output header
 ; IBPG = Page number passwd by referece
 ; IBNEW = 1 to force new page
 ; IBSL = page length passed by reference
 ; Function returns 1 if user chooses to stop output
 N IBSTOP S IBSTOP=0
 I IBNEW!'IBPG!(IBSL'<(IOSL-4)) D
 . D:IBPG ASK(.IBSTOP) I IBSTOP Q
 . W @IOF
 . D RHDR(IBSCR,IBDT,.IBPG)
 Q IBSTOP
 ;
ASK(IBSTOP) ; User if you want to quit or continue
 S IBSTOP=0
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBSTOP=1 Q
 Q
 ;
HDRP(Z,X,Z1) ; Print Header (Z=String, X=1 (line feed) X=0 (no LF), Z1 (page number right justified)
 I X=1 W !
 W ?(IOM-$L(Z)\2),Z W:$G(Z1)]"" ?(IOM-$L(Z1)),Z1
 Q
