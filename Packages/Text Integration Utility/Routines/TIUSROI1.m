TIUSROI1 ; SLC/JER - Reassign actions ; 04/19/2004
 ;;1.0;TEXT INTEGRATION UTILITIES;**112,187,173**;Jun 20, 1997
 Q
FROMTO(TIUODA,TIUDA,TIUTNM) ; Display the from/to information
 N TIUF,TIUF12,TIUT,TIUT12,TIUFEDT,TIUFLDT,TIUTEDT,TIUTLDT
 D GETTIU^TIULD(.TIUF,+TIUODA)
 D GETTIU^TIULD(.TIUT,+TIUDA)
 S TIUFEDT=$$DATE^TIULS($P(TIUF("EDT"),U),"MM/DD/YY HR:MIN")
 S TIUFLDT=$$DATE^TIULS($P(TIUF("LDT"),U),"MM/DD/YY HR:MIN")
 S TIUTEDT=$$DATE^TIULS($P(TIUT("EDT"),U),"MM/DD/YY HR:MIN")
 S TIUTLDT=$$DATE^TIULS($P(TIUT("LDT"),U),"MM/DD/YY HR:MIN")
 S TIUF12=$G(^TIU(8925,TIUODA,12)),TIUT12=$G(^TIU(8925,TIUDA,12))
 W !!,"You are about to move the ",TIUTNM," as follows:",!
 W !,?5,"From",?45,"To",!
 W !,$P(TIUF("DOCTYP"),U,2),?35," --> ",?40,$P(TIUT("DOCTYP"),U,2)
 W !,TIUF("PNM")," ",TIUF("PID"),?35," --> ",?40,TIUT("PNM")," ",TIUT("PID")
 W !,TIUFEDT,$S(+TIUFLDT:" - "_TIUFLDT,1:""),?35," --> "
 W ?40,TIUTEDT,$S(+TIUTLDT:" - "_TIUTLDT,1:""),!
 W !,"     Surgeon: ",$$PERSNAME^TIULC1(+$P(TIUF12,U,2)),?35," --> "
 W ?40,$$PERSNAME^TIULC1(+$P(TIUF12,U,2))
 W !,"   Attending: ",$$PERSNAME^TIULC1(+$P(TIUF12,U,9)),?35," --> "
 W ?40,$$PERSNAME^TIULC1(+$P(TIUT12,U,9))
 W !,"Surg. Case #: ",+$P($G(^TIU(8925,TIUODA,14)),U,5),?35," --> "
 W ?40,+$P($G(^TIU(8925,TIUDA,14)),U,5),!
 Q +$$READ^TIUU("YA"," ... Ok? ","NO")
ANES(TIUDA) ; Roll back ANESTHESIA REPORT when TIU changes require it
 N SRODA S SRODA=+$P($G(^TIU(8925,TIUDA,14)),U,5)
 Q:+SRODA'>0
 D ANES^SROTIUD(SRODA)
 Q
NURS(TIUDA) ; Roll back NURSE INTRAOPERATIVE REPORT when TIU changes require it
 N SRODA S SRODA=+$P($G(^TIU(8925,TIUDA,14)),U,5)
 Q:+SRODA'>0
 D NURS^SROTIUD(SRODA)
 Q
RETRACT(TIUDA) ;
 N CNT,TITLE,TIUACT,TIUDATA
 S TIUDATA="ANESTHESIA REPORTS^NURSE INTRAOPERATIVE REPORTS^OPERATION REPORTS^PROCEDURE REPORT (NON-O.R.)"
 F CNT=1:1:$L(TIUDATA,U) S TITLE=$P(TIUDATA,U,CNT) I $$BELONGS^TIULX(TIUDA,$$FIND1^DIC(8925.1,"","BX",TITLE)) D
 . S TIUACT=$S(CNT=1:"ANES^TIUSROI1(TIUDA)",CNT=2:"NURS^TIUSROI1(TIUDA)",CNT=3:"RBOR^TIUSROI(TIUDA)",CNT=4:"RBPR^TIUSROI(TIUDA)",1:"QUIT")
 . I TIUACT="QUIT" Q
 . D @TIUACT
 Q
