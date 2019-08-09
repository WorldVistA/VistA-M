GMTSP125 ; CIO/SLC - Post Install GMTS*2.7*125 ;Mar 07, 2019@10:53:03
 ;;2.7;Health Summary;**125**;Oct 20, 1995;Build 15
 Q
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI
 S GMTSCPS="RXDC;RXOI"
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI) K GMTSIN
 . D ARRAY Q:'$D(GMTSIN)
 . I $L($G(GMTSIN("TIM"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"TIM")=$G(GMTSIN("TIM"))
 . I $L($G(GMTSIN("OCC"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"OCC")=$G(GMTSIN("OCC"))
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN),GMTSTOT=+($G(GMTSTOT))+($G(GMTSINST))
 ; Rebuild Ad Hoc Health Summary Type
 D:+($G(GMTSTOT))>0 BUILD^GMTSXPD3
 D LIM
 I +$$ROK("GMTSXPS1")>0 D
 . N GMTSHORT S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*125" D SEND^GMTSXPS1
 Q
ARRAY ; Build Array
 K GMTSIN N GMTSI,GMTSTXT,GMTSEX,GMTSFLD,GMTSUB,GMTSVAL,GMTSPDX S GMTSPDX=1,GMTSCP=$G(GMTSCP) Q:'$L(GMTSCP)
 F GMTSI=1:1 D  Q:'$L(GMTSTXT)
 . S GMTSTXT="",GMTSEX="S GMTSTXT=$T("_GMTSCP_"+"_GMTSI_")" X GMTSEX S:$L(GMTSTXT,";")'>3 GMTSTXT="" Q:'$L(GMTSTXT)
 . S GMTSFLD=$P(GMTSTXT,";",2),GMTSUB=$P(GMTSTXT,";",3),GMTSVAL=$P(GMTSTXT,";",4)
 . S:$E(GMTSFLD,1)=1&(+GMTSFLD<2) GMTSVAL=$P(GMTSTXT,";",4,5)
 . S:$E(GMTSFLD,1)=" "!('$L(GMTSFLD)) GMTSTXT="" Q:GMTSTXT=""
 . S:$L(GMTSFLD)&('$L(GMTSUB)) GMTSIN(GMTSFLD)=GMTSVAL Q:$L(GMTSFLD)&('$L(GMTSUB))  S:$L(GMTSFLD)&($L(GMTSUB)) GMTSIN(GMTSFLD,GMTSUB)=GMTSVAL
 . S:$G(GMTSFLD)=7&(+($G(GMTSUB))>0) GMTSPDX=0
 K:+($G(GMTSPDX))=0 GMTSIN("PDX")
 Q
LIM ; Limits
 N GMTSI,GMTST,GMTSO,GMTSA S GMTSI=0 F  S GMTSI=$O(GMTSLIM(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",3),GMTST=$G(GMTSLIM(+GMTSI,"TIM")) S:'$L(GMTST) GMTST=$S(GMTSA="Y ":"1Y ",1:"")
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",5),GMTSO=$G(GMTSLIM(+GMTSI,"OCC")) S:'$L(GMTSO) GMTSO=$S(GMTSA="Y ":"10 ",1:"")
 . D TO^GMTSXPD3(GMTSI,GMTST,GMTSO)
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T(+1^"_X_")" X GMTSEX
 Q:'$L(GMTSTXT) 0  Q 1
 ;
RXDC ; Meds OP/Drug Class Component Data
 ;0;;269
 ;.01;;Meds OP/Drug Class
 ;1;;MAIN;GMTSPSO8
 ;1.1;;0
 ;2;;Y
 ;3;;RXDC
 ;3.5;;13
 ;3.5;1;This component contains information from the Outpatient Pharmacy package.
 ;3.5;2;It allows selection of prescriptions to display, based on the drug class.
 ;3.5;3;Only 'child' classes are displayed, with the exception of the HA000 class.
 ;3.5;4;
 ;3.5;5;Only time limits apply. Data presented include:  drug, prescription number,
 ;3.5;6;status expiration/cancellation date (when appropriate), quantity, issue
 ;3.5;7;date, last fill date, refills remaining, provider, and cost/fill (when
 ;3.5;8;available).
 ;3.5;9;
 ;3.5;10;Note: If no time limit is defined, only active outpatient orders are
 ;3.5;11;reported. If a time limit is defined, all outpatient pharmacy orders which
 ;3.5;12;have an expiration or cancel date within the time limit range are
 ;3.5;13;reported.
 ;4;;
 ;5;;
 ;6;;
 ;7;;1
 ;7;1;50.605
 ;8;;
 ;9;;Meds OP/Drug Class
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;TIM;;1Y
 ;
 Q
 ;
RXOI ; Meds OP/Rx Ord Item Component Data
 ;0;;270
 ;.01;;Meds OP/Rx Ord Item
 ;1;;MAIN;GMTSPSO9
 ;1.1;;0
 ;2;;Y
 ;3;;RXOI
 ;3.5;;13
 ;3.5;1;This component contains information from the Outpatient Pharmacy package.
 ;3.5;2;It allows selection of prescriptions to display, based on the Pharmacy
 ;3.5;3;orderable item associated with the order.
 ;3.5;4;
 ;3.5;5;Only time limits apply.  Data presented include:  drug, prescription number,
 ;3.5;6;status expiration/cancellation date (when appropriate), quantity, issue
 ;3.5;7;date, last fill date, refills remaining, provider, and cost/fill (when
 ;3.5;8;available).
 ;3.5;9;
 ;3.5;10;Note: If no time limit is defined, only active outpatient orders are
 ;3.5;11;reported. If a time limit is defined, all outpatient pharmacy orders which
 ;3.5;12;have an expiration or cancel date within the time limit range are
 ;3.5;13;reported.
 ;4;;
 ;5;;
 ;6;;
 ;7;;1
 ;7;1;50.7
 ;8;;
 ;9;;Meds OP/Rx Ord Item
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;TIM;;1Y
 ;
 Q
 ;
