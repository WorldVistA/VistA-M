PRSATPTW ;WASHFO/JAH - Telework Posting;4/13/2012
 ;;4.0;PAID;**132**;Sep 21, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
 ;
TELEWORK(PPI,PRSIEN,PRSD,STAT,POSTTYPE,TC) ; telework posting driver
 ;
 ;INPUT:
 ;  PPI-pay period being edited (either correctd timecard or regular posting)
 ;  PRSIEN:  employe 450 ien
 ;  PRSD: day number 1-14 being posted
 ;  STAT: timecard status (timekeeper, payroll, transmitted)
 ;  POSTTYPE: 1:Worked Entire Tour 2:Absent Entire Tour 3:Irregular Tour
 ;
 ; get telework indicator and check tour for scheduled telework
 ;
 N TWE,MAXTW,SCHED,MED,ADNOC,SCHHRS
 S TWE=$$TWE^PRSATE0(PRSIEN,PPI,PRSD)
 I POSTTYPE=2 D CLEANTW(PPI,PRSIEN,PRSD) Q
 ;
 ; for corrected timecards check if telework eligible during that 
 ; pay period otherwise use current telework indicator and
 ; quit if no trackable telework indicator
 ;
 Q:($P(TWE,U,4)'="Y")
 ;
 ; Get day's scheduled telework?
 ;
 S SCH=$P(TWE,U,5)
 ;
 ; Daily employees either telework or they don't so
 ; we're all done with them after this block
 ;
 N ACTUALTW
 I $G(TC)=2!($G(TC)=3) D  Q
 .  S ACTUALTW=$$TWDAY(SCH)
 .  Q:ACTUALTW<0
 .  D STORETW(PPI,PRSIEN,PRSD,ACTUALTW)
 ;
 ; for hourly employees get max allowable tw hrs based on timecard posting
 ;
 S MAXTW=$$MAXTW(PPI,PRSIEN,PRSD,SCH,POSTTYPE)
 I MAXTW="0^0^0" D CLEANTW(PPI,PRSIEN,PRSD) Q
 ;
 ;get any telework already posted
 ; piece 2 SCHEDULED
 ;       3 MEDICAL
 ;       4 AD HOC SITU    
 ;
 S OLDTWHRS=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,8)),U,2,4)
 ;
 ;  Prompt for the actual telework hours:
 ;   "REGULAR SCHEDULED","MEDICAL SCHEDULED","AD HOC"
 ;
 D ASKTWHRS(.ACTUALTW,MAXTW,OLDTWHRS,SCH)
 ;
 ;store the telework hours posted in the timecard
 ;
 D STORETW(PPI,PRSIEN,PRSD,ACTUALTW)
 ;
 Q
 ;
