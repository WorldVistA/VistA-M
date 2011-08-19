TIURD4 ; SLC/JER - Reassign actions ;13-APR-2001 14:29:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**61,100**;Jun 20, 1997
FROMTO(TIUDA,TIUDAT) ; Display the from/to information
 N TIUF,TIUT,TIUDAD,TIUFEDT,TIUFLDT,TIUTEDT,TIUTLDT
 S TIUDAD=$P($G(^TIU(8925,+TIUDA,0)),U,6)
 D GETTIU^TIULD(.TIUF,+TIUDAD)
 D GETTIU^TIULD(.TIUT,+TIUDAT)
 S TIUFEDT=$$DATE^TIULS($P(TIUF("EDT"),U),"MM/DD/YY")
 S TIUFLDT=$$DATE^TIULS($P(TIUF("LDT"),U),"MM/DD/YY")
 S TIUTEDT=$$DATE^TIULS($P(TIUT("EDT"),U),"MM/DD/YY")
 S TIUTLDT=$$DATE^TIULS($P(TIUT("LDT"),U),"MM/DD/YY")
 W !!,"You are about to move the addendum as follows:",!
 W !,?5,"From",?45,"To",!
 W !,$P(TIUF("DOCTYP"),U,2),?35," --> ",?40,$P(TIUT("DOCTYP"),U,2)
 W !,TIUF("PNM")," ",TIUF("PID"),?35," --> ",?40,TIUT("PNM")," ",TIUT("PID")
 W !,TIUFEDT,$S($L(TIUFLDT):" - "_TIUFLDT,1:""),?35," --> "
 W ?40,TIUTEDT,$S($L(TIUTLDT):" - "_TIUTLDT,1:""),!
 Q
UPDSTAT(DA)     ; Update the status of the named record
 N DIE,DR
 S DIE=8925,DR=".05///^S X=$$STATUS^TIULC(DA)"
 D ^DIE
 Q
LOADSB(TIUODA,TIUADA,TIUOS,TIUAS) ; Load arrays w/Sig Blocks
 N TIUOD15,TIUAD15
 S TIUOD15=$G(^TIU(8925,TIUODA,15))
 S TIUOS("SBN")=$S($P(TIUOD15,U,3)]"":$$DECRYPT(TIUODA,$P(TIUOD15,U,3)),1:"@")
 S TIUOS("SBT")=$S($P(TIUOD15,U,4)]"":$$DECRYPT(TIUODA,$P(TIUOD15,U,4)),1:"@")
 S TIUOS("CSBN")=$S($P(TIUOD15,U,9)]"":$$DECRYPT(TIUODA,$P(TIUOD15,U,9)),1:"@")
 S TIUOS("CSBT")=$S($P(TIUOD15,U,10)]"":$$DECRYPT(TIUODA,$P(TIUOD15,U,10)),1:"@")
 S TIUAD15=$G(^TIU(8925,TIUADA,15))
 S TIUAS("SBN")=$S($P(TIUAD15,U,3)]"":$$DECRYPT(TIUADA,$P(TIUAD15,U,3)),1:"@")
 S TIUAS("SBT")=$S($P(TIUAD15,U,4)]"":$$DECRYPT(TIUADA,$P(TIUAD15,U,4)),1:"@")
 S TIUAS("CSBN")=$S($P(TIUAD15,U,9)]"":$$DECRYPT(TIUADA,$P(TIUAD15,U,9)),1:"@")
 S TIUAS("CSBT")=$S($P(TIUAD15,U,10)]"":$$DECRYPT(TIUADA,$P(TIUAD15,U,10)),1:"@")
 Q
SWAPSB(TIUODA,TIUADA,TIUOS,TIUAS) ; Swap Signature blocks
 N DA,DIE,DR
 S DR="1503///^S X=TIUAS(""SBN"");1504///^S X=TIUAS(""SBT"")"
 S DR=DR_";1509///^S X=TIUAS(""CSBN"");1510///^S X=TIUAS(""CSBT"")"
 S DA=TIUODA,DIE="^TIU(8925," D ^DIE K DR
 S DR="1503///^S X=TIUOS(""SBN"");1504///^S X=TIUOS(""SBT"")"
 S DR=DR_";1509///^S X=TIUOS(""CSBN"");1510///^S X=TIUOS(""CSBT"")"
 S DA=TIUADA,DIE="^TIU(8925," D ^DIE K DR
 Q
DECRYPT(TIUDA,TIUX) ; Decrypt signature blocks
 N TIUY
 S TIUY=$$DECRYPT^TIULC1(TIUX,1,$$CHKSUM^TIULC("^TIU(8925,"_+TIUDA_",""TEXT"")"))
 Q TIUY
RECOVER(TIUODA,TIUDA,TIUD0)     ; Restore original state on abort
 N DIE,DR,DA,DIDEL,TIUI
 W $C(7),$C(7),!!,"Transaction aborted. Restoring records to original state..."
 ; Loop thru ^TMP("TIURTRCT",$J,DA) and restore prior state
 I '$D(^TMP("TIURTRCT",$J,TIUODA)) D
 . W !!,"** Can't Restore to Prior State...'$D(^TMP(""TIURTRCT"",$J,TIUODA)) **"
 S TIUI=0 F  S TIUI=$O(^TMP("TIURTRCT",$J,TIUI)) Q:+TIUI'>0  D
 . N DIE,DR,X,Y,TIUD0,DA
 . S DA=TIUI,TIUD0=^TMP("TIURTRCT",$J,DA,0)
 . S DIE=8925
 . S DR=".03////^S X=$P(TIUD0,U,3);.05////^S X=$P(TIUD0,U,5);.06////^S X=$P(TIUD0,U,6)"
 . D ^DIE
 ; Loop thru ^TMP("TIURTRCT",$J,"NEW",DA) and delete duplicate notes
 I '$D(^TMP("TIURTRCT",$J,"NEW",TIUDA)) D
 . W !!,"** Can't Restore to Prior State...'$D(^TMP(""TIURTRCT"",$J,""NEW"",TIUDA)) **"
 S TIUI=0 F  S TIUI=$O(^TMP("TIURTRCT",$J,"NEW",TIUI)) Q:+TIUI'>0  D
 . D DELDOC(TIUI)
 H 3
 Q
DELDOC(DA) ; Delete document and components--NOT its addenda
 N DIE,DIDEL,DR,X,Y,TIUDA,TIUI
 S TIUDA=DA
 ; First, delete audit trail entries
 D DELAUDIT^TIUEDI1(TIUDA)
 D DELSGNRS(TIUDA)
 ; Next, delete the document's components
 S TIUI=0 F  S TIUI=$O(^TIU(8925,"DAD",TIUDA,TIUI)) Q:+TIUI'>0  D
 . I +$$ISADDNDM^TIULC1(TIUI) Q
 . D DELDOC(TIUI)
 S (DIDEL,DIE)=8925,DR=".01///@"
 D ^DIE ; Delete duplicate note
 Q
DELSGNRS(TIUDA,UNSIGN) ; Remove Additional signers
 N DA S DA=0
 F  S DA=$O(^TIU(8925.7,"B",TIUDA,DA)) Q:+DA'>0  D
 . N DIK,DIDEL
 . I +$G(UNSIGN),(+$P(^TIU(8925.7,DA,0),U,4)>0) Q
 . S DIK="^TIU(8925.7,",DIDEL=8925.7 D ^DIK
 Q
