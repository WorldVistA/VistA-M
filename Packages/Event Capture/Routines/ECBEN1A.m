ECBEN1A ;BIR/JLP,RHK-New Batch Entry ;12 Feb 96
 ;;2.0; EVENT CAPTURE ;**4,5,72**;8 May 96
O ;select ord sect
 W !!,"Location: "_ECLN,!,"DSS Unit:  "_ECDN K DIC,DUOUT
 S DIC=723,DIC(0)="QEAMZ",DIC("A")="Ordering Section: " D ^DIC K DIC I Y<0 S ECOUT=1 Q
 S ECO=+Y,ECON=$P(Y,"^",2)
DATE ;select date
 K %DT S %DT="AEXR"
 I ECDDT="",$G(ECDR)]"" S %DT("B")=ECDR G DATE1
 I ECDDT'="" S %DT("B")=ECDDT
 ;
 ; ALB/ESD - Prevent future dates from being entered
DATE1 S %DT("A")="Procedure Date and Time: ",%DT(0)="-NOW" D ^%DT I Y<0 S ECOUT=1 Q
 S ECDT=+Y,(ECDATE,ECDR)=$$FMTE^XLFDT(ECDT) K %DT
 ;
 ;select provider(s) with active person class
 D ASKPRV^ECPRVMUT("",ECDT,.ECPRVARY,.ECOUT)
 I $G(ECOUT) S ECOUT=1 K ECPRVARY Q
 ;
PAT ;select pat
 D ^ECBEN1B
 K ECPRVARY
END Q
 ;
MSG ;quit msg
 W !!,"No action taken.",!!,"Press <RET> to continue " R X:DTIME S ECOUT=1
 Q
