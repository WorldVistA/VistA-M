IBCEP9B ;ALB/TMP - UPDATE OF PROVIDER ID FROM FILE UTILITIES ;14-NOV-00
 ;;2.0;INTEGRATED BILLING;**137,200,320**;21-MAR-94
 ;
 Q
 ;
READFILE ; Read records stored in ^TMP($J
 ;
 N D,DA,DIC,IBCT,IBP,IBQUIT,IBS,IBX,P,P3,X,Y,Z
 S (IBCT,IBQUIT,IBQUIT1,IBS)=0
 U IO(0)
 ;
 F  S IBCT=$O(^TMP($J,IBCT)) Q:'IBCT  S X=$G(^(IBCT)) I X'="" D  Q:IBQUIT
 . D  Q:IBQUIT
 .. I $P($G(IBPOS),U)="D" D
 ... D CSV(X,.IBX,$P(IBPOS,U,2),$P(IBPOS,U,3))
 ... D DSETUP(.IBX,.IBPOS,.P) K IBX
 .. I $P($G(IBPOS),U)'="D" D FSETUP(X,.IBPOS,.P)
 . ;
 . I $G(P(1))'="" S P(1)=$$NOPUNCT^IBCEF(P(1),1),X=P(1),D="SSN",DIC="^VA(200,",DIC(0)="" D IX^DIC
 . S IBP=+Y,IBVNAME=$P(Y,U,2)
 . I $S($G(P(1))="":1,1:Y'>0) D  Q
 .. S ^TMP("IBPID-ERR",$J,1,$S($G(P(1))'="":P(1),1:"NO SSN"),$G(P(2))_" ","??")=""
 .. N IBID
 .. S IBID=$S(IBFT=0!(IBFT=1):$G(P("INST_ID")),1:$G(P("PROF_ID")))
 .. S ^TMP("IBPID-ERR",$J,1,$S($G(P(1))'="":P(1),1:"NO SSN"),$G(P(2))_" ","PROV ID")=IBID
 . ;
 . S ^TMP("IBPID_IN",$J,U,IBP)=P(1)_U_P(2)_U_IBVNAME
 . F Q0=0,"TID","UPIN","INST_ID","PROF_ID","CU","CRED" S ^TMP("IBPID_IN",$J,U,IBP,Q0)=$G(P(Q0))
 Q
 ;
CSV(X,IBX,IBDEL,IBQUOTES) ; Parse out fields from a delimited file
 ; X = data string in CSV format to be parsed
 ; IBX = array returned if passed by reference, subscripted by field #
 ; IBDEL = the delimiter
 ; If IBQUOTES=1, quoted strings are double quoted within a field
 N FC,I,PC,QCT,QM,QM2,QM4,STR,TPC
 S FC=0,TPC=$L(X,IBDEL),QM=$C(34),QM2=QM_QM,QM4=QM2_QM2
 F PC=1:1:TPC D
 . S STR=$P(X,IBDEL,PC)
 . S FC=FC+1
 . I (STR=QM2)!(STR=QM4) S IBX(FC)="" Q
 . I $E(STR,1)=QM D
 .. F QCT=0:1 Q:$E(STR,QCT+1)'=QM
 .. F  Q:($E(STR,1,QCT)=$E(STR,$L(STR)-(QCT-1),$L(STR)))  S PC=PC+1 Q:PC>TPC  S STR=STR_IBDEL_$P(X,IBDEL,PC)
 .. I PC>TPC S IBX(0)="-1^UNMATCHED QUOTE MARKS" Q
 .. F  Q:$E(STR,1)'=QM  I $E(STR,$L(STR))=QM S STR=$E(STR,2,$L(STR)-1)
 . I IBQUOTES,STR[QM2 D
 .. F I=1:1:$L(STR) I $E(STR,I,I+1)=QM2 S STR=$E(STR,1,I)_$E(STR,I+2,9999)
 . S IBX(FC)=STR
 Q
 ;
MANUAL ; Manual entry to get providers from VistA
 N IBCRED,IBDA,IBNAM,IBSSN
 ; S IBCNT=0 ; this looks like extraneous code, IBCNT not used anywhere.
 F  D  I X=""!(X["^") Q
 . S Y=$$LOOKUP^XUSER Q:X=""  I X["^" S IBQUIT1=1 Q
 . S IBDA=+Y,IBNAM=$P(Y,U,2)
 . S IBSSN=$$GET1^DIQ(200,IBDA_",",9,"I")
 . S IBCRED=$$GET1^DIQ(200,IBDA_",",10.6,"I")
 . S ^TMP("IBPID_IN",$J,U,IBDA)=IBSSN_U_IBNAM_" "_IBCRED
 Q
 ;
DIR1(DIR,Z,IBQUIT,IBQUIT1) ; Ask position
 N X,Y
 S Y=$$DIR^IBCEP9(.DIR,.IBQUIT,.IBQUIT1)
 I IBQUIT1 S Y="" G DIRQ
 I $P(Z,U,4),Y'>0 S Y="",(IBQUIT1,IBQUIT)=1
 I Y'>0 S Y=""
DIRQ Q Y
 ;
DISP(Q,IBID,IBINS,IBPTYP,IBFT,IBCT,IBCU,IBPID,IBSRC) ; Display provider data
 ;  includes ID data if IBID=1
 ; Q = SSN^provider name from input^provider name from file #200
 ; IBPID = array of id numbers to be stored
 N A,IBL,Q0,Z
 S $P(Q,U,2)=$$FLEN($P(Q,U,2))
 S Q0(1)="PROVIDER : "_$P(Q,U)_$S($P(Q,U,2)'="":" ("_$P(Q,U,2)_")",1:"")_$S(IBSRC="F":" <- input file data",1:"")
 S Q0(2)="" S:IBSRC="F" Q0(2)=$J("("_$P(Q,U,3),22+$L($P(Q,U,3)))_") <- VA match"
 S IBL=0
 D DISP^IBCEP4("Q0",IBINS,IBPTYP,IBFT,IBCT,3,.IBL)
 I $G(IBCU)'="" S Q0(IBL+1)="CARE UNIT: "_IBCU
 W !
 S A=0 F  S A=$O(Q0(A)) Q:'A  W !,Q0(A)
 I $G(IBID),$O(IBPID(""))'="" D  ; Display id's to be filed
 . W ! S Z="" F  S Z=$O(IBPID(Z)) Q:Z=""  I IBPID(Z)'="" D
 .. W !,$S(Z="TID":"TAX ID NUMBER",Z="INST_ID":"INSTITUTIONAL ID",Z="PROF_ID":"PROFESSIONAL ID",Z="UPIN":"UPIN",1:"PROV ID"),": ",IBPID(Z)
 Q
 ;
DSETUP(IBX,IBPOS,P) ; Set up the subscripted array P with the correct data
 ; from IBX(pc #) based on the parameters in array IBPOS
 ; RETURNED: P(data index)=data value (pass by reference)
 N Q,Z,Z0
 S Z=$G(IBPOS("SSN")),P(1)=""
 F Z0=+Z:1:$S('$P(Z,U,2):Z,1:$P(Z,U,2)) S P(1)=P(1)_$S(P(1)'=""&($G(IBX(Z0))'=""):" ",1:"")_$G(IBX(Z0))
 S Z=$G(IBPOS("NAM")),P(2)=""
 F Z0=+Z:1:$S('$P(Z,U,2):Z,1:$P(Z,U,2)) S P(2)=P(2)_$S(P(2)'=""&($G(IBX(Z0))'=""):" ",1:"")_$G(IBX(Z0))
 F Q="TID","UPIN","INST_ID","PROF_ID","CRED","CU","LIC" D
 . S Z=$G(IBPOS(Q)),P(Q)=""
 . Q:'Z
 . F Z0=+Z:1:$S('$P(Z,U,2):Z,1:$P(Z,U,2)) S P(Q)=P(Q)_$S(P(Q)'=""&($G(IBX(Z0))'=""):" ",1:"")_$G(IBX(Z0))
 Q
 ;
FSETUP(X,IBPOS,P) ;Set up the subscripted array P with the correct data
 ; from record data in X, based on the parameters in array IBPOS for a
 ; fixed length data field format
 ; RETURNED: P(data index)=data value (pass by reference)
 ;
 N Q,Z
 S Z=$G(IBPOS("SSN")),P(1)=""
 S P(1)=$E(X,+Z,$S($P(Z,U,2):$P(Z,U,2),1:+Z))
 S Z=$G(IBPOS("NAM")),P(2)=""
 S P(2)=$E(X,+Z,$S($P(Z,U,2):$P(Z,U,2),1:+Z))
 F Q="TID","UPIN","INST_ID","PROF_ID","CRED","CU","LIC" D
 . S Z=$G(IBPOS(Q)),P(Q)=""
 . Q:'Z
 . S P(Q)=$$FLEN($E(X,+Z,$S($P(Z,U,2):$P(Z,U,2),1:+Z)))
 Q
 ;
FLEN(IBX) ; Strip out trailing spaces from field
 ; FUNCTION returns stripped data
 N Z,IB,IB1
 S IB1=IBX,IB=$TR(IB1," ")
 I IB'="" F Z=$L(IB1):-1:1 I $E(IB1,Z)'=" " S IB=$E(IB1,1,Z) Q
 Q IB
 ;
ADDID(IB200,IBINS,IBCU,IBFT,IBCT,IBPTYP,IBQUIT,IBQUIT1) ; Add ID record (file 355.9) if not already there
 N DIC,X,Y,DO,DD,DLAYGO,DIR
 S X=IB200_";VA(200,"
 S Y=+$O(^IBA(355.9,"AUNIQ",X,$S(IBINS:IBINS,1:"*ALL*"),$S($G(IBCU)'="":IBCU,1:"*N/A*"),IBFT,IBCT,IBPTYP,0))
 I 'Y D
 . S DIC(0)="L",DIC="^IBA(355.9,",DLAYGO=355.9,DIC("DR")=".02////"_IBINS_$S($G(IBCU)'="":";.03////"_IBCU,1:"")_";.04////"_IBFT_";.05////"_IBCT_";.06////"_IBPTYP
 . D FILE^DICN K DIC,DO,DD,DLAYGO
 I Y'>0 D  Q
 . S DIR(0)="AE",DIR("A",1)="A PROBLEM WAS ENCOUNTERED ADDING THIS PROVIDER ID RECORD - NO RECORD ADDED",DIR("A")="PRESS ENTER TO CONTINUE "
 . S Y=$$DIR^IBCEP9(.DIR,.IBQUIT,.IBQUIT1,,1,1)
 S IBN=Y
 Q $S(IBN>0:IBN,1:0)
 ;
PRTERR ; Prints error report
 N IBPAGE,Z,Z0,Z1,Z2,Z3,IBLCT,IBSTOP,IBHDT
 W:$E(IOST,1,2)["C-" @IOF
 I $D(^TMP("IBPID-ERR",$J)) D
 . S IBSTOP=0,IBLCT=$$HDR(.IBPAGE,.IBSTOP,.IBHDT)
 . S Z=0 F  S Z=$O(^TMP("IBPID-ERR",$J,Z)) Q:'Z  W !!,$P($T(ERR+Z^IBCEP9),";;",2)_":" D
 .. S Z0=""
 .. F  S Z0=$O(^TMP("IBPID-ERR",$J,Z,Z0)) Q:Z0=""  S IBLCT=IBLCT+1 S:(IBLCT+5)>IOSL IBLCT=$$HDR(.IBPAGE,.IBSTOP) Q:IBSTOP  D
 ... S Z1="" F  S Z1=$O(^TMP("IBPID-ERR",$J,Z,Z0,Z1)) Q:Z1=""  W !,$E(Z0_$J("",9),1,9) W:$P(Z1,U)'="" "  "_$E($P(Z1,U)_$J("",40),1,40) D
 .... S Z2="" F  S Z2=$O(^TMP("IBPID-ERR",$J,Z,Z0,Z1,Z2)) Q:Z2=""  S Z3=$G(^(Z2)) I Z3'="" D
 ..... W "  "_$S(Z2="CU":"CARE UNIT",Z2="CRED":"CREDENTIALS",Z2="TID":"TAX ID #",Z2="LIC_ST":"LICENSE STATE",Z2="LIC":"LICENSE",Z2="UPIN":"UPIN",1:Z2)_": "_Z3
FILED ; Prints all filed records
 I $D(^TMP("IBPID_IN",$J)) D
 . S IBSTOP=0,IBLCT=$$HDR(.IBPAGE,.IBSTOP,.IBHDT)
 . W !!," RECORDS SELECTED FOR FILING:"
 . S Z0=""
 . F  S Z0=$O(^TMP("IBPID_IN",$J,U,Z0)) Q:Z0=""  S IBLCT=IBLCT+1 S:(IBLCT+5)>IOSL IBLCT=$$HDR(.IBPAGE,.IBSTOP) Q:IBSTOP  D
 .. I $G(^TMP("IBPID_IN",$J,U,Z0,0))="NO PRINT" S:IBLCT>6 IBLCT=IBLCT-1 Q
 .. S Z=^TMP("IBPID_IN",$J,U,Z0)
 .. W !,$P(Z,U,1),?12,$P(Z,U,2),?52,$G(^TMP("IBPID_IN",$J,U,Z0,"INST_ID"))
 ;
 I $E(IOST,1,2)["C-",'IBSTOP K DIR S DIR(0)="E" D ^DIR K DIR
 W @IOF
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) W ! D ^%ZISC
 Q
HDR(PG,IBSTOP,IBHDT) ; Prints error report header, function returns # of lines used
 ; PG = the last page # printed
 ; IBHDT = the run date of the report
 N Z,IBLCT
 S IBLCT=0
 I '$G(PG) S IBHDT="RUN DATE: "_$$FMTE^XLFDT($$NOW^XLFDT(),2)_U_"RUN BY: "_$P($G(^VA(200,+$G(IBDUZ),0)),U)
 I $G(PG),$E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR S IBSTOP=('Y) G:IBSTOP HDRQ  W @IOF
 S PG=$G(PG)+1
 W $J("",23)_"BATCH UPDATE OF PROVIDER ID REPORT"_$J("",13)_"PAGE: ",PG
 W !,$J("",(80-$L($P($G(IBHDT),U)))\2),$P($G(IBHDT),U)
 W !,$J("",(80-$L($P($G(IBHDT),U,2)))\2),$P($G(IBHDT),U,2)
 W !!,"    INSURANCE CO: "_$P($G(^DIC(36,+$G(IBINS),0)),U)
 W !,"PROVIDER ID TYPE: "_$P($G(^IBE(355.97,+$G(IBPTYP),0)),U)
 W !,"       FORM TYPE: "_$$EXPAND^IBTRE(355.91,.04,$G(IBFT))
 W !,"       CARE TYPE: "_$$EXPAND^IBTRE(355.91,.05,$G(IBCT))
 S IBLCT=7
 I $G(IBCU)'="" W !,$J("",7)_"CARE UNIT: "_IBCU S IBLCT=IBLCT+1
 S Z="",$P(Z,"=",81)="",IBLCT=IBLCT+1
 W !,Z
HDRQ Q $G(IBLCT)
 ;
LOCK(IBINS) ; Lock Parent and Children up
 N IBQUIT
 S IBQUIT=0
 I $P($G(^DIC(36,IBINS,3)),U,13)="P" D
 . L +^DIC(36,IBINS):5 E  S IBQUIT=1 Q
 . N CHILD
 . S CHILD="" F  S CHILD=$O(^DIC(36,"APC",IBINS,CHILD)) Q:'+CHILD  D  Q:IBQUIT
 .. L +^DIC(36,CHILD):5 E  S IBQUIT=1
 Q IBQUIT
 ;
UNLOCK(IBINS) ; Unlock the family
 I $P($G(^DIC(36,IBINS,3)),U,13)="P" D
 . L -^DIC(36,IBINS)
 . N CHILD
 . S CHILD="" F  S CHILD=$O(^DIC(36,"APC",IBINS,CHILD)) Q:'+CHILD  D
 .. L -^DIC(36,CHILD)
 Q
 ;
