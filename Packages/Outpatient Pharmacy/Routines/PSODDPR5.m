PSODDPR5 ;BIR/SAB - displays OP/rdi/pending/nva orders ;09/320/06 11:33am
 ;;7.0;OUTPATIENT PHARMACY;**251,375,379,390,372,416,438**;DEC 1997;Build 4
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(55 supported by DBIA 2228 
 ;
EXC ;displays order check exceptions
 N Q,CT,ONT,OT,ON,TD,ERRTY,OP,OPP,ZEXC,ZREA,X,DIWL,DIWR,DIWF,PSOWROTE
 I ($Y+5)'>IOSL D HD^PSODDPR2() Q:$G(PSODLQT)  ;W @IOF
 S (CT,Q)=0,ONT=""
 F  S ONT=$O(^TMP($J,LIST,"OUT","EXCEPTIONS",ONT)) Q:ONT=""  F  S CT=$O(^TMP($J,LIST,"OUT","EXCEPTIONS",ONT,CT)) Q:'CT  D
 .S ZEXC=^TMP($J,LIST,"OUT","EXCEPTIONS",ONT,CT),ZREA=$P(^TMP($J,LIST,"OUT","EXCEPTIONS",ONT,CT),"^",10)
 .S OT=$P(ONT,";"),ON=$P(ONT,";",2),OP=$P(ONT,";",3),OPP=OT_";"_ON_";"_OP
 .I '$D(PSODGCK),'$D(PSSDGCK),OT="Z",ZREA="Drug not matched to NDF"!($P(^TMP($J,LIST,"OUT","EXCEPTIONS",ONT,CT),"^",7)["manual check") S PSODRUG("BAD",PSODRUG("IEN"))=1
 .Q:$G(^TMP($J,"PSEXC","OUT",OPP))
 .S Q=Q+1,ERRTY=$S(OT="R":"RDI",OT="N":"Non-VA",OT="P":"Pending",OT="O":"Rx",1:"")
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 .W ! S X=$P(^TMP($J,LIST,"OUT","EXCEPTIONS",ONT,CT),"^",7) D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0) S PSOWROTE=1
 .I $D(PSODGCK)!$D(PSSDGCK) K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." W ! D ^DIR K DIR W @IOF
 .S:OT'="Z" ^TMP($J,"PSEXC","OUT",OPP)=1,PSOWROTE=1
 .Q:ZREA=""
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 .S X="   Reason(s): "_ZREA D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0) S PSOWROTE=1
 .K ^UTILITY($J,"W"),X,DIWL,DIWR,DIWF
 .D:$O(^TMP($J,LIST,"OUT","EXCEPTIONS",ONT,CT)) HD^PSODDPR2() Q:$G(PSODLQT)
 W !! I $G(PSOWROTE) K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR S:($D(DTOUT))!($D(DUOUT)) PSODLQT=1,PSORX("DFLG")=1 W ! K DIR,X,Y I ($Y+5)>IOSL W @IOF
 Q
