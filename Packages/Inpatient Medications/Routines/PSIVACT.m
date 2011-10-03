PSIVACT ;BIR/PR,MLM-UPDATE ORDER STATUS AFTER PATIENT SELECTION ;16 Jul 98 / 12:51 PM
 ;;5.0; INPATIENT MEDICATIONS ;**15,38,58,110,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ;
ENNA ; Inpatient entry point.
 D:$D(XRTL) T0^%ZOSV
 D NOW^%DTC S PSFDT=%,PS=0 D L D:'$G(PSIVRD) PEND
 I $D(XRT0) S XRTN="PSIVACT" D T1^%ZOSV
 Q
 ;
ENNB ; Ask profile type, gather orders.
 D NOW^%DTC S PSFDT=%,PS=0 K ^TMP("PSIV",$J),^TMP("PSJPRO",$J)
 S PSIVNV=$S(+PSJSYSU=1:"ANIV",+PSJSYSU=3:"APIV",1:"")
 ;D @P("PT") D:PSIVNV]"" NVACT D:'$G(PSIVRD) PEND
 D @P("PT") D:'$G(PSIVRD) PEND
 I P("PT")="L",$D(XRT0) S XRTN="PSIVACT" D T1^%ZOSV
 Q
 ;
L ; Long profile
 S:'$D(PSJSYSU) PSJSYSU=""
 F ON=0:0 K Y S ON=$O(^PS(55,DFN,"IV",+ON)) Q:'ON  D SETP
 Q
 ;
S ; Short profile.
 S PSJDCEXP=$$RECDCEXP^PSJP()
 I '+$P(PSJDCEXP,U,2) S $P(PSJDCEXP,U,2)=PSFDT
 F PSIVDT=$P($G(PSJDCEXP),U,2):0 S PSIVDT=$O(^PS(55,DFN,"IV","AIS",PSIVDT)) Q:'PSIVDT  F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",PSIVDT,+ON)) Q:'ON  S ON=ON_"V",P(17)=$P($G(^PS(55,DFN,"IV",+ON,0)),U,17) D ACTO
 I +PSJSYSU=3 S PSIVNV="APIV" D NVACT K PSIVNV
 Q
 ;
NVACT ; Non-verified but have active status
 NEW ON
 F ON=0:0 S ON=$O(^PS(55,PSIVNV,DFN,ON)) Q:'ON  D
 . I $P($G(^PS(55,DFN,"IV",ON,0)),U,17)="E",($P($G(^(.2)),U,4)="D") S ^TMP("PSIV",$J,"A",9999999999-ON)=""
 Q
 ;
PEND ; Get pending and non-verified orders from 53.1
 N PSJCOM,PSJCOM1 S (PSJCOM,PSJCOM1)=0
 F ON=0:0 S ON=$O(^PS(53.1,"AS","P",DFN,ON)) Q:'ON  D  S PSJCOM1=PSJCOM
 . NEW X S X=$P($G(^PS(53.1,ON,.2)),U,4),X=$S(X="S":1,X="A":2,X="R":3,X="P":4,1:5)
 . S PSJCOM=$P($G(^PS(53.1,ON,.2)),U,8) I PSJCOM Q:'$$COMCHK^PSJO1(PSJCOM,2)  Q:PSJCOM=PSJCOM1
 . I $G(^PS(53.1,ON,0)),$P(^PS(53.1,ON,0),U,4)'="U" S ^TMP("PSIV",$J,$S('PSJCOM:"P",1:"PD"),X_9999999999-ON)=""
 F ON=0:0 S ON=$O(^PS(53.1,"AS","N",DFN,ON)) Q:'ON  D  S PSJCOM1=PSJCOM
 . NEW X S X=$P($G(^PS(53.1,ON,.2)),U,4),X=$S(X="S":1,X="A":2,X="R":3,X="P":4,1:5)
 . S PSJCOM=$P($G(^PS(53.1,ON,.2)),U,8) I PSJCOM Q:'$$COMCHK^PSJO1(PSJCOM,2)  Q:PSJCOM=PSJCOM1
 . I $G(^PS(53.1,ON,0)),$P(^PS(53.1,ON,0),U,4)'="U" S ^TMP("PSIV",$J,$S('PSJCOM:"N",1:"ND"),X_9999999999-ON)=""
 .; S:$P(^PS(53.1,ON,0),U,4)'="U" ^TMP("PSIV",$J,"P",X_9999999999-ON)=""
 ;
