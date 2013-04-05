DVBABDOD ;ALB/SPH - FHIE SERVER RPC'S ; 04/21/2009
 ;;2.7;AMIE;**140**;Apr 10, 1995;Build 16
 ;
 ; This routine supports the following remote procedure calls:
 ;
 ;   RPC Name                 Tag
 ;   ----------------------   ---------
 ;   DVBAB DOD REPORT TYPES   RPTTYPS
 ;   DVBAB DOD INFO           INFOMSG
 ;   DVBAB DOD REPORT         SENDRPT
 ;   DVBAB FIND DFN BY ICN    ICN
 ;              
 ; The routine is designed specifically for the Federal Health Information
 ; Exchange (FHIE) server (Station 200). It is distributed nationally with
 ; the CAPRI application so the RPC's and this supporting routine are
 ; consistent on all systems using CAPRI.
 ;
 ;
SENDRPT(DVBABY,IEN,DATATYPE,BEGDATE,ENDDATE,ORMAX,DVBABTMP) ;return DOD report
 ;This remote procedure call returns a DOD report from the FHIE framework.
 ;
 ; -- rpc: DVBAB DOD REPORT
 ; 
 ; Supported References:
 ;  DBIA #3486: D GCPR^OMGCOAS1(IEN,DATATYPE,BEGDATE,ENDDATE,ORMAX) 
 ;
 ; Input:  IEN       = Patient's DFN
 ;         DATATYPE  = Type of data being requested:
 ;                       LRO - Lab Orders
 ;                       LRC - Chem & Hem
 ;                       SP  - Surgical Path
 ;                       CY  - Cytology
 ;                       MI  - Microbiology
 ;                       RR  - Radiology Report
 ;                       RXOP- All Outpatient RX
 ;                       ADT - ADT Summary
 ;                       DS  - Discharge Summary
 ;        
 ;                       RI  - Radiology Impression
 ;                       RXA - Active Outpatient RX
 ;                       ALRG - Allergies
 ;
 ;    TIUPRG - Progress Notes
 ;
 ;    Outpatient encounter
 ;    TIUPRG - Progress Notes
 ;
 ;         BEGDATE   = Beginning search date
 ;         ENDDATE   = Ending search date
 ;         ORMAX     = Max number of entries for report 
 ;
 ;quit if Clinical Observation Access Service (routine: OMGCOAS1) not installed
 Q:'$L($T(GCPR^OMGCOAS1))
 ;
 N DVBATXT
 ;
 S DVBABY=$NA(^TMP(DVBABTMP,$J))
 D GCPR^OMGCOAS1(IEN,DATATYPE,BEGDATE,ENDDATE,ORMAX)
 ; S ^TMP("CAPRI",DUZ)=IEN+"-"+DATATYPE+"-"+BEGDATE+"-"+ENDDATE+"-"+ORMAX
 S DVBATXT=IEN_","_DATATYPE_","_BEGDATE_","_ENDDATE_","_ORMAX_","_DVBABTMP
 S ^TMP("CAPRI",DUZ,$J)=DVBATXT
 ; K IEN,DATATYPE,BEGDATE,ENDDATE,ORMAX,DVBABTMP
 Q
 ;
RPTTYPS(Y) ;return list of available report types
 ;This remote procedure call returns a list of available report types.
 ; 
 ; -- rpc: DVBAB DOD REPORT TYPES
 ;
 S Y(1)="Allergies^ALRG^ORDATA"
 ;S Y(2)="Ambulatory Data^ADR^ORDATA"
 S Y(3)="Expanded ADT^ADT^ORDATA"
 S Y(4)="Consult Report^CONS^ORDATA"
 S Y(5)="Discharge Summary^DS^ORDATA"
 S Y(6)="Lab Orders^LRO^LRO"
 S Y(7)="Chem & Hem^LRC^LRC"
 S Y(8)="Surgical Path^SP^LRA"
 S Y(9)="Cytology^CY^LRCY"
 S Y(10)="Microbiology^MI^LRM"
 S Y(11)="Radiology Report^RR^RAE"
 S Y(12)="Outpatient RX^RXOP^PSOO"
 S Y(13)="Progress Notes^PN^ORDATA"
 Q
 ;
INFOMSG(Y) ;return DOD data message
 ;This remote procedure call returns a message to be displayed in CAPRI. 
 ;
 ; -- rpc: DVBAB DOD INFO
 ;
 S Y="NOTE:  DoD data at shared sites is available immediately.  All other sites will be available less than a week after discharge."
 Q
 ;
ICN(RESULT,DVBAICN) ;retrieve patient DFN
 ;
 ;This remote procedure call returns the patient's DFN associated
 ;with the ICN passed to the RPC. The DFN is the internal entry
 ;number in the Patient (#2) file.  
 ;
 ; -- rpc: DVBAB FIND DFN BY ICN
 ; 
 ;  Supported References:
 ;    DBIA #4679: GETDFN^VAFCTFU1
 ;
 ;  Input:
 ;   DVBAICN - patient's Integration Control Number
 ;    
 ; Output:
 ;    RESULT - global array containing patient's DFN, otherwise
 ;             an error msg if ICN can't be converted to a DFN
 ;
 N DVBADFN  ;patient DFN
 ;
 S DVBADFN=0
 K ^TMP("DVBAICN",$J)
 ;
 I $G(DVBAICN)>0 D
 . D GETDFN^VAFCTFU1(.DVBADFN,DVBAICN) ;convert icn to dfn
 S ^TMP("DVBAICN",$J,0)=$S(DVBADFN>0:DVBADFN,1:"NOT A VALID ICN")
 S RESULT=$NA(^TMP("DVBAICN",$J))
 Q