NOCAN ;shows duplicate therapeutic when cancel duplicate class parameter is et to 'no'
 K ^UTILITY($J,"W"),DDTH,DOCPL S DIWL=1,DIWR=78,DIWF="",(CT,SUB)=0 K TCT,TCTP,TCTL,TCTI,ZZQ,ZHDR
 F  S CT=$O(^TMP($J,LIST,"OUT","THERAPY",CT)) Q:'CT  F  S SUB=$O(^TMP($J,LIST,"OUT","THERAPY",CT,"DRUGS",SUB)) Q:'SUB  D
 .S ON=$P(^TMP($J,LIST,"OUT","THERAPY",CT,"DRUGS",SUB),"^"),PDRG=$P(^(SUB),"^",3),RXREC=$P(ON,";",2)
 .I $G(PSODCTH(ON)) Q
 .I $P(ON,";")="Z" Q
 .I $P(ON,";")="N",$G(^TMP($J,"PSONVADD",RXREC,0)) Q
 .I $P(ON,";")="R",$G(^TMP($J,"PSORMDD",RXREC,0)) Q
 .I $P(ON,";")="O",$G(^TMP("PSORXDC",$J,RXREC,0)) Q
 .I $P(ON,";")="P",$G(^TMP("PSORXDC",$J,RXREC,0)) Q
 .I $P(ON,";")="O",$G(^TMP("PSORXDD",$J,RXREC,0)) Q
 .I '$G(ZHDR) D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)  W !,PSONULN,!,"*** THERAPEUTIC DUPLICATION(S) *** "_PSODRUG("NAME")_" with",! S ZHDR=1
 Q:'$G(ZHDR)  Q:$G(PSODLQT)
 N ST,STA,STAT,ORT K DOCPL
 S (SUB,CT)=0 F  S CT=$O(^TMP($J,LIST,"OUT","THERAPY",CT)) Q:'CT  F  S SUB=$O(^TMP($J,LIST,"OUT","THERAPY",CT,"DRUGS",SUB)) Q:'SUB  D DUPCL K DDTH
 D DUPCP
 Q
DUPCL ;
 S ON=$P(^TMP($J,LIST,"OUT","THERAPY",CT,"DRUGS",SUB),"^"),PDRG=$P(^(SUB),"^",3),RXREC=$P(ON,";",2)
 I $P(ON,";")="Z" Q
 I $P(ON,";")="N",$G(^TMP($J,"PSONVADD",RXREC,0)) Q
 I $P(ON,";")="R",$G(^TMP($J,"PSORMDD",RXREC,0)) Q
 I $P(ON,";")="O",$G(^TMP("PSORXDC",$J,RXREC,0)) Q
 I $P(ON,";")="P",$G(^TMP("PSORXDC",$J,RXREC,0)) Q
 I $P(ON,";")="O",$G(^TMP("PSORXDD",$J,RXREC,0)) Q
 S ORT=$S($P(ON,";")="N":4,$P(ON,";")="P":3,$P(ON,";")="R":2,1:1)
 S DOCPL(ORT,ON)=""
 Q
DUPCP D HD^PSODDPR2():(($Y+5)'>IOSL) S ORT=0,ON=""  F  S ORT=$O(DOCPL(ORT)) Q:'ORT!$G(PSODLQT)  F  S ON=$O(DOCPL(ORT,ON)) Q:ON=""!$G(PSODLQT)  D
 .I $P(ON,";")="O" D
 ..D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)  S ST=$P(^PSRX($P(ON,";",2),"STA"),"^")+1
 ..S STA="ACTIVE^NON-VERIFIED^REFILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^^EXPIRED^DISCONTINUED^^DISCONTINUED BY PROVIDER^DISCONTINUE EDIT^PROVIDER HOLD"
 ..S STAT=$P(STA,"^",ST) W !?2,"Local Rx #"_$P(^PSRX($P(ON,";",2),0),"^")_" ("_STAT_") for "_$P(^PSDRUG($P(^PSRX($P(ON,";",2),0),"^",6),0),"^")
 .I $P(ON,";")="P" D
 ..D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 ..S RXREC=$P(ON,";",2),DNM=$P(^PS(52.41,RXREC,0),"^",9)
 ..S DUPRX0=^PS(52.41,RXREC,0)
 ..W !?2,"Pending Order for "
 ..I '$P(DUPRX0,"^",9) W $P(^PS(50.7,$P(DUPRX0,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 ..E  W $P(^PSDRUG($P(DUPRX0,"^",9),0),"^")
 .I $P(ON,";")="R" N RXDAT D
 ..D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 ..S RXDAT=^TMP($J,LIST,"OUT","REMOTE",$P(ON,";",2))
 ..S RDIRX=$P(RXDAT,"^",5) D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)  W !?2,"Remote Rx #"_RDIRX_" ("_$P(RXDAT,"^",4)_") for "_$P(RXDAT,"^",3)
 .I $P(ON,";")="N" D
 ..Q:'$D(^PS(55,PSODFN,"NVA",$P(ON,";",2),0))
 ..S DUPRX0=^PS(55,PSODFN,"NVA",$P(ON,";",2),0) N NVAQ
 ..D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 ..W !?2,"Non-VA Med for "
 ..I '$P(DUPRX0,"^",2) W $P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 ..E  W $P(^PSDRUG($P(DUPRX0,"^",2),0),"^")
 .S DDTH(ON)=1
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 D CLASSES^PSODDPR3
 D HD^PSODDPR2(0,1) Q:$G(PSODLQT)
 Q
