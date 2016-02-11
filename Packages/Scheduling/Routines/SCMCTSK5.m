SCMCTSK5 ;ALB/JDS - PCMM Inactivation Reports ;01/28/2013
 ;;5.3;Scheduling;**297,532,539,603**;AUG 13, 1993;Build 79
 ;
 Q
FLAG ;
 ;;Patients scheduled for inactivation from their Patient Aligned Care
 ;;Team (PACT) assignments appear below.
 ;;  
 ;;Flagging of primary care patients from a PCMM panel occurs each time
 ;;this Inactivation Task is run.
 ;;All providers assigned to a particular position are evaluated.  
 ;;If a patient is assigned to PC position and a provider assigned to that
 ;;position has a preceptor all encounters for that patient will be
 ;;checked for matches with either the provider (preceptee) assigned to
 ;;that position or the provider (preceptor) assigned as preceptor to that
 ;;position. If a patient is assigned to the PC preceptor position then only
 ;;the encounters with the provider assigned as preceptor will be evaluated.
 ;;(a) If a patient is NEW as assigned to the position 12 months or less,
 ;;and it is the 8th month since being assigned to the position,
 ;;and the patient had no prior encounters with the PCP/APs in the preceding
 ;;8 months + 7 days then the patient is flagged for inactivation.
 ;;(b) If a patient is ESTABLISHED as assigned to the position more than
 ;;12 months and if the patient had no prior encounters with the PCP/AP in
 ;;the preceding 20 months + 7 days the patient is flagged for inactivation.
 ;;Inactivation will occur on the fifteenth and the last day of the month
 ;;unless the patient has a completed appointment encounter with their current
 ;;Primary Care Provider (PCP) or their Associate Primary Care Provider (AP)
 ;;before that date. The patient may be reactivated to their previous PCP and PC
 ;;team if they return for care.
 ;;This message is generated each time when at least one new occurrence of
 ;;flagging for inactivation takes place, and unconditionally on the 15th and
 ;;the last day of a month.
 ;;Patients scheduled for Inactivation from Primary Care panels
 ;;                                                            Dates
 ;;                                                            Scheduled
 ;;Patient Name        SSN Provider            Team            for Inactivation
 ;;----------------------------------------------------------------------------
 Q
EXT ;
 ;;By using the Extend Patient Inactivation Date option, these patients'
 ;;PCMM inactivation dates are now 183 days from their original inactivation date.
 ;;Inactivation occurs on the fifteenth and the last day of the month, unless
 ;;the patient has a completed appointment encounter with their current
 ;;Primary Care Provider (PCP) or their Associate Primary Care Provider (AP)
 ;;before that date. The patient may be reactivated to their previous PCP and PC
 ;;team if they return for care.
 ;;Patients with Extended PCMM Inactivation Dates
 ;;                                                        Date
 ;;                                                        Scheduled for
 ;;Patient Name         SSN  Provider         Team         Inactivation
 ;;---------------------------------------------------------------------------
 Q
INACT ;
 ;;Patients inactivated from their Patient Aligned Care Team (PACT)
 ;;assignments appear below.
 ;;Inactivation occurs on the fifteenth and the last day of a month, unless
 ;;the patient has a completed appointment encounter with their current
 ;;Primary Care Provider (PCP) or their Associate Primary Care Provider (AP)
 ;;before that date.
 ;;Inactivation of primary care patients from a PCMM panel occurs under
 ;;the following circumstances:
 ;;(a) The patient expires
 ;;(b) Newly assigned patients (either newly-enrolled patients or patients who    
 ;;have been re-assigned to a different provider) who have not been seen by 
 ;;their PCP or Associate Provider (AP) and 12 months have passed since the 
 ;;time of assignment to that provider.  This provides every PCP a 1-year grace
 ;;period for seeing patients added to their panel (either newly-enrolled
 ;;patients or patients transferred from a different panel) before they are
 ;;inactivated. Patients must be seen by their PCP or AP within 8 months +7 days
 ;;of being assigned, or they need to be inactivated from the PCP's panel.
 ;;(c) Established patients that have been assigned to the PCP's panel for more 
 ;;than 12 months, but have not been seen by their PCP or AP in the past
 ;;20 months +7 days need to be inactivated.
 ;;The patient may be reactivated to their previous PCP and PC team if they
 ;;return for care.
 ;;Patients Automated Inactivation from Primary Care Panels
 ;;                                                           Patient     Patient
 ;;Patient Name         SSN  Provider          Team           Inact Date  Inact
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
