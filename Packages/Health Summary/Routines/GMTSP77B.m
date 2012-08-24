GMTSP77B ; CIO/SLC - Post Install GMTS*2.7*77    ; 09/11/2007
 ;;2.7;Health Summary;**77**;Oct 20, 1995;Build 47
 ;
 Q
POST ; Post-Install
 D CI
 Q
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI,GMTSINX
 S GMTSCPS="MHAL;MHAS"
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI) K GMTSIN
 . D ARRAY Q:'$D(GMTSIN)
 . I $L($G(GMTSIN("TIM"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"TIM")=$G(GMTSIN("TIM"))
 . I $L($G(GMTSIN("OCC"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"OCC")=$G(GMTSIN("OCC"))
 . I GMTSIN(0)=249 M GMTSINX=GMTSIN
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN),GMTSTOT=+($G(GMTSTOT))+($G(GMTSINST))
 ; Rebuild Ad Hoc Health Summary Type
 D:+($G(GMTSTOT))>0 BUILD^GMTSXPD3
 I $G(GMTSTOT)<1 D
 .W !!," Adding missing data for previously installed components."
 .D FIX
 .D BUILD^GMTSXPD3
 D LIM
 I +$$ROK("GMTSXPS1")>0 D
 . N GMTSHORT S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*77" D SEND^GMTSXPS1
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
FIX ;
 ;FIX OCCURANCE AND TIME LIMITS
 S $P(^GMT(142.1,248,0),U,3)=1
 S $P(^GMT(142.1,248,0),U,5)=1
 S $P(^GMT(142.1,249,0),U,3)=1
 S $P(^GMT(142.1,248,0),U,5)=1
 ;FIX SELECTION ITEMS
 I $D(GMTSINX) D SEL^GMTSXPD1(.GMTSINX)
 Q
 ;
MHAL ;
 ;0;;248
 ;.01;;MHA Administration List
 ;1;;EN;GMTSYTQL
 ;2;;YES
 ;3;;MHAL
 ;4;;YES
 ;13;;YS
 ;9;;MHA Admin List
 ;3.5;;2
 ;3.5;1;This component displays all administrations of intruments in
 ;3.5;2;the mental health package for the specified patient. All administrations from 
 ;3.5;3;MH Administrations (file #601.84) are shown.
 ;3.5;4;
 ;3.5;5;Date ranges and maximum occurances apply. 
 ;PDX;;1
 ;TIM;;1Y
 ;OCC;;10
 ;
 Q
 ;
MHAS ;
 ;0;;249
 ;.01;;MHA Score
 ;1;;EN;GMTSYTQS
 ;2;;YES
 ;3;;MHAS
 ;4;;YES
 ;13;;YS
 ;9;;MHA Score
 ;7;;1
 ;7;1;601.71^99
 ;3.5;;2
 ;3.5;1;This component displays the administration and scoring of 
 ;3.5;2;intruments in the mental health package. Tests, interviews and surveys from MH
 ;3.5;3;TESTS and SURVEYS (file # 601.71) must be selected.
 ;3.5;4;
 ;3.5;5;Date ranges and maximum occurances apply.
 ;PDX;;1
 ;TIM;;1Y
 ;OCC;;10 
 ;
 Q
