YSCUP ;DALISC/LJA -  MH Patient Movement Driver ;9/12/94 12:04
 ;;5.01;MENTAL HEALTH;**2,11,20,29**;Dec 30, 1994
 ;
 QUIT
 ;
BEGIN ;  Called by [YS PATIENT MOVEMENT] Protocol in [DG MOVEMENT EVENTS]
 ;  Called by RERUN^YSCUP, also...  (An undocumented call point)
 ;
 ;D TRACE
 ;
 I '$G(DGQUIET) W !,"MAS Patient Movement - Activating Mental Health Update"
 I $P($G(^YSA(602,1,0)),U,6)="Y" D
 .  S ZTRTN="CTRL^YSCUP000"
 .  S ZTDTH=$HOROLOG
 .  ;
 .  ;VARIABLES TO BE SAVED IN ZTSAVE
 .  S ZTSAVE("*")=""
 .  ;
 .  S ZTDESC="MENTAL HEALTH - YS PAT MOVEMENT"
 .  S ZTIO=""
 .  D ^%ZTLOAD
 I $P($G(^YSA(602,1,0)),U,6)="Y" D  QUIT
 .  I '$G(DGQUIET) W !!,"The Mental Health Update has been Tasked, job# ",ZTSK,"...",!
 ;
 I '$G(DGQUIET) W !!,"Starting Mental Health Update..."
 D CTRL^YSCUP000
 D END
 I '$G(DGQUIET) D
 .  W:$X>(IOM-10) ! W "  done..."
 QUIT
 ;
END ;
 ;Kill variables at end of updating
 K %,%X,%Y,A,ARR,ARR1,DA,DIC,DIE,DIK,DIR,DLAYGO,DR,END,I,LP
 K MH0,MH7,MHIEN,MHNO,MOVE,MOVNO,MT,NO,NODE,P,TA,TIEN,TP
 K VAIP,WIEN,WN,X,X1,X2,Y
 K YS0,YS5,YS7,YSACTS,YSAMH,YSAMV,YSBEDT,YSC,YSDFN,YSDT,YSEND
 K YSFEDT,YSFMTMH,YSIEN,YSLADM,YSLAST,YSLMHA,YSLMOMH
 K YSLP,YSLR,YSLTRSF,YSMH,YSMHAN,YSMHDT,YSMHMOV
 K YSMOVES,YSMOVN,YSMOVOK,YSMT,YSMV,YSNM,YSNMH,YSNO,YSNOW,YSOK,YSPM,YSPMA
 K YSPMT,YSPURDT,YST,YSTRIP,YSVDT,YSX,YSXEC,YSXTMP,YSY
 KILL ^TMP("YSMH",$J),^TMP("YSPM",$J)
 QUIT
 ;
TRACE ;
 ;S X1=DT,X2=7 D C^%DTC S PURGEDT=X
 ;S ^XTMP("MHINP",$J)=PURGEDT_U_$G(DFN)_U_"***"_U_DGPMA
 ;QUIT
 ;
RERUN ;
 I '$G(DGQUIET) W !!,"This utility will evaluate and correct the inpatient status of a patient...",!
 D END
