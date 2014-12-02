MAGSDOFF ; OI&T-Clin3/DWM - DEX & AA Track Offline Images ; 01/31/13
 ;;3.0;IMAGING;**135**;Mar 19, 2002;Build 5238;Jul 17, 2013
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
 ;  Process:
 ;     - validate mail group 'OFFLINE IMAGE TRACKERS'
 ;     - read and store platter report in ^TMP($J, global
 ;     - extract image file names into ^TMP($J,"PLATTER",
 ;     - import image file names into #2006.033 'OFFLINE IMAGES FILE'
 ;     - update original AA platter report to DEX format
 ; Original AA platter report format:
 ;   "File Path","File ID","File Size","Migration ID",
 ;   "Migration Time",Status "
 ; 'Split' files are added as duplicates but with their corresponding
 ;    platter name - this allows online/offline to work as needed.
 Q
EN ; entry point; called by ^MAGSDOFL; from option [MAG JB OFFLINE]
 N FILE,PATH,Y,L,LN,N,XX,DIR,X,GRP,MAILCHK,I,MAGPLAT
 K ^TMP($J),DIR
 W !!,"AA Offline Platter Utility",! F I=1:1:26 W "-"
 ;
 ; validate mail group 'OFFLINE IMAGE TRACKERS'
 S GRP="OFFLINE IMAGE TRACKERS"
 W !!,"Validating mail group '"_GRP_"'..." H 2
 S MAILCHK=$$MAIL(GRP) F I=1:1:$L(MAILCHK,U) W !,?7,$P(MAILCHK,U,I)
 ;
 ; ask directory & file name
 D DIR
 I '$D(PATH)!('$D(FILE)) Q
 ;
 ; $$FTG^%ZISH(): Load Host File into Global
 W !!,"Extracting data from "_FILE_"..."
 S Y=$$FTG^%ZISH(PATH,FILE,$NA(^TMP($J,0)),2)
 I Y=0 D ERR(1,FILE,PATH) G EXIT
 I '$D(^TMP($J)) D ERR(2,FILE) G EXIT
 W "completed.",!
 ;
 ; extract image file name from data saved in ^TMP($J,
 D PULL
 I '$D(^TMP($J,"PLATTER")) D  Q
 . W !!,"No files to take offline - "
 . W "platter report will not be modified",!! Q
 ;
 ; import image file names into #2006.033 'OFFLINE IMAGES FILE'
 D OFF
 I MAGPLAT="ERROR" D  G EXIT
 . W !!,"Unable to create unique report platter name 30 characters or less"
 . Q
 ; update platter report file in directory
 D UPD
 ;
EXIT ;
 ;
 K ^TMP($J),FILE,PATH,MAGPLAT
 Q
 ;
DIR ; ask path & file name
 N DIR,Y,I
 W ! S DIR(0)="F"
 S DIR("A")="Enter File Directory ( example user$:[dir] ) "
 D ^DIR Q:Y["^"!(Y=-1)  S PATH=Y K DIR
 S DIR(0)="F"
 S DIR("A")="Enter File Name ( example aab42_134175.txt ) "
 D ^DIR Q:Y["^"!(Y=-1)  S FILE=Y K DIR
 Q
 ;
PULL ; extract image file name from data saved in ^TMP($J,
 ; build ^TMP($J,"PLATTER",L)=file_name
 N L,LN,N,XX,CNT
 W !,"Pulling image file names from report data",!
 S (L,CNT)=0 F  S L=$O(^TMP($J,L)) Q:'L  D
 . S LN=^TMP($J,L)
 . ; pattern match example "bil0001.txt ..."
 . I $P(LN," ",1)?.E1"."2.5AN D  Q
 .. S LN=$P(LN," ") D SET
 .. Q
 . ; pull name "default/xxx0/00/23/46/97/xxx00023469737.TIF",2028..."
 . I LN["/" D
 .. ; a few bogus lines may exist in report
 .. Q:LN[".config_backup"!(LN["self_test")
 .. S LN=$P(LN,"""",2)
 .. F N=1:1 S XX=$P(LN,"/",N) Q:XX=""  I XX?.E1"."2.5AN S LN=XX
 .. D SET
 .. Q
 . Q
 W !,"completed -  "_CNT_" file names found.",!
 Q
 ;
SET ; LN = image file name
 S CNT=CNT+1 I CNT#500=0 W "."
 S ^TMP($J,"PLATTER",CNT)=LN
 Q
 ;
OFF ; import image file names into #2006.033 'OFFLINE IMAGES FILE'
 N L,CNT,CNT1,MAGFL,MAGFDA,MAGIEN,LN
 N DIERR,MRK,OIEN,RPT,DUP,MAGPLAT1,I
 S (L,CNT,CNT1,DUP)=0,MAGFL=2006.033
 ; platter name limited to 30 characters, and must be unique
 S MAGPLAT=$P(FILE,".") S:$L(MAGPLAT)>30 MAGPLAT=$$PLAT(MAGPLAT)
 Q:MAGPLAT="ERROR" 
 W !,"Updating the individual image files as 'offline'"
 F  S L=$O(^TMP($J,"PLATTER",L)) Q:'L  D
 . S LN=^TMP($J,"PLATTER",L)
 . ;
 . ; check for existing image file from same platter report
 . I $D(^MAGQUEUE(2006.033,"B",LN)) S MRK=0 D  Q:MRK
 .. S OIEN="" F  S OIEN=$O(^MAGQUEUE(2006.033,"B",LN,OIEN)) Q:'OIEN  D
 ... S RPT=$P(^MAGQUEUE(2006.033,OIEN,0),U,2)
 ... ; file/platter entry already in #2006.033:
 ... I RPT=MAGPLAT S MRK=1,DUP=DUP+1
 ... Q
 .. Q
 . ;
 . S CNT=CNT+1 I CNT#500=0 W "."
 . ; using "+1," instead of "?+1," to allow duplicate "split" entries
 . K MAGIEN S MAGIEN="+1,"
 . S MAGFDA(MAGFL,MAGIEN,.01)=LN ;   .01 FILENAME
 . S MAGFDA(MAGFL,MAGIEN,1)=MAGPLAT ;  1 JUKEBOX PLATTER
 . D UPDATE^DIE("E","MAGFDA","MAGIEN","MAGERR")
 . ;
 . ; check and process error msg if needed
 . I '$D(DIERR) S CNT1=CNT1+1
 . E  D ERR(3,LN,"",.MAGERR) K MAGERR
 . Q
 W !,"Done - "_CNT1_" entries added to #2006.033"
 ; "duplicates" could be 1. already in #2006.033 or an actual
 ;  file duplication on the platter report
 I DUP W !,DUP_" duplicate(s) not added"
 Q
 ;
UPD ; update platter report file in directory
 N Y,LAST,LAST1
 I MAGPLAT'=$P(FILE,".") W !!,"Creating new platter report "_MAGPLAT
 E  W !!,"Reformatting platter report "_MAGPLAT
 I '$D(^TMP($J,"PLATTER")) D  Q
 . W !!,"No platter data available for updating of report!"
 . Q
 ; add platter name at top; add end statement
 S ^TMP($J,"PLATTER",0)="Media """_MAGPLAT_""""  ;platter name
 S LAST="",LAST=$O(^TMP($J,"PLATTER",LAST),-1),LAST1=LAST+1
 S ^TMP($J,"PLATTER",LAST1)=LAST_" Files Listed"
 ;
 S FILE=MAGPLAT_".TXT",Y=$$GTF^%ZISH($NA(^TMP($J,"PLATTER",0)),3,PATH,FILE)
 I 'Y W !!,"Unable to create/update platter report",! W PATH_FILE Q
 W !,"Finished"
 Q
 ;
PLAT(MAGPLAT) ; starting at 30 char length, whittle down until unique
 N MAGPLAT30,I
 W !,"Original report name is greater than the allowed 30 characters,"
 W !,?5,"a new name for the report will be generated for #2006.033."
 S MAGPLAT30=""
 F I=30:-1:2 D:MAGPLAT30'=MAGPLAT
 . S MAGPLAT30=$E(MAGPLAT,1,I) D
 . ; check to see if platter name already exist
 . Q:$D(^MAGQUEUE(2006.033,"C",MAGPLAT30))
 . S MAGPLAT=MAGPLAT30
 . Q
 ; unable to create unique platter name
 I MAGPLAT30'=MAGPLAT Q "ERROR"
 ;
 Q MAGPLAT
 ;
ERR(TY,T1,T2,T3) ; error messaging
 Q:'TY
 I TY=2 W !!,"Unable to pull data from "_T1 Q
 I TY=3 D  Q
 . W !!,"Unable to add "_LN_" as an offline image",!
 . D MSG^DIALOG("WE","",50,5,"T3") K T3
 . Q
 W !!,"Unable to access "_T2_T1
 K TY,T1,T2
 Q
 ;
MAIL(GRP) ; add "OFFLINE IMAGE TRACKERS" and/or active member
 ;  No update if group exist w/active local member
 ;  If no group add it, add DUZ as member and mag server
 ;  If group w/o active local member, add DUZ as member and mag server
 ;
 N CHKG,CHKM,Y,TYPE,INT,ENR,XMY,ORG,DESC,MAGMAIL,MAGSVR,GRPIEN,RES
 I GRP="" Q "No action taken, mail group name required"
 S CHKG=$D(^XMB(3.8,"B",GRP)),CHKM=$$GOTLOCAL^XMXAPIG(GRP)
 S MAGMAIL="G.MAG SERVER" I $D(^XMB(3.8,"B",$P(MAGMAIL,".",2))) D
 . S MAGSVR="",MAGSVR=$O(^XMB(3.8,"B",$P(MAGMAIL,".",2),MAGSVR))
 ;
 ;  mail group exist w/active member
 Q:CHKG&(CHKM) "Mail group '"_GRP_"' present with active member."
 I '$D(DUZ) Q "No DUZ defined, unable to add/edit mail group."
 ;
 S (TYPE,ENR)=0,INT=1,ORG=DUZ,XMY(DUZ)=""
 S DESC(1)="Mail group to send messages regarding accessing "
 S DESC(1)=DESC(1)_"images on offline jukebox platters."
 S Y=$$MG^XMBGRP(GRP,TYPE,ORG,ENR,.XMY,.DESC,INT)
 I 'Y D  Q RES(1)_U_RES(2)
 . S RES(1)="Unable to add mail group '"_GRP_"', contact "
 . S RES(2)="Support if further assistance is needed."
 S GRPIEN=Y
 ;
 ; add 'MAG SERVER' as member group if not already there
 S (RES(3),RES(4))=""
 I $D(MAGSVR)&('$D(^XMB(3.8,GRPIEN,5,"B",MAGSVR))) D
 . D ADDMBRS^XMXAPIG(DUZ,GRP,MAGMAIL)
 . Q:'$D(^XMB(3.8,GRPIEN,5,"B",MAGSVR))
 . S RES(3)="Added member group: '"_MAGMAIL_"' to mail group"
 . S RES(4)=" '"_GRP_"'"
 ;
 ; "offline" group and members added
 I 'CHKG D  Q RES(1)_U_RES(2)_U_RES(3)
 . S RES(1)="Mail group '"_GRP_"' created."
 . S RES(2)="Added local user: '"_$P(^VA(200,DUZ,0),U)
 . S RES(2)=RES(2)_"' to mail group"
 ;
 ; "offline" was present but w/o an active local user
 S RES(1)="Added local user '"_$P(^VA(200,DUZ,0),U)
 S RES(1)=RES(1)_"' to mail group '"_GRP_"'"
 Q RES(1)_U_RES(3)_RES(4)
 ;
KILL ; remove before release
 K ^MAGQUEUE(2006.033)
 S ^MAGQUEUE(2006.033,0)="OFFLINE IMAGES^2006.033AO^"
 Q
