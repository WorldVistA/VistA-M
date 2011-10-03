PSIVORC ;BIR/MLM-COMPLETE IV ORDERS ENTERED THROUGH OE/RR ;02 Mar 99 / 10:16 AM
 ;;5.0; INPATIENT MEDICATIONS ;**23,53,80,110,134**;16 DEC 97;Build 124
 ;
 ; Reference to ^DIC(42 is supported by DBIA 10039
 ; Reference to ^DPT is supported by DBIA 10035
 ; Reference to ^%DTC is supported by DBIA 10000
 ; Reference to ^DID is supported by DBIA 2052
 ;
EN ; Set IV parameters.
 D SITE^PSIVORE Q:'$G(PSIVQ)  K PSIVQ
 ;
SELECT ;
 F  S PSGSSH="ORVC" D ^PSGSEL Q:U[PSGSS  D GTORDRS
 D DONE^PSIVORC1
 Q
GTORDRS ;
 K ^TMP("PSIV",$J) N DIC,Y D @PSGSS Q:+$G(Y)'>0  W:PSGSS'="P" !,"...a few moments, please..." D @("G"_PSGSS)
 I $G(Y),'$D(^TMP("PSIV",$J)) W !,$C(7),"NO PENDING ORDERS FOR ",$S(PSGSS="P":"PATIENT",1:"WARD"),$S(PSGSS="G":" GROUP",1:"")," SELECTED." Q
 D NOW^%DTC S HDT=$$ENDTC^PSGMI(%),PSIVAC="C",DONE=0,WDN=""
 F  S WDN=$O(^TMP("PSIV",$J,WDN)) Q:WDN=""!DONE  S PNME="" F  S PNME=$O(^TMP("PSIV",$J,WDN,PNME)) Q:PNME=""!DONE  D
 . I PSGSS'="P" S PSGDFN=$P(PNME,";",2)_"^"_$P(PNME,";") D CHK^PSJDPT(.PSGDFN,1,1) I PSGDFN=-1 Q
 . D PROFILE D:PSIVHD ASK
 D:$G(PSIVHD) ASK
 Q
 ;
PROFILE ; Display profile of all incomplete orders.
 ;
 K PSGODDD S (DFN,PSGP)=$P(PNME,";",2) D ENBOTH^PSJAC
 S RB=PSJPRB,PG=1,PSJORL=$$ENORL^PSJUTL($G(VAIN(4))),PSJIVOF=PSJORL,PSGLMT=0,LN2="" D ENHEAD^PSJO3
 S (DONE1,TYP)="" F  S TYP=$O(^TMP("PSIV",$J,WDN,PNME,TYP)) Q:TYP=""!(DONE1)  D:$Y+5'>IOSL GTYP F ON1=0:0 S ON1=$O(^TMP("PSIV",$J,WDN,PNME,TYP,ON1)) Q:'ON1!(DONE1)  D DISPLAY
 Q
 ;
DISPLAY ; Display order on profile.
 I $Y+5>IOSL D ASK Q:DONE1  D ENHEAD^PSJO3,GTYP
 S PSIVHD=1,PSGLMT=PSGLMT+1,PSIVCV(PSGLMT)=ON1,PSJC="" W !?3,PSGLMT D PIV^PSIVUTL(+ON1_"P")
 Q
 ;
GTYP ; Get formatted heading for type
 N PSJD5314 D FIELD^DID(53.1,4,"","POINTER","PSJD5314")
 ; removed ^DD ref 3-2-99, pass ^^_set of codes value
 ; because codes^psivutl uses the 3rd piece
 S X=$$CODES^PSIVUTL(TYP,"^^"_PSJD5314("POINTER"),"")
 S PSIV=$S(X]"":X,1:"UNKNOWN"),X="",$P(X,"-",40-($L(PSIV)/2))="" W !,X_PSIV_X
 Q
 ;
ASK ; Ask which orders to view.
 S PSIVHD=0,ACTION="ORDER" D RD1^PSGON I X="^" S (DONE,DONE1)=1 Q
 Q:'$D(PSGODDD)  S DONE1=0 F PN=1:1:$L(PSGODDD(1),",")-1 S ON=+$P(PSGODDD(1),",",PN) Q:ON=""!DONE1  S ON=+$P(PSGODDD(1),",",PN) D SHOW
 S DONE1=1,PSGOP=DFN D:$P(PSJSYSL,U,2)]"" ENQL^PSGLW
 Q
 ;
SHOW ; Display selected order and prompt for action
 S (P("PON"),ON)=PSIVCV(ON)
 ;
