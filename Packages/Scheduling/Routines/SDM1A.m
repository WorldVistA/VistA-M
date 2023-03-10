SDM1A ;SF/GFT,ALB/TMP,MS/PB - MAKE APPOINTMENT ;JUN 29, 2017
 ;;5.3;Scheduling;**26,94,155,206,168,223,241,263,327,478,446,544,621,622,627,658,665,650,704,694,775,792,809**;Aug 13, 1993;Build 10
 ;
OK I $D(SDMLT) D ^SDM4 Q:X="^"!(SDMADE=2)
 S ^SC(SC,"ST",$P(SD,"."),1)=S,^DPT(DFN,"S",SD,0)=SC,^SC(SC,"S",SD,0)=SD S:'$D(^DPT(DFN,"S",0)) ^(0)="^2.98P^^" S:'$D(^SC(SC,"S",0)) ^(0)="^44.001DA^^" L -^SC(SC,"ST",$P(SD,"."),1)
S1 L +^SC(SC,"S",SD,1):$G(DILOCKTM,5) W:'$T "Another user is editing this record.  Trying again.",! G:'$T S1 F SDY=1:1 I '$D(^SC(SC,"S",SD,1,SDY)) S:'$D(^(0)) ^(0)="^44.003PA^^" S ^(SDY,0)=DFN_U_(+SL)_"^^^^"_$G(DUZ)_U_DT L -^SC(SC,"S",SD,1) Q
 I SM S ^("OB")="O" ;NAKED REFERENCE - ^SC(IFN,"S",Date,1,SDY,"OB")
 I $D(^SC(SC,"RAD")),^("RAD")="Y"!(^("RAD")=1) S ^SC("ARAD",SC,SD,DFN)=""
 S SDINP=$$INP^SDAM2(DFN,SD)
 ;-- added sub-category
 S COV=3,SDYC="",COV=$S(COLLAT=1:1,1:3),SDYC=$S(COLLAT=7:1,1:"")
 S:SD<DT SDSRTY="W"
 S ^DPT(DFN,"S",SD,0)=SC_"^"_$$STATUS(SC,SDINP,SD)_"^^^^^"_COV_"^^^^"_SDYC_"^^^^^"_SDAPTYP_U_$G(SD17)_"^"_$G(DUZ)_U_DT_"^^^^^"_$G(SDXSCAT)_U_$P($G(SDSRTY),U,2)_U_$$NAVA^SDMANA(SC,SD,$P($G(SDSRTY),U,2)) ;544 added DUZ
 S ^DPT(DFN,"S",SD,1)=$G(SDDATE)_U_$G(SDSRFU)
 I $D(SDMULT) S SDCLNCND=^SC(SC,0),STPCOD=$P(SDCLNCND,U,7),TMPYCLNC=SC_U_$P(SDCLNCND,U) D A^SDCNSLT ;SD/478 MULTI CLINIC OPTION SELECTED
 ;xref DATE APPT. MADE field
 D
 .N DIV,DA,DIK
 .S DA=SD,DA(1)=DFN,DIK="^DPT(DA(1),""S"",",DIK(1)=20 D EN1^DIK
 .D EN^SDTMPHLA(DFN,SD) ; Patch 704 - added to send the update to TMP when an appointment is scheduled with VistA roll and scroll options
 .Q
 K:$D(^DPT(DFN,"S",SD,"R")) ^("R") K:$D(^DPT("ASDCN",SC,SD,DFN)) ^(DFN)
 S SDRT="A",SDTTM=SD,SDPL=SDY,SDSC=SC D RT^SDUTL
 W !,"   ",+SL,"-MINUTE APPOINTMENT MADE" K SDINP
 ;confirm request type & follow-up indicator
 I $D(SDSRTY(0)) D CONF(.SDSRTY,.SDSRFU,DFN,SD,SC) W !
 I $P(SD,".")'>DT,$D(^DPT(DFN,.321)) D EN1^SDM3
 ;Wait List SD*5.3*263
 ;I '$D(SDWLLIST) D ^SDWLR ;replaced with sd/372, see below