CHANGE(TIUDA) ; Redirect the TIU Document to a different Surgical Case
 N DFN,SROVP,TIUD0,TIUD14,TIUNDA,TIUACT
 S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUD14=$G(^(14)),SROVP=$P(TIUD14,U,5)
 S DFN=$P(TIUD0,U,2) Q:+DFN'>0
 ; choose destination case
 W ! S SROVP=$$GETCASE^TIUSROI(DFN)
 ; if no case is selected, quit
 I +SROVP'>0 D  Q
 . W !!,$C(7),"Okay, no harm done...",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 ; if target case is same as current, quit
 I +SROVP=+$P(TIUD14,U,5) D  Q
 . W !!,$C(7),"You've selected the original case. No changes made.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 ; Get the document for the target surgical case
 S TIUNDA=$$TARGET(SROVP)
 ; if target document is of a different type than source, quit
 I $$TYPE(TIUNDA)'=$$TYPE(TIUDA) D  Q
 . W !!,$C(7),"Incompatible document type. No changes made.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 ; if target case has empty report, replace
 S TIUTYP=+TIUD0
 S TIUTNM=$$PNAME^TIULC1(TIUTYP)
 I '$$FROMTO^TIUSROI1(TIUDA,TIUNDA,TIUTNM) D  Q
 . W !!,"Aborting Transaction, No Harm Done...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 I +$$EMPTYDOC^TIULF(TIUNDA) D  Q
 . W !!,"Moving document ",TIUDA," to Surgical Case #",+SROVP,"...",!
 . I '+$$READ^TIUU("YA","Are you sure? ","NO") Q
 . D REPLACE(TIUDA,TIUNDA)
 ; else, ask whether to swap or replace
 S TIUACT=$$ASKACT($$TITLE(TIUNDA))
 I $P(TIUACT,U)="E"!($P(TIUACT,U)="") D  Q
 . W !!,"Great. No harm done.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 I $P(TIUACT,U)="R" D  Q
 . W !!,"Replacing ",$$TITLE(TIUNDA)," on Surgical Case #",+SROVP,"...",!
 . I '+$$READ^TIUU("YA","Are you sure? ","NO") Q
 . D REPLACE(TIUDA,TIUNDA)
 I $P(TIUACT,U)="S" D
 . W !!,"Swapping with ",$$TITLE(TIUNDA)," on Surgical Case #",+SROVP,"...",!
 . I '+$$READ^TIUU("YA","Are you sure? ","NO") Q
 . D SWAP(TIUDA,TIUNDA)
 Q
ASKACT(TITLE) ; ask user to choose replace or swap
 N TIUY,TIUSET S TIUY=""
 W !!,"Please choose the appropriate action for this "_TITLE_":"
 S TIUSET="R:replace target document with this document"
 S TIUSET=TIUSET_";S:swap target document with this document"
 S TIUSET=TIUSET_";E:exit and do nothing"
 S TIUY=$$READ^TIUU("S^"_TIUSET,"Select Action","exit")
 Q TIUY
TITLE(TIUDA) ; resolve title of document
 Q $P($G(^TIU(8925.1,+$G(^TIU(8925,TIUDA,0)),0)),U)
TYPE(TIUDA) ; identifies type of document (i.e., Op Report or Proc Report)
 N TIUY,TIUCOR,TIUCPR S TIUY=""
 S TIUCOR=+$$CLASS^TIUSROI("OPERATION REPORTS")
 S TIUCPR=+$$CLASS^TIUSROI("PROCEDURE REPORT (NON-O.R.)")
 I +$$ISA^TIULX(+$G(^TIU(8925,TIUDA,0)),TIUCOR) S TIUY="OS" I 1
 E  I +$$ISA^TIULX(+$G(^TIU(8925,TIUDA,0)),TIUCPR) S TIUY="PR"
 Q TIUY
TARGET(TIUCASE) ; Get report ien for case
 N TIUI,TIUNDA,TIUCOR,TIUCPR S (TIUI,TIUNDA)=0
 S TIUCOR=+$$CLASS^TIUSROI("OPERATION REPORTS")
 S TIUCPR=+$$CLASS^TIUSROI("PROCEDURE REPORT (NON-O.R.)")
 F  S TIUI=$O(^TIU(8925,"G",TIUCASE,TIUI)) Q:+TIUI'>0  D  Q:+TIUNDA
 . I $P($G(^TIU(8925,TIUI,0)),U,5)=15 Q
 . I +$$ISA^TIULX(+$G(^TIU(8925,TIUI,0)),TIUCOR) S TIUNDA=TIUI Q
 . I +$$ISA^TIULX(+$G(^TIU(8925,TIUI,0)),TIUCPR) S TIUNDA=TIUI
 Q TIUNDA
