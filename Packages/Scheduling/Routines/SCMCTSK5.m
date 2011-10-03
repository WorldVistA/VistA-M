SCMCTSK5 ;ALB/JDS - PCMM Inactivation Reports ; 03 Jun 2004  3:30 PM
 ;;5.3;Scheduling;**297,532**;AUG 13, 1993;Build 21
 Q
FLAG ;
 ;;Patients scheduled for inactivation from their Primary Care team and
 ;;Primary Care Provider assignments appear below.  Inactivation will 
 ;;occur on the Scheduled Date for Inactivation date unless the patient
 ;;has a completed appointment encounter with their current Primary Care
 ;;Provider (PCP) or their Associate Primary Care Provider (AP) before
 ;;that date.  The patient may be reactivated to their previous PCP and PC
 ;;team if they return for care.
 ;; 
 ;;VHA DIRECTIVE 2003-063, ACTIVE PATIENTS IN PCMM, establishes the rules for
 ;;PCMM automated inactivation of patients.  The following is from that Directive.
 ;;  
 ;;Inactivation of primary care patients from a PCMM panel occurs under the
 ;;following circumstances: 
 ;;(2) (a) The patient expires and 
 ;;(b) Newly assigned patients (either newly-enrolled patients or patients who
 ;;have been re-assigned to a different provider) who have not been seen by
 ;;their PCP or Associate Provider (AP) and 12 months have passed since
 ;;the time of assignment to that provider.  This provides every PCP a 1-year
 ;;grace period for seeing patients added to their panel (either newly-enrolled
 ;;patients or patients transferred from a different panel) before they are
 ;;inactivated.  Patients must be seen by their PCP or AP within 12 months of
 ;;being assigned, or they need to be inactivated from the PCP's panel.
 ;;(c) Established patients that have been assigned to the PCP's panel for more 
 ;;than 12 months, but have not been seen by their PCP or AP in the past 24 months
 ;;need to be inactivated.
 ;;(3) Patients appropriate for removal are to be identified and inactivated on
 ;;a regular basis.  
 ;;  
 ;;With PCMM patch SD*5.3*297 installed, inactivations occur on the fifteenth
 ;;and the last day of the month.
 ;;  
 ;;Patients Scheduled for Inactivation from Primary Care panels
 ;;                                                           Date
 ;;                                                           Scheduled       
 ;;Patient Name         SSN  Provider          Team           for Inactivation
 ;;------------------------------------------------------------------------------
 Q
EXT ;
 ;;By using the Extend Patients Inactivation Date option, these patients'
 ;;PCMM inactivation dates are now 60 days from their original inactivation date.
 ;;Inactivation will occur on the Date Scheduled for Inactivation unless the
 ;;patient has a completed appointment encounter with their current Primary
 ;;Care Provider (PCP) or their Associate Primary Care Provider (AP) before
 ;;that date.  
 ;;VHA DIRECTIVE 2003-063, ACTIVE PATIENTS IN PCMM,  establishes the rules for
 ;;PCMM automated inactivation of patients.  The following is from that Directive.
 ;;  
 ;;Inactivation of primary care patients from a PCMM panel occurs under the
 ;;following circumstances: 
 ;;(2) (a) The patient expires and 
 ;;(b) Newly assigned patients (either newly-enrolled patients or patients who
 ;;have been re-assigned to a different provider) who have not been seen by
 ;;their PCP or Associate Provider (AP) and 12 months have passed since
 ;;the time of assignment to that provider.  This provides every PCP a 1-year
 ;;grace period for seeing patients added to their panel (either newly-enrolled
 ;;patients or patients transferred from a different panel) before they are
 ;;inactivated.  Patients must be seen by their PCP or AP within 12 months of
 ;;being assigned, or they need to be inactivated from the PCP's panel.
 ;;(c) Established patients that have been assigned to the PCP's panel for more 
 ;;than 12 months, but have not been seen by their PCP or AP in the past 24 months
 ;;need to be inactivated.
 ;;(3) Patients appropriate for removal are to be identified and inactivated on
 ;;a regular basis.
 ;;    
 ;;With PCMM patch SD*5.3*297 installed, inactivations occur on the fifteenth
 ;;and the last day of the month. 
 ;;  
 ;;Patients with Extended PCMM Inactivation Dates
 ;;                                                           Date
 ;;                                                           Scheduled for   
 ;;Patient Name         SSN  Provider         Team            Inactivation
 ;;------------------------------------------------------------------------------
 Q
INACT ;
 ;;Patients inactivated from their Primary Care team and Primary Care Provider
 ;;assignments appear below.  The patient may be reactivated to their previous PCP
 ;;and PC team if they return for care.
 ;;VHA DIRECTIVE 2003-063, ACTIVE PATIENTS IN PCMM, establishes the rules for PCMM
 ;;automated inactivation of patients.  The following is from that Directive.
 ;;  
 ;;Inactivation of primary care patients from a PCMM panel occurs under the
 ;;following circumstances: 
 ;;(2) (a) The patient expires and 
 ;;(b) Newly assigned patients (either newly-enrolled patients or patients who
 ;;have been re-assigned to a different provider) who have not been seen by
 ;;their PCP or Associate Provider (AP) and 12 months have passed since
 ;;the time of assignment to that provider.  This provides every PCP a 1-year
 ;;grace period for seeing patients added to their panel (either newly-enrolled
 ;;patients or patients transferred from a different panel) before they are
 ;;inactivated.  Patients must be seen by their PCP or AP within 12 months of
 ;;being assigned, or they need to be inactivated from the PCP's panel.
 ;;(c) Established patients that have been assigned to the PCP's panel for more 
 ;;than 12 months, but have not been seen by their PCP or AP in the past 24 months
 ;;need to be inactivated.
 ;;(3) Patients appropriate for removal are to be identified and inactivated on
 ;;a regular basis..
 ;;  
 ;;With PCMM patch SD*5.3*297 installed, inactivations occur on the fifteenth
 ;;and the last day of the month. 
 ;; 
 ;;Patients Automated Inactivations from Primary Care Panels
 ;;                                                           Date        Reason
 ;;                                                           Patient     Patient
 ;;Patient Name         SSN  Provider          Team           Inact       Inact
 ;;-------------------------------------------------------------------------------
 Q
