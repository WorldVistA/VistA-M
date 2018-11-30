RCDPESP1 ;BIRM/SAB,hrubovcak - ePayment Lockbox Site Parameter Reports ;7/1/15
 ;;4.5;Accounts Receivable;**298,304**;Mar 20, 1995;Build 104
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
 ; LOCAL VARIABLES:
 ;    RTYPE - Type of Report to run (Medical, Pharmacy, or Both)
 ;
 N RCTYPE
 W !,$$HDRLN,!
 ;
 S RCTYPE=$$RTYPE^RCDPESP2() G:RCTYPE=-1 RPTQ
 W !!   ;Spacing before the next prompt
 ;
 N %ZIS,POP S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="SPRPT^RCDPESP1",ZTDESC=$$HDRLN,ZTSAVE("RC*")=""
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task.")
 .K IO("Q") D HOME^%ZIS
 ;
 D SPRPT
RPTQ Q
 ;
SPRPT ; site parameter report entry point
 ; RCNTR - counter
 ; RCFLD - DD field number
 ; RCHDR - header information
 ; RCPARM - parameters
 ; RCSTOP - exit flag
 N J,RCNTR,RCFLD,RCGLB,RCHDR,RCPARM,RCSTOP,V,X,Y,RCSTRING
 N RCDATA,RCCODE,RCDESC,RCSTAT,RCI,RCCARCD,RCCIEN,RCITEM,RCACTV
 ;
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
 D GETS^DIQ(342,"1,",".01;7.02;7.03;7.04;7.05;7.06","E",RCGLB(342))
 ; add site to header data
 S RCHDR("SITE")="Site: "_@RCGLB(342)@(342,"1,",.01,"E")
 ;
 F RCFLD=7.02,7.03,7.04,7.05,7.06 S RCITEM=$S(RCFLD=7.05:"TITLE",RCFLD=7.06:"TITLE",1:"LABEL") D  ; EFT and ERA days unmatched
 . Q:(RCFLD=7.05)&(RCTYPE="P")  ; Dont display if only showing Pharmacy parameters
 . Q:(RCFLD=7.06)&(RCTYPE="M")  ; Dont display if only showing medical parameters
 . S Y=$$GET1^DID(342,RCFLD,,RCITEM)_": "_@RCGLB(342)@(342,"1,",RCFLD,"E")
 . I RCFLD=7.05 D AD2RPT(" ")
 . I (RCFLD=7.06)&(RCTYPE="P") D AD2RPT(" ")
 . D AD2RPT(Y)
 ;
 D AD2RPT(" ")
 ;
 ; Display Medical Parameters
 ; RCDPE PARAMETER file (#344.61)
 D GETS^DIQ(344.61,"1,",".02;.03;.04;.05;.06;.07;1.01;1.02","E",RCGLB(344.61))
 ; get auto-post and auto-decrease settings, save zero node
 S X=$G(^RCY(344.61,1,0)),RCPARM("AUTO-POST")=$P(X,U,2),RCPARM("AUTO-DECREASE")=$P(X,U,3),RCPARM(344.61,0)=X
 S RCPARM("RX AUTO-POST")=$P($G(^RCY(344.61,1,1)),U)
 ;
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;   screening logic: ^DD(344.6,.06,0)="EXCLUDE MED CLAIMS POSTING^S^0:No;1:Yes;^0;6^Q"
 D LIST^DIC(344.6,,"@;.01;.02;.06;1","P",,,,,"I $P(^(0),U,6)=1",,RCGLB(344.6))
 ;
 ; PRCA*4.5*304 - Print Medical Claim Parameters
 I RCTYPE'="P" D
 .; RCDPE PARAMETER file (#344.61), auto-posting of medical claims
 .S X=$$GET1^DID(344.61,.02,,"TITLE"),V=" (Y/N)" S:X[V X=$P(X,V)_$P(X,V,2)  ; remove yes/no prompt
 .S Y=X_" "_@RCGLB(344.61)@(344.61,"1,",.02,"E")
 .D AD2RPT(Y)
 .;
 .I (RCPARM("AUTO-POST")!RCPARM("AUTO-DECREASE")) D  ; list auto-post excluded payers
 ..I '$D(@RCGLB(344.6)@("DILIST",1,0)) D  Q
 ...S X="     No payers excluded from medical auto-posting." D AD2RPT($J(" ",80-$L(X)\2)_X)
 ..;
 ..D AD2RPT("   Excluded Payer                      Comment")
 ..S RCNTR=0
 ..F  S RCNTR=$O(@RCGLB(344.6)@("DILIST",RCNTR)) Q:'RCNTR  D
 ...S V=@RCGLB(344.6)@("DILIST",RCNTR,0),X=$E($P(V,U,2),1,35)
 ...S Y="   "_X_$J(" ",36-$L(X))_$P(V,U,5)
 ...D AD2RPT($E(Y,1,IOM))
 .;
 .I RCPARM("AUTO-POST") D AD2RPT(" ")  ; blank line
 .;
 .K @RCGLB(344.6)  ; delete old data
 .; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 .;   screening logic: ^DD(344.6,.07,0)="EXCLUDE MED CLAIMS DECREASE^S^0:No;1:Yes;^0;7^Q"
 .D LIST^DIC(344.6,,"@;.01;.02;.07;2","P",,,,,"I $P(^(0),U,7)=1",,RCGLB(344.6))
 .;
 .; RCDPE PARAMETER file (#344.61), auto-decrease of medical claims
 .S X=$$GET1^DID(344.61,.03,,"TITLE"),V=" (Y/N): ",V=" (Y/N)" S:X[V X=$P(X,V)_$P(X,V,2)  ; remove yes/no prompt
 .S Y=$J(X,45)_@RCGLB(344.61)@(344.61,"1,",.03,"E")
 .D AD2RPT(Y) ; ,AD2RPT(" ")
 .; PRCA*4.5*304 - Removed because auto-decrease amounts are based on CARCs
 .;I RCPARM("AUTO-DECREASE") D  ; list these 2 fields only if auto-decrease enabled
 .;.D AD2RPT("NUMBER OF DAYS TO WAIT BEFORE AUTO-DECREASE: "_(+$P(RCPARM(344.61,0),U,4)))
 .;.D AD2RPT("     MAXIMUM DOLLAR AMOUNT TO AUTO-DECREASE: "_"$"_(+$P(RCPARM(344.61,0),U,5)))
 .;
 .; PRCA*4.5*304 - Print the CARC Auto-decrease parameters
 . I $$CARCCHK(RCTYPE,"M") D
 .. D AD2RPT(" "),AD2RPT("     AUTO-DECREASE MEDICAL CLAIMS FOR THE FOLLOWING CARC/AMOUNTS ONLY:"),AD2RPT(" ")
 .. S RCSTRING=$TR($J("",70)," ","-"),RCI=0
 .. D AD2RPT("     CARC  Description                                             Max. Amt")
 .. D AD2RPT("     "_RCSTRING)
 .. ;
 .. ; Loop and print entries
 .. F  S RCI=$O(^RCY(344.62,RCI)) Q:'RCI  D
 .. . S RCDATA=$G(^RCY(344.62,RCI,0)),Y=""
 .. . Q:RCDATA=""
 .. . S RCCODE=$P(RCDATA,U),RCCIEN=$O(^RC(345,"B",RCCODE,""))
 .. . S RCDESC=$G(^RC(345,RCCIEN,1,1,0))
 .. . S RCSTAT=$P(RCDATA,U,2)
 .. . Q:RCSTAT'=1
 .. . I $L(RCDESC)>50 S RCDESC=$E(RCDESC,1,50)_" ..."
 .. . D GETCODES^RCDPCRR(RCCODE,"","A",$$DT^XLFDT,"RCCARCD","1^70")
 .. . S Y="     "_$J(RCCODE,4)_"  "
 .. . S Y=Y_$E(RCDESC,1,53) S:$L(RCDESC)<53 Y=Y_$J("",(53-$L(RCDESC))) S Y=Y_$J($P(RCDATA,U,6),10,0)
 .. . I '$$ACT^RCDPRU(345,RCCODE,) S Y=Y_" (I)"  ; if inactive, display (i)
 .. . D AD2RPT(Y)
 .. ;
 ..D AD2RPT(" ")  ; blank line
 .I (RCPARM("AUTO-POST")!RCPARM("AUTO-DECREASE")) D  ; list excluded auto-decrease payers
 .. S X=$P($$GET1^DID(344.61,.04,,"TITLE")," (",1)_": "
 .. S Y=$J(X,50)_@RCGLB(344.61)@(344.61,"1,",.04,"E")
 .. D AD2RPT(Y),AD2RPT(" ")
 .. D AD2RPT("     All payers excluded from Auto-Posting are excluded from Auto-Decrease.")
 .. Q:'RCPARM("AUTO-DECREASE")
 .. I '$D(@RCGLB(344.6)@("DILIST",1,0)) D  Q
 ... S X="       No additional payers excluded from Medical Auto-Decrease." D AD2RPT($J(" ",80-$L(X)\2)_X)
 ..;
 .. D AD2RPT("     Additional Excluded Payer           Comment")
 .. S RCNTR=0
 .. F  S RCNTR=$O(@RCGLB(344.6)@("DILIST",RCNTR)) Q:'RCNTR  D
 ... S V=@RCGLB(344.6)@("DILIST",RCNTR,0),X=$E($P(V,U,2),1,35)
 ... S Y="     "_X_$J(" ",36-$L(X))_$P(V,U,5)
 ... D AD2RPT($E(Y,1,IOM))
 .;
 .D AD2RPT(" ")  ; blank line
 ;
 K @RCGLB(344.6)  ; delete old data
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;   screening logic: ^DD(344.6,.06,0)="EXCLUDE MED CLAIMS POSTING^S^0:No;1:Yes;^0;6^Q"
 D LIST^DIC(344.6,,"@;.01;.02;.08;3","P",,,,,"I $P(^(0),U,8)=1",,RCGLB(344.6))
 ;
 ; PRCA*4.5*304 - Print Pharmacy Claim Parameters
 I RCTYPE'="M" D
 .; RCDPE PARAMETER file (#344.61), auto-posting of pharmacy claims
 .S X=$$GET1^DID(344.61,1.01,,"TITLE"),V=" (Y/N)" S:X[V X=$P(X,V)_$P(X,V,2)  ; remove yes/no prompt
 .S Y=X_" "_@RCGLB(344.61)@(344.61,"1,",1.01,"E")
 .D AD2RPT(Y)
 .;
 . I RCPARM("RX AUTO-POST") D  ; list auto-post excluded payers
 .. I '$D(@RCGLB(344.6)@("DILIST",1,0)) D  Q
 ... S X="     No payers excluded from pharmacy auto-posting." D AD2RPT($J(" ",80-$L(X)\2)_X)
 ..;
 .. D AD2RPT("   Excluded Payer                      Comment")
 .. S RCNTR=0
 .. F  S RCNTR=$O(@RCGLB(344.6)@("DILIST",RCNTR)) Q:'RCNTR  D
 ... S V=@RCGLB(344.6)@("DILIST",RCNTR,0),X=$E($P(V,U,2),1,35)
 ... S Y="   "_X_$J(" ",36-$L(X))_$P(V,U,5)
 ... D AD2RPT($E(Y,1,IOM))
 .. S X=$P($$GET1^DID(344.61,1.02,,"TITLE")," (",1)_": "  ; remove yes/no prompt
 .. S Y="     "_X_" "_$S(@RCGLB(344.61)@(344.61,"1,",1.02,"E")="":"No",1:@RCGLB(344.61)@(344.61,"1,",1.02,"E"))
 .. D AD2RPT(" "),AD2RPT(Y)
 .;
 .I RCPARM("RX AUTO-POST") D AD2RPT(" ")  ; blank line
 .;
 .K @RCGLB(344.6)  ; delete old data
 .;
 .; PRCA*4.5*304 - Print the CARC Auto-decrease parameters
 . I $$CARCCHK(RCTYPE,"P") D
 .. S RCSTRING=$TR($J("",73)," ","-"),RCI=0
 .. D AD2RPT("  CARC  Description                                             Max. Amt")
 .. D AD2RPT(RCSTRING)
 .. ;
 .. ; Loop and print entries
 .. F  S RCI=$O(^RCY(344.62,RCI)) Q:'RCI  D
 .. . S RCDATA=$G(^RCY(344.62,RCI,0)),Y=""
 .. . Q:RCDATA=""
 .. . S RCCODE=$P(RCDATA,U),RCCIEN=$O(^RC(345,"B",RCCODE,""))
 .. . S RCDESC=$G(^RC(345,RCCIEN,1,1,0))
 .. . S RCSTAT=$P(RCDATA,U,2)
 .. . Q:RCSTAT'=1
 .. . I $L(RCDESC)>50 S RCDESC=$E(RCDESC,1,50)_" ..."
 .. . D GETCODES^RCDPCRR(RCCODE,"","A",$$DT^XLFDT,"RCCARCD","1^70")
 .. . S Y="  "_$E(RCCODE,1,4)_"  "
 .. . S Y=Y_$E(RCDESC,1,55)_$J($P(RCDATA,U,6),10,0)
 .. . I '$$ACT^RCDPRU(345,RCCODE,) S Y=Y_" (I)"  ; if inactive, display (i)
 .. . D AD2RPT(Y)
 ;
 ; RCDPE PARAMETER file (#344.61)
 F RCFLD=.06,.07 D
 . Q:(RCFLD=.06)&(RCTYPE="P")  ; Dont display if only showing Pharmacy parameters
 . Q:(RCFLD=.07)&(RCTYPE="M")  ; Dont display if only showing medical parameters
 . S Y=$$GET1^DID(344.61,RCFLD,,"TITLE")_" "_@RCGLB(344.61)@(344.61,"1,",RCFLD,"E")
 . D AD2RPT(Y)
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
 I '$G(ZTSK),$E(IOST,1,2)="C-",'RCSTOP D ASK^RCDPEARL(.RCSTOP)
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
HDRLN() Q "EDI Lockbox Parameters Report"_$S($G(RCTYPE)="B":" - ALL",$G(RCTYPE)="M":" - MEDICAL",$G(RCTYPE)="P":" - PHARMACY",1:"")  ; extrinsic variable
 ;
 ;Function to check to see if the CARC parameters are to appear on the report
CARCCHK(RCTYPE,TYPE) ;
 ;
 N RCMEN,RCREN
 ;
 ; Return 1 if valid to print, 0 otherwise
 ;
 Q:RCTYPE="B"&($G(TYPE)="M") +$P($G(^RCY(344.61,1,0)),U,3)  ;User wants all parameters and we are checking for medical auto decrease
 ;
 Q:RCTYPE="B"&($G(TYPE)="P") +$P($G(^RCY(344.61,1,1)),U,2)  ;User wants all parameters and we are checking for Pharmacy auto decrease
 ;
 S (RCMEN,RCREN)=""
 ;
 ;Print if Report type is medical and auto-decrease for medical is on
 I RCTYPE="M" S RCMEN=+$P($G(^RCY(344.61,1,0)),U,3) Q RCMEN
 ;
 ;Print if Report type is pharmacy and auto-decrease for pharmacy is on
 I RCTYPE="P" S RCREN=+$P($G(^RCY(344.61,1,1)),U,2) Q RCREN
 ;
 Q 0  ;Don't print the CARCs
 ;
