RCTCSWL1 ;ALB/PAW-Cross Servicing Worklist ;30-SEP-2015
 ;;4.5;ACCOUNTS RECEIVABLE;**315,339**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
GETRPT(RCRPT) ; Create patient report based upon report selection
 ; required input RCRPT (see comments below for number/report correlation)
 ; output ^TMP("RCTCSWL",$J), containing auths for group queue
 N RCBILLEX,RCDATE,RCDEBTOR,RCDFN,RCBILL,RCDBTRN,RCDFN,RCFND1,RCTRAN,RCRTCD,RCRTCDX,RCUNC,RCPIF,RCSPA,RCDIV,RCDIVX
 ; Loop through ACCOUNTS RECEIVABLE File (#430) Cross-Servicing Index
 S RCDATE="" F  S RCDATE=$O(^PRCA(430,"AN",RCDATE)) Q:RCDATE=""  D
 .S RCBILL="" F  S RCBILL=$O(^PRCA(430,"AN",RCDATE,RCBILL)) Q:RCBILL=""  D
 ..I +$P($G(^PRCA(430,RCBILL,30)),U,9) Q  ;Bill has been removed from CS Reconciliation Worklist
 ..S RCDEBTOR=$P($G(^PRCA(430,RCBILL,0)),U,9)  ;Debtor in File 340
 ..I $P($G(^RCD(340,RCDEBTOR,0)),U,1)["DPT" S RCDFN=+$P($G(^RCD(340,RCDEBTOR,0)),U,1)
 ..S RCRTCD=$P($G(^PRCA(430,RCBILL,30)),U,2)
 ..I RCRTCD="" Q
 ..S RCRTCDX=$P(^PRCA(430.5,RCRTCD,0),U)
 ..S RCBILLEX=$P(^PRCA(430,RCBILL,0),U)
 ..; Check if running for specific Division - MEDICAL CENTER DIVISION File #40.8
 ..S RCDIV=$P(RCBILLEX,"-")
 ..S RCDIVX="" I VAUTD=0 I '$D(VAUTD(RCDIV)) Q
 ..; Check if running for specific Patient
 ..I $P(FILTERS(0),U,3)=1 I '$D(RCDFN) Q
 ..I $P(FILTERS(0),U,3)=1 I '$D(FILTERS(2,RCDFN)) Q
 ..; Specific checks for each type of report
 ..I RCRPT=1 I RCRTCDX'="B" Q  ;Bankruptcy Return Reason code B
 ..I RCRPT=2 I RCRTCDX'="D" Q  ;Death Return Reason Code D
 ..I RCRPT=3 I RCRTCDX'="Z" Q  ;Uncollectable Return Reason Code Z
 ..I RCRPT=4 I RCRTCDX'="F" Q  ;Payment in Full - Return Reason Code = F
 ..I RCRPT=5 I RCRTCDX'="P" Q  ;Satisfied PA - Return Reason Code = P, but nothing in Compromise Field
 ..I RCRPT=6 I RCRTCDX'="S" Q  ;Compromise Field set to Y
 ..I RCRPT=7 I RCRTCDX="" Q  ;Any Return Reason Code
 ..D BLDTMP
 Q
 ;
BLDTMP ; Build ^TMP("RCTCSWL",$J) for the main list screen
 N A1,A2,PRCA3,DFN,RCBAL,RCBILLEX,RCNAME,RCPTID,RCRTRSN,RCLINE,VA,VADM,VAERR,TRTYP,RCBIND
 I $D(RCDFN) D
 . S DFN=RCDFN
 . D DEM^VADPT
 . I VAERR K VADM
 . S RCNAME=VADM(1)
 . S RCPTID=$E(RCNAME,1)_VA("BID")
 S A1=$P(^RCD(340,RCDEBTOR,0),";",1),A2=$P($P(^(0),U,1),";",2),PRCA3=U_A2_A1_",0)",RCNAME=$S($D(@PRCA3):$P(^(0),U,1),1:"")
 S RCBAL=$$GET1^DIQ(430,RCBILL_",",11)
 S RCBILLEX=$P($G(^PRCA(430,RCBILL,0)),U,1)  ;External Bill Number
 ; Set historical indicator "y" when returned from Treasury
 I $D(^PRCA(430,"AN",RCDATE,RCBILL)) S RCBIND="y"
 S RCLINE=$G(RCNAME)_U_$G(RCPTID)_U_$G(RCBAL)_U_$G(DFN)_U_$G(RCBIND)_$G(RCBILLEX)_U_RCDEBTOR_U_RCBILL_U_RCDATE_U_RCRTCDX
 ; Sort by Patient Name
 I SORTBY=1 S ^TMP("RCTCSWL",$J,RCNAME,RCBILLEX)=RCLINE
 ; Sort by Bill Number
 I SORTBY=2 S ^TMP("RCTCSWL",$J,RCBILLEX,RCNAME)=RCLINE
 ; Sort by Return Reason Code
 I SORTBY=3 S ^TMP("RCTCSWL",$J,RCRTCDX,RCBILLEX)=RCLINE
 ;
BLDWL ; Format main list screen data lines
 ; build display lines
 K ^TMP("RCTCSWLX",$J)
 N RCBILL,RCBILLEX,RCDATE,RCDEBTOR,RCDFN,RCNAME,RCPATNAM,RCPTID,RCRRSN,RCXX,RCY,RCYY,FIRST,LINE,VCNT
 S (VALMCNT,FIRST,VCNT)=0
 S RCY="" F  S RCY=$O(^TMP("RCTCSWL",$J,RCY)) Q:RCY=""  D
 .S RCYY="" F  S RCYY=$O(^TMP("RCTCSWL",$J,RCY,RCYY)) Q:RCYY=""  D
 ..S VCNT=VCNT+1
 ..S LINE=$$LJ^XLFSTR(VCNT,6) ;line #
 ..S RCXX=^TMP("RCTCSWL",$J,RCY,RCYY)
 ..S RCPATNAM=$P(RCXX,U)
 ..S RCPTID=$P(RCXX,U,2)
 ..S RCDFN=$P(RCXX,U,4)
 ..S RCBILLEX=$P(RCXX,U,5)
 ..S RCDEBTOR=$P(RCXX,U,6)
 ..S RCBILL=$P(RCXX,U,7)
 ..S RCDATE=$P(RCXX,U,8)
 ..S RCRRSN=$P(RCXX,U,9)
 ..I SORTBY=1 D
 ...;Patient^Patient ID^Bill No.^Balance^Ret Rsn
 ...S LINE=$$SETL(LINE,$P(RCXX,U),"",4,27)
 ...S LINE=$$SETL(LINE,$P(RCXX,U,2),"",32,5)
 ...S LINE=$$SETL(LINE,$P(RCXX,U,5),"",40,12)
 ...S LINE=$$SETL(LINE,$J($P(RCXX,U,3),10,2),"",55,12)
 ...S LINE=$$SETL(LINE,$P(RCXX,U,9),"",67,3)
 ..I SORTBY=2 D
 ...;Bill No.^Patient ID^Patient^Balance^Ret Rsn
 ...S LINE=$$SETL(LINE,$P(RCXX,U,5),"",4,12)
 ...S LINE=$$SETL(LINE,$P(RCXX,U,2),"",17,5)
 ...S LINE=$$SETL(LINE,$P(RCXX,U),"",24,27)
 ...S LINE=$$SETL(LINE,$J($P(RCXX,U,3),10,2),"",55,12)
 ...S LINE=$$SETL(LINE,$P(RCXX,U,9),"",67,3)
 ..I SORTBY=3 D
 ...;Ret Rsn^Bill No.^Pt ID^Patient^Balance  
 ...S LINE=$$SETL(LINE,$P(RCXX,U,9),"",4,7)
 ...S LINE=$$SETL(LINE,$P(RCXX,U,5),"",12,12)
 ...S LINE=$$SETL(LINE,$P(RCXX,U,2),"",25,5)
 ...S LINE=$$SETL(LINE,$P(RCXX,U),"",32,27)
 ...S LINE=$$SETL(LINE,$J($P(RCXX,U,2),10,2),"",64,12)
 ..S VALMCNT=VALMCNT+1
 ..D SET^VALM10(VALMCNT,LINE,VCNT)
 ..S ^TMP("RCTCSWLX",$J,VCNT)=RCDFN_U_RCPATNAM_U_RCPTID_U_RCDEBTOR_U_RCBILL_U_RCBILLEX_U_RCDATE_U_RCRRSN  ;This is set for ACTIONS
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input: LINE - Current line being created
 ; DATA - Information to be added to the end of the current line
 ; LABEL - Label to describe the information being added
 ; COL - Column position in line to add information add
 ; LNG - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
EXCEL ;Format and Print EXCEL file
 W @IOF
 N RCX,RCXX,RCY,RCYY,RCZ,RCAMT
 S RCX=$P(FILTERS(0),U,1)
 S RCXX=$S(RCX=1:"Bankruptcy",RCX=2:"Deaths",RCX=3:"Uncollectible",RCX=4:"Payment in Full",1:"")
 I $G(RCXX)="" S RCXX=$S(RCX=5:"Satisfied PA",RCX=6:"Compromise",RCX=7:"All Returns",1:"")
 W !,RCXX_" Report"
 I SORTBY=1 W !,"Patient Name^Patient ID^Bill Number^Current Amount^Rt Rsn Code"
 I SORTBY=2 W !,"Bill Number^Patient ID^Patient Name^Current Amount^Rt Rsn Code"
 I SORTBY=3 W !,"Rt Rsn Code^Bill Number^Patient ID^Patient Name^Current Amount"
 S RCY="" F  S RCY=$O(^TMP("RCTCSWL",$J,RCY)) Q:RCY=""  D
 .S RCYY="" F  S RCYY=$O(^TMP("RCTCSWL",$J,RCY,RCYY)) Q:RCYY=""  D
 ..S RCZ=^TMP("RCTCSWL",$J,RCY,RCYY)
 ..;Reformat Excel line, based upon sort
 ..;Input from RCZ: PtName_U_PtID_U_CurBal_U_DFN_U_Bill No_U_Debtor_U_InternalBill_U_Date_U_ReturnReasonCode
 ..S RCAMT=$P(RCZ,U,3)
 ..I RCAMT="" S RCAMT=0
 ..S RCAMT=$J(RCAMT,10,2)
 ..I SORTBY=1 W !,$P(RCZ,U)_"^",$P(RCZ,U,2)_"^"_$P(RCZ,U,5)_"^"_RCAMT_"^"_$P(RCZ,U,9)
 ..I SORTBY=2 W !,$P(RCZ,U,5)_"^",$P(RCZ,U,2)_"^"_$P(RCZ,U)_"^"_RCAMT_"^"_$P(RCZ,U,9)
 ..I SORTBY=3 W !,$P(RCZ,U,9)_"^",$P(RCZ,U,5)_"^"_$P(RCZ,U,2)_"^"_$P(RCZ,U)_"^"_RCAMT
 I $E(IOST,1,2)="C-",'EXCEL R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K IOP,%ZIS,ZTQUEUED
 Q
 ;
 ;RCDIV() N DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Reset RCDIV array
 K RCDIV
 ;
 ;First see if they want to enter individual divisions or ALL
 S DIR(0)="S^D:DIVISION;A:ALL"
 S DIR("A")="Select Certain (D)ivisions or (A)LL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     D         DIVISION"
 S DIR("L",4)="     A         ALL"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout, otherwise define BPPHARM
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 E  S RCDIV=$S(Y="A":0,1:1)
 ;
 ;If division selected, ask prompt
 I $G(RCDIV)=1 F  D  Q:Y="^"!(Y="") 
 .;
 .;Prompt for entry
 .K X S DIC(0)="QEAM",DIC=40.8,DIC("A")="Select Division(s): "
 .W ! D ^DIC
 .;
 .;Check for "^" or timeout 
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) K RCDIV S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(X)="" S Y=$S($D(RCDIV)>9:"",1:"^") K:Y="^" RCDIV Q
 .;
 .;Handle Deletes
 .I $D(RCDIV(+Y)) D  Q:Y="^"  I 1
 ..N P
 ..S P=Y  ;Save Original Value
 ..S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ..S DIR("B")="NO" D ^DIR
 ..I ($G(DUOUT)=1)!($G(DTOUT)=1) K RCDIV S Y="^" Q
 ..I Y="Y" K RCDIV(+P),RCDIV("B",$P(P,U,2),+P)
 ..S Y=P  ;Restore Original Value
 ..K P
 .E  D
 ..;Define new entries in RCDIV array
 ..S VAUTD(+Y)=Y
 ..S RCDIV("B",$P(Y,U,2),+Y)=""
 .;
 .;Display a list of selected divisions
 .I $D(RCDIV)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X="" F  S X=$O(RCDIV("B",X)) Q:X=""  W !,?10,X
 ..K X
 .Q
 ;
 K RCDIV("B")
 Q Y
 ;
CSTOP(BILL) ;
 ; Input:
 ; BILL - Bill number from #430 - External Value (.01), not IEN
 ; Output:
 ; CSTOP - Cross-serviced status (blank = not found, 0 = not stopped, 1 = stopped)
 ;
 N CSTOP,IEN
 I BILL="" Q ""  ;no bill #
 I '$D(^PRCA(430,"TCSP",BILL)) Q ""
 S CSTOP=$$GET1^DIQ(430,BILL,"157,","IE")
 Q CSTOP