EWLCHK ;check if patient has any open EWL entries (SD/372)
 ;get appointment
 K ^TMP($J,"SDAMA301"),^TMP($J,"APPT")
 D APPT^SDWLEVAL(DFN,SD,SC)
 Q:'$D(^TMP($J,"APPT"))
 N SDWL,SDWLF,SDWLIST S SDWL="" S SDWLF=0   ;alb/sat 627
 N SDEV D EN^SDWLEVAL(DFN,.SDEV) I SDEV,$L(SDEV(1))>0 D
 .K ^TMP("SDWLPL",$J),^TMP($J,"SDWLPL")
 .D INIT^SDWLPL(DFN,"M")
 .Q:'$D(^TMP($J,"SDWLPL"))
 .D LIST^SDWLPL("M",DFN)
 .D SDGET(.SDWLIST)   ;alb/sat 627
 .F  Q:'$D(^TMP($J,"SDWLPL"))  N SDR D ANSW^SDWLEVAL(1,.SDR) S:SDR SDWLF=1 I 'SDR D LIST^SDWLPL("M",DFN) D
 ..F  N SDR D ANSW^SDWLEVAL(0,.SDR) Q:'$D(^TMP($J,"SDWLPL"))  I 'SDR W !,"MUST ENTER A REASON NOT TO DISPOSITION MATCHED EWL ENTRY",!  ;alb/sat665 remove S SDWLF=1
 .S:+SDWLF SDWL=$$SDWL(.SDWLIST)   ;alb/sat 627
 ;update SDEC APPOINTMENT file 409.84  ;alb/sat 627
 N SDECAR,SDREC,SDRES
 S SDREC=""
 I $G(CNSLTLNK)="",SDWL="" S SDREC=$$RECALL^SDECUTL(DFN,SD,SDSC)  ;check if recall appt
 I SDWL="",$G(CNSLTLNK)="",SDREC="" S SDECAR=$$SDWLA(DFN,SD,SDSC,SDDATE,$G(SDAPTYP),$G(SDECANS))  ;alb/sat 665 add SDECANS
 K SDECANS
 S SDRES=$$GETRES^SDECUTL(SC,1)
 S SDAPTYP=$G(SDAPTYP) S:SDAPTYP="" SDAPTYP=$$GET1^DIQ(44,SC_",",2507,"I")
 ;alb/sat 658 - moved below OTHER INFO prompt to store in NOTE field of 409.84
 ;D SDECADD^SDEC07(SD,$$FMADD^XLFDT(SD,,,+SL),DFN,SDRES,0,SDDATE,"",$S(+SDWL:"E|"_SDWL,+$G(CNSLTLNK):"C|"_CNSLTLNK,+SDREC:"R|"_SDREC,+SDECAR:"A|"_SDECAR,1:""),,SC,,,,SDAPTYP) ;ADD SDEC APPOINTMENT ENTRY
 ;end addition/modification  ;alb/sat 627
 ;CREATE 120 FLAG IF APPLICABLE; appt created
