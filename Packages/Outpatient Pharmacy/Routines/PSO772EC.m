PSO772EC ;BIR/JCH-Environment Check for patch PSO*7*772 ;03/31/2025
 ;;7.0;OUTPATIENT PHARMACY;**772**;9/30/97;Build 105
 ;
 ; This Environment Check Routine is executed during the installation of PSO*7*772.
 ; If any custom ASAP definitions exist in the SPMP ASAP RECORD DEFINITION FILE (#58.4) that were
 ; not installed by patch PSO*7*772, the check will fail and the installation is aborted.
 ;
 N STDCUS,ASAPTXT
 K XPDQUIT S XPDQUIT=0
 F PSOASVER="4.2A","4.2AZ","4.2B","4.2BZ","5.0","5.0Z" S STDCUS(PSOASVER)=$$CUSSASAP(PSOASVER) I STDCUS(PSOASVER) S ASAPTXT=$G(ASAPTXT)_", "_PSOASVER
 ;
 S ASAPTXT=$P($G(ASAPTXT),", ",2,99) S STDCUS=$S(ASAPTXT="":0,1:+$L($G(ASAPTXT),","))
 Q:'STDCUS
 S XPDQUIT=1
 D MES^XPDUTL("A non-standard version of ASAP definition"_$S(STDCUS>1:"s",1:"")_" "_ASAPTXT)
 D MES^XPDUTL("exist"_$S($G(STDCUS)=1:"s",1:"")_" in the SPMP ASAP RECORD DEFINITION file (#58.4). Remove")
 D MES^XPDUTL("or rename"_$S(STDCUS>1:" these ASAP definitions",1:" this ASAP definition")_" before installing this patch.")
 ;
 Q
 ;
CUSSASAP(PSOASVER) ; Check to see if a Custom ASAP definition exists in the STANDARD node or CUSTOM node
 ;                  of the SPMP ASAP RECORD DEFINITION FILE (#58.4) for PSOASVER
 ;
 N ASAPIENS,ASAPIENC,ASAPERR,ASAPND,COPIED,LOCKED
 Q:PSOASVER="" 0  ; Nothing to check
 I (PSOASVER'="5.0")&(PSOASVER'="4.2A")&(PSOASVER'="4.2B")&(PSOASVER'="4.2AZ")&(PSOASVER'="4.2BZ")&(PSOASVER'="5.0Z") Q 0  ; Not a 772 ASAP release
 Q:'$D(^PS(58.4,1,"VER","B",PSOASVER))&('$D(^PS(58.4,2,"VER","B",PSOASVER))) 0  ; Definition does not exist in standard node.
 ;
 ; Now we know an ASAP definition of 4.2A, 4.2B, and/or 5.0 exists in the STANDARD node or the CUSTOM node
 I '$$PATCH^XPDUTL("PSO*7.0*772") Q 1  ; If PSO*7*772 was never installed, must be a site custom ASAP definition
 S ASAPIENS=$$FIND1^DIC(58.4001,",1,","OX",PSOASVER,,,"ASAPERR")
 I 'ASAPIENS S ASAPIENC=$$FIND1^DIC(58.4001,",2,","OX",PSOASVER,,,"ASAPERR")
 I '$G(ASAPIENS)&'$G(ASAPIENC) D  Q 0
 . S ASAPERR=$G(ASAPERR("DIERR",1,"TEXT",1)) I $L(ASAPERR) D BMES^XPDUTL(ASAPERR)
 I '$D(^PS(58.4,1,"VER","B",PSOASVER))&'$D(^PS(58.4,2,"VER","B",PSOASVER)) Q 0
 I $G(ASAPIENS) S ASAPND=$G(^PS(58.4,1,"VER",+ASAPIENS,0)) Q:'$L(ASAPND) 0
 I $G(ASAPIENC) S ASAPND=$G(^PS(58.4,2,"VER",+ASAPIENC,0)) Q $S($L(ASAPND):1,1:0)
 S LOCKED=$P(ASAPND,"^",7) Q:LOCKED 0
 Q 1
