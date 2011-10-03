MAGDCCSD ;WOIFO/MLH - DICOM Correct - Clinical Specialties - Driver ; 01/30/2004  17:14
 ;;3.0;IMAGING;**10,11**;14-April-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
EN() ;Start looping either by patient or loop thru Study uid
 N DIR,X,Y
 S DIR(0)="S^P:Patient;L:Loop thru file;D:Specify a Date Range"
 S DIR("A")="Update entries by"
 D ^DIR
 Q Y
 ;
START ;
 N MAGSORT,MAGIEN,PREV,START,STOP,X,Y
 N KFIXALL ; -- does user hold MAGDFIX ALL key
 ;
 S KFIXALL=$$SECKEY^MAGDLB12()
 S MAGSORT=$$EN Q:MAGSORT["^"
 I MAGSORT="P" D  G EXIT
 . L +^MAGD(2006.575,"D") D SRT^MAGDCCSS S MAGIEN=$$SELECT L -^MAGD(2006.575,"D") Q:MAGIEN<1
 . I 'KFIXALL,$P($G(^MAGD(2006.575,MAGIEN,1)),"^",5)'=$G(DUZ(2)) D  Q
 . . W !,"The entry selected was not captured on your site's gateway."
 . . W !,"You are not authorized to correct another site's entries."
 . . Q
 . I $D(^MAGD(2006.575,MAGIEN,"TYPE")),$P(^("TYPE"),"^")'="CON" D  Q
 . . W !,"Only Clinical Specialties images may be fixed using this option."
 . . Q
 . S PREV=MAGIEN D SET^MAGDCCS
 . Q
 I MAGSORT="D" D  G EXIT
 . D SRTDT^MAGDCCSS
 . D ASKDT^MAGDCCSS
 . I '$D(STR)!'($D(STP)) Q
 . S START=STR,STOP=STP K STR,STP
 . D DATELOOP^MAGDCCS(START,STOP)
 . Q
 E  D
 . D L^MAGDCCS
 . Q
EXIT ;
 K ANS,ANSR,CASENO,COMNT1,DATA,DATA1,DATA2,DATE,FILE,FIRST,FIRSTS,I,MACHID,MAGDY
 K MAGDIEN,MAGCSE,MAGERR,MAGFIX,MAGDTPRT,MAGTYPE,MAGDTPRT,MAGSTP,MSG
 K MOD,MODEL,NEWCAS,NEWDFN,NEWDTI,NEWDTIM,NEWMUL,NEWNME,NEWPIEN,NEWPROC
 K NEWSSN,OK,OOUT,OUT,PAT,PID,PREV,PREVS,REASON,STUDYUID,SUID,WHY
 Q
SELECT() ;
 N DIC,D,X,Y
 S DIC="^MAGD(2006.575,",D="D",DIC(0)="AEQ"
 D MIX^DIC1
 Q +Y
SLDATE() ;
 N DIC,D,X,Y
 S DIC="^MAGD(2006.575,",D="AD",DIC(0)="AE"
 D MIX^DIC1
 Q +Y
