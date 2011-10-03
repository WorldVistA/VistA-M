RMPOLZB ;EDS/PAK - HOME OXYGEN LETTERS ;7/24/98
 ;;3.0;PROSTHETICS;**29,55,159**;Feb 09, 1996;Build 2
 ;
 ; ODJ - patch 55 - 1/29/01 - remove hard code 121 mail code and
 ;                            replace with extrinsic (AUG-1097-32118)
 ;
 ; Input:
 ;
 ;   JOB                  -  0: interactive, 1: job
 ;   RMPOLCD              -  Letter type code
 ;
 ; Output: None
 ;
 ; Called by:
 ;   EN03^RMPOLT,EN02^RMPOLY
 N REC,POS
 ; if interactive select device
 I 'JOB D FULL^VALM1 Q:'$$DEV
 ; if print queued
 I $D(IO("Q")) D  Q:'$$QUEUE^RMPOLET1(ZTDESC,ZTRTN,.ZTSAVE)  D HOME^%ZIS,EXIT Q
 . K ZTSAVE
 . S ZTDESC="RMPO : Patient Letter Print",ZTRTN="START^RMPOLZB"
 . S (ZTSAVE("RMPOXITE"),ZTSAVE("JOB"),ZTSAVE("RMPOLCD"),ZTSAVE("RMPOSITE"),ZTSAVE("RMPO("),ZTSAVE("^TMP($J,RMPOXITE,"))=""
 W !,"Printing...."
 ;
START ; Print H.O. correspondence for selected letter type
 N DATE U IO
 S Y=DT X ^DD("DD") S DATE=Y
 D HDRL  ; initialise header lines
 S RMPONAM="" F  S RMPONAM=$O(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)) Q:RMPONAM=""  D
 . S RMPOLTR=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,1)
 . S RMPODFN=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,2)
 . S REC=^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN) D BODY
 D EXIT Q
 ;
ONE ;print a single patient
 ;I 'JOB D FULL^VALM1 Q:'$$DEV
 ;D COMMON("PIKSOM") D ^%ZISC D CLEAN^VALM10,INIT^RMPOLT,RE^VALM4 K DIR,RTN
 D PIKSOM Q:$$QUIT  I Y="" S VALMBCK="R" Q
 S LFNS=Y I 'JOB D FULL^VALM1 Q:'$$DEV
 I $D(IO("Q")) D  D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 2 D HOME^%ZIS,EXIT Q
 . K ZTSAVE
 . S ZTDESC="RMPO : Patient Letter Print",ZTRTN="QUED^RMPOLZB"
 . S (ZTSAVE("RMPOXITE"),ZTSAVE("JOB"),ZTSAVE("RMPOLCD"))=""
 . S ZTSAVE("RMPOSITE")="",ZTSAVE("RMPO(")="",ZTSAVE("^TMP($J,RMPOXITE,")="",ZTSAVE("IO")="",ZTSAVE("LFNS")=""
 W !!,"Printing...."
 ;
QUED N DATE S Y=DT X ^DD("DD") S DATE=Y D HDRL
 U IO F ZI=1:1:$L(LFNS,",")-1 D
 . S LFN=$P(LFNS,",",ZI) Q:LFN'>0
 . S RMPONAM="",CNT=0 F  S RMPONAM=$O(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)) Q:RMPONAM=""  D
 .. S RMPOLTR=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,1)
 .. S RMPODFN=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,2)
 .. S CNT=CNT+1
 .. S:CNT=LFN ^TMP($J,RMPOXITE,"LTR",RMPONAM)=RMPODFN
 S RMPONAM="" F  S RMPONAM=$O(^TMP($J,RMPOXITE,"LTR",RMPONAM)) Q:RMPONAM=""  D SINGLE
 K LFNS,LFN,ZI,RTN,DIR,RMLET
 D ^%ZISC D CLEAN^VALM10,INIT^RMPOLT,RE^VALM4
 S VALMBCK="R" D EXIT Q
 ;
SINGLE S RMPOLTR=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,1)
 S RMPODFN=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,2)
 S REC=^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN)
 D BODY Q
