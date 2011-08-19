RMPOLY ;EDS/PAK - HOME OXYGEN LETTERS ;7/24/98
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
 ;
EN ; -- main entry point for RMPO LETTER TYPE
 ;
 ; Input: None
 ;
 ; Output:
 ;   RMPOLCD              -  H.O. Letter Type code
 ;
 ; Called by:
 ;   RMPOLZ               - H.O. Letter Control module
 ;
 N LSTN
 ;
 D EN^VALM("RMPO LETTER TYPE")
 Q
 ;
HDR ; -- header code
 ;
 S VALMHDR(1)=$$CNTR(" ",RMPO("NAME"),80)
 S VALMHDR(2)=$$CNTR(" ","HOME OXYGEN PATIENT LETTER TYPE LIST",80)
 Q
 ;
INIT ; -- init variables and list array
 N SP,RMPOLCD,CNT,X,RMPOLTR,LTR
 ;
 S $P(SP," ",80)=" "
 ;
 ; initialise list
 S (PATV,VALMCNT,RMPOLCD,CNT)=0
 ; for each valid H.O. letter type code define a line
 F  S RMPOLCD=$O(LTRX("A",RMPOLCD)) Q:RMPOLCD=""  D
 . S VALMCNT=VALMCNT+1,LSTN(VALMCNT)=RMPOLCD
 . S CNT=0,RMPONAM=""
 . F  S RMPONAM=$O(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)) Q:RMPONAM=""  D
 . . S CNT=CNT+1
 . . S RMPOLTR=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,1),RMPODFN=$P(^(RMPONAM),U,2)
 . . S LTR=$P(^RMPR(665.2,RMPOLTR,0),U)
 . . D UPDLTR^RMPOLET0(RMPODFN,LTR)  ; update "letter to be sent" flag for patient
 . ;
 . S X=$$SETFLD^VALM1($E(VALMCNT_SP,1,$P(VALMDDF("LINE #"),U,3)),"","LINE #")
 . S X=$$SETFLD^VALM1($$EXTERNAL^DILFD(669.965,1,"",RMPOLCD),X,"DESCRIPTION")
 . S X=$$SETFLD^VALM1(CNT,X,"PATIENT COUNT")
 . D SET^VALM10(VALMCNT,X,CNT)  ; create list line
 . S:CNT PATV=1  ; at least one line have a patient count value > 0
 ;
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 K LSTN,PATV
 ;
 Q
 ;
EXPND ; -- expand code
 Q
 ;
EN01 ; Select letter type
 N Y
 S VALMBCK="R",LST=0
 ;I 'PATV S VALMSG="There are no patients awaiting a letter" Q
 S Y=$$SELN^RMPOLZA("N","Select letter type line #",VALMCNT) Q:'Y
 I $G(^TMP($J,RMPOXITE,"EXIT"))=1 S QT=1 Q
 S VALMBCK="Q"
 S (RMPOLCD,RMC)=LSTN(Y)
 S RMBAT=$S(RMC="A":"RMPOXBAT1",RMC="B":"RMPOXBAT2",RMC="C":"RMPOXBAT3",1:"")
 S RMBATCO=$S(RMC="A":"^669.9002P^^",RMC="B":"^669.972P^^",RMC="C":"^669.974P^^^",1:"")
 ;K ^RMPR(669.9,RMPOXITE,RMBAT) S ^RMPR(669.9,RMPOXITE,RMBAT,0)=RMBATCO 
 D NEWLST^RMPOLZ
 I $O(^RMPR(669.9,RMPOXITE,RMBAT,0))'>0 S VALMSG="No patients are awaiting letters of this type!!" H 4 W !,VALMSG Q
 W !,"DONE GENERATING A NEW LIST..." H 4
 ; rebuild letter type list.
 D CLEAN^VALM10,INIT^RMPOLY S VALMBCK="R",RMPOLCD=""
 Q
 ;
EN02 ; Print letters
 ; select letter type. Quit if none choosen
 ;D EN01^RMPOLY S VALMBCK="R" Q:RMPOLCD=""
 N Y
 S VALMBCK="R"
 I 'PATV S VALMSG="There are no patients awaiting a letter" Q
 ;
 S Y=$$SELN^RMPOLZA("N","Select letter type line #",VALMCNT) Q:'Y
 W !,$C(7),"Processing...."
 I '$O(@VALMAR@("IDX",Y,"")) S VALMSG="No patients are awaiting letters of this type!!" H 4 W !,VALMSG Q
 S VALMBCK="Q",RMPOLCD=LSTN(Y)
 ;ask for patient to print
 D EN^RMPOLT
 ; rebuild letter type list.
 D CLEAN^VALM10,INIT^RMPOLY S VALMBCK="R",RMPOLCD=""
 Q
 ;
CNTR(PD,TXT,WDT) ; Centre text
 S $P(PD,PD,WDT)=PD
 Q $E(PD,1,(WDT-$L(TXT))/2)_TXT
