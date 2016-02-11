DGMTOFA ;ALB/CAW/AEG/PWC/DHS - Future Appointments who will require MT ; 4/21/11 10:57am
 ;;5.3;Registration;**3,50,182,326,426,568,725,830,891**;Aug 13, 1993;Build 14
 ;
EN ; 
 I '$$RANGE^DGMTUTL("F") G ENQ
 I '$$DIV^DGMTUTL G ENQ
 I '$$CLINIC^DGMTUTL G ENQ
 ;I '$$LETTER G ENQ
 W !! S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D MAIN G ENQ
 S Y=$$QUE
ENQ ;
 D:'$D(ZTQUEUED) ^%ZISC
 K DFN,DGAPT,DGBEG,DGCLN,DGDATE,DGDFN,DGDIV,DGEND,DGFLG,DGINFO,DGLINE,DGLST,DGMT,DGMT1,DGPAGE,DGSTOP,DGTMP,DGTMP1,DGTMP2,DGMTYPT,DGYN,DIW,DIWF,DIWR,DIWT,DN,SDFORM,SDLET,VA,VAERR,VAUTC,VAUTD,^TMP("DGMTO",$J),^TMP("DGMTL",$J)
 K DGARRAY,CLNARRAY,^TMP($J,"SDAMA"),I,DGTMP,SDCNT
 Q
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Future Appt. w/ Means Test",ZTRTN="MAIN^DGMTOFA"
 F X="DGBEG","DGEND","DGYN","DGMTYPT","SDFORM","SDLET","VAUTC","VAUTD","VAUTC(","VAUTD(" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
 ;
MAIN ; 
 K ^TMP("DGMTO",$J) S I=1
 I VAUTC=1,VAUTD=1 S DGCLN=0 F  S DGCLN=$O(^SC(DGCLN)) Q:'DGCLN  I $P(^(DGCLN,0),U,3)="C" D CBLD3(DGCLN)
 ;
 I VAUTC=1,VAUTD=0 S DGDIV="" F  S DGDIV=$O(VAUTD(DGDIV)) Q:'DGDIV  S DGCLN=0 F  S DGCLN=$O(^SC(DGCLN)) Q:'DGCLN  I $P(^SC(DGCLN,0),U,3)="C",$P(^SC(DGCLN,0),U,15)=DGDIV D CBLD3(DGCLN)
 I VAUTC=0 S DGCLN="" F  S DGCLN=$O(VAUTC(DGCLN)) Q:'DGCLN  D CBLD3(DGCLN)
 D SDAM,CLN1
 D ^DGMTOFA1
 D CLOSE^DGMTUTL
 Q
 ;
CBLD3(DGCLN) ; Build array of specified Clinics for specified Divisions
 S CLNARRAY(I)=$G(CLNARRAY(I))_DGCLN_";"
 I $L(CLNARRAY(I))>120 S I=I+1
 Q
 ;
SDAM ; Build TMP Global with Appointment API Data for Report
 S DGARRAY(1)=DGBEG_";"_DGEND
 S DGARRAY("FLDS")="1;3;10"
 F I=1:1 Q:'$D(CLNARRAY(I))  D
 .S DGARRAY(2)=CLNARRAY(I)
 .I $$SDAPI^SDAMA301(.DGARRAY)>0 M ^TMP($J,"SDAMA")=^TMP($J,"SDAMA301")
 .K ^TMP($J,"SDAMA301")
 Q
 ;
