RMPOLG ;HIN-CIOFO/RVD - HOME OXYGEN LETTERS (MANAGE LETTER) ;7/24/98
 ;;3.0;PROSTHETICS;**29,46**;Feb 09, 1996
EN ; -- main entry point for manage letter list.
 ; Input:
 ;   RMPOLCD              - Selected Home Oxygen Letter code
 ; Called by:
 ;   RMPOLZ               - H.O. Letter Control module
 D EN^VALM("RMPO MANAGE LETTER")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$$CNTR^RMPOLY(" ",$$EXTERNAL^DILFD(669.965,1,"",RMPOLCD),80)
 S VALMHDR(2)=$$CNTR^RMPOLY(" ","HOME OXYGEN PATIENT LETTER LIST",80)
 Q
 ;
INIT ; -- init variables and list array
 N RMPODFN,REC,RMPOITEM,Y,X,SP
 ;
 ; for each entry in list for the selected letter type display details
 S RMPONAM="",VALMCNT=0,$P(SP," ",80)=" "
 F  S RMPONAM=$O(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)) Q:RMPONAM=""  D
 . S RMPODFN=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,2)
 . S REC=^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN),VALMCNT=VALMCNT+1
 . S Y=$P(REC,U,3) D DD^%DT S RMPORX=Y,Y=$P(REC,U,4)
 . I Y'="" D DD^%DT
 . I Y="" S Y="No Rx!"
 . S RMPOEXP=Y,RMPOITEM=$P(REC,U,5)
 . S:RMPOITEM="" RMPOITEM="No Primary!"
 . ;
 . S X=$$SETFLD^VALM1($E(VALMCNT_SP,1,$P(VALMDDF("LINE #"),U,3)),"","LINE #")
 . S X=$$SETFLD^VALM1($P($P(REC,U),","),X,"PATIENT")
 . S X=$$SETFLD^VALM1($P(REC,U,2),X,"SSN")
 . S X=$$SETFLD^VALM1(RMPOITEM,X,"PRIMARY ITEM")
 . S X=$$SETFLD^VALM1(RMPORX,X,"ACTIVATION DATE")
 . S X=$$SETFLD^VALM1(RMPOEXP,X,"Rx EXPIRY DATE")
 . D SET^VALM10(VALMCNT,X,RMPODFN)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 Q
 ;
EN02 ; Delete list entry and code deleted in #665
 N SEL,LINE
 ; Select lines to delete
 S SEL=$$SELN^RMPOLZA("L","Enter lines to delete",VALMCNT)
 I SEL="^" S ^TMP($J,RMPOXITE,"EXIT")=1 Q  ; quit to menu
 Q:'SEL
 N CNT
 ; for each patient selected remove 'Letter to be sent' from
 ; Prosthetics Patient File (665)
 F CNT=1:1 S LINE=$P(SEL,",",CNT) Q:LINE=""  D
 . S RMPODFN=$O(@VALMAR@("IDX",LINE,""))
 . S RMPONAM=$P(^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN),U,1)
 . S RMPONAM=$E(RMPONAM,1,15)
 . D UPDLTR^RMPOLZA(RMPODFN,"@")
 . ; purge work file holding data
 . K ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN)
 . Q:'$D(RMPOLCD)
 . I RMPOLCD="A" D
 . . S $P(^RMPR(665,RMPODFN,"RMPOA"),U,09)=DT,$P(^RMPR(665,RMPODFN,"RMPOA"),U,10)="D"
 . . S RMDBAT="RMPOXBAT1"
 . I RMPOLCD="B" D
 . . S $P(^RMPR(665,RMPODFN,"RMPOA"),U,11)=DT,$P(^RMPR(665,RMPODFN,"RMPOA"),U,12)="D"
 . . S RMDBAT="RMPOXBAT2"
 . I RMPOLCD="C" D
 . . S $P(^RMPR(665,RMPODFN,"RMPOA"),U,13)=DT,$P(^RMPR(665,RMPODFN,"RMPOA"),U,14)="D"
 . . S RMDBAT="RMPOXBAT3"
 . S DA=$O(^RMPR(669.9,RMPOXITE,RMDBAT,"B",RMPODFN,0))
 . S DIK="^RMPR(669.9,"_RMPOXITE_",",DA(1)=RMPOXITE
 . S DIK=DIK_""""_RMDBAT_""""_"," D ^DIK
 K DIK,DA
 ;
 G AMEND
 ;
ADD ; Add patient to the list entry.
 D FULL^VALM1 W @IOF
 K DIC,RMPODFN
 S DIC("S")="I '$D(^TMP($J,RMPOXITE,""RMPODEMO"",+Y)),$D(^RMPR(665,+Y,""RMPOA"")),$P(^(""RMPOA""),U,3)="""",$P(^(0),U,2)=RMPOSITE"
DIC S DIC="^RMPR(665,",DIC(0)="EAMQN" D ^DIC I Y<0 G AMEND
 S RMPORX=$P($G(^RMPR(665,+Y,"RMPOB",0)),U,3) G:'$G(RMPORX) DIC
 I $G(RMPORX),'$D(^RMPR(665,+Y,"RMPOB",RMPORX,0)) W !,"Patient has no current prescription!!" G DIC
 S RMDEXP=$P(^RMPR(665,+Y,"RMPOB",RMPORX,0),U,3)
 I RMPORX,RMDEXP,RMDEXP<DT W !,"Rx prescription has expired - Unable to ADD patient to the list !!",! G DIC
 S RMPODFN=+Y,ADT=$P($G(^RMPR(665,+Y,"RMPOA")),U,2)
 ;
GETPAT ;get patient information(demographics)
 D EXTRCT^RMPOLZA
 S RMPONAM=$P(^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN),U,1)
 ;S RMI="",RMPOLTR=0 F  S RMI=$O(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMI)) Q:RMI=""  S RMPOLTR=$P(^(RMI),U,1)
 S RMCOD=$S(RMPOLCD="A":"RMPOXBAT1",RMPOLCD="B":"RMPOXBAT2",RMPOLCD="C":"RMPOXBAT3",1:"")
 ;add the code to delete the entry in 665 for P and D entries and the dates.
 Q:$D(^RMPR(669.9,RMPOXITE,RMCOD,"B",RMPODFN))
 K DD,DO S DA(1)=RMPOXITE,DIC="^RMPR(669.9,"_RMPOXITE_","_""""_RMCOD_""""_","
 S DIC(0)="L",X=RMPODFN,DLAYGO=669.9 D FILE^DICN
 I '$D(DA) W !,"Patient was not added!!!" Q
 S RMPOLTR=$G(LTRX("C",RMPOLCD))
 S ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)=RMPOLTR_"^"_RMPODFN_"^"_DA
 K DIC,DA,X
 ;
AMEND ; delete listman data and rebuild list from amended work file
 D CLEAN^VALM10,INIT
 Q:'$D(@VALMAR)  ; Quit if there are no entries in list
 S VALMBCK="R"
 Q
