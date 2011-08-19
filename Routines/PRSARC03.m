PRSARC03 ;WOIFO/JAH - Recess Tracking Functions ;10/25/06
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
NEWSTART(OUT,PRSDT) ; change alternate work schedule start date.
 ;
 N FD,LD,ALLFY,GOOD,LINE,LISTI
 S OUT=0
 S FD=$P(PRSFYRNG,U,1)
 S LD=$P(PRSFYRNG,U,2)
 S ALLFY=$$ALLFYAWS^PRSARC04()
 I ALLFY<0 S OUT=1 Q
 I ALLFY=1 D
 .    S PRSDT=$P(PRSFY,U,5)
 E  D
 .    S PRSDT=$$AWSTART(FD,LD,"Enter Date 9 mo. AWS begins")
 .    I PRSDT'>0 S OUT=1
 Q:OUT
 ; convert start to 1st day of pp and 
 ; update the PRSFY var with new start date info
 N D1,DAY S D1=PRSDT D PP^PRSAPPU
 I DAY'=1 N X1,X2,X,%H S X1=D1,X2=-(DAY-1) D C^%DTC S PRSDT=X
 S $P(PRSFY,U,12)=PPE
 S $P(PRSFY,U,10)=$E(PRSDT,4,5)_"/"_$E(PRSDT,6,7)_"/"_$E(PRSDT,2,3)
 S $P(PRSFY,U,11)=PRSDT
 ;
 ;
 S PRSFSCYR=$$GETFSCYR^PRSARC04(PRSDT)
 I PRSDT<2006 S OUT=1
 ;
 ;GET total available hours based on fiscal year and start date.
 ;
 S PRSRWHRS=$$GETAVHRS^PRSARC04(.FMWKS,PRSDT)
 ;
 ; clean out old list data and rebuild everything
 ;
 D CLEAN^VALM10
 S (LISTI,LINE)=0
 K ^TMP("PRSARC",$J) ;  array-all items in list, incl. non selectable
 ;                      items such as month headings.
 K ^TMP("PRSLI",$J) ; index of all selectable items in the list.
 K ^TMP("PRSSW",$J) ; index of items selected as recess weeks.
 K ^TMP("PRSRW",$J) ; index of recess weeks with hours.
 D MAIN^PRSARC06(.PRSLSTRT,.LISTI,.LINE,PRSDT,PRSFYRNG)
 D HDR^PRSARC
 S PRSWKLST=LISTI-1
 S VALMCNT=LINE
 ;
 Q
 ;
AWSTART(FD,LD,PROMPT) ;function returns date within range FD-LD using PROMPT.
 ;
 ; since %DT will not restrict the valid date to a range we can use
 ;  %DT to create the lower bound and then check the upper bound
 ;  after exit from %DT.  range is first and last day of FY.
 N PRSDT,Y,DIRUT,DIR,X
 S DIR("A")=PROMPT
 S DIR(0)="D^"_FD_":"_LD_":EX"
 D ^DIR
 S PRSDT=Y
 I $D(DIRUT) S PRSDT=0
 Q PRSDT
 ;
FYRDATA(RWIEN) ; build a record of data for the Fiscal Year Recess for the viewer
 ; INPUT: Recess record IEN
 ;
 ;  OUTPUT: SELFY-selected fiscal year data (11 ^ piece string)
 ;    1) 4 digit yr           2) ex.FY06-07      3) external 1st day
 ;    4) external last day    5) FM 1st day      6) FM last day
 ;    7) first pp             8) last pp         9) 458.8 IEN if exists 
 ;    10) ext AWS start date 11) FM date AWS start
 ;    12) AWS start pay period
 ;
 N NODE3,FY,RANGE,ST,EN,EXTRANGE,FYE,X,Y,EXTSTDT,SELFY,STDT
 S NODE3=$G(^PRST(458.8,RWIEN,3))
 S FY=$P(NODE3,U,1)
 S RANGE=$$FYDAYS^PRSARC04(FY)
 S ST=$P(RANGE,U)
 S EN=$P(RANGE,U,2)
 S ST=$E(ST,4,5)_"/"_$E(ST,6,7)_"/"_$E(ST,2,3)
 S EN=$E(EN,4,5)_"/"_$E(EN,6,7)_"/"_$E(EN,2,3)
 S EXTRANGE=ST_U_EN
 S FYE=$$GETFSCYR^PRSARC04(FY-1700_"0101")
 S SELFY=FY_U_$P(FYE,U,3)_U_EXTRANGE_U_RANGE
 S X=$P(NODE3,U,2)
 D ^%DT
 S STDT=Y
 N D1,DAY S D1=STDT D PP^PRSAPPU
 S EXTSTDT=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 S SELFY=SELFY_U_RWIEN_U_EXTSTDT_U_STDT_U_PPE
 Q SELFY
VWMSG(MSG) ; roll and scroll message from listmanager call.
 D FULL^VALM1
 I MSG=1 D
 .  W !!,"This is a view only option.  You may not make any changes to the"
 .  W !,"recess schedule.  The Recess Hours Summary action is available.",!
 .  S OUT=$$ASK^PRSLIB00(1)
 E  D
 .  I 'PRSVIEW W !!,"Recess Schedule not saved." S OUT=$$ASK^PRSLIB00(1)
 Q
