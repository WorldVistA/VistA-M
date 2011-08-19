RMPRPCE1 ;HCIOFO/RVD - Prosthetics/PCE UPDATE UTILITY ;5/7/03  09:12
 ;;3.0;PROSTHETICS;**62,69,77,78,146**;Feb 09, 1996;Build 4
 ;
 ;patch #69
 ;RVD 4/10/02 - validate the length (16 c) of provisional diagnosis
 ;              before filing.  Change Routine Prosthetic to ROUTINE
 ;              Type of Request field in 660.
 ;RVD 5/6/03 patch #77 - SET Consult Request Service field in #660.
 ;                     - POST init for setting Consult Request Service. 
 ;TH 9/29/03 Patch #78 - Add Billing Aware related fields.
 ;
 ;DBIA # 10060, Fileman read of file #200.
 ;
 ;This routine contains the code for updating file #660 and #668.
 ;
 ;RMIE60 - ien of file #660
UP60(RMIE60,RMIE68,RMSUSTAT) ; update file #660.
 D NEWVAR
 S RMERR=0
 S:RMSUSTAT="" RMSUSTAT=0
 L +^RMPR(660,RMIE60):2
 I $T=0 W !,"Someone else is Editing this entry!!!",! H 3 S RMERR=1 G UP60X
 S RM680=$G(^RMPR(668,RMIE68,0))
 S RM688=$G(^RMPR(668,RMIE68,8))
 S RM6810=$G(^RMPR(668,RMIE68,10))
 ;code here for 668 fields
 S RMDATE=$P(RM680,U,1)  ;Suspense Date
 S RMCODT=$P(RM680,U,5)  ;Completion Date
 S RMINDT=$P(RM680,U,9)  ;Initial Action Date
 S RMPRCO=$P(RM680,U,15) ;Consult
 S RMDWRT=$P(RM680,U,16) ;Date RX Written
 S RMSTAT=$P(RM680,U,7)  ;Station
 S RMTRES=$P(RM680,U,8)  ;Type of Request
 S RMTYRE=$S(RMTRES=1:"ROUTINE",RMTRES=2:"EYEGLASS",RMTRES=3:"CONTACT LENS",RMTRES=4:"OXYGEN",RMTRES=5:"MANUAL",1:"")
 S RMREQU=$P(RM680,U,11) ;Requestor (Ordering Provider)
 S RMSERV=""
 ;I $G(RMREQU) D GETS^DIQ(200,RMREQU,"29","E","RMAA") S RMSERV=RMAA(200,RMREQU_",",29,"E")
 S RMPRDI=$E($P(RM688,U,2),1,16) ;Provisional Diagnosis
 S RMICD9=$P(RM688,U,3)   ;ICD9
 ;
 S RMDAT(660,RMIE60_",",8.1)=RMDATE    ;Suspense Date
 S RMDAT(660,RMIE60_",",8.2)=RMDWRT    ;Date RX Written
 S RMDAT(660,RMIE60_",",8.3)=RMINDT    ;Initial Action Date
 S RMDAT(660,RMIE60_",",8.4)=RMCODT    ;Completion Date
 S RMDAT(660,RMIE60_",",8.5)=RMTYRE    ;Type of Request
 S RMDAT(660,RMIE60_",",8.6)=RMREQU    ;Ordering Provider
 S RMDAT(660,RMIE60_",",8.61)=RMSERV   ;Consult Request Service
 S RMDAT(660,RMIE60_",",8.7)=RMPRDI    ;Provisional Diagnosis
 S RMDAT(660,RMIE60_",",8.8)=RMICD9    ;Suspense ICD9
 S RMDAT(660,RMIE60_",",8.9)=RMPRCO    ;Pointer to Request/Consultation
 S RMDAT(660,RMIE60_",",8.11)=RMSTAT   ;Suspense Station
 S RMDAT(660,RMIE60_",",8.14)=RMSUSTAT ;Suspense Status
 ;
 ; Patch #78
 ; #668,BA nodes
 F RMPRL=1:1:99 S RM68BA=$G(^RMPR(668,RMIE68,"BA"_RMPRL)) Q:RM68BA=""  D
 . N RMICD,RMAO,RMIR,RMSC,RMEC,RMMST,RMHNC,RMCBV
 . S RMICD=$P(RM68BA,U,1)
 . S RMAO=$P(RM68BA,U,2)
 . S RMIR=$P(RM68BA,U,3)
 . S RMSC=$P(RM68BA,U,4)
 . S RMEC=$P(RM68BA,U,5)
 . S RMMST=$P(RM68BA,U,6)
 . S RMHNC=$P(RM68BA,U,7)
 . S RMCBV=$P(RM68BA,U,8)
 . N RMPTR
 . S RMPTR=29+RMPRL
 . S RMDAT(660,RMIE60_",",RMPTR)=RMICD
 . S RMDAT(660,RMIE60_",",RMPTR_".1")=RMAO
 . S RMDAT(660,RMIE60_",",RMPTR_".2")=RMIR
 . S RMDAT(660,RMIE60_",",RMPTR_".3")=RMSC
 . S RMDAT(660,RMIE60_",",RMPTR_".4")=RMEC
 . S RMDAT(660,RMIE60_",",RMPTR_".5")=RMMST
 . S RMDAT(660,RMIE60_",",RMPTR_".6")=RMHNC
 . S RMDAT(660,RMIE60_",",RMPTR_".7")=RMCBV
 ;
 D UPDATE^DIE("","RMDAT",,"RMERROR")
 I $D(RMERROR) S RMERR=1 D ERR0
 ;
 L -^RMPR(660,RMIE60)
