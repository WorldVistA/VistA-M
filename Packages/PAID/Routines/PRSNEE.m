PRSNEE ;WOIFO/PLT - Enter Nurse POC Data Entry ; 08/14/2009  7:56 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;
ENT ;option entry
 N A,X,Y
 N PRSNCR,PRSNG,PRSNDT,PPI,PRSNDAY,PRSNPP,PRSNEW,PRSNGLB,PRSNGA,PRSNGB,DFN,PRSNX
 ;prsncr="" if poc a/e, =1 if correct release, =eta if post employee time
 S PRSNCR=""
 D ACCESS^PRSNUT02(.A,"E",DT,"")
 I $P($G(A(0)),U,2)="E" D  Q
 .W !,$P(A(0),U,3)
 S PRSNG=A(0)_"^"_$O(A(0))_"^"_A($O(A(0))) K A
 S %DT="AEPX",%DT("A")="Enter POC Data for Date: ",%DT("B")="T-1" D ^%DT G:Y<1 EXIT
 S PRSNDT=Y,Y=$G(^PRST(458,"AD",Y)),PPI=$P(Y,"^",1),PRSNDAY=$P(Y,"^",2)
 I PPI="" D EN^DDIOL("Pay Period is Not Open Yet!") G EXIT
 ;entry from tag nurse for eta
PPADD ;
 N PRSNUR
 S PRSNPP=$P(^PRST(458,PPI,0),U)_U_$P(^(2),U,PRSNDAY)
 ;add new ppi entry in file 451
 I '$D(^PRSN(451,PPI)) K X,Y S X=$P(PRSNPP,U) D ADD^PRSU1B1(.X,.Y,"451",PPI) S:Y PRSNEW=1
 I '$D(^PRSN(451,PPI)) W !,"File - POC DAILY TIME RECORDS is in use, try it later!" G EXIT
 ;if from entry point nurse called from eta post employee time option
 I PRSNCR="ETA" D POST G EXIT
Q1 S Y(1)="Answer YES if you want all Nurses brought up for whom no data has been entered." D YN^PRSU1A(.X,.Y,"Would you like to enter the POC RECORDs in alphabetical order","","Yes")
 ;+prsng=1 - for alpha order, =0 for one nurse
 S $P(PRSNG,U)=Y G ONE:Y=0,EXIT:Y["^"
 ;for group of location or t&l
 S PRSNGLB=$S($P(PRSNG,U,2)="N":$NA(^NURSF(211.8,"D",$P(PRSNG,U,7))),1:$NA(^PRSPC("ATL"_$P(PRSNG,U,3))))
 S PRSNGA="",PRSNX=0
 F  S PRSNGA=$O(@PRSNGLB@(PRSNGA)) QUIT:PRSNGA=""  D  QUIT:PRSNX
 . S PRSNGB=0
 . F  S PRSNGB=$O(@PRSNGLB@(PRSNGA,PRSNGB)) QUIT:'PRSNGB  D  QUIT:PRSNX
 .. I $P(PRSNG,U,2)="N",+$P(PRSNG,U,4)'=+$$PRIMLOC^PRSNUT03(PRSNGB) Q
 .. S DFN=$S($P(PRSNG,U,2)="N":+$G(^VA(200,PRSNGB,450)),1:PRSNGB)
 .. D POST
 .. ;don't ask question if not a nurse.  That check needs to stay in the POST subroutine beause it is called from other parts of this program.
 .. Q:'PRSNUR
 .. N DIR,Y,DIRUT
 .. S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Continue to next Nurse"
 .. D ^DIR
 .. S PRSNX=$S(Y=1:0,1:1)
 . QUIT
 G EXIT
 ;
ONE ;selecting a nurse
 S Y=$$PICKNURS^PRSNUT03($P(PRSNG,U,2),$P(PRSNG,U,4)) G EXIT:Y<1
 S DFN=+Y D POST G ONE
 ;
EXIT QUIT
 ;
POST ;start poc posting
 N PRSNQ,PRSNLOC,PRSNLOC,PRSNPC,PRSNVER,PRSNQ,PRSNTD,PRSNTM
 S PRSNQ="",PRSNUR=$$ISNURSE^PRSNUT01(DFN) QUIT:'PRSNUR
 S $P(PRSNUR,U,5)=$$EXTERNAL^DILFD(451.1,3,,$P(PRSNUR,U,4),)
 S PRSNEW=+$G(PRSNEW),PRSNVER=1
 ;check pp status if not in alpha mode
 I $P($G(^PRSN(451,PPI,"E",DFN,0)),U,2)]"",$P(^(0),U,2)'="E" QUIT:PRSNG  S A=$P(^(0),U,2) D  QUIT
 . W !!,"The POC Record has a status - ",$S(A="A":"Approved, ask Coordinator to return the record for editing.",1:"Released, use the Correct Released Nurse POC Data option for correcting.")
 . QUIT
 S PRSNLOC=$$DFTLOC(PPI,DFN)
 ;quit if in alpha mode
 K PRSNPC I $D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER)) QUIT:PRSNG  D SMAN QUIT
 ;get default time segments array prsnpc of poc time segments from eta
 D ETAPOC^PRSNEE0
 ;quit if by group, no eta posted and tour is day off or intermittens
 I PRSNG,'PRSNPC,"1 3 4"[$P(PRSNPC,U,2) QUIT
 W:PRSNG !!,"Nurse: ",PRSNGA,"  (",$P(PRSNUR,U,5),")",?50,$P(PRSNLOC,U,3)
 ;
 ;quit if eta posted, poc with eta default but no tour/exceptions
