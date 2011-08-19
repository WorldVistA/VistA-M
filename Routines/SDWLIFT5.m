SDWLIFT5 ;IOFO BAY PINES/OG - INTER-FACILITY TRANSFER: ACCEPT DATA - MAIN SCREEN  ; Compiled March 29, 2005 15:26:24  ; Compiled January 26, 2007 10:05:24
 ;;5.3;Scheduling;**415,446**;AUG 13 1993;Build 77
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   10/03/06                    SD*5.3*446              Enhancements
 ;
 Q
EN ; INITIALIZE VARIABLES
 K DIR,DIC,DR,DIE,VADM,SDWLLIST,VALMHDR,VALMCNT,VALMBCK
 D EN^VALM("SDWL TRANSFER ACC MAIN")
 Q
INIT ; Default initialization options.
 K ^TMP("DILIST",$J),^TMP("SDWLIFT",$J,"EP")
 N SDWLI,DIC
 S SDWLSPS=$J("",80)
 S VALMCNT=0
 D GETLIST F SDWLI=1:1:SDWLLIST(0) D
 .N SDWLOUT
 .S VALMCNT=VALMCNT+1
 .S SDWLOUT=$E(VALMCNT_SDWLSPS,1,3)
 .S SDWLOUT=SDWLOUT_$E($P(SDWLLIST(SDWLI,0),U)_SDWLSPS,1,26)_" "
 .S SDWLOUT=SDWLOUT_$E($P(SDWLLIST(SDWLI,0),U,2)_SDWLSPS,1,21)_" "
 .S SDWLOUT=SDWLOUT_$E($P(SDWLLIST(SDWLI,0),U,3)_SDWLSPS,1,25)_" "
 .S SDWLOUT=SDWLOUT_$P(SDWLLIST(SDWLI,0),U,4)
 .D SET^VALM10(VALMCNT,SDWLOUT)
 .Q
 I 'VALMCNT S VALMCNT=1 D SET^VALM10(VALMCNT," ** No transfer details... ")
 Q
HD ; -- Make header line for list processor
 S (VALMHDR(1),VALMHDR(2))=""
 Q
EXIT ; Tidy up
 K ^TMP("DILIST",$J),^TMP("SDWLIFT",$J,"EP")
 K SDWLLIST,SDWLSPS,SDWLIFTN
 Q
GETLIST ;
 N SDWLI
 S DIC=409.36
 D LIST^DIC(DIC)
 S (SDWLI,SDWLLIST(0))=0,DIC(0)="Z"
 F  S SDWLI=$O(^TMP("DILIST",$J,2,SDWLI)) Q:'SDWLI  D
 .N TMP,SDWLIFTN,SDWLST,DIC,D,X
 .S SDWLIFTN=^TMP("DILIST",$J,2,SDWLI)
 .D GETS^DIQ(409.36,SDWLIFTN,".01;.02;.03;.09;.1;.2;1",,"TMP")
 .S SDWLST=$$GET1^DIQ(409.36,SDWLIFTN,1,"I")
 .Q:SDWLST="C"!(SDWLST="R")!(SDWLST="T")
 .S SDWLLIST(0)=SDWLLIST(0)+1
 .S SDWLLIST(SDWLLIST(0),0)=TMP(409.36,SDWLIFTN_",",.01)
 .S $P(SDWLLIST(SDWLLIST(0),0),U,2)=TMP(409.36,SDWLIFTN_",",.2)  ; date/time
 .S $P(SDWLLIST(SDWLLIST(0),0),U,3)=$$GET1^DIQ(4,$$FIND1^DIC(4,"","X",TMP(409.36,SDWLIFTN_",",.1),"D"),.01)
 .S $P(SDWLLIST(SDWLLIST(0),0),U,4)=SDWLST
 .S SDWLLIST(SDWLLIST(0),1)=SDWLIFTN
 .Q
 Q
GETDATA(SDWLOUT,SDWLFMT) ; Get request data for display.
 ; SDWLFMT - output format: 0: filtered, only active transmissions
 ;                          1: all transmissions
 ;                          2: filtered, only inactive transmissions
 N SDWLI,DIC,X,Y
 S DIC=409.35
 D LIST^DIC(DIC)
 S (SDWLI,SDWLOUT(0))=0,DIC(0)="Z"
 F  S SDWLI=$O(^TMP("DILIST",$J,2,SDWLI)) Q:'SDWLI  S X="`"_^TMP("DILIST",$J,2,SDWLI) D ^DIC I $D(Y(0)) D
 .N REC,SDWLNAM,DFN,SDWLDA,SDWLSTA,TMP,SDWLIFTN,SDWLTY,SDWLTV,VADM,DIC,D,X
 .S REC=Y(0),SDWLNAM=Y(0,0),SDWLDA=$P(Y(0),U),SDWLIFTN=+Y,DFN=$$GET1^DIQ(409.3,SDWLDA,.01,"I")
 .D GETS^DIQ(409.35,SDWLIFTN,"1;2;3;4",,"TMP")
 .S SDWLSTA=TMP(409.35,SDWLIFTN_",",3),SDWLTV=SDWLSTA="RESOLVED"!(SDWLSTA="REFUSED")
 .I 'SDWLFMT Q:SDWLTV  ; Only show 'active' transmissions.
 .I SDWLFMT=2 Q:'SDWLTV  ; Only show 'inactive' transmissions.
 .D DEM^VADPT
 .D GETS^DIQ(409.3,SDWLDA,"2;4",,"TMP")
 .S SDWLOUT(0)=SDWLOUT(0)+1
 .S SDWLOUT(SDWLOUT(0),1)=SDWLIFTN
 .; Name
 .S SDWLOUT(SDWLOUT(0),0)=SDWLNAM
 .; SSN
 .S $P(SDWLOUT(SDWLOUT(0),0),U,2)=$P(VADM(2),U,2)
 .; Destination Institution
 .S $P(SDWLOUT(SDWLOUT(0),0),U,3)=$$GET1^DIQ(4,$$FIND1^DIC(4,"","X",TMP(409.35,SDWLIFTN_",",1),"D"),.01)
 .; Transfer Status
 .S $P(SDWLOUT(SDWLOUT(0),0),U,4)=SDWLSTA
 .; Current Wait List Institution
 .S $P(SDWLOUT(SDWLOUT(0),0),U,5)=TMP(409.3,SDWLDA_",",2)
 .; Current Wait List Type
 .S $P(SDWLOUT(SDWLOUT(0),0),U,6)=TMP(409.3,SDWLDA_",",4)
 .; Current Wait List Type Extension
 .S SDWLTY=$$GET1^DIQ(409.3,SDWLDA,4,"I")
 .S $P(SDWLOUT(SDWLOUT(0),0),U,7)=$$GET1^DIQ(409.3,SDWLDA,SDWLTY+4)
 .; Sex
 .S $P(SDWLOUT(SDWLOUT(0),0),U,8)=$P(VADM(5),U,2)
 .; Transmission date/time
 .S $P(SDWLOUT(SDWLOUT(0),0),U,9)=TMP(409.35,SDWLIFTN_",",2)
 .; Requestor
 .S $P(SDWLOUT(SDWLOUT(0),0),U,10)=TMP(409.35,SDWLIFTN_",",4)
 .Q
 Q