OTHERHRS(CTHW1,CTHW2,PRSNURSE) ; are any tour hours selected different than
 ; current tour hours.
 N ITEM,D1,TH,MISMATCH,K,PP4Y,PPE,PPI,Y,DAY,W1TMP,W2TMP
 S (MISMATCH,ITEM)=0
 F  S ITEM=$O(^TMP("PRSSW",$J,ITEM)) Q:ITEM'>0!MISMATCH  D
 . ; Get item out of selectable items index
 .  S D1=$G(WKSFM(ITEM)) D PP^PRSAPPU
 .  I $G(PPI)>0 D
 ..   K TH D TOURHRS^PRSARC07(.TH,PPI,PRSNURSE,"")
 ..   S W1TMP=$G(TH("W1"))
 ..   S W2TMP=$G(TH("W2"))
 ..   I W1TMP>0,W1TMP'=CTHW1 S MISMATCH=1 Q
 ..   I W2TMP>0,W2TMP'=CTHW2 S MISMATCH=1 Q
 Q MISMATCH
 ;
GETFLWKS(IEN,PRSDT) ; Get weeks/recess hours from 458.8 and any posted recess
 ; by way of the TT8b string.  Update the list columns.
 ;
 ; INPUT: IEN from file 458.8
 ;
 N RW,RWDATA,REW,RWD1,D1,TMPDT,LSTITEM,RH,PPI,STR8B,PAD,RCPOSTED
 N X1,X2,X,%H S X1=PRSDT,X2=-1 D C^%DTC S TMPDT=X
 ;
 F  S TMPDT=$O(^PRST(458.8,IEN,1,"AC",TMPDT)) Q:TMPDT'>0  D
 .  S RW=$O(^PRST(458.8,IEN,1,"AC",TMPDT,0))
 .  S RWDATA=^PRST(458.8,IEN,1,RW,0)
 .  S RH=$P(RWDATA,U,2)
 .  S RWD1=$P(RWDATA,U,3)
 .  S REW=$P(RWDATA,U,4)
 .  ; Get item number for week out of selectable items index
 .  S LSTITEM=$G(^TMP("PRSLI",$J,+RWDATA))
 .  D FLDTEXT^VALM10(LSTITEM,"RECESS HOURS",$J($P(RWDATA,U,2),15,2))
 .  D FLDCTRL^VALM10(LSTITEM,"RECESS HOURS",,,1)
 .  S ^TMP("PRSRW",$J,+RWDATA)=LSTITEM_U_RH_U_RWD1_U_REW
 ;D RPOSTED
 Q
