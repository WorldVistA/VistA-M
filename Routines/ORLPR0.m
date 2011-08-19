ORLPR0 ; SLC/CLA - Report formatter for patient lists ;11/27/91 [3/22/00 12:41pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**47**;Dec 17, 1997
 ;
OUTPUT ;called by TaskMan via ORUTL1 (ORUTL1 queued output was setup by INQ)
 ; SLC/PKS - Modified 8/99.
 U IO
 N ORTDATA,ORTDEV,ORTCREAT,ORTSUB,ORTTYPE
 S (PR,PF,PAGE)=1,ORLOUT="",ORTIT=$S(TL="TA":"Team Patient Autolinked List",TL="TM":"Team Patient Manual List",TL="MRAL":"Team Patient Manual Removal/Autolinked List",1:"Personal Patient List"),ORTIT(1)=$P(ORLIST,U,2)
 S:$E(IOST,1,2)'="C-" ORSNUM=1 D HEADING K ORSNUM
 S ORTDATA=^OR(100.21,+ORLIST,0)                ; Get 0-node data.
 S ORTDEV=$P(ORTDATA,U,4)                       ; Assign "device."
 I ORTDEV'="" D                                 ; "Device" exist?
 . S ORTDEV=$$GET1^DIQ(3.5,+($G(ORTDEV)),.01)   ; Get device name.
 S ORTCREAT=$P(ORTDATA,U,5)                     ; Assign "creator."
 I ORTCREAT'="" D                               ; "Creator" exist?
 . S ORTCREAT=$P($G(^VA(200,ORTCREAT,0)),U)     ; Get creator's name.
 S ORTTYPE=$P(ORTDATA,U,2)                      ; Assign type.
 I ORTTYPE'="" D TYPESTR                        ; Full type string.
 S ORTSUB=""                                    ; Initialize.
 I TL["A" D                                     ; A/L type?
 . S ORTSUB=$P(ORTDATA,U,6)                     ; Assign "subcribe."
 . I ORTSUB="" S ORTSUB="NO"                    ; Default for no data.
 . I ORTSUB="Y" S ORTSUB="YES"                  ; Full word.
 ; Put in a blank line if no device, creator, type, or subscribe info:
 I (ORTDEV'="")!(ORTCREAT'="")!(ORTTYPE'="")!(ORTSUB'="") W !
 I ORTCREAT'="" W !,"       Creator: "_ORTCREAT ; Write creator line.
 I ORTDEV'="" W !,"        Device: "_ORTDEV     ; Write device line.
 I ORTTYPE'="" W !,"          Type: "_ORTTYPE   ; Write type line.
 I TL["A" W !,"  Subscribable: "_ORTSUB         ; Subscribe line.
 S ORI=0 F  S ORI=$O(^OR(100.21,+ORLIST,1,ORI)) Q:ORI<1  S USER=^(ORI,0) D
 . S ^TMP("ORLP",$J,"LIST","B",$P(^VA(200,+USER,0),"^"))=""
 D USER
 I TL["A",$O(^OR(100.21,+ORLIST,2,0)) S PR=1 D  D ALINK
 . N VP,OROK
 . S ORI=0 F  S ORI=$O(^OR(100.21,+ORLIST,2,ORI)) Q:'ORI  D
 .. S VP=^(ORI,0),VP(1)="^"_$P($P(VP,";",2),U),VP(2)=+VP I $L(VP,"^")=2 S VP(3)=$S($P(VP,U,2)="A":"Attending",$P(VP,U,2)="P":"Primary",1:"Primary or Attending")
 .. S OROK=0
 .. I VP(1)["DIC(42," S OROK=1,VPNM="Ward......."_$P(@(VP(1)_VP(2)_",0)"),U)
 .. I VP(1)["VA(200," S OROK=1,VPNM="Provider..."_$P(@(VP(1)_VP(2)_",0)"),U)_" - as "_VP(3)
 .. I VP(1)["DIC(45.7," S OROK=1,VPNM="Specialty.."_$P(@(VP(1)_VP(2)_",0)"),U)
 .. I VP(1)["DG(405.4," S OROK=1,VPNM="Room/Bed..."_$P(@(VP(1)_VP(2)_",0)"),U)
 .. I VP(1)["SC" S OROK=1,VPNM="Clinic....."_$P(@(VP(1)_VP(2)_",0)"),U)
 .. I 'OROK S VPNM="(Undetermined) - "_$P(@(VP(1)_VP(2)_",0)"),U)
 .. S ^TMP("ORLP",$J,"LIST","AL",VPNM)=""
 S ORI=0 F  S ORI=$O(^OR(100.21,+ORLIST,10,ORI)) Q:ORI<1  D
 . N VAERR,VAIN,DFN
 . S PAT=^OR(100.21,+ORLIST,10,ORI,0),DFN=+PAT,PAT=^DPT(DFN,0)
 . D INP^VADPT Q:VAERR  S WRD=$S(VAIN(4):$E($P(VAIN(4),U,2),1,10),1:"WD-none"),RMBED=$S(VAIN(5)]"":VAIN(5),1:"unassigned"),SSN=$E($P(PAT,U,9),6,9)_"0000",PATNM=$P(PAT,U)
 . I SORT="T" S ^TMP("ORLP",$J,"LIST","C","A"_$E(SSN,1,4),PATNM,WRD_": "_RMBED)="" Q
 . I SORT="R" S ^TMP("ORLP",$J,"LIST","C",WRD_": "_RMBED,PATNM,$E(SSN,1,4))="" Q
 . S ^TMP("ORLP",$J,"LIST","C",$P(PAT,"^"),$E(SSN,1,4),WRD_": "_RMBED)=""
 D PT
 I ORLOUT'["^" W !!?5,"List completed." D
 . I $E(IOST)="C" S DIR(0)="E" D ^DIR
 I $D(ZTQUEUED) S ZTREQ="@"
END ;called by INQ, flow thru from OUTPUT
 K ALINK,DIR,L,LINE,ORI,ORLOUT,ORTIT,PAGE,PAT,PATNM,PF,PR,PT,PTRB,PTSSN,RMBED,SSN,USER,VPNM,WRD,X1,X2,X3,Y,%ZIS,ZTDESC,ZTRTN,ZTSAVE
 K ^TMP("ORLP",$J,"LIST")
 Q
 ;
HEADING ;called by OUTPUT, USER, PT - build list heading & handle paging
 Q:ORLOUT["^"
 I $$S^%ZTLOAD S ORLOUT="^",ZTSTOP=1 Q
 I PAGE>1,($E(IOST)="C") S DIR(0)="E" D ^DIR I Y<1 S ORLOUT="^" Q
 W:'$D(ORSNUM) @IOF
 W !,$P($$HTE^XLFDT($H),"@"),?(IOM-$L(ORTIT)/2),ORTIT,?70,"page ",PAGE
 W !?(IOM-$L(ORTIT(1))/2),ORTIT(1) W !?(IOM-$L(ORTIT(1))/2)-2 F L=0:1 W "=" Q:L=($L(ORTIT(1))+4)
 S (PR,PF)=1,PAGE=PAGE+1
 Q
ALINK ;called by OUTPUT - build entries (autolinks)
 S ALINK=""  F  S ALINK=$O(^TMP("ORLP",$J,"LIST","AL",ALINK)) Q:ALINK=""  D
 . I $L(ALINK)'<1,($Y+2>IOSL) D HEADING Q:ORLOUT["^"
 . I PR=1 W !!,"     Autolinks: ",ALINK S PR=2
 . E  W !?16,ALINK
 Q
USER ;called by OUTPUT - build list entries (users)
 S USER="" F  S USER=$O(^TMP("ORLP",$J,"LIST","B",USER)) Q:USER=""  D
 . I $L(USER)'<1,($Y+2>IOSL) D HEADING Q:ORLOUT["^"
 . I PR=1 W !!,"Provider/users: ",USER S PR=2
 . E  W !?16,USER
 Q
PT ;called by OUTPUT - build list entries (patients)
 N DOTS,SPACE,WRDL
 S $P(DOTS,".",34)="",$P(SPACE," ",28)="",WRDL=""
 S X1="" F  S X1=$O(^TMP("ORLP",$J,"LIST","C",X1)) Q:X1=""  D
 . S X2="" F  S X2=$O(^TMP("ORLP",$J,"LIST","C",X1,X2)) Q:X2=""  D
 .. S X3="" F  S X3=$O(^TMP("ORLP",$J,"LIST","C",X1,X2,X3)) Q:X3=""  D
 ... ; sort="T" Terminal digit sort
 ... I SORT="T" S LINE="("_$E(X1,2,5)_")   "_$E(X2_DOTS,1,33)_"  "_$E(X3_SPACE,1,27) D PT1 Q
 ... ; sort="R" Room/Bed sort
 ... I SORT="R" D  D PT1 Q
 .... I PF=1 S LINE=$E(X1_SPACE,1,27)_"  "_$E(X2_DOTS,1,33)_"  ("_X3_")" Q
 .... I WRDL'=$P(X1,":") S LINE=$E(X1_SPACE,1,27)_"  "_$E(X2_DOTS,1,33)_"  ("_X3_")" Q
 .... S LINE=$E($E(SPACE,1,$L(WRDL)+1)_$P(X1,":",2)_SPACE,1,27)_"  "_$E(X2_DOTS,1,33)_"  ("_X3_")"
 ... ; else sort alpha by patient name
 ... S LINE=$E(X1_DOTS,1,33)_"("_X2_")   "_X3 D PT1
 Q
 ;
PT1 I $L(X1)'<1,($Y+3>IOSL) D HEADING Q:ORLOUT["^"
 I SORT="R" S WRDL=$P(X1,":") I PF=1 S LINE=$E(X1_SPACE,1,27)_"  "_$E(X2_DOTS,1,33)_"  ("_X3_")"
 I PF=1 W !!,"Patients: " S PF=2
 W !?3,LINE
 Q
TYPESTR ; Assign description strings to ORTTYPE (Team List type) variables.
 ; Tag by PKS - 8/99.
 ;
 I ORTTYPE="P" S ORTTYPE="PERSONAL"
 I ORTTYPE="TA" S ORTTYPE="AUTOLINK"
 I ORTTYPE="TM" S ORTTYPE="MANUAL"
 I ORTTYPE="MRAL" S ORTTYPE="MRAL"
 Q
