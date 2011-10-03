ORLA1 ; slc/dcm,cla - Order activity alerts ;3/10/05  15:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,82,215**;Dec 17, 1997
 ;
 ; DBIA 3869   GETPLIST^SDAMA202   ^TMP($J,"SDAMA202")
 ;
BUILD ;
 D PARAM^ORU1
 K:$D(ORDEF) ^XUTL("OR",$J,"ORLP"),^("ORW"),^("ORU"),^("ORV")
B1 ;
 D PREF
 I $D(ORDEF),ORDEF="P"!(ORDEF="T"),$D(^OR(100.21,+$G(ORPRIM),0)) S X=$P(^(0),"^")_" patient list",ORY=ORPRIM_"^"_$P(^(0),"^"),ORTITLE=$S($D(^XUTL("OR",$J,"ORLP",0)):$S('$P(^(0),"^",2):"PATIENT LIST",1:X),1:X),ORCOLW=40-($L(ORTITLE)\2) D P1 Q
 I $D(ORDEF),ORDEF="W",ORWARD,$D(^DIC(42,ORWARD,0)) S X=$P(^(0),"^")_" ward list",ORY=ORWARD_"^"_$P(^(0),"^"),ORTITLE=$S($D(^XUTL("OR",$J,"ORLP",0)):$S('$P(^(0),"^",2):"PATIENT LIST",1:X),1:X),ORCOLW=40-($L(ORTITLE)\2) D W1 Q
 I $D(ORDEF),ORDEF="C",ORCLIN,$D(^SC(ORCLIN,0)) S X=$P(^(0),"^")_" clinic list",ORY=ORCLIN_"^"_$P(^(0),"^"),ORTITLE=$S($D(^XUTL("OR",$J,"ORLP",0)):$S('$P(^(0),"^",2):"PATIENT LIST",1:X),1:X),ORCOLW=40-($L(ORTITLE)\2) D C0 Q
 I $D(ORDEF),ORDEF="V",ORPROV,$D(^VA(200,ORPROV,0)) S X=$P(^(0),"^")_" patient list",ORY=ORPROV_"^"_$P(^(0),"^"),ORTITLE=$S($D(^XUTL("OR",$J,"ORLP",0)):$S('$P(^(0),"^",2):"PATIENT LIST",1:X),1:X),ORCOLW=40-($L(ORTITLE)\2) D V1^ORLA11 Q
 I $D(ORDEF),ORDEF="S",ORSPEC,$D(^DIC(45.7,ORSPEC,0)) S X=$P(^(0),"^")_" specialty list",ORY=ORSPEC_"^"_$P(^(0),"^"),ORTITLE=$S($D(^XUTL("OR",$J,"ORLP",0)):$S('$P(^(0),"^",2):"PATIENT LIST",1:X),1:X),ORCOLW=40-($L(ORTITLE)\2) D S1^ORLA11 Q
 Q
P1 ; Loading the Primary Patient List
 S (ORCNT,J)=0
 F  S J=$O(^OR(100.21,+ORY,10,J)) Q:J<1  S ORX=^(J,0),ORVP=$P(ORX,"^") D PR1(ORVP,OROPREF)
 D PR2(OROPREF,ORTITLE,ORDEF)
 K ORI,ORJ,ORURMBD,ORUVP,ORVP,ORX,ORY
 Q
W1 ;
 W !,"Loading Ward Patient List..."
 S (ORCNT,ORJ)=0
 F  S ORJ=$O(^DPT("CN",$P(ORY,"^",2),ORJ)) Q:ORJ<1  S ORX="",ORVP=ORJ_";DPT(" D PR1(ORVP,OROPREF)
 D PR2(OROPREF,ORTITLE,ORDEF)
 K ORI,ORJ,ORURMBD,ORUVP,ORVP,ORX,ORY
 Q
C0 ; DBIA 3869
 ; SLC/PKS - 5/15/2000: Next line added to fix a reported problem:
 N %DT,ORI,ORERR
 W:$L(ORCSTRT) !,"Starting date: "
 S %DT=$S($L(ORCSTRT):"E",1:"AE"),X=$S($L(ORCSTRT):ORCSTRT,1:"")
 S:'$L(ORCSTRT) %DT("A")="Patient Appointment STARTING DATE: ",%DT("B")="T"
 D ^%DT
 I Y<0 S OREND=1 Q
 S ORCSTRT=Y
 D DD^%DT
 W:$L(ORCEND) !,"Ending date: "
 S %DT=$S($L(ORCEND):"E",1:"AE"),X=$S($L(ORCEND):ORCEND,1:"")
 S:'$L(ORCEND) %DT("A")="Patient Appointment ENDING DATE: ",%DT("B")=Y
 D ^%DT
 I Y<0 S OREND=1 Q
 S ORCEND=$P(Y,".")_.5
 I ORCEND<ORCSTRT S ORCTMP=ORCEND,ORCEND=ORCSTRT,ORCSTRT=ORCTMP K ORCTMP
 W !,"Loading Clinic Patient List..."
 K ^TMP($J,"SDAMA202","GETPLIST")
 S ORCNT=0
 D GETPLIST^SDAMA202(+ORCLIN,"1;4","",ORCSTRT,ORCEND)  ;DBIA 3869
 S ORERR=$$CLINERR^ORQRY01
 I $L(ORERR) W !,ORERR Q
 S ORI=0
 F  S ORI=$O(^TMP($J,"SDAMA202","GETPLIST",ORI)) Q:ORI<1  D  ;DBIA 3869
 . S ORCLDT=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,1))
 . S DFN=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,4))
 . I DFN,ORCLDT S ORX="" D C1
 K ORCLDT,ORI,ORURMBD,ORUVP,ORVP,ORX,ORY
 K ^TMP($J,"SDAMA202","GETPLIST")
 I '$L($O(^XUTL("OR",$J,"ORLP",0))) W $C(7),!,"No patients found" D READ^ORUTL Q
 H 1
 Q
END ;
 G END^ORLA11
 Q
C1 ;
 S ORVP=DFN_";DPT("
 D PR1(ORVP,OROPREF,ORCLDT)
 I '$D(^XUTL("OR",$J,"ORLP",ORUVP)),$D(^DPT(DFN,0)) S ORCNT=ORCNT+1,ORUPNM=$P(^(0),"^"),ORUSSN=$P(^(0),"^",9) S ^XUTL("OR",$J,"ORLP",ORUVP,0)=ORUPNM_"^"_ORUSSN_"^"_ORVP
 D PR2(OROPREF,ORTITLE,ORDEF)
 Q
PR1(ORVP,OROPREF,ORCLDT) ;from ORLA11
 Q:'$G(ORVP)
 I '$D(^DPT(+ORVP)) W !,"Data inconsistency found, no entry for DFN="_+ORVP Q
 S ORUVP=+ORVP
 Q:$D(^XUTL("OR",$J,"ORLP",ORUVP))
 N DFN,RB,VAIN,VADM,X
 S ORCNT=ORCNT+1
 S DFN=ORUVP,X=$G(^DPT(ORUVP,0)),ORUPNM=$P(X,U),ORUSSN=$P(X,U,9)
 D INP^VADPT
 S ORURMBD=VAIN(5)
 I ORURMBD']"" S ORURMBD="~"
 S ORUPNM=$S($L(ORUPNM)'>15:ORUPNM,1:$$NAME^ORU(ORUPNM,"LAST, FI MI"))
 S:$L(ORUPNM)<16 ORUPNM=ORUPNM_$E("               ",$L(ORUPNM),16)
 S RB=ORURMBD,ORURMBD=ORURMBD_$E("        ",$L(ORURMBD),8)
 S ^XUTL("OR",$J,"ORLP",ORUVP,0)=ORUPNM_"^"_ORUSSN_"^"_ORVP_"^"_$P(ORX,"^",2)_"^"_ORURMBD
 I $D(ORCLDT),ORCLDT S X=ORCLDT D LTIM S ^(0)=^(0)_"^"_X
 S ^XUTL("OR",$J,"ORLP","B",ORUPNM,ORUVP)=""
 S:$D(ORCT) ORCT=ORCT+1
 D KVAR^VADPT
 ; terminal digit x-ref
 I OROPREF="T" S S=ORUSSN,S="A"_$E(S,8,9)_$E(S,6,7)_$E(S,1,5)_$E(S,10,11),^XUTL("OR",$J,"ORLP","C",S,ORUVP)="" K S Q
 ; room bed x-ref
 I OROPREF="R" S ^XUTL("OR",$J,"ORLP","D",RB,ORUVP)="" Q
 ; clinic date x-ref
 I $G(ORCLDT) S ^XUTL("OR",$J,"ORLP","D",ORCLDT,ORUVP)=""
 Q
PR2(OROPREF,ORTITLE,ORDEF) ;
 S:$L($O(^XUTL("OR",$J,"ORLP",0))) ^(0)=$S($L($G(ORTITLE)):ORTITLE,1:"Current PATIENT List")_"^1^"_$S(OROPREF="T":"C",OROPREF="R":"D",OROPREF="C"&($G(ORDEF)="C"):"D",1:"B")_"^"_ORCNT
 Q
LTIM ;
 Q:'$L(X)
 S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_$S(X[".":" "_$E(X_"0",9,10)_":"_$E(X_"000",11,12),1:"")
 Q
KIL ;
 Q:'$D(^XUTL("OR",$J,"ORLP"))
 W !,"The current patient list will be cleared."
 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW")
 Q
PREF ;Get a preference
 N ORSRV
 S ORSRV=$P($G(^VA(200,DUZ,5)),"^"),OROPREF=$$GET^XPAR("USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT LIST ORDER",1,"I")
 Q
