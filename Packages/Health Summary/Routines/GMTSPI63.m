GMTSPI63 ; SLC/AGP - Post Install GMTS*2.7*63    ; 01/27/2005
 ;;2.7;Health Summary;**63**;Oct 20, 1995
 Q
PRE ;
 N DIU
 S DIU="142",DIU(0)="" D EN^DIU2
 Q
 ;
TYPE ;
 N DA,DIK
 S DIK="^GMT(142,",DA=5000016 D ^DIK
 S DIK="^GMT(142,",DA=5000017 D ^DIK
 ;
 N IEN,GMTSVAL
 ;
 S GMTSVAL(1)="GMTSMHV"
 S GMTSVAL(2)="07/06/2004@15:06:21"
 S IEN=+$$FIND1^DIC(811.8,"","KU",.GMTSVAL)
 I IEN'=0 D
 . N TEXT
 . S TEXT="Installing Health Summary item "_GMTSVAL(1)
 . D BMES^XPDUTL(TEXT)
 . D INSTALL^PXRMEXSI(IEN)
 Q
 ;
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI
 S GMTSCPS="GECH;GECC;MHVD;MHVS"
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
 . N GMTSHORT S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*63" D SEND^GMTSXPS1
 D TYPE
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
GECH ; Referral Categories  Component Data
 ;0;;244
 ;.01;;GEC Health Factor Category
 ;1;;HFSEL;GMTSPXFP
 ;1.1;;1
 ;1.1;1;HF;PXRHS07(DFN,END,BEG,NUM,.GMTSARY)
 ;2;;Y
 ;3;;GECH
 ;3.5;;0
 ;4;;Y
 ;5;;
 ;6;;
 ;7;;1
 ;7;1;9999999.64
 ;8;;
 ;9;;Referral Categories 
 ;10;;
 ;11;;
 ;12;;
 ;13;;GEC
 ;14;;
 ;TIM;;1Y
 ;OCC;;10
 ;
 Q
 ;
GECC ; Referral Count Component Data
 ;0;;245
 ;.01;;GEC Completed Referral Count
 ;1;;PRINT;GMTSGEC
 ;1.1;;0
 ;2;;Y
 ;3;;GECC
 ;3.5;;0
 ;4;;Y
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Referral Count
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;TIM;;1Y
 ;OCC;;10
 ;
 Q
 ;
MHVD ; Component Data
 ;0;;246
 ;.01;;MHV REMINDERS DETAIL DISPLAY
 ;1;;MAIN;GMTSPXHR
 ;1.1;;0
 ;2;;
 ;3;;MHVD
 ;3.5;;2
 ;3.5;1;This component display the detail description of all Clinical Reminders that 
 ;3.5;2;are define for MyHealtheVet. 
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Detail Display
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
MHVS ; Component Data
 ;0;;247
 ;.01;;MHV REMINDERS SUMMARY DISPLAY
 ;1;;MAIN;GMTSPXHR
 ;1.1;;0
 ;2;;
 ;3;;MHVS
 ;3.5;;2
 ;3.5;1;This component display the summary description of all Clinical Reminders 
 ;3.5;2;that are define for HealtheVet.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Summary Display
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
