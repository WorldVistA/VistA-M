SDECGMR ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**627,658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
STOP(GMRSTOP,SDGMR)  ;get stop codes from field 688 of REQUEST SERVICES file 123.5
 ; .GMRSTOP - returned array of STOP CODE pointers to CLINIC STOP file 40.7
 ;            GMRSTOP(<clinic stop id>)=<clinic stop name>
 ;  SDGMR   - (required) pointer to REQUEST/CONSULTATION file 123
 N RS,SDDATA,SDI,SDIEN,SDNM
 K GMRSTOP
 S RS=$$GET1^DIQ(123,SDGMR_",",1,"I")  ;get TO SERVICE
 D GETS^DIQ(123.5,RS_",","688*","IE","SDDATA")
 S SDI=0 F  S SDI=$O(SDDATA(123.5688,SDI)) Q:SDI=""  D
 .S SDIEN=$G(SDDATA(123.5688,SDI,.01,"I"))
 .S SDNM=$G(SDDATA(123.5688,SDI,.01,"E"))
 .S:+SDIEN GMRSTOP(SDIEN)=SDNM
 Q
 ;
GETSVC(GMRSVC,SVC)  ;get REQUEST SERVICES entries for given stop codes
 ; .GMRSVC - returned array of REQUEST SERVICES entries
 ; .SVC    - input array of clinic stop codes SVC(NAME)=ID pointer to CLINIC STOP file 40.7
 N AB1,ID,SDN,STOP
 K GMRSVC
 S SDN="" F  S SDN=$O(SVC(SDN)) Q:SDN=""  D
 .I SVC(SDN)="" Q
 .S STOP=SVC(SDN) I '$D(^DIC(40.7,STOP,0)) Q
 .S ID=0 F  S ID=$O(^GMR(123.5,"AB1",STOP,ID)) Q:ID=""  D
 ..S AB1=0 F  S AB1=$O(^GMR(123.5,"AB1",STOP,ID,AB1)) Q:AB1=""  D
 ...Q:STOP'=$P($G(^GMR(123.5,ID,688,AB1,0)),U,1)
 ...S GMRSVC(ID)=""
 Q
