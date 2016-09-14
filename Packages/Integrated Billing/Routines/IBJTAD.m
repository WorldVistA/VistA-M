IBJTAD ;ALB/TJB - TP ERA/835 ADDITIONAL INFORMATION SCREEN ;01-MAY-2015
 ;;2.0;INTEGRATED BILLING;**530**;21-MAR-94;Build 71
 ;;Per VA Directive 6402, this routine should not be modified.
 ;; ;
EN ; -- main entry point for IBJT ADDITIONAL 835 DATA
 D EN^VALM("IBJT ADDITIONAL 835 DATA")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="******* ADDITIONAL INFORMATION FOUND IN THE 835 at the EOB level"
 Q
 ;
INIT ; -- init variables and list array
 I '$G(IBIFN) S VALMQUIT="" G INITQ
 N ADERA,ADLN,ADRNM,ADRNPI,ADRTQ,IBRP,DIR,DIRUT,DIROUT,DTOUT,DUOUT,DZX,EPIEN,I,IBIFN,X,Y,IBARR,IBAR2,IBAR3,IBFN,IBMN,IBLN,IBPAYNM,IBPPAYTE,IBPPAYFX,IBPPAYEM
 ; EPBILL and ERALST come in from IBJTEP, that routine will clean up these variables.
IN1 ;
 S IBRP(U)=", "
 I $L(ERALST,U)=1 S ADERA=ERALST G IN2
 S DIR("A")="Enter ERA for Receipt Review: ",DIR(0)="FA^1:10"
 S DIR("A",1)="Enter an ERA# from the following list for additional information."
 S DIR("A",2)="Available ERAs: "_$$REPLACE^XLFSTR(ERALST,.IBRP)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S VALMQUIT=1 G EXIT
 S ADERA=Y I (U_ERALST_U)'[(U_Y_U) W !!,"ERA: "_Y_" not a valid selection. Please try again...",! S X="",ADERA="" G IN1
