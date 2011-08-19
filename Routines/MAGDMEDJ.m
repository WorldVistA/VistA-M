MAGDMEDJ ;WOIFO/LB - Routine to fix failed DICOM entries ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;;Mar 01, 2002
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
L ;Loop thru the entire file for entries that need processing
 ;The "F" xref is set for unique Study UIDs. The entry setting this xref
 ;will also have a "RLATE" node with all the Xray images associated with
 ;that unique Study UID.
 N ANS,CASEDATE,CASENO,COMNT1,DATA,DATA1,DATA2,DATE,FILE,FOUND,MACHID,MAGDY,MAGIEN,MAGDIMG
 N MAGDIEN,MOD,MODEL,MSG,MAGPAT,MAGTYPE,MEDFILE
 N NEWCAS,NEWDFN,NEWDTI,NEWDTIM,NEWMUL,NEWNME,NEWPIEN,NEWPROC,NEWSSN
 N OOUT,OUT,PAT,PID,REASON,STUDYUID,JJ,ITEM
 I '$D(^MAGD(2006.575,"F")) W !,"Nothing to process!" Q
 S (MAGIEN,STUDYUID,OOUT,OUT)=0
 F  S STUDYUID=$O(^MAGD(2006.575,"F",STUDYUID)) Q:STUDYUID<1!(OOUT)  D
 . S MAGIEN=$O(^MAGD(2006.575,"F",STUDYUID,0)) Q:'MAGIEN
 . Q:'$D(^MAGD(2006.575,MAGIEN,0))
 . Q:$P($G(^MAGD(2006.575,MAGIEN,"FIXD")),"^")    ;Already fixed.
 . ; Only Medicine images
 . S MAGTYPE=$G(^MAGD(2006.575,MAGIEN,"TYPE"))
 . Q:MAGTYPE'["MED"
 . ; Only Medicine images need to be fixed thru this program.
 . S DATA=^MAGD(2006.575,MAGIEN,0),FILE=$P(^(0),"^")
 . S DATA1=^MAGD(2006.575,MAGIEN,1)    ;Case no. info
 . S DATA2=^MAGD(2006.575,MAGIEN,"AMFG")    ;Modality info
 . S PAT=$P(DATA,"^",4),PID=$P(DATA,"^",3),REASON=$P(DATA,"^",2)
 . S MOD=$P(DATA2,"^"),MODEL=$P(DATA2,"^",6)
 . S CASENO=$P(DATA1,"^",2),CASEDATE=$P(DATA1,"^",3)
 . S MACHID=$P(DATA1,"^",4),DATE=CASEDATE
 . S COMNT1=$G(^MAGD(2006.575,MAGIEN,"ACSTXT")) ;1st line comment.
 . ; Use patient information send via DICOM FILE
 . S MEDFILE=$$FILE^MAGDMEDI($P(CASENO,"-"))
 . D DISPLAY S ANS=$$ASK^MAGDLB1 I ANS="Q"!(ANS["^") S (OOUT,OUT)=1 Q
 . I ANS="N" S OUT=1 Q
 . I ANS="D" D SETDEL Q
 . Q:OUT
 . K MAGDY W !," Lookup patient name",!
 . S MAGPAT=$$PATLK^MCARUTL2
 . I 'MAGPAT D  Q
 . . W !,"Can not update if patient can not be identified.",$C(7)
 . ; If patient name could not be determined then we can not correct.
 . D PATSUB^MAGDMEDK(.MAGSUB,MAGPAT)
 . Q:'$D(MAGSUB)#10   ;No subspecialties found
 . ;Q:'$D(MAGMC)#10    ;No Medicine entries found
 . ; Select subspecialty
 . S SUB=$$DISPLAY^MAGDMEDL(.MAGSUB) I 'SUB D  Q
 . . W !,"No specialty selected"
 . S SUB=$P(MAGSUB(SUB),"^"),SUB=$P(SUB,"(",2),SUB=$P(SUB,")",1)
 . D SUB^MAGDMEDK(SUB,MAGPAT)
 . I '$D(MAGMC)#10 D  Q
 . . W !,"No entries were found for the selected specialty."
 . D LOOP^MAGDMEDL(.XX,MAGPAT,SUB,CASEDATE)
 . ;S ITEM=$$DISPLAY^MAGDMEDL(.XX) I 'ITEM D
 . ;. W !,"No entry selected."
 . I $D(XX(0)),$P(XX(0),"^")=0 D  Q:MAGDOUT
 . . S MAGDOUT=0
 . . W !,"No Medicine file entries found for this patient"
 . . W !,"on the date/time the image was captured."
 . . S FOUND=$$ASKMORE^MAGDMEDL I 'FOUND S MAGDOUT=1
 . S ITEM=$$DISPLAY^MAGDMEDL(.XX) I 'ITEM D  Q
 . . W !,"Can not update if Medicine file entry can not be found.",$C(7)
 . D NEWCASE,CHK,NEWDIS S ANS=$$ASK^MAGDLB1 I ANS="D" D SETDEL Q
 . I ANS="Q"!(ANS["^") S (OOUT,OUT)=1 Q
 . I ANS="N" S OUT=1 Q
 . Q:OUT  D UPDT
 K OUT,OOUT,ANS,MAGDOUT,MAGMC,MAGSUB,SUB,XX
 Q
DISPLAY ;
 D DISPLAY^MAGDLB1
 Q
NEWCASE ;
 Q:'$D(XX(0))
 Q:'$D(XX(ITEM,1))
 S MAGDY=$G(XX(ITEM,1))  ;W !,MAGDY
 I MAGDY="" Q
 S NEWDFN=MAGPAT,NEWNME=$P(MAGDY,"^",2),NEWSSN=$P(MAGDY,"^",3)
 S NEWCAS=$P(MAGDY,"^",1),NEWPROC=$P(MAGDY,"^",5),NEWDTI=$P(MAGDY,"^",4)
 S NEWPIEN=$P(MAGDY,"^",6),MAGDIMG=$P(MAGDY,"^",7),MEDFILE=$P(MAGDY,"^",8)
 Q
CHK ;remove any punctuation before doing comparison on SSN
 ;stop on 1st check.
 N OLD,I
 Q:MAGDY=""
 S OLD="" F I=1:1:$L(PID) I $E(PID,I)?1AN S OLD=OLD_$E(PID,I)
 I NEWSSN'=OLD D  Q
 . S MSG="Social Security numbers do not match. Update?"
 I NEWNME'=PAT D
 . S MSG="Patient names do not match. Update?"
 ;Finally the problem is with the case number/DICOM ID
 S MSG="DICOM ID number is different. Update?"
 Q
NEWDIS ;
 D NEWDIS^MAGDLB1
 Q
UPDT ;
 ;S OUT=1 W !,"Will change the following: " D NEWDIS
 W !,"Are you sure you want to CORRECT?" S %=2 D YN^DICN
 I %=-1!(%=2) S OUT=1 Q
 W !,"Updating the file."
 S ^MAGD(2006.575,MAGIEN,"FIXD")="1^"_NEWDFN_"^"_NEWNME_"^"_NEWSSN_"^"_NEWCAS_"^"_NEWDTI_"^^^"_NEWPIEN W "."
 S ^MAGD(2006.575,MAGIEN,"FIXPR")=NEWPIEN_"^"_NEWPROC_"^"_$G(MAGDIMG)_"^"_MEDFILE W "."
 S MACHID=$S(MACHID="":"A",1:MACHID)  ;Server ID
 S ^MAGD(2006.575,"AFX",MACHID,MAGIEN)="" W "."
 Q
SETDEL ;Entry to be deleted
 D SETDEL^MAGDLB1
 Q
ASKWHCH ;More than one patient found with same name
 S MAGPAT=""
 N ITEM
 Q:'$D(JJ(0))
 S ITEM=$$DISPLAY^MAGDMEDL(.JJ)
 I ITEM S MAGPAT=$P(JJ(+ITEM,1),"^",3)
 Q
