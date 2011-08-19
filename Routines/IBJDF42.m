IBJDF42 ;ALB/RB - FIRST PARTY FOLLOW-UP REPORT (PRINT);15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,204**;21-MAR-94
 ;
EN ; - Print the Follow-up report.
 ;
 S IBCT(1)="INELIGIBLE",IBCT(2)="EMERG/HUMAN.",IBCT(18)="C MEANS TEST"
 S IBCT(22)="RX COPAY/SC",IBCT(23)="RX COPAY/NSC"
 S IBCT(33)="ADHC LTC"
 S IBCT(34)="DOM LTC"
 S IBCT(35)="RESPITE INPT LTC"
 S IBCT(36)="RESPITE OPT LTC"
 S IBCT(37)="GERIATRIC INPT LTC"
 S IBCT(38)="GERIATRIC OPT LTC"
 S IBCT(39)="NURSING HOME LTC"
 ;
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%) G:IBRPT="S" SUM
 S IBPRTFLG=0 D DET D PAUSE:'IBPRTFLG I IBQ!'IBPRTFLG G ENQ
 ;
 D PAUSE I IBQ G ENQ
 ;
SUM I 'IBQ D PRT^IBJDF43 ; Print summary.
ENQ K IB0,IBAI,IBC,IBCAT,IBCD,IBC1,IBC2,IBCT,IBCNT,IBN,IBP,IBPAG,IBQ,IBRUN,IBS
 K IBST,IBTOT,%,DFN,IBPRTFLG
 Q
 ;
DET ; - Print report for a specific category.
 ;
 D HDR1 G:IBQ DETQ
 S (IBPT,IB,IBCAT,IB0)=""
 F  S IBPT=$O(^TMP("IBJDF4",$J,IBPT)) Q:IBPT=""  D  Q:IBQ
 . I $O(^TMP("IBJDF4",$J,IBPT,0))="" Q
 . S IBP=$G(^TMP("IBJDF4",$J,IBPT))
 . I $Y>(IOSL-14) D PAUSE Q:IBQ  D HDR1 Q:IBQ
 . D WPAT
 . F IB=16,19 D  Q:IBQ
 . . I IBSTA="A",IB'=16 Q
 . . I IBSTA="S",IB=16 Q
 . . I '$D(^TMP("IBJDF4",$J,IBPT,IB)) D  Q
 . . . I $Y>(IOSL-5) D PAUSE Q:IBQ  D HDR1,WPAT,HDR2 Q:IBQ
 . . . W !,"-> NO "_$S(IB=16:"ACTIVE",1:"SUSPENDED")_" BILLS."
 . . I $Y>(IOSL-9) D PAUSE Q:IBQ  D HDR1,WPAT Q:IBQ
 . . D HDR2
 . . K IBFLG S IBTOT="",IBCNT=0
 . . F  S IBCAT=$O(^TMP("IBJDF4",$J,IBPT,IB,IBCAT)) Q:IBCAT=""  D  Q:IBQ
 . . . F  S IB0=$O(^TMP("IBJDF4",$J,IBPT,IB,IBCAT,IB0)) Q:IB0=""  D  Q:IBQ
 . . . . S IBN=$G(^TMP("IBJDF4",$J,IBPT,IB,IBCAT,IB0))
 . . . . I $Y>(IOSL-5) D PAUSE Q:IBQ  D HDR1,WPAT,HDR2 Q:IBQ
 . . . . D WBIL Q:IBQ
 . . . . S IBCNT=IBCNT+1
 . . . I 'IBQ,$O(^TMP("IBJDF4",$J,IBPT,IB,IBCAT))="" D
 . . . . D TOT W !
 . . ; - Display bill comment history, if selected.
 . . S IBPRTFLG=1
 . . D WCOM(IBPT,IB)
 ;
 I 'IBPRTFLG D
 . W !!!!!!,"There are no receivables for the parameters entered."
 ;
DETQ Q
 ;
