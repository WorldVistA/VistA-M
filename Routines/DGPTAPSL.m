DGPTAPSL ;MTC/ALB - PTF Archive and Purge Selection Routines; 9/11/92
 ;;5.3;Registration;**31**;Aug 13, 1993
 ;
SEL() ;-- the routine will get the date range for the a/p process
 N SDATE,EDATE,Y
 S (SDATE,EDATE)=""
 ;-- get oldest record on file
 S Y=$O(^DGPT("AF",0)) D DD^%DT W !,"The oldest PTF record on file is from ",Y,"."
 S DIR(0)="D^:"_$$MAXDT(),DIR("A")="Please enter the date to begin search"
 D ^DIR
 G:$D(DIRUT) SELQ S SDATE=Y
 S DIR(0)="D^"_Y_":"_$$MAXDT(),DIR("A")="Please enter the date to end search"
 D ^DIR
 G:$D(DIRUT) SELQ S EDATE=Y
SELQ Q SDATE_"^"_EDATE
 ;
MAXDT() ;-- This function will return the lastest date allowable for
 ;purge. The date is based on the current FY - X; where X is
 ;number of years determined by VACO.
 ;  OUTPUT - date in FM format
 N DATE,YEARS
 S YEARS=3,DATE=""
 D NOW^%DTC
 ;-- get current FY
 I %I(1)>9,%I(1)<13 S DATE=%I(3)+1
 I %I(1)>0,%I(1)<10 S DATE=%I(3)
 ;-- adjust max date by YEARS
 S DATE=(DATE-YEARS)_"0930"
 K %I,X
 Q DATE
 ;
SRCH(GLB,DRANGE) ;-- search PTF file by adm date
 ; INPUT: GLB    - Global to load entries ex. "^TMP("MATT",$J,"
 ;        DRANGE - start date ^ end date in FM format
 ;        
 ; OUTPUT: Total # of entires loaded into GLB
 N SDATE,EDATE,PDATE,NREC,PTF
 S NREC=0,SDATE=$P(DRANGE,U),EDATE=$P(DRANGE,U,2)
 S PDATE=SDATE-.0000001 F  S PDATE=$O(^DGPT("AF",PDATE)) Q:'PDATE!(PDATE>EDATE)  S PTF=0 F  S PTF=$O(^DGPT("AF",PDATE,PTF)) Q:'PTF  I $$SHUDADD(PTF,DRANGE) S @(GLB_PTF_")")="",NREC=NREC+1
 Q NREC
 ;
SHUDADD(PTF,DRANGE) ;-- routine to determin if the PTF records should be added to purge
 ; INPUT : PTF - record to check
 ;         DRANGE - start and end date of search
 ; OUTPUT: 1=OK, 0=Don't Purge
 N RESULT,X,DFN
 S RESULT=1
 ;-- if PTF record does not exist... exit
 I '$D(^DGPT(PTF,0)) S RESULT=0 G SHUDEND
 S DFN=$P($G(^DGPT(PTF,0)),U)
 ;-- check if current inpatient
 S X=$O(^DGPM("APTF",PTF,0)) I '$P($G(^DGPT(PTF,70)),U),X,X=$G(^DPT(DFN,.105)) S RESULT=0 G SHUDEND
 ;-- check if discharge date is after end date
 I $P($G(^DGPT(PTF,70)),U)>$P(DRANGE,U,2) S RESULT=0 G SHUDEND
 ;-- check for entry in bill claims file
 I $D(^DGCR(399,"APTF",PTF)) S RESULT=0 G SHUDEND
 ;
SHUDEND Q RESULT
 ;
CRTEMP ;-- This function will create a sort template containing the
 ; items from the PTF File (#45) that should be Archived/Purged. The
 ; name of the template will be derive from the date range selected.
 ; Lastly, if items are selected, then an entry will be made in the
 ; PTF Archive/Purge History File (#45.62).
 ;
 ;  Sample File name DGPTAP89011391110201 = Archive PTF Sort Template 
 ; created for the date range:
 ;
 ;   Jan 13, 1989 - Nov 2, 1991 - #1 created for that date range.
 ; Note: if more then 1 entry is made for a date range then the last
 ;       2 characters will be incremented. Max for date range = 99
 ;
 ;-- get date range, build file name, get next sequence number
 N FNAME,OLFN,SEQNUM,DRANGE,TEMP,NUMREC
 ;-- get date range
 S DRANGE=$$SEL() G:DRANGE=U!($P(DRANGE,U)="")!($P(DRANGE,U,2)="") CRQ
 ;-- build template name
 S FNAME="DGPTAP"_$E(DRANGE,2,7)_$E($P(DRANGE,U,2),2,7)
 ;-- determine correct sequence number
 S SEQNUM=1,OLFN=FNAME F  S OLFN=$O(^DIBT("B",OLFN)) Q:OLFN=""!(FNAME<$E(OLFN,1,18))  I FNAME=$E(OLFN,1,18) S SEQNUM=SEQNUM+1
 S FNAME=FNAME_$S(SEQNUM<10:"0"_SEQNUM,1:SEQNUM)
 ;-- add entry to sort template file
 S DIC="^DIBT(",DIC(0)="LZ",X=FNAME,DIC("DR")="2///NOW;4///45;7///NOW"
 K DD,DO D FILE^DICN S TEMP=+Y I 'Y W !,*7,">>> Error creating Sort Template ... Try again later." G CRQ
 ;-- search File (#45), for the date range, if no entries del template
 S NUMREC=$$SRCH("^DIBT("_TEMP_",1,",DRANGE)
 I NUMREC=0 D  G CRQ
 . W !,*7,">>> No entries selected for "
 . S Y=$P(DRANGE,U) X ^DD("DD") W Y," to "
 . S Y=$P(DRANGE,U,2) X ^DD("DD") W Y,"."
 . W !,*7,">>> Deleting Sort Template."
 . S DIK="^DIBT(",DA=TEMP D ^DIK K DIK,DA
 ;-- create historical entry in file #45.62
 D CRHIS(FNAME,NUMREC,DRANGE)
CRQ K DIC,DD,DO
 Q
 ;
CRHIS(FNAME,NUMREC,DRANGE) ;-- This function will create an entry in the 
 ; PTF Archive/Purge History File (#45.62). 
 ;
 ;    INPUT :  FNAME - Name of entry (same as search template)
 ;            NUMREC - Total number of records to process
 ;  
 W !,">>> Creating PTF Archive/Purge History entry."
 S DIC="^DGP(45.62,",DIC(0)="LZ",X=FNAME,DIC("DR")=".08///"_FNAME_";.09///^S X=NUMREC;.1///"_$P(DRANGE,U)_";.11///"_$P(DRANGE,U,2)
 K DD,DO D FILE^DICN S TEMP=+Y
 K DIC
 Q
 ;
DELENTRY(FNAME) ;-- This function will delete the entry in the
 ; the PTF Archive/Purge History file and the search
 ; template.
 ;   INPUT : FNAME - History File to delete.
 ;
 N RECNUM
 W *7,!,">>> Deleting PTF Archive/Purge History entry."
 S RECNUM=$O(^DGP(45.62,"B",FNAME,0)) I 'RECNUM G DELENQ
 S DA=$P(^DGP(45.62,RECNUM,0),U,8) I DA S DIK="^DIBT(" D ^DIK K DIK,DA
 S DIK="^DGP(45.62,",DA=RECNUM D ^DIK K DIK,DA
DELENQ Q
 ;
