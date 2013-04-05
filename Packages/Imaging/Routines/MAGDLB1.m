MAGDLB1 ;WOIFO/LB/JSL/SAF - Routine to fix failed DICOM entries ; 05/18/2007 11:23
 ;;3.0;IMAGING;**11,30,54,123**;Mar 19, 2002;Build 67;Jul 24, 2012
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
DISPLAY ;
 S OUT=0
 W !,"**************Processing entry**********"
 W !!?2,"PATIENT: ",PAT,?50,$$PIDLABEL^MAGSPID(),": ",PID,!,"RADIOLOGY CASE #: ",CASENO  ;;P123
 W !?2,"Equipment: ",MOD,?50,"Model: ",MODEL
 W !?2,"Date Processed: ",DATE,?50,"Problem with: ",REASON
 W !?2,"Comment: ",COMNT1
 W !?2,"Correcting file on Image gateway server ID: ",MACHID,!?5,FILE
 S MSG="Do you want to Correct this entry? "
 Q
 ;
NEWCASE ;
 S NEWDFN=$P(MAGDY,"^"),NEWNME=$P(MAGDY,"^",2),NEWPID=$P(MAGDY,"^",3)
 S NEWCAS=$P(MAGDY,"^",4),NEWPROC=$P(MAGDY,"^",5),NEWDTI=$P(MAGDY,"^",6)
 S NEWMUL=$P(MAGDY,"^",7),NEWPIEN=$P(MAGDY,"^",8),PP=$P(MAGDY,"^",9)
 Q
 ;
ASK() ;
 N ANS,ASK
 ;
ASK1 S ASK="Y/N/D/Q"
 I $G(PREV)'=$G(MAGIEN),MAGTYPE="RAD" S ASK=ASK_"/P"
 W !,$G(MSG),"("_ASK_")// " R ANS:600
 I '$T!(ANS["^") Q "^"
 I ANS="" Q "N"
 I "YNDPQyndpq"'[$E(ANS) D  G ASK1
 . W !,"Please respond with one of the following codes."
 . W !,"Legend: Y=yes, N=no, D=delete, P=Previous entry, and Q=quit",!
 S ANS=$TR(ANS,"yndpq","YNDPQ")
 Q $E(ANS)
 ;
CHK ;remove any punctuation before doing comparison on SSN
 ;stop on 1st check.
 N OLD,I
 S OLD="" F I=1:1:$L(PID) I $E(PID,I)?1AN S OLD=OLD_$E(PID,I)
 I NEWPID'=OLD D  Q
 . I $$ISIHS^MAGSPID() S MSG="Patient ID numbers do not match. Update? " Q  ;P123
 . S MSG="Social Security numbers do not match. Update? "
 I NEWNME'=PAT D  Q
 . S MSG="Patient names do not match. Update? "
 ;Finally the problem is with the case number...either no longer in "C"
 ;xref or invalid number provided
 S MSG="Radiology case number different. Update? "
 Q
 ;
NEWDIS ;
 W !?2,"****Please review the following: *****"
 W !?2,"Previous name: ",PAT,!?2,"     New name: ",NEWNME
 W !?2,"Previous ",$$PIDLABEL^MAGSPID(),": ",PID,!?2,"     New ",$$PIDLABEL^MAGSPID(),": ",NEWPID  ;P123
 W !?2,"Previous case #: ",CASENO,!?2,"     New case #: ",NEWCAS
 I $L($G(PP)) W !?15,"Case number selected: ",PP
 ; Variable PP already has text message about being part of printset.
 Q
 ;