ADD I PRSNPC,PRSNQ!$P(PRSNQ,U,3),$O(PRSNPC(""))="" QUIT
 ;add nurse in subfile# 451.09 of file #451 with pp-status e
 I '$D(^PRSN(451,PPI,"E",DFN)) K X,Y S X=DFN,X("DR")="1////E" D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_";9~451.09;^PRSN(451,PPI,""E"",",DFN) S:Y $P(PRSNEW,U,2)=1
 I '$D(^PRSN(451,PPI,"E",DFN)) W !,"Nurse POC file in use, try it later!" QUIT
 ;add day # in subfile #451.99 in subfile #451.09
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY)) K X,Y S X=PRSNDAY D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_"~451.09;;"_DFN_";9~451.99;^PRSN(451,PPI,""E"",DFN,""D"",",PRSNDAY) S:Y $P(PRSNEW,U,3)=1
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY)) W !,"Nurse POC file in use, try it later!" QUIT
 ;add version # in subfile #451.999 in subfile #451.99
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER)) K X,Y S X=PRSNVER D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_"~451.09;;"_DFN_";~451.99;;"_PRSNDAY_";9~451.999;^PRSN(451,PPI,""E"",DFN,""D"",PRSNDAY,""V"",",PRSNVER) S:Y $P(PRSNEW,U,4)=1
 I '$D(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER)) W !,"Nurse POC file in use, try it later!" QUIT
 D SMAN
 QUIT
 ;
 ;
