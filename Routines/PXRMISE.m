PXRMISE ; SLC/PKR - Index size estimating routines. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**6,12,17**;Feb 04, 2005;Build 102
 ;
 ;========================================================
EST ;Driver for making index counts.
 N BLOCKS,FROM,FUNCTION,GBL,GLIST,IND,NE,NL,NUMGBL,RTN
 N SF,TASKIT,TBLOCKS,TO,XMSUB
 D SETDATA(.GBL,.GLIST,.NUMGBL,.RTN,.SF)
 I +SF=-1 D ERRORMSG^PXRMISF(SF)  Q
 S (NL,TBLOCKS)=0
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Start time "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Size Estimate for ^PXRMINDX"
 F IND=1:1:NUMGBL D
 . S FUNCTION="S NE=$$"_RTN(GBL(IND))
 . X FUNCTION
 . S BLOCKS=NE*SF(GBL(IND))
 . S BLOCKS=$FN(BLOCKS,"","")+1
 . S TBLOCKS=TBLOCKS+BLOCKS
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Estimates for "_GLIST(IND)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Number of entries: "_NE
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Number of blocks: "_BLOCKS
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Total estimated blocks: "_TBLOCKS
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="End time "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S XMSUB="Size estimate for index global"
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S TO(DUZ)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,FROM)
 S ZTREQ="@"
 Q
 ;
 ;===============================================================
ESTTASK ;Task the index size estimation.
 N DIR,DTOUT,DUOUT,MINDT,SDTIME,X,Y
 S MINDT=$$NOW^XLFDT
 W !,"Queue the Clinical Reminders index size estimation."
 S DIR("A",1)="Enter the date and time you want the job to start."
 S DIR("A",2)="It must be after "_$$FMTE^XLFDT(MINDT,"5Z")
 S DIR("A")="Start the task at: "
 S DIR(0)="DAU"_U_MINDT_"::RSX"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S SDTIME=Y
 K DIR
 ;Put the task into the queue.
 S ZTRTN="EST^PXRMISE"
 S ZTDESC="Clinical Reminders index size estimation"
 S ZTDTH=SDTIME
 S ZTIO=""
 D ^%ZTLOAD
 W !,"Task number ",ZTSK," queued."
 Q
 ;
 ;===============================================================
NEOR() ;Return number of entries in OR.
 ;DBIA #4180
 Q $P(^OR(100,0),U,4)
 ;
 ;===============================================================
NEPROB() ;Return number of entries in PROBLEM LIST.
 ;DBIA #3837
 Q $P(^AUPNPROB(0),U,4)
 ;
 ;===============================================================
NEPS() ;Return number of entries in PS(55).
 N ADD,DA,DA1,DFN,DRUG,IND,NE,SDATE,SOL,STARTD,TEMP
 ;DBIA #4181
 S (DFN,IND,NE)=0
 F  S DFN=+$O(^PS(55,DFN)) Q:DFN=0  D
 .;Process Unit Dose.
 . S DA=0
 . F  S DA=+$O(^PS(55,DFN,5,DA)) Q:DA=0  D
 .. S TEMP=$G(^PS(55,DFN,5,DA,2))
 .. S STARTD=$P(TEMP,U,2)
 .. I STARTD="" Q
 ..;If the order is purged then SDATE is 1.
 .. S SDATE=$P(TEMP,U,4)
 .. I SDATE=1 Q
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,5,DA,1,DA1)) Q:DA1=0  D
 ... S DRUG=$P(^PS(55,DFN,5,DA,1,DA1,0),U,1)
 ... I DRUG="" Q
 ... S NE=NE+1
 .;Process the IV mutiple.
 . S DA=0
 . F  S DA=+$O(^PS(55,DFN,"IV",DA)) Q:DA=0  D
 .. S TEMP=$G(^PS(55,DFN,"IV",DA,0))
 .. S STARTD=$P(TEMP,U,2)
 .. I STARTD="" Q
 .. S SDATE=$P(TEMP,U,3)
 .. I SDATE=1 Q
 ..;Process Additives
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,"IV",DA,"AD",DA1)) Q:DA1=0  D
 ... S ADD=$P(^PS(55,DFN,"IV",DA,"AD",DA1,0),U,1)
 ... I ADD="" Q
 ... S DRUG=$P($G(^PS(52.6,ADD,0)),U,2)
 ... I DRUG="" Q
 ... S NE=NE+1
 ..;Process Solutions
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,"IV",DA,"SOL",DA1)) Q:DA1=0  D
 ... S SOL=$P(^PS(55,DFN,"IV",DA,"SOL",DA1,0),U,1)
 ... I SOL="" Q
 ... S DRUG=$P($G(^PS(52.7,SOL,0)),U,2)
 ... I DRUG="" Q
 ... S NE=NE+1
 Q NE
 ;
 ;===============================================================
