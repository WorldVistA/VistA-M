VAFCTF ;BIR/DLR-Utility for capturing patient's Date Last Treated and Event Reason ;9/9/2002
 ;;5.3;Registration;**428,713,766**;Aug 13, 1993;Build 3
 Q  ; quit if called from the top
 ;
 ;Reference to ^SCE("ADFN" supported by IA# 2953
 ;Reference to EXC^RGHLLOG supported by IA# 2796
 ;Reference to $$ICNLC^MPIF001 supported by IA #3072
 ;
EN1(VAFCDFN,VAFCSUP) ; determine the LAST TREATMENT DATE for a single
 ; patient
 ; input: VAFCDFN - the dfn of the patient
 ;        VAFCSUP - if 1, suppress add entries to the ADT HL7 PIVOT
 ;                (#391.71) file for TF messaging - VAFCTFMF (optional)
 ; output: VAFCDATE - patient's DATE LAST TREATED
 ;         VAFCENVR - event reason
 ;
 N ERR,VAFCSITE,VAFCLAST,VAFCSITE,VAFCADMD,VAFCENDT,VAFCDATE,VAFCENVR,VAFCTYPE
 S U="^"
 S:'$D(VAFCSITE) VAFCSITE=$$KSP^XUPARAM("INST") ;defines the local facility
 S (VAFCLAST,VAFCADMD)=$$ADMDIS(VAFCDFN) ; dt_"^"_event type or ""
 S VAFCADMD=$S(VAFCADMD]"":$P(VAFCADMD,"^"),1:"") ; event dt or null
 S:$P(VAFCLAST,"^",2)=3!(VAFCLAST="") VAFCENDT=$$ENCDT(VAFCDFN,VAFCADMD)
 ; patient has been discharged or has never been admitted.  Has this
 ; individual been checked out of a clinic? 
 I $D(VAFCENDT)#2,($P(VAFCLAST,U)) S VAFCLAST=$S(+VAFCENDT>+VAFCLAST:VAFCENDT,1:VAFCLAST)
 I $D(VAFCENDT)#2,('$P(VAFCLAST,U)) S VAFCLAST=VAFCENDT
 S VAFCTYPE=$P(VAFCLAST,"^",2),VAFCDATE=+VAFCLAST
 ; input variables to FILE^VAFCTFU
 ; VAFCDFN - patient ien ; VAFCSITE - treating facility
 ; VAFCDATE - date last treated ; VAFCENVR - event reason
 ;
 I +VAFCDATE'>0 S VAFCDATE="",VAFCENVR=""
 I +VAFCDATE>0 S VAFCENVR=$S(VAFCTYPE=1:"A1",VAFCTYPE=3:"A2",1:"A3") ;A1=adm;A2=dis;A3=CO
 N STA,ICN S ICN=$$ICNLC^MPIF001(VAFCDFN),STA=$P($$SITE^VASITE,"^",3)
 D FILE^VAFCTFU(VAFCDFN,VAFCSITE_U_VAFCDATE_U_VAFCENVR,$G(VAFCSUP),1,.ERR) I $D(ERR(STA)) D EXC^RGHLLOG(212,ERR(STA),VAFCDFN)
 ;
 Q
ADMDIS(DFN) ; find the patient's last admission and discharge dates if
 ; they exist.
 ; Input: DFN - ien of the patient (file 2)
 ;Output: a valid discharge/admission date/time concatenated with
 ;        the event type (1=admission, 3=discharge) -or- null
 N %,VAERR,VAIP S VAIP("D")="LAST" D IN5^VADPT
 I '+$G(VAIP(17,1)),('+$G(VAIP(13,1))) Q ""
 ; no discharge date, no admission date, return null
 I '+$G(VAIP(17,1)) Q $P($G(VAIP(13,1)),U)_"^1"
 ; no discharge date, return admission date
 I '+$G(VAIP(13,1)) Q $P($G(VAIP(17,1)),U)_"^3"
 ; no admission date, return discharge date
 I +$G(VAIP(17,1))>(+$G(VAIP(13,1))) Q +$G(VAIP(17,1))_"^3"
 ; return discharge date
 Q +$G(VAIP(13,1))_"^1" ; return admission date
 ;
ENCDT(DFN,INPDT) ; find the last patient check out date/time.  'ADFN'
 ; cross-reference accessed through DBIA: 2953
 ; Input: DFN  - ien of the patient (file 2)
 ;        INPDT - date (if any) returned from the inpatient admission/
 ;               discharge subroutine     
 ;Output: a valid discharge/admission date/time concatenated with
 ;        the event type (5=check out) -or- null
 Q:'DFN "" ; we need dfn defined
 N VAFCDATA,VAFCPURG,VAFCX,VAFCX1,VAFCX2,VAFCX3
 S VAFCX=9999999.9999999,VAFCX2=0,VAFCX3=""
 F  S VAFCX=$O(^SCE("ADFN",DFN,VAFCX),-1) Q:'VAFCX!(INPDT>VAFCX)  D  Q:VAFCX2
 . S VAFCX1=0 F  S VAFCX1=$O(^SCE("ADFN",DFN,VAFCX,VAFCX1)) Q:'VAFCX1  D  Q:VAFCX2
 .. D GETGEN^SDOE(VAFCX1,"VAFCDATA")
 .. D PARSE^SDOE(.VAFCDATA,"EXTERNAL","VAFCPARS")
 .. I $G(VAFCPARS(.12))="CHECKED OUT" S VAFCX2=1,VAFCX3=VAFCX
 .. K VAFCDATA,VAFCPARS
 .. Q
 . Q
 K VAFCDATA,VAFCPURG,VAFCX,VAFCX1,VAFCX2
 ;DG*5.3*766
 I $E(VAFCX3,9,10)>23 S VAFCX3=$E(VAFCX3,1,8)_"23"_$E(VAFCX3,11,14)
 I $E(VAFCX3,11)>5 S VAFCX3=$E(VAFCX3,1,10)_"59"_$E(VAFCX3,13,14)
 ;DG*5.3*713
 I $E(VAFCX3,13)>5 S VAFCX3=$E(VAFCX3,1,12)_"59"
 Q VAFCX3_"^5" ; X is either null or the date/time of the check out
 ;