BODY ; Set up array for filing and print letter
 N I,LN,LNCT,SP,HDR,X,Y,NAME,SURNM,FRSTNM
 S $P(SP," ",80)=" ",LNCT=0
 ;
 ; Print text or blank lines in header
 S HDR=^TMP($J,RMPOXITE,"HEADER",RMPOLTR)
 I 'HDR F I=1:1:9 D LINE("")
 I HDR D PHDR
 ;
 D LINE(DATE),LINE("")
 S NAME=$P(REC,U),SURNM=$P(NAME,",",2),FRSTNM=$P(NAME,",")
 S LN=$E(FRSTNM_" "_SURNM_SP,1,40)_"In Reply Refer To: "_RMPO("NAME")_"/"_$$ROU^RMPRUTIL(RMPOXITE)
 D LINE(LN)
 S LN=$P(REC,U,10),LN=$E(LN_SP,1,40)
 D LINE(LN)
 S LN=$P(REC,U,11) I LN]"" S LN=$E(LN_SP,1,40) D LINE(LN)
 I $P(REC,U,12)]"" D LINE($P(REC,U,12))
 ;
 ; City, State, Zip
 D LINE($P(REC,U,13)_", "_$P(REC,U,14)_"  "_$P(REC,U,15))
 ;I $P(REC,U,11)="",$P(REC,U,12)="" D LINE($E(SP,1,40)_$P(RMPODFN,U))
 S RMPORX=$P(REC,U,6) S:RMPORX="" RMPORX="Not on file"
 D LINE($E(SP,1,40)_FRSTNM_" "_SURNM)
 D LINE($E(SP,1,40)_"Current Home Oxygen Rx#: "_RMPORX)
 S LN=$E(SP,1,40)_"Rx Expiration Date: "
 S RMPORXDT=$P(REC,U,4)
 I RMPORXDT="" S RMPORXDT="n/a"
 E  S Y=RMPORXDT X ^DD("DD") S RMPORXDT=Y
 D LINE(LN_RMPORXDT),LINE("")
 D LINE("Dear "_$S($P(REC,U,9)="F":"Ms. ",1:"Mr. ")_SURNM_":")
 D LINE(""),LINE("")
 ;
 ; print letter template
 S I=0 F  S I=$O(^RMPR(665.2,RMPOLTR,1,I)) Q:'I  D LINE(^(I,0))
 ;
 ; Update Correspondence Tracking
 ; DO NOT remove patient from list is correspondence update unsuccessful.
 S X=$$FILE^RMPOLZU(RMPODFN,"^TMP("_$J_","_RMPOXITE_",""LINE"")",RMPOLTR)
 I +X D  Q  ; quit if error
 . W !!!,"<<< Error"_+X_":"_$P(X,";",2)_" Patient #"_RMPODFN_" ! >>>",*7
 D UPDLTR^RMPOLZA(RMPODFN,"@")  ; Clear "letter to be sent" field in RMPR(665
 ;
 K ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)
 K ^TMP($J,RMPOXITE,"LINE")
 K ^TMP($J,RMPOXITE,RMPODFN)
 I RMPOLCD="A" S $P(^RMPR(665,RMPODFN,"RMPOA"),U,9)=DT,$P(^("RMPOA"),U,10)="P"
 I RMPOLCD="B" S $P(^RMPR(665,RMPODFN,"RMPOA"),U,11)=DT,$P(^("RMPOA"),U,12)="P"
 I RMPOLCD="C" S $P(^RMPR(665,RMPODFN,"RMPOA"),U,13)=DT,$P(^("RMPOA"),U,14)="P"
 W @IOF
 Q
 ;
LINE(X) S LNCT=LNCT+1,^TMP($J,RMPOXITE,"LINE",LNCT,0)="         "_X
 W !,?9,X
 Q
 ;
HDRL ; Define header lines
 S HEAD(1)="Department of Veterans Affairs",POS(1)=40-($L(HEAD(1))\2)
 S HEAD(2)=RMPO("NAME"),POS(2)=40-($L(HEAD(2))\2)  ;name of VAMC
 S HEAD(3)=RMPO("ADD"),POS(3)=40-($L(HEAD(3))\2)  ;street address of VAMC
 S HEAD(4)=RMPO("CITY"),POS(4)=40-($L(HEAD(4))\2)  ;city,state and zip of VAMC
 Q
 ;
PHDR ; Print header
 F I=1:1:5 D LINE("")
 D LINE($E(SP,1,POS(1))_HEAD(1)),LINE($E(SP,1,POS(2))_HEAD(2))
 D LINE($E(SP,1,POS(3))_HEAD(3)),LINE($E(SP,1,POS(4))_HEAD(4))
 F I=1:1:4 D LINE("")
 Q
 ;
DEV() ; Get device. Cannot be home device
 N DEV,POP
 ;F  S DEV=0,%ZIS="Q" D ^%ZIS Q:$G(POP)=1  S DEV=1 Q:IO(0)'=IO  W "Cannot Select Home Device"
DAGAIN S DEV=0,%ZIS="MQ" K IOP D ^%ZIS Q:$G(POP)=1 DEV
 I IO(0)=IO!(IOST["SLAVE") D ^%ZISC,HOME^%ZIS W "Cannot Select Home or Slave Device" G DAGAIN
 S DEV=1 Q DEV
EXIT ;Clean up and quit
 ; if interactive close printer
 D:'JOB ^%ZISC
 ;Kill off variables
 K %ZIS,Y,ZTSAVE,ZTDESC,ZTRTN,HEAD
 Q
QUIT() S QUIT=$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q QUIT
 Q
COMMON(PIKRTN) ;
 D FULL^VALM1
 S RTN="SINGLE^RMPOLZB"
 D @PIKRTN Q:$$QUIT  I Y="" S VALMBCK="R" Q
 S LFNS=Y
 I 'JOB Q:'$$DEV
 Q
 ;
PIKSOM ; ALLOW SELECTION FROM DISPLAYED ENTRIES
 K DIR S DIR(0)="LO^"_VALMBG_":"_VALMLST D ^DIR
 Q
