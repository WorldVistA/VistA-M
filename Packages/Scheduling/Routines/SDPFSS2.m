SDPFSS2 ;ALD/SCK - Patient Financial Services System cont. ; 22-April-2005
 ;;5.3;Scheduling;**430**;Aug 13, 1993
 ;
 Q
 ;
GETARN(SDT,DFN,SDCL) ; Get the PFSS Account Number Reference from file #409.55 for the matching Appt. D/T,
 ; patient DFN, and clinic location.
 ;   Input
 ;      SDT  - Appointment Date/Time
 ;      DFN  - Patient IEN to File #2
 ;      SDCL - Clinic IEN to File #44
 ;
 ;   Output
 ;      If an error occurred : -1^Error message
 ;      0 if no match found
 ;      SDANR if a match is found
 ;
 N SDANR,SDIEN
 ;
 S DFN=$G(DFN) I 'DFN S SDANR="-1^No DFN was provided" G ARNQ
 S SDT=$G(SDT) I 'SDT S SDANR="-1^No Appointment Date/Time provided" G ARNQ
 S SDCL=$G(SDCL) I 'SDCL S SDANR="-1^No Clinic information was provided"  G ARNQ
 ;
 S SDIEN=0
 S SDIEN=$O(^SD(409.55,"D",SDT,DFN,SDCL,0))
 I SDIEN>0 D
 . S SDANR=$$GET1^DIQ(409.55,SDIEN,.04)
 E  D
 . S SDANR=0
ARNQ Q $G(SDANR)
 ;
ENCPRV(DFN,SDVSIT) ; Returns the encounter provider associated with the visit.
 ; Input
 ;    DFN    - Patient IEN from the PATIENT File (#2)
 ;    SDVSIT - Visit IEN from the VISIT File (#9000010)
 ;      DFN and SDVSIT are references to global variables which are available as part 
 ; of the SD application.
 ;
 ; Output
 ;    Visit Provider from the NEW PERSON File (#200)
 ;    IEN^Provider Name or Null
 ;
 N PRVIEN,SDX,PRVNAME,RSLT
 ;
 I $G(SDVSIT)>0 S SDX=$O(^AUPNVPRV("AD",SDVSIT,0))
 I +$G(SDX)>0 D
 . S PRVIEN=$P($G(^AUPNVPRV(SDX,0)),U)
 . I PRVIEN>0,$P($G(^AUPNVPRV(SDX,0)),U,2)=DFN S PRVNAME=$$GET1^DIQ(200,PRVIEN,.01)
 . S RSLT=$G(PRVIEN)_"^"_$G(PRVNAME)
 Q $G(RSLT)
 ;
DEFPRV(SDCLN) ; Return the default provider for a clinic if one is specified
 ; Input
 ;    SDCLN - Clinic IEN for HOSPITAL LOCATION File (#44)
 ; Output
 ;    Provider from NEW PERSON File (#200):
 ;    IEN^Provider Name or Null
 ;
 N SDX,PRVIEN,PRVNAME,RSLT
 ;
 S SDX=0
 F  S SDX=$O(^SC(SDCLN,"PR",SDX)) Q:'SDX  D
 . Q:'$P($G(^SC(SDCLN,"PR",SDX,0)),U,2)
 . S PRVIEN=$P($G(^SC(SDCLN,"PR",SDX,0)),U)
 . S PRVNAME=$$GET1^DIQ(200,PRVIEN,.01)
 . S RSLT=$G(PRVIEN)_"^"_$G(PRVNAME)
 Q $G(RSLT)
 ;
ERRMSG(ERRCODE) ; Generate bulletin when an error condition is processed
 ; Bulletins will be sent only if the receiving mail group SD RSA API ERRORS
 ; contains at least 1 member
 ;
 N XMDUZ,XMSUB,XMTEXT,XMB,X,Y,MSG,SDMG,XMY
 ;
 S SDMG=$O(^XMB(3.8,"B","SD RSA API ERRORS",0))
 Q:'SDMG
 ; Check mail group for members.  Quit if there are no members assigned to the group
 Q:'$D(^XMB(3.8,SDMG,1,"B"))
 ;
 ; Get the error message, or set a generic message
 S MSG=$P($G(ERRCODE),U,2)
 I MSG']"" S MSG="A general error condition occurred during the PFSS Event Driver processing"
 ;
 S XMDUZ="PFSS EVENT DRIVER"
 S XMY("G.SD RSA API ERRORS")=""
 S XMB="SD API ERROR NOTICE"
 S XMB(1)=$$GET1^DIQ(2,DFN,.01)
 S XMB(2)=$$FMTE^XLFDT(SDT)
 S XMB(3)=$$GET1^DIQ(44,SDCL,.01)
 S XMB(4)=IBBEVENT
 S XMB(5)=MSG
 D ^XMB
 Q
 ;
GETEVT(EVT) ; Return message type for appointment event
 ; The following appoint events will return the indicated message type
 ;   MAKE              A05
 ;   CHECK-IN          A04
 ;   CHECK-OUT         A03
 ;   NO-SHOW           A38
 ;
 ;   CANCEL APPT.      A38
 ;   CANCEL CHECK-IN   A11
 ;   CANCEL CHECK-OUT  A13
 ;   CANCEL NO-SHOW    A05
 ;
 Q $S(EVT="MAKE":"A05",EVT="CHECK-IN":"A04",EVT="CHECK-OUT":"A03",EVT="NO-SHOW":"A38",EVT="CANCEL":"A38",EVT="DELETE CO":"A13",EVT="DELETE CI":"A11",EVT="DELETE NS":"A05",1:"")
