PRSNCGR1 ;WOIFO-JAH - Release POC Records for VANOD Extraction;10/16/09
 ;;4.0;PAID;**126,146**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified.
 Q
 ;
FILEPP(PC,PRSIEN,PPI,INST,STATN) ; file pay per activity records for Nurse to extraction AND update extraction version number in 451
 ;
 N PRSD,I,PRSFDA,PCDATA,X,X1,OTR,LOC,LOCDIV
 S PRSD=0
 F  S PRSD=$O(PC(PRSD)) Q:PRSD'>0!(PRSD>14)  D
 .;
 .;  increment version number for this day's extraction
 .   D EXTVERS(.VNUM,PPI,PRSIEN,PRSD)
 .;
 .  S I=0
 .  F  S I=$O(PC(PRSD,I)) Q:I'>0  D
 ..   S PCDATA=PC(PRSD,I)
 ..   K PRSFDA,IEN
 ..   S LOC=$P(PCDATA,U,5)
 ..   S LOCDIV=$S(LOC="":"",1:$P($$ISACTIVE^PRSNUT01("",LOC),U,4))
 ..   S PRSFDA(451.7,"+1,",.01)=$P($G(^PRSN(451.7,0)),U,3)+1
 ..   S PRSFDA(451.7,"+1,",1)=$G(INST)
 ..   S PRSFDA(451.7,"+1,",2)=LOCDIV
 ..   S PRSFDA(451.7,"+1,",3)=VNUM
 ..   S PRSFDA(451.7,"+1,",4)=$P($G(^PRSPC(PRSIEN,0)),U,9)
 ..   S PRSFDA(451.7,"+1,",5)=+PRSIEN
 ..   S X=$P($G(^PRST(458,PPI,1)),U,PRSD)
 ..   S X1=$E(X,1,3)+1700_$E(X,4,7)
 ..   S PRSFDA(451.7,"+1,",6)=X1
 ..   S PRSFDA(451.7,"+1,",7)=$P(PCDATA,U,9) ;           Start time
 ..   S PRSFDA(451.7,"+1,",8)=$P(PCDATA,U,10) ;          Stop time
 ..   S PRSFDA(451.7,"+1,",9)=$P(PCDATA,U,4) ;         POC type of time
 ..   S PRSFDA(451.7,"+1,",10)=LOC ;        Point of care
 ..   S PRSFDA(451.7,"+1,",11)=$P(PCDATA,U,7) ;        mand. ot?
 ..;
 ..   S OTR=$P(PCDATA,U,8)
 ..   I OTR>0 S OTR=$P($G(^PRSN(451.6,OTR,0)),U) ;   OT reason
 ..   S PRSFDA(451.7,"+1,",12)=OTR
 ..;                                                 451.5 type of wrk
 ..   S PRSFDA(451.7,"+1,",13)=$P($G(^PRSN(451.5,+$P(PCDATA,U,6),0)),U)
 ..   S PRSFDA(451.7,"+1,",14)=DT ;                    release date
 ..   S PRSFDA(451.7,"+1,",15)=$P(^PRSN(451,PPI,"E",PRSIEN,0),U,7) ; T&L WHEN APPROVED
 ..   D UPDATE^DIE("","PRSFDA","IEN"),MSG^DIALOG()
 Q
 ;
EXTVERS(VNUM,PPI,PRSIEN,PRSD) ; update extraction version in POC records file
 ;
 ;  RETURN: VNUM-the version number of the extraction for the 
 ;               day (PRSD = 1-14) of the pay period.
 ;
 ; increment Extraction Version number.  If no data on node then
 ; we are dealing with the initial extraction for 2nd day of a 
 ; two day tour, so add a node and set version to 1. Subsequent
 ; releases to day will then have the correct version number.
 ;
 K FDA,IENS
 ;
 I $D(^PRSN(451,PPI,"E",PRSIEN,"D",PRSD,0)) D
 .  S IENS=PRSD_","_PRSIEN_","_PPI_","
 .  S VNUM=1+$P($G(^PRSN(451,PPI,"E",PRSIEN,"D",PRSD,0)),U,3)
 E  D
 .  S IENS="+1,"_PRSIEN_","_PPI_","
 .  S IENS(1)=PRSD
 .  S VNUM=1
 .  S FDA(451.99,IENS,.01)=PRSD
 S FDA(451.99,IENS,2)=VNUM
 ;
 D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 Q
 ;
