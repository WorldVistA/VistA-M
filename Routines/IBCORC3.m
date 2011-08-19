IBCORC3 ;ALB/CPM - RANK INSURANCE CARRIERS (NEW BULLETIN) ; 02-DEC-94
 ;;2.0;INTEGRATED BILLING;**29,47,64,116**;21-MAR-94
 ;
BULL ; Generate a specially formatted bulletin for the MCCR Program Office.
 ;
 ; - first, invert the list by carrier to rank by number of claims
 S (IBNR,IBINS)=0 F  S IBINS=$O(^TMP("IBORIC",$J,"IC1",IBINS)) Q:'IBINS  S ^TMP("IBORIC",$J,"NUM",-$G(^(IBINS)),IBINS)="",IBNR=IBNR+1
 ;
 S IBSITE=$P($$SITE^VASITE,"^",3),IBDAT=$$DAT1^IBOUTL(DT)
 S XMSUB="PRQC IBINS: "_IBSITE_" Top "_IBNR_" Billed "_IBDAT
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 K ^TMP($J,"IBORIC") S XMTEXT="^TMP($J,""IBORIC"","
 S XMY(DUZ)=""
 I $$PROD^IBCORC() S XMY(IBMAILTO)=""
 ;
 ; - set up report body
 S IBCNT=0,IBNUM=""
 F  S IBNUM=$O(^TMP("IBORIC",$J,"NUM",IBNUM)) Q:IBNUM=""  D
 .S IBINS=0 F  S IBINS=$O(^TMP("IBORIC",$J,"NUM",IBNUM,IBINS)) Q:'IBINS  D
 ..S IBCNT=IBCNT+1,IBAMT=+$G(^TMP("IBORIC",$J,"IC",IBINS))
 ..S ^TMP($J,"IBORIC",IBCNT)=IBSITE_"^"_IBCNT_"^"_$$INS(IBINS)_"^"_$J(IBAMT,"",2)_"^"_-IBNUM_"^"_IBINS
 ;
 ; - deliver and quit
 D ^XMD
 K ^TMP($J,"IBORIC"),IBNUM
 K IBAMT,IBCNT,IBC,IBDAT,IBINS,IBSITE,IBT,X,XMSUB,XMDUZ,XMY,XMTEXT,Y
 Q
 ;
INS(IBCNS) ; Format Insurance Company name and address for bulletin.
 ;  Input:  IBCNS   --   pointer to the insurance company in file #36
 N IBCNS0,X,Y
 S IBINS0=$G(^DIC(36,IBCNS,0))
 S Y=$S($P(IBINS0,"^")]"":$P(IBINS0,"^"),1:"CARRIER UNKNOWN") ; name
 S Y=Y_"^"_$S($P(IBINS0,"^",5):0,1:1)            ; 1-active, 0-inactive
 S X=$G(^DIC(36,IBCNS,.11))
 S Y=Y_"^"_$P(X,"^")                             ; address [line 1]
 S Y=Y_"^"_$P(X,"^",2)                           ; address [line 2]
 S Y=Y_"^"_$P(X,"^",4)                           ; city
 S Y=Y_"^"_$P($G(^DIC(5,+$P(X,"^",5),0)),"^",2)  ; state
 S Y=Y_"^"_$P(X,"^",6)                           ; zip code
 S X=$G(^DIC(36,IBCNS,.13))
 S Y=Y_"^"_$P(X,"^")                             ; phone number
 S Y=Y_"^"_$P(X,"^",2)                           ; billing phone number
 Q Y
 ;
 ;
IRM ; IRM Entry Point to queue a one-time (?) job for MCCR.
 ;
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,1:0) D  G IRMQ
 .W !!?3,"The variable DUZ must be set to an active user code and the variable"
 .W !?3,"DUZ(0) must also be defined to run this routine."
 ;
 ; - set parameters, if not defined, as needed for the compilation
 I '$D(IBABEG) S IBABEG=2971001
 I '$D(IBAEND) S IBAEND=2981231
 I '$D(IBNR) S IBNR=30
 I '$D(IBMAILTO) S IBMAILTO="S.PRQC SERVER IBINS@ISC-ALBANY.VA.GOV"
 S IBIRM=1
 ;
 W !!,"This job will compile a ranking of all your insurance carriers by the total"
 W !,"number of claims billed from ",$$DAT1^IBOUTL(IBABEG)," to ",$$DAT1^IBOUTL(IBAEND),".  The compilation will be"
 W !,"uploaded into a mail message and sent to the MCCR National Database where"
 W !,"it will be re-formatted in a PC-downloadable format and sent to the"
 W !,"MCCR Program Office.  This mail message will also be sent to you."
 ;
 ; - warn that the software is not being executed in Production
 I '$$PROD^IBCORC() D
 .W !!,*7,"   *** Please note ***"
 .W !!?3,"You appear to be executing this routine in a test account."
 .W !?3,"The mail message will only be sent to you."
 ;
 ; - okay to continue?
 S DIR(0)="Y",DIR("A")="Do you want to queue this job now"
 W ! D ^DIR K DIR I 'Y G IRMQ
 ;
 ; - queue the job up to be run
 W !!,"Please enter the date and time to execute this job...",!
 S ZTRTN="DQ^IBCORC1",ZTIO="",ZTDESC="IB - RANKING CARRIERS (FROM IRM)"
 F I="IBABEG","IBAEND","IBNR","IBIRM","IBMAILTO" S ZTSAVE(I)=""
 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"")
 ;
IRMQ K IBABEG,IBAEND,IBMAILTO,IBNR,IBIRM,X,Y,DIRUT,DUOUT,DTOUR,DIROUT,I,ZTSK
 Q
