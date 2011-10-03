PXUTLVST ;ISL/dee - Looks up the visit to see if there is already one ;8/6/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 Q
 ;
LOOKVSIT(PAT,VDT,LOC,DSS,INS,TYP) ;Calls visit tracking to see if there is already a visit.
 ;Get the visit for the appointment is there is one
 N APPTVST
 S APPTVST=$$APPT2VST^PXUTL1(PAT,VDT,LOC)
 I APPTVST>0 Q APPTVST
 ;
 N VSIT,VSITPKG
 S VSIT("IEN")=""
 S VSIT("VDT")=VDT
 S VSIT("PAT")=PAT
 S VSIT("LOC")=LOC
 S VSIT("INS")=$G(INS)
 S VSIT("TYP")=$G(TYP)
 S VSIT("DSS")=$G(DSS)
 I VSIT("DSS")="",$P($G(^SC(+VSIT("LOC"),0)),"^",7)>0 S VSIT("DSS")=$P(^SC(+VSIT("LOC"),0),"^",7)
 S VSITPKG="PX"
 S VSIT(0)="D0EM"
 ;
 ;CALL FOR VSIT
 D ^VSIT
 I '$D(VSIT("IEN"))#2 Q -1
 Q $P(VSIT("IEN"),"^",1)
 ;
