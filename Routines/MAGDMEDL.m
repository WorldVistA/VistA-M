MAGDMEDL ;WOIFO/LB - Routine to look up entries in the Medicine files ; 06/06/2007 09:42
 ;;3.0;IMAGING;**51,54**;03-July-2009;;Build 1424
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
SELECT(ITEM,ARRAY) ;
 ;
 N CNT,DIR,DIROUT,DIRUT,ENTRY
 S CNT=+ARRAY
 I 'CNT Q 0
 S DIR(0)="NO^1:"_CNT,DIR("A")="Select a Medicine Procedure"
 S DIR("T")=600 D ^DIR
 I $D(DIRUT)!($D(DIROUT)) Q 0
 S ENTRY=+Y
 I '$D(ARRAY(ENTRY)) D  G SELECT
 . W !,"Please select an entry or use '^' to exit"
 W !,"You have selected ",$P(ARRAY(ENTRY),"^"),"."
 Q $P(ARRAY(ENTRY),"^",2)
 ;
LOOP(ARRAY,MAGPAT,SUB,CASEDT) ;
 ; MAGPAT = patient's dfn
 ; SUB = Medicine specialty
 ; CASEDT = case date
 ;  array(0)= 1 or 0 ^ # entries found ^ message text
 ;  array(#)= formatted out display without delimiters
 ;  array(#,1) = internal stored values
 ; Variable MAGDIMG
 S ARRAY(0)="0^^No entries found"
 Q:'MAGPAT
 Q:'$D(MAGMC)#10   ;Array should be available.
 N BEG,CDT,CNT,DATA,DICOM,EN,END,IMG,IMAGEPTR,MAGDIMG,PATIENT,PATNME,PRC,PRCNM,SSN,THEDT,X1,X2,X
 N IEN,II,IOUT,MAGMC,MEDFILE
 Q:'$$FIND1^DIC(2,,"A",MAGPAT,"","")
 S PATNME=$P(^DPT(MAGPAT,0),"^"),SSN=$P(^(0),"^",9)
 S PATIENT=PATNME_" "_SSN
 S:'CASEDT CASEDT=DT
 S BEG=$$FMADD^XLFDT(CASEDT,-3),END=CASEDT+.9999,CNT=0,CDT=BEG-.001
 F  S CDT=$O(MAGMC(MAGPAT,SUB,CDT)) Q:'CDT!(CDT>END)  D
 . S EN=0 F  S EN=$O(MAGMC(MAGPAT,SUB,CDT,EN)) Q:'EN  D
 . . S DATA=MAGMC(MAGPAT,SUB,CDT,EN)
 . . S PRCNM=$P(DATA,"^",2),PRC=SUB
 . . S THEDT=$P(DATA,"^"),IEN=$P(DATA,"^",5)
 . . I $D(MAGMC(MAGPAT,SUB,CDT,EN,2005)) S (IOUT,II)=0 D
 . . . F  S II=$O(MAGMC(MAGPAT,SUB,CDT,EN,2005,II)) Q:'II!IOUT  D
 . . . . S IMAGEPTR=MAGMC(MAGPAT,SUB,CDT,EN,2005,II)
 . . . . I '$D(^MAG(2005,IMAGEPTR)) S IMAGEPTR="" Q
 . . . . I '$D(^MAG(2005,IMAGEPTR,"PACS"))  S IMAGEPTR="",IOUT=1
 . . S MEDFILE=$P(DATA,"^",4),MEDFILE=$P(MEDFILE,"MCAR(",2)
 . . S DICOM="" D DICOMID^MAGDMEDI(.DICOM,MEDFILE,IEN,PRC,MAGPAT)
 . . I DICOM'="" D
 . . . S DICOM=$P(DICOM,":",2)
 . . . S CNT=CNT+1
 . . . S ARRAY(CNT)=DICOM_" "_PRCNM_", "_THEDT_" "_PATIENT
 . . . S ARRAY(CNT,1)=DICOM_"^"_PATNME_"^"_SSN_"^"_EN_"^"_PRCNM_"^"_PRC_"^"_$G(IMAGEPTR)_"^"_MEDFILE
 I CNT S ARRAY(0)="1^"_CNT_"^Medicine file entries for "_PATIENT
 Q
 ;
DISPLAY(ARRAY) ;
 ; Call routine needs to pass array in the following sequence
 ; ARRAY(0)= 1 or 0 ^ #entries ^ message
 ; ARRAY(#)=  Formatted output to be displayed.
 ; Will set the RES variable for selected entry.
 I '$D(ARRAY(0)) Q 0
 ; If only one entry return the subscript variable.
 I $P(ARRAY(0),"^",2)=1 Q 1
 I $P(ARRAY(0),"^")'=1 Q 0
 N ENTRY,ITEM,ITEMS,MSG,OUT,OUTPUT,RES
 S RES=0,MSG=$P(ARRAY(0),"^",3)
 S IOF="#,$C(27,91,72,27,91,74,8,8,8,8)",IO=0,IOSL=24,POP=0
 D HEAD
 S (ENTRY,OUT)=0,ITEMS=$P(ARRAY(0),"^",2)
 F  S ENTRY=$O(ARRAY(ENTRY)) Q:'ENTRY!OUT  D
 . S OUTPUT=$G(ARRAY(ENTRY))
 . D:$Y+3>IOSL HEAD D LINE
 . D:$Y+3>IOSL ASKQ
 I 'OUT D ASKQ S RES=ITEM
 Q RES
 ;
HEAD ;
 W:$Y+3>IOSL @IOF W !,MSG
 Q
 ;
LINE ;
 W !,ENTRY,".) "_OUTPUT
 Q
 ;
ASKQ ;
 N X,Y,DIR
 S DIR(0)="L^1:"_$S('ENTRY:ITEMS,1:ENTRY)
 S DIR("T")=600,DIR("A")="Select an entry: " D ^DIR
 S ITEM=+Y
 Q:$D(DIRUT)!($D(DIROUT))
 Q:'ITEM
 I '$D(ARRAY(ITEM)) W !,"Please select an entry or '^' to exit" G ASKQ
 W !,"You have selected ",$P($G(ARRAY(ITEM)),"^")
 S OUT=1
 Q
 ;
ASKMORE() ;
 N DIR,DATE,X,XX,Y
 Q:'$D(MAGPAT)
 Q:'$D(SUB)
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Search further"
 D ^DIR K DIR
 I 'Y Q 0
 W !,"Search will include 3 days prior to the day specified."
 S DIR(0)="D^::EXP" D ^DIR
 ; Y2K compliance all calls to %DT must have either past or future date
 I 'Y Q 0
 S DATE=Y
 D LOOP(.XX,MAGPAT,SUB,DATE)
 I $D(XX(0)),$P(XX(0),"^")=0 D  Q 0
 . W "No entries found."
 Q 1
 ;
