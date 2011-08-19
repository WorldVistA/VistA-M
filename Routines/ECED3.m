ECED3 ;BIR/MAM,JPW-Enter Event Capture Data (cont'd) ;7 May 96
 ;;2.0; EVENT CAPTURE ;**1,4,5,7,10,13,18,23,29,32,47,72**;8 May 96
EDIT ; enter or edit procedure
 W !!,"Edit or Delete this Procedure:  EDIT//  " R X:DTIME I '$T!(X["^") S ECOUT=1 Q
 S X=$E(X) S:X="" X="E" I "EeDd"'[X W !!,"Press <RET> to edit the selected procedure, or enter D to delete",!,"the procedure.",! G EDIT
 I "Dd"[X D DEL Q
 D SETE^ECEDU
ASK ;edit cat
 S (ECFLG,ECOLD,ECOLDN,EC1,OK)=0
 I '$D(ECC(1)) G P
 I '$D(ECC(2)) G P
 W !!,"Category: "_ECCN_"// " R X:DTIME I '$T!(X["^") S ECOUT=1 Q
 I X="" G P
 I "?"[X G NEWC
NEW ; create new procedure
 S MM="" F  S MM=$O(ECC(MM)) Q:(MM="")!($D(ECHOICE))  I $D(ECC(MM)),$P(ECC(MM),"^",2)=X S ECHOICE=MM
 I $D(ECHOICE) S ECOLD=ECC,ECOLDN=ECCN,ECC=+ECC(ECHOICE),ECCN=$P(ECC(ECHOICE),"^",2)
 I $D(ECHOICE),ECC=ECOLD K ECOLD,ECOLDN W !,"CATEGORY: "_ECCN K ECHOICE G P
 I $D(ECHOICE) G P
NEWC S X="",(CNT,ECOLD)=0
LIST W !,"Categories within "_ECDN_": ",! S EC1=0 F I=0:0 S CNT=$O(ECC(CNT)) Q:'CNT!$D(ECHOICE)  D:($Y+5>IOSL) SELC Q:$D(ECHOICE)  I X="" W !,CNT_". ",?5,$P(ECC(CNT),"^",2)
 I '$D(ECSTOP),$D(ECHOICE) G P
PICK W !!,"Select Number:  " R X:DTIME I '$T!("^"[X) S ECOUT=1 Q
 I '$D(ECC(X)) W !!,"Select the number corresponding to the procedure category, or ^ to quit.",!!,"Press <RET> to continue  ",! R X:DTIME K ECHOICE,ECSTOP S CNT=CNT-5,X="" D HDR^ECEDU G LIST
 S ECOLD=ECC,ECOLDN=ECCN,ECC=$P(ECC(X),"^"),ECCN=$P(ECC(X),"^",2) I ECC=ECOLD K ECOLD,ECOLDN
P ; get procedure
 S EC1=1 D PROS^ECHECK1
 I '$O(^TMP("ECPRO",$J,0)) D  Q:ECOUT
 .W !!,"Within the ",ECLN," location there are no procedures defined",!
 .W "for the DSS Unit ",ECDN,".  Please select another DSS Unit.",!!
 .W "Press <RET> to continue " R X:DTIME S ECOUT=2 Q
P1 ;
 I '$D(^TMP("ECPRO",$J,2)) S CNT=1 D SETP W !,"Procedure: " D  G DIE
 . W $S(ECCPT="":"",1:ECPTCD_" ")_$E(ECPN,1,50)
 . W $S(SYN'["NOT DEFINED":" ["_SYN_"]",1:"")_"  (#"_NATN_")",!
 ;
NEWP S ECX="",(ECPCNT,CNT,OK)=0,EC1=1 K ECHOICE,ECSTOP
 I $G(ECPN)]"" S DIR("B")=ECPN
 S DIR("?")="^D PROS^ECED3"
 S ECX=$$GETPRO^ECDSUTIL
 I +$G(ECX)=-1 D KILLV^ECDSUTIL S ECOUT=1 Q
 ;
 I +$G(ECX),($G(ECPROCED)=$G(ECPN)) D KILLV^ECDSUTIL G DIE
 ;
P2 ;ask mul proc
 I +$G(ECX)=1 D SRCHTM^ECDSUTIL(ECX)
 S ECPCNT=+$G(ECPCNT)
 I ECPCNT=-1!(ECPCNT=-2) D  G NEWP
 . D @($S(ECPCNT=-1:"ERRMSG^ECDSUTIL",ECPCNT=-2:"ERRMSG2^ECDSUTIL"))
 . D KILLV^ECDSUTIL
 I ECPCNT>0 D  G DIE
 . S CNT=ECPCNT
 . D SETP
 . S OK=1
 . D KILLV^ECDSUTIL
 I 'ECPCNT,$D(ECPNAME) S CNT=$$PRLST^ECDSUTIL
 I CNT=-1 D MSG^ECEDU,KILLV^ECDSUTIL Q
 I CNT>0 D  G DIE
 . D SETP
 . S OK=1
 . D KILLV^ECDSUTIL
 Q
PROS ;
 S X="",CNT=0 K ECHOICE,ECSTOP
LISTP D HDR1^ECEDU S JJ=1 W !,"Available Procedures within "_ECDN_": ",!
 W ?72,"National",!,?5,"Procedure Name",?40,"Synonym",?72,"Number",!
 S EC1=1
 F   S CNT=$O(^TMP("ECPRO",$J,CNT)) Q:'CNT!$D(ECHOICE)  D:($Y+5>IOSL) SELC Q:$D(ECHOICE)  I X="" W !,CNT_".",?5,$E($P(^TMP("ECPRO",$J,CNT),"^",4),1,30),?38,$E($P(^(CNT),"^",3),1,30),?72,$P(^(CNT),"^",5)
 I X="" D
 .W !!?5,"Select by number, CPT or national code, procedure name, or synonym."
 .W !?5,"Synonym must be preceded by the & character  (example:  &TESTSYN).",!
 .W ?2,"** Modifier(s) can be appended to a CPT code (ex: CPT code-mod1,mod2,mod3) **",!
 Q
 ;
SETP ;set proc info
 S ECP=$P(^TMP("ECPRO",$J,CNT),"^"),ECPN=$P(^(CNT),"^",4),NATN=$P(^(CNT),"^",5),SYN=$P(^(CNT),"^",3),ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP)
 S ECPTCD="" I ECCPT'="" D
 . S ECPTCD=$$CPT^ICPTCOD(ECCPT,ECDT) I +ECPTCD>0 S ECPTCD=$P(ECPTCD,U,2)
 W "  "_$S(ECCPT="":"",1:ECPTCD_" ")_$E(ECPN,1,50)
 W $S(SYN'["NOT DEFINED":" ["_SYN_"]",1:"")_"  (#"_NATN_")",!
 S EC4=$P(^TMP("ECPRO",$J,CNT),"^",2),EC4=$P($G(^ECJ(+EC4,"PRO")),"^",4)
 S EC4N=$S($P($G(^SC(+EC4,0)),"^")]"":$P(^(0),"^"),1:"")
 S ECID=$P($G(^SC(+EC4,0)),"^",7)
 S ^TMP("ECLKUP",$J,"LAST")=CNT
 Q
DIE ;edit record
 I $D(^ECH(DA,0)) S ECPO=$P(^(0),"^",9),$P(^(0),"^",8)=+ECC,$P(^(0),"^",9)=ECP,ECINP=$P(^(0),"^",22),ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP),$P(^ECH(DA,"P"),"^")=ECCPT,ECPR=$P(^(0),"^",3),ECFN=DA,ECDX1=$P($G(^ECH(DA,"P")),U,2) D
 . Q:ECPO=ECP
 . W !,?8,"** Procedure code replaced, all modifiers deleted **"
 . S (ECDA,DA(1))=DA,DIK="^ECH("_DA(1)_",""MOD"",",DA=0
 . F  S DA=$O(^ECH(ECDA,"MOD",DA)) Q:'DA  D ^DIK
 . K DA S DA=ECDA K ECPO,ECDA,DIK,^ECH(DA,"MOD")
 K DIE,DR S DIE("NO^")="OUTOK",DIE="^ECH("
 ;
 S DR=$S($G(ECCPT)'="":"36;",1:"")
 S DR=DR_"9;11//"_ECMN
 D ^DIE K DR
 I $D(DTOUT)!($D(Y)'=0) K DIE S ECOUT=1 Q
 ;
 ;- Don't allow future dates for procedure date/time
 I +$G(ECPR) S Y=ECPR D DD^%DT
 S %DT="EAXR",%DT("A")="DATE/TIME OF PROCEDURE: ",%DT("B")=$S($G(ECPR)&($G(Y)]""):Y,1:""),%DT(0)="-NOW" K Y
 D ^%DT K %DT
 I $D(DTOUT)!($G(Y)=-1) K DTOUT,Y S ECOUT=1 Q
 S DR="2////"_Y,ECNEWDT=Y
 D ^DIE K DR,Y
 ;
 ;- Get inpatient/outpatient status and file in #721
 S ECPTSTAT=$$INOUTPT^ECUTL0(+$G(ECDFN),+$G(ECNEWDT))
 I ECPTSTAT="" D INOUTERR^ECUTL0 Q
 S DR="29////"_ECPTSTAT
 D ^DIE
 K DR
 ;
 ;- Get associated clinic
 I $$CHKDSS^ECUTL0(+$G(ECD),ECPTSTAT) D  Q:+$G(ECOUT)
 . S DR=$S(EC4N]"":"26//"_EC4N,1:"26")
 . D ^DIE
 . K DR
 . I $D(DTOUT)!($D(Y)'=0) K DIE S ECOUT=1
 ;
 ; - Edit Primary and multiple secondary dx codes
 I $P(ECPCE,"~",2)'="N" D DXEDT^ECEDU I ECOUT Q
 ;
 ;- Determine patient eligibility
 I $$CHKDSS^ECUTL0(+$G(ECD),ECPTSTAT) D
 . I '$$MULTELG^ECUTL0(+$G(ECDFN)) S ECELIG=+$G(VAEL(1))
 . E  D
 .. S ECELCOD=+$P($G(^ECH(DA,"PCE")),"~",17)
 .. S ECELDSP=$S(ECELCOD:$P($G(^DIC(8,ECELCOD,0)),"^"),1:"NO ELIGIBILITY ON FILE")
 .. S ECELANS=$$ASKIF^ECUTL0(ECELDSP)
 .. I (ECELANS<1) D
 ... I ECELDSP="NO ELIGIBILITY ON FILE" D ELIGERR^ECUTL0
 ... S ECELIG=$S(ECELDSP="NO ELIGIBILITY ON FILE":+$G(VAEL(1)),1:ECELCOD)
 .. I (ECELANS>0) S ECELIG=+$$ELGLST^ECUTL0
 K ECELANS,ECELCOD,ECELDSP,VAEL,ECNEWDT,ECDX1
 ;
 ;- Display inpatient/outpatient status message
 D DSPSTAT^ECUTL0(ECPTSTAT)
 ;
 ;- Ask classification questions applicable to patient and file in #721
 I $$ASKCLASS^ECUTL1(+$G(ECDFN),.ECCLFLDS,.ECOUT,ECPCE,ECPTSTAT,DA),($O(ECCLFLDS(""))]"") D EDCLASS^ECUTL1(DA,.ECCLFLDS)
 Q:+$G(ECOUT)
 K ECCLFLDS
 ;
 ;- Get provider(s) with active person class
 I '$G(ECOUT) D ASKPRV^ECPRVMUT(DA,ECDT,.ECPRVARY,.ECOUT)
 I '$G(ECOUT) S ECFIL=$$FILPRV^ECPRVMUT(DA,.ECPRVARY,.ECOUT)
 K ECFIL,ECPRVARY,ECPRV,ECPRVN
 I $G(ECOUT)!$D(DTOUT) K DIE S ECOUT=1 Q
 ;
 ;- File assoc clinic from event code screen if null
 I $P($G(^ECH(DA,0)),"^",19)="" D
 . I $G(EC4)="" D GETCLN
 . S EC4=+$G(EC4)
 . I EC4>0 D
 .. S DR="26////^S X=EC4"
 .. D ^DIE K DR
 ;
 ;- Procedure Reason(s)
 I $G(ECP)]"" S ECSCR=+$O(^ECJ("AP",+ECL,+ECD,+ECC,ECP,0))
 I ECSCR>0,($P($G(^ECJ(ECSCR,"PRO")),"^",5)=1),(+$O(^ECL("AD",ECSCR,0))) D  Q:+$G(ECOUT)
 . S DIE="^ECH(",DR="34" D ^DIE K DR,DIE
 . I $D(DTOUT)!($D(Y)'=0) K ECSCR S ECOUT=1 Q
 ;
 K DIE,ECSCR S EC(0)=^ECH(+EC(EC),0),ECFN=+EC(0)
 S ECZZ=$G(^ECH(ECFN,"P")),ECDX=+$P(ECZZ,"^",2),ECCPT=+$P(ECZZ,"^"),ECINP=$P(EC(0),"^",22) K ECZZ
 S EC4=$P(EC(0),"^",19),ECID=$P($G(^SC(+EC4,0)),"^",7),$P(^ECH(ECFN,0),"^",20)=ECID
 I $P(ECPCE,"~",2)="N" G SET
 I ($P(ECPCE,"~",2)="O")&(ECINP'="O") G SET
 D CLIN^ECEDF I 'ECPCL W !!,"You should edit this patient procedure and enter an active clinic.",!!
 W !!,"Press <RET> to continue " R X:DTIME
SET ; sets data 
 S $P(^ECH(DA,0),"^",14)="",$P(^ECH(DA,0),"^",16)="",$P(^ECH(DA,0),"^",18)=""
 S $P(^ECH(DA,0),"^",13)=DUZ,ECU=$P(^(0),"^",11) K DA
 Q:$P(ECPCE,"~",2)="N"  I $P(ECPCE,"~",2)="O"&(ECINP'="O") Q
 D PCEE^ECBEN2U
 Q
DEL ; delete existing procedure
 W !!,"Are you sure that you want to delete this entire procedure from",!,"your records ?  NO// " R X:DTIME I '$T!(X["^") S ECOUT=1 Q
 S X=$E(X) S:X="" X="N" I "NnYy"'[X W !!,"Enter YES to delete this procedure, or <RET> to quit this option." G DEL
 I "Nn"[X Q
 S ECCH=$G(^ECH(+EC(EC),0)),ECVST=+$P(ECCH,"^",21) I 'ECVST G DELP
 ;
 ;* Prepare all EC records with same Visit file entry to resend to PCE
 ;* Remove Visit entry from ^ECH( so DELVFILE will complete cleanup
 N ECVAR1 S ECVAR1=$$FNDVST^ECUTL(ECVST) K ECVAR1  ;* 2nd Param not sent
 ;
 ;- Set VALQUIET to stop Amb Care validator from broadcasting to screen
 S VALQUIET=1,ECVV=$$DELVFILE^PXAPI("ALL",ECVST) K ECVST,VALQUIET
DELP S DA=+EC(EC),DIK="^ECH(" W !!,"Deleting Procedure... " D ^DIK K DA,DIK,ECVV
 ;S ECOUT=99  ;JAM/9/28/01 remove to allow redisplay of screen
 W !!,"Press <RET> to continue " R X:DTIME
 Q
SELC ; select category
 W !!,$S(EC1:"Press",1:"Select Number, or press")_" <RET> to continue listing "_$S(EC1:"procedures",1:"categories")_" or '^' to stop: " R X:DTIME I '$T!(X="^") S (ECSTOP,ECHOICE)=1 Q
 I X="" W @IOF,!,$S(EC1:"Available Procedures",1:"Categories")_" within ",ECDN," : ",! Q
 I 'EC1,'$D(ECC(X)) D MSGC^ECEDU Q
 I EC1,'$D(^TMP("ECPRO",$J,X)) D MSGC^ECEDU Q
 S ECHOICE=1
 I 'EC1 S ECC=+$P(ECC(X),"^"),ECCN=$P(ECC(X),"^",2) Q
 Q
 ;
GETCLN ;- Get assoc clinic from event code screen
 N ECI
 I $G(EC4)="",($G(ECP)]"") D
 . S ECI=+$O(^ECJ("AP",+ECL,+ECD,+ECC,ECP,0)),EC4=+$P($G(^ECJ(+ECI,"PRO")),"^",4)
 . S EC4N=$S($P($G(^SC(+EC4,0)),"^")]"":$P(^(0),"^"),1:"")
 Q