REMOTE ;backdoor RDI
 Q:$G(PSODLQT)
 S PSORDI=0 F  S PSORDI=$O(^TMP($J,LIST,"OUT","REMOTE",PSORDI)) Q:'PSORDI!$G(PSODLQT)  S RDITMP=^(PSORDI) D  K PSOSEQN
 .I $P(RDITMP,"^",2)="" Q
 .S RDIVUID=$P(RDITMP,"^",2),RDIDNAM=$P(RDITMP,"^",3)
 .I $O(PDRG(0)) F ZI=0:0 S ZI=$O(PDRG(ZI)) Q:'ZI  I $P(^PSDRUG($P(PDRG(ZI),"^"),0),"^")=RDIDNAM S INDD=+$G(INDD)+1,^TMP($J,"DD",INDD,0)=$P(PDRG(ZI),"^")_"^"_RDIDNAM_"^^"_PSORDI_"Z;O"
 .S DO=$G(DO)+1 D GETIREF^XTID(50.68,.01,RDIVUID,"PSOSEQN",1) I 'PSOSEQN S ^TMP($J,LIST,"IN","PROFILE","R;"_PSORDI_";PROFILE;"_DO)=0_"^"_RDIVUID_"^0^"_RDIDNAM_"^^" Q
 .S SEQN="" S SEQN=$O(PSOSEQN(50.68,.01,SEQN)) Q:SEQN=""
 .S P3=+SEQN,SEQN=$P($$PROD0^PSNAPIS(,P3),"^",7)
 .S ^TMP($J,LIST,"IN","PROFILE","R;"_PSORDI_";PROFILE;"_DO)=SEQN_"^"_RDIVUID_"^0^"_RDIDNAM_"^^"
 Q
