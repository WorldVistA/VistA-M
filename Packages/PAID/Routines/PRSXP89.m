PRSXP89 ;WCIOFO/MGD-Report for Central PAID for PL 108-170 ;03/22/2004
 ;;4.0;PAID;**89**;Sep 21, 1995
 ;;This routine is not a part of the VistA PAID/ETA v 4.0 software.
 ;
 Q
 ;
 ; This program will review the TIME & ATTENDANCE RECORDS (#458) file
 ; from 12/6/2003 through 1/10/2004 looking for employees who were
 ; eligible for Saturday Premium under the newly passed Public
 ; Law 108-170 and who worked a tour of duty that would entitle them
 ; to Saturday Premium pay.  A report will be generated for each employee
 ; meeting this criteria.  This report will be delivered to the Central
 ; PAID group so they can determine if any back pay is due the employee.
 ;
START ; Define variables
 ;
 N CNT,DATA,DATA0,DATA8,DATA9,DAY,DB,DFN,DTE,EMP,EMPCNT,FLSA,GRD,GS
 N I,INT,J,K,L3,L4,LCNT,LINE1,LINE2,NH,OCC,PDT,PP,PPE,PPI,PPI9,PG,PREM
 N QT,RPT,SAL,SAT,SEG,SSN,STAT,STEP,TC,TL,TOT,U,WRK,Y3,Y31,Y4
 K ^TMP($J,"P89")
 S LCNT=1,$P(LINE1,"-",79)="-",$P(LINE2,"=",79)="=",U="^",(PG,QT)=0
 S RPT=1
 D OCC
 ;
PP ; Loop through Pay Period 03-24 - 03-26
 ;
 F I=24:1:26 D
 . S PPE="03-"_I
 . S PPI=$O(^PRST(458,"B",PPE,0))
 . Q:'PPI
 . Q:'$D(^PRST(458,PPI,0))
 . S PPI9=$O(^PRST(459,"B",PPE,0))
 . W !,LINE2
 . W !,"= Pay Period ",PPE,?78,"="
 . W !,LINE2
 . D PPHDR
 . ;
EMP . ;Loop through employees
 . ;
 . S (DFN,EMP,EMPCNT)=0
 . F  S EMP=$O(^PRST(458,PPI,"E",EMP)) Q:'EMP  D
 . . S DATA0=$G(^PRSPC(EMP,0))
 . . Q:DATA0=""!(DATA0?1"^"."^")
 . . S OCC=$P(DATA0,U,17)
 . . Q:OCC=""  ; Quit if no OCC code
 . . Q:'$D(^TMP($J,"P89","OCC",OCC))  ; Quit if not eligible for Sat Prem
 . . S INT=$S($P(DATA0,U,10)=3:1,1:0)
 . . S WRK=0
 . . D DAY ; Check for work on Saturdays
 . . Q:'WRK
 . . I $X>78 W !  ; Show patch is working
 . . W "."
 . . S DFN=EMP ; DFN is needed for call to S1^PRSADP1
 . . ; Load employee info from #459 or #450 for header. Load 8B from #458
 . . S DATA9=$S(PPI9'="":$G(^PRST(459,PPI9,"P",EMP,0)),1:"")
 . . S DATA8=$G(^PRST(458,PPI,"E",EMP,5))
 . . S SAL=$P(DATA9,U,14) I SAL="" S SAL="*"_$P(DATA0,U,29)
 . . S SSN=$P(DATA9,U,2) I SSN="" S SSN=$P(DATA0,U,9)
 . . S SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 . . S PP=$P(DATA9,U,3) I PP="" S PP="*"_$P(DATA0,U,21)
 . . S DB=$P(DATA9,U,6) I DB="" S DB="*"_$P(DATA0,U,10)
 . . S NH=$P(DATA9,U,7) I NH="" S NH="*"_$P(DATA0,U,16)
 . . S TL=$P(DATA9,U,13) I TL="" S TL="*"_$P(DATA0,U,8)
 . . S FLSA="*"_$P(DATA0,U,12)
 . . S PREM=$P($G(^PRSPC(EMP,"PREMIUM")),U,6)
 . . I PREM'="" S PREM="*"_PREM
 . . S GRD=$P(DATA9,U,4) I GRD="" S GRD="*"_$P(DATA0,U,14)
 . . S STEP=$P(DATA9,U,5) I STEP="" S STEP="*"_$P(DATA0,U,39)
 . . S GS=GRD_"/"_STEP
 . . D HDR ; Employee header
 . . D DIS ; Employee timecard
 . . S EMPCNT=EMPCNT+1
 . D SETX
 . S DATA=LINE2 D SET
 . W !!,DATA
 . S DATA="= Total Employees reported for PP "_PPE_" : "_EMPCNT
 . W !,DATA,?78,"="
 . S $E(DATA,68,73)="RPT #"_RPT,$E(DATA,79)="="
 . D SET
 . S DATA=LINE2 D SET
 . W !,DATA
 . D SETX,SETX
 . W !!
 D XMT
 K ^TMP($J,"P89")
 Q
 ;
 ;====================================================================
 ; Check for any work on either Saturday
DAY F SAT=7,14 D  Q:WRK
 . ; Check for a scheduled tour on a Saturday.
 . I $P($G(^PRST(458,PPI,"E",EMP,"D",SAT,0)),U,2)>2 S WRK=1 Q
 . ; Check exceptions for RG, CT, OT or HW
 . F SEG=3:4:28 D  Q:WRK
 . . S TOT=$P($G(^PRST(458,PPI,"E",EMP,"D",SAT,2)),U,SEG)
 . . Q:TOT=""
 . . I "CTHWOTRG"[TOT S WRK=1
 Q
 ;
PPHDR ; Pay Period header
 S DATA=LINE2
 D SET
 S DATA="= Pay Period "_PPE,$E(DATA,68,73)="RPT #"_RPT,$E(DATA,79)="="
 D SET
 S DATA=LINE2
 D SET,SETX
 Q
 ;
 ;====================================================================
HDR ; Display Header
 ; LINE 1
 S DATA=$P(DATA0,U,1),$E(DATA,32)=" "
 S DATA=DATA_SSN
 S $E(DATA,50)=" ",DATA=DATA_"T&L: "_TL
 S $E(DATA,61)=" ",DATA=DATA_"OCC: "_OCC
 D SET
 ; LINE 2
 S DATA="Sal: "_SAL,$E(DATA,18)=" "
 S DATA=DATA_"PP: "_PP,$E(DATA,27)=" "
 S DATA=DATA_"DB: "_DB,$E(DATA,36)=" "
 S DATA=DATA_"NH: "_NH,$E(DATA,46)=" "
 S DATA=DATA_"FLSA: "_FLSA,$E(DATA,58)=" "
 S DATA=DATA_"PPI: "_PREM
 S $E(DATA,67)=" ",DATA=DATA_"G/S: "_GS
 D SET,SETX
 Q
 ;
 ;====================================================================
DIS ; Display 14 days
 ;
 S PDT=$G(^PRST(458,PPI,2)),STAT=$P($G(^PRST(458,PPI,"E",EMP,0)),"^",2)
 S DATA="       Date          Scheduled Tour           Tour Exceptions"
 D SET
 S DATA=LINE1
 S $E(DATA,1,3)="   "
 D SET
 F DAY=1:1:14 S DTE=$P(PDT,"^",DAY) D
F0 . ; Display Frames
 . K Y1,Y2 S Y1=$G(^PRST(458,PPI,"E",DFN,"D",DAY,1)),Y2=$G(^(2)),Y3=$G(^(3)),Y4=$G(^(4)),TC=$P($G(^(0)),"^",2)
 . I Y1="" S Y1=$S(TC=1:"Day Off",TC=2:"Day Tour",TC=3!(TC=4):"Intermittent",1:"")
 . I " 1 3 4 "'[TC,$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,10)),"^",1)="" S Y2(1)="Unposted"
 . I TC=3,$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,10)),"^",4)=1 S Y2(1)="Day Worked"
 . S DATA="   "_DTE
 . S (L3,L4)=0
 . I Y1="",Y2="" S Y31="" Q
 . D S1^PRSADP1
 . F K=1:1 Q:'$D(Y1(K))&'$D(Y2(K))  D
 . . ; Don't repeat the Date and Tour for days w/ multiple lines
 . . I K>1 S DATA="",$E(DATA,45)=" "
 . . I $D(Y1(K)) D
 . . . S $E(DATA,21)=" "
 . . . S DATA=DATA_Y1(K)
 . . I $D(Y2(K)) D
 . . . S $E(DATA,45)=" "
 . . . S DATA=DATA_$P(Y2(K),U,1)
 . . . S $E(DATA,63)=" "
 . . . S DATA=DATA_$P(Y2(K),U,2)
 . . D SET
 . . I Y3'="" S DATA="          "_Y3 D SET
 D SETX
 S DATA="   8B: "_DATA8
 D SET,SETX
 S DATA=LINE1
 D SET,SETX
 I LCNT>1000 D XMT,PPHDR
 Q
 ;
 ;====================================================================
