PSGOE2 ;BIR/MV-CHECK INACTIVE DRUG ; 23 Sep 98 / 8:38 AM
 ;;5.0; INPATIENT MEDICATIONS ;**7,19,62**;16 DEC 97
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180
 ; Reference to ^PSDRUG( is supported by DBIA# 2192
 ;
CHKDRG ;*** Check inactive Orderable Item/disp drug and also if marked for UD
 N DRG,DRGPT,INACTDT,X K PSGPFLG,PSGDFLG,PSGDI
 ;S:'$G(PSGDI) PSGDI=$G(PSGPD)
 S PSGDFLG='$$DDOK("^PS(55,"_PSGP_",5,"_+PSGORD_",1,",PSGPD)
 ;S X=$P($G(^PS(50.7,PSGDI,0)),"^",4) I X,(X'>DT) S (PSGR,PSGE)="",PSGPFLG=1 Q
 I '$$OIOK(PSGPD) S (PSGR,PSGE)="",PSGPFLG=1 Q
 Q
CHKDD(F) ;*** Check inactive dispense drug within the order.
 ;* 9/20/94
 ;* When check for a valid dispense drug, the following logic is used:
 ;* If ^PS(55 does not have a valid ddrug, PSGDFLG=1
 ;* If ddrug in ^PS(55, has an inactive date, don't check ^PSDRUG
 ;* If a ddrug in ^PS(55 pointed to an invalid ^PSDRUG note, PSGDFLG=1.
 ;*    The existing ddrugs in ^PS(55 will not copy to the new order.  
 ;*    Only store the new selected ddrug in the new order.
 ;* All active ddrugs in ^PS(55 has to be checked for valid ^PSDRUG
 ;* If ddrugs in ^PS(55 are all inactive, PSGINDT=0
 ;* If this routine returns 1, it means either no valid ddrug in the
 ;*    drug file or all the ddrug in ^PS(55 are inactive
 ;*
 N DRG,DRGPT,PSGDFLG,PSGINDT
 S PSGDFLG=0,PSGINDT=1 I '$O(@(F_"1,"_0_")")) Q 1
 F DRG=0:0 S DRG=$O(@(F_"1,"_DRG_")")) Q:'DRG  S DRGPT=^(DRG,0),INACTDT=+$P(DRGPT,U,3) I $S('INACTDT:1,1:INACTDT>DT) S PSGINDT=0 D  Q:PSGDFLG
 . I $P(^PSDRUG(+DRGPT,2),U,3)'["U"!($S('+$G(^PSDRUG(+DRGPT,"I")):0,^("I")'>DT:1,1:0)) S PSGDFLG=1
 Q $S(PSGDFLG:1,1:PSGINDT)
STUFFDD() ;*** Stuff DD in ^PS(53.1 only if a valid DD is 1 to 1 link to OI.
 ;*** Stuff DD in if only one valid DD is marked for UD.
 ;*** Do not stuff if there are multiple DD tie to a Orderable Item.
 ;*** Do not stuff if mult. DD marked as UD item & only 1 is a valid DD
 I '$D(PSGDT) D NOW^%DTC S PSGDT=$E(%,1,12)
 N Q,X,DRG,QPT S (X,Q,QPT)=0
 I '$O(^PS(53.1,+PSGORD,1,0)) F DRG=0:0 S DRG=$O(^PSDRUG("ASP",+$G(^PS(53.1,+PSGORD,.2)),DRG)) Q:'DRG  S:$G(^PSDRUG(DRG,"I")) X=^("I")'>PSGDT I $P(^PSDRUG(DRG,2),U,3)["U" S Q=Q+1 S:'X QPT=DRG
 Q $S(Q=1:QPT,1:0)
CHK ; check for valid reply and questions
 S C=1 I PSGOEA="P"!(PSGOEA="S") W $S(PSGOEA="P":"RINT",1:"HOW") Q
 I PSGOEA="C",PSJPCAF,'PSGOENG,'$D(PSGODF),'PSGDI,'PSGPI,'$G(PSGPFLG) W "OPY" Q
 I PSGOEA="DC",PSGACT["D" W " (DISCONTINUE)" S PSGOEA="D" Q
 I $L(PSGOEA)=1,PSGOEA'["?",PSGACT[PSGOEA W $S(PSGOEA="R"&PSGRRF:"EINSTATE",1:$P("^YPASS^ISCONTINUE^DIT^INISH^OLD^NCOMPLETE^OG DISPLAY^ENEW^ERIFY","^",$F("BDEFHILRV",PSGOEA))) Q
 S C=0 I PSGOEA'?1."?" W $C(7),"  ??" Q
 ;
DDOK(PSJF,OI) ;Check to be sure all dispense drugs that are active in the
 ;order are valid.
 ; Input: PSJF - File root of the order including all but the IEN of 
 ;               the drug. (EX "^PS(53.45,X,2,")
 ;        OI   - IEN of the order's orderable item
 ; Output: 1 - all active DD's in the order are valid
 ;         0 - no DD's active DD's or at least one active is invalid
 N DDCNT,ND,PSJ,X S (X,DDCNT)=0
 I $P(PSJSYSU,";")'=3,('$O(@(PSJF_"0)"))) Q 1
 F PSJ=0:0 S PSJ=$O(@(PSJF_PSJ_")")) Q:'PSJ!X  S ND=$G(@(PSJF_PSJ_",0)"))  D
 .I $P(ND,U,3),($P(ND,U,3)'>PSGDT) Q
 .S DDCNT=DDCNT+1
 .S X=$S('$D(^PSDRUG(+ND,0)):1,$P($G(^(2)),U,3)'["U":1,+$G(^(2))'=+OI:1,$G(^("I"))="":0,1:^("I")'>PSGDT)
 Q $S('DDCNT:0,X=1:0,1:1)
 ;
OIOK(X) ; Check to be sure orderable item is valid
 ; input:  X - IEN of orderable item
 ; Output: 0 - invalid
 ;         1 - valid
 Q:'$D(^PS(50.7,X,0)) 0
 S X=$P($G(^PS(50.7,X,0)),U,4)
 Q $S('X:1,X'>DT:0,1:1)
