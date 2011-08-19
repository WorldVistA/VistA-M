ECED2 ;BIR/MAM,JPW-Enter Event Capture Data (cont'd) ;7 May 96
 ;;2.0; EVENT CAPTURE ;**1,4,5,13,18,47**;8 May 96
NEW ; create new procedure
 S (EC1,OK)=0 K ECHOICE,ECSTOP
 I '$D(ECC(1)) S ECC=+$P(ECC(0),"^"),ECCN="None" G P
 I '$D(ECC(2)) S ECC=+ECC(1),ECCN=$P(ECC(1),"^",2) G P
 S X="",CNT=0
LIST W:$D(EC(1))!($Y+5>IOSL) @IOF W !,"Categories within "_ECDN_": ",! S EC1=0 F I=0:0 S CNT=$O(ECC(CNT)) Q:'CNT!$D(ECHOICE)  D:($Y+5>IOSL) SELC Q:$D(ECHOICE)  I X="" W !,CNT_". ",?5,$P(ECC(CNT),"^",2)
 I '$D(ECSTOP),$D(ECHOICE) G P
PICK W !!,"Select Number:  " R X:DTIME I '$T!("^"[X) S ECOUT=1 Q
 I '$D(ECC(X)) W !!,"Select the number corresponding to the category, or ^ to quit.",!!,"Press <RET> to continue  ",! R X:DTIME K ECHOICE,ECSTOP S CNT=CNT-5,X="" G LIST
 S ECC=+$P(ECC(X),"^"),ECCN=$P(ECC(X),"^",2)
 W !,"Category: "_ECCN,!
P ; get procedure
 I '$D(ECC) W !!,"Category not defined.",! D MSG^ECEDU Q
 D PROS^ECHECK1
 I '$O(^TMP("ECPRO",$J,0)) D  Q:ECOUT
 .W !!,"Within the ",ECLN," location there are no procedures defined",!
 .W "for the DSS Unit ",ECDN,".  Please select another DSS Unit.",!!
 .W "Press <RET> to continue " R X:DTIME S ECOUT=2 Q
P1 ;
 I '$D(^TMP("ECPRO",$J,2)) S CNT=1 D SETP W !,"Procedure: " D  G FILE
 . W $S(ECCPT="":"",1:ECPTCD_" ")_$E(ECPN,1,50)
 . W $S(SYN'["NOT DEFINED":" ["_SYN_"]",1:"")_"  (#"_NATN_")",!
P2 ;ask mul proc
 S EC1=1
 S ECX="",(ECPCNT,CNT,OK)=0 K ECHOICE,ECSTOP
 ;
 ;New code for procedure entry/lookup
 S DIR("?")="^D PROS^ECED2"
 S ECX=$$GETPRO^ECDSUTIL
 I +$G(ECX)=-1 D MSG^ECEDU,KILLV^ECDSUTIL Q
 I +$G(ECX)=1 D SRCHTM^ECDSUTIL(ECX)
 S ECPCNT=+$G(ECPCNT)
 I ECPCNT=-1!(ECPCNT=-2) D  G P2
 . D @($S(ECPCNT=-1:"ERRMSG^ECDSUTIL",ECPCNT=-2:"ERRMSG2^ECDSUTIL"))
 . D KILLV^ECDSUTIL
 I ECPCNT>0 D  G FILE
 . S CNT=ECPCNT
 . D SETP
 . S OK=1
 . D KILLV^ECDSUTIL
 I 'ECPCNT,$D(ECPNAME) S CNT=$$PRLST^ECDSUTIL
 I CNT=-1 D MSG^ECEDU,KILLV^ECDSUTIL Q
 I CNT>0 D  G FILE
 . D SETP
 . S OK=1
 . D KILLV^ECDSUTIL
 Q
 ;
PROS ;
LISTP N X,CNT
 S X="",CNT=0 K ECHOICE,ECSTOP
 D HDR1^ECEDU S JJ=1 W !,"Available Procedures within "_ECDN_": ",!
 W ?72,"National",!,?5,"Procedure Name",?40,"Synonym",?72,"Number",!
 S EC1=1
 F   S CNT=$O(^TMP("ECPRO",$J,CNT)) Q:'CNT!$D(ECHOICE)  D:($Y+5>IOSL) SELC Q:$D(ECHOICE)  I X="" W !,CNT_".",?5,$E($P(^TMP("ECPRO",$J,CNT),"^",4),1,30),?38,$E($P(^(CNT),"^",3),1,30),?72,$P(^(CNT),"^",5)
 I X="" D
 .W !!?5,"Select by number, CPT or national code, procedure name, or synonym."
 .W !?5,"Synonym must be preceded by the & character  (example:  &TESTSYN).",!
 .W ?2,"** Modifier(s) can be appended to a CPT code (ex: CPT code-mod1,mod2,mod3) **",!
 Q
 ;
FILE ;file pro
 D HDR^ECEDU
 D ^ECEDF
 Q
SETP ;set proc info
 S ECJJ=0
 S ECP=$P(^TMP("ECPRO",$J,CNT),"^"),ECPN=$P(^(CNT),"^",4),NATN=$P(^(CNT),"^",5),ECVOL=$P(^(CNT),"^",6),SYN=$P(^(CNT),"^",3),EC4=$P(^(CNT),"^",2)
 S ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP)
 S ECPTCD="" I ECCPT'="" D
 . S ECPTCD=$$CPT^ICPTCOD(ECCPT,ECDT)
 . I +ECPTCD>0 S ECPTCD=$P(ECPTCD,U,2)
 W "  "_$S(ECCPT="":"",1:ECPTCD_" ")_$E(ECPN,1,50)
 W $S(SYN'["NOT DEFINED":" ["_SYN_"]",1:"")_"  (#"_NATN_")",!
 S EC4=$P($G(^ECJ(+EC4,"PRO")),"^",4)
 S EC4N=$S($P($G(^SC(+EC4,0)),"^")]"":$P(^(0),"^"),1:""),ECID=$P($G(^SC(+EC4,0)),"^",7)
 S ^TMP("ECLKUP",$J,"LAST")=CNT
 Q
SELC ; select category
 W !!,$S(EC1:"Press",1:"Select Number, or press")_" <RET> to continue listing "_$S(EC1:"procedures",1:"categories")_" or '^' to stop: " R X:DTIME I '$T!(X="^") S (ECSTOP,ECHOICE)=1 Q
 I X="" W @IOF,!,$S(EC1:"Available Procedures",1:"Categories")_" within ",ECDN," : ",! Q
 I 'EC1,'$D(ECC(X)) D MSGC^ECEDU Q
 I EC1,'$D(^TMP("ECPRO",$J,X)) D MSGC^ECEDU Q
 S ECHOICE=1
 I 'EC1 S ECC=+$P(ECC(X),"^"),ECCN=$P(ECC(X),"^",2) Q
 Q
