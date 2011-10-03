PSOLMUTL ;BIR/SAB - listman utilities ;03/07/95
 ;;7.0;OUTPATIENT PHARMACY;**19,46,84,99,131,132,148,268,225,305**;DEC 1997;Build 8
 ;External reference FULL^VALM1 supported by dbia 10116
 ;External reference $$SETSTR^VALM1 supported by dbia 10116
 ;External reference EN2^GMRAPEMO supported by dbia 190
 ;External reference to ^ORD(101 supported by DBIA 872
 ;External reference to RE^VALM4 supported by dbia 10120
 ;
EN W @IOF S VALMCNT=0
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) W $C(7),!!?5,"Site parameter must be defined!",! G INITQ
 D EN^PSOLMPI
INITQ Q
HDR ;patient med profile display
 K VALMHDR S HDR=^TMP("PSOHDR",$J,1,0)
 S:^TMP("PSOHDR",$J,8,0) X=IORVON_"<A>"_IORVOFF,HDR=$$SETSTR^VALM1(X,HDR,80-$L(X),80) S VALMHDR(1)=HDR
 I '(^TMP("PSOHDR",$J,8,0)) S PSONOAL="" D ALLERGY^PSOORUT2 I PSONOAL'="" D  K PSONOAL
 .S X=IORVON_"<NO ALLERGY ASSESSMENT>"_IORVOFF,HDR=$$SETSTR^VALM1(X,HDR,80-$L(X),80) S VALMHDR(1)=HDR
 S HDR="  PID: "_^TMP("PSOHDR",$J,2,0)
 S VALMHDR(2)=$$SETSTR^VALM1("Ht(cm): "_^TMP("PSOHDR",$J,7,0),HDR,52,27)
 S HDR="  DOB: "_^TMP("PSOHDR",$J,3,0)_" ("_^TMP("PSOHDR",$J,4,0)_")"
 S VALMHDR(3)=$$SETSTR^VALM1(" Wt(kg): "_^TMP("PSOHDR",$J,6,0),HDR,51,28)
 S HDR="  SEX: "_$E(^TMP("PSOHDR",$J,5,0),1,44)
 S VALMHDR(4)=HDR
 S $P(VALMHDR(4)," ",30)="  "_$E(^TMP("PSOHDR",$J,5,0),48,80)
 Q:$G(PS)="VIEW"!($G(PS)="DELETE")
 S VALMHDR(5)=$G(^TMP("PSOHDR",$J,9,0))
 S VALMHDR(6)=$G(^TMP("PSOHDR",$J,10,0))
 Q
 ;
NEWALL(DFN) ; Enter Allergy info.
 N PSOID D FULL^VALM1,EN2^GMRAPEM0,^PSOORUT2 S VALMBCK="R"
 Q
NEWSEL ;allows order selection by number instead of action
 S Y=$P(XQORNOD(0),"=",2) N VALMCNT D NEWSEL^PSOORNE2
 Q
EDTSEL ;allows edit selection by number instead of action - active orders
 N VALMCNT S Y=$P(XQORNOD(0),"=",2) D EDTSEL^PSOOREDT
 Q
SELAL ;selection of allergy by number instead of action - select allergy
 N VALMCNT S Y=$P(XQORNOD(0),"=",2) D SELAL^PSOORDA
 Q
EDTNEW ;allows edit selection by number instead of action - new orders
 N VALMCNT S Y=$P(XQORNOD(0),"=",2) D EDTSEL^PSOORNE1
 Q
EDTRNEW ;allows edit selection by number instead of action - renew orders
 N VALMCNT S Y=$P(XQORNOD(0),"=",2) D EDTSEL^PSOORNE4
 Q
EDTPEN ;allows edit selection by number instead of action - pending orders
 N VALMCNT S Y=$P(XQORNOD(0),"=",2),SEDT=1 G EDTSEL^PSOORNEW
 Q
HLDHDR ;keeps patient's header info
 S IOTM=VALM("TM"),IOBM=IOSL W IOSC W @IOSTBM W IORC
 Q
 ;
BYPASS S:$G(PSOFDR) SIGOK=1 S Y=-1,VALMBCK="Q"
 Q
ACTIONS() ;screen actions on active orders
 Q:$G(PKI1)=2 0
 N DIC,X,Y K DIC,Y S DIC="^ORD(101,"_DA(1)_",10,",X=DA,DIC(0)="ZN" D ^DIC Q:Y<0 0
 S Y=Y(0,0)
 I Y="PSO REFILL" Q $S(PSOACT["R":1,1:0)
 I Y="PSO RENEW" Q $S(PSOACT["N":1,1:0)
 I Y="PSO REPRINT" Q $S(PSOACT["P":1,1:0)
 I Y="PSO EDIT ORDERS" Q $S(PSOACT["E":1,1:0)
 I Y="PSO RELEASE" Q $S(PSOACT["L":1,1:0)
 I Y="PSO PARTIAL" Q $S(PSOACT["T":1,1:0)
 I Y="PSO CANCEL" Q $S(PSOACT["D":1,1:0)
 I Y="PSO HOLD" Q $S(PSOACT["H":1,1:0)
 I Y="PSO UNHOLD" Q $S(PSOACT["U":1,1:0)
 I Y="PSO LM BACKDOOR COPY" Q $S(PSOACT["C":1,1:0)
 I Y="PSO VERIFY" Q $S(PSOACT["V":1,1:0)
 I Y="PSO ACTIVITY LOGS" Q 1
 Q 1
ACTIONS1() ;screen actions on pending orders
 Q:$G(PKI1)=2 0
 N DIC,X,Y K DIC,Y S DIC="^ORD(101,"_DA(1)_",10,",X=DA,DIC(0)="ZN" D ^DIC Q:Y<0 0
 S Y=Y(0,0)
 I Y="PSO LM DISCONTINUE" Q $S(PSOACT["D":1,1:0)
 I Y="PSO LM EDIT" Q $S(PSOACT["E":1,1:0)
 I Y="PSO LM FINISH" Q $S(PSOACT["F":1,1:0)
 I Y="PSO LM FLAG" Q $S(PSOACT["X":1,1:0)
 Q 1
PKIACT() ;screen actions on pending orders DEA/PKI proj.
 Q:$G(PKI1)=2 0
 Q 1
RFDSP ;screen action to toggle display of prescriptions between LAST FILL date and LAST RELEASE Date.
 S PSORFG='$G(PSORFG)
 I '$D(PSOSD) D ^PSOBUILD
 D ^PSOORUT2,BLD^PSOORUT1
 K VALMHDR
 D RE^VALM4
 Q
