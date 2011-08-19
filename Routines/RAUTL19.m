RAUTL19 ;HISC/GJC-Utility Routine ;11/13/97  15:18
 ;;5.0;Radiology/Nuclear Medicine;**1,31**;Mar 16, 1998
 ;
PRELIM(RAIMG) ; Called from '1^RAMAIN1'
 W !!?(IOM-$L(RAHDR)\2),RAHDR K %ZIS S %ZIS="MQ" W !
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  W ! Q
 . S ZTDESC="Rad/Nuc Med Exam Status Entry/Edit Report",ZTSAVE("RA*")=""
 . S ZTRTN="EN1^RAUTL19" D ^%ZTLOAD
 . W !?5,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!")
 . Q
 I IO'=IO(0) U IO
 D EN1 I IO'=IO(0) D HOME^%ZIS
 Q
EN1 ; Check data consistency
 D EN1^RAUTL19C
 Q
NOTNEED ;non-radiopharm used don't need .5n and .6n fields answered
 Q:RANODE(.5)'["Y"&(RANODE(.6)'["Y")
 W !!,RADASH,"Checking fields not needed by non-nucmed imaging",RADASH
 W !!?11,"Within : ",RAIMG,!?5,"The following need not be answered :"
 W !?5,"Exam Status '",$P(RANODE(0),"^"),"'",!?5,"order ("_RAO_") '",!
 N RAIMG0,RAIMG1,RAIMG2
 S RAIMG1=.50,RAIMG2=.69,RAIMG0=RAIMG1
 F  S RAIMG0=$O(RAPIECE(RAIMG0)) Q:RAIMG0>RAIMG2  Q:RAIMG0=""  I RAPIECE(RAIMG0)="Y" W !,"'",$P($G(^DD(72,RAIMG0,.1)),U),"' is set to ",RAPIECE(RAIMG0)
 W !
 Q
CKPRNTR ;ck that all img locations for that img type has a dosg tkt prntr
 N RAIMG72,RA791,RA791FL
 S RAIMG72=$P(RANODE(0),U,7),RA791=0,RA791FL=0
 F  S RA791=$O(^RA(79.1,"BIMG",RAIMG72,RA791)) Q:'RA791  I $P(^RA(79.1,RA791,0),U,23)="" D PRNTASGN Q:RAOUT
 Q
PRNTASGN ;
 W:'RA791FL !!,RADASH,"Checking Dosage Ticket Printer Assignment",RADASH
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W:'RA791FL !!?11,"Within : ",RAIMG,!?5,"Exam Status '",$P(RANODE(0),"^"),"'",!?5,"order ("_RAO_") '"_$P($G(^DD(72,.611,.1)),U)_"'",!?5,"is set to 'Yes' but",!?5,"there's no Dosage Ticket Printer assigned to :"
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 S RA791FL=1
 W !?15,$P(^SC($P(^RA(79.1,RA791,0),U),0),U)
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 Q
WRPAIR I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W:'RACHKERR !!,RADASH,"Checking fields that are inter-related",RADASH
 S RACHKERR=1 ;only write this once
 Q
CKPAIR ; when field I is Y, then field J must also be Y at current/lower status
 D CKPAIR^RAUTL19C
 Q
WRWAIT W:'RAWATERR !!,RADASH,"Checking ",$P(RANODE(0),U,1),"'s 'ASK' and 'REQUIRED' fields",RADASH,!?11,"within : ",RAIMG,!
 S RAWATERR=1 ;only write this once regardless of number of errors found
 Q
CKWAIT ; CKWAIT is only done for WAITING FOR EXAM and assumes order seq = 1
 D CKWAIT^RAUTL19C
 Q
ASKPRI(A,B,C) ; Check all prior statuses to ensure that the specific required
 ; data field is set to 'yes', and the field for data asked is set to
 ; 'yes'.
 ; 'A' is the I-Type (external)     <->  'B' is the current status order 
 ; 'C' is fld that shd be prompted  <->  'E' is the order #
 ; 'F' is the ien of file 72.       <->  'RA' hold the entire data node
 ; 'RAFLD' value of the field       <->  'RAPCE' where data found on node
 N E,F,RA,RAFLD,RAPCE S E=0
 F  S E=$O(^RA(72,"AA",A,E)) Q:E'>0!(E'<B)  D  Q:RAFLG
 . S F=+$O(^RA(72,"AA",A,E,0)) Q:'F
 . S RA(0)=$G(^RA(72,F,0))
 . I $$UP^XLFSTR($P(RA(0),"^",5))="Y" D  ; if on Status Tracking
 .. S RAPCE=$E(C,3,$L(C)) ;pce is after 2nd byte, & is 1 or 2 bytes long
 .. S RA($E(C,1,2))=$G(^RA(72,F,$E(C,1,2))),RAFLD=$P(RA($E(C,1,2)),"^",RAPCE)
 .. S:$$UP^XLFSTR(RAFLD)="Y" RAFLG=1
 .. Q
 . Q
 Q RAFLG