CLN1 ; Loop through appointments
 ;
 N DGTMP S DGDATE=DGBEG-.1,DGLST=DGEND+.9
 S DGCLN=0 F  S DGCLN=$O(^TMP($J,"SDAMA",DGCLN)) Q:'DGCLN  D
 .S DGDFN=0 F  S DGDFN=$O(^TMP($J,"SDAMA",DGCLN,DGDFN)) Q:'DGDFN  D
 ..S DGDATE=0 F  S DGDATE=$O(^TMP($J,"SDAMA",DGCLN,DGDFN,DGDATE)) Q:'DGDATE  D
 ...S DGTMP=^TMP($J,"SDAMA",DGCLN,DGDFN,DGDATE)
 ...Q:$$DOM(DGDFN,DGDATE)
 ...Q:"^NS^NSR^CC^CCR^CP^CPR^"[(U_$P($P(DGTMP,U,3),";")_U)
 ...D MT
 Q
MT ; Is patient going to need to complete a MT/Copay by appt?
  S DGMT=$$LST^DGMTU(DGDFN,$P(DGDATE,"."),DGMTYPT),DGMT1=$P($G(^DGMT(408.31,+DGMT,0)),U,3) I DGMT1,"^3^10^"'[("^"_DGMT1_"^") D
 . N MTQ,X S MTQ=0  ; only do the following for RX Co-pay tests
 .I DGMTYPT=2 D  Q:MTQ=1
 .. ;Exclude from report the following:
 .. ;Existing RX Copay Test with Source of Test = IVM AND
 .. ;Primary eligibility code = NSC OR Primary eligibility code =
 .. ; SC Less than 50% and percentage is 0 and Total VA check amt = 0
 .. ;  DG*5.3*830
 .. I $P($G(^DGMT(408.31,+DGMT,0)),U,23)'=2 Q  ; quit if not IVM
 .. S X=$P($G(^DPT(DGDFN,.36)),"^",1)
 .. I $P($G(^DIC(8,+X,0)),"^",9)=5!($$SC(DGDFN)) S MTQ=1
 .S X1=$P(DGMT,U,2),X2=365 D C^%DTC I $P(DGDATE,".")<X,$S(DGMT1=1:0,DGMT1=9:0,1:1) Q
 .;Check to see if Cat C/Pend Adj agreed to pay with test date >10/5/99
 .I $P(DGMT,U,2)>2991005,$P($G(^DGMT(408.31,+DGMT,0)),U,11)=1,((DGMT1=6)!(DGMT1=2)) Q
 .;Check to see if Cat C, declined to provide income info but agreed to
 .;pay -- no date restrictions on these types.
 .I $G(DGMT1)=6,+$P($G(^DGMT(408.31,+DGMT,0)),U,14),+$P($G(^DGMT(408.31,+DGMT,0)),U,11) Q
 .; checking for future means test based on DT
 .;
 .; DG*5.3*891 - test whether patient is current
 .I $P(DGMT,U,2)>3120101&($P(DGMT,U,2)<3130101) Q  ; test effective date range   1 or 9 value
 .I $P(DGMT,U,2)>3121231,"^4^11^16^"[("^"_DGMT1_"^") Q  ; MT status = Copay exempt,GMT Copay requred,Pending Adjudication
 .I DGMT1=6!(DGMT1=3) Q  ;MT Copay required and and No longer required
 .;
 .N DGNXTMT
 .S DGNXTMT=$O(^IVM(301.5,"AE",DGDFN,DT))
 .I 'DGNXTMT S DGNXTMT=""
 .S ^TMP("DGMTO",$J,$S(+$P(^SC(DGCLN,0),U,15):$P(^(0),U,15),1:$O(^DG(40.8,0))),$P(^SC(DGCLN,0),U),$P(^DPT(DGDFN,0),U),DGDATE)=DGDFN_U_$P(DGMT,U,1,4)_U_$P($P(DGTMP,U,10),";")_U_DGNXTMT,^TMP("DGMTL",$J,$P(^DPT(DGDFN,0),U),DGDFN)=""
 Q
 ;
SC(DFN) ; Check if patient is SC 0% non-compensable
 ; Input -- DFN       Patient IEN
 ; Output -- 1=Yes and 0=No
 N Y
 S Y=0
 ; Primary eligibility is SC LESS THAN 50%
 I $D(^DPT(DFN,.36)),$P($G(^DIC(8,+^(.36),0)),"^",9)=3 S Y=1
 G:'Y SCQ
 ; Service connected percentage is zero
 I $P($G(^DPT(DFN,.3)),"^",2)'=0 S Y=0 G SCQ
 ; No Total annual VA check amount
 I $P($G(^DPT(DFN,.362)),"^",20) S Y=0
SCQ Q +$G(Y)
 ;
LETTER() ;
 ;   Input - none
 ;  Output - DGYN - yes/no
 ;
 N %
LTR W !!,"Do you want to generate letters" S %=2 D YN^DICN
 ;I %=1 D START^DGMTLTR S DGYN=$S('$D(DGFLG):1,1:0)
 I %=2 S DGYN=0
 I %=0 W !!,"Enter 'Y'es to generate letters from the listing or",!,"Enter 'N'o to produce the listing, but not the letters." G LTR
 Q $D(DGYN)
 ;
DOM(DFN,DGT) ; Screen out dom patient
 ;         Input:   DFN - Patient IEN
 ;                  DGT - Date of visit
 ;
 N Y,DGI,DGXFR0,DGA1,DGINP
 S Y=0
 D ^DGINPW I DG1 I $P(^DG(43,1,0),U,21),$D(^DIC(42,+DG1,0)),$P(^(0),U,3)="D" S Y=1
 Q Y
