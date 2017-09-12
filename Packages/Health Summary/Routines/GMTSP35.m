GMTSP35 ; CIO/SLC - Post Install GMTS*2.7*35    ; 04/11/2000
 ;;2.7;Health Summary;**35**;Oct 20, 1995
 ;
 Q
POST ; Post Install
 N GMTSIN,GMTSINST,GMTSTL,GMTSGAF,GMTSVSD,GMTSINST,GMTSBLD
 D CI D TO^GMTSXPD3("GAF","3Y",10),TO^GMTSXPD3("VSD","1Y",3)
 I +$$ROK("GMTSXPS1")>0 S GMTSINST="",GMTSBLD="GMTS*2.7*35" D SEND^GMTSXPS1
 Q
CI ; Component Install
 N GMTSOK,GMTSIN,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI
 S GMTSCPS="GAF;VSD",GMTSOK=0,GMTSOK=GMTSOK+$$ROK("GMTSXPD1"),GMTSOK=GMTSOK+$$ROK("GMTSXPD3")
 I GMTSOK'=2 D  Q
 . W !!," >> Can not install components GAF, and VSD"
 . W !,"    Could not find install routines GMTSXPD*"
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI)
 . D ARRAY Q:'$D(GMTSIN)
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN)
 . S GMTSTOT=+($G(GMTSTOT))+GMTSINST
 D:+($G(GMTSTOT))>0 BUILD^GMTSXPD3
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0 Q:$L(X)>8 0 X ^%ZOSF("TEST") Q:$T 1 Q 0
ARRAY ; Build Array
 K GMTSIN N GMTSI,GMTSTXT,GMTSEX,GMTSFLD,GMTSV,GMTSPDX,GMTSDD,GMTSFLDS
 S GMTSPDX=0,GMTSCP=$G(GMTSCP) Q:'$L(GMTSCP)
 S GMTSDD(0)="1;.01^2;1^3;2^4;3^5;4^6;5^7;6^8;8^9;9^10;10^11;11^12;12^13;13^14;14"
 S GMTSDD(.1)="1.1",GMTSDD(.1,0)="1;.01",GMTSDD(1)="7",GMTSDD(1,0)="1;.01^2;1",GMTSDD(3.5)="3.5",GMTSDD(3.5,0)="1;.01"
 S GMTSFLDS=".01;1;2;3;4;5;6;8;9;10;11;12;13;14^1.1;7;3.5"
 N GMTSND,GMTSNS,GMTSNI,GMTSNP,GMTSNV,GMTSV,GMTSTR
 F GMTSI=1:1 D  Q:'$L(GMTSTXT)
 . S GMTSTXT="",GMTSEX="S GMTSTXT=$T("_GMTSCP_"+"_GMTSI_")"
 . X GMTSEX S:$L(GMTSTXT,";")'>3 GMTSTXT="" Q:'$L(GMTSTXT)
 . S GMTSND=$P(GMTSTXT,";",2),GMTSNS=$P(GMTSTXT,";",3)
 . S GMTSNI=$P(GMTSTXT,";",4),GMTSNV=$P(GMTSTXT,";",5,299)
 . S:GMTSND="PDX"&(GMTSNV=1) GMTSPDX=1 Q:GMTSND="PDX"
 . S:GMTSND="IEN"&(+($G(GMTSNV))>0) GMTSIN(0)=+($G(GMTSNV)) Q:GMTSND="IEN"
 . F GMTSNP=1:1:$L(GMTSNV,"^") D
 . . S GMTSV=$P(GMTSNV,"^",GMTSNP) Q:'$L(GMTSV)
 . . S GMTSTR=$P($G(GMTSDD(GMTSND)),"^",GMTSNP),GMTSFLD=$P(GMTSTR,";",2)
 . . S:$L(GMTSNS) GMTSTR=$P($G(GMTSDD(GMTSND,GMTSNS)),"^",GMTSNP),GMTSFLD=$G(GMTSDD(GMTSND))
 . . S:GMTSNI'>0 GMTSIN(GMTSFLD)=GMTSV
 . . S:GMTSNI>0 GMTSIN(GMTSFLD,GMTSNI)=GMTSV,GMTSIN(GMTSFLD)=+($G(GMTSIN(GMTSFLD)))+1
 S:GMTSPDX GMTSIN("PDX")=1 F GMTSI=1:1 Q:'$L($P($P(GMTSFLDS,"^",1),";",GMTSI))  D
 . S GMTSFLD=$P($P(GMTSFLDS,"^",1),";",GMTSI) S:$L(GMTSFLD)&('$D(GMTSIN(GMTSFLD))) GMTSIN(GMTSFLD)=""
 F GMTSI=1:1 Q:'$L($P($P(GMTSFLDS,"^",2),";",GMTSI))  D
 . S GMTSFLD=$P($P(GMTSFLDS,"^",2),";",GMTSI) S:$L(GMTSFLD)&('$D(GMTSIN(GMTSFLD))) GMTSIN(GMTSFLD)=0
 Q
 ;
GAF ; Global Assess Funct
 ;IEN;;;238
 ;0;;;GLOBAL ASSESSMENT FUNCTIONING^EN;GMTSGAF^Y^GAF^Y^^^^Global Assess Funct^^^^YS
 ;.1;0;1;GAFHX;YSGAFAPI
 ;3.5;0;1;This component displays the GAF score taken from the Global Assessment
 ;3.5;0;2;Functioning scale to evaluate the psychological,social, and occupational
 ;3.5;0;3;functioning on a hypothetical continuum of mental health/illness.  Also
 ;3.5;0;4;displayed is the date of the assessment and the name of the health care
 ;3.5;0;5;professional who provided the assessment.
 ;PDX;;;1
 ;
VSD ; Detailed Vitals
 ;IEN;;;237
 ;0;;;VITAL SIGNS DETAILED DISPLAY^EN;GMTSVSD^Y^VSD^Y^^^^Detailed Vitals^^^^GMRV
 ;.1;0;1;EN1;GMRVUT0
 ;3.5;0;1;This component contains vital measurements extracted from the Vital Signs
 ;3.5;0;2;module, and differs from other Health Summary Vital Signs displays by
 ;3.5;0;3;including the Vital Signs Qualifiers (sitting,standing, left arm, etc.)
 ;3.5;0;4;with the vitals measurement.  Time and maximum occurrence limits apply.
 ;3.5;0;5;Data presented includes measurement date and time, temperature, blood
 ;3.5;0;6;pressure, pulse, height, weight, respiratory rate,CVP, PO2, circumference
 ;3.5;0;7;and girth, and pain.
 ;PDX;;;1
 ;