NSRT ;sort of drug interactions ; called by psoddpr2
 ;Q:$G(PSODLQT)
 N SV,SEV,STOP,TYP,CNT,CHK,DRG,ON,CT,ZOT,PSOVAG,PSODD,COUNT,NSRT,NSRT2 S COUNT=0,(SV,DRG,ON,CT,PSOVAG)=""
 F  S SV=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV)) Q:SV=""!$G(PSODLQT)  D  Q:$G(PSORX("DFLG"))
 .F  S DRG=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG)) Q:DRG=""!$G(PSODLQT)  F  S ON=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON)) Q:ON=""!$G(PSODLQT)  F  S CT=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT)) Q:'CT!$G(PSODLQT)  D
 ..I $P(ON,";")'="Z",$P(ON,";")="O",$P(^PSRX($P(ON,";",2),"STA"),"^")>5,$P(^PSRX($P(ON,";",2),"STA"),"^")'=16 Q
 ..I $P(ON,";")'="Z",$P(ON,";")="R" D RVAGEN Q
 ..I $P(ON,";")'="Z",$P(ON,";")="P",'$P($G(^PS(52.41,$P(ON,";",2),0)),"^",9) S PSORDIT=$P($G(^PS(52.41,$P(ON,";",2),0)),"^",8) D:$G(PSORDIT) DVAGEN Q
 ..I $P(ON,";")'="Z",$P(ON,";")="N",'$P($G(^PS(55,PSODFN,"NVA",$P(ON,";",2),0)),"^",2) S PSORDIT=$P($G(^PS(55,PSODFN,"NVA",$P(ON,";",2),0)),"^") D:$G(PSORDIT) DVAGEN ;Q  ;*438
 ..S PSODD=$O(^PSDRUG("B",DRG,0)) D:PSODD'="" VAGEN^PSODDPR3(PSODD)
 ..S:PSOVAG="" PSOVAG=DRG
 ..S ZOT=$S($P(ON,";")["C":1,$P(ON,";")="O":2,$P(ON,";")="R":3,$P(ON,";")="P":4,1:5)
 ..S ZDGDG(SV,ZOT,PSOVAG,DRG)=ON_"^"_CT
 ..I ZOT=1 S PSOCLNS(SV,PSOVAG,DRG,ON)=CT
 ..I '$D(NSRT(SV,PSOVAG)) S NSRT(SV,PSOVAG)=ZOT
 ..E  S $P(NSRT(SV,PSOVAG),"^",1)=$P(NSRT(SV,PSOVAG),"^",1)_","_ZOT
 ;resort of zdgdg
 K ZZDGDG S (SEV,STOP,PSOVAG,TYP,ON)="",CNT=0
 F J=1:1:5 F  S SEV=$O(NSRT(SEV)) Q:SEV=""  F I=1:1:5 F  S PSOVAG=$O(NSRT(SEV,PSOVAG)) Q:PSOVAG=""  D
 .S TYP="",TYP=","_$P(NSRT(SEV,PSOVAG),"^",1)_","
 .Q:TYP'[(","_J_",")
 .S STOP=0 F CHK=1:1:5 I TYP[(","_CHK_",")&(CHK<J) S STOP=1
 .Q:STOP
 .S CNT=CNT+1 F I=J:1:5 S TYP=I I $D(ZDGDG(SEV,TYP)) D S2(SEV,TYP,PSOVAG,CNT)
 K NSRT,J,F,ZDGDG,COUNT,CNT
 Q
 ;print order sort
S2(SEV,TYP,PSOVAG,CNT) ;
 N PSONAM,COUNT2 S (PSONAM)="",COUNT2=0
 F  S PSONAM=$O(ZDGDG(SEV,TYP,PSOVAG,PSONAM)) Q:PSONAM=""  S COUNT2=COUNT2+1 D
 .S:$G(ZZDGDG2(SEV,PSOVAG)) ZZDGDG2(SEV,PSOVAG)=ZZDGDG2(SEV,PSOVAG)+1 S:'$G(ZZDGDG2(SEV,PSOVAG)) ZZDGDG2(SEV,PSOVAG)=1
 .S ZZDGDG(SEV,CNT,TYP,PSOVAG,PSONAM)=ZDGDG(SEV,TYP,PSOVAG,PSONAM)
 .S ZZDGCK(SEV,CNT,TYP,PSOVAG,PSONAM)=ZDGDG(SEV,TYP,PSOVAG,PSONAM)
 Q
 ;
NSRT1 ;sort out dc'd drug therapies local and remote rxs
 S (SUB,CT)=0 K PSODCTH N RXN
 F  S CT=$O(^TMP($J,LIST,"OUT","THERAPY",CT)) Q:'CT  F  S SUB=$O(^TMP($J,LIST,"OUT","THERAPY",CT,"DRUGS",SUB)) Q:'SUB  D
 .S ON=$P(^TMP($J,LIST,"OUT","THERAPY",CT,"DRUGS",SUB),"^")
 .I $P(ON,";")="O",$P($G(^PSRX($P(ON,";",2),3)),"^",5) D  Q
 ..S RXN=$P(ON,";",2),X1=$P($G(^PSRX($P(ON,";",2),3)),"^",5),X2=(+$P(^PSRX($P(ON,";",2),0),"^",8)+7)
 ..D C^%DTC I X<DT S PSODCTH(ON)=1 K X,Y,X1,X2
 .I $P(ON,";")="R",$P($G(^TMP($J,LIST,"OUT","REMOTE",$P(ON,";",2))),"^",4)["DISC" D
 ..S RXN=$P(ON,";",2) K X,Y,X1,X2
 ..S X=$P(^TMP($J,LIST,"OUT","REMOTE",RXN),"^",6) D ^%DT S X1=Y,X2=(+$P(^TMP($J,LIST,"OUT","REMOTE",RXN),"^",7)+7)
 ..D C^%DTC I X<DT S PSODCTH(ON)=1 K X,Y,X1,X2
 Q
 ;
RVAGEN ;va generic for remote drugs
 N PSOVIUD,PSONDF,PSOVAG,DIC
 S PSOVUID=$P(^TMP($J,"PSOPEPS","OUT","REMOTE",$P(ON,";",2)),"^",2) Q:'$G(PSOVUID)
 K PSORDIID S PSOVAGEN="" D GETIREF^XTID("50.68",".01",PSOVUID,"PSORDIID")
 S PSONDF=$O(PSORDIID(50.68,.01,"")) K PSORDIID
 I +PSONDF D DATA^PSN50P68(+PSONDF,,"PSONDF") S PSOVAG=$P($G(^TMP($J,"PSONDF",+PSONDF,.05)),U,2),ZDGDG(SV,2,PSOVAG,DRG)=ON_"^"_CT
 K ^TMP($J,"PSONDF")
 Q
 ;
DVAGEN ;va generic for non-va/pending meds
 S PSI=0 N PSID,PSODD,PSOVAG
 F  S PSI=$O(^PSDRUG("ASP",PSORDIT,PSI)) Q:'PSI!($G(PSID)'="")  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S($P($G(^PSDRUG(PSI,2)),"^",3)'["X":0,1:1) S PSID=$P($G(^PSDRUG(PSI,0)),"^")
 I PSI="" S PSI=0 F  S PSI=$O(^PSDRUG("ASP",PSORDIT,PSI)) Q:'PSI!($G(PSID)'="")  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S($P($G(^PSDRUG(PSI,2)),"^",3)'["O":0,1:1) S PSID=$P($G(^PSDRUG(PSI,0)),"^")
 I PSI="" S PSI=0 F  S PSI=$O(^PSDRUG("ASP",PSORDIT,PSI)) Q:'PSI!($G(PSID)'="")  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S($P($G(^PSDRUG(PSI,2)),"^",3)'["U":0,1:1) S PSID=$P($G(^PSDRUG(PSI,0)),"^")
 I PSI="" S PSI=0 F  S PSI=$O(^PSDRUG("ASP",PSORDIT,PSI)) Q:'PSI!($G(PSID)'="")  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S($P($G(^PSDRUG(PSI,2)),"^",3)'["I":0,1:1) S PSID=$P($G(^PSDRUG(PSI,0)),"^")
 I PSI="" S PSI=0 F  S PSI=$O(^PSDRUG("ASP",PSORDIT,PSI)) Q:'PSI!($G(PSID)'="")  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S('$L($P($G(^PSDRUG(PSI,2)),"^",3)):0,1:1) S PSID=$P($G(^PSDRUG(PSI,0)),"^")
 I PSI="" S PSI=0 F  S PSI=$O(^PSDRUG("ASP",PSORDIT,PSI)) Q:'PSI!($G(PSID)'="")  I $S('$D(^PSDRUG(PSI,"I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S($L($P($G(^PSDRUG(PSI,2)),"^",3)):0,1:1) S PSID=$P($G(^PSDRUG(PSI,0)),"^")
 Q:$G(PSID)']""
 S PSODD=$O(^PSDRUG("B",PSID,0)) D VAGEN^PSODDPR3(PSODD)
 Q:$G(PSOVAG)']""
 S ZOT=$S($P(ON,";")="O":1,$P(ON,";")="R":2,$P(ON,";")="P":3,1:4),ZDGDG(SV,ZOT,PSOVAG,DRG)=ON_"^"_CT,COUNT=COUNT+1
 K PSI,PSID,PSORDIT,PSODD,PSOVAG
 Q
 ;
INT ;
 I $G(PSOVORD),$P(PSOINTV,"^")=1 D  Q
 .K DIR,DTOUT,DIRUT,DIROUT,DUOUT
 .W ! S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Continue? ",DIR("B")="Y" D ^DIR S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)
 .K DIR,DTOUT,DIRUT,DIROUT,DUOUT
 .I 'Y S PSODLQT=1,PSORX("DFLG")=1 Q
 .S DA=PSONV,RXREC=DA,RX=$G(^PSRX(RXREC,0)),PSORX("INTERVENE")=1
 .D:'$D(PSODGCK) CRI^PSODGDG1
 .I $G(OLDDA) S DA=OLDDA K OLDDA
 Q:$G(PSODLQT)!($G(PSORX("DFLG")))
 I '$D(PSODGCK),$P(PSOINTV,"^") S IT=$P(PSOINTV,"^"),ON=$P(PSOINTV,"^",2) D ^PSODGDGP K DIR S IT=$P(PSOINTV,"^")
 Q
 ;
DGCK ;CK - Drug check option at patient profile
 I '$D(PSOSD) D FULL^VALM1 W !!,"Not enough drugs found in profile!",! K DIR S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue" D ^DIR K DIR G DGCKQ
 S PSODGCK=1
 D FULL^VALM1
 D PSOCK^PSOUTL
 K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." W ! D ^DIR K DIR W @IOF,!
 D SELECT
 I $G(PSONEW("DFLG"))=1!'$D(PSOSD) W ! G DGCKQ
 D SET^PSODRG
DGCKNP D POST^PSODRG
DGCKQ S VALMBCK="R"
 K PSODGCK,PSODGCKX,MON,PSONEW("DFLG"),PSORX("DFLG"),PSOIENID,PSOGCNPT,PSOGCNID,PSONDFID,DGCKDUPF
 Q
 ;
GCN(PSOIENID) ;Return 0 for not matched, 1 for matched with no GCNSEQNO, 1^1 for matched with a GCNSEQNO
 N PSONDFID,PSOGCNPT,PSOGCNID
 S PSONDFID=$P($G(^PSDRUG(PSOIENID,"ND")),"^"),PSOGCNPT=$P($G(^PSDRUG(PSOIENID,"ND")),"^",3)
 I 'PSONDFID!('PSOGCNPT) Q 0
 S PSOGCNID=$$PROD0^PSNAPIS(PSONDFID,PSOGCNPT)
 I $P(PSOGCNID,"^",7) Q PSOIENID_";"_PSONDFID_";"_$P(PSOGCNID,"^",7)
 Q PSOIENID_";"_PSONDFID
 ;
PKGFLG(PKF1) ;Return 0 for not in range of acceptable package flags, 1 for within range
 I $S(PKF1["O":1,1:0) Q 1
 I $S(PKF1["X":1,1:0) Q 1
 Q 0
 ;
SELECT ;
 N PSODGCKD S PSODGCKD=0 K:'$G(PSORXED) CLOZPAT
 K IT,DIC,X,Y,PSODRUG("TRADE NAME"),PSODRUG("NDC"),PSODRUG("DAW"),PSODRUG("BAD") S:$G(POERR)&($P($G(OR0),"^",9)) Y=$P(^PSDRUG($P(OR0,"^",9),0),"^")
 I $G(PSODRUG("IEN"))]"",'$D(PSODGCK) S Y=PSODRUG("NAME"),PSONEW("OLD VAL")=PSODRUG("IEN")
 W !,"DRUG: " R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I PSODGCK,X="",PSOSD<2 W !!,"Not enough drugs found in profile!",! K DIR S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue" D ^DIR K DIR S PSONEW("DFLG")=1 G SELECTX
 S:X="" PSODGCKX=1
 I X="",$G(Y)]"" S:Y X=Y S:'X X=$G(PSODRUG("IEN")) S:X X="`"_X
 I X="",$D(PSOSD) S X=$O(PSOSD($O(PSOSD("")),"")),PSODGCKD=1
 I X="",'$D(PSOSD) D  Q
 .W !!,"Now Processing Enhanced Order Checks!  Please wait..." H 1
 .W !!,"No Order Check Warnings Found",! K DIR S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue" D ^DIR K DIR
 I X?1."?" W !!,"Answer with DRUG NUMBER, or GENERIC NAME, or VA PRODUCT NAME, or",!,"NATIONAL DRUG CLASS, or SYNONYM" G SELECT
 I $G(PSORXED),X["^" S PSORXED("DFLG")=1 G SELECTX
 I X="^"!(X["^^")!($D(DTOUT)) S PSONEW("DFLG")=1 G SELECTX
 I '$G(POERR),X[U,$L(X)>1 S PSODIR("FLD")=PSONEW("FLD") D JUMP^PSODIR1 S:$G(PSODIR("FIELD")) PSONEW("FIELD")=PSODIR("FIELD") K PSODIR S PSODRG("QFLG")=1 G SELECTX
 S DIC=50,DIC(0)="MZV",D="B^C^VAPN^VAC"
 I 'PSODGCKD S DIC=50,DIC(0)="EMQZVT",DIC("T")="",D="B^C^VAPN^VAC"
 S DIC("S")="I $S('$D(^PSDRUG(+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0),$$GCN^PSODDPR5(+Y),$$PKGFLG^PSODDPR5($P($G(^PSDRUG(+Y,2)),""^"",3)),$D(^PSDRUG(""ASP"",+$G(^(2)),+Y))"
 D MIX^DIC1 K DIC,PKF1,D
 I $$PSOSUPCK^PSOUTL(+Y) G SELECT
 S (DGCKSTA,DGCKDNM)=""
 I '$D(PSODGCKX),$D(PSOSD) F  S DGCKSTA=$O(PSOSD(DGCKSTA)) Q:DGCKSTA=""!$G(DGCKDUPF)  F  S DGCKDNM=$O(PSOSD(DGCKSTA,DGCKDNM)) Q:DGCKDNM=""!$G(DGCKDUPF)  D
 .I DGCKDNM=$G(Y(0,0)) D
 ..S DGCKDUPF=1 W !!,"Duplicate Drug in Patient profile, please select a different drug:",!
 ..K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR W @IOF
 I $D(DGCKDUPF) K DGCKDUPF,PSODGCKX G SELECT
 I '$D(PSOSD) D  Q
 .W !!,"Now Processing Enhanced Order Checks!  Please wait..." H 1
 .W !!,"No Order Check Warnings Found",! K DIR S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue" D ^DIR K DIR
 I $D(DTOUT) S PSONEW("DFLG")=1 G SELECTX
 I $D(DUOUT) K DUOUT G SELECT
 I Y<0 G SELECT
 S:$G(PSONEW("OLD VAL"))=+Y&('$G(PSOEDIT)) PSODRG("QFLG")=1
 K PSOY S PSOY=Y,PSOY(0)=Y(0)
 I $P(PSOY(0),"^")="OTHER DRUG"!($P(PSOY(0),"^")="OUTSIDE DRUG") D TRADE^PSODRG
SELECTX K X,Y,DTOUT,DUOUT,PSONEW("OLD VAL"),PSODGCKD,DGCKDNM,DGCKSTA
 Q
 ;