FLG N SDST S SDST=$G(^TMP($J,"APPT",1)) I +SDST>0 D
 .Q  ; sd/446
 .N SDT,SDDES,SDPAR,SDDES1,SDT1 S SDPAR=0 S SDT=+SDST,SDDES=$P(SDST,U,17) I SDDES="" S SDDES=DT ; today's date if no desired date
 .S X=SDT D H^%DTC S SDT1=%H
 .S X=SDDES D H^%DTC S SDDES1=%H
 .I SDT1-SDDES1>120 N SD120,SD120A S SD120=1,SD120A=1  D
 ..; CREATE ewl eN SDPR S SDPR=$S(SDDES=DT:"A",1:"F") entry with 120 flag
 ..N SDPR S SDPR=$S(SDDES=DT:"A",1:"F") ;10
 ..N SDWLIN S SDWLIN=+$P(SDST,U,15) ;2
 ..N SDWLSCPR S SDWLSCPR=0 I +$P(SDST,U,10)=11 S SDWLSCPR=1 ;15
 ..N SC,SDWLSCL S SC=+$P(SDST,U,2) D
 ...I $D(^SDWL(409.32,"B",SC)) S SDWLSCL=$O(^SDWL(409.32,"B",SC,"")) Q  ;8
 ...;create 409.32 entry
 ...N DA,DIC S DIC(0)="LX",X=SC,DIC="^SDWL(409.32," D FILE^DICN
 ...S SDWLSCL=DA
 ...S DIE="^SDWL(409.32,"
 ...S DR=".02////^S X=SDWLIN" D ^DIE
 ...S DR="1////^S X=DT"
 ...S DR=DR_";2////^S X=DUZ"
 ...D ^DIE S SDPAR=1
 ..N DA S DIC(0)="LX",(X,SDWLDFN)=+$P(SDST,U,4),X=SDWLDFN,DIC="^SDWL(409.3," D FILE^DICN
 ..F  L +^SDWL(409.3,DA):$G(DILOCKTM,5) Q:$T  D
 ...I '$T W !,"Unable to acquire a lock on the Wait List file" Q
 ..; Update EWL variables.
 ..S SDWLDA=DA D EN^SDWLE11 ; get enrollee both SDWLDA and SDWLDFN have to be
 ..N SDWLCM S SDWLCM=" > 120 days; appt created"
 ..N SDWLSCPG S SDWLSCPG=$S($P($G(^DPT(SDWLDFN,.3)),U,1)="Y":$P(^(.3),U,2),1:"")
 ..S DR="1////^S X=DT"
 ..S DR=DR_";2////^S X=SDWLIN"
 ..S DR=DR_";4////^S X=4"
 ..S DR=DR_";8////^S X=SDWLSCL"
 ..S DR=DR_";9////^S X=DUZ"
 ..S DR=DR_";10////^S X=SDPR"
 ..S DR=DR_";11////^S X=2" ; by patient for this entry to avoid asking for provider
 ..S DR=DR_";14////^S X=SDWLSCPG"
 ..S DR=DR_";15////^S X=SDWLSCPR"
 ..S DR=DR_";22////^S X=SDDES"
 ..S DR=DR_";23////^S X=""O"""
 ..S DR=DR_";25////^S X=SDWLCM"
 ..S DR=DR_";36////^S X=SD120"
 ..S DR=DR_";39////^S X=SD120A"
 ..S DIE="^SDWL(409.3,"
 ..D ^DIE
 ..L -^SDWL(409.3,DA)
 ..D MESS^SDWL120(SDWLDFN,SC,SDT,SDPAR)
 ;continue appointment entry process
ORD S %=2 W !,"WANT PATIENT NOTIFIED OF LAB,X-RAY, OR EKG STOPS" D YN^DICN I '% W !,"  Enter YES to notify patient on appt. letter of LAB, X-RAY, or EKG stops" G ORD
 I '(%-1) D ORDY^SDM3
