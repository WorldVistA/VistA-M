DG53357T ; ALB/GRR - POST INIT TO REMOVE INSTITUTION NAME FOR PROTOCOLS ; 10-14-99
 ;;5.3;Registration;**357**;Aug 13, 1993
 ;
EN ;
 W @IOF,"Post Init routine started"
 N DGPROT,DGPIEN,DGPNAME,DGNEWN
 ;
 S DGPROT="DGRU-"
 F  S DGPROT=$O(^ORD(101,"B",DGPROT)) Q:$E(DGPROT,1,5)'="DGRU-"  D
 .I $E(DGPROT,1,8)'="DGRU-RAI"&($E(DGPROT,1,12)'="DGRU-PATIENT") Q  ;not an RAI/MDS protocol
 .I DGPROT["ROUTER"!(DGPROT["SERVER") Q  ;don't rename router and server protocols
 .S DGPIEN=$O(^ORD(101,"B",DGPROT,0)) ;get ien of protocol
 .S DGPNAME=$$GET1^DIQ(101,DGPIEN,.01,"I") ;get current protocol name
 .S DGPAPP=$$GET1^DIQ(101,DGPIEN,770.2,"I") ;get ien of receiving application 
 .S DGNEWN=$P(DGPNAME,"-",1,3)_"-"_DGPAPP
 .S FDA(1,101,DGPIEN_",",.01)=DGNEWN
 .D FILE^DIE("","FDA(1)")
 W !,"Post init routine completed",!
 Q
