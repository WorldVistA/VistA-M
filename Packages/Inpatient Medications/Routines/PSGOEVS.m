PSGOEVS ;BIR/CML3-SPEED VERIFY SELECTED ORDERS ;05 DEC 97 / 8:43 AM
 ;;5.0; INPATIENT MEDICATIONS ;**29,110**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PSSLOCK is supported by DBIA #2789
 ;
EN ;
 I 'PSJSYSU W $C(7),!!,"THIS FUNCTION NOT AVAILABLE TO WARD STAFF." H 3 Q
 I '$D(PSJOCNT) W !!,"Speed verify is not available for IVs." H 3 Q
 W !,"Note: Only orders created by a RENEW can be speed verified."
 D FULL^VALM1
EN2 S PSGONV=PSJOCNT,PSJSPEED=1 D NOW^%DTC S PSGDT=+$E(%,1,2)
 S PSGONW="V",PSGLMT=PSGONV D ENWO^PSGON S PSJRB=X I "^"[X K X G DONE
 F PSGOEVS=1:1:PSGODDD F PSGOEVS1=1:1 S PSGOEVS2=$P(PSGODDD(PSGOEVS),",",PSGOEVS1) Q:'PSGOEVS2  D
 .S PSGORD=^TMP("PSJON",$J,PSGOEVS2)
 .I $$CHKIV Q
 .I $$CHKVER Q
 .;I '$$ACTIONS Q
 .N PSJCOM I $$CHKCOM Q
 .I '$$RENEWED Q
 .I $$FROMOERR Q
 .D VERIFY(PSJSPEED)
 ;
DONE ;
 K %,DA,N,PSGAL,PSGID,PSGLMT,PSGOD,PSGODDD,PSGOEVS,PSGOEVS1,PSGOEVS2
 K PSGONW,PSGORD,PSJRB,PSJRENEW,PSJSPEED
 N DIR S DIR(0)="E" D ^DIR
 Q
 ;
RENEWED() ;   was it created by a renew?
 S PSJRENEW=1
 I PSGORD'["P" D
 .S PSJRB=$G(^PS(55,PSGP,5,+PSGORD,.2))
 .S PSJRB=$$NAME(PSJRB)
 .W !!,"  ",PSGOEVS2,".  ",PSJRB
 .I $P(^PS(55,PSGP,5,+PSGORD,0),"^",24)'="R" D NOTREN Q
 E  I PSGORD["P" D
 .S PSJRB=$G(^PS(53.1,+PSGORD,.2))
 .S PSJRB=$$NAME(PSJRB)
 .W !!,"  ",PSGOEVS2,".  ",PSJRB
 .I $P(^PS(53.1,+PSGORD,0),"^",24)'="R" D NOTREN Q
 Q PSJRENEW
 ;
VERIFY(PSJSPEED) ;
 I '$$LS^PSSLOCK(PSGP,PSGORD) W !,"NO ACTION TAKEN ON ORDER",!  ; lock single order
 D GETUD^PSJLMGUD(PSGP,PSGORD),EN^PSGOEV(PSGORD)
 D UNL^PSSLOCK(PSGP,PSGORD)
 Q
 ;
CHKVER() ;   check if already verified
 I $D(^PS(55,PSGP,5,+PSGORD,4)),$P(^(4),"^",PSJSYSU) S N=$P(^(4),"^",+PSJSYSU),PSGOD=$P(^(4),"^",PSJSYSU+1)
 I  D VMSG H 2
 Q $T
 ;
CHKIV() ;   check if this order is an IV
 I PSGORD["V"
 I  W !,"  Order ",PSGOEVS2," is an IV order.",! H 2
 Q $T
CHKCOM() ;       Check if this order is a complex order
 S PSJCOM=0
 I PSGORD=+PSGORD S PSJCOM=PSGORD W !,"  Order ",PSGOEVS2," is part of a complex order series, No change made.",! H 2 Q PSJCOM
 S PSJCOM=$S(PSGORD["U":$P($G(^PS(55,PSGP,5,+PSGORD,.2)),U,8),1:$P($G(^PS(53.1,+PSGORD,.2)),U,8))
 I PSJCOM  W !,"  Order ",PSGOEVS2," is part of a complex order series, No change made.",! H 2
 Q PSJCOM
 ;
VMSG ;
 S N=$$ENNPN^PSGMI(N),PSJRB=$G(^PS(55,PSGP,5,+PSGORD,.2))
 S PSJRB=$$NAME(PSJRB)
 W !!,"  ",PSGOEVS2,".  ",PSJRB,!,"   was verified by ",N," on "
 W $$ENDTC^PSGMI(PSGOD),"."
 Q
NOTREN ;
 W !,"   was not created from a renew, No change made!" H 2
 S PSJRENEW=0
 Q
 ;
NAME(PSJRB)        ;
 I PSJRB S PSJRB=$$DRUGN_" "_$P(PSJRB,"^",2)
 E  S PSJRB="ORDERABLE ITEM - NOT FOUND"
 Q PSJRB
 ;
DRUGN() Q $P($$DRUGNAME^PSJLMUTL(PSGP,PSGORD),"^")
 ;
ACTIONS()    ;
 ;W !," ******  ",$$ENACTION^PSGOE1(PSGP,PSGORD)
 I $$ENACTION^PSGOE1(PSGP,PSGORD)["V"
 E  W !,PSGOEVS2,". CAN'T BE VERIFIED FOR SOME REASON!  ",PSGACT
 Q $T
 ;
FROMOERR()         ;  is it pending from OERR?
 I PSGORD["P"&($P($G(^PS(53.1,+PSGORD,0)),"^",9)="P")
 I  D
 .W !,"   is Pending from Order Entry/Results Reporting"
 .W ", No Change made." H 2
 Q $T
