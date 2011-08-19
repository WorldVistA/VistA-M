PSORMRXD ;BIRM/JAM - REMOTE DATA INTEROPERABILITY UTILITY ; 10/29/08
 ;;7.0;OUTPATIENT PHARMACY;**320**;DEC 1997;Build 2
 ;;
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(PSOSEL) ;- ListManager entry point
 ;
 D EN^VALM("PSO RDI VISITS DETAIL")
 D FULL^VALM1
 G EXIT
 ;
HDR ; Patient Header for remote site
 D HDR^PSORMRX
 I PSOSEL="DO" S VALM("TITLE")="Medication Profile - Remote"
 I PSOSEL="DB" S VALM("TITLE")="Medication Profile - Both"
 Q
 ;
INIT ; - Populates the Body section for ListMan
 S VALMCNT=0
 D DETAIL
 S VALMSG="Enter ?? for more actions"
 Q
 ;
DETAIL ; Build prescription details for local site
 N SEQ,ST,DRG,DATA,NODE0,NODE1,PSOX,ISDT,QTY,LFDT,PSOSD,PSODTCUT,LINE,RX
 N FSIG,PRVDR,SIG,STA,LC,CNT
 ; - get the last sequence number for remote prescriptions
 S SEQ=$O(^TMP("PSORDI",$J,"A"),-1)
 I PSOSEL="DO" S VALMCNT=$S(SEQ:SEQ,1:1) D  Q
 .; if no remote sites, set display reasons if available
 .I '+$O(^TMP("PSORDI",$J,0)),$D(^TMP($J,"PSORDI",1)) S LC="",CNT=0 D
 ..F  S LC=$O(^TMP($J,"PSORDI",LC)) Q:LC=""  D
 ...S CNT=CNT+1,^TMP("PSORDI",$J,CNT,0)="  "_$G(^TMP($J,"PSORDI",LC,0))
 ; get local prescriptions
 S PSODTCUT=$$FMADD^XLFDT(DT,-90)
 D ^PSOBUILD
 I +SEQ<1 S SEQ=0
 I SEQ>1 S LINE="" D SETTMP
 I $D(PSOSD) D
 .S LINE="LOCAL PRESCRIPTIONS" D SETTMP
 S (LINE,ST)=""
 F  S ST=$O(PSOSD(ST)) Q:ST=""  D
 .S (LINE,DRG)="" F  S DRG=$O(PSOSD(ST,DRG)) Q:DRG=""  D
 ..S DATA=PSOSD(ST,DRG)
 ..S NODE0=$G(^PSRX(+$P(DATA,"^"),0)),LFDT=+$G(^(3)) I NODE0="" Q
 ..S STA=$$STACHK^PSORMRX(ST,$P($G(^PSRX(+$P(DATA,"^"),2)),"^",6))
 ..I '+STA Q
 ..S STA=$P(STA,"^",2)
 ..S LINE=$P(NODE0,"^"),$E(LINE,15)=$E(DRG,1,34)
 ..S $E(LINE,50)=$S(STA="DISCONTINUED":"DC",1:$E(STA))
 ..S QTY=$P(NODE0,"^",7),ISDT=$P(NODE0,"^",13)
 ..S $E(LINE,53)=$J(+QTY,4),$E(LINE,60)=$$FMTE^XLFDT(ISDT,"2ZM")
 ..F PSOX=0:0 S PSOX=$O(^PSRX(+$P(DATA,"^"),1,PSOX)) Q:'PSOX  D
 ...S NODE1=$G(^PSRX(+$P(DATA,"^"),1,PSOX,0))
 ...I +NODE1=LFDT,$P(NODE1,"^",16) S LFDT=LFDT_"^R"
 ..I '$O(^PSRX(+$P(DATA,"^"),1,0)),$P($G(^PSRX(+$P(DATA,"^"),2)),"^",15) D
 ...S LFDT=LFDT_"^R"
 ..S $E(LINE,70)=$$FMTE^XLFDT(LFDT,"2ZM")
 ..D SETTMP
 ..K FSIG D GETSIG
 ..S LINE="",$E(LINE,15)="SIG: ",SIG=0
 ..F  S SIG=$O(FSIG(SIG)) Q:'SIG  D
 ...S $E(LINE,20)=FSIG(SIG) D SETTMP S LINE=""
 ..I $O(FSIG(""))="" D SETTMP
 ..S PRVDR=$P($G(^PSRX(+$P(DATA,"^"),0)),"^",4),LINE=""
 ..S $E(LINE,15)="PROVIDER: "_$$UP^XLFSTR($$NAME^XUSER(PRVDR,"F"))
 ..D SETTMP S LINE=""
 S VALMCNT=SEQ
 Q
 ;
SETTMP ;Sets the ^TMP("PSORDI",$J global
 S SEQ=SEQ+1,^TMP("PSORDI",$J,SEQ,0)=LINE
 Q
 ;
GETSIG ;Gets SIG from File #52, format and place into FSIG array
 N I,RSIG
 S I=0 F  S I=$O(^PSRX(+$P(DATA,"^"),"SIG1",I)) Q:'I  D
 .S RSIG(I)=$G(^PSRX(+$P(DATA,"^"),"SIG1",I,0))
 I $O(RSIG(""))'="" D FMTSIG^PSORMRX
 Q
 ;
HELP ;
 Q
 ;
EXIT ;
 ;Remove local but leave remote prescriptions
 N CNT,SEQ
 I '$D(PSORFLG) D  Q
 .K ^TMP("PSORDI",$J),^TMP($J,"PSORDI"),^TMP("PSORDIS",$J)
 S SEQ=$G(^TMP("PSORDI",$J,"REMOTE COUNT"))
 F  S SEQ=$O(^TMP("PSORDI",$J,SEQ)) Q:'SEQ  K ^TMP("PSORDI",$J,SEQ)
 Q
