IVMUM6 ;ALB/SEK - COMPLETE MEANS TEST ; 23 MAY 94
 ;;2.0;INCOME VERIFICATION MATCH;**1,3,17,115**;21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will call MAS routines to determine the following:
 ;        total dependents
 ;        income
 ;        net worth
 ;        deductible expenses
 ;        thresholds
 ;        category
 ;
 ; the above will be added in the ANNUAL MEANS TEST file(#408.31)
 ;
 ; s dgcomf=1 to indicate completing means test which will update
 ; means test ien (field 31) in individual annual income file (408.21)
 ; when called SET^DGMTSCU2
 S DGCOMF=1
 ;
 ; get DGMTPAR - annual means test parameters 0 node from ^DG(43,1,"MT"
 ; if current year parameters are not available DGMTPAR will contain
 ; previous year income parameters and DGMTPAR("PREV") will be defined
 ; indicating such.
 D PAR^DGMTSCU
 ;
 ; d set^dgmtscu2 will create the following variables to update
 ; annual means test file (408.31):
 ;      dgmts - means test status(.03)
 ;      dgint - income(.04)
 ;      dgnwt - net worth(.05)
 ;      dgtha - threshold a(.12)
 ;      dgthb - threshold b(.13)
 ;      dgdet - deductible expenses(.15)
 ;      dgmtpar("prev") - previous years threshold(.16)  (if defined)
 ;      dgnd  - total dependents(.18)
 ;      
 D SET^DGMTSCU2
 ;
 ; setup other variables for 408.31
 S IVMDA1=IVMDAZ D GET^IVMUM1 ; get ZMT segment
 S IVM1=$$FMDATE^HLFNC($P(IVMSEG,"^",10)) ; dt/time completed
 S IVM2=$P(IVMSEG,"^",7) ; agree to pay deductible
 S IVM3=$$FMDATE^HLFNC($P(IVMSEG,"^",15)) ; dt verified test sign
 S IVM4=$P(IVMSEG,"^",16) ; declines to give income info field
 S IVM5=$$FMDATE^HLFNC($P(IVMSEG,"^",6)) ; dt/time of adjudication
 S IVM6=$$FMDATE^HLFNC($P(IVMSEG,"^",20)) ; dt ivm verified mt completed
 S IVM7=$P(IVMSEG,"^",21) ; refuse to sign
 S IVMSTAT=$P(IVMSEG,"^",3) ; means test status
 S IVM8=+$P(IVMSEG,"^",30) ; Means Test Version
 ;
 I IVM4 S DGCAT="C" D STA^DGMTSCU2 ; make cat C if declines to give income info
 ;
 I DGTYC="M",(DGNWT+DGINT-DGDET)>$P(DGMTPAR,"^",8) S DGCAT="C" D STA^DGMTSCU2 ; if cat A for income make cat C if high assets
 ;
 ; add to annual means test file
 S:'$D(DGTHB) DGTHB=""
 S DA=DGMTI,DIE="^DGMT(408.31,"
 S DR=".03////^S X=DGMTS;.04////^S X=DGINT;.05////^S X=DGNWT;.06////^S X=DUZ;.07////^S X=IVM1;.11////^S X=IVM2"
 S DR=DR_";.12////^S X=DGTHA;.13////^S X=DGTHB;.14////^S X=IVM4;.15////^S X=DGDET;.18////^S X=DGND;.23////2;.24////^S X=IVM3;2.11////^S X=IVM8"
 I $D(DGMTPAR("PREV")) S DR=DR_";.16////1"
 D ^DIE K DR
 S DR=".1////^S X=IVM5;.25////^S X=IVM6;.26////^S X=IVM7"
 D ^DIE K DA,DIE,DR
 ;
 ; if ivm mt cat diff then calculated cat or still cat a ack msg is
 ; sent to ivm center
 ; dgcat (mt cat) is also created by d set^dgmtscu2
 I IVMSTAT'=DGCAT D  G MTDRIVER
 . S HLERR="Uploaded mt cat should be "_DGCAT
 I DGCAT="A" D
 . S HLERR="Uploaded mt cat is still A"
 ;
MTDRIVER ; call means test event driver
 S DGMTACT="UPL"
 D AFTER^DGMTEVT
 S DGMTINF=1 ; non-interactive flag
 D EN^DGMTEVT
 ;
 ; close IVM case record for patient
 D CLOSE^IVMPTRN1(DGLY,DFN,1,1)
 ;
 ; Get copay exemption status (IVMCEA) and means test status (IVMMTA
 ; after upload.  If different from before upload and send notification
 ; mail message to the site.  Also, send notification mail message if
 ; patient doesn't agree to pay deductible.
 S IVMCNTR=10
 S IVMCEA=$P($$RXST^IBARXEU(DFN),"^",2)
 I IVMCEA'=IVMCEB D
 . S IVMTEXT(10)=""
 . S IVMTEXT(11)="The patient is now "_IVMCEA_" from the prescription copayment."
 . S IVMCNTR=12
 S IVMMTA=$P($$LST^DGMTU(DFN),"^",3)
 I IVMMTA'=IVMMTB D
 . S IVMTEXT(IVMCNTR)=""
 . S IVMTEXT(IVMCNTR+1)="The patient's current Means Test status is now "_IVMMTA_"."
 . S IVMCNTR=IVMCNTR+2
 I 'IVM2 D
 . S IVMTEXT(IVMCNTR)=""
 . I IVM2=0 D  Q
 . . S IVMTEXT(IVMCNTR+1)="The patient is CATEGORY C and doesn't agree to pay the deductible."
 . S IVMTEXT(IVMCNTR+1)="The patient is CATEGORY C and didn't answer agree to pay the deductible."
 D MTBULL,MAIL^IVMUFNC()
 ;
 ; cleanup
 K DGCAT,DGCOMF,DGMTACT,DGMTI,DGMTINF,DGMTPAR,DGTHB
 K IVM1,IVM2,IVM3,IVM4,IVM5,IVM6,IVM7,IVMCEA,IVMCEB,IVMMTA,IVM8
 Q
 ;
MTBULL ; build mail message for transmission to IVM mail group notifying them
 ; an IVM verified means test has been uploaded into DHCP for a patient.
 ;
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="IVM - MEANS TEST UPLOAD for "_$P($P(IVMPAT,"^"),",")_" ("_$P(IVMPAT,"^",3)_")"
 S IVMTEXT(1)="An Income Verification Match verified Means Test has been uploaded"
 S IVMTEXT(2)="for the following patient:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="  NAME:           "_$P(IVMPAT,"^")
 S IVMTEXT(5)="  ID:             "_$P(IVMPAT,"^",2)
 S Y=IVMMTDT X ^DD("DD")
 S IVMTEXT(6)="  DATE OF TEST:   "_Y
 S IVMTEXT(7)="  PREV CATEGORY:  "_$P($G(^DG(408.32,+$P(IVMMT31,"^",3),0)),"^",2)
 S IVMTEXT(8)="  NEW CATEGORY:   "_DGCAT
 I IVM5 S Y=IVM5 X ^DD("DD") S IVMTEXT(9)="  DATE/TIME OF ADJUDICATION:  "_Y
 Q