NEPSRX() ;Return number of entries in PSRX
 N DA,DA1,DATE,DSUP,DFN,DRUG,NE,RDATE,TEMP
 ;DBIA #4182
 S (DA,NE)=0
 F  S DA=+$O(^PSRX(DA)) Q:DA=0  D
 . S TEMP=$G(^PSRX(DA,0))
 . S DFN=$P(TEMP,U,2)
 . I DFN="" Q
 . S DRUG=$P(TEMP,U,6)
 . I DRUG="" Q
 . S DSUP=$P(TEMP,U,8)
 . I DSUP="" Q
 . S RDATE=+$P($G(^PSRX(DA,2)),U,13)
 . I RDATE>0 S NE=NE+1
 .;Process the refill mutiple.
 . S DA1=0
 . F  S DA1=+$O(^PSRX(DA,1,DA1)) Q:DA1=0  D
 .. S TEMP=$G(^PSRX(DA,1,DA1,0))
 .. S DSUP=+$P(TEMP,U,10)
 .. S RDATE=+$P(TEMP,U,18)
 .. I RDATE>0 S NE=NE+1
 .;Process the partial fill multiple.
 . S DA1=0
 . F  S DA1=+$O(^PSRX(DA,"P",DA1)) Q:DA1=0  D
 .. S TEMP=$G(^PSRX(DA,"P",DA1,0))
 .. S DSUP=+$P(TEMP,U,10)
 .. S RDATE=+$P(TEMP,U,19)
 .. I RDATE>0 S NE=NE+1
 Q NE
 ;
 ;===============================================================
