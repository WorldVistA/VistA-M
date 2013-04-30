DGBTALTI ;PAV - BENEFICIARY/TRAVEL Alternate Income Enter/Edit; 4/23/2012@1130 ;11/14/11  09:58
 ;;1.0;Beneficiary Travel;**20**;September 25, 2001;Build 185
ALT ;BT Alternate Income Enter/Edit
 D KILL S DGBTIME=300 S:'$D(DTIME) DTIME=DGBTIME S:'$D(U) U="^"
 I '$D(DT)#2 S %DT="",S="T" D ^%DT S DT=Y
PATIENT ; patient lookup, quit if patient doesn't exist
 D QUIT1^DGBTEND ; kill local variables except med division vars
 S DGBTDTI=DT
 S DGBTTOUT="",DIC="^DPT(",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: "
 W !!,"BT Alternate Income Enter/Edit" D ^DIC K DIC G:+Y'>0 EXITE
 ; get patient information#
 S DFN=+Y
 L +^DGBT(392.9,DFN):3
 E  W !,*7,"Somebody else is Editing this entry",*7 G EXIT
 D 6^VADPT,KVAR^DGBTEND,PID^VADPT ;
 I '+VAEL(1) W !!,"Eligibility is missing from registration and is required to continue.",*7 G EXIT
 D GA^DGBTUTL(DFN,"XX(3)",DT,"XX(5)") ;W !! ZW XX W !
 I $D(XX(5,1))!(XX(3)) D  W ! G:$G(EXIT) EXIT
 .W ! S DIR("A")="<D>isplay Income History, or <C>ontinue with current Alt. Income: ",DIR(0)="SA^;D:Display;C:Continue",DIR("B")="C" D ^DIR
 .I Y=U!($G(DUOUT)) S EXIT=1 Q
 .Q:Y="C"
 .W !!,"History of Alt. Incomes:" S I=0
 .F  S I=$O(XX(5,I)) Q:'I  W !,I,":  ",$$FMTE^XLFDT($P(XX(5,I),U,3)),?30,"$",$P(XX(5,I),U,2),?40,$S($P(XX(5,I),U,4)="H":"Hardship",1:"POW"),?50,"Ex: ",$$FMTE^XLFDT($P(XX(5,I),U,5))
 .W:XX(3) !,"*",":  ",$$FMTE^XLFDT($P(XX(3),U,3)),?30,"$",$P(XX(3),U,2),?40,$S($P(XX(3),U,4)="H":"Hardship",1:"POW"),?50,"Ex: ",$$FMTE^XLFDT($P(XX(3),U,5))
DATE ;Get the date
 K DIR S DIR("A")="Begin Date",DIR("B")=$$FMTE^XLFDT(DT),DIR(0)="D^"_$$FMADD^XLFDT(DT,-30)_":DT:EA"
 D ^DIR G:(Y=U)!$G(DTOUT)!$G(DUOUT) EXIT
 S DGBTDTI=Y,DGBTDTY=" (Year: "_$$FMTE^XLFDT($E(DGBTDTI,1,3)_"0000")_")"
 S XXX(3)=XX(3) K XX D PI(DFN,DGBTDTI,.XX) S XX(3)=XXX(3)
 D PD S TXT=""
RD ;Display - Redisplay Alt. Income on File
 I XX(3) W !!,*7 S:'$L(TXT) TXT=$$FMTE^XLFDT($P(XX(3),U,3))_": $"_$P(XX(3),U,2)_" Alternate income is on the File" W TXT D  G:EXIT EXIT G RD
 .I $$FMDIFF^XLFDT(DT,$P(XX(3),U,3))>30 W !!,"No Edit permited for Alt. Income older as 30 days." S EXIT=1 Q
 .S EXIT=0,TXT=""
 .K DIR S DIR("A")="<D>elete Alt. Income, <E>dit Alt. Income, or <Q>uit ",DIR("B")="Quit",DIR(0)="SA^D:Delete;E:Edit;Q:Quit" D ^DIR
 .I Y="Q"!(Y=U) S EXIT=1 Q
 .I Y="E" S X=$$SETINC(DFN,$P(XX(3),U,3),DGBTDTI) D GA^DGBTUTL(DFN,"XX(3)",DGBTDTI),PD S TXT=$$FMTE^XLFDT($P(XX(3),U,3))_": Alt. Income "_$S($P(XX(3),U,4)="H":"Hardship",1:"POW")_": $"_$P(XX(3),U,2)_" has been Saved " Q
 .I Y="D" S DA(1)=DFN,DA=$P(XX(3),U,3),DIK="^DGBT(392.9,DFN,1," D ^DIK W !,"Alternate Income Deleted" S EXIT=1
 I XX(1) W !!,"Patient Already Qualified for Low Income Condition",*7 G EXIT
 W:XX(4) !!,"This is the POW Patient",*7
 W !