QUIT ; Kill and exit.
 K PSIVCWD,PSIVFLAG,PSIVWD,PSDFN,PSON1,PSFDT,YHOLD,JJ,XHOLD
 Q
 ;
SETP ; Get partial P array,
 S ON=ON_"V",Y=$G(^PS(55,DFN,"IV",+ON,0)) F X=2,3,17,21 S P(X)=$P(Y,U,X)
 S P(2)=+P(2),P(3)=+P(3) S Y(P(2))="",Y(P(3))=""
 I P(2),P(3),P(17)'="P" D CHK
 Q
 ;
CHK ; Check if order is active or expired and save accordingly.
 S PS=PS+1 I P(17)="H" S ^TMP("PSIV",$J,"A",9999999999-ON)="" Q
 I $O(Y(PSFDT))=P(3) D ACTO Q
 I $O(Y(PSFDT))="" D NACTO Q
 S:"ARO"[P(17) ^TMP("PSIV",$J,"A",9999999999-ON)="" S:"ED"[P(17) ^TMP("PSIV",$J,"X",9999999999-ON)="" S:"E"[P(17) PSIVREA="A",$P(^PS(55,DFN,"IV",+ON,0),U,17)="A",PS("A",9999999999-ON)=""
 Q
 ;
ACTO ; Active orders
 ;I "AE"[P(17) S ^TMP("PSIV",$J,"A",9999999999-ON)="" S:P(17)="E" $P(^PS(55,DFN,"IV",+ON,0),U,17)="A" Q ;;mv-not sure why setting status back to "A"???
 I "A"[P(17) S ^TMP("PSIV",$J,"A",9999999999-ON)="" Q
 I "HOR"[P(17) S ^TMP("PSIV",$J,"A",9999999999-ON)="" Q
 I "DE"[P(17) S ^TMP("PSIV",$J,"RD",9999999999-ON)=""
 Q
 ;
NACTO ; Inactive orders
 ;I "AER"[P(17) S ^TMP("PSIV",$J,"X",9999999999-ON)="" I "AR"[P(17) S $P(^PS(55,DFN,"IV",+ON,0),U,17)="E" D EXPIR^PSIVOE Q
 I "AER"[P(17) D
 . Q:$P(^PS(55,DFN,"IV",+ON,0),U,3)=""
 . I +PSJSYSU=3,($P($G(^PS(55,DFN,"IV",+ON,.2)),U,4)="D"),'+$P($G(^(4)),U,4) S ^TMP("PSIV",$J,"A",9999999999-ON)="" Q
 . S ^TMP("PSIV",$J,"X",9999999999-ON)=""
 I "AR"[P(17) S $P(^PS(55,DFN,"IV",+ON,0),U,17)="E" D EXPIR^PSIVOE
 I "OD"[P(17) S ^TMP("PSIV",$J,"X",9999999999-ON)=""
 Q
 ;
DCOR ; Auto-cancel IV orders
 ;NEED TO NEW VARIABLES LATER.
 NEW DA,DIR,DG,ON,ON55,P,PSIVAC,PSIVACT,PSIVLN,PSIVREA,PSIVRES,PSGALO,PSGP,PSJDCDT,PSJIVDCF,PSJIVON,PSJIVORF,PSJORF,VA,VADM,VAERR
 S PSGP=DFN,PSIVRES="Auto DC due to Surgery Package"
 D NOW^%DTC S PSJDCDT=+%
 D ENIV^PSJADT0
 Q
