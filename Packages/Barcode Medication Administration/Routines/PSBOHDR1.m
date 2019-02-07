PSBOHDR1 ;AITC/CR - REPORT FOR RESPIRATORY THERAPY MEDS ;7/30/18 12:32pm
 ;;3.0;BAR CODE MED ADMIN;**103**;Mar 2004;Build 21
 ;Per VA Directive 6402, this routine should not be modified.
 ;
WARD(PSBWP,PSBHDR,PSBCONT,PSBDT,SRCHTXT) ; called from PSBORT 
 ; PSBWP:   Nurse Location File IEN (optional)
 ; PSBHDR:  array for header
 ; PSBCONT: True if this is a continuation page
 ; PSBDT:   Date of Pt Information (Default to DT)
 ; SRCHTXT: search text - optional
 ;
 N PSBMODE,PSBWRDA,Y
 S:'$G(PSBDT) PSBDT=DT
 I '$D(PSBHDR("DATE")) D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ S PSBHDR("DATE")="Run Date: "_Y
 S:'$D(PSBHDR("PAGE")) PSBHDR("PAGE")=0
 ;W:$Y>1 @IOF
 I $E(IOST,1,2)="C-" W !!
 E  W:$Y>1 @IOF ; printout goes to a printer
 W:$X>0 !
 W $TR($J("",IOM)," ","=")
 W !,$G(PSBHDR(0))
 S PSBMODE="Include Inpatient Orders Only"
 I $G(PSBHDR(0))]"" W !,PSBMODE
 W $G(PSBHDR(1)),?102,PSBHDR("DATE")
 I $G(PSBHDR(0))="" W !,PSBMODE
 S PSBHDR("PAGE")=PSBHDR("PAGE")+1
 W $G(PSBHDR(2)),?103,$J("Page: "_PSBHDR("PAGE"),10)
 F X=3:1 Q:'$D(PSBHDR(X))  D
 . W !,PSBHDR(X)
 . I PSBHDR(X)["Clinic Search" W $$WRAP^PSBO(21,111,SRCHTXT)
 . I PSBHDR(X)["Ward Location" W SRCHTXT
 I $G(PSBCONT) W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 I $G(PSBMUDV)=1 S X="Division: "_PSBNAME D HDR1 Q  ; Div prompt
 I $G(PSBMUDV)=2 S X="Division: "_"ALL" D HDR1 Q    ; Div prompt
 I $G(PSBMUDV)=0 S X="Division: "_$$NAME^XUAF4(DUZ(2)) D HDR1 Q  ; no Div prompt, single site support
 Q
HDR1 ;
 W !,X,!,$TR($J("",IOM)," ","=")
 Q