SHOW1 ; Entry point from backdoor.
 S PSIVUP=+$$GTPCI^PSIVUTL D GT531^PSIVORFA(DFN,ON) I $G(PSIVAC)="PRO" D ENNONUM^PSIVORV2(DFN,ON) Q
 I $G(PSJORD)["P" D REQDT^PSJLIVMD(PSJORD)
 S PSJORD=+ON D ^PSJLIFN
 Q
 ;
 ; look-ups on ward group, ward, or patient; depending on value of SS
G S DIC="^PS(57.5,",DIC(0)="QEAMI",DIC("A")="Select WARD GROUP: " W ! D ^DIC S:+Y>0 WG=+Y Q
W S DIC="^DIC(42,",DIC(0)="QEAMI",DIC("A")="Select WARD: " W ! D ^DIC S:+Y>0 WD=+Y Q
P D ENGETP^PSIV Q:DFN<0  S Y=1 I $D(^PS(53.1,"AS","P",+DFN)) S PNME=$G(^DPT(+DFN,0)),PNME=$P(PNME,U)_";"_DFN,WDN=$S(VAIN(4)]"":$P(VAIN(4),U,2),1:"OUTPATIENT") D GP
 Q
 ;
GG ; put patient(s) with incomplete orders into array
 F WD=0:0 S WD=$O(^PS(57.5,"AC",WG,WD)) Q:'WD  D GW
 Q
GW S WDN=$G(^DIC(42,WD,0)),WDN=$P(WDN,U) I WDN]"" F DFN=0:0 S DFN=$O(^DPT("CN",WDN,DFN)) Q:'DFN  I $D(^PS(53.1,"AS","P",DFN)) S Y=$G(^DPT(+DFN,0)),PNME=$P(Y,U)_";"_DFN D:PNME]"" GP
 Q
GP ;
 F ON=0:0 S ON=$O(^PS(53.1,"AS","P",DFN,ON)) Q:'ON  S Y=$G(^PS(53.1,ON,0)),TYP=$S($P(Y,U,4)]"":$P(Y,U,4),1:"Z"),^TMP("PSIV",$J,WDN,PNME,TYP,ON)=""
 Q
DISCONT ; Cancel incomplete order
 N PSJDCTYP I $G(ON)["P",$P($G(^PS(53.1,+$G(ON),0)),"^",24)="R" S PSJDCTYP=$$PNDRNA^PSGOEC(ON) I $G(PSJDCTYP)'=1 D PNDRN(PSJDCTYP) Q
D2 ; Called from PNDRN for pending order
 D:'$D(PSJIVORF) ORPARM^PSIVOREN I PSJIVORF D NATURE^PSIVOREN I '$D(P("NAT")) W !,$C(7),"Order Unchanged." Q
 ;Prompt for requesting provider
 W ! I '$$REQPROV^PSGOEC W !,$C(7),"Order Unchanged." K PSJDCTYP Q
 W !
 ;
D3 ; called from PNDRN for original order
 I 'PSJCOM N PSJORNAT S PSJORIFN=$P($G(^PS(53.1,+ON,0)),U,21),PSJORD=ON,PSJORNAT=P("NAT") D DC^PSIVORA ;* I PSJIVORF,PSJORIFN,(ON["V") D EN1^PSJHL2(PSGP,"OD",+ON_"V","ORDER DISCONTINUED")
 I PSJCOM,PSJORD["P" N O S O="" F  S O=$O(^PS(53.1,"ACX",PSJCOM,O)) Q:O=""  D
 .S ON=O_"P",PSJORIFN=$P($G(^PS(53.1,+ON,0)),U,21),PSJORD=ON,PSJORNAT=P("NAT") D DC^PSIVORA
 W !,"Order discontinued.",!
 Q
 ;
EDIT ; Edit incomplete order
 S PSIVAC="CE" L +^PS(53.1,+ON):1 E  W !,$C(7),"This order LOCKED by another user." Q
 D EDIT^PSIVORC2 L -^PS(53.1,+ON)
 Q
 ;
FINISH ; Finish incomplete order
 S PSIVAC="CF" L +^PS(53.1,+ON):1 E  W !,$C(7),"This order LOCKED by another user." Q
 D FINISH^PSIVORC2 L -^PS(53.1,+ON)
 Q
 ;
PNDRN(PSJDCTYP) ; Discontinue pending renewal only or both pending and original orders
 I PSJDCTYP=2 S PSJDCTYP=1 D D2 Q:'$G(PSJDCTYP)  D
 .N ND5310 S ND5310=$G(^PS(53.1,+ON,0))
 .N ON S ON=$P(ND5310,"^",25) I ON S PSJDCTYP=2 D D3
 Q
