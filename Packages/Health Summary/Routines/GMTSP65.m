GMTSP65 ; SLC OIFO/GS - Post Install GMTS*2.7*65    ; 04/09/2004
 ;;2.7;Health Summary;**65**;Oct 20, 1995
 Q
POST ; Post-Install
 D HOME^%ZIS N ENV S ENV=$$ENV Q:'ENV  D REM,CI,RDV
 Q
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD
 N GMTSCPS,GMTSCP,GMTSCI
 S GMTSCPS="RXNV"
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
 . N GMTSHORT
 . S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*65"
 . D SEND^GMTSXPS1
 Q
REM ; Remove Component
 N DA,DIK,GMTST,GMTSC,GMTSD
 S (GMTST,GMTSD)=0
 ;   From Health Summary Type File 142
 F  S GMTST=$O(^GMT(142,"AE",243,GMTST)) Q:+GMTST=0  D
 . S GMTSC=0 F  S GMTSC=$O(^GMT(142,"AE",243,GMTST,GMTSC)) Q:+GMTSC=0  D
 . . Q:$P($G(^GMT(142,GMTST,1,GMTSC,0)),"^",2)'=243  S GMTSD=GMTSD+1
 . . K ^GMT(142,GMTST,1,GMTSC),^GMT(142,GMTST,1,"B",GMTSC),^GMT(142,GMTST,1,"C",243)
 I GMTSD>1 K ^GMT(142,"AE",243)
 ;   From Health Summary Component File 142.1
 S DA=243,DIK="^GMT(142.1," D ^DIK
 ;   From PDX Segment File 394.1
 ;      Previous RXNV Component
 S DA=+($O(^VAT(394.71,"C","RXNV",0))) I +DA>0 S DIK="^VAT(394.71," D ^DIK
 ;      Previous NVM Component
 S DA=+($O(^VAT(394.71,"C","NVM",0))) I +DA>0 S DIK="^VAT(394.71," D ^DIK
 ;      Previous HOTC Component
 S DA=+($O(^VAT(394.71,"C","HOTC",0))) I +DA>0 S DIK="^VAT(394.71," D ^DIK
 ;      Previous "Non-va Medications" Component
 S DA=+($O(^VAT(394.71,"B","Non-va Medications",0))) I +DA>0 S DIK="^VAT(394.71," D ^DIK
 Q
RDV ; Remote Data View - Outpatient Meds
 N COM,TYP,HDR,TTL,TIM,DA,DIK,DIE,DIC,DA
 S COM=$O(^GMT(142.1,"C","RXNV",0)) Q:+COM'>0
 S TYP=$O(^GMT(142,"B","REMOTE OUTPATIENT MEDS (6M)",0)) Q:+TYP=0
 S HDR=$P($G(^GMT(142.1,+COM,0)),"^",9) Q:'$L(HDR)
 S TTL=$P($G(^GMT(142.1,+COM,0)),"^",1) Q:'$L(TTL)  S TIM="6M"
 S DA(1)=+TYP,(DIE,DIK,DIC)="^GMT(142,"_DA(1)_",1,",DA=15 D ^DIK
 D BMES^XPDUTL(" Adding the '"_TTL_"' Health Summary Component")
 D MES^XPDUTL(" to the 'REMOTE OUTPATIENT MEDS (6M)' Remote Data View Health")
 D MES^XPDUTL(" Summary Type"),MES^XPDUTL("")
 K ^GMT(142,"AE",243,5000014,15),^GMT(142,5000014,1,"B",15,15),^GMT(142,5000014,1,"C",243,15)
 S ^GMT(142,DA(1),1,DA,0)="15^"_COM_"^^"_TIM_"^"_HDR
 S ^GMT(142,DA(1),1,"B",DA,DA)="",^GMT(142,DA(1),1,"C",COM,DA)=""
 K DA S DA=+TYP,DIK="^GMT(142," D IX1^DIK
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
ENV(X) ; Environment check
 D HOME^%ZIS S U="^"
 I $$GET1^DIQ(200,+($G(DUZ)),.01)="" W !!,"    User (DUZ) not defined",! Q 0
 Q 1
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0
 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T(+1^"_X_")" X GMTSEX
 Q:'$L(GMTSTXT) 0
 Q 1
 ;                
RXNV ; Non VA Meds Component Data
 ;0;;243
 ;.01;;NON VA MEDICATIONS
 ;1;;MAIN;GMTSPSHO
 ;1.1;;1
 ;1.1;1;PSOHCSUM
 ;2;;Y
 ;3;;RXNV
 ;3.5;;2
 ;3.5;1;This component displays the non-VA medications taken or
 ;3.5;2;reported as used by a patient.
 ;4;;Y
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Non VA Meds
 ;10;;
 ;11;;
 ;12;;
 ;13;;PS
 ;14;;
 ;PDX;;1
 ;TIM;;1Y
 ;OCC;;10
 ;
 Q
 ;