PROCTY(Y) ; Passes back the Procedure Type.  'Y' is the ien in the
 ; Rad/Nuc Med Procedure file '^RAMIS(71,'.
 Q $$UP^XLFSTR($P($G(^RAMIS(71,+Y,0)),"^",6))
LK(X) ; Lock a patient record when updating orders
 ; 'X' input in a variable pointer format: 'record_#;data_file__root'
 ; Pass back 'Y': '0' if lock fails, '1' if successful
 ; 'Y' defined in LK^ORX2
 Q 1
ULK(X) ; Unlock a patient record
 ; 'X' input in a variable pointer format: 'record_#;data_file__root'
 Q
ACCVIO ; Lack of Imaging Location access for a user
 W !?5,$C(7),"You do not have access to any Imaging Locations."
 W !?5,"Contact your ADPAC."
 Q
DEV(X) ; Lookup an entry in the Device (3.5) file.
 ; Called from the [RA LOCATION PARAMETERS] input template.  File: 79.1
 ; Input:  X=IEN of Device
 ; Output: Name of Device
 Q:'$L(X) ""
 I X?1N.NP Q $P($G(^%ZIS(1,X,0)),"^")
 Q ""
OENO(X) ; OE/RR notifications, called from: RAORR1, RAORD1 & RAO7RO
 ; Input: 'X' ->  ien of the Rad/Nuc Med Orders file (75.1)
 N I,RA751,RADFN,RADUZ,RALOC,RAMSG,RANOTY
 S RA751=$G(^RAO(75.1,X,0)),RADFN=+$P(RA751,"^"),RANOTY=$P(RA751,"^",6)
 S RANOTY=$S(RANOTY=1:51,RANOTY=2:52,1:"") Q:RANOTY=""
 S RALOC=$P(RA751,"^",20) Q:RALOC']""  ; no i-loc, no alert
 S I=0 F  S I=$O(^RA(79.1,RALOC,"REC","B",I)) Q:I'>0  D
 . S RADUZ(I)=""
 . Q
 S:($D(RADUZ)\10)=0 RADUZ="" ; NOTE: if no rad/nuc med recipients, check
 ; oe/rr to see if they have any recipients for this particular alert
 S RAMSG="Imaging Request Urgency: "_$$XTERNAL^RAUTL5($P(RA751,"^",6),$P($G(^DD(75.1,6,0)),"^",2))
 D EN^ORB3(RANOTY,RADFN,X,.RADUZ,RAMSG)
 Q
VRADE ;VistaRad Category data entry
 I '$$IMAGE^RARIC1() W !!,"Current system is not running Vista Imaging -- nothing done.",! Q
 S DIC="^RA(79.2,",DIC(0)="QEAMNZ",DIC("A")="Select an Imaging Type: "
 D ^DIC K DIC G:+Y'>0 VRADQ
 S RAOUT=0,RAIMGTYI=+Y,RAIMGTYJ=$P(Y,U,2)
 F  D  Q:RAOUT
 . K DINUM,DLAYGO,D0 W !
 . S DIC="^RA(72,",DIC(0)="QEAZ" ; don't allow LAYGO
 . S DIC("S")="I +$P(^(0),U,7)=RAIMGTYI"
 . S RADICW(1)="N RA S RA(0)=^(0),RA(3)=$P(RA(0),U,3) "
 . S RADICW(2)="W ?35,""Imaging Type: "",?49,RAIMGTYJ"
 . S RADICW(3)=",!?35,""Order: "",?42,RA(3)"
 . S DIC("W")=RADICW(1)_RADICW(2)_RADICW(3)
 . D ^DIC K DIC,RADICW
 . I +Y'>0 S RAOUT=1 Q
 . S DA=+Y,DIE="^RA(72,",DR="9" D ^DIE
 . Q
VRADQ K RAIMGTYI,RAIMGTYJ,RAOUT
 Q