UPDTPOC(PPI,PRSIEN,STATUS,RETURN) ; update pay period status for nurse POC records
 ; INPUT:
 ;   PPI, PRSIEN: Standard
 ;   STATUS: POC pay period status (E)ntered, (A)pproved, (R)eleased
 ;   RETURN: (optional) flag set to true to indicate the pay period
 ;                      is being returned
 N IENS,PRSFDA,PRIMLOC
 S IENS=PRSIEN_","_PPI_","
 S PRSFDA(451.09,IENS,1)=STATUS
 I STATUS="A" D
 .  S PRIMLOC=+$$PRIMLOC^PRSNUT03(+$G(^PRSPC(PRSIEN,200)))
 .  S PRSFDA(451.09,IENS,4)=$P($$DIV^PRSNUT03("N",+PRIMLOC),U,3)
 .  S PRSFDA(451.09,IENS,2)=DUZ
 .  N %,X,%I,%H D NOW^%DTC
 .  S PRSFDA(451.09,IENS,3)=%
 .  S PRSFDA(451.09,IENS,5)=PRIMLOC
 .  ;PRS*4.0*146 SETS the PRSFDA node below to the internal value of the T&L UNIT code
 .  N TLE S TLE=$P($G(^PRSPC(PRSIEN,0)),U,8)
 .  I TLE'="" S PRSFDA(451.09,IENS,6)=$O(^PRST(455.5,"B",TLE,""))
 I STATUS="E"&$G(RETURN) D 
 .  S PRSFDA(451.09,IENS,4)="@"
 .  S PRSFDA(451.09,IENS,2)="@"
 .  S PRSFDA(451.09,IENS,3)="@"
 .  S PRSFDA(451.09,IENS,5)="@"
 .  S PRSFDA(451.09,IENS,6)="@"
 D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 Q
UPDTPP(PPI,CI,NRSCNT,RECNT) ; update division release history for pay period
 N IENS,PRSFDA
 S IENS="+1,"_PPI_","
 S PRSFDA(451.06,IENS,.01)=CI
 S PRSFDA(451.06,IENS,1)=DUZ
 N %,X,%I,%H D NOW^%DTC
 S PRSFDA(451.06,IENS,2)=%
 S PRSFDA(451.06,IENS,3)=NRSCNT
 S PRSFDA(451.06,IENS,4)=RECNT
 D UPDATE^DIE("","PRSFDA","IENS"),MSG^DIALOG()
 Q
 ;
CNTREP(PRSINST,PPI) ;  Report on the record status for each division
 ;
 ;  INPUT: PRSINST- array of instituions
 ;
 N REC,PRECNT,FIELD,PC,DIV,CI,PRSIEN,PRIM,SN
 S REC=0
 F  S REC=$O(PRSINST(REC)) Q:REC'>0  D
 .  S CI=+PRSINST(REC)
 .  D GETS^DIQ(4,CI_",","99","E","FIELD(",,)
 .  S SN=FIELD(4,CI_",",99,"E")
 .  S PRECNT(CI)="0^0^0"
 .;
 .; count up entered records
 .;
 .  S PRSIEN=0
 .  F  S PRSIEN=$O(^PRSN(451,"AE",PRSIEN)) Q:PRSIEN'>0  D
 ..    S PRIM=$$PRIMLOC^PRSNUT03(+$G(^PRSPC(PRSIEN,200)))
 ..    S DIV=$P($$ISACTIVE^PRSNUT01(DT,+PRIM),U,4)
 ..    I (DIV=CI),($D(^PRSN(451,"AE",PRSIEN,PPI))) D
 ...       S $P(PRECNT(CI),U)=$P(PRECNT(CI),U)+1
 .;
 .; count up approved records
 .;
 .  S PRSIEN=0
 .  F  S PRSIEN=$O(^PRSN(451,"AA",CI,PPI,PRSIEN)) Q:PRSIEN'>0  D
 ..    S $P(PRECNT(CI),U,2)=$P(PRECNT(CI),U,2)+1
 .;
 .; count up released records
 .;
 .  S PRSIEN=0
 .  F  S PRSIEN=$O(^PRSN(451,"AR",CI,PPI,PRSIEN)) Q:PRSIEN'>0  D
 ..    S $P(PRECNT(CI),U,3)=$P(PRECNT(CI),U,3)+1
 ;
 ; Display counts for the division
 ;
 W @IOF,!!!,?14,"Pay Period ",$P($G(^PRST(458,PPI,0)),U)," Statistics"
 N DIVI,DIVE,I,F,X
 W !,?14,"==============================="
 W !!,?26,"NURSES POINT OF CARE PAY PERIOD RECORD STATUS"
 W !,?4,"DIVISION",?41,"UNAPPROVED",?54,"APPROVED",?66,"RELEASED"
 W !,?4,"========",?41,"==========",?54,"========",?66,"========"
 N I,STNUM,STNAME S I=0
 F  S I=$O(PRECNT(I)) Q:I'>0  D
 .  D GETS^DIQ(4,I_",",".01;99","EI","F(",,)
 .  S STNUM=F(4,I_",",99,"E"),STNAME=F(4,I_",",.01,"E")
 .  W !,?4,STNAME," (",STNUM,")"
 .  W ?42,$J($P(PRECNT(I),U),8)
 .  W ?54,$J($P(PRECNT(I),U,2),8)
 .  W ?66,$J($P(PRECNT(I),U,3),8)
 Q
