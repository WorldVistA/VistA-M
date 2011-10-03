SDWLIFT1 ;IOFO BAY PINES/OG - INTER-FACILITY TRANSFER: REQUEST SUMMARY  ; Compiled March 29, 2005 15:36:25
 ;;5.3;Scheduling;**415**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;
 ;
 Q
EN ; INITIALIZE VARIABLES
 K ^TMP("SDWLIFT",$J)
 K DIR,DIC,DR,DIE,VADM
 S SDWLFMT=0
 D EN^VALM("SDWL TRANSFER REQ MAIN")
 Q
ENI ; INITIALIZE VARIABLES - Inactive entries
 N SDWLFMT
 K ^TMP("SDWLIFT",$J,"EP")
 K DIR,DIC,DR,DIE,VADM
 S SDWLFMT=2
 D EN^VALM("SDWL TRANSFER REQ INAC"),INIT(0)
 S VALMBCK="R"
 Q
INIT(SDWLOPT) ; Default initialization options.
 K ^TMP("DILIST",$J),^TMP("SDWLIFT",$J)
 N SDWLINFO,SDWLI,DISPCNT
 I '$D(DUZ) W !,"DUZ required for this option" D PAUSE^VALM1 Q
 S SDWLDZN=$P(^VA(200,DUZ,0),U)
 S SDWLSPS=$J("",30)
 D GETDATA^SDWLIFT5(.SDWLINFO,SDWLOPT)
 S VALMCNT=0
 F DISPCNT=1:1:SDWLINFO(0) D
 .N SDWLOUT
 .S VALMCNT=VALMCNT+1
 .; Display count
 .S SDWLOUT=$E(DISPCNT_SDWLSPS,1,3)
 .; Name
 .S SDWLOUT=SDWLOUT_$E($P(SDWLINFO(DISPCNT,0),U)_SDWLSPS,1,27)_"  "
 .; SSN
 .S SDWLOUT=SDWLOUT_$E($P(SDWLINFO(DISPCNT,0),U,2)_SDWLSPS,1,12)_"  "
 .; Destination Institution
 .S SDWLOUT=SDWLOUT_$E($P(SDWLINFO(DISPCNT,0),U,3)_SDWLSPS,1,20)_"  "
 .; Transfer Status
 .S SDWLOUT=SDWLOUT_$P(SDWLINFO(DISPCNT,0),U,4)
 .D SET^VALM10(VALMCNT,SDWLOUT)
 .; Line 2
 .S VALMCNT=VALMCNT+1
 .; Current Wait List Institution
 .S SDWLOUT=$E($P(SDWLINFO(DISPCNT,0),U,5)_SDWLSPS,1,30)_"  "
 .; Current Wait List Type
 .S SDWLOUT=SDWLOUT_$P(SDWLINFO(DISPCNT,0),U,6)_" : "
 .; Current Wait List Type Extension
 .S SDWLOUT=SDWLOUT_$P(SDWLINFO(DISPCNT,0),U,7)
 .D SET^VALM10(VALMCNT,SDWLOUT)
 .Q
 I 'VALMCNT S VALMCNT=1 D SET^VALM10(VALMCNT," ** No "_$S(SDWLOPT=2:"in",1:"")_"active transfer details to display... ")
 Q
HD ; -- Make header line for list processor
 N X
 S X=$$SETSTR^VALM1("User: "_SDWLDZN,"",1,79)
 S VALMHDR(1)=X,VALMHDR(2)=""
 Q
EXIT ; Tidy up
 K VALMBCK,VALMHDR,VALMCNT
 K SDWLDZN,SDWLSPS,SDWLINFO,SDWLOPT,SDWLFMT
 K ^TMP("DILIST",$J),^TMP("SDWLIFT",$J)
 Q
GETTRN(SDWLDA,SDWLINNM,SDWLSTN) ; Get transfer details for Electronic Wait List internal entry number
 ; Extrinsic boolean: 0: no active transfer, 1: active transfer.
 ; Input:  SDWLDA:   EWL IEN
 ; Output: SDWLINNM: Institution name
 ;         SDWLSTN:  Station Number
 S (SDWLINNM,SDWLSTN)=""
 Q:'$D(^SDWL(409.35,"B",SDWLDA)) 0
 N SDWLIFTN,SDWLSTA,SDWLINST
 S SDWLIFTN=$O(^SDWL(409.35,"B",SDWLDA,":"),-1),SDWLSTA=$$GET1^DIQ(409.35,SDWLIFTN,3,"I")  ; Get the last transfer: a status of P, T or R can not have entries after.
 Q:"^P^T^R^"'[("^"_SDWLSTA_"^") 0
 S SDWLSTN=$$GET1^DIQ(409.35,SDWLIFTN,1),SDWLINST=$$FIND1^DIC(4,"","X",SDWLSTN,"D"),SDWLINNM=$$GET1^DIQ(4,SDWLINST,60)
 Q 1
