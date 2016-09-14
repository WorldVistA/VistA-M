SDECGMR ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
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
