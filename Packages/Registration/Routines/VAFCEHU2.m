VAFCEHU2 ;ALB/JLU,LTL-UTILITIES FOR 391.98 AND 391.99 AND LIST MAN ;10/10/02  15:55
 ;;5.3;Registration;**149,255,333,474,477,620**;Aug 13, 1993
SORTS(SRT,ARY) ;
 ;this tag will sort the exceptions in different formats depending on
 ;what the user has selected.
 ;
 ;INPUTS - SRT this variable contains what sort is requested from the
 ;list man patient review screen.
 ; Ex.  SP  sort by patient
 ;      SS  sort by site
 ;      SO  sort by oldest event
 ;      SN  sort by newest event
 ;ARY - the array the calling program wants the info returned in.
 ;
 ;OUTPUT
 ;a populated array that was passed in by the user.  The array is in
 ;the structure xxx(#,0)=value
 ;
 S VAR=SRT_"(ARY)"
 D @VAR
 Q
 ;
SP(ARY) ;sort by patient
 N LP,LP1,CTR
 S LP=""
 S CTR=1
 F  S LP=$O(^DGCN(391.98,"C",LP)) Q:LP=""  F LP1=0:0 S LP1=$O(^DGCN(391.98,"C",LP,LP1)) Q:LP1=""  D BLD(LP1,ARY,.CTR)
 Q
 ;
SS(ARY) ;sort by site
 N LP,LP1,CTR
 S LP=""
 S CTR=1
 F  S LP=$O(^DGCN(391.98,"FRM",LP)) Q:LP=""  F LP1=0:0 S LP1=$O(^DGCN(391.98,"FRM",LP,LP1)) Q:LP1=""  D BLD(LP1,ARY,.CTR)
 Q
 ;
SO(ARY) ;sort by oldest event
 N LP,LP1,CTR
 S LP=""
 S CTR=1
 F  S LP=$O(^DGCN(391.98,"EVT",LP)) Q:LP=""  F LP1=0:0 S LP1=$O(^DGCN(391.98,"EVT",LP,LP1)) Q:LP1=""  D BLD(LP1,ARY,.CTR)
 Q
 ;
SN(ARY) ;sort by newest event
 N LP,LP1,CTR
 S LP=999999999999
 S CTR=1
 F  S LP=$O(^DGCN(391.98,"EVT",LP),-1) Q:LP=""  F LP1=999999999999:0 S LP1=$O(^DGCN(391.98,"EVT",LP,LP1),-1) Q:LP1=""  D BLD(LP1,ARY,.CTR)
 Q
 ;
BLD(LP1,ARY,CTR) ;this is the actual building subroutine.  the array that is
 ;return is var(#,0)=value starting at 1.
 ;
 N DATA,STAT,PAT,XX
 ;getting the exception
 S DATA=$G(^DGCN(391.98,LP1,0))
 Q:DATA']""
 ;checking for the status
 ;Q:$P(DATA,U,4)']"" ;**333
 I $P(DATA,U,4)']"" S XX=$$EDIT^VAFCEHU1(LP1,"RETIRED DATA") Q  ;**333 retire
 ;getting the status node from 391.984
 S STAT=$G(^DGCN(391.984,$P(DATA,U,4),0))
 ;if retired skip
 I "RETIRED DATA"=$P(STAT,U,1) Q
 ;if rejected skip
 I "DATA REJECTED"=$P(STAT,U,1) Q
 ;if merge complete
 I "MERGE COMPLETE"=$P(STAT,U,1) Q
 ;get patient file zero node
 S PAT=$G(^DPT($P(DATA,U,1),0))
 ;Q:PAT']"" ;**333
 I $S(PAT']"":1,$$IFLOCAL^MPIF001(+$P(DATA,U,1)):1,$$IFVCCI^MPIF001(+$P(DATA,U,1))=-1:1,1:0) S XX=$$EDIT^VAFCEHU1(LP1,"RETIRED DATA") Q  ;**333 retire if a local, you're not the cmor or no cmor
 S @ARY@(CTR,0)=$P(PAT,U,1)_U_$P(PAT,U,9)_U_$P(PAT,U,3)_U_$P(STAT,U,2)_U_$P(DATA,U,3)_U_$G(^DGCN(391.98,LP1,"FRM"))
 S @ARY@(CTR,"VAFC")=LP1
 S CTR=CTR+1
 Q
 ;
FORMAT(ARY,VALMCNT,VALMQUIT) ;this subroutines formats the array in ARY
 ;from file 391.98 for display by the list manager.  It accepts the
 ;array name as its input in ARY.
 ;VALMCNT and VALMQUIT are passed by reference
 ;VALMCNT will be the total number of entries
 ;VALMQUIT tells list man to quit if something when wrong.
 ;
 N CTR,STR,LP
 S CTR=1
 F LP=0:0 S LP=$O(@ARY@(LP)) Q:'LP  S STR=$G(@ARY@(LP,0)) I STR]"" DO
 .N X,DATE
 .S X=$$SETSTR^VALM1(CTR,"",1,4)
 .S X=$$SETSTR^VALM1($E($P(STR,U,1),1,23),X,5,23)
 .S X=$$SETSTR^VALM1($P(STR,U,2),X,29,9)
 .S DATE=$$IN2EXDT^VAFCMGU0($P(STR,U,3))
 .S X=$$SETSTR^VALM1(DATE,X,40,10)
 .S X=$$SETSTR^VALM1($P(STR,U,4),X,51,2)
 .S DATE=$$IN2EXDT^VAFCMGU0($P(STR,U,5))
 .S X=$$SETSTR^VALM1(DATE,X,55,10)
 .S X=$$SETSTR^VALM1($P(STR,U,6),X,67,$L($P(STR,U,6)))
 .S @ARY@(LP,0)=X
 .S @ARY@("IDX",CTR,CTR)=""
 .S CTR=CTR+1
 .Q
 S VALMCNT=CTR-1
 I CTR=1 DO
 .S @ARY@(1,0)=""
 .S @ARY@(2,0)="There are no exceptions on file to review."
 .S VALMCNT=2
 .Q
 Q
 ;
FRMDATA(IEN,ARY) ;
 ;This entry point will return all the data related to a given exception
 ;INPUTS
 ;  IEN - The IEN of the exception to be extracted.
 ;  ARY - The array that the user wishes the information returned in.
 ;        This array can be either local or global.
 ;  Ex.   ^TMP("TEST",$J)
 ;        If and array is not passed then a default global array will
 ;        be used.  ^TMP($J,"VAFC-MRG","DATA")
 ;OUTPUTS
 ;  1 if the look up and retreival were successful
 ;  0^description if they were not.
 ;
 N ERR,LP,DATA
 I '$D(IEN) S ERR="0^Parameter not defined." G FRMQ
 I IEN']"" S ERR="0^Exception not defined." G FRMQ
 I '$D(^DGCN(391.98,IEN,0)) S ERR="0^Exception not in file." G FRMQ
 I '$D(^DGCN(391.99,"B",IEN)) S ERR="0^Data for exception not defined." G FRMQ
 I '$D(ARY) S ARY="^TMP($J,""VAFC-MRG"",""DATA"")"
 I ARY']"" S ARY="^TMP($J,""VAFC-MRG"",""DATA"")"
 S LP=""
 F  S LP=$O(^DGCN(391.99,"B",IEN,LP)) Q:'LP  DO
 . S DATA=$G(^DGCN(391.99,LP,0))
 . Q:'DATA
 . I $P(DATA,U,2)=""!($P(DATA,U,3)="") Q  ;**477
 . I $S($P(DATA,U,3)=.211:1,$P(DATA,U,3)=.2403:1,1:0) D  ;**477 standardize mmn and nok for old pdr entries
 . . N DGNAME S DGNAME=$G(^DGCN(391.99,LP,"VAL")) I $S(DGNAME="":0,DGNAME["@":0,1:1) D
 . . . I $P(DATA,U,3)=.211 D STDNAME^XLFNAME(.DGNAME,"P") S DGNAME=$$FORMAT^XLFNAME7(.DGNAME,3,35) I DGNAME="" Q
 . . . I $P(DATA,U,3)=.2403 D STDNAME^XLFNAME(.DGNAME,"P") S DGNAME=$$FORMAT^XLFNAME7(.DGNAME,3,35,,2,,1) I DGNAME="" Q
 . . . D UPD(LP,50,DGNAME)
 . I $P(DATA,U,3)=.05,($G(^DGCN(391.99,LP,"VAL"))="N") D UPD(LP,50,"NEVER MARRIED"),UPD(LP,.06,"@") S $P(DATA,"^",6)="" ;**477 translate marital status from 'n' to 'never married' and remove unresolved flag
 . ;
 . S @ARY@($P(DATA,U,2),$P(DATA,U,3))=$G(^DGCN(391.99,LP,"VAL"))_U_$P(DATA,U,5)_U_$P(DATA,U,6)
 . Q
 I $D(@ARY)>9 S ERR=1
 E  S ERR="0^No elments found."
 ;
FRMQ Q ERR
 ;
REVFUL ;this entry point is to process the user selection from the summary
 ;screen of the exception handler.
 ;the variable VALMAR is expected.  This contains the array that is
 ;being used as part of list manager
 ;
 ;variable collision during VAFCMG01 processing, changed ien to ienpdr ;**477
 ;
 S VALM("ENTITY")="Patient"
 D EN^VALM2(XQORNOD(0))
 I '$D(VALMY) G FULQ
 N LP,RES
 F LP=0:0 S LP=$O(VALMY(LP)) Q:'LP  DO  Q:RES<-9
 .N IENPDR,LCK,MSG,EXCPT,FRM,STR,STAT,EDT,ARY
 .S RES=0
 .S IENPDR=$O(@VALMAR@("IDX",LP,0))
 .Q:'IENPDR
 .S IENPDR=$G(@VALMAR@(IENPDR,"VAFC"))
 .Q:'IENPDR
 .S LCK=$$LOCK^VAFCEHU1(IENPDR)
 .I 'LCK DO  Q
 ..N PAT
 ..S PAT=$E(@VALMAR@(LP,0),4,27)
 ..D FULL^VALM1
 ..W $C(7)
 ..W !!,"The status for ",PAT," is ",$P(LCK,U,2)
 ..W !,"Review or merging of this data is not allowed at this time."
 ..D PAUSE^VALM1
 ..Q
 .S EXCPT=$G(^DGCN(391.98,IENPDR,0))
 .S FRM=$G(^DGCN(391.98,IENPDR,"FRM"))
 .I 'EXCPT!(FRM']"") Q
 .S ARY="^TMP($J,""VAFC-MRG"",""DATA"")"
 .S STR=$$FRMDATA(IENPDR,ARY)
 .Q:'STR
 .S RES=$$EN^VAFCMG01($P(EXCPT,U,1),ARY,FRM,$P(EXCPT,U,3))
 .S STAT=$S(RES>11:"DR",RES>9:"MC",RES<2:"DE",1:"AR")
 .S EDT=$$EDIT^VAFCEHU1(IENPDR,STAT)
 .I RES=10!(RES=11) D WHO(IENPDR,DUZ,"NOW")
 .L -^DGCN(391.98,IENPDR) ;**255
 .Q
 D INIT2^VAFCEHLM
 ;
FULQ Q
 ;
WHO(IEN,WHO,WHEN) ;this entry point updates the exceptions as to who
 ;made this update and when.
 ;
 S DIE="^DGCN(391.98,"
 S DA=IEN
 S DR="12////"_DUZ_";11///"_WHEN
 D ^DIE
 Q
 ;
RETPDR(DFN,STAIEN) ;retire site's PDRs 'awaiting review' for patient ;**474
 ;INPUT    DFN - ien of the patient
 ;      STAIEN - ien of the institution
 ;
 N DAT,IEN,NAM,PDRIEN,STANAM,VAFCINST
 I 'DFN!'STAIEN Q
 D GETS^DIQ(4,STAIEN_",",".01;999.1*",,"VAFCINST") ;retrieve current name and name history
 S NAM=$G(VAFCINST(4,STAIEN_",",.01)) I NAM'="" S STANAM(NAM)="" ;get current name
 S IEN="" F  S IEN=$O(VAFCINST(4.999,IEN)) Q:IEN=""  S NAM=$G(VAFCINST(4.999,IEN,.02)) I NAM'="" S STANAM(NAM)="" ;get name history in case site name change
 S NAM="" F  S NAM=$O(STANAM(NAM)) Q:NAM=""  D  ;loop through array of names
 . S DAT=0 F  S DAT=$O(^DGCN(391.98,"AKY",DFN,NAM,DAT)) Q:DAT=""  D  ;loop through site's pdrs for patient
 . . S PDRIEN="" F  S PDRIEN=$O(^DGCN(391.98,"AKY",DFN,NAM,DAT,PDRIEN)) Q:'PDRIEN  I $P($G(^DGCN(391.98,PDRIEN,0)),"^",4)=1 S XX=$$EDIT^VAFCEHU1(PDRIEN,"RETIRED DATA") ;retire pdr's awaiting review
 Q
 ;
UPD(DA,FLD,VAL) ;update value ;**477
 L +^DGCN(391.99,DA,0):10
 S DIE="^DGCN(391.99,"
 S DR=FLD_"///^S X=VAL"
 D ^DIE K DIE,DR
 L -^DGCN(391.99,DA,0)
 Q
