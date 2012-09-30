MDPRE12 ;HINES OIFO/TJ - Pre Installation Tasks;02 Mar 2008
 ;;1.0;CLINICAL PROCEDURES;**12**;Apr 01, 2004;Build 318
 ;Per VHA Directive 2004-038, this MDCRTN should not be modified.
 ;
 ; This routine uses the following IAs:
 ;
 ;  # 2263       - XPAR calls                   TOOLKIT                        (supported)
 ;  # 4447       - POSTKID^VDEFVU               VDEF             (controlled subscription)
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;
EN ; Deactivate CP Flowsheets-VDEF
 ;
 N MDX,MDTASK,MDTMP
 D GETLST^XPAR(.MDTMP,"SYS","MD PARAMETERS","Q")
 F MDX=0:0 S MDX=$O(MDTMP(MDX)) Q:'MDX  D:MDTMP(MDX)?1"TASK_".E
 .S MDTASK($P(MDTMP(MDX),"^",1))=$P(MDTMP(MDX),"^",2)
 .D EN^XPAR("SYS","MD PARAMETERS",$P(MDTMP(MDX),"^",1),"@")
 ;
 ; Now rebuild the one that we want to keep
 ;
 S MDTASK("TASK_HL7_CLEANUP")=$G(MDTASK("TASK_HL7_CLEANUP"),"0;;;0")
 ;
 S $P(MDTASK("TASK_HL7_CLEANUP"),";",2)="HL7 Cleanup"
 S $P(MDTASK("TASK_HL7_CLEANUP"),";",3)="HL7 MDCPURG"
 ;
 ; Save them back to XPAR
 ;
 D MES^XPDUTL(" MD*1.0*12 Pre Init begin")
 F MDX="TASK_HL7_CLEANUP" D
 .D EN^XPAR("SYS","MD PARAMETERS",MDX,MDTASK(MDX))
 .D MES^XPDUTL(" Task '"_MDX_"' updated...")
 ;
 ;
 ;
 ; IA 4447.
 ;
 ; Event subtypes:
 ;   CPAN - CLIO Admit/Visit Notification (A01)
 ;   CPCAN - CLIO Cancel Admit Notice (A11)
 ;   CPCDE - CLIO Cancel Discharge (A13)
 ;   CPCT - CLIO Cancel Transfer (A12)
 ;   CPDE - CLIO Discharge/End Visit (A03)
 ;   CPTP - CLIO Transfer a Patient (A02)
 ;   CPUPI - CLIO Update Patient Info (A08)
 ;
 ; Message/Event types - Protocols - Extraction Program
 ;   ADT/A01 - MDC CPAN VS   - MDCA01
 ;   ADT/A02 - MDC CPTP VS   - MDCA02
 ;   ADT/A03 - MDC CPDE VS   - MDCA03
 ;   ADT/A08 - MDC CPUPI VS  - MDCA08
 ;   ADT/A11 - MDC CPCAN VS  - MDCA11
 ;   ADT/A12 - MDC CPCT VS   - MDCA12
 ;   ADT/A13 - MDC CPCDE VS  - MDCA13
 ;
 D POSTKID^VDEFVU("ADT","A01","CPAN","MDC CPAN VS","CLINICAL PROCEDURES","MDCA01","CLIO Admit/Visit Notification (A01)","CLIO Admit/Visit Notification (A01)")
 D POSTKID^VDEFVU("ADT","A02","CPTP","MDC CPTP VS","CLINICAL PROCEDURES","MDCA02","CLIO Transfer a Patient (A02)","CLIO Transfer a Patient (A02)")
 D POSTKID^VDEFVU("ADT","A03","CPDE","MDC CPDE VS","CLINICAL PROCEDURES","MDCA03","CLIO Discharge/End Visit (A03)","CLIO Discharge/End Visit (A03)")
 D POSTKID^VDEFVU("ADT","A08","CPUPI","MDC CPUPI VS","CLINICAL PROCEDURES","MDCA08","CLIO Update Patient Info (A08)","CLIO Update Patient Info (A08)")
 D POSTKID^VDEFVU("ADT","A11","CPCAN","MDC CPCAN VS","CLINICAL PROCEDURES","MDCA11","CLIO Cancel Admit Notice (A11)","CLIO Cancel Admit Notice (A11)")
 D POSTKID^VDEFVU("ADT","A12","CPCT","MDC CPCT VS","CLINICAL PROCEDURES","MDCA12","CLIO Cancel Transfer (A12)","CLIO Cancel Transfer (A12)")
 D POSTKID^VDEFVU("ADT","A13","CPCDE","MDC CPCDE VS","CLINICAL PROCEDURES","MDCA13","CLIO Cancel Discharge (A13)","CLIO Cancel Discharge (A13)")
 D MES^XPDUTL(" CP Flowsheets - VDEF entries have been deactivated")
 D MES^XPDUTL(" MD*1.0*12 Pre Init complete")
 Q
 ;