NEPTF() ;Return number of entries in PTF.
 N D1,DA,DATE,DFN,ICD0,ICD9,JND,NE0,NE9,TEMP70,TEMP0,TEMPP,TEMPS
 ;DBIA #4177
 S (DA,NE0,NE9)=0
 F  S DA=+$O(^DGPT(DA)) Q:DA=0  D
 . S TEMP0=$G(^DGPT(DA,0))
 . S DFN=$P(TEMP0,U,1)
 . I DFN="" Q
 . S D1=0
 . F  S D1=+$O(^DGPT(DA,"S",D1)) Q:D1=0  D
 .. S TEMPS=$G(^DGPT(DA,"S",D1,0))
 .. S DATE=$P(TEMPS,U,1)
 .. I DATE="" Q
 .. F JND=8,9,10,11,12 D
 ... S ICD0=$P(TEMPS,U,JND)
 ... I (ICD0'=""),$D(^ICD0(ICD0)) S NE0=NE0+1
 .;
 . S D1=0
 . F  S D1=+$O(^DGPT(DA,"P",D1)) Q:D1=0  D
 .. S TEMPP=$G(^DGPT(DA,"P",D1,0))
 .. S DATE=$P(TEMPP,U,1)
 .. I DATE="" Q
 .. F JND=5,6,7,8,9 D
 ... S ICD0=$P(TEMPP,U,JND)
 ... I (ICD0'=""),$D(^ICD0(ICD0)) S NE0=NE0+1
 .;
 .;Discharge ICD9 codes
 . I $D(^DGPT(DA,70)) D
 .. S TEMP70=$G(^DGPT(DA,70))
 .. F JND=10,11,16,17,18,19,20,21,22,23,24 D
 ... S ICD9=$P(TEMP70,U,JND)
 ... I (ICD9'=""),$D(^ICD9(ICD9)) S NE9=NE9+1
 .;
 .;Movement ICD9 codes
 . I '$D(^DGPT(DA,"M")) Q
 . S D1=0
 . F  S D1=$O(^DGPT(DA,"M",D1)) Q:+D1=0  D
 .. S TEMPS=$G(^DGPT(DA,"M",D1,0))
 .. S DATE=$P(TEMPS,U,10)
 .. I DATE="" Q
 .. F JND=5,6,7,8,9,11,12,13,14,15 D
 ... S ICD9=$P(TEMPS,U,JND)
 ... I (ICD9'=""),$D(^ICD9(ICD9)) S NE9=NE9+1
 Q NE0+NE9
 ;
 ;===============================================================
NERAD() ;Return number of entries in RAD/NUC MED PATIENT.
 N IEN,NE
 ;DBIA #4183
 S (IEN,NE)=0
 F  S IEN=$O(^RADPT(IEN)) Q:+IEN=0  S NE=NE+$P($G(^RADPT(IEN,"DT",0)),U,4)
 Q NE
 ;
 ;===============================================================
NEVCPT() ;Return number of entries in V CPT.
 ;DBIA #4176
 Q $P(^AUPNVCPT(0),U,4)
 ;
 ;===============================================================
NEVHF() ;Return number of entries in V HEALTH FACTORS.
 ;DBIA #4176
 Q $P(^AUPNVHF(0),U,4)
 ;
 ;===============================================================
NEVIMM() ;Return number of entries in V IMMUNIZATION
 ;DBIA #4176
 Q $P(^AUPNVIMM(0),U,4)
 ;
 ;===============================================================
NEVIT() ;Return number of entries in GMRV VITAL MEASUREMENT
 ;DBIA #4178
 Q $P(^GMR(120.5,0),U,4)
 ;
 ;===============================================================
NEVPED() ;Return number of entries in V PATIENT ED.
 ;DBIA #4176
 Q $P(^AUPNVPED(0),U,4)
 ;
 ;===============================================================
NEVPOV() ;Return number of entries in V POV.
 ;DBIA #4176
 Q $P(^AUPNVPOV(0),U,4)
 ;
 ;===============================================================
NEVSK() ;Return number of entries in V SKIN TEST.
 ;DBIA #4176
 Q $P(^AUPNVSK(0),U,4)
 ;
 ;===============================================================
NEVXAM() ;Return number of entries in V EXAM.
 ;DBIA #4176
 Q $P(^AUPNVXAM(0),U,4)
 ;
 ;===============================================================
NEYTD() ;Return number of entries in PSYCH INSTRUMENT PATIENT
 N DATE,DFN,NE,TEST
 ;DBIA #4184
 S (DFN,NE)=0
 F  S DFN=$O(^YTD(601.2,DFN)) Q:+DFN=0  D
 . S TEST=0
 . F  S TEST=$O(^YTD(601.2,DFN,1,TEST)) Q:+TEST=0  D
 .. S DATE=0
 .. F  S DATE=$O(^YTD(601.2,DFN,1,TEST,1,DATE)) Q:+DATE=0  S NE=NE+1
 Q NE
 ;
 ;===============================================================
SETDATA(GBL,GLIST,NUMGBL,RTN,SF) ;
 S NUMGBL=16
 S GLIST(1)="LABORATORY TEST (CH, Anatomic Path, Micro)",GBL(1)=63
 S GLIST(2)="MENTAL HEALTH",GBL(2)=601.2
 S GLIST(3)="ORDER",GBL(3)=100
 S GLIST(4)="PTF",GBL(4)=45
 S GLIST(5)="PHARMACY PATIENT",GBL(5)=55
 S GLIST(6)="PRESCRIPTION",GBL(6)=52
 S GLIST(7)="PROBLEM LIST",GBL(7)=9000011
 S GLIST(8)="RADIOLOGY",GBL(8)=70
 S GLIST(9)="V CPT",GBL(9)=9000010.18
 S GLIST(10)="V EXAM",GBL(10)=9000010.13
 S GLIST(11)="V HEALTH FACTORS",GBL(11)=9000010.23
 S GLIST(12)="V IMMUNIZATION",GBL(12)=9000010.11
 S GLIST(13)="V PATIENT ED",GBL(13)=9000010.16
 S GLIST(14)="V POV",GBL(14)=9000010.07
 S GLIST(15)="V SKIN TEST",GBL(15)=9000010.12
 S GLIST(16)="VITAL MEASUREMENT",GBL(16)=120.5
 S RTN(45)="NEPTF^PXRMISE"
 S RTN(52)="NEPSRX^PSO52CLR"
 S RTN(55)="NEPS^PSSCLINR"
 S RTN(63)="NELR^PXRMLABS"
 S RTN(70)="NERAD^PXRMISE"
 S RTN(100)="NEOR^PXRMISE"
 S RTN(120.5)="NEVIT^PXRMISE"
 S RTN(601.2)="NEYTD^PXRMISE"
 S RTN(9000011)="NEPROB^PXRMISE"
 S RTN(9000010.07)="NEVPOV^PXRMISE"
 S RTN(9000010.11)="NEVIMM^PXRMISE"
 S RTN(9000010.12)="NEVSK^PXRMISE"
 S RTN(9000010.13)="NEVXAM^PXRMISE"
 S RTN(9000010.16)="NEVPED^PXRMISE"
 S RTN(9000010.18)="NEVCPT^PXRMISE"
 S RTN(9000010.23)="NEVHF^PXRMISE"
 D LSF^PXRMISF(.SF)
 Q
 ;