UPDT ;
 N GWLOC ; -- gateway location
 N % ; ------ utility variable for FM calls
 W !,"Will change the following: " D NEWDIS
 W !,"Are you sure you want to correct this entry? " S %=2 D YN^DICN
 I %=-1!(%=2) S OUT=1 Q
 W !,"Updating the file."
 S NEWDTIM=$TR(NEWDTI,"0123456789","9876543210")
 S ^MAGD(2006.575,MAGIEN,"FIXD")="1^"_NEWDFN_"^"_NEWNME_"^"_NEWPID_"^"_NEWCAS_"^"_NEWDTI_"^"_NEWMUL_"^"_NEWDTIM W "."
 S ^MAGD(2006.575,MAGIEN,"FIXPR")=NEWPIEN_"^"_NEWPROC W "."
 ;Same as ^radpt(newdfn,"DT",newdti,"P",newmul,0) & ^RAMIS(71,newpien,0)
 S MACHID=$S(MACHID="":"A",1:MACHID) ; server ID
 S GWLOC=$P($G(^MAGD(2006.575,MAGIEN,1)),"^",5)
 I GWLOC S ^MAGD(2006.575,"AFX",GWLOC,MACHID,MAGIEN)="" W "."
 E  W !,"Gateway place not defined on image entry "_MAGIEN_", continuing.."
 ;Xref to loop & process entries; processing will be minimal.
 S MAGFIX(MAGIEN)="F"
 Q
 ;
SETDEL ;Entry to be deleted
 N GWLOC ; -- gateway location
 D LOGERR I ANS="^" S OUT=1 Q
 S GWLOC=$P($G(^MAGD(2006.575,MAGIEN,1)),"^",5)
 I GWLOC S ^MAGD(2006.575,"AFX",GWLOC,MACHID,MAGIEN)="D" W "."
 E  W !,"Gateway place not defined on this image entry "_MAGIEN_", continuing.."
 S $P(^MAGD(2006.575,MAGIEN,0),"^",6)="1"
 S ^MAGD(2006.575,MAGIEN,"FIXD")=1
 S MAGFIX(MAGIEN)="D"
 Q
 ;
LOGERR ;Need to record error
 N DIR,DIRUT,DTOUT,ENTRY,I,MAGERR,MAGOUT,NOW,WHY,WHO,X,Y
 W !! F I=1:1:80 W "*"
 W !,"*** Will log in error log (file 2006.599). ****"
 S NOW=$$NOW^XLFDT()
 S DIR(0)="F^3:30"
 S DIR("A")="Reason for deletion"
 S DIR("A",1)="Please enter a reason for deleting."
 S DIR("A",2)="For example: TEST PATIENT"
 D ^DIR
 I $D(DIRUT)!($D(DTOUT))!(Y="") D  S ANS="^" Q
 . W !,"Can not delete if a reason is not provided."
 . Q
 S WHY=Y,WHO=$G(DUZ)
 I WHO D 
 . D GETS^DIQ(200,DUZ,".01","E","MAGOUT","MAGERR")
 . Q:$D(MAGERR("DIERR"))
 . S WHO=$G(MAGOUT(200,DUZ_",",.01,"E"))
 I WHO="" S WHO="UNKNOWN"
 I '$D(^MAGD(2006.599,0)) D
 . S ^MAGD(2006.599,0)="Dicom Error Log^2006.599^^"
 . Q
 S ENTRY=$P(^MAGD(2006.599,0),"^",3)+1
 S $P(^MAGD(2006.599,0),"^",3)=ENTRY
 S $P(^MAGD(2006.599,0),"^",4)=$P(^MAGD(2006.599,0),"^",4)+1
 S ^MAGD(2006.599,ENTRY,0)=NOW_"^"_WHY_"^"_FILE_"^"_MODEL
 S ^MAGD(2006.599,ENTRY,1)=WHO_"^"_PAT_"^"_PID_"^"_CASENO_"^"_MACHID
 S ^MAGD(2006.599,"B",NOW,ENTRY)=""
 Q
 ;