IN2 ;
 ; Get IEN pointing back to 361.1 & Rendering/Servicing Provider information
 K IBARR,IBAR2,IBAR3
 ; EPBILL is created/Killed in IBJTEP
 D FIND^DIC(344.41,","_ADERA_",",".02I;.19;.2;.21;.23","",EPBILL,,"AC",,,"IBAR2","ER")
 D GETS^DIQ(344.4,ADERA_",",".06;3.01;3.02;3.03;3.04;3.05;3.06;3.07;5.01;","IE","IBAR3","ER") ; Get web address
 ; Check to see if we may have an EEOB if not report no ERA Information for this K-Bill
 S EPIEN=$G(IBAR2("DILIST","ID",1,".02")) I EPIEN="" S VALMCNT=2 D SET^VALM10(1," "),SET^VALM10(2,"No ERA Information for Bill: "_EPBILL) G INITQ
 S ADLN=0 S EPIEN=EPIEN_","
 ; Get additional ERA information from this entry in 361.1
 D GETS^DIQ(361.1,EPIEN,".21;1.21;61.01;1.07;1.17;1.12;1.13;1.14;1.15;1.16;25.01;25.02;25.03;25.04;25.05;25.06;25.07;.08;.09","IE","IBARR")
 ; Set Rendering/Servicing provider information
 S ADRNM=$G(IBAR2("DILIST","ID",1,.21)),ADRNPI=$G(IBAR2("DILIST","ID",1,.19)),ADRTQ=$G(IBAR2("DILIST","ID",1,.2))
 ; Set Corrected Patient Name and ID
 S IBFN=$P(IBARR("361.1",EPIEN,61.01,"E"),U,4),IBMN=$P(IBARR("361.1",EPIEN,61.01,"E"),U,5),IBLN=$P(IBARR("361.1",EPIEN,61.01,"E"),U,3)
 ; Determine Payer's Phone, FAX and e-mail information
 F I=25.03,25.05,25.07 D
 . ; If "Extension" then add this to the previous (I-.03) field
 . I $G(IBARR("361.1",EPIEN,I,"I"))="EX" S:I'=25.03 DZX(IBARR("361.1",EPIEN,I-.03,"I"))=DZX(IBARR("361.1",EPIEN,I-.03,"I"))_" x"_IBARR("361.1",EPIEN,I-.03,"E") Q
 . I $G(IBARR("361.1",EPIEN,I,"I"))'="" S DZX(IBARR("361.1",EPIEN,I,"I"))=$G(IBARR("361.1",EPIEN,(I-.01),"E"))
 ; If the contact information is not present, set to ""
 I $D(DZX)=0 S DZX("TE")="",DZX("EM")="",DZX("FX")=""
 S IBPAYNM=$S(IBARR("361.1",EPIEN,25.01,"E")'="":IBARR("361.1",EPIEN,25.01,"E"),1:$G(IBAR3("344.4",ADERA_",",3.01,"E")))
 ;
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Claim Code/Status: "_IBARR("361.1",EPIEN,.21,"E")_"/"_$$CCS(IBARR("361.1",EPIEN,.21,"E")))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Coverage Expiration Date: "_IBARR("361.1",EPIEN,1.13,"E")_"  Claim Received Date: "_IBARR("361.1",EPIEN,1.12,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Interest Amount: "_IBARR("361.1",EPIEN,1.07,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Corrected Patient Name: "_IBFN_" "_$S(IBMN'="":IBMN_" ",1:"")_IBLN)
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Corrected Patient ID: "_$P(IBARR("361.1",EPIEN,61.01,"E"),U,6))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Other Subscriber Name: "_IBARR("361.1",EPIEN,1.17,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Rendering/Servicing Provider Name: "_ADRNM)
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Rendering/Servicing Provider NPI: "_ADRNPI)
 I $G(IBAR2("DILIST","ID",1,.23))]"" S ADLN=ADLN+1 D SET^VALM10(ADLN,"  NPI Comment: "_IBAR2("DILIST","ID",1,.23))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Type Qualifier: "_ADRTQ)
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Claim Contact Name: "_IBARR("361.1",EPIEN,25.01,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Claim Contact Phone: "_$G(DZX("TE")))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Claim Contact FAX: "_$G(DZX("FX")))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Claim Contact e-mail: "_$G(DZX("EM")))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"*** ADDITIONAL INFORMATION FOUND IN THE 835 at the ERA level: ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Payer Name/Payment From: "_IBAR3("344.4",ADERA_",",.06,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Payer Contact Name: "_IBAR3("344.4",ADERA_",",3.01,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Payer Contact Phone: "_IBAR3("344.4",ADERA_",",3.02,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Payer Contact FAX: "_IBAR3("344.4",ADERA_",",3.04,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Payer Contact e-mail: "_IBAR3("344.4",ADERA_",",3.06,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Payer Website Address: "_IBAR3("344.4",ADERA_",",5.01,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"*** Corrected Priority Payer Name (Last Name or Organization Name): ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,IBARR("361.1",EPIEN,1.14,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Type: "_IBARR("361.1",EPIEN,1.15,"I")_"/"_IBARR("361.1",EPIEN,1.15,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"ID: "_IBARR("361.1",EPIEN,1.16,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"  ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"*** Crossover Carrier Name (Last Name or Organization Name): ")
 S ADLN=ADLN+1 D SET^VALM10(ADLN,IBARR("361.1",EPIEN,.08,"E"))
 S ADLN=ADLN+1 D SET^VALM10(ADLN,"Crossover ID: "_IBARR("361.1",EPIEN,.09,"E"))
 S VALMCNT=ADLN
 ;
INITQ Q
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
CCS(DATA) ; Build code array
 N XCD
 Q:$G(DATA)="" ""  ; If DATA is null, then nothing to output return empty string
 ;
 S XCD(1)="Processed as Primary"
 S XCD(2)="Processed as Secondary"
 S XCD(3)="Processed as Tertiary"
 S XCD(4)="Denied"
 S XCD(19)="Processed as Primary, Forwarded to Additional Payer(s)"
 S XCD(20)="Processed as Secondary, Forwarded to Additional Payer(s)"
 S XCD(21)="Processed as Tertiary, Forwarded to Additional Payer(s)"
 S XCD(22)="Reversal of Previous Payment"
 S XCD(23)="Not Our Claim, Forwarded to Additional Payer(s)"
 S XCD(25)="Predetermination Pricing Only - No Payment"
 Q:$G(XCD(DATA))'="" $G(XCD(DATA))
 ;
 Q "No Status Code Description"
