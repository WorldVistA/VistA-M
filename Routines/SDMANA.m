SDMANA ;BP-CIOFO/KEITH - Make Appointment 'Next Available' functionality ; 30 Nov 99  2:38 PM
 ;;5.3;Scheduling;**206**;AUG 13, 1993
 ;
NAVA(SC,SDT,SDUR) ;Compute 'next available' indicator
 ;Input: SC=clinic ifn
 ;Input: SDT=date of appointment being scheduled
 ;Input: SDUR=User response (optional)
 ;            'N' for user defined 'next available' scheduling request
 ;            'C' other than 'next available' at clinician request
 ;            'P' other than 'next available' at patient request
 ;            'W' for walkin (unscheduled) appointment
 ;            'M' for multiple appointment booking
 ;            'A' for auto rebook
 ;
 ;Output: '0' = not defined or computed to be a 'next available' appt.
 ;        '1' = user defined 'next available' scheduling request
 ;        '2' = computed to be a 'next available' appointment
 ;        '3' = user defined and computed to be 'next available' appt.
 ;
 N SD,SDAY,SDOUT,SDIND
 ;Initialize variables
 S SDUR=$G(SDUR),SDT=SDT\1,(SDOUT,SDIND)=0 D INIT
 I SC'>0!'SDT!(SDT<DT) Q SDIND  ;Check input variables
 S SDAY=DT F  D  Q:SDOUT
 .I $$PCNT($$PAT(SC,SDAY)) S SDOUT=1,SDIND=$$IND(SDT,SDAY,SDUR) Q
 .S SDAY=$$FMADD^XLFDT(SDAY,1)  ;Increment days
 .I SDAY>SDT S SDOUT=1,SDIND=$$IND(SDT,SDAY,SDUR)
 .Q
 Q SDIND
 ;
IND(SDT,SDAY,SDUR) ;Compute indicator
 ;Input/Output: as described in NAVA entry point
 Q $S(SDAY=SDT:2,1:0)+$S(SDUR="N":1,1:0)
 ;
PAT(SC,SDT) ;Return pattern for specified date (modified clone of OVR^SDAUT1)
 ;Input: SC=clinic ifn
 ;Input: SDT=date of pattern
 ;Output: Current availability pattern for date selected
 ;        in the format of ^SC(clinic,"ST",date,1) nodes
 ;
 N SDI,SDIN,SDRE,SDSOH,SDD,SDJ,SDY,SDS,SDAY
 S SDT=SDT\1
 ;Inactivate/reactivate dates
 S SDIN=$G(^SC(SC,"I")),SDRE=$P(SDIN,U,2),SDIN=$P(SDIN,U)
 I '$$ACTIVE(SDT,SDIN,SDRE) Q ""  ;Quit if not active on this date
 S SDAY="SU^MO^TU^WE^TH^FR^SA" ;Day abbreviations
 S SDI=$P($G(^SC(SC,"SL")),U,6),SDI=$S(SDI<3:4,1:SDI) ;Increments/hour
 ;Schedule on holidays?
 S SDSOH=$S('$D(^SC(SC,"SL")):0,$P(^SC(SC,"SL"),"^",8)']"":0,1:1)
 Q:$O(^SC(SC,"T",0))>SDT ""  ;Earlier than first availability date
 S SDD=$$DOW^XLFDT(SDT,1)  ;Day of week
 K SDJ F SDY=0:1:6 I $D(^SC(+SC,"T"_SDY)) S SDJ(SDY)=""  ;Patterns
 I $D(^SC(+SC,"ST",SDT,1)) Q ^SC(+SC,"ST",SDT,1)  ;Current availability
 ;No ava. on file, quit if no pattern
 I '$D(^SC(SC,"ST",SDT,1)) S SDY=SDD#7 Q:'$D(SDJ(SDY)) ""
 ;Quit if holiday and no schedule
 Q:$D(^HOLIDAY(SDT))&('SDSOH) "   "_$E(SDT,6,7)_"    "_$P(^(SDT,0),U,2)
 ;Create availability string, quit if no pattern
 S SDS=$O(^SC(SC,"T"_SDY,SDT)) Q:SDS<1 ""
 Q:(^SC(SC,"T"_SDY,SDS,1)="") ""
 Q $P(SDAY,U,SDY+1)_" "_$E(SDT,6,7)_$J("",SDI+SDI-6)_^SC(SC,"T"_SDY,SDS,1)
 ;
ACTIVE(X,SDIN,SDRE) ;Determine if the clinic is active on a given date
 ;Input: X=date to be examined
 ;Input: SDIN=clinic inactive date
 ;Input: SDRE=clinic reactivate date
 ;Output: '1'=active, '0'=inactive
 Q:'SDIN 1  Q:X<SDIN 1  Q:'SDRE 0  Q:X<SDRE 0  Q 1
 ;
INIT ;Initialize array for counting patterns
 K SD N SDI
 S SD="123456789jklmnopqrstuvwxyz"
 F I=1:1:26 S SD($E(SD,I))=I
 Q
 ;
PCNT(X) ;Count open slots in a pattern
 ;Input: X=clinic availability pattern
 ;Output: number of open slots in a single date pattern
 N I,CT
 S CT=0 Q:X'["[" CT
 S X=$E(X,6,999),X=$TR(X,"|[] ","")
 F I=1:1:$L(X) S CT=CT+$G(SD($E(X,I)))
 Q CT
