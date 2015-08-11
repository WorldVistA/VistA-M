RCDPESP1 ;BIRM/EWL,hrubovcak - ePayment Lockbox Site Parameter Reports ;Aug 14, 2014@14:25:30
 ;;4.5;Accounts Receivable;**298**;Nov 11, 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RPT ; EDI Lockbox Parameters Report [RCDPE SITE PARAMETER REPORT]
 ; report data from:
 ;    AR SITE PARAMETER file (#342)
 ;    RCDPE PARAMETER file (#344.61)
 ;    RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;
 W !,$$HDRLN,!
 N %ZIS,POP S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="SPRPT^RCDPESP1",ZTDESC=$$HDRLN
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task.")
 .K IO("Q") D HOME^%ZIS
 ;
 D SPRPT
 Q
 ;
SPRPT ; site parameter report entry point
 ; RCNTR - counter
 ; RCFLD - DD field number
 ; RCHDR - header information
 ; RCPARM - parameters
 ; RCSTOP - exit flag
 N J,RCNTR,RCFLD,RCGLB,RCHDR,RCPARM,RCSTOP,V,X,Y
 S X="RC" F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clear out old data
 ;
 ; RCGLB - ^TMP global storage locations
 ;     ^TMP($J,"RC342") - AR SITE PARAMETER file (#342)
 ;   ^TMP($J,"RC344.6") - RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;  ^TMP($J,"RC344.61") - RCDPE PARAMETER file (#344.61)
 F J=342,344.6,344.61 S RCGLB(J)=$NA(^TMP($J,"RC"_J)) K @RCGLB(J)
 ;
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"10S")
 S RCHDR("PGNMBR")=0  ; page number
 ;
 ; AR SITE PARAMETER file (#342)
 D GETS^DIQ(342,"1,",".01;7.02;7.03","E",RCGLB(342))
 ; add site to header data
 S RCHDR("SITE")="Site: "_@RCGLB(342)@(342,"1,",.01,"E")
 ;
 F RCFLD=7.02,7.03 D  ; EFT and ERA days unmatched
 .S Y=$$GET1^DID(342,RCFLD,,"LABEL")_": "_@RCGLB(342)@(342,"1,",RCFLD,"E")
 .D AD2RPT(Y)
 ;
 D AD2RPT(" ")
 ; RCDPE PARAMETER file (#344.61)
 D GETS^DIQ(344.61,"1,",".02;.03;.04;.05;.06;.07","E",RCGLB(344.61))
 ; get auto-post and auto-decrease settings, save zero node
 S X=^RCY(344.61,1,0),RCPARM("AUTO-POST")=$P(X,U,2),RCPARM("AUTO-DECREASE")=$P(X,U,3),RCPARM(344.61,0)=X
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;   screening logic: ^DD(344.6,.06,0)="EXCLUDE MED CLAIMS POSTING^S^0:No;1:Yes;^0;6^Q"
 D LIST^DIC(344.6,,"@;.01;.02;.06;1","P",,,,,"I $P(^(0),U,6)=1",,RCGLB(344.6))
 ;
 ; RCDPE PARAMETER file (#344.61), auto-posting of medical claims
 S X=$$GET1^DID(344.61,.02,,"TITLE"),V=" (Y/N)" S:X[V X=$P(X,V)_$P(X,V,2)  ; remove yes/no prompt
 S Y=X_" "_@RCGLB(344.61)@(344.61,"1,",.02,"E")
 D AD2RPT(Y)
 ;
 I (RCPARM("AUTO-POST")!RCPARM("AUTO-DECREASE")) D  ; list auto-post excluded payers
 .I '$D(@RCGLB(344.6)@("DILIST",1,0)) D  Q
 ..S X="     No payers excluded from auto-posting." D AD2RPT($J(" ",80-$L(X)\2)_X)
 .;
 .D AD2RPT("   Excluded Payer                      Comment")
 .S RCNTR=0
 .F  S RCNTR=$O(@RCGLB(344.6)@("DILIST",RCNTR)) Q:'RCNTR  D
 ..S V=@RCGLB(344.6)@("DILIST",RCNTR,0),X=$E($P(V,U,2),1,35)
 ..S Y="   "_X_$J(" ",36-$L(X))_$P(V,U,5)
 ..D AD2RPT($E(Y,1,IOM))
 ;
 I RCPARM("AUTO-POST") D AD2RPT(" ")  ; blank line
 ;
 K @RCGLB(344.6)  ; delete old data
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;   screening logic: ^DD(344.6,.07,0)="EXCLUDE MED CLAIMS DECREASE^S^0:No;1:Yes;^0;7^Q"
 D LIST^DIC(344.6,,"@;.01;.02;.07;2","P",,,,,"I $P(^(0),U,7)=1",,RCGLB(344.6))
 ;
 ; RCDPE PARAMETER file (#344.61), auto-decrease of medical claims
 S X=$$GET1^DID(344.61,.03,,"TITLE"),V=" (Y/N): ",V=" (Y/N)" S:X[V X=$P(X,V)_$P(X,V,2)  ; remove yes/no prompt
 S Y=$J(X,45)_@RCGLB(344.61)@(344.61,"1,",.03,"E")
 D AD2RPT(Y)
 I RCPARM("AUTO-DECREASE") D  ; list these 2 fields only if auto-decrease enabled
 .D AD2RPT("NUMBER OF DAYS TO WAIT BEFORE AUTO-DECREASE: "_(+$P(RCPARM(344.61,0),U,4)))
 .D AD2RPT("     MAXIMUM DOLLAR AMOUNT TO AUTO-DECREASE: "_"$"_(+$P(RCPARM(344.61,0),U,5)))
 ;
 I (RCPARM("AUTO-POST")!RCPARM("AUTO-DECREASE")) D  ; list excluded auto-decrease payers
 .D AD2RPT("   All payers excluded from auto-posting are excluded from auto-decrease.")
 .Q:'RCPARM("AUTO-DECREASE")
 .I '$D(@RCGLB(344.6)@("DILIST",1,0)) D  Q
 ..S X="     No additional payers excluded from auto-decrease." D AD2RPT($J(" ",80-$L(X)\2)_X)
 .;
 .D AD2RPT("   Additional Excluded Payer           Comment")
 .S RCNTR=0
 .F  S RCNTR=$O(@RCGLB(344.6)@("DILIST",RCNTR)) Q:'RCNTR  D
 ..S V=@RCGLB(344.6)@("DILIST",RCNTR,0),X=$E($P(V,U,2),1,35)
 ..S Y="   "_X_$J(" ",36-$L(X))_$P(V,U,5)
 ..D AD2RPT($E(Y,1,IOM))
 ;
 D AD2RPT(" ")  ; blank line
 ;
 ; RCDPE PARAMETER file (#344.61)
 F RCFLD=.06,.07 D
 .S Y=$$GET1^DID(344.61,RCFLD,,"TITLE")_" "_@RCGLB(344.61)@(344.61,"1,",RCFLD,"E")
 .D AD2RPT(Y)
 ;
 D AD2RPT(" "),AD2RPT($$ENDORPRT^RCDPEARL)
 ;
 S RCSTOP=0 U IO D SPHDR(.RCHDR)
 S J=0 F  S J=$O(^TMP($J,"RC SP REPORT",J)) Q:'J!RCSTOP  S Y=^TMP($J,"RC SP REPORT",J,0) D
 .W !,Y Q:'$O(^TMP($J,"RC SP REPORT",J))  ; quit if last line
 .I '$G(ZTSK),$E(IOST,1,2)="C-",$Y+3>IOSL D ASK^RCDPEARL(.RCSTOP) I 'RCSTOP D SPHDR(.RCHDR) Q
 .Q:RCSTOP  Q:$Y+2<IOSL
 .D SPHDR(.RCHDR)
 ;
 ; close device
 U IO(0) D ^%ZISC
 ;
 S X="RC" F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clean up
 ;
 Q
 ;
SPHDR(HDR) ; HDR passed by ref.
 ; HDR("RUNDATE") - run date, external format
 ;  HDR("PGNMBR") - page number
 ;    HDR("SITE") - site name
 N P,X,Y
 S P=$G(HDR("PGNMBR"))+1,HDR("PGNMBR")=P  ; increment page count
 ; 
 S X=$$HDRLN
 S P=IOM-($L(X)+10)\2,Y=$J(" ",P)_X_$J(" ",P)_" Page: "_HDR("PGNMBR")
 W @IOF,Y
 S X="   Run Date: "_HDR("RUNDATE"),Y=X_$J(HDR("SITE"),IOM-($L(X)+1))
 W !,Y
 S Y=" "_$TR($J("",IOM-2)," ","-")  ; space_row of hyphens
 W !,Y
 Q
 ;
AD2RPT(A) ; add line to report
 Q:$G(A)=""
 N C S C=$G(^TMP($J,"RC SP REPORT",0))+1,^TMP($J,"RC SP REPORT",0)=C
 S ^TMP($J,"RC SP REPORT",C,0)=A Q
 ;
HDRLN() Q "EDI Lockbox Parameters Report"  ; extrinsic variable
 ;