SET ;
 S MAGTYPE=$P(^MAGD(2006.575,MAGIEN,"TYPE"),"^")
 Q:$P($G(^MAGD(2006.575,MAGIEN,"FIXD")),"^")  ; Already fixed.
 ; Only process Radiology images...medicine images done by other rtns.
 I MAGTYPE'["RAD" Q
 S DATA=^MAGD(2006.575,MAGIEN,0)
 S FILE=$P(^MAGD(2006.575,MAGIEN,0),"^")
 S DATA1=^MAGD(2006.575,MAGIEN,1) ; Case no. info
 S DATA2=$G(^MAGD(2006.575,MAGIEN,"AMFG")) ; Modality info
 S PAT=$P(DATA,"^",4),PID=$P(DATA,"^",3),REASON=$P(DATA,"^",2)
 S MOD=$P(DATA2,"^"),MODEL=$P(DATA2,"^",6)
 S CASENO=$P(DATA1,"^",2),MACHID=$P(DATA1,"^",4)
 S Y=$P(DATA1,"^",3) X ^DD("DD") S DATE=Y
 S COMNT1=$G(^MAGD(2006.575,MAGIEN,"ACSTXT")) ; 1st line comment.
 S MACHID=$P(DATA1,"^",4),GWLOC=$P(DATA2,"^",9)
 S ANS="" D DISPLAY S ANS=$$ASK
 I ANS="Q"!(ANS["^") S (OOUT,OUT)=1 D SETPREV Q
 I ANS="N" S OUT=1 D SETPREV Q
 I ANS="P" D CHKPREV Q
 I ANS="D" D SETDEL,SETPREV Q
 Q:OUT
 K MAGDY W !," Lookup by case number or patient name"
 ;
 ; Fall Through intended
LOOK ;
 ;D ^MAGDLB2 Q:'$D(MAGDY)  Q:MAGDY'[""
 D EN^MAGDRA2 Q:'$D(MAGDY)  Q:MAGDY'[""
 D NEWCASE,CHK,NEWDIS S ANS=$$ASK
 I ANS="Q"!(ANS["^") S (OOUT,OUT)=1 D SETPREV Q
 I ANS="D" D SETDEL,SETPREV Q
 I ANS="P" D CHKPREV Q
 I ANS="N" S OUT=1 D SETPREV Q
 Q:OUT
 D UPDT
 I ANS="P" D CHKPREV Q
 D SETMAG
 Q
 ;
DATELOOP(START,STOP) ;Loop thru the "AD" cross reference
 N MAGIEN,SUID,THEDT,FIRST,OOUT,MAGFIX,MDV
 S KFIXALL=$$SECKEY^MAGDLB12
 S THEDT=START-.1,(OOUT,FIRST)=0
 F  S THEDT=$O(^MAGD(2006.575,"AD",THEDT)) Q:'THEDT!(THEDT>STOP)!(OOUT)  D
 . S MAGIEN=0
 . F  S MAGIEN=$O(^MAGD(2006.575,"AD",THEDT,MAGIEN)) Q:'MAGIEN  D
 . . I '$D(^MAGD(2006.575,MAGIEN,0)) D  Q
 . . . K ^MAGD(2006.575,"AD",THEDT,MAGIEN)
 . . . Q
 . . I $P($G(^MAGD(2006.575,MAGIEN,"TYPE")),U,1)'["RAD" Q
 . . ; No security key, or gateway site other than this site
 . . I 'KFIXALL,$P($G(^MAGD(2006.575,MAGIEN,1)),U,5)'=$G(DUZ(2)) Q
 . . I 'FIRST S PREV=MAGIEN,FIRST=1
 . . D SET
 . . Q
 . Q
 Q
 ;
SETPREV ;
 S PREV=MAGIEN,PREVS=$G(SUID)
 Q
 ;
SETMAG ;
 S FIRST=MAGIEN,FIRSTS=$G(SUID),MAGIEN=PREV,SUID=$G(PREVS)
 S PREV=FIRST,PREVS=FIRSTS
 Q
 ;
CHKPREV ;
 S OUT=1 N STATUS
 I '$D(MAGFIX(PREV)) D SETMAG G SET
 S STATUS=$S($G(MAGFIX(PREV))="D":"deleted",1:"corrected")
 W !,"Previous entry has been "_STATUS_".",$C(7)
 G SET
 Q
 ;
NAME(ENTRY) ;SITE NAME
 N NAME,MAGOUT,MAGERR
 I '$G(ENTRY) Q ""
 D GETS^DIQ(4,ENTRY,".01","E","MAGOUT","MAGERR")
 I $D(MAGERR("DIERR")) Q ""
 S NAME=$G(MAGOUT(4,ENTRY_",",.01,"E"))
 Q NAME
 ;