RD1 W !,"Continue Processing Alternate Income" S %=1 D YN^DICN
 I %=2!(%=-1) G EXIT
 I '% W !,"    Answer with 'Yes' or 'No'",*7 G RD1
 I $$SETINC(DFN,,DGBTDTI) S DA(1)=DFN,DA=DGBTDTI,DIK="^DGBT(392.9,DFN,1," D ^DIK W !,"Alternate Income Deleted" G EXIT
 D GA^DGBTUTL(DFN,"XX(3)",DGBTDTI),PD
 I XX(3) W !!,$S($P(XX(3),U,4)="H":"Hardship",1:"POW")_": $",$P(XX(3),U,2)," Begin: ",$$FMTE^XLFDT($P(XX(3),U,3))," Expire: ",$$FMTE^XLFDT($P(XX(3),U,5))," has been Saved "
 G EXIT
 Q 
SETINC(DFN,OLDDATE,DGBTDTI) ;Set Alt Income
 N DIE,DR,Y,FDA,DA
 I $G(OLDDATE) S DA(1)=DFN,DA=OLDDATE,DIK="^DGBT(392.9,DFN,1," D ^DIK
 I '$D(^DGBT(392.9,DFN,0)) S IENC(1)=DFN  S FDA(392.9,"+1,",.01)=IENC(1) D UPDATE^DIE(,"FDA","IENC")
 K IENC S IENC(2)=DGBTDTI,FDA(392.91,"+2,"_DFN_",",.01)=IENC(2) D UPDATE^DIE(,"FDA","IENC","DGBTERR")
 W !,"Begin of Alt. Income: ",$$FMTE^XLFDT(DGBTDTI)
 K DIR S DIR("A")="Enter the Alternate Income",DIR(0)="392.91,1"
 I $L($P($G(XX(3)),U,2)) S DIR("B")=$P($G(XX(3)),U,2),DIR(0)="392.91,1"
 E  S DIR(0)="392.91,1A",DIR("A")=DIR("A")_": "
 D ^DIR
 Q:Y=U!$G(DTOUT) 1  ;$S($P($G(XX(3)),U,2):0,1:1)
 S FDA(392.91,DGBTDTI_","_DFN_",",1)=Y
 K DIR S DIR("A")="Enter the Reason for Alternate Income: "
 I XX(4) S DIR("B")="P",DIR(0)="SA^P:POW;H:Hardship"
 E  S DIR("B")="H",DIR(0)="SA^H:Hardship"
 D ^DIR
 I Y=U!$G(DTOUT) Q 1
 S FDA(392.91,DGBTDTI_","_DFN_",",2)=Y
 S FDA(392.91,DGBTDTI_","_DFN_",",3)=$S(Y="H":$E(DGBTDTI,1,3)_1231,1:$E(DGBTDTI,1,3)+1_$E(DGBTDTI,4,7))
 D FILE^DIE(,"FDA")
 Q 0
