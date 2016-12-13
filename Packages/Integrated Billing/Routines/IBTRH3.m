IBTRH3 ;ALB/VAD - IBT HCSR RESPONSE VIEW ;02-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IBT HCSR Response View
 N IBPTNO,IBTRIEN,IBOK,DATA,IBTRNM,IBTRSPEC
 N DFN,NODE0,IEN312,INSNODE0,VALMCNT
 S IBTRNM="IBTRH3"
 ;
 D EN^VALM("IBT HCSR RESPONSE VIEW")
 I $G(IBPTNO)'=-1,'$D(IBFASTXT) K IBTNO,IBTRIEN,IBOK,DATA,IBTRN,IBTRSPEC,DFN,NODE0,IEN312,INSNODE0,VALMCNT G EN
 Q
 ;
EN2 ;JWS;alternate entry point when IBTRIEN is selected from
 ; a response list view, so IBTRIEN is known
 N DLINE,IBPTNO,IBTRIEN,IBOK,DATA,IBTRNM,IBTRSPEC
 N DFN,NODE0,IEN312,INSNODE0,VALMCNT
 S IBTRNM="IBTRH3"
 S IBTRIEN=+$$SELEVENT^IBTRH5(0,"Select entry",.DLINE) ; select entry to expand
 I IBTRIEN'>0 Q
 D EN^VALM("IBT HCSR RESPONSE VIEW")
 Q
 ;
EN3 ;alternate entry point when IBTRIEN is selected from
 ; a response list view to display response pending entry,
 ; so IBTRIEN is known for the current entry and we need
 ; to figure out the pending response.
 N CURIEN,CURNODE0
 S CURIEN=IBTRIEN
 S CURNODE0=NODE0
 ;
 N DLINE,IBPTNO,IBTRIEN,IBOK,DATA,IBTRNM,IBTRSPEC
 N DFN,NODE0,IEN312,INSNODE0,VALMCNT
 S IBTRNM="IBTRH3"
 I $P(CURNODE0,U,8)'="07" D NODP Q
 S IBTRIEN=$P(CURNODE0,U,14)
 I IBTRIEN'>0 D NODP Q
 D EN^VALM("IBT HCSR RESPONSE VIEW")
 Q
 ;
HDR ; -- header code
 N VADM,Z
 S Z=""
 I +$G(DFN) D DEM^VADPT S Z=$E(VADM(1),1,28),Z=Z_$J("",35-$L(Z))_$P(VADM(2),U,2)_"    DOB: "_$P(VADM(3),U,2)_"    AGE: "_VADM(4)
 S VALMHDR(1)=Z
 S VALMSG="#In-Prog"
 Q
 ;
INIT ; -- init variables and list array
 ;JWS 9/9/14 - added conditions based on IBTRIEN already selected
 K ^TMP(IBTRNM,$J)
 ;
 ; May need a switch or 2 to call INIT^IBTRH2 one to not display comments and
 ; maybe another to change the primary subscript from "IBTRH2" to something else
 ;
 ; JWS 9/9/14 - if response IEN has value, set PATIENT variable and skip forward
 I +$G(IBTRIEN) S IBPTNO=$P($G(^IBT(356.22,IBTRIEN,0)),U,2) G INIT1
 ; Get the Patient.
 S IBPTNO=$$ASKPAT() I IBPTNO=-1 S VALMQUIT="" G INITQ
 I '$D(^IBT(356.22,"D",IBPTNO)) D  G INIT
 . W !,"No HCSR Response data for this Patient.",!
 ;
 ; Get the Appointment/Admission Date.
 S IBTRIEN=$$ASKEVT(IBPTNO)
 I IBTRIEN=-1 S VALMQUIT="" G INITQ
 I '$G(IBTRIEN) S VALMQUIT="" G INITQ
INIT1 ;
 S IBTRSPEC("IBTPATID")=IBPTNO
 S IBTRSPEC("IBTEVENT")=IBTRIEN
 ;
 S NODE0=$G(^IBT(356.22,IBTRIEN,0))
 S DFN=+$P(NODE0,U,2)
 S IEN312=+$P(NODE0,U,3)
 S INSNODE0="" S:IEN312>0 INSNODE0=$G(^DPT(DFN,.312,IEN312,0)) ; 0-node in file 2.312
 ;
 ; Compile the data for the display.
 D COMPILE(IBTRNM,.IBTRSPEC)