PRIN ;
 ;;WARNING- The following primary care staff will be automatically
 ;;inactivated in PCMM software if a correct 'Person Class' and 
 ;;'Provider Type' are not entered in the New Person File (#200) or
 ;;their role and position in the 'Position Setup' window is not 
 ;;corrected to correspond with their 'Provider Type', 'Person
 ;;Class' and the Primary Care business rules stated below:
 ;;  
 ;;1. Staff designated as Primary Care Providers (PCPs) in PCMM that
 ;;   are not an Attending physician (Attending MD or Attending DO) NP
 ;;   or PA, shall be inactivated from PCMM
 ;;2. Staff designated as Associate Providers (APs) in PCMM, that are not
 ;;   a Resident/Intern (Physician) NP or PA shall be inactivated in 
 ;;   PCMM
 ;;3. All persons designated as an Associate Provider or Primary Care 
 ;;   Provider, who do not have the correct 'Provider Type' and 'Person
 ;;   Class' entered in the New Person file (#200) in VistA, shall be 
 ;;   inactivated from their Primary Care positions in PCMM.
 ;;4. Please contact your PCMM Coordinator or Information Systems 
 ;;   to correct these problems
 ;;  
 ;;  PRIMARY CARE PROVIDERS SCHEDULDED FOR INACTIVATION
 ;;  
 ;;Provider's     Assoc     Team                      Person    # of Pts  Sch Inac
 ;;Name           Clinics   Position   Role           Class     Assigned  Date 
 ;;-------------------------------------------------------------------------------
 ;;  
 Q
GONE ;
 ;;  PRIMARY CARE PROVIDERS INACTIVATED
 ;; 
 ;;Provider's     Assoc     Team                      Person    # of Pts  Inac
 ;;Name           Clinics   Position   Role           Class     Assigned  Date   
 ;;-------------------------------------------------------------------------------
 ;;    
 Q
MAIL(POS,T)       ;Given POS as position set up who gets mail 
 I $D(^TMP("SCML",$J,"POS",POS)) Q
 S ^TMP("SCML",$J,"POS",+$G(POS))=""
 ;who gets mail at this position 
 N TWO S TWO=$G(^SCTM(404.57,+$G(POS),2))
 I $P(TWO,U,10) D  ;get preceptor
 .S PREC=+$$OKPREC3^SCMCLK(POS,DT) Q:'PREC
 .D POS(PREC)
 I $P(TWO,U,9)="T" D  ;get team providers
 .S T=$G(T)
 .N I F I=0:0 S I=$O(^SCTM(404.57,"C",T,I)) Q:'I  D POS(I)
 I $P(TWO,U,9)="P" D  ;get position providers
 .D POS(POS) Q
 Q
POS(P) ;provider
 N A
 S A=+$$GETPRTP^SCAPMCU2(P,DT) Q:'A
 S ^TMP("SCML",$J,"POS",A)=""
 S ^TMP("SCML",$J,"XM",A,POS)=""
 Q
LINES(TYPE) ;Lines of Bulletin
 N I,ZERO,ZERO1,Y
 S Y=$$PDAT^SCMCGU("SD*5.3*297") X ^DD("DD")
 F I=1:1 S A=$P($T(@($P("FLAG^INACT^EXT^PRIN^GONE",U,TYPE))+I),";;",2) Q:A=""  D
 .S ^TMP("SCMCTXT",$J,I,0)=$S(A["|DATE|":$P(A,"|DATE|",1)_Y,1:A)
 ;S ^TMP("SCMCTXT",$J,2,0)="Patient                   Team                 Position           Dt "_$S($G(XMSUB)["Fla":"Flagged",1:"Inactivate")
 S (CNT,HEAD)=$O(^TMP("SCMCTXT",$J,99),-1)+1
 S DIV=""
 F I=0:0 S I=$O(^TMP("SCMC",$J,I)) Q:'I  S ENTRY=+$O(^(I,0)) D
 .I TYPE>3 D MM(TYPE) Q
 .S ZERO=$G(^SCPT(404.43,+ENTRY,0)),ZERO1=$G(^SCPT(404.42,+ZERO,0))
 .D MAIL(+$P(ZERO,U,2),+$P(ZERO1,U,3)) ;find out which individuals get this
 .D MAKEMAIL(TYPE)
 Q
MAKEMAIL(TYPE)  ;
 D MAKEMAIL^SCMCTSK6(TYPE) Q
MM(TYPE)        ;for providers
 D MM^SCMCTSK6(TYPE) Q
PRMAIL(TYPE)    ;
 ;Send mail to providers
 D PRMAIL^SCMCTSK6(TYPE)