PI(DFN,DGBTDTI,XX) ;Return Patient info in XX
 ;XX(1)=Already Low Income on Record
 ;XX(2)=Hardship on Record  <== Discontinued
 ;XX(3)=Alt Income is on file   1^$Alt Inc^Date^Reason^Exp Date
 ;XX(4)=POW on file
 ;XX(5)=Expired Alt Income on file (list)  XX(5,I)=Date^income^reason^expiration date
 N X0,X1,FDA K XX
 S DGBTDEP=$$DEP^VAFMON(DFN,DGBTDTI)
 S DGBTMTTH=$$MTTH^DGBTMTTH(DGBTDEP,DGBTDTI) ; Means test threshold
 S DGBTRXTH=+$$THRES^IBARXEU1(DGBTDTI,1,DGBTDEP) ; RX co-pay threshhold
 S X0=+$$LI^DGBTUTL(DFN,DGBTDTI,DGBTDEP,1)
 S XX(1)=$S("1^2"[X0:1,1:0)
 ;S XX(2)=$S(X0=3:1,1:0)
 D GA^DGBTUTL(DFN,"XX(3)",DGBTDTI,"XX(5)")
 D SVC^VADPT
 S XX(4)=+$G(VASV(4))
 Q:XX(4)
 ;VAEL(1)="15^HOUSEBOUND"
 ;VAEL(1,18)="18^PRISONER OF WAR"
 I VAEL(1)["PRISONER OF WAR" S XX(4)=1
 F  S X0=$O(VAEL(1,X0)) Q:'X0  I VAEL(1,X0)["PRISONER OF WAR" S XX(4)=1 Q
 Q
PD ;Display patient information
 W @IOF
 D PID^VADPT6 W !!?8,"Name: ",VADM(1),?40,"PT ID: ",VA("PID"),?64,"DOB: ",$P(VADM(3),"^",2)
 W !!?5,"Address: ",VAPA(1) W:VAPA(2)]"" !?14,VAPA(2) W:VAPA(3)]"" !?14,VAPA(3) W !?14,VAPA(4),$S(VAPA(4)]"":", "_$P(VAPA(5),"^",2)_"  "_$P(VAPA(11),U,2),1:"UNSPECIFIED")
 ;  if move in current info for elig, sc%
 S DGBTELG=VAEL(1),DGBTCSC=VAEL(3)
 I +DGBTELG=3,'$E(DGBTCSC)=1 S DGBTCSC=1
 W !!," Eligibility: ",$P(DGBTELG,"^",2) W:DGBTCSC ?45,"SC%: ",$P(DGBTCSC,"^",2) W ?65,"POW:",$S(XX(4):"YES",1:"NO") W !
 I $O(VAEL(1,0))'="" W !," Other Elig.: " F I=0:0 S I=$O(VAEL(1,I)) Q:'I  W ?14,$P(VAEL(1,I),"^",2)," "
 ;  service connected status/information
 I DGBTCSC&($P(DGBTCSC,"^",2)'>29) W !!,"Disabilities:" S I3=""
 N DGQUIT,I
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I!($G(DGQUIT)=1)  D
 . S I1=^(I,0),I2=$S($D(^DIC(31,+I1,0)):$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",1:"NSC")_")",1:""),I3=I1
 . I $Y>(IOSL-3) D PAUSE I $G(DGQUIT)=0 W @IOF
 . I $G(DGQUIT)=1 Q
 . W ?16 W I2,!
 ;;;
 D:XX(3)
 .N X,X2,X3
 .S X=$P(XX(3),U,2),DGBTIFL=$E($P(XX(3),U,4)) ; returns income & source.
 .I X?1N.E!(X<0) D
 .I X<0 S X=0
 .S X2="0$",X3=8 D COMMA^%DTC
 .S DGBTINC=X_U_$G(DGBTIFL)
 S DGBTDT=DGBTDTI,DGBTINCA=XX(3)
 I $$DAYSTEST^DGBT1(DFN,.DAYFLG,.RXDAYS,.RXCPST,.LOWINC,.DGNOTEST)
 S X=$$LST^DGMTCOU1(DFN,DT,3),DGBTMTS=$P(X,U,4)_U_$P(X,U,3)
 S:XX(3) RXCPST=0,DGBTMTS=U,DAYFLG=1 ; PAVEL
 ;I DAYFLG,$G(RXCPST),$G(RXCP)'=1 S DGBTINC="^",DGBTIFL=""
 I DAYFLG,$G(RXCPST) S DGBTIFL="C" S:DGBTMTS]"" DGBTMTS=U S:$G(RXCP)'=1 DGBTINC="^"
 I 'DAYFLG S DGBTINC="^",DGBTIFL="^",DGBTMTS="EX^"
 W !!?2,"Income: ",$P($G(DGBTINC),U),$G(DGBTDTY),?35,"Source of Income:  "
 W $S($G(DGBTIFL)="M":"MEANS TEST",$G(DGBTIFL)="C":"COPAY TEST",$G(DGBTIFL)="P":"Alt. Income POW",$G(DGBTIFL)="H":"Alt. Income Hardship",1:"")
 I XX(3) W !,?40," (Expire: ",$$FMTE^XLFDT($P(XX(3),U,5)),")"
 W !?2,"No. of Dependents: ",+DGBTDEP
 ;
 I DGBTMTS]"" W:$P(DGBTMTS,"^")'="N" ?35,"MT Status: ",$S($P(DGBTMTS,"^")="EX":"EXPIRED",$P(DGBTMTS,"^")="R":"REQUIRED",$P(DGBTMTS,"^")="P":$P($P(DGBTMTS,"^",2)," "),DGBTMTS=U!($G(RXCPST)):" NOT APPLICABLE",1:$P(DGBTMTS,"^",2))
 ;
 Q
PAUSE   ;added with DGBT*1*11
 I $E(IOST,1,2)["C-" N DIR S DIR(0)="E" D ^DIR S DGQUIT='Y
 Q 
EXIT ;Exit patient
 I $G(DFN) L -^DGBT(392.9,DFN)
 W !!,"EXITING Patient" D KILL G ALT
 Q
EXITE ; Exit Menu
 I $G(DFN) L -^DGBT(392.9,DFN)
 W !!,"EXITING Alternate Income Menu" D KILL
 Q
KILL ;Kill Local variable.. Dont use NEW, because of return to Patient Prompt
 K DGBTTOUT,DGBTAI,DGBTAIE,DGBTR,DGBTHAR,DGBTELG,VAEL,DGBTCSC,VAPA,VASV,DGBTDEP,DGBTIFL,DGBTINC,IENC,DGBTDTI,DGBTERR,DGBTMTS,DGBTDTY,TXT
 K DGBTINCA,DAYFLG,RXDAYS,RXCPST,LOWINC,DGNOTEST,RXCP,DDD
 K X,Y,I,I1,I2,I3,X2,DFN,DIC,Y,EXP,DA,DR,DIE,FDA,XX,XXX,DIR,EXIT,%DT
