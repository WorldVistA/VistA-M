RMPOLET2 ;EDS/PAK - HOME OXYGEN LETTERS ;7/24/98
 ;;3.0;PROSTHETICS;**29,55,159**;Feb 09, 1996;Build 2
 ;
 ; ODJ - patch 55 - 1/30/01 - replace hard code 121 mail symbol with
 ;                            site param. extrinsic (AUG-1097-32118)
 ;
START ;
 N HEAD,REC,POS
 ;
 K ^TMP($J)
 Q:'$$SITE^RMPOLET0
 ;
 D GENOLST^RMPOLET0(1)   ;generate list of patient to print
 ;
 I '$D(^TMP($J)) D  G EXIT
 . W !!,"There are no letters to print for this site."
 . W !!,"Use the 'List of Patients' option to create a list.",!!,$C(7)
 ;
 Q:'$$LOCK^RMPOLET0("work with current")
 ;
 F  D ASKHEAD Q:%'=0
 S HEAD=% W @IOF
 S %ZIS="Q" D ^%ZIS Q:$G(POP)=1
 I $D(IO("Q")) D  Q:'$$QUEUE^RMPOLET1(ZTDESC,ZTRTN,.ZTSAVE)  D HOME^%ZIS Q
 . K ZTSAVE
 . S ZTDESC="RMPO : Patient Letter Print"
 . S ZTRTN="PRINT^RMPOLET2("_HEAD_")"
 . S (ZTSAVE("RMPOXITE"),ZTSAVE("RMPOSITE"),ZTSAVE("RMPO("),ZTSAVE("^TMP($J,"))=""
 D PRINT(HEAD),EXIT
 Q
ASKHEAD ;
 S %=1 W !,"Would you like a letterhead printed on the letters"
 D YN^DICN
 Q:%<0
 I %=0 W !,"Answer 'Yes' for a header, 'No' for no header."
 Q
 ;
PRINT(HEAD) ; Print H.O. correspondence
 N DATE
 ;
 U IO(0) S Y=DT X ^DD("DD") S DATE=Y D:HEAD=1 HEADER
 ;
 S RMPOLCD="" F  S RMPOLCD=$O(^TMP($J,"RMPOLST",RMPOLCD)) Q:RMPOLCD=""  D
 . S RMPODFN="" F  S RMPODFN=$O(^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)) Q:RMPODFN=""  D
 . . S RMPOLTR=^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)
 . . S REC=^TMP($J,"RMPODEMO",RMPODFN) D BODY
 ;
 Q
BODY ; Set up array for filing and print letter
 N I,LN,LNCT,SP,Y,NAME,SURNM,FRSTNM
 ; 
 S $P(SP," ",80)=" ",LNCT=0
 I HEAD'=1 F I=1:1:5 D LINE("")
 E  D
 . F I=1:1:5 D LINE("")
 . D LINE($E(SP,1,POS(1))_HEAD(1)),LINE($E(SP,1,POS(2))_HEAD(2))
 . D LINE($E(SP,1,POS(3))_HEAD(3)),LINE($E(SP,1,POS(4))_HEAD(4))
 . F I=1:1:4 D LINE("")
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
 S X=$$FILE^RMPOLETU(RMPODFN,"^TMP($J,""LINE"")",LNCT,RMPOLTR)
 I 'X W !,"<<< Error"_+X_":"_$P(X,";",2)_" Patient #"_RMPODFN_" ! >>>",*7 Q
 ;
 D UPDLTR^RMPOLET0(RMPODFN,"@")  ; Clear "letter to be sent" field in RMPR(665
 ;
 I IOST["C-" R !!,"Press <ENTER> to continue",ANS:DTIME Q:'$T
 Q
 ;
LINE(X) S LNCT=LNCT+1,^TMP($J,"LINE",LNCT,0)="         "_X
 W !,?9,X
 Q
 ;
HEADER ;
 S HEAD(1)="Department of Veterans Affairs",POS(1)=45-($L(HEAD(1))\2)
 S HEAD(2)=RMPO("NAME"),POS(2)=45-($L(HEAD(2))\2)  ;name of VAMC
 S HEAD(3)=RMPO("ADD"),POS(3)=45-($L(HEAD(3))\2)  ;street address of VAMC
 S HEAD(4)=RMPO("CITY"),POS(4)=45-($L(HEAD(4))\2)  ;city,state and zip of VAMC
 Q
 ;
EXIT ;Clean up and quit
 ;
 ;Close printer
 D ^%ZISC
 ;
 ; clear lock of virtual control record
 L -^TMP("RMPO",$J,"LETTERPRINT")
 ;
 ;Kill off variables
 K ^TMP($J),%ZIS,Y,ZTSAVE,ZTRTN,RMPO,ZTDESC,L,LET
 Q