OTHER R !,"  OTHER INFO: ",D:DTIME I D["^" W !,*7,"'^' not allowed - hit return if no 'OTHER INFO' is to be entered" G OTHER
 S TMPD=D I $L(D)>150 D MSG^SDMM G OTHER ;SD/478
 I D]"",D?."?"!(D'?.ANP) W "  ENTER LAB, SCAN, ETC." G OTHER
 I $L($G(^SC(SC,"S",SD,1,SDY,0)))+$L(D)+$L(DT)+$S($D(DUZ):$L(DUZ),1:0)>250 D MSG^SDMM G OTHER  ; sd/446
 ;S $P(^(0),"^",4)=D,$P(^(0),U,6,7)=$S($D(DUZ):DUZ,1:"")_U_DT ;NAKED REFERENCE - ^SC(IFN,"S",Date,1,SDY,0)
 S $P(^(0),"^",4)=D ;NAKED REFERENCE - ^SC(IFN,"S",Date,1,SDY,0) 544 moved DUZ&DT to tag S1.
 ; SD*775 add SDSLSV to be evaluated
 S:$G(SL)="" SL=$S($D(SDSLSV):SDSLSV,1:$G(^SC(+SC,"SL")))   ;alb/sat 658 - SL gets killed in SDM3 if 'WANT PATIENT NOTIFIED OF LAB,X-RAY, OR EKG STOPS' is answered with Y
 D SDECADD^SDEC07(SD,$$FMADD^XLFDT(SD,,,+SL),DFN,SDRES,0,SDDATE,"",$S(+SDWL:"E|"_SDWL,+$G(CNSLTLNK):"C|"_CNSLTLNK,+SDREC:"R|"_SDREC,+SDECAR:"A|"_SDECAR,1:""),,SC,$G(D),,,SDAPTYP) ;ADD SDEC APPOINTMENT ENTRY  ;alb/sat 658 moved from above
 D:$D(TMP) LINK^SDCNSLT(SC,SDY,SD,CNSLTLNK) ;SD/478
 D:$D(TMP) EDITCS^SDCNSLT(SD,TMPD,TMPYCLNC,CNSLTLNK) ;SD/478
 K TMP  ;SD/478
XR I $S('$D(^SC(SC,"RAD")):1,^("RAD")="Y":0,^("RAD")=1:0,1:1) S %=2 W !,"WANT PREVIOUS X-RAY RESULTS SENT TO CLINIC" D YN^DICN G:'% HXR I '(%-1) S ^SC("ARAD",SC,SD,DFN)=""
SDMM S SDEMP=0 I COLLAT=7 S:SDEC'=SDCOL SDEMP=SDCOL G OV
 D ELIG^VADPT I $O(VAEL(1,0))>0 D ELIG^SDM4:"369"[SDAPTYP S SDEMP=$S(SDDECOD:SDDECOD,1:SDEMP)
OV Q:$D(SDZM)  K SDQ1,SDEC,SDCOL I +SDEMP S $P(^SC(SC,"S",SD,1,SDY,0),"^",10)=+SDEMP
 S SDMADE=1 D EVT
LET ; SD*5.3*622 - help user print the PRE-APPT letter for a patient
 ; check for a PRE-APPT letter defined and if none, don't issue a device prompt
 N SDFN ; new SDFN to see the patient prompt next time
 S %=2 W !!,"WANT TO PRINT THE PRE-APPOINTMENT LETTER" D YN^DICN I %=0 W !,"RESPOND YES (Y) OR NO (N)" G:'% LET
 I (%=2)!(%=-1) Q
 I $P($G(^SC(SC,"LTR")),U,2)="" D  Q
 . W $C(7),!!,"PATIENT "_$P(^DPT(DFN,0),U,1)," ",$P(^(0),U,9)," HAS FUTURE APPTS., but"
 . W !,$P(^SC(SC,0),U,1)_" is not assigned a PRE-APPOINTMENT LETTER",!
 . S DIR(0)="E" D ^DIR K DIR
 ;
 ; pre-define letter type (P), the division, date for appt, etc.
 S (SDBD,SDED)=SDTTM,L0="P",SD9=0,VAUTNALL=1,VAUTNI=2,S1="P",SDLT=1,SDV1=1,SDFORM=""
 S L2=$S(L0="P":"^SDL1",1:"^SDL1"),J=SDBD
 S (A,SDFN,S)=DFN,L="^SDL1",SDCL=+$P(^SC(SC,0),U,1),SDC=SC,SDX=SDTTM
 S SDLET=$P(^SC(SC,"LTR"),U,2) ; letter IEN
 S SDLET1=SDLET
 I SDY["DPT(" S SDAMTYP="P",SDFN=+SDY
 I SDY["SC(" S SDAMTYP="C",SDCLN=+SDY
 ; prepare to queue the letter if the user so desires
 N %ZIS,POP,ZTDESC,ZTRTN,ZTSAVE
 S %ZIS("B")="",POP=0,%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="QUE^SDM1A",ZTDESC="PRINT PRE-APPT LETTER",ZTSAVE("*")="" D ^%ZTLOAD,HOME^%ZIS K IO("Q") Q
 D QUE ; print right away without getting into the queue
 D HOME^%ZIS
 Q
 ;
QUE ; execute whether by queue or immediate print request
 U IO
 N SDFIRST S SDFIRST=1   ; Flag to determine first page SD*650
 D PRT^SDLT,WRAPP^SDLT
 ; if there are x-ray, lab, or ekg appts, print them too
 S SDATA=$G(^DPT(DFN,"S",SDX,0))
 I $D(SDATA) F B=3,4,5 D
 . S SDCL=$S(B=3:"LAB",B=4:"XRAY",1:"EKG")
 . S SDX=$P($G(SDATA),U,B)
 . S SC=SDCL Q:$G(SDX)=""  D FORM^SDLT
 ;
 D REST^SDLT
 D ^%ZISC
 Q  ; SD*5.3*622 - end of changes
 ;
HXR W !,"  Enter YES to have previous XRAY results sent to the clinic" G XR
 Q
CS S SDCS=+$P(^SC(+SC,0),"^",7) I $S('$D(^DIC(40.7,SDCS,0)):1,'$P(^(0),"^",3):0,1:$P(^(0),"^",3)'>DT) W !!,*7,"** WARNING - CLINIC HAS AN INVALID OR INACTIVE STOP CODE!!!",!!
 S SDCS=+$P(^SC(+SC,0),"^",18) I $S('SDCS:0,'$D(^DIC(40.7,SDCS,0)):1,'$P(^(0),"^",3):0,1:$P(^(0),"^",3)'>DT) W !!,*7,"** WARNING - CLINIC HAS AN INVALID OR INACTIVE CREDIT STOP CODE!!!",!!
 K SDCS Q
STATUS(SDCL,SDINP,SDT) ; -- determine status for NEW appts
 Q $S(SDINP]"":SDINP,$$CHK(.SDCL,.SDT):"NT",1:"")
CHK(SDCL,SDT) ; -- should appt be NT'ed
 ; -- non-count clinic check := don't NT appt
 ; -- appt update executed   := need to NT appt
 ; -- otherwise              := don't NT appt
 Q $S($P($G(^SC(SDCL,0)),U,17)="Y":0,$D(^SDD(409.65,"AUPD",$P(SDT,"."))):1,1:0)
EVT ; -- separate tag if need to NEW vars
 D MAKE^SDAMEVT(DFN,SD,SC,SDY,0)
 Q
REQ(SDT) ; -- which is required check in(CI) or out(CO)
 Q $S($$REQDT()>SDT:"CI",1:"CO")
REQDT() ; -- co required date
 Q $S($P(^DG(43,1,"SCLR"),U,23):$P(^("SCLR"),U,23),1:2931001)
COCMP(DFN,SDT) ; -- date CO completed
 Q $P($G(^SCE(+$P($G(^DPT(DFN,"S",SDT,0)),U,20),0)),U,7)
CI(SDCL,SDT,SDDA,SDACT) ; -- ok to update DPT
 N C
 I '$$CHK(.SDCL,.SDT) G CIQ
 I $$REQ(SDT)'="CI" G CIQ
 I SDACT="SET",$D(^DPT(+^SC(SDCL,"S",SDT,1,SDDA,0),"S",SDT,0)),$P(^(0),U,2)="NT" S $P(^(0),U,2)=""
 I SDACT="KILL" S C=$G(^SC(SDCL,"S",SDT,1,SDDA,"C")) I $D(^DPT(+$G(^(0)),"S",SDT,0)),$P(^(0),U,2)="",'$P(C,U,3) S $P(^(0),U,2)="NT"
CIQ Q
CO(SDCL,SDT,SDDA,SDACT) ; -- ok to update DPT
 N DFN,C
 I '$$CHK(.SDCL,.SDT) G COQ
 I $$REQ(.SDT)'="CO" D  G COQ
 .I SDACT="SET",$D(^DPT(+^SC(SDCL,"S",SDT,1,SDDA,0),"S",SDT,0)),$P(^(0),U,2)="NT" S $P(^(0),U,2)=""
 .I SDACT="KILL" S C=$G(^SC(SDCL,"S",SDT,1,SDDA,"C")) I $D(^DPT(+$G(^(0)),"S",SDT,0)),$P(^(0),U,2)="",'C S $P(^(0),U,2)="NT"
 S DFN=+^SC(SDCL,"S",SDT,1,SDDA,0)
 D UPD(.DFN,.SDT,$$COCMP(.DFN,.SDT),$S(SDACT="SET":X,1:""))
COQ Q
UPD(DFN,SDT,SDCOCMP,SDCODT) ; -- update status
 N Y
 I $D(^DPT(DFN,"S",SDT,0)) S Y=$P(^(0),U,2) D
 .I 'SDCOCMP!('SDCODT) S:Y="" $P(^DPT(DFN,"S",SDT,0),U,2)="NT" Q
 .S:Y="NT" $P(^DPT(DFN,"S",SDT,0),U,2)=""
 Q
OE(SDOE,SDACT) ; -- called by x-ref on co completed field(#.07) in ^SCE
 N Y S Y=^SCE(SDOE,0)
 I $P(Y,U,8)'=1 G OEQ
 I $$REQ(+Y)'="CO" G OEQ
 I '$$CANT(+$P(Y,U,2),+Y,SDOE),'$$CHK(+$P(Y,U,4),+Y) G OEQ
 D UPD(+$P(Y,U,2),+Y,$S(SDACT="SET":X,1:""),$P($G(^SC(+$P(Y,U,4),"S",+Y,1,+$P(Y,U,9),"C")),U,3))
OEQ Q
CONF(SDSRTY,SDSRFU,DFN,SDT,SC) ;Confirm scheduling request type
 ;Input: SDSRTY=request type
 ;Input: SDSRFU=follow-up indicator
 ;Input: DFN=patient ien
 ;Input: SDT=appointment date/time
 ;Input: SC=clinic ifn
 N DIR,DIE,DA,DR,SDX,SDY,X,Y
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="THIS APPOINTMENT IS MARKED AS '"_SDSRTY(0)_"', IS THIS CORRECT"
 W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I 'Y S SDX='SDSRTY,SDX(0)=$$TXRT(.SDX) W !!,"THIS APPOINTMENT HAS NOW BEEN MARKED AS '"_$S('SDSRTY:"",1:"NOT ")_"NEXT AVAILABLE'."
 ;S DIR("A")="THIS APPOINTMENT IS DEFINED AS '"_$S(SDSRFU:"FOLLOW-UP",1:"OTHER THAN FOLLOW-UP")_"', OK"
 ;W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 ;I 'Y S SDY='SDSRFU W "  (changed)"
 Q:'$D(SDX)  S DR=""
 I $D(SDX) S DR="25///^S X=$P(SDX,U,2);26///^S X=$$NAVA^SDMANA(SC,SDT,$P(SDX,U,2))"
 ;I $D(SDY) S:$L(DR) DR=DR_";" S DR=DR_"26///^S X=SDY"
 S DA=SDT,DA(1)=DFN
 S DIE="^DPT(DA(1),""S""," D ^DIE
 Q
TXRT(SDSRTY)    ;Transform request type
 ;Input: SDSRTY=variable to return request type (pass by reference)
 ;Output: external text for SDSRTY(0)
 I SDSRTY S SDSRTY=SDSRTY_U_"N" Q "NEXT AVAILABLE"
 S SDSRTY=SDSRTY_U_"O" Q "NOT NEXT AVAILABLE"
CANT(DFN,SDT,SDOE) ;Determine if clinic appt. has been marked "NT"
 ;Output: '1' if appt. points to encounter and is marked "NT", otherwise '0'
 N SDAPP S SDAPP=$G(^DPT(DFN,"S",SDT,0))
 Q:$P(SDAPP,U,20)'=SDOE 0
 Q $P(SDAPP,U,2)="NT"
SDGET(SDWLIST)  ;build array of wait list entries that are in ^TMP($J,"SDWLPL")
 N SDI
 K SDWLIST
 S SDI="" F  S SDI=$O(^TMP($J,"SDWLPL",SDI)) Q:SDI=""  D
 .S SDWLIST(+$G(^TMP($J,"SDWLPL",SDI)))=""
 Q
 ; -- Variable doc for above tags
 ;     SDCL := file 44 ien
 ;      SDT := appt date/time
 ;      DFN := file 2 ien
 ;     SDDA := ^SC(SDCL,"S",SDT,1,SDDA,0)
 ;    SDACT := current x-ref action 'set' or 'kill'
 ;  SDCOCMP := check out completed date
 ;   SDCODT := check out date/time
 ;     SDOE := Outpatient Encounter ien
 ;    SDINP := inpatient status ('I' or null)
 ;    SDINP := inpatient status ('I' or null)
 ;
SDWL(SDWLIST)  ;determine EWL that was closed for this appointment   ;alb/sat  SD/627
 N SDI
 S SDI="" F  S SDI=$O(^TMP($J,"SDWLPL",SDI)) Q:SDI=""  D
 .I $D(SDWLIST(+$G(^TMP($J,"SDWLPL",SDI)))) K SDWLIST(+$G(^TMP($J,"SDWLPL",SDI)))
 Q $O(SDWLIST(0))
SDWLA(DFN,SD,SDSC,SDDATE,SDAPTYP,SDECANS)  ;add SDEC APPT REQUEST entry  ;alb/sat  SD/627  ;alb/sat 665 add SDECANS
 ;INPUT:
 ; DFN
 ; SD     = appointment date/time in fm format
 ; SDSC   = clinic code pointer to HOSPITAL LOCATION file
 ; SDDATE = desired date of appointment
 ; SDAPTYP = pointer to APPOINTMENT TYPE file 409.1
 ; SDECANS = service connected condition  Y=yes N=no from SDM4  ;alb/sat 665
 N SDECINP,SDWLSTAT,SDARIEN,SDWLRET,X
 S SDAPTYP=$G(SDAPTYP)
 S SDECANS=$G(SDECANS)  ;alb/sat 665
 ;get clinic location name
 K ^TMP("SDEC50",$J,"PCSTGET")
 D PCSTGET^SDEC(.SDWLRET,DFN,SDSC)
 S SDWLSTAT=$P($P($G(^TMP("SDEC50",$J,"PCSTGET",1)),$C(30),1),U,2)
 K ^TMP("SDEC50",$J,"PCSTGET")
 ;set appt request entry
 S SDECINP(1)=""
 S SDECINP(2)=DFN                                     ;patient
 S X=$E($$NOW^XLFDT,1,12),SDECINP(3)=$$FMTE^XLFDT(X)  ;originating date/time in external format  PWC SD*5.3*694 VSE
 S SDECINP(4)=DUZ(2)                                  ;institution
 S SDECINP(5)="APPOINTMENT"                           ;wait list type - specific clinic
 S SDECINP(6)=SDSC                                    ;clinic
 S SDECINP(7)=DUZ                                     ;originating user
 S SDECINP(8)="ASAP"                                  ;priority
 S SDECINP(9)="PATIENT"                               ;requested by
 S SDECINP(11)=SDDATE                                 ;desired date of appointment
 ;S SDECINP(16)=$S(SDWLSTAT="YES":"ESTABLISHED",1:"NEW")
 S SDECINP(14)="NO"                                   ;multiple appointment RTC
 S SDECINP(15)=0
 S SDECINP(16)=0
 S:SDECANS'="" SDECINP(18)=$S(SDECANS="Y":"YES",1:0)  ;alb/sat 665
 S:+SDAPTYP SDECINP(22)=+SDAPTYP                      ;appointment type
 K SDWLRET
 S SDWLRET=""
 D ARSET1^SDEC(.SDWLRET,.SDECINP)
 S SDARIEN=$P($P(SDWLRET,$C(30),2),U,1)
 S SDWLRET=""
 Q:'$D(^SDEC(409.85,+SDARIEN,0)) ""
 ;close appt request entry
 K INP
 S INP(1)=SDARIEN
 S INP(2)="REMOVED/SCHEDULED-ASSIGNED"
 S INP(3)=DUZ
 ;S INP(4)=$P(SD,".",1) ;SD_53_809 - commenting this code since this is not the correct disposition date
 S INP(4)=$$NETTOFM^SDECDATE($P($G(SDECINP(3)),"@"),"N","N") ;SD_53_809 - date of disposition should be the same to the create date
 D ARCLOSE1^SDEC(.SDWLRET,.INP)
 Q SDARIEN