MAXTW(PPI,PRSIEN,PRSD,SCH,POSTTYPE) ;
 ;    Extrinsic function to return maximum allowable 
 ;    telework for medical, ad hoc, reg. sched.
 ;    RETURN:
 ;     piece 1: maximum regular scheduled
 ;     piece 2: maximum Medical scheduled
 ;     piece 3:  maximum AD HOC
 ;
 ;
 ;get tour length, length of exceptions to compute max telewk allowed
 ;
 ;  Field            Node;piece     Definition
 ; TOUR LENGTH         0;8   length of tour
 ; POSTING TYPE (104) 10;4  1:Worked tour 2:Absent tour 3:Irregular tour
 ; POSTING STATUS (101) 10;1 T:Timekeeper post P:Payroll rev X:Xmitted
 ;
 N TOT,TOD,MT,MAXTW,TCN,TSET,TT,TRC,TOURLEN,TOUR2LEN,BEG,END
 N SEGHRS
 ;
 S MAXTW="0^0^0"
 S TOURLEN=+$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,8)
 S TOUR2LEN=+$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,14)
 ;
 ;initialize telework to the tour length
 ;
 S $P(MAXTW,U,$S(SCH="REG":1,SCH="MED":2,1:3))=TOURLEN
 I TOUR2LEN>0 S $P(MAXTW,U,3)=+$P(MAXTW,U,3)+TOUR2LEN
 ;
 ; only worked tour, no exceptions, so MAXTW is tour length
 ;
 Q:POSTTYPE=1 MAXTW
 ;
 ; else we need to count up exceptions. OT and CT can only be ad hoc.
 ;
 N ADHOC,SUBTOT,TSEG
 S TCN=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,2))
 S ADHOC="^CT^OT^RG^"
 ;
 ; for following non work types of time in exceptions, subtract from total available TW
 ; ^AA^AD^AL^CB^CP^CU^DL^HX^ML^NL^NP^RL^RS^SL^TR^TV^UN^"
 ;
 N I F I=1:4:24 D
 .   S TSEG=$P(TCN,U,I,I+3)
 .   S TT=$P(TSEG,U,3)
 .   Q:TT=""!("^ON^SB^HW^"[(U_TT_U))
 .   S TRC=$P(TSEG,U,4)
 .   S BEG=$P(TSEG,U)
 .   S END=$P(TSEG,U,2)
 .   S SEGHRS=$$AMT^PRSPSAPU(BEG,END,0)
 .   I ADHOC[(U_TT_U) D
 ..     S $P(MAXTW,U,3)=$P(MAXTW,U,3)+SEGHRS
 .   E  D
 ..     S SUBTOT=$P(MAXTW,U,$S(SCH="REG":1,SCH="MED":2,1:3))
 ..     S $P(MAXTW,U,$S(SCH="REG":1,SCH="MED":2,1:3))=SUBTOT-SEGHRS
  ;
 Q MAXTW
 ;
ASKTWHRS(ACTUALTW,MAXTW,OLDTWHRS,SCH) ;
 ;INPUT:
 ;
 ;RETURN:
 ; ACTUALTW = 3 piece string ^ delimiter TW SCH hrs^TW Med Hrs^TW Adhoc
 ;
 S ACTUALTW="0^0^0"
 N ADHOCTYP,THISMTW,THISACT,TWTYPEI
 F TWTYPEI=1:1:3 D
 .  S THISMTW=$P(MAXTW,U,TWTYPEI)
 .  Q:THISMTW'>0
 .  S THISACT=$$GETTWHRS(THISMTW,TWTYPEI,OLDTWHRS,SCH)
 .  I THISACT<0 D  Q
 ..    S THISACT=+$P($G(OLDTWHRS),U,TWTYPEI)
 ..    S $P(ACTUALTW,U,TWTYPEI)=THISACT
 .; for ad hoc-ask if it is ad hod regular or ad hoc medical
 .  I TWTYPEI=3&(THISACT>0) D
 ..    S ADHOCTYP=$$GETTYPE()
 ..    Q:"AM"'[ADHOCTYP
 ..; might be adding adhoc medical to scheduled medical
 ..    S $P(ACTUALTW,U,$S(ADHOCTYP="M":2,1:3))=$P(ACTUALTW,U,$S(ADHOCTYP="M":2,1:3))+THISACT
 .  E  D
 ..    S $P(ACTUALTW,U,TWTYPEI)=THISACT
 Q
 ;
GETTWHRS(MAX,TT,OLDTWHRS,SCH) ;
 ;
 N X,Y,DIR,TWTYPE,THISOLDTW
 S TWTYPE=$S(TT=1:"Regular Scheduled",TT=2:"Medical Scheduled",1:"Ad Hoc")
 S DIR("A")="Enter Any "_TWTYPE_" Telework Hours"
 S DIR(0)="N^0"_":"_MAX_":"_2_U_"K:(X#.25) X"
 S DIR("?")="Telework hours must be less than or equal to the amount of work posted."
 S DIR("?",1)="Enter telework hours less than or equal to "_MAX_" in quarter hours."
 S DIR("??")="PRSA ENTER TW^"
 S THISOLDTW=+$P(OLDTWHRS,U,TT)
 I THISOLDTW>0 D
 .  I THISOLDTW'>MAX D
 ..    S DIR("B")=$S(TT<3:MAX,1:THISOLDTW)
 .  E  D
 ..; thisoldtw > max
 ..    S DIR("B")=+MAX
 E  D
 .  S DIR("B")=$S(TT<3:+MAX,1:0)
 ;
 ; special case for Ad hoc telework stored as medical
 I ($G(DIR("B"))'>0)&(TT=3)&(SCH'="MED")&(SCH'="REG") D
 .  S DIR("B")=+$P(OLDTWHRS,U,2)
 ;
 D ^DIR
 I $D(DIRUT) Q -1
 Q Y
 ;
 ;
GETTYPE() ;
 ;  Prompt for type of additional telework
 N X,Y,DIR
 S DIR("A")="Type of Telework? "
 S DIR(0)="SAB^A:Ad Hoc;M:Medical"
 S DIR("B")="A"
 D ^DIR
 I $D(DIRUT) Q -1
 Q Y
 ;
TWDAY(SCH) ;
 ; input: SCH - is the daily employee scheduled for Medical or regular
 ; output: ACTUALTW- return piece positional telework type--
 ;                  piece 1 = 1 if medical telework
 ;                   ''   2 = 1 if regular scheduled
 ;                   ''   3 = 1 if ad hoc situational
 ;
 ;  Prompt daily tour employees 
 N X,Y,DIR,ACTUALTW,TWLENGTH,TYPE
 S ACTUALTW="0^0^0"
 S TYPE=$S(SCH="MED":"Medical",SCH="REG":"Regular",1:"Ad Hoc")
 ;
 I SCH="MED"!(SCH="REG") D
 .   S DIR("A")="Did Employee Perform "_TYPE_" Telework"
 E  D
 .  S DIR("A")="Did Employee Perform Telework"
 ;
 S DIR(0)="Y"
 S DIR("B")=$S(SCH'="":"Y",1:"N")
 D ^DIR
 S TWLENGTH=+Y
 Q:$D(DIRUT) -1
 Q:TWLENGTH'=1 ACTUALTW
 ;
 I TYPE="Ad Hoc" D  Q ACTUALTW
 .  S ADHOCTYP=$$GETTYPE()
 .  I "AM"'[ADHOCTYP Q
 .  S $P(ACTUALTW,U,$S(ADHOCTYP="M":2,1:3))=TWLENGTH
 S $P(ACTUALTW,U,$S(SCH="MED":2,SCH="REG":1,1:3))=TWLENGTH
 Q ACTUALTW
 ;
CLEANTW(PPI,PRSIEN,PRSD) ; remove any telework hours, leave any scheduled tw.
 N IENS,FDA
 S IENS=PRSD_","_PRSIEN_","_PPI_","
 S FDA(458.02,IENS,71)="@"
 S FDA(458.02,IENS,72)="@"
 S FDA(458.02,IENS,73)="@"
 D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 Q
STORETW(PPI,PRSIEN,PRSD,ACTUALTW) ;
 ;    store telework in node 8 of the "D" (daily) subnode.
 ;
 ;S $P(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,8),U,2,4)=ACTUALTW
 N IENS,FDA
 S IENS=PRSD_","_PRSIEN_","_PPI_","
 S FDA(458.02,IENS,71)=+$P(ACTUALTW,U)
 S FDA(458.02,IENS,72)=+$P(ACTUALTW,U,2)
 S FDA(458.02,IENS,73)=+$P(ACTUALTW,U,3)
 D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 Q
