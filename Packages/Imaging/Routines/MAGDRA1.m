MAGDRA1 ;WOIFO/LB -Routine for DICOM fix ; 09/15/2004  13:34
 ;;3.0;IMAGING;**10,11,30**;16-September-2004
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
LOOP ;Loop thru ^TMP($J,"RAE1" global
 ;MAGDFN should exist.
 ;MAGNME,MAGSSN may exist.
 Q:'$D(^TMP($J,"RAE1"))!('$D(MAGDFN))
 N CCASE,CASE,CDATE,CODE,DATA,DATE,ENTRY,ENTRIES,ERR,ESTAT,INDEX
 N LOC,MAGCASE,MAGCNI,MAGCPT,MAGDTI,MAGPIEN,MAGPRC,MAGPSET,MAGPST
 N OUT,OLDCNI,OLDDT,OLDENTRY,PROC,PSET,PTINFO,RARPT,RADTI,RACNI,RADFN
 N RAMELOW,RAPRTSET,REIN,STAT,X,Y
 S (ENTRY,ENTRIES,OLDDT)=0
 F  S ENTRY=$O(^TMP($J,"RAE1",MAGDFN,ENTRY)) Q:'ENTRY!$G(OUT)  D
 . S DATA=^TMP($J,"RAE1",MAGDFN,ENTRY),ENTRIES=ENTRIES+1
 . S DATE=$P(ENTRY,"-"),CDATE=9999999.9999-DATE
 . S DATE=$TR($$FMTE^XLFDT(CDATE,"2FD")," ","0")
 . S PROC=$P(DATA,"^"),CASE=$P(DATA,"^",2),STAT=$P(DATA,"^",6)
 . S ESTAT=$P(STAT,"~",2),LOC=$P(DATA,"^",7)
 . S RARPT=$P(DATA,"^",5)
 . S RADTI=$P(ENTRY,"-"),RACNI=$P(ENTRY,"-",2),RADFN=MAGDFN
 . S MAGCASE=$$LCASE^MAGDRA2(CDATE,CASE)
 . ;Above radiology variables needed for EN1^RAULT20
 . K RAMELOW,RAPRTSET
 . D EN1^RAUTL20
 . S (PSET,MAGPSET)=""
 . I OLDDT'=RADTI S OLDCNI=""
 . S PSET=$S(RAMEMLOW:"+",RAPRTSET:".",1:"")
 . I PSET="+" S OLDCNI=RACNI
 . I PSET=".",OLDCNI D
 . . N OLDENTRY S OLDENTRY=$P(ENTRY,"-")_"-"_OLDCNI
 . . I $D(^TMP($J,"RAE1",MAGDFN,OLDENTRY)) D
 . . . S MAGCASE=$P(^TMP($J,"RAE1",MAGDFN,OLDENTRY),"^",2)
 . . . S CDATE=$P(ENTRY,"-")
 . . . S CDATE=9999999.9999-CDATE,RADTI=$P(OLDENTRY,"-"),RACNI=OLDCNI
 . . . S MAGCASE=$$LCASE^MAGDRA2(CDATE,MAGCASE)
 . . . S MAGPSET=CASE_" is part of this printset."
 . . . Q
 . . Q
 . I '$D(MAGNME)!'($D(MAGSSN)) D
 . . S PTINFO=$$PTINFO^MAGDRA2
 . . S MAGNME=$P(PTINFO,"^"),MAGSSN=$P(PTINFO,"^",2)
 . . Q
 . S INDEX(ENTRIES)=PROC_"^"_$G(MAGPSET)_"^"_RADTI_"^"_RACNI_"^"_MAGCASE
 . ; Radiology procedure^Printset^Inverse radiology date/time^Radioloty multiple^radiology case number
 . D PRT S OLDDT=RADTI
 . Q
 D:'$G(OUT) SEL I +X,$D(INDEX(+X)) D SET
 K OUT
 Q
PRT ;
 S (X,Y)=0
 I ENTRIES=1 D HEAD
 I $Y+6>IOSL D HEAD
 W !?1,ENTRIES,?5,PSET,?6,CASE_$$IMG^MAGDRA2(RARPT),?12,$E(PROC,1,28)
 W ?41,DATE,?52,$E(ESTAT,1,12),?67,$E(LOC,1,12) Q:ENTRIES#15
 D SEL
 Q
HEAD ;
 W @IOF,"Patient: ",MAGNME,?50,"SSN: ",MAGSSN
 W !!,?3,"Case #",?12,"Procedure",?41,"Exam Date",?52,"Status of"
 W "Exam",?69,"Imaging Loc"
 W !?3,"--------",?12,"-------------",?41,"---------"
 W ?52,"--------------",?67,"-----------"
 Q
SEL ;
 N DIR ; -- array for FileMan prompt data
 S DIR(0)="NAO^1:"_ENTRIES
 S DIR("?",1)="Enter a number between 1 and "_ENTRIES
 S DIR("?")="corresponding to a single exam you wish to select."
 S DIR("A",1)="'i' next to a case number denotes images collected on study."
 S DIR("A")="Select an exam: "
 D ^DIR
 I '$D(DTOUT),'$D(DUOUT) ; didn't time out or uparrow out
 E  S OUT=1 Q
 I Y,$D(INDEX(Y)) D CHECK I 'Y G SEL
 I Y S Y=INDEX(Y) S OUT=1
 Q
SET ;
 S DATA=Y K Y
 S MAGCASE=$P(INDEX(+X),"^",5)
 S MAGPRC=$P(INDEX(+X),"^"),MAGPIEN=$$PROC^MAGDRA2(MAGPRC)
 S MAGDTI=$P(INDEX(+X),"^",3)
 S MAGPST=$P(INDEX(+X),"^",2)
 S MAGCNI=$P(INDEX(+X),"^",4)
 D MAGDY^MAGDRA2
 Q
CHECK ;
 ;Check to see if the entry still exists.
 N RADTI,CNI
 Q:'MAGDFN
 S RADTI=$P(INDEX(Y),"^",3),CNI=$P(INDEX(Y),"^",4)
 I '$D(^RADPT(MAGDFN,"DT",RADTI,"P",CNI)) D
 . S Y=""
 . W !,"There is a database problem with the entry selected.",!
 . Q
 I $P(INDEX(Y),"^")="" D
 . S Y=""
 . W !,"There are no procedures for the entry selected.",!
 Q