SMAN ;start screenman
 N PRSNID,DDSFILE,DR,DA,DDSPAGE,DDSPARM,DDSCHANG,DDSSAVE,DIMSG,DTOUT,REASCD,REASTOP
 L +^PRSN(451,PPI,"E",DFN):0 E  W !!,"File is in use, Try it later!" D:$P(PRSNEW,U,4) EDVDEL QUIT
 S:PRSNCR=1 PRSNLOC=$$DFTLOC(PPI,DFN)
 ;add poc data prsnpc array time segemnts in file #451.9999 of file #451
 ;COMMENT OUT SKIPPING OF POC SCREEN, MAKE THEM LOOK AT IT AND PF1-E OUT
 I $O(PRSNPC(""))]"",PRSNLOC D ADDTS^PRSNEE0
 ;prsnid = 1^ name ^2 staion # ^3 t&l ^4 ss# ^5 defaul location ^6 poc status
 S PRSNID=$P(^PRSPC(DFN,0),U),$P(PRSNID,U,2,4)=$P(^PRSPC(DFN,0),U,7,9),$P(PRSNID,U,5)=$P(PRSNLOC,U,3)
 S $P(PRSNID,U,6)=$S('PRSNCR:$P(^PRSN(451,PPI,"E",DFN,0),U,2),1:$P(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,0),U,2))
 S $P(PRSNID,U,6)=$S($P(PRSNID,U,6)="E":"Entered",1:"New")
 ;get displaying tour of duty of the day and the 1 or 2 day tour data
 S PRSNTD=$$TOUR(PPI,DFN,PRSNDAY),PRSNTM=$$PSTOUR^PRSNEE0(PPI,DFN,PRSNDAY)
 S DA=PRSNVER,DA(1)=PRSNDAY,DA(2)=DFN,DA(3)=PPI
 S DDSFILE(1)=451.999,DDSFILE(2)=451.99,DDSFILE(3)=451.09,DDSFILE=451,DDSPAGE=1
 S REASCD="",REASTOP=0
 S DR="[PRSN DAILY TIME RECORDS A/E/D]",DDSPARM="CS" D ^DDS
 ;save and change post action after dds call
EDVDEL ;if no save and no change, delete new added entries before dds call
 ;delete e,d, v multiple field records
 I $P(PRSNEW,U,4),'$G(DDSSAVE),'$G(DDSCHANG) D
 . N PRSNA
 . S PRSNA="451;;"_PPI_";9~451.09;^PRSN(451,PPI,""E"",;"_DFN
 . I $P(PRSNEW,U,2) K X D DELETE^PRSU1B1(.X,PRSNA) QUIT
 . S $P(PRSNA,"~",3)="451.99;^PRSN(451,PPI,""E"",DFN,""D"",;"_PRSNDAY
 . I $P(PRSNEW,U,3) K X D DELETE^PRSU1B1(.X,PRSNA) QUIT
 . S $P(PRSNA,"~",4)="451.999;^PRSN(451,PPI,""E"",DFN,""D"",PRSNDAY,""V"",;"_PRSNVER
 . I $P(PRSNEW,U,4) K X D DELETE^PRSU1B1(.X,PRSNA)
 . QUIT
 ;changed
 I $G(DDSCHANG)=1 D
 . QUIT
 ;saved
 I $G(DDSSAVE)=1 D
 . ;add correction released status 'e' in day # multiple
 . I PRSNCR,$P(PRSNEW,U,4) D EDIT^PRSU1B(.X,"451;;"_PPI_"~451.09;;"_DFN_";9~451.99;^PRSN(451,PPI,""E"",DFN,""D"",;"_PRSNDAY,"1////E","")
 . QUIT
SMANEXT L -^PRSN(451,PPI,"E",DFN)
 QUIT
 ;
REASON(CD,STOP) ;
 N CDIEN,DESC,VAL,SEQ,I
 S VAL=""
 I STOP Q VAL
 S CD=$O(^PRSN(451.6,"B",CD))
 I CD="" S STOP=1 Q VAL
 S CDIEN=$O(^PRSN(451.6,"B",CD,""))
 S DESC=$P($G(^PRSN(451.6,CDIEN,0)),U,2)
 S VAL=CD_" - "_DESC
 Q VAL
 ;
WORKTYPH ;
 N CDIEN,DESC,VAL,SEQ,I,COL
 S CD="",SEQ=0
 F I=0:1 S CD=$O(^PRSN(451.5,"B",CD)) Q:CD=""  D
 .S CDIEN=$O(^PRSN(451.5,"B",CD,""))
 .S DESC=$P($G(^PRSN(451.5,CDIEN,0)),U,2)
 .S COL=I#3
 .I COL=0 S SEQ=SEQ+1
 .S VAL(SEQ)=$G(VAL(SEQ))
 .S VAL(SEQ)=VAL(SEQ)_$J("",27*COL-$L(VAL(SEQ)))_CD_" - "_DESC
 D HLP^DDSUTL(.VAL)
 Q
 ;
TOUR(PPI,DFN,DAY) ;ef - tour of duty of the nurse
 N Y1,Y2,Y3,Y31,Y4,TC,L1,A1,L3,PRSNTD
 S PRSNTD="" D F1^PRSADP1
 QUIT Y31
 ;
 ;return ^1 = "", ^2=ien of file #44, ^3=hospital location name
DFTLOC(PPI,DFN) ;ef - nurse default location of the ppi
 N A
 S A=$P($G(^PRSN(451,PPI,"E",DFN,0)),U,6)
 QUIT:A +A_"^^"_$S(A:$P($G(^SC(+$G(^NURSF(211.4,+A,0)),0)),U),1:"")
 QUIT $$PRIMLOC^PRSNUT03(+$G(^PRSPC(DFN,200)))
 ;
 ;ppi=ien of file #458, dfn=ien of file #450, prsnday=day #, prsndt=fileman date of day #
NURSE(PPI,DFN,PRSNDAY,PRSNDT) ;entry point from eta post employee time option
 N PRSNCR,PRSNG,PRSNPP,PRSNEW,PRNGLB,PRSNGA,PRSNGB,PRSNX
 S PRSNCR="ETA",PRSNG=0 G PPADD
 ;
 ;the following line is for testing by d nurse+3*******************
 S PRSNCR="",PRSNEW="",PRSNG=0,PPI=347,DFN=14308,PRSNDAY=3,PRSNVER=2
 S PRSNLOC=$$DFTLOC(PPI,DFN),PRSNPP=$P(^PRST(458,PPI,0),U)_U_$P(^(2),U,PRSNDAY) G SMAN
 ;
