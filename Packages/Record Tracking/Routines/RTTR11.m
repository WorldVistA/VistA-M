RTTR11 ;ALB/PKE,JLU - THE SECOND HALF OF RTTR1 ; 3/6/91
 ;;v 2.0;Record Tracking;;10/22/91 
 ;
PY8 W $C(13),"| 8. TYPE OF TRANSFER   [",XMB(CT),"] Permanent  [",XMB(CT+1),"] Temporary",?$X+28,"|"
 Q
 ;
PY11 W $C(13),"| 11a. Transfer Claims Folder   [",XMB(CT),"] CL",?$X+41,"|"
 Q
PY13 W $C(13),"| [",XMB(CT),"] LG  [",XMB(CT+1),"] PG  [",XMB(CT+2),"] OPT  [",XMB(CT+3),"] REC  [",XMB(CT+4),"] CORRESP  [",XMB(CT+5),"] RAY",?$X+23,"|"
 Q
 ;
PY13A W !,"|",?79,"|",!,"|",?24,"COUNSELING/TRAINING",?79,"|"
 Q
 ;
PY13B W $C(13),"| [",XMB(CT+6),"] R&E  [",XMB(CT+7),"] INS  [",XMB(CT+8),"] SUBFOLDER  [",XMB(CT+9),"] (specify)",?$X+31,"|"
 Q
 ;
PY13C W !,"| Specify:",XMB(300)
 Q
 ;
PY13D W !,"| 13.  OTHER FOLDER TRANSFER",?$X+51,"|"
 W !,"|",?31,"MED",?40,"HOSP",?53,"X-",?79,"|"
 Q
 ;
PL14 W !,"| 14.  Reason for Transfer or Remarks",?79,"|"
 Q
 ;
PL14A I XMB(CT)="" W $C(13),"|    ",?$X+74,"|"
 E  W $C(13),"|    ",XMB(CT)
 Q
 ;
PL14B I XMB(CT+1)="" W $C(13),"|    ",?$X+74,"|"
 E  W $C(13),"|    ",XMB(CT+1)
 Q
 ;
PL15 W $C(13),"| 15.  Adjudication Action pending   [",XMB(CT),"] YES   [",XMB(CT+1),"] NO",?$X+27,"|"
 Q
 ;
Y7 S CT=9
 ;7 beneficary master record   NOT USED
 I RTVAR['7
 E  S DIR("A")="",DIR(0)="" D ^DIR K DIR I 0
 E  S XMB(CT)="X"
 ;
Y8 ;8 TYPE OF TRANSFER
 S CT=10 D LINE^RTUTL3
 ;A nothing added to prompt, B choices added
 S (RTV,DIR("A"))="| 8. TYPE OF TRANSFER   [ ] Permanent  [ ] Temporary  ? ",DIR("B")="T",DIR(0)="SOA^P:Permanent;T:Temporary"
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) Q
 S XMB(CT)=$S(Y="P":"X",1:"")
 S XMB(CT+1)=$S(Y="T":"X",1:"")
 D PY8
 Q:$D(RTKEY)
 ;
Y9 ;9 other file number   logic for not used fields
 S CT=11
 I RTVAR'[9
 E  S DIR("A")="9. Other File NO. ? ",DIR(0)="FOA^1:20" D ^DIR K DIR I 0
 E  S XMB(CT)=Y
 ;
Y11 ;11 TRANSFER CLAIMS FOLDER
 S CT=12 D LINE^RTUTL3
 S (RTV,DIR("A"))="| 11a. Transfer Claims Folder   [ ] CL  ? ",DIR("B")="NO",DIR(0)="YOA^"
 D ^DIR K DIR I $D(DUOUT)!($D(RTOUT)) Q
 S XMB(CT)=$S(Y=1:"X",1:" ")
 D PY11
 ;
Y11B ;11B Transfer DEA folder  not used
 S CT=13
 I RTVAR'[9
 E  S DIR("A")="| 11b. Transfer DEA folder  ?",DIR("B")="",DIR(0)="YOA^" D ^DIR K DIR I 0
 E  S XMB(CT)="X"
 ;
Y12 ;12A date of transfer, 12b rec station, 12c tranf station, 12 d paye no
 ;only appears after a transfer to
 ;S CT=14
 ;
Y13 ;13 other folder transfer
 S CT=21 D LINE^RTUTL3
 F Z=CT:1:CT+9 S XMB(CT)=" "
 D PY13D
 S DIR("A")="| [1] LG  [2] PG  [3] OPT  [4] REC  [5] CORRESP  [6] RAY  Number(s) "
 S DIR(0)="LOA^0:6" D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) Q
 F Z=1:1:6 S XMB(20+Z)=$S(Y[Z:"X",1:" ") ;hard set of 20 instead of CT
 D PY13,PY13A
 S DIR("A")="| [7] R&E  [8] INS  [9] SUBFOLDER  [10] (specify)  Number(s) "
 S DIR(0)="LOA^7:10" D ^DIR I $D(DUOUT)!($D(DTOUT)) Q
 F Z=7:1:10 S XMB(20+Z)=$S(Y[Z:"X",1:" ") ;hard set 20
 S XMB(300)=""
 D PY13B
 I XMB(30)="X" K DIR S DIR("A")="| Specify:",DIR(0)="FOA^1:30" D ^DIR S XMB(300)=Y
 S CT=1 D PT^RTTR1
 S CT=2 D PN^RTTR1
 S CT=5 D PN1^RTTR1,PN2^RTTR1
 S CT=6 D PY5^RTTR1
 S CT=8 D PY6^RTTR1
 S CT=10 D LINE^RTUTL3 W ! D PY8
 S CT=12 D LINE^RTUTL3 W ! D PY11
 S CT=21 D LINE^RTUTL3,PY13D W ! D PY13,PY13A W ! D PY13B,PY13C
 ;
L14 ;14 reason transfer/or remarks
 S CT=31
 D LINE^RTUTL3,PL14
 S DIR("A")="|    ",DIR(0)="FOA^1:70" D ^DIR I $D(DUOUT)!($D(DTOUT)) Q
 S XMB(CT)=Y K Y
 D PL14A
 I X'="" S DIR("A")="|    " D ^DIR I $D(DUOUT)!($D(DTOUT)) Q
 S XMB(CT+1)=$S($D(Y):Y,1:"")
 D PL14B K DIR
 I $D(RTKEY) Q
L15 ;15 ajudication action pending ?
 S CT=33
 D LINE^RTUTL3
 S DIR("A")="| 15.  Adjudication Action pending   [Y] YES   [N] NO  ? ",DIR("B")="NO",DIR(0)="YOA^"
 D ^DIR I $D(DUOUT)!($D(DTOUT)) Q
 S XMB(CT)=$S(Y=1:"X",1:"")
 S XMB(CT+1)=$S('Y:"X",1:"")
 D PL15
 K DIR
 Q