UP60X ; exit point
 Q RMERR
 ;
 ;RMIE60 = IEN of file #660.
 ;RMIE68 = IEN of file #668.
UP68(RMIE60,RMIE68,RMAMIS) ; update file #668.
 D NEWVAR
 S (RMI,RMERR)=0
 ;S RMAMIS=$G(^RMPR(660,RMIE60,"AMS"))
 I '$G(RMAMIS) D ERR8 S RMERR=1 G UP68X
 ;L +^RMPR(668,RMIE68):2
 ;I $T=0 W !,"Someone else is Editing this entry!!!",! H 3 S RMERR=1 G UP68X
 I $D(^RMPR(668,RMIE68,10,"B",RMIE60)) G UP68X
 S DA(1)=RMIE68 K DD,DO
 S DIC="^RMPR(668,"_DA(1)_","_"10,",DIC(0)="L",DLAYGO=668,X=RMIE60
 D FILE^DICN K DIC,X,DLAYGO,DD,DO
 I Y=-1 S RMERR=1 D ERR8 G UNL68
 I $D(^RMPR(668,RMIE68,11,"B",RMAMIS)) G UP68X
 S DA(1)=RMIE68
 S DIC="^RMPR(668,"_DA(1)_","_"11,",DIC(0)="L",DLAYGO=668,X=RMAMIS
 D FILE^DICN K DIC
 I Y=-1 S RMERR=1 D ERR8 G UNL68
 ;
UNL68 ;L -^RMPR(668,RMIE68)
UP68X ; exit point
 Q RMERR
 ;
ERR0 ;error updating file #660
 W !,"*** Error updating file #660 in PCE module!!!",!
 Q
ERR8 ;error updating file #668
 W !,"*** Error updating file #668 in PCE module!!!",!
 Q
LINK ;link 2319 to suspense
 D DIV4^RMPRSIT Q:$D(X)
 K ^TMP($J)
 W ! S DIC="^RMPR(660,",DIC(0)="AEMQZ",DIC("A")="Select PATIENT: "
 S DIC("S")="S RMZ=$G(^RMPR(660,+Y,10)) I $P(RMZ,U,14)'=1,$D(^(""AMS"")),RMPR(""STA"")=$P(^(0),U,10)"
 S DIC("W")="D EN^RMPRD1"
 W !
 D ^DIC G:Y'>0 EXIT
 L +^RMPR(660,+Y):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 S RMPRDA=+Y
 S RMPRDFN=$P(^RMPR(660,+Y,0),U,2)
 I $D(^RMPR(660,+Y,"AMS")) N RMPRAMIS S RMPRAMIS=$P(^RMPR(660,+Y,"AMS"),U,1)
 S ^TMP($J,"RMPRPCE",660,+Y)=RMPRAMIS_"^"_RMPRDFN
 D LINK^RMPRS
 I $G(RMPRDA)="" S RMPRDA=$O(^TMP($J,"RMPRPCE",660,0))
 I $G(RMPRDA)="" L  G EXIT
 L -^RMPR(660,RMPRDA)
EXIT ;quit
 K ^TMP($J)
 K RMPR,RMPRSTE
 K RMCODT
 D KILL^XUSCLEAN
 Q
 ;
SCRS ;set consult request service.
 ;start conversion on 1/1/2002, the date of PCE/Link to suspense patch.
 W !!,"Setting Consult Request Service in file #660....."
 N RI,RJ F RI=3020100:0 S RI=$O(^RMPR(660,"B",RI)) Q:RI'>0  F RJ=0:0 S RJ=$O(^RMPR(660,"B",RI,RJ)) Q:RJ'>0  I $D(^RMPR(660,RJ,10)) D
 .K RMAA
 .S RMREQU=$P(^RMPR(660,RJ,10),U,6)
 .S RMSERV=""
 .I $G(RMREQU) D GETS^DIQ(200,RMREQU,"29","E","RMAA") S RMSERV=RMAA(200,RMREQU_",",29,"E")
 .S:RMSERV'="" $P(^RMPR(660,RJ,4),U,3)=RMSERV
 W !!,"Done setting Consult Request Service!!",!
 Q
 ;
NEWVAR N DA,DIE,DIC,I,J,RMDFN,RMI,RMDATE,RM680,RM688,RM6810,RMERROR
 N RMERR,RMCHK,RMAMIS,DLAYGO,X,DR,RMAA,RMSERV,RMREQU,RMDAT
 N RMPRL,RM68BA,RMDWRT,RMICD9,RMINDT,RMPRCO,RMPRDI,RMSTAT,RMTRES,RMTYRE
 Q
