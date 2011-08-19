IBDFRPC3 ;ALB/AAS - AICS Identify patient form form id ; 12-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**6,3,17**;APR 24, 1997
 ;
 ; -- used by AICS Data Entry System (routine IBDFDE)
 ;    used by AICS Workstation software
 ;
IDPAT(RESULT,FORMID) ; -- Procedure
 ; -- Broker call to identify patient, clinic, form, and appt. from
 ;    Encounter form ID
 ;    rpc := IBD EXPAND FORMID
 ;
 ; -- input  FORMID = pointer to form tracking (357.96)
 ;                    if Formid := Formid_"LOOKUP" then no errors created
 ;           Result = called by reference
 ;
 ; -- output  The format of the returned array is as follows
 ;        result = $p1 :=  Patient Name^
 ;                 $p2 :=  Patient IEN
 ;                 $p3 :=  patient primary identifier (pid)
 ;                 $p4 :=  form name
 ;                 $p5 :=  form IEN (pointer to 357)
 ;                 $p6 :=  Clinic Name 
 ;                 $p7 :=  Clinic ien
 ;                 $p8 :=  Clinic Physical Location
 ;                 $p9 :=  Appt. date/time (fm format)
 ;                 $P10:=  Appt. date/time (external format)
 ;                 $P11:=  Appt Status internal
 ;                 $P12:=  Appt Status external
 ;                 $P13:=  form input status internal
 ;                 $p14:=  form input status external
 ;                 $p15:=  form definition ien (357.95)
 ;                 $p16:=  default provider (for clinic) internal
 ;                 $p17:=  default provider (for clinic) external
 ;                 $P18:=  # Scannable pages on form
 ;                 $p19:=  shortedge/long edge binding
 ;                 $p20:=  check out date time
 ;
 N C,I,J,X,Y,NODE,PATNM,DFN,PID,CLIN,CLINNM,FORMNM,FORM,APPT,APPTNM,STATUS,STATNM,FRMDEF,PROVDEF,APPTSTI,APPTSTE,CLINPH,DUPLX,SCANPG,CO,LOOKUP
 K RESULT
 S FORMID("SOURCE")=1
 S LOOKUP=0
 ;
 ; -- formid is for lookup only
 I $E(FORMID,($L(FORMID)-5),$L(FORMID))="LOOKUP" S FORMID=+FORMID,LOOKUP=1
 ;
 ; -- scanner may send in leading spaces, strip it off
 I +FORMID'=FORMID,$L(FORMID) S FORMID=+$P(FORMID," ",3)
 S RESULT="Form ID not a valid value, null or zero^^^"
 I '$G(FORMID) D:'$G(LOOKUP) LOGERR^IBDF18E2(3579604,.FORMID) G IDPATQ
 ;
 S RESULT="Form ID not found^^^"
 S NODE=$G(^IBD(357.96,+FORMID,0))
 I NODE="" D:'$G(LOOKUP) LOGERR^IBDF18E2(3579605,.FORMID) G IDPATQ
 ;
 S DFN=+$P(NODE,"^",2)
 I 'DFN S RESULT="Patient Information is Missing^^^^" G IDPATQ
 S PATNM=$P($G(^DPT(DFN,0)),"^"),PID=$P($G(^DPT(DFN,.36)),"^",3)
 S APPT=+$P(NODE,"^",3)
 S APPTSTI=$P($G(^DPT(DFN,"S",APPT,0)),"^",2)
 S APPTNM=$$FMTE^XLFDT(APPT)
 ;
 S X=$$STATUS^SDAM1(DFN,APPT,+$G(^DPT(DFN,"S",APPT,0)),$G(^(0)))
 S APPTSTE=$P(X,";",3),CO=$P(X,";",5)
 I $G(^DPT(DFN,"S",APPT,0))="",CO="" D
 .S CO=+$$SDV(DFN,APPT)
 .I CO S APPTSTE="COMPLETE"
 .I +$G(CO)<1 S APPTSTE="ACTION REQUIRED"
 ;
 S CLIN=+$P(NODE,"^",10)
 S CLINNM=$P($G(^SC(CLIN,0)),"^"),CLINPH=$P($G(^SC(CLIN,0)),"^",11)
 S PROVDEF=$$PRDEF(CLIN)
 S FRMDEF=$P(NODE,"^",4)
 S FORM=+$P($G(^IBD(357.95,+FRMDEF,0)),"^",21)
 S FORMNM=$P($G(^IBE(357,FORM,0)),"^")
 S DUPLX=$P($G(^IBE(357,FORM,0)),"^",2) ; Duplex/simplex
 S (SCANPG,I)=0 F  S I=$O(^IBD(357.96,+FORMID,9,I)) Q:'I  S SCANPG=SCANPG+1
 S STATUS=$P(NODE,"^",11)
 S Y=STATUS,C=$P(^DD(357.96,.11,0),"^",2) D Y^DIQ S STATNM=Y
 S RESULT=PATNM_"^"_DFN_"^"_PID_"^"_FORMNM_"^"_FORM_"^"_CLINNM_"^"_CLIN_"^"_CLINPH_"^"_APPT_"^"_APPTNM_"^"_APPTSTI_"^"_APPTSTE_"^"_STATUS_"^"_STATNM_"^"_FRMDEF_"^"_PROVDEF_"^"_$P($G(^VA(200,+PROVDEF,0)),"^")_"^"_SCANPG_"^"_DUPLX_"^"_CO
 ;
IDPATQ Q
 ;
PRDEF(CLIN) ;Provider Default for Clinic
 ; Input  -- SDCL     Hospital Location file IEN
 ; IF DEFINED: DFN - ptr to PATIENT File
 ; Output -- Default
 N Y,X
 S Y=$P($G(^SC(+$G(CLIN),"PR",+$O(^SC("ADPR",CLIN,0)),0)),"^")
 I $G(Y)="",$G(^SC(+$G(CLIN),"PC")),$D(DFN),$L($T(NMPCPR^SCAPMCU2)) S Y=+$$NMPCPR^SCAPMCU2(DFN,DT,1)
 Q $G(Y)
 ;
SDV(DFN,APPT) ; -- try to find checkout date of stand alone encounter
 N CO,IBOE,IBVAL,IBCBK
 S CO="",IBOE=""
 S IBVAL("DFN")=DFN,IBVAL("BDT")=APPT,IBVAL("EDT")=APPT+.000001
 S IBCBK="I '$P(Y0,U,6),$P(Y0,U,8)=3 S IBOE=Y,CO=$P(Y0,U,7),SDSTOP=1"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,"",IBCBK,1)
 Q CO_"^"_IBOE
 ;