SET S ^TMP($J,"P89","DATA",LCNT)=DATA,LCNT=LCNT+1
 Q
 ;
 ;====================================================================
SETX S ^TMP($J,"P89","DATA",LCNT)="",LCNT=LCNT+1
 Q
 ;
 ;====================================================================
XMT ; Send TOD information via mail message
 I $D(^TMP($J,"P89","DATA")) D
 . K DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 . N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 . S XMSUB="PRS*4.0*89 Saturday Premium Report # "_RPT
 . S XMDUZ=.5
 . S XMTEXT="^TMP($J,""P89"",""DATA"","
 . S XMY(DUZ)=""
 . D ^XMD
 . K ^TMP($J,"P89","DATA")
 . S LCNT=1,RPT=RPT+1
 Q
 ;
 ;====================================================================
OCC ; Set valid OCC codes into ^TMP($J,"P89"
 ;
 F J="02","03","04","05","07",11,25,26,85,86,87,92,96,97,98 D
 . S ^TMP($J,"P89","OCC","0180"_J)=""  ; PSYCHOLOGISTS
 ;
 F J="02","03","04","05",51,57,58,59,61,62,63,71 D
 . S ^TMP($J,"P89","OCC","0185"_J)=""  ; SOCIAL WORKER
 ;
 S ^TMP($J,"P89","OCC","060113")=""    ; NUCLEAR MEDICINE
 ;
 F J=18,20,59,61 D
 . S ^TMP($J,"P89","OCC","0630"_J)=""  ; DIETITIAN
 ;
 S ^TMP($J,"P89","OCC","063502")=""    ; CORRECTIVE THERAPIST
 ;
 F J=15:1:18 D
 . S ^TMP($J,"P89","OCC","0636"_J)=""  ; THERAPY ASSISTANTS
 ;
 F J="02","03","05" D
 . S ^TMP($J,"P89","OCC","0644"_J)=""  ; MEDICAL TECHNOLOGIST
 ;
 F J=11:1:17 D
 . S ^TMP($J,"P89","OCC","0647"_J)=""  ; DIAGNOSTIC RADIOLOGIC
 ;
 F J=14:1:17 D
 . S ^TMP($J,"P89","OCC","0648"_J)=""  ; THERAPEUTIC RADIOLOGIC
 ;
 F J=15:1:19,21:1:25,27,28 D
 . S ^TMP($J,"P89","OCC","0649"_J)=""  ; MEDICAL INSTRUMENT TECHNICIAN
 ;
 F J="03","04","06","07","08","09" D
 . S ^TMP($J,"P89","OCC","0661"_J)=""  ; PHARMACY AID/TECHNICIAN
 ;
 F J="02","05","08",12,15,18,65,68,75,82 D
 . S ^TMP($J,"P89","OCC","0665"_J)=""  ; AUDIOLOGIST/SPEECH
 ;
 F J="02",12,22 D
 . S ^TMP($J,"P89","OCC","0667"_J)=""  ; ORTHOTISTS
 ;
 F J="03","04","05" D
 . S ^TMP($J,"P89","OCC","0669"_J)=""  ; MEDICAL RECORDS ADMINSTRATION
 ;
 F J="05","06" D
 . S ^TMP($J,"P89","OCC","0672"_J)=""  ; PROSTHETIC
 ;
 F J="01","02","04","05","06","08","09" D
 . S ^TMP($J,"P89","OCC","0675"_J)=""  ; MEDICAL RECORDS TECHNICIAN
 ;
 F J="03","04","05","06","07","09",42,45,48 D
 . S ^TMP($J,"P89","OCC","0681"_J)=""  ; DENTAL ASSISTANT
 ;
 S ^TMP($J,"P89","OCC","068202")=""    ; DENTAL HYGIENIST
 ;
 F J="02","03","04" D
 . S ^TMP($J,"P89","OCC","0858"_J)=""  ; BIOMEDICAL ENGINEER
 ;
 Q
