NURSCEP ;HIRMFO/JH/MH/MD-LIST STAFF (#210) FILE DISCREPANCIES ;7/15/97
 ;;4.0;NURSING SERVICE;**6**;Apr 25, 1997
TXT ;;This option generates an exception report that identifies the
 ;;following discrepancies between the NURS Staff (#210) and the
 ;;NURS Position Control (#211.8) Files:
 ;;
 ;;a.  Staff record has no corresponding New Person (#200) file entry.
 ;;b.  Staff record contains missing/invalid data in the Name field .01.
 ;;c.  Staff record has missing/invalid Status data in field 5.5.
 ;;d.  Staff record missing the 'B' index entry.
 ;;e.  Staff Employee has 'ACTIVE' status and no active file 211.8 assignment(s).
 ;;f.  Staff Record has 'B' index entry and no data on zeroth node.
 ;;g.  File (#211.8) contains duplicate assignment entries for an employee.
 ;;h.  File (#211.8) contains assignments with no corresponding staff record.
 ;;i.  File (#211.8) contains active assignments for inactive nursing locations.
 ;;
EN1 I '$D(^NURSF(210,0))!('$D(^NURSF(211.8,0))) W !!,"*** MISSING NURSING FILE ***" Q
 S TXT=$T(TXT) W ! F I=0:1:12 S TXT=$T(TXT+I) W !,$P(TXT,";",3)
ASK W !!,"Do you want the discrepancy report queued to a printer ?" S DIR(0)="Y",DIR("B")="NO" D ^DIR S NUROUT=+$G(DIRUT) G QUIT:NUROUT G START:Y=0
 W ! S ZTDESC="STAFF DISCREPANCIES",ZTRTN="START^NURSCEP" D QUEUE G:$D(ZTSK)!$G(POP) QUIT D:$D(ZTSK)#2 HOME^%ZIS
START U IO D NOW^%DTC S NDATE=%I(1)_"/"_%I(2)_"/"_$E(%I(3),2,3),(NSW1,NURQUEUE,NURPAGE,NURQUIT,NUROUT)=0 W ! K ^TMP("NOSTAFF",$J),^TMP("NURS",$J),^TMP("NURP",$J),^TMP("NURPOS",$J)
 I $E(IOST)="C" W !,"Checking the NURS Staff (#210) File..."
 S (NUM,NURSDA)=0 F  S NURSDA=$O(^NURSF(210,NURSDA)) Q:NURSDA'>0  S NPDA=+$G(^NURSF(210,NURSDA,0)),NSTAT=$P($G(^(0)),U,2),NAM=$S($G(^VA(200,+NPDA,0))'="":$P(^(0),U),1:"** INVALID NAME DATA **"),NUM=(NUM+1) D
 .  W:$E(IOST)="C"&($R(2000)) "." I '$$EN1^NURSUT0(NPDA,DT),$P($G(^NURSF(210,NURSDA,0)),U,2)="A",$D(^VA(200,NPDA,0)) S SW=5 D SETSTF ;Active employee/no assignment(s)
 .  I $P($G(^NURSF(210,NURSDA,0)),U)'>0 S SW=2 D SETSTF ;Emp. entry has missing/invalid data in name field
 .  I '$D(^VA(200,NPDA,0)),'$D(^TMP("NURS",$J,NUM,3,NURSDA)) S SW=1 D SETSTF ;Employee not in New Person File.
 .  I '$D(^NURSF(210,"B",NPDA)),'$D(^TMP("NURS",$J,NUM,3,NURSDA)) S SW=4 D SETSTF ;Emp. has missing B xrf in Nurstaff File.
 .  I NSTAT'="A",NSTAT'="R",NSTAT'="I"!(NSTAT="") S SW=3 D SETSTF
 . Q
 S NPDA=0 F  S NPDA=$O(^NURSF(210,"B",NPDA)) Q:NPDA'>0  S NURSDA=$O(^NURSF(210,"B",NPDA,0)) I +NURSDA,$G(^NURSF(210,+NURSDA,0))="" D
 . S NUM=(NUM+1),NAM=$S($G(^VA(200,+NPDA,0))'="":$P(^(0),U),1:"** INVALID NAME DATA **"),SW=6 D SETSTF ; 'B' xref no data on zeroth node
 . Q
 I $E(IOST)="C" W !,"Checking the NURS Position Control (#211.8) File..."
 S NOD=0 F  S NOD=$O(^NURSF(211.8,NOD)) Q:NOD'>0  S NDA=0 F  S NDA=$O(^NURSF(211.8,NOD,1,NDA)) Q:NDA'>0  I $G(^NURSF(211.8,NOD,1,NDA,0))'="",$P($G(^(0)),U,6)="" D
 .  S NAM=+$P(^NURSF(211.8,NOD,1,NDA,0),U,2),NFTE=+$P($G(^(0)),U,4)
 .  S Q=$G(^NURSF(211.8,NOD,1,NDA,0)) S STDAT=$P(Q,U),NPOS=$P(Q,U,3),NFT=$P(Q,U,4),ENDAT=$P(Q,U,6)
 .  S NPOS(1)=$S($D(^NURSF(211.3,+NPOS,0)):$P(^(0),U,1),1:""),NSWRD=$P($G(^NURSF(211.8,NOD,0)),U),NWRD=$P($P(^SC(NSWRD,0),"NUR ",2),U)
 .  S:STDAT'="" SDAT=$E(STDAT,4,5)_"/"_$E(STDAT,6,7)_"/"_$E(STDAT,2,3) S EDAT="" S:ENDAT'="" EDAT=$E(ENDAT,4,5)_"/"_$E(ENDAT,6,7)_"/"_$E(ENDAT,2,3)
 .  I $$STAT^NURSCEP1(NOD) S ^TMP("INACT",$J,NAM,NOD,NDA)=NPOS(1)_U_NWRD_U_NFT_U_SDAT_U_EDAT
 .  S:'$D(^NURSF(210,"B",NAM)) ^TMP("NOSTAFF",$J,NAM,NOD,NDA)=NPOS(1)_U_NWRD_U_NFT_U_SDAT_U_EDAT
 .  I NFTE>0,$D(^TMP("NURPOS",$J,NAM,1)) S ^TMP("NURPOS",$J,NAM,1)=^TMP("NURPOS",$J,NAM,1)_NOD_";"_NDA_U F X=1:1 Q:$P(^TMP("NURPOS",$J,NAM,1),U,X)=""  S Y=$P(^(1),U,X),NOD=$P(Y,";"),NDA=$P(Y,";",2) D GETDATA
 .  S:'$D(^TMP("NURPOS",$J,NAM,NFTE)) ^(NFTE)=NOD_";"_NDA_U
 .  Q
 I '$D(^TMP("NURS",$J)),'$D(^TMP("NURP",$J)),'$D(^TMP("NOSTAFF",$J)),'$D(^TMP("INACT",$J)) S NURTYPE="" D HDR^NURSCEP1 W !!,"No discrepancies were found between the 210 and 211.8 files." G QUIT
 D ^NURSCEP1
QUIT ;
Q K ^TMP("NOSTAFF",$J),^TMP("NURS",$J),^TMP("NURP",$J),^TMP("NURPOS",$J) D CLOSE^NURSUT1,^NURSKILL
 Q
QUEUE ;
 S %ZIS="Q",IOP="Q" D ^%ZIS K %ZIS K:POP IO("Q") Q:POP
 I $D(IO("Q")) K IO("Q"),IO("C") S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL D ^%ZTLOAD S:'$D(ZTSK) POP=1
 Q
GETDATA ;
 W:$E(IOST)="C"&($R(20000)) "."
 S:'$D(^TMP("NURP",$J,NAM,NOD,NDA)) ^(NDA)=NPOS(1)_U_NWRD_U_NFT_U_SDAT_U_EDAT
 Q
SETSTF ;
 S:'$D(^TMP("NURS",$J,"L",NURSDA,NAM)) ^(NAM)=NUM
 S ^TMP("NURS",$J,"L1",NUM,SW)=""
 Q