REPLACE(TIUDA1,TIUDA2) ; Replace TIUDA2 with TIUDA1
 N SRODA1,SRODA2,TIUD01,TIUD02,TIUD141,TIUD142,TIUTYPE,TIUNODEL
 S TIUD01=$G(^TIU(8925,TIUDA1,0)),TIUD02=$G(^TIU(8925,TIUDA2,0))
 I +TIUD01'=+TIUD02 D  Q
 . W !!,$C(7),"The two documents are of different types. No changes made.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 S TIUD141=$G(^TIU(8925,TIUDA1,14)),SRODA1=+$P(TIUD141,U,5)
 S TIUD142=$G(^TIU(8925,TIUDA2,14)),SRODA2=+$P(TIUD142,U,5)
 ; 1. Swap comments for TIUDA1 and TIUDA2
 D SWAPCOMM(TIUDA1,TIUDA2)
 ; 2. Redirect TIUDA1 to TIUDA2's surgical case
 D RDTIU(TIUDA1,SRODA2)
 ; 3. Redirect TIUDA2's surgical case to TIUDA1
 D RDSURG(SRODA2,TIUDA1)
 ; 4. Delete or Retract TIUDA2
 I +$P(TIUD02,U,5)<6 D DIK^TIURB2(TIUDA2,1) I 1
 E  S TIUNODEL=1,TIUDA2=$$RETRACT^TIURD2(TIUDA2,"",14)
 ; 5. Rollback SRODA1 (create new stub)
 S TIUTYPE=$$TYPE(TIUDA1)
 I TIUTYPE="OS" D OS^SROTIUD(SRODA1) I 1
 E  I TIUTYPE="PR" D NON^SROTIUD(SRODA1)
 Q
SWAP(TIUDA1,TIUDA2) ; Swap TIUDA1 with TIUDA2
 N SRODA1,SRODA2,TIUD01,TIUD02,TIUD141,TIUD142
 S TIUD01=$G(^TIU(8925,TIUDA1,0)),TIUD02=$G(^TIU(8925,TIUDA2,0))
 I +TIUD01'=+TIUD02 D  Q
 . W !!,$C(7),"The two documents are of different types. No changes made.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 S TIUD141=$G(^TIU(8925,TIUDA1,14)),SRODA1=+$P(TIUD141,U,5)
 S TIUD142=$G(^TIU(8925,TIUDA2,14)),SRODA2=+$P(TIUD142,U,5)
 ; 1. Redirect TIUDA1 to TIUDA2's surgical case
 D RDTIU(TIUDA1,SRODA2)
 ; 2. Redirect TIUDA2 to TIUDA1's surgical case
 D RDTIU(TIUDA2,SRODA1)
 ; 3. Redirect TIUDA1's surgical case to TIUDA2
 D RDSURG(SRODA1,TIUDA2)
 ; 4. Redirect TIUDA2's surgical case to TIUDA1
 D RDSURG(SRODA2,TIUDA1)
 ; 5. Swap comments for TIUDA1 and TIUDA2
 D SWAPCOMM(TIUDA1,TIUDA2)
 Q
RDSURG(SRODA,TIUDA) ; Redirect surgical case to new document
 N DA,DIE,DR,TIUTYP S TIUTYP=$$TYPE(TIUDA) Q:TIUTYP']""
 S DIE=130,DA=SRODA,DR=$S(TIUTYP="OS":1000,TIUTYP="PR":1002,1:"")
 S DR=DR_"////^S X=TIUDA" D ^DIE
 Q
RDTIU(TIUDA,SRODA) ; Redirect document to new surgical case
 N DA,DIE,DR,SROVP S SROVP=SRODA_";SRF("
 S DIE=8925,DA=TIUDA,DR="1405////^S X=SROVP" D ^DIE
 Q
SWAPCOMM(TIUDA1,TIUDA2) ; Swap the comments field for two TIU Documents
 N DA,DIE,DR,COMM1,COMM2
 S COMM1=$G(^TIU(8925,TIUDA1,17)),COMM2=$G(^TIU(8925,TIUDA2,17))
 S DA=TIUDA1,DIE=8925,DR="1701////^S X=COMM2" D ^DIE
 S DA=TIUDA2,DIE=8925,DR="1701////^S X=COMM1" D ^DIE
 Q
