SDCNP0 ;ALB/LDB,ANU - CANCEL APPT. FOR A PATIENT ;MAR 15, 2017
 ;;5.3;Scheduling;**132,167,478,517,572,592,627,658,801,803,804**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Reference/ICR
 ; ^VALM1 - 10116
 ;
EN2 D WAIT^DICD S NDT=HDT/1,L=0 F J=1:1 S NDT=$O(^DPT(DFN,"S",NDT)) Q:NDT'>0!(SDPV&(NDT'<SDTM))  S SD0=^(NDT,0) I $P(SD0,"^",2)'["C" S SC=+SD0,L=L\1+1,APL="" D FLEN^SDCNP1A S ^UTILITY($J,"SDCNP",L)=NDT_"^"_SC_"^"_COV_"^"_APL_"^^"_APL D CHKSO
WH1 G:L'>0 NO S (SDCTRL,SDCTR)=0,APP="" N SDITEM W:'SDERR @IOF
 W ! F Z=0:0 S Z=$O(^UTILITY($J,"SDCNP",Z)) Q:Z'>0  S SDITEM=$J($S(Z\1=Z:"("_$J(Z,2)_") ",1:""),5) D  Q:SDCTRL
 .I SDITEM["(" W !,SDITEM S HLDCSND=""
 .I SDITEM'["(" W SDITEM
 .S AT=$S($P(^(Z),"^",2)'?.N:1,1:0),Y=$P($P(^(Z),"^"),".") D DT^SDM0 S X=$P(^(Z),"^"),^(Z,"CNT")="" X ^DD("FUNC",2,1) W " ",$J(X,8) D MORE W:AT ! Q:SDCTRL
 S:SDERR SDCTRL=1 I Z>0 G:SDCTRL&(APP']"") NOPE^SDCNP1 G:SDCTRL DEL
 D WH G NOPE^SDCNP1:APP']"",DEL
WH W !!,"SELECT APPOINTMENTS TO BE CANCELLED" W:Z>0 " OR HIT RETURN TO CONTINUE DISPLAY" R ": ",APP:DTIME I '$T!(APP="^") S SDCTRL=1,APP="" Q
 S SDMSG="W !,""Enter appt. numbers separated by commas and/or a range separated"",!,""by dashes (ie 2,4,6-9)"" H 2" I APP["?" X SDMSG G WH
 S SDCTRL=$S(APP']"":0,1:1) Q
DEL S SDERR=0 F J=1:1 S SDDH=$P(APP,",",J) Q:SDDH']""  D MTCH^SDCNP1
 G:SDERR WH1
DEL1 F J=1:1 S SDDH=$P(APP,",",J) Q:SDDH']""  S SDDI=$P(SDDH,"-"),SDDM=$P(SDDH,"-",2) D CKK^SDCNP1A Q:SDERR  D CKK1^SDCNP1A Q:SDERR  Q:'SDDI  F A1=SDDI:1:$S(SDDM:SDDM,1:SDDI) D BEGD
 G:SDERR WH1 G NOPE^SDCNP1
BEGD S (SD,S)=$P(^UTILITY($J,"SDCNP",A1),"^",1),I=$P(^UTILITY($J,"SDCNP",A1),"^",2)
 S SL=^SC(I,"SL"),X=$P(SL,U,3),STARTDAY=$S($L(X):X,1:8),SB=STARTDAY-1/100,X=$P(SL,U,6),HSI=$S(X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2) K Y
 ; SD*5.3*803 - Check if Check In Date exists and not allow cancel
 I $P($G(^SC(+$P(^UTILITY($J,"SDCNP",A1),U,2),"S",+^UTILITY($J,"SDCNP",A1),1,+$$FIND^SDAM2(.DFN,+^UTILITY($J,"SDCNP",A1),+$P(^(A1),U,2)),"C")),U,1) W !,*7,">>> Appointment #",A1," has a check in date and cannot be cancelled." Q 
 I $$CODT^SDCOU(DFN,+^UTILITY($J,"SDCNP",A1),+$P(^(A1),U,2)) W !,*7,">>> Appointment #",A1," has a check out date and cannot be cancelled." Q
 D PROT^SDCNP1A Q:SDPRT=1  D CAN S $P(^UTILITY($J,"SDCNP",A1),"^",4)="*** JUST CANCELLED ***" Q
CAN Q:$P(^UTILITY($J,"SDCNP",A1),"^",4)["JUST CANCELLED"  S CNT=CNT+1,DIV=$S($P(^SC(I,0),"^",15)]"":" "_$P(^(0),"^",15),1:" 1") I $D(^DPT("ASDPSD","C",DIV,I,S,DFN)) K ^(DFN)
 N SDATA,SDCPHDL,SDNOW,SDCLI S SDCPHDL=$$HANDLE^SDAMEVT(1) D BEFORE^SDAMEVT(.SDATA,DFN,S,I,"",SDCPHDL)
 S SDCLI=I ;changed variable name I to SDCLI(Hospital location file IEN) as the value of I is manipulated by ^DIE SD*5.3*592
 S:'$D(^DPT(DFN,"S",0)) ^(0)="^2.98P^^" I $D(SDREM) S DIE="^DPT("_DFN_",""S"",",(DA,Y)=S,DA(1)=DFN,DR="17///^S X="_"""""_SDREM_""""" D ^DIE K DIE,DR
 S ^DPT("ASDCN",SDCLI,DA,DA(1))=$S(SDWH["P":1,1:"") K DA
 ;removed rounding logic for time and changed direct global writes to fileman call SD*5.3*592
 D NOW^%DTC S SDNOW=%,DIE="^DPT("_DFN_",""S"",",DA=S,DA(1)=DFN,DR="3///^S X=SDWH;14////^S X=DUZ;15///^S X=SDNOW;16////^S X=SDSCR" D ^DIE K DIE,DR,DA
 S (DA,Y)=0 F X=0:0 S X=+$O(^SC(SDCLI,"S",S,1,X)) Q:'$D(^(X,0))  D C Q:Y&(DA)
 N REOPEN S REOPEN="" D SDEC(DFN,S,SDCLI,SDWH,SDSCR,SDREM,SDNOW,DUZ,REOPEN) ; vse-1886 reopen appt request when cancelling with VistA SD CANCEL APPOINTMENT option
 I $D(^DPT("ASDPSD","B",DIV,S\1,DFN)) D CK1
 Q:'Y  S SL=$P(^SC(SDCLI,"S",S,1,Y,0),U,2) I DA,'$D(^("OB")) K ^SC(SDCLI,"S",S,1,DA,"OB")
 S SDDA=DA,SDTTM=S,SDRT="D",SDPL=Y,SDSC=SDCLI D RT^SDUTL D CANCEL^SDCNSLT S Y=SDPL,S=SDTTM,SDCLI=SDSC,DA=SDDA K SDDA ;SD/478
 S SDNODE=^SC(SDCLI,"S",S,1,Y,0),^SC("ARAD",SDCLI,S,DFN)="N",TLNK=$P($G(^SC(SDCLI,"S",S,1,Y,"CONS")),U) K ^SC(SDCLI,"S",S,1,Y) K:$O(^SC(SDCLI,"S",S,0))'>0 ^SC(SDCLI,"S",S,0) D CLRK^SDCNP1  ;SD/478
 K:TLNK'="" ^SC("AWAS1",TLNK),TLNK ;SD/478
 ;S SDNODE=^SC(I,"S",S,1,Y,0),^SC("ARAD",I,S,DFN)="N" S DA(2)=I,DA(1)=S,DA=Y,DIK="^SC("_DA(2)_",""S"","_DA(1)_",1," D ^DIK K:$O(^SC(I,"S",S,0))'>0 ^SC(I,"S",S,0) D CLRK^SDCNP1 ;SD/478
 D EVT
 Q:'$D(^SC(SDCLI,"ST",SD\1,1))
EN01 S S=^SC(SDCLI,"ST",SD\1,1),Y=SD#1-SB*100,ST=Y#1*SI\.6+(Y\1*SI),SS=SL*HSI/60
 I Y'<1 F I=ST+ST:SDDIF S Y=$E(STR,$F(STR,$E(S,I+1))) Q:Y=""  S S=$E(S,1,I)_Y_$E(S,I+2,999),SS=SS-1 Q:SS'>0
 S ^(1)=S Q  ;NAKED REFERENCE - ^SC(IFN,"ST",Date,1)
C I +^SC(SDCLI,"S",S,1,X,0)=DFN S Y=X Q  ;changed variable name I to SDCLI SD*5.3*592
 Q:'$D(^("OB"))!DA  S:^("OB")?1"O".E DA=X Q
NO W !,"NO ",$S('SDPV:"PENDING",1:"PREVIOUS")," APPOINTMENTS",*7,*7,*7
 D END^SDCNP G RD^SDCNP
 Q
CHKSO S COV=$S($P(^DPT(DFN,"S",NDT,0),"^",11)=1:" (COLLATERAL) ",1:"") F SDJ=3,4,5 I $P(^DPT(DFN,"S",NDT,0),"^",SDJ)]"" S L=L+.1,^UTILITY($J,"SDCNP",L)=$P(^(0),"^",SDJ)_"^"_$S(SDJ=3:"LAB",SDJ=4:"XRAY",1:"EKG")_"^0^0"
 Q
MORE S SDCTR=SDCTR+2 I AT W ?41,$P(^UTILITY($J,"SDCNP",Z),"^",2) G OVR
 W " ",$S($P(^UTILITY($J,"SDCNP",Z),"^",4)?.N:"("_$P(^(Z),"^",4)_" MIN) ",1:$P(^(Z),"^",4))," ",$S($D(^SC($P(^(Z),"^",2),0)):$P(^(0),"^",1),1:"DELETED CLINIC"),$P(^UTILITY($J,"SDCNP",Z),"^",3) ;SD/478
 N CSND,CSDT,CSSD,CONSULT,Y
 S CSND=^UTILITY($J,"SDCNP",Z),CSDT=$P(CSND,U),CSSD=$P(CSND,U,2),HLDCSND=CSND S CONSULT=$$CONSULT(CSSD,CSDT) I +$G(CONSULT) S Y=$P(^GMR(123,CONSULT,0),U) D DD^%DT W !?5,"CONSULT ",Y,"/ ",CONSULT
 D STATUS($X>55)
OVR ;Following code added SD/517
 I '$D(CSND) I $G(HLDCSND) I (($P(HLDCSND,U,4)="")!($P(HLDCSND,U,6)="")) D
 .W !!,"**********************************************************************"
 .W !,"* WARNING: There is a data inconsistency or data corruption problem  *"
 .W !,"* with the above appointment.  Corrective action needs to be taken.  *"
 .W !,"* Please cancel the appointment above.  If it is a valid appointment,*"
 .W !,"* it will have to be re-entered via Appointment Management.          *"
 .W !,"**********************************************************************"
 .S SDCTR=21
 .K HLDCSND
 ;
 I SDCTR>20,$O(^UTILITY($J,"SDCNP",Z)) S (SDCTRL,SDCTR)=0 W *7 D WH W:'SDCTRL @IOF
 Q
 ;
CONSULT(CSSD,CSDT) ;
 N CSI S CONSULT=""
 S CSI=0 F  S CSI=$O(^SC(CSSD,"S",CSDT,1,CSI)) Q:'+CSI  I $P($G(^SC(CSSD,"S",CSDT,1,CSI,0)),U)=DFN S CONSULT=$P($G(^SC(CSSD,"S",CSDT,1,CSI,"CONS")),U) Q  ;SD/478
 Q CONSULT
CK1 S SDX=0 F SD1=S\1:0 S SD1=$O(^DPT(DFN,"S",SD1)) Q:'SD1!((SD1\1)'=(S\1))  I $P(^(SD1,0),"^",2)'["C",$P(^(0),"^",2)'["N" S SDX=1 Q
 Q:SDX  F SD1=2,4 I $D(^SC("AAS",SD1,S\1,DFN)) S SDX=1 Q
 Q:SDX  IF $D(^SCE(+$$EXAE^SDOE(DFN,S\1,S\1),0)) S SDX=1
 Q:SDX  K ^DPT("ASDPSD","B",DIV,S\1,DFN) Q
 ;
SDEC(DFN,S,SDCLI,SDWH,SDSCR,SDREM,SDNOW,SDDUZ,SDF) ;update SDEC APPOINTMENT   /alb/sat  SD/627
 N SDECAPPT
 S SDECAPPT=$$APPTGET^SDECUTL(DFN,S,SDCLI)
 D:+SDECAPPT SDECCAN^SDEC08(SDECAPPT,SDWH,SDSCR,SDREM,SDNOW,$S($G(SDDUZ)'="":SDDUZ,1:DUZ),"0"_$G(SDF,0))  ;alb/jsm 658 add flag to indicate called from SDAM APPT CANCEL
 ; SD*5.3*804 - Move deletion of VVSID to after Appointment Cancellation
 N SDECIENS,SDECFDA,SDECMSG
 S SDECIENS=SDECAPPT_","
 S SDECFDA(409.84,SDECIENS,2)="@"
 K SDECMSG
 D FILE^DIE("","SDECFDA","SDECMSG")
 Q
 ;end addition/modification  /alb/sat  SD/627
 ;
STATUS(LF) ;
 W:LF !
 W ?55,"(",$E($$LOWER^VALM1($P($$STATUS^SDAM1(DFN,+^UTILITY($J,"SDCNP",Z),+$P(^(Z),U,2),$G(^DPT(DFN,"S",+^(Z),0))),";",3)),1,23),")"
 W:'LF !
 Q
 ;
EVT ; -- separate tag if need to NEW vars
 N I,STR,SS,SL,SD,SB,SI,HSI,J,APP,S,A1,STARTDAY,CNT,DIV,SDERR,SDDIF
 D CANCEL^SDAMEVT(.SDATA,DFN,SDTTM,SDSC,SDPL,0,SDCPHDL)
 Q
