FHWOR61 ; HISC/JH - Dietetics Isolation/Precaution ;2/23/00  09:53
 ;;5.5;DIETETICS;;Jan 28, 2005
GET ; Get OBR
 N FHIS1
 S OBR=$P(X,"|",13),(FHIS1,IS)=$P(OBR,"^",4)
 I $P(^FHPT(FHDFN,"A",ADM,0),"^",10)'="" S FHIS=$P(^FHPT(FHDFN,"A",ADM,0),"^",10) D CAN^FHORD4 S FHHOLD=FHORN,FHORN=$P(^FHPT(FHDFN,"A",ADM,0),"^",13) D:FHORN>0 CODE^FHWOR61 S FHORN=FHHOLD,IS=FHIS K FHHOLD,FHIS
 S IS=FHIS1 D FIL^FHORD4 S $P(^FHPT(FHDFN,"A",ADM,0),"^",13)=+FHORN,FILL="I"_";"_ADM_";"_IS D SEND^FHWOR
 K OBR Q
ISO ; Isolation/Precaution Order
 K MSG D SETVAR^FHORD4
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORM"
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 S WARD=$G(^DPT(DFN,.1)) Q:WARD=""  S FHWRD=$O(^DIC(42,"B",WARD,0)) Q:'FHWRD  S HOSP=+$P($G(^DIC(42,+FHWRD,44)),"^",1) Q:'HOSP  S RM=$G(^DPT(DFN,.108)) S:RM RM=$P($G(^DG(405.4,+RM,0)),"^",1)
 S MSG(3)="PV1||I|"_HOSP_"^"_RM_"||||||||||||||||"
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_FHIDT_"|||"_DUZ_"||"_DUZ_"|||"_FHIDT
 S MSG(5)="OBR||||||||||||^^^"_IS_"^"_$P(^FH(119.4,IS,0),"^")_"^99FHI"
 K FHIDT,FILL,FHWRD,HOSP,RM,SITE,SDT
 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 Q
CODE ; Cancelation From Dietetic
 K MSG D SETVAR^FHORD4
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORM"
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^")
 S MSG(3)="ORC|OC|"_FHORN_"^OR|"_FILL_"^FH|||||||||"_FHPV_"|||"_FHIDT_"|Dietetics Canceled Isolation/Precaution"
 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 Q
CAN ; Cancel Isolation From Order Entry
 S IS=+$P(FILL,";",3) I 'IS D CSEND^FHWOR Q
 D GADM^FHWORR
 I IS'=$P($G(^FHPT(FHDFN,"A",+ADM,0)),"^",10) D CSEND^FHWOR Q
 I +FHORN'=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",13) D CSEND^FHWOR Q
 D CAN^FHORD4,CSEND^FHWOR
 K IS
 Q
NA ; If isolation store in Ditetics and Order/Entry
 G:'$P(FILL,";",3) KILL
 S:ADM'=$P(FILL,";",2) ADM=$P(ADM,";",2) ;Check if same admission
 S OBR=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",10) I OBR=+$P(FILL,";",3) D
 .I +FHORN>0 S $P(^FHPT(FHDFN,"A",ADM,0),"^",13)=+FHORN
 .Q
KILL K FHIDT,IS
 Q
