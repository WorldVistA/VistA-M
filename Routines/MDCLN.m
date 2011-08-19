MDCLN ;HIOFO/NCA - Cleanup Disabled Studies ;4/19/01  11:52
 ;;1.0;Clinical Procedures;**21**;Apr 01, 2004;Build 30
 N MDLP,MDFDA
 S MDLP=0 F  S MDLP=$O(^MDK(704.202,"AS",2,MDLP)) Q:MDLP<1  D
 .I $P($G(^MDD(702,MDLP,0)),"^",9)'=3!($P($G(^MDD(702,MDLP,0)),"^",9)=3) D
 ..S MDFDA(702,+MDLP_",",.09)=3
 ..D FILE^DIE("","MDFDA") W !,+MDLP
 ..K MDFDA S MDFDA(704.202,+MDLP_",",.09)=0
 ..D FILE^DIE("","MDFDA")
 Q