R1 K DA,DIC,Y,YSDFN
 S DIC(0)="AEMQ",DIC=2,DIC("A")="Select Patient: "
 D ^DIC
 QUIT:+Y'>0  ;->
 S YSDFN=+Y
 D CHKMOV^YSCUP000
 D END
 I '$G(DGQUIET) W !
 S DIR(0)="EA",DIR("A")="Press RETURN to continue, or '^' to exit..."
 D ^DIR
 KILL DIR
 QUIT:X[U  ;->
 G R1 ;->
 ;
RTNS ;  List of routines used by YSCUP
 ;
 ;YSCUP       Call point by DGPM MOVEMENT EVENTS protocol.
 ;YSCUP003    Gets MH Movements into ^TMP("YSMH",$J,.
 ;            Gets Movements into ^TMP("YSPM",$J, via ^VADPT calls.
 ;            Establishes matches between ^TMP("YSPM",$J, and ^TMP("YSMH",$J,.
 ;YSCUP001    Updates MH Inpt entry data.
 ;YSCUP000    Master logic which establishes variables, 
 ;            determines where to call, etc.
 ;YSCUP004    Creates, deletes ^XTMP data.
 ;YSCUP002    Adds new MH Inpt entries using ^TMP("YSPM",$J, data.
 ;            Deletes MH Inpt entries.
 QUIT
 ;
CALLS ;  Undocumented and unsupported "internal use" calls...
 ;  (These calls are NOT used by package!!)
 ;
 ;  RERUN^YSCUP      Resubmits patient for update.
 ;  SHOWPT^YSCUP004  Show all XTMP data for one patient
 ;
 QUIT
 ;
VARDOC ;  Documentation of variable structures
 ;
 ;  YSLADM = Last Admit in YSMP( array format
 ;  YSLTRSF = Last Transfer in ^TMP("YSPM",$J, array format
 ;  YSMH = Admission IEN responsible for current MH Inpt entry.
 ;
 ;  ------- Below, # = 999-Sequential number of MH Inpt Entry -------
 ;  -------------- contained in the YSMH array ------------------
 ;  ^TMP("YSMH",$J,#,0) = MH Inpt IEN ~ Node 0  (Ie., ^YSG("INP",MH Inpt IEN,0))
 ;  ^TMP("YSMH",$J,#,7) = Node 7 (Ie., ^YSG("INP",MH Inpt IEN,7)
 ;  ^TMP("YSMH",$J,"M",Admission IEN of MH Inpt entry) = # ^ MH Inpt IEN
 ;  -----------------------------------------------------------------
 ;
 ;  YSMHMOV = 0 ->
 ;            1 ->
 ;
 ;  YSMOVES = p(3) of last ^YSG("INP",ien,7) found...
 ;            Note: if = 328~328, it is changed to 328.
 ;                  if = 328~395, it is left.
 ;
 ;  YSMV = IEN of last YSPM movement found...
 ;  YSNM = Number of movements found and contained in ^TMP("YSPM",$J,#)...
 ;  YSNMH = Number of MH Inpt entries found and in ^TMP("YSMH",$J,#,0-7)...
 ;
 ;  ------- Below, # = 999-Sequential number of Movement  -------
 ;  -------------- contained in the YSPM array ------------------
 ;  ^TMP("YSPM",$J,#) = MH Move? (0/1) ^ Ward IEN ^ Default Team IEN ^ Move Type (1-3) ^ Move IEN ^ D/T of movement
 ;
 ;  ^TMP("YSPM",$J,"M",Movement IEN) = # ^ Admit DT
 ;  -----------------------------------------------------------------
 ;
 ;  YST = 5 pieces as explained below...  (All answers are 0 or 1)
 ;        p(1) = Does any ^TMP("YSMH",$J, data exist for patient? 
 ;        p(2) = Is there any Movement data in ^TMP("YSPM",$J,? ... which is found via ^VADPT calls.
 ;        p(3) = Any MH moves in ^TMP("YSPM",$J, movement data?
 ;        p(4) = Does +^TMP("YSMH",$J,"M",Admit IEN) = +$O(^TMP("YSPM",$J,"M",0))?   See var explanation above.
 ;        p(5) = Are there any MH wards in the ^UTILITY("DGPM" data.  (Usually, not viewed...)
 ;        p(6) = Does any ^YSG("INP" data exist for patient?
 ;
 ; ------------------------- Sample data ------------------------------
 ; YSMH=328
 ; ^TMP("YSMH",$J,997,0)=2~2940829.1013^5^2940829.092857^3
 ; ^TMP("YSMH",$J,997,7)=7^2940829.092857^328~328^
 ; ^TMP("YSMH",$J,998,0)=1~2940829.0929^5^2940829.092857^3
 ; ^TMP("YSMH",$J,998,7)=7^2940829.10124^328~332^
 ; ^TMP("YSMH",$J,"M",328)=997^2
 ; YSMHMOV=0
 ; YSMOVES=328
 ; YSMV=328
 ; YSNM=4
 ; YSNMH=2
 ; ^TMP("YSPM",$J,995)=0^10^^3^332^2940829.10124
 ; ^TMP("YSPM",$J,996)=0^10^^2^331^2940829.094158
 ; ^TMP("YSPM",$J,997)=1^1^1^2^330^2940829.093201
 ; ^TMP("YSPM",$J,998)=1^7^3^1^328^2940829.092857
 ; ^TMP("YSPM",$J,"M",328)=998
 ; YST=1^1^0^1^0
 QUIT
 ;
EOR ;YSCUP - MH Patient Movement Driver ;9/12/94 12:04
