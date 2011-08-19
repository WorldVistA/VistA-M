PSJMISC ;BIR/MV - MISC. SUB-ROUTINES ;03 Aug 98 / 8:42 AM
 ;;5.0; INPATIENT MEDICATIONS ;**181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ;
GCN(PSJDD) ;Return GCNSEQNO for a dispense drug
 ;PSJDD - IEN (file #50)
 NEW PSJDDND,X
 I '+$G(PSJDD) Q ""
 S PSJDDND=$G(^PSDRUG(+PSJDD,"ND"))
 I PSJDDND="" Q ""
 S X=$$PROD0^PSNAPIS($P(PSJDDND,U),$P(PSJDDND,U,3))
 Q $P(X,U,7)
GTVUID(PSJDD) ;Return the VUID for a dispense drug
 ;PSJDD - IEN (file #50)
 NEW PSJND,PSJVUID,DIC
 I '+$G(PSJDD) Q ""
 S PSJVUID=""
 S PSJND=$P($G(^PSDRUG(+PSJDD,"ND")),U,3)
 I +PSJND S PSJVUID=$$GETVUID^XTID(50.68,,PSJND_",")
 Q PSJVUID
VAGEN(PSJDD) ;Return the VA GENERIC name
 ;PSJDD - IEN (file #50)
 NEW PSJIEN,PSJVAGEN
 I '+$G(PSJDD) Q ""
 S PSJIEN=+$G(^PSDRUG(PSJDD,"ND"))
 D ZERO^PSN50P6(PSJIEN,,,,"PSJVAGEN")
 S PSJVAGEN=$G(^TMP($J,"PSJVAGEN",PSJIEN,.01))
 K ^TMP($J,"PSJVAGEN")
 Q PSJVAGEN
 ;
GENVUID(PSJVUID) ;Return the VA GENERIC name
 ;PSJVUID - #50.68
 ;PSJRDIID - Array returning from ^XTID call
 ;PSJNDF - #50.68 ien
 ;GETIREF^XTID - will not return the .01 name if DIC is defined. 
 I '+$G(PSJVUID) Q ""
 NEW PSJNDF,PSJVAGEN,DIC
 K PSJRDIID
 S PSJVAGEN=""
 D GETIREF^XTID("50.68",".01",PSJVUID,"PSJRDIID")
 S PSJNDF=$O(PSJRDIID(50.68,.01,""))
 K PSJRDIID
 I +PSJNDF D
 . D DATA^PSN50P68(+PSJNDF,,"PSJNDF")
 . S PSJVAGEN=$P($G(^TMP($J,"PSJNDF",+PSJNDF,.05)),U,2)
 K ^TMP($J,"PSJNDF")
 Q PSJVAGEN
 ;
CLASS(PSJDD) ;Return the VA CLASS
 Q:'+$G(PSJDD) ""
 NEW PSJCLASS
 S PSJCLASS=$P($G(^PSDRUG(+PSJDD,0)),U,2)
 Q PSJCLASS
 ;
PREMIX(X) ;Check if the solution is flag as a Pre-mix
 ;X - ien from 52.7
 ;Return 0 if not flag as premix.
 I '+$G(X) Q 0
 Q +$P($G(^PS(52.7,+X,0)),U,14)
 ;
IVDDRG(PSIVAS,PSJIEN) ;Return corresponding dispense drug IEN for ad/sol
 ;PSJIEN - ien from 52.6 or 52.7
 ;PSIVAS - "AD" or "SOL"
 NEW DDRUG
 I PSIVAS="AD" S DDRUG=$P($G(^PS(52.6,+PSJIEN,0)),U,2)
 I PSIVAS="SOL" S DDRUG=$P($G(^PS(52.7,+PSJIEN,0)),U,2)
 Q DDRUG
 ;
WRITE(X,DIWL,DIWR) ;Start a new line before writing
 NEW DN
 I '$G(DIWL) S DIWL=1
 I '$G(DIWR) S DIWR=75
 K ^UTILITY($J,"W") D ^DIWP D ^DIWW
 Q
 ;
MYWRITE(X,DIWL,DIWR) ;Continue writing on the same line
 NEW DN,PSJCNT
 I '$G(DIWL) S DIWL=1
 I '$G(DIWR) S DIWR=75
 K ^UTILITY($J,"W") D ^DIWP
 F PSJCNT=0:0 S PSJCNT=$O(^UTILITY($J,"W",DIWL,PSJCNT)) Q:'PSJCNT  W:PSJCNT'=1 ! W ?DIWL,^UTILITY($J,"W",DIWL,PSJCNT,0)
 Q
 ;
COMPARE(DRG,TMPDRG,PSJNPRMX) ;
 ;PSJNPRMX is set to consider non-premix solution.
 ;Compare the DRG array if it has changed
 ;Returning 1 will cause OC to be performed due to add/sol changes or new OE
 I '$D(DRG) Q 0
 I $D(DRG),('$D(TMPDRG)) Q 1
 NEW PSJDIFF,PSJX,X
 S PSJDIFF=0
 F X=0:0 S X=$O(DRG("AD",X)) Q:'X!PSJDIFF  S PSJX=DRG("AD",X) D
 . I DRG("AD",X)'=$G(TMPDRG("AD",X)) S PSJDIFF=1 Q
 I PSJDIFF Q 1
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X!PSJDIFF  S PSJX=DRG("SOL",X) D
 . I '+$G(PSJNPRMX),'$$PREMIX(+PSJX) Q
 . I DRG("SOL",X)'=$G(TMPDRG("SOL",X)) S PSJDIFF=1 Q
 I PSJDIFF Q 1
 F X=0:0 S X=$O(TMPDRG("AD",X)) Q:'X!PSJDIFF  S PSJX=TMPDRG("AD",X) D
 . I TMPDRG("AD",X)'=$G(DRG("AD",X)) S PSJDIFF=1 Q
 I PSJDIFF Q 1
 F X=0:0 S X=$O(TMPDRG("SOL",X)) Q:'X!PSJDIFF  S PSJX=TMPDRG("SOL",X) D
 . I '+$G(PSJNPRMX),'$$PREMIX(+PSJX) Q
 . I TMPDRG("SOL",X)'=$G(DRG("SOL",X)) S PSJDIFF=1 Q
 Q PSJDIFF
DN(X) ;
 ;Return the drug name from file 50
 Q $P($G(^PSDRUG(+X,0)),U)
OI(X) ;
 ;Return the Orderable name from file 50.7
 NEW PSJX
 S PSJX=$P($G(^PS(50.7,+X,0)),U)
 Q $S(PSJX="":"Invalid Orderable Item",1:PSJX)
LINE(PSJLINE,PSJLEN) ;Display a line
 ;PSJLINE - type of line (ex: '-', '=")
 ;PSJLEN - the length of line
 S X="",$P(X,PSJLINE,PSJLEN)=""
 W X
 Q
DD53P45() ;Return the zero node of the first dispense drug found in 53.45
 ;Calling routine needs to clean up PSJALLGY array.
 NEW PSJDD,PSJDD1,PSJDD0,X,PSJX,PSGDT,%
 D NOW^%DTC S PSGDT=%
 S PSJDD="",PSJDD1=""
 I '+$G(PSJSYSP) Q ""
 F X=0:0 S X=$O(^PS(53.45,+PSJSYSP,2,X)) Q:'+X  D
 . S PSJDD0=$G(^PS(53.45,PSJSYSP,2,X,0))
 . S PSJX=$P(PSJDD0,U,3) I PSJX]"",(PSJX'>$G(PSGDT)) S PSJDD0="" Q
 . S PSJDD=+PSJDD0
 . S PSJX=$S('$D(^PSDRUG(+PSJDD,0)):1,$P($G(^(2)),U,3)'["U":1,$G(^("I"))="":0,1:^("I")'>$G(PSGDT))
 . I PSJX S PSJDD0="",PSJDD="" Q
 . S PSJALLGY(PSJDD)=""
 . S:PSJDD1="" PSJDD1=PSJDD0
 Q $G(PSJDD1)
RETQUIT() ;
 ;Return 1 If enter "^"
 NEW DIR,DIROUT,DTOUT,DUOUT,PSJQUIT
 S PSJQUIT=0
 S DIR(0)="FO^1:1",DIR("A")="Press RETURN to continue or '^' to exit"
 S DIR("?")="Enter '^' to quit or any keys to continue"
 D ^DIR
 I $S($D(DIROUT):1,$D(DUOUT):1,$D(DTOUT):1,1:0) S PSJQUIT=1
 Q PSJQUIT
PAUSE(PSJFIRST,PSJLAST) ;
 ;PSJFIRST - Print a blank line before the pause prompt
 ;PSJLAST - Print a blank line after the pause prompt
 K DIR W:+$G(PSJFIRST) ! S DIR(0)="EA",DIR("A")="Press Return to continue...",DIR("?")="Press Return to continue..." D ^DIR W:+$G(PSJLAST) !
 Q
PAUSE1() ;Allow "^"
 ;Return 0 if X=""
 ;Return 1 if X="^"
 ;Return 2 if Not null or "^"
 NEW DIR,DIRUT,DUOUT,X
 K DIR S DIR("A")="Press RETURN to continue or ""^"" to display the next Monograph or ""^^"" to Exit"
 S DIR("?")="Enter ""^"" to go to next Monograph, ""^^"" to exit the Monograph display."
 S DIR(0)="FOU^^K:(X'="""")!(X'[""^"") X"
 D ^DIR
 I X="" Q 0
 I X="^" Q 1
 Q 2
ONCALL(PSJSCH,PSJSTYPE) ;
 ; PSJSCH = Admin Schedule
 ; PSJSTYPE = schedule type (optional)
 ; Returns 0 = Not an "ON CALL" schedule.
 ;         1 = For schedule ="ON CALL" or schedule type = "OC".
 Q:$G(PSJSTYPE)="OC" 1
 Q:$G(PSJSCH)="" 0
 I PSJSCH="ON CALL"!(PSJSCH="ONCALL")!(PSJSCH="ON-CALL") Q 1
 Q 0
TMPDRG(DFN,ON,TMPDRG) ;Set TMPDRG array from the order in 55
 ;ON - IV order #
 NEW DRGT,FIL,Y,ND,DRG,DRGI
 Q:'+$G(ON)
 F DRGT="AD","SOL" S FIL=$S(DRGT="AD":52.6,1:52.7) F Y=0:0 S Y=$O(^PS(55,DFN,"IV",+ON,DRGT,Y)) Q:'Y  D
 .; naked ref below refers to line above
 .S DRG=$G(^(Y,0)),ND=$G(^PS(FIL,+DRG,0)),(DRGI,TMPDRG(DRGT,0))=$G(TMPDRG(DRGT,0))+1
 .S TMPDRG(DRGT,+DRGI)=+DRG_U_$P(ND,U)_U_$P(DRG,U,2)_U_$P(DRG,U,3)_U_$P(ND,U,13)_U_$P(ND,U,11)
 Q
TMPDRG1(DFN,ON,TMPDRG) ;Set TMPDRG array from the order in 53.1
 ;ON - IV order #
 NEW DRGT,FIL,Y,ND,DRG,DRGI
 Q:'+$G(ON)
 I $P(^PS(53.1,+ON,0),U,15)'=DFN Q
 F DRGT="AD","SOL" S FIL=$S(DRGT="AD":52.6,1:52.7) F Y=0:0 S Y=$O(^PS(53.1,+ON,DRGT,Y)) Q:'Y  D
 .; naked ref below refers to line above
 .S DRG=$G(^(Y,0)),ND=$G(^PS(FIL,+DRG,0)),(DRGI,TMPDRG(DRGT,0))=$G(TMPDRG(DRGT,0))+1
 .S TMPDRG(DRGT,+DRGI)=+DRG_U_$P(ND,U)_U_$P(DRG,U,2)_U_$P(DRG,U,3)_U_$P(ND,U,13)_U_$P(ND,U,11)
 Q
INFRATE(DFN,ON,PSJIR,PSJDTYP) ;Check if the infusion rate has changed
 ;ON - ON_P/V
 ;PSJIR - infusion rate
 ;PSJDTYP - IV type.  Only check infusion rate on continuous IV type
 NEW X,PSJONIR
 I '$D(PSJDTYP)!(+$G(PSJDTYP)=1) Q 0
 I '+$G(ON) Q 0
 I '+$G(PSJIR) Q 0
 I ON["V" S X=$G(^PS(55,DFN,"IV",+ON,0)) S PSJONIR=$P(X,U,8)
 I ON["P" S X=$G(^PS(53.1,+ON,8)) S PSJONIR=$P(X,U,5)
 I PSJONIR="" Q 0
 I PSJIR'=PSJONIR Q 1
 Q 0