RPOSTED ; Get weeks posted 
 ; get 8b from 5 node unless corrected timecard--then re decomp
 ;
 N WKDT,RW,STARTDT,STR8B,PAD,RCPOSTED,LSTITEM,RW
 S STARTDT=PRSDT
 N X1,X2,X,%H S X1=PRSDT,X2=-1 D C^%DTC S WKDT=X
 F  S WKDT=$O(FMWKS(WKDT)) Q:WKDT'>0  D
 .  S RW=$G(FMWKS(WKDT))
 .  S PPI=+$G(^PRST(458,"AD",WKDT))
 .  Q:PPI'>0
 .  S STR8B=$$GET8B^PRSPUT3(PPI,+PRSNURSE)
 .; pad 8B for function
 .  S PAD="12345678901234567890123456789012"
 .  S RCPOSTED=$$CD8B^PRSU1B2(PAD_STR8B,"RS^3^RN^3",1)
 .  S RCPOSTED=$P(RCPOSTED,U,$S(RW#2:1,1:2))
 .  Q:RCPOSTED'>0
 .  S LSTITEM=$G(^TMP("PRSLI",$J,RW))
 .  D FLDTEXT^VALM10(LSTITEM,"RECESS POSTED",$J(RCPOSTED,7,2))
 .  I +$G(^TMP("PRSRW",$J,+RW)) D
 ..   S $P(^TMP("PRSRW",$J,+RW),U,5)=RCPOSTED
 .  E  D
 ..   S ^TMP("PRSRW",$J,RW)=LSTITEM_U_U_U_U_RCPOSTED
 Q
EVEODDWK(ODD,EVEN) ; CHECK SELECTION INDEX FOR ODD AND EVEN PP WEEKS
 N ITEM
 S (ODD,EVEN)=0
 S ITEM=0
 F  S ITEM=$O(^TMP("PRSSW",$J,ITEM)) Q:ITEM'>0!(ODD&EVEN)  D
 . I ITEM#2 S ODD=1
 . E  S EVEN=1
 Q
CHANGE(IEN) ; funtion true if file record is different than current data
 ;
 S VALMBCK="R"
 Q:$G(IEN)'>0 0
 N RW,RWDATA,REW,RH,RWD1,PRSFILED,ITEM,PRSLIST,WK
 S RW=0,PRSFILED="",PRSLIST=""
 F  S RW=$O(^PRST(458.8,IEN,1,RW)) Q:RW'>0  D
 . S RWDATA=^PRST(458.8,IEN,1,RW,0)
 . S WK=+RWDATA
 . S RH=$P(RWDATA,U,2)
 . S RWD1=$P(RWDATA,U,3)
 . S REW=$P(RWDATA,U,4)
 . S PRSFILED=PRSFILED_WK_U_RH_U
 ;
 S ITEM=0
 F  S ITEM=$O(^TMP("PRSRW",$J,ITEM)) Q:ITEM'>0  D
 . S RH=$P(^TMP("PRSRW",$J,ITEM),U,2)
 . I RH>0 S PRSLIST=PRSLIST_ITEM_U_RH_U
 Q PRSFILED'=PRSLIST
 ;==================================================================
 ;
SETRECES ;SET HOURS FOR A WEEK AT A TIME
 ;
 S VALMBCK="R"
 I $G(PRSVIEW) D VWMSG^PRSARC03(1) Q
 ;
 N LSTITEM,CTRH1
 N ITEM,Y,RH1,RH2,OUT,HRSLEFT,HRDEFALT,CRH,TOURHRS,D1,PPI,PPE
 ;
 S VALMBCK="R"
 D SELRWK^PRSARC01("X",.OUT)
 Q:OUT
 ;get remaining hours to schedule for FY
 ;
 S (CRH,ITEM)=0
 F  S ITEM=$O(^TMP("PRSSW",$J,ITEM)) Q:ITEM'>0!OUT  D
 .  S D1=$G(WKSFM(ITEM)) D PP^PRSAPPU
 .  N TH D TOURHRS^PRSARC07(.TH,PPI,+PRSNURSE,"")
 .  S CTRH1=+TH("W1"),CTRH2=+TH("W2")
 .  S TOURHRS=$S(ITEM#2:CTRH1,1:CTRH2)
 .  S HRSLEFT=$$HRSLEFT()
 .  S CRH=+$P($G(^TMP("PRSRW",$J,ITEM)),U,2)
 .  I HRSLEFT+CRH<TOURHRS D
 ..    S HRDEFALT=HRSLEFT+CRH
 .  E  D
 ..   S HRDEFALT=TOURHRS
 .  I HRDEFALT<0 S HRDEFALT=0
 .  N DIRUT,DIR,Y,VALID
 .  S DIR(0)="N^0:72:2"
 .  S DIR("B")=HRDEFALT
 .  W !,"Recess hours remaining to schedule: ",HRSLEFT,!
 .  S DIR("A")="Enter recess hours for week "_ITEM
 .  S VALID=0
 .  F  D  Q:VALID!OUT
 ..   D ^DIR
 ..   I (+Y#.25)=0 S VALID=1
 ..   I +Y=0 S Y=""
 ..   S RH=Y
 ..   I $D(DIRUT) S OUT=1,RH=CRH
 . ; Get item from selectable index
 . S LSTITEM=$G(^TMP("PRSSW",$J,ITEM))
 . D FLDTEXT^VALM10(LSTITEM,"RECESS HOURS",$J(RH,15,2))
 .;
 .; set hrs for selected weeks, remove from array if zero
 .; 
 . I RH'>0 D
 ..  K ^TMP("PRSRW",$J,ITEM)
 . E  D
 ..  S $P(^TMP("PRSRW",$J,ITEM),U,2)=RH
 ..  S $P(^TMP("PRSRW",$J,ITEM),U,3)=$G(WKSFM(ITEM))
 ..  S $P(^TMP("PRSRW",$J,ITEM),U,4)=0
 ;
 D DSELALL^PRSARC01
 S VALMBCK="R"
 Q
 ;====================
HRSLEFT() ; Get remaining hours available for recess for the FY
 ;
 N TRHA,WK,HRSWK,HRSUSED,PRSRWHRS
 S (WK,HRSUSED)=0
 F  S WK=$O(^TMP("PRSRW",$J,WK)) Q:WK'>0  D
 . ; Get item out of recess weeks items index
 .   S HRSWK=$P(^TMP("PRSRW",$J,WK),U,2)
 .   S HRSUSED=HRSUSED+HRSWK
 S PRSRWHRS=$$GETAVHRS^PRSARC04(.FMWKS,PRSDT)
 S TRHA=$P($G(PRSRWHRS),U,2)
 Q TRHA-HRSUSED
 ;
HRSFILED(IEN) ; funtion returns number of recess hours on file
 ;
 N RW,RWDATA,RH,HRSFILED
 S HRSFILED=0
 Q:$G(IEN)'>0 HRSFILED
 S RW=0,PRSFILED="",PRSLIST=""
 F  S RW=$O(^PRST(458.8,IEN,1,RW)) Q:RW'>0  D
 . S RWDATA=^PRST(458.8,IEN,1,RW,0)
 . S RH=$P(RWDATA,U,2)
 . S HRSFILED=HRSFILED+RH
 Q HRSFILED
 ;==================================================================
 ;