WPAT ; - Write patient data.
 N I,X
 S DFN=$P(IBPT,"@@",2),IBAI=$G(^TMP("IBJDF4",$J,IBPT,0,"A"))
 W !!,"Patient Name     : ",$P(IBP,U) W:IBAI["V" " *"
 W ?63,"SSN: ",$$SSN($P(IBP,U,2)),!,"Means Test Status: ",$P(IBP,U,4)
 W:$P(IBP,U,5)'="" " ("_$P(IBP,U,5)_")"
 W ?58,"Medicaid: ",$$GET1^DIQ(2,DFN,.381)
 W !,"RX Copay Status  : ",$P(IBP,U,6)
 W:$P(IBP,U,7)'="" " ("_$P(IBP,U,7)_")"
 W:$P(IBP,U,8) ?53,"Date of Death: ",$$DAT1^IBOUTL($P(IBP,U,8))
 W !,"Eligibilities    : " S X=$$ELIG($P(IBP,U,3))
 F I=1:1 Q:X=""  W ?19,$E(X,1,61) S X=$E(X,62,999) I X'="" W !
 S X=$$INFO(IBAI)
 I X'="" D
 . W !,"Additional Info  : "
 . F I=1:1 Q:X=""  W ?19,$E(X,1,61) S X=$E(X,62,999) I X'="" W !
 ;
 Q
 ;
WBIL ; - Write bill data.
 W ! W:'$D(IBFLG(IBCAT)) IBCT(IBCAT) W ?13,IB0
 W:$P(IBN,"^",6) ?25,$J("("_$P(IBN,"^",6)_")",4)
 W ?30,$$DAT1^IBOUTL(+IBN)
 W ?39,$J($FN($P(IBN,U,2),",",2),10),?50,$J($FN($P(IBN,U,3),",",2),10)
 W ?61,$J($FN($P(IBN,U,4),",",2),9),?71,$J($FN($P(IBN,U,5),",",2),9)
 S $P(IBTOT,"^")=$P(IBTOT,"^")+$P(IBN,U,2)
 S $P(IBTOT,"^",2)=$P(IBTOT,"^",2)+$P(IBN,U,3)
 S $P(IBTOT,"^",3)=$P(IBTOT,"^",3)+$P(IBN,U,4)
 S $P(IBTOT,"^",4)=$P(IBTOT,"^",4)+$P(IBN,U,5)
 S IBFLG(IBCAT)=""
 Q
 ;
WCOM(IBPT,IB) ; - Write bill comments.
 N CMDT,CONT,DIWL,DIWR,IBIDX,IBTR,IBLN,IBX,X
 ;
 S (IBIDX,IBTR,IBLN)="",DIWL=1,DIWR=64 K ^UTILITY($J,"W")
 F  S IBIDX=$O(^TMP("IBJDF4",$J,IBPT,0,"C",IB,IBIDX)) Q:IBIDX=""  D  Q:IBQ
 . I $Y>(IOSL-6) D WCPB Q:IBQ
 . D WCD(IBIDX)
 . F  S IBTR=$O(^TMP("IBJDF4",$J,IBPT,0,"C",IB,IBIDX,IBTR)) Q:IBTR=""  D  Q:IBQ
 . . S CMDT=$G(^TMP("IBJDF4",$J,IBPT,0,"C",IB,IBIDX,IBTR))
 . . I $Y>(IOSL-4) D WCPB Q:IBQ
 . . S CONT=0 D WCD(,1,)
 . . F  S IBLN=$O(^TMP("IBJDF4",$J,IBPT,0,"C",IB,IBIDX,IBTR,IBLN)) Q:IBLN=""  D  Q:IBQ
 . . . S IBX=$G(^TMP("IBJDF4",$J,IBPT,0,"C",IB,IBIDX,IBTR,IBLN))
 . . . I $E(IBX)=" ",$L(IBX)>1 S $E(IBX)=""
 . . . S X=IBX D ^DIWP
 . . . I 'CONT,$L(IBX)<66 D WCTX
 . . . S CONT=$L(IBX)>65
 . . . I '$O(^TMP("IBJDF4",$J,IBPT,0,"C",IB,IBIDX,IBTR,IBLN)) D
 . . . . D:$D(^UTILITY($J,"W")) WCTX
 K ^UTILITY($J,"W")
 Q
 ;
WCD(I,D,C) ; - Write the comment date.
 ; Input: I - Index #         "(I)"
 ;        D - Print the Date  " - MM/DD/YY"
 ;        C - Print the Cont. "(Continued)"
 ;
 W:$G(I) !,"(",I,")" W:$G(D) ?3," - ",$$DAT1^IBOUTL(CMDT),": "
 W:$G(C) "(Continued)",!
 Q
 ;
WCTX ; - Write the comment text.
 N LIN,WLIN,Z
 S LIN=""
 F  S LIN=$O(^UTILITY($J,"W",1,LIN)) Q:LIN=""  D  Q:IBQ
 . S WLIN=$G(^UTILITY($J,"W",1,LIN,0)) Q:WLIN=""
 . W ?16,WLIN
 . I '$O(^UTILITY($J,"W",1,LIN)) W ! Q
 . I $Y>(IOSL-4) D WCPB,WCD(IBIDX,1,1) Q
 . W !
 K ^UTILITY($J,"W")
 Q
 ;
WCPB ; - Page Break in the middle of the Comments
 D PAUSE Q:IBQ  D HDR1,WPAT W !!
 Q
 ;
HDR1 ; - Write the report header.
 N X,I
 W:'$G(IBPAG) ! I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1 W "First Party Follow-Up Report"
 W ?34,"Run Date: ",IBRUN,?71,"Page: ",$J(IBPAG,3)
 S X="ALL "_$S(IBSTA'="S":"ACTIVE",1:"")_$S(IBSTA="B":" AND ",1:"")
 S X=X_$S(IBSTA'="A":"SUSPENDED",1:"")_$$TYPE(IBSEL)_" RECEIVABLES"
 I IBSMN'="A" S X=X_" OVER "_IBSMN_" AND UNDER "_IBSMX_" DAYS OLD"
 S X=X_" / BY "_$S(IBSN="N":"NAME",1:"LAST 4 SSN")
 S X=X_" ("_$S($G(IBSNA)="ALL":"ALL",1:"From "_$S(IBSNF="":"FIRST",1:IBSNF)_" to "_$S(IBSNL="zzzzz":"LAST",1:IBSNL))_")"
 S X=X_" / "_$S('IBSAM:"NO ",1:"")_"MINIMUM BALANCE"
 S X=X_$S(IBSAM:": $"_$FN(IBSAM,",",2),1:"")
 S X=X_" / "_$S('IBSH:"NO ",IBSH1="A":"ALL ",1:"ONLY ")_"COMMENTS"
 S X=X_$S($G(IBSH2):" LESS THAN "_IBSH2_" DAYS OLD",1:"")
 S X=X_" / RECEIVABLES REFERRED TO RC "_$S('IBSRC:"NOT ",1:"")_"INCLUDED"
 F I=1:1 W !,$E(X,1,80) S X=$E(X,81,999) I X="" Q
 ;
 S IBQ=$$STOP^IBOUTL("First Party Follow-Up Report")
 Q
 ;
TYPE(SEL) ; Returns a string with the type of receivables (description)
 ; selected or NULL if ALL receivable type have been selected.
 ; SEL - User input for the parameter "Type of Receivable"
 ;
 N TYPE,I,X
 I SEL="1,2,3," Q ""
 S TYPE="",X="EMERGENCY/HUMANITARIAN^INELIGIBLE^C-MEANS TEST & RX COPAY"
 F I=2:1:($L(SEL,",")-1) D
 . S TYPE=TYPE_$S(I=($L(SEL,",")-1)&(TYPE'=""):" AND ",1:", ")
 . S TYPE=TYPE_$P(X,"^",+$P(SEL,",",I))
 S $E(TYPE,1)=""
 ;
 Q TYPE
 ;
HDR2 ; - Write bill sub-header.
 W ! I IBSTA="B" W !,$S(IB=16:"ACTIVE",1:"SUSPENDED")
 W ! I IBSTA="B" W $S(IB=16:"======",1:"=========")
 W:IBSH ?26,"COM" W ?30,"Last",?40,"Current",?51,"Principal"
 W !,"Category",?13,"Bill Number",?26,"REF"
 W ?30,"Payment",?40,"Balance",?51,"Balance",?62,"Interest",?72,"Admin."
 W !,$$DASH(80,1)
 Q
 ;
TOT ; - Write balance total for patient.
 N I,J
 I IBCNT>1 W ! F I=40,51,62,72 W ?I,$E("---------",1,$S(I>60:8,1:9))
 W:IBCNT'>1 !
 W !,"Account Balance: $"_$FN($P(IBP,"^",10),",",2)
 I IBCNT'>1 Q
 S J=1 F I=39,50,60,70 W ?I,$J($FN($P(IBTOT,"^",J),",",2),10) S J=J+1
 Q
 ;
DASH(X,Y) ; - Return a dashed line.
 Q $TR($J("",X)," ",$S(Y:"-",1:"="))
 ;
ELIG(X) ; - Return eligibility code name.
 ; X - Eligibility codes separated by semi-collon (;)
 ;
 N ELIG,I
 S ELIG="" F I=1:1:$L(X,";") D
 . I '$P(X,";",I) Q
 . S ELIG=ELIG_", "_$E($P($G(^DIC(8,+$P(X,";",I),0)),U),1,20)
 S $E(ELIG,1,2)=""
 ;
 Q ELIG
 ;
INFO(X) ; - Return the patient Additional Information about the Patient Accout
 ; X - Flags representing the observations
 ;
 N INFO,I
 S INFO="" F I=1:1:$L(X) D
 . I $E(X,I)="V" S INFO=INFO_", '*' - VA EMPLOYEE"
 . I $E(X,I)="R" S INFO=INFO_", REFERRED TO RC"
 . I $E(X,I)="D" S INFO=INFO_", REFERRED TO DMC"
 . I $E(X,I)="T" S INFO=INFO_", REFERRED TO TOP"
 . I $E(X,I)="P" S INFO=INFO_", UNDER REPAYMENT PLAN"
 . I $E(X,I)="F" S INFO=INFO_", UNDER DEFAULTED REPAYMENT PLAN"
 S $E(INFO,1,2)=""
 ;
 Q INFO
 ;
SSN(X) ; - Format the SSN.
 Q $S(X]"":$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),1:"")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