INITQ Q
 ;
ASKPAT()    ; Get the Patient Name
 ; Init vars
 N DIC,DTOUT,DUOUT,X,Y
 ; Patient lookup
 W !
 S DIC(0)="AEQM",DIC("S")="I $D(^IBT(356.22,""D"",Y))"
 S DIC("A")=$$FO^IBCNEUT1("Select PATIENT NAME: ",21,"R")
 S DIC="^DPT("
 D ^DIC
 Q +Y
 ;
ASKEVT(IBTRIEN) ; Get the Appointment/Admission
 N A1,A2,MX,SEL,YY,XIEN,XREQ,XREQDATA
 S YY=$$GTLIST(IBTRIEN) I YY=-1 D NODP G ASKEVTX  ; If no Appts Quit.
ASKEVT1 ;
 S A1="",MX=0
 W !!!,"Select Appt/Adm:",!
 ; Loop through the list if Appointments/Admissions and display each one.
 F  S A1=$O(^TMP("IBTRH3E",$J,"XLISTNO",A1)) Q:A1=""  S A2=$P(^(A1),"^",3) D
 . S XIEN=+$G(^TMP("IBTRH3E",$J,"DILIST",2,A2))
 . S XREQ=+$P($G(^IBT(356.22,XIEN,0)),"^",13),XREQDATA=$G(^IBT(356.22,XREQ,0))
 . W !?5,A1,".  ",$S($P(XREQDATA,"^",4)="I":"Adm: ",1:"App: ")
 . W $$FMTE^XLFDT($P(^TMP("IBTRH3E",$J,"XLISTNO",A1),U,1)),"    "
 . W $S($P(XREQDATA,"^",20)=1:"215:",1:"217:") S MX=A1
 . W " ",$$FMTE^XLFDT($P($P(XREQDATA,U,15),".")),"  "
 . I $P($G(^IBT(356.22,XIEN,103)),"^") W $$GET1^DIQ(356.22,XIEN_",",103.01)
 . E  I $D(^IBT(356.22,XIEN,101)) W "AAA"
 R !,"Enter Selection: ",SEL:DTIME I SEL=""!(SEL="^") S YY=-1 G ASKEVTX ; Nothing selected.
 I SEL<1!(SEL>MX) W !?5,"INVALID SELECTION.",! G ASKEVT1
 S YY=$P($G(^TMP("IBTRH3E",$J,"XLISTNO",SEL)),U,3)
 S YY=+$G(^TMP("IBTRH3E",$J,"DILIST",2,YY))
 I YY=0 S YY=-1
ASKEVTX Q YY
 ;
GTLIST(IBTRIEN) ; Create list of Appointments/Admission Dates.
 ; This will create a ^TMP global that will look similar to the following:
 ;    ^TMP("IBTRH3E",$J,"DILIST",0)="1^*^0^"
 ;    ^TMP("IBTRH3E",$J,"DILIST",0,"MAP")=.07
 ;    ^TMP("IBTRH3E",$J,"DILIST",I1,J)="JUN 19, 2014@11:00"
 ;    ^TMP("IBTRH3E",$J,"DILIST",I2,J)=IBTRNO
 ;    ^TMP("IBTRH3E",$J,"DILIST","ID",J,.07)=IBTEVNT
 ; where:
 ;    I1 = The first cross-reference index which has the external event date values to display.
 ;    I2 = The second cross-reference index which has the pointers to the IBT(356.22,...) Record no.
 ;    J = Is just the internal counter of events for the selected patient.
 ;    And ^IBT(356.22,"D",IBTRIEN,IBTEVNT,IBTRNO) is the actual Cross-reference record.
 ;
 N A,B,X,Z,Z1
 S X=-1
 K ^TMP("IBTRH3E",$J)
 ; Only want Responses for the selected Patient.
 D LIST^DIC(356.22,,".07",,,,,,"I $P(^(0),U,2)=IBTRIEN,$P(^(0),U,20)=2",,"^TMP(""IBTRH3E"",$J)")
 I +$P($G(^TMP("IBTRH3E",$J,"DILIST",0)),U,1) D
 . S A=""
 . F  S A=$O(^TMP("IBTRH3E",$J,"DILIST","ID",A)) Q:A=""  D
 . . S B=^(A,.07) S ^TMP("IBTRH3E",$J,"XLIST",B,$G(^TMP("IBTRH3E",$J,"DILIST",1,A)))=A
 . S Z=0,(A,B)=""
 . F  S A=$O(^TMP("IBTRH3E",$J,"XLIST",A)) Q:A=""  D   ; Appt/Adm
 . . S B=""
 . . F  S B=$O(^TMP("IBTRH3E",$J,"XLIST",A,B)) Q:B=""  S Z1=$G(^(B)) D    ; Date Entered
 . . . S Z=Z+1
 . . . S ^TMP("IBTRH3E",$J,"XLISTNO",Z)=A_U_B_U_Z1
 . S X=1
 Q X
 ;
