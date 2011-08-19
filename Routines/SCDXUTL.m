SCDXUTL ;ALB/JLU;Utility routine for ambcare project;4/26/96
 ;;5.3;Scheduling;**44,78,132**;5/1/96
 ;
DATE(DATE) ;this entry point will accept a date and return whether the new or old Scheduling Visits file limitations are to be used.
 ;INPUTS  -  a date in FM format to be compared to the ambcare start
 ;           date parameter,
 ;OUTPUTS -  1 for using the new structure
 ;           0 for using the old structure
 ;
 N PAR,ANS
 S PAR=$P($G(^SD(404.91,1,"AMB")),U,2) ;get parameter date
 I 'PAR S ANS=0 G QT
 I DATE<PAR S ANS=0 G QT ;if date passed in older than parameter us old
 S ANS=1
QT Q ANS
 ;
FMDATE() ;this entry point returns the FM date from the parameter of
 ;whether to use the new or old structure.
 Q $P($G(^SD(404.91,1,"AMB")),U,2)
 ;
CLOSED(DATE) ;this entry point accepts a date, compares it to the close out
 ;date and returns whether the close out period is up.
 ;INPUTS  - a date in FM format to be compared to the close out date 
 ;          parameter.
 ;OUTPUTS - 1 for close out period is over
 ;          0 for still being able to close out
 ;
 N PAR,ANS
 S PAR=$P($G(^SD(404.91,1,"AMB")),U,3) ;gets close out parameter
 I 'PAR S ANS=0 G CQT
 I DATE<PAR S ANS=0 G CQT ;if date is after close out date parameter 1.
 S ANS=1
CQT Q ANS
 ;
CLOSEFM() ;this entry point returns the close out date parameter in FM format.
 Q $P($G(^SD(404.91,1,"AMB")),U,3)
 ;
INPATENC(PTR,PTR2) ;ALB/JRP - Determine if an Outpatient Encounter
 ; is for an inpatient appointment
 ;
 ;Input  : PTR - Pointer to one of the following files:
 ;               *  TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;               *  OUTPATIENT ENCOUNTER file (#409.68)
 ;               *  DELETED OUTPATIENT ENCOUNTER file (#409.74)
 ;         PTR2 - Denotes which file PTR points to
 ;                0 = TRANSMITTED OUTPATIENT ENCOUNTER file (Default)
 ;                1 = OUTPATIENT ENCOUNTER file
 ;                2 = DELETED OUTPATIENT ENCOUNTER file
 ;Output : 0 - Encounter is not an inpatient appointment
 ;         1 - Encounter is an inpatient appointment
 ;Notes  : 0 is returned if a valid pointer is not passed or the
 ;         entry in the TRANSMITTED OUTPATIENT ENCOUNTER file does
 ;         not point to a valid entry in the OUTPATIENT ENCOUNTER
 ;         file or DELETED OUTPATIENT ENCOUNTER file
 ;
 ;Check input
 S PTR=+$G(PTR)
 Q:('PTR) 0
 S PTR2=+$G(PTR2)
 S:((PTR2<0)!(PTR2>2)) PTR2=0
 I ('PTR) Q:('$D(^SD(409.73,PTR,0))) 0
 I (PTR2=1) Q:('$D(^SCE(PTR,0))) 0
 I (PTR2=2) Q:('$D(^SD(409.74,PTR,0))) 0
 ;Declare variables
 N ZERONODE,STATPTR,STATUS
 ;Passed pointer to TRANSMITTED OUTPATIENT ENCOUNTER file
 ; Convert to pointer to [DELETED] OUTPATIENT ENCOUNTER file
 ; Quit if it can't be converted
 I ('PTR2) D  Q:('PTR) 0
 .S ZERONODE=$G(^SD(409.73,PTR,0))
 .S PTR=+$P(ZERONODE,"^",2)
 .;Entry is for an outpatient encounter
 .I (PTR) S PTR2=1 Q
 .;Entry is for a deleted outpatient encounter
 .S PTR=+$P(ZERONODE,"^",3)
 .S PTR2=2
 ;Get zero node of [deleted] encounter
 S ZERONODE=$G(^SCE(PTR,0))
 S:(PTR2=2) ZERONODE=$G(^SD(409.74,PTR,1))
 ;Get pointer to appointment status
 S STATPTR=+$P(ZERONODE,"^",12)
 Q:('STATPTR) 0
 ;Get zero node of appointment status
 S ZERONODE=$G(^SD(409.63,STATPTR,0))
 ;Get abbreviation for appointment status
 S STATUS=$P(ZERONODE,"^",2)
 ;Inpatient appointments have an abbreviation of 'I'
 Q:(STATUS="I") 1
 ;Not an inpatient appointment
 Q 0
 ;
DATECHK() ;this function call returns whether to require diag/prov based
 ;on the date function call and whether the post init has run.
 ;there are no inout variables.
 ;
 ;a 1 if after 10/1 or the post init has been run to require diag etc.
 ;a 0 if not to require yet
 ;
 N DATE,ANS
 S ANS=$$DATE(DT) I ANS G DATECHKQ
 I $P(^SD(404.91,1,"AMB"),U,7) S ANS=1 G DATECHKQ
 S ANS=0
DATECHKQ Q ANS
 ;
OCCA(CLN) ;This function call returns whether or not the clinic is
 ;considered an occasion of service, based upon file 409.45.
 ;
 ;CLN is the clinic in question
 ;
 ;a 1 if this clinic is an occasion of service clinic
 ;a 0 if not
 ;
 N SCP,SC,ANS
 I '$D(^SC(CLN,0)) S ANS=0 G OCCAQ
 S SCP=$P(^SC(CLN,0),U,7)
 I 'SCP S ANS=0 G OCCAQ
 I '$D(^DIC(40.7,SCP,0)) S ANS=0 G OCCAQ
 S SC=$P(^DIC(40.7,SCP,0),U,2)
 I 'SC S ANS=0 G OCCAQ
 I '$O(^SD(409.45,"B",SC,"")) S ANS=0 G OCCAQ
 I "117^118^119^120^121^123^124^125^126^128^152^165^170^999"[SC S ANS=0 G OCCAQ
 S ANS=1
OCCAQ Q ANS