COMPILE(IBTRNM,IBTRSPEC)    ; -- Compile the data
 K ^TMP(IBTRNM,$J)
 ;
 ; Compile Data
 D SETDATA,BLD
 Q
 ;
SETDATA ; -- Set up the data
 N SQ,SQ1,SQ2,SQ3,SQ4,X,IBTRNO
 S IBTRNO=IBTRSPEC("IBTEVENT")
 S DATA(0)=$G(^IBT(356.22,IBTRNO,0))
 ;
 I $D(^IBT(356.22,IBTRNO,1)) D    ; Comments Multiple.
 . S SQ="" F  S SQ=$O(^IBT(356.22,IBTRNO,1,SQ)) Q:SQ=""  S DATA(1,SQ,0)=$G(^IBT(356.22,IBTRNO,1,SQ,0))
 ;
 S DATA(2)=$G(^IBT(356.22,IBTRNO,2))
 ;
 I $D(^IBT(356.22,IBTRNO,3)) D    ; Patient Diagnosis Multiple.
 . S SQ=0 F  S SQ=$O(^IBT(356.22,IBTRNO,3,SQ)) Q:SQ=""  S DATA(3,SQ,0)=$G(^IBT(356.22,IBTRNO,3,SQ,0))
 ;
 S DATA(4)=$G(^IBT(356.22,IBTRNO,4))
 S DATA(7)=$G(^IBT(356.22,IBTRNO,7))
 S DATA(8)=$G(^IBT(356.22,IBTRNO,8))
 S DATA(9)=$G(^IBT(356.22,IBTRNO,9))
 S DATA(10)=$G(^IBT(356.22,IBTRNO,10))
 ;
 I $D(^IBT(356.22,IBTRNO,11)) D    ; Attachments Multiple.
 . S SQ=0 F  S SQ=$O(^IBT(356.22,IBTRNO,11,SQ)) Q:(SQ="")!('+SQ)  S DATA(11,SQ,0)=$G(^IBT(356.22,IBTRNO,11,SQ,0))
 ;
 I $D(^IBT(356.22,IBTRNO,12)) D
 . N SQ1,TEXT
 . S SQ=0 F  S SQ=$O(^IBT(356.22,IBTRNO,12,SQ)) Q:SQ=""  D
 . . S TEXT=$G(^IBT(356.22,IBTRNO,12,SQ,0))
 . . I $L(TEXT)>80 D  Q
 . . . N SAV,X1,END
 . . . S END=$L(TEXT," ")
 . . . F I=1:1:END S X1=$P(TEXT," ",I) D
 . . . . I X1="",$G(SAV)="" Q
 . . . . I X1="" S X1=" "
 . . . . I $L(X1)+$L($G(SAV))<78 S:$G(SAV)'="" SAV=SAV_" " S SAV=$G(SAV)_X1 Q
 . . . . S SQ1=$G(SQ1)+1,DATA(12,SQ1)=SAV,SAV=X1
 . . . I $G(SAV)'="" S SQ1=$G(SQ1)+1,DATA(12,SQ1)=SAV
 . . . S DATA(12,0)=SQ1
 . . S SQ1=$G(SQ1)+1,DATA(12,SQ1)=TEXT
 . . S DATA(12,0)=+SQ1
 ;
 I $D(^IBT(356.22,IBTRNO,13)) D    ; Patient Event Provider Multiple.
 . S SQ1=0 F  S SQ1=$O(^IBT(356.22,IBTRNO,13,SQ1)) Q:SQ1=""  D
 . . I SQ1'?.N Q
 . . S SQ2="" F SQ2=0:1:5 S DATA(13,SQ1,SQ2)=$G(^IBT(356.22,IBTRNO,13,SQ1,SQ2))
 ;
 I $D(^IBT(356.22,IBTRNO,14)) D    ; Patient Event Transport Multiple.
 . S SQ="" F  S SQ=$O(^IBT(356.22,IBTRNO,14,SQ)) Q:SQ=""  S DATA(14,SQ,0)=$G(^IBT(356.22,IBTRNO,14,SQ,0))
 ;
 I $D(^IBT(356.22,IBTRNO,15)) D    ; Other UMO Multiple.
 . S SQ="" F  S SQ=$O(^IBT(356.22,IBTRNO,15,SQ)) Q:SQ=""  S DATA(15,SQ,0)=$G(^IBT(356.22,IBTRNO,15,SQ,0))
 ;
 ;
 I $D(^IBT(356.22,IBTRNO,16)) D    ; Service Line Multiple.
 . S SQ1=0 S DATA(16,0)=$G(^IBT(356.22,IBTRNO,16,0))
 . F  S SQ1=$O(^IBT(356.22,IBTRNO,16,SQ1)) Q:SQ1=""  D      ; Service Line Item.
 . . I SQ1'?.N Q
 . . S DATA(16,SQ1,0)=$G(^IBT(356.22,IBTRNO,16,SQ1,0))
 . . S SQ2=0 F  S SQ2=$O(^IBT(356.22,IBTRNO,16,SQ1,SQ2)) Q:SQ2=""  D     ; Service Line Item sub-record.
 . . . I SQ2'?.N Q
 . . . I "^4^6^7^8^10^"[(U_SQ2_U) D  Q  ; Service Line Item sub-record is a multiple.
 . . . . ; (i.e.,  ^IBT(356.22,IBTRNO,16,1,6,0))
 . . . . S DATA(16,SQ1,SQ2,0)=$G(^IBT(356.22,IBTRNO,SQ1,SQ2,0))
 . . . . S SQ3=0 F  S SQ3=$O(^IBT(356.22,IBTRNO,16,SQ1,SQ2,SQ3)) Q:SQ3=""  D
 . . . . . I SQ3'?.N Q
 . . . . . ; (i.e.,  ^IBT(356.22,IBTRNO,16,1,6,1,0))
 . . . . . S DATA(16,SQ1,SQ2,SQ3,0)=$G(^IBT(356.22,IBTRNO,16,SQ1,SQ2,SQ3,0))
 . . . . . S SQ4="" F  S SQ4=$O(^IBT(356.22,IBTRNO,16,SQ1,SQ2,SQ3,SQ4)) Q:SQ4=""  D
 . . . . . . I SQ4'?.N Q
 . . . . . . ; (ie., ^IBT(356.22,IBTRNO,16,1,8,1,0-5,0))
 . . . . . . S DATA(16,SQ1,SQ2,SQ3,SQ4,0)=$G(^IBT(356.22,IBTRNO,16,SQ1,SQ2,SQ3,SQ4,0))
 . . . . Q
 . . . ; These sub-records are not multiples.
 . . . S DATA(16,SQ1,SQ2)=$G(^IBT(356.22,IBTRNO,16,SQ1,SQ2))   ; This is true of sub-records 0,1,2,3,5,7,9,11.
 ;
 ;
 S DATA(17)=$G(^IBT(356.22,IBTRNO,17))
 S DATA(18)=$G(^IBT(356.22,IBTRNO,18))
 S DATA(19)=$G(^IBT(356.22,IBTRNO,19))
 S DATA(20)=$G(^IBT(356.22,IBTRNO,20))
 S DATA(21)=$G(^IBT(356.22,IBTRNO,21))
 S DATA(22)=$G(^IBT(356.22,IBTRNO,22))
 ;
 I $D(^IBT(356.22,IBTRNO,101)) D    ; AAA Segment Multiple.
 . S SQ=0 S DATA(101,0)=$G(^IBT(356.22,IBTRNO,101,0))
 . F  S SQ=$O(^IBT(356.22,IBTRNO,101,SQ)) Q:SQ=""  S DATA(101,SQ,0)=$G(^IBT(356.22,IBTRNO,101,SQ,0))
 ;
 S DATA(103,0)=$G(^IBT(356.22,IBTRNO,103))
 ;
 I $D(^IBT(356.22,IBTRNO,105)) D    ; TRN Segment Multiple.
 . S SQ=0 S DATA(105,0)=$G(^IBT(356.22,IBTRNO,105,0))
 . F  S SQ=$O(^IBT(356.22,IBTRNO,105,SQ)) Q:SQ=""  S DATA(105,SQ,0)=$G(^IBT(356.22,IBTRNO,105,SQ,0))
 ;
 I $D(^IBT(356.22,IBTRNO,107)) D    ; HI Segment Multiple.
 . S SQ=0 S DATA(107,0)=$G(^IBT(356.22,IBTRNO,107,0))
 . F  S SQ=$O(^IBT(356.22,IBTRNO,107,SQ)) Q:SQ=""  S DATA(107,SQ,0)=$G(^IBT(356.22,IBTRNO,107,SQ,0))
 Q
 ;
BLD ; charges, as they would display on the bill
 S VALMCNT=0
 D EN2^IBTRH2(IBTRNM,IBTRIEN)   ; Get the Group Insurance information.
 D GETINFO^IBTRH3A(IBTRNM,IBTRIEN)
 Q
 ;
NODP ; No Response Pending for this selection.
 D FULL^VALM1
 W !!,"  No Response Pending to view."
 D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
SETDLN(DLN,SPEC) ; Add Display Line to ^TMP global.
 S VALMCNT=VALMCNT+1
 S ^TMP(IBTRNM,$J,VALMCNT,0)=DLN
 I $G(SPEC)="B" D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 Q
 ;
GTXNMY(VARPTR) ; API to obtain a Provider's Taxonomy Code and Person Class.
 ; INPUT:  VARPTR is the variable pointer to the Provider.
 ;   It can point to 1 of the 3 following globals:
 ;     "ien;VA(200"      points to the VA Individual Provider global
 ;     "ien;DIC(4"       points to the VA Institutional Provider global
 ;     "ien;IBA(355.93"  points to the non-VA Provider global
 ;   where the ien is the internal identifier to the specified global.
 ;
 ; OUTPUT:  TAXNMY will contain Taxonomy Results in 2 pieces:
 ;     Piece 1:  will contain the Taxonomy Code
 ;     Piece 2:  will contain the Person Class Description.
 N RESULTS,TAXNMY,PC1,PC2
 S (RESULTS,TAXNMY)=""
 S PC1=$P(VARPTR,";",1),PC2=$P(VARPTR,";",2)
 I PC2["VA(200" S RESULTS=$$TAXIND^XUSTAX(PC1)  ; Get Taxonomy for VA Individual Provider
 I PC2["DIC(4" S RESULTS=$$TAXORG^XUSTAX(PC1)   ; Get Taxonomy for VA Institutional Provider
 I PC2["IBA(355.93" S RESULTS=$$TAXGET^IBCEP81(PC1)  ; Get Taxonomy for Non-VA Provider
 I '+$P(RESULTS,U,2) Q TAXNMY
 S TAXNMY=$P(RESULTS,U,1)   ; Taxonomy Code
 S $P(TAXNMY,U,2)=$$GET1^DIQ(8932.1,+$P(RESULTS,U,2),.01)  ; Person Class description
 Q TAXNMY
 ;
HELP ; -- help code
 D FULL^VALM1
 W !!,"This option displays the view of a Healthcare Services Review Response."
 D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBTRH3",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
PRMARK(WHICH)   ;EP
 ; Listman Protocol Action to Mark/Remove 'In-Progress' from a selected entry
 ; from the expand entry worklist
 ; Input:   WHICH   - 0 - Remove 'In-Progress' mark
 ;                    1 - Set 'In-Progress' mark
 ;          IBTRIEN - IEN of the Expanded Entry being marked/removed
 N STATUS
 D PRMARK^IBTRH1(WHICH,IBTRIEN,"IBTRH5IX")
 S STATUS=$$GET1^DIQ(356.22,IBTRIEN_",",.21,"I")
 I WHICH=1 D  Q
 . I +STATUS=1 S VALMSG="Entry has been Marked" Q
 . S VALMSG="Nothing Done"
 ;
 I +STATUS=0 S VALMSG="Entry has been Unmarked" Q
 S VALMSG="Nothing Done"
 Q
 ;
