ENXIP65 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;5/18/2000
 ;;7.0;ENGINEERING;**65**;Aug 17, 1993
 Q
 ;
PS ;Post Install Entry Point
 ;
 ; only perform during 1st install
 I $$PATCH^XPDUTL("EN*7.0*65") D BMES^XPDUTL("  Skipping post install since patch was previously installed.") Q
 ;
 N ENX,Y
 ; create KIDS checkpoints with call backs
 F ENX="XTIME","EQHIST" D
 . S Y=$$NEWCP^XPDUTL(ENX,ENX_"^ENXIP65")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_ENX_" Checkpoint.")
 Q
 ;
XTIME ; Remove time from equipment history entries
 ; Previous patch EN*7*48 resulted in work orders with a time being
 ; incorrectly posted to the equipment history
 N ENACTN,ENC,ENDTCP,ENH,ENHDA,ENHR,ENINV
 N XPDIDTOT
 ;
 D BMES^XPDUTL("   Removing time from equipment histories...")
 ;
 ; estimate count of equipment to examine
 S ENC("TOT")=$P($G(^ENG(6914,0)),U,4)
 I ENC("TOT")<1 S ENC("TOT")=1
 S ENC("EQ")=0 ; count of evaluated equipment
 S ENC("FIX")=0 ; count of modified histories
 S XPDIDTOT=ENC("TOT") ; set total for status bar
 S ENC("UPD")=5  ; initial % required to update status bar
 ;
 ; loop thru equipment
 S ENINV=0 F  S ENINV=$O(^ENG(6914,ENINV)) Q:'ENINV  D
 . S ENC("EQ")=ENC("EQ")+1
 . S ENC("%")=ENC("EQ")*100/ENC("TOT") ; calculate % complete
 . ;
 . ; check if status bar should be updated
 . I ENC("%")>ENC("UPD"),ENC("%")<100 D
 . . D UPDATE^XPDID(ENC("EQ")) ; update status bar
 . . S ENC("UPD")=ENC("UPD")+5 ; increase update criteria by 5%
 . ;
 . ; loop thru history multiple
 . S ENHDA=0
 . F  S ENHDA=$O(^ENG(6914,ENINV,6,ENHDA)) Q:'ENHDA  I ENHDA["." D
 . . ; contains a time
 . . ;
 . . ; get current data
 . . S ENH=$G(^ENG(6914,ENINV,6,ENHDA,0))
 . . Q:ENH=""
 . . S ENHR=$P(ENH,U)
 . . S ENDTCP=$P(ENHR,"-") ; date complete
 . . S ENACTN=$P(ENHR,"-",2) ; work action(s)
 . . ;W !!,ENINV,?10,ENHDA,?25,ENDTCP,!," ",ENH
 . . ;
 . . ; remove time from the date in the history reference field
 . . S ENDTCP=$P(ENDTCP,".")
 . . S $P(ENH,U)=ENDTCP_"-"_ENACTN
 . . ;
 . . ;W !,ENINV,?25,ENDTCP,!," ",ENH
 . . ; post to history as a new entry (uses ENINV, ENDTCP, and ENH)
 . . D EXT^ENEQHS
 . . ;
 . . ; delete original entry from history
 . . K ^ENG(6914,ENINV,6,ENHDA,0)
 . . S $P(^ENG(6914,ENINV,6,0),U,4)=$P(^ENG(6914,ENINV,6,0),U,4)-1
 . . ;
 . . S ENC("FIX")=ENC("FIX")+1
 ;
 D MES^XPDUTL("     "_ENC("FIX")_" equipment histories were modified.")
 Q
 ;
EQHIST ; update equipment history data based on completed work orders
 ;
 N ENC,ENEQDA,ENEQHDA,ENEQHX,ENH,ENI,ENINV,ENTEC,ENWODA,ENWODC,ENWOX
 N XPDIDTOT
 ;
 D BMES^XPDUTL("   Using completed work order data to correct equipment histories...")
 ;
 ; estimate count of work orders to examine
 S ENC("TOT")=$P($G(^ENG(6920,0)),U,4)
 I ENC("TOT")<1 S ENC("TOT")=1
 S ENC("WO")=0 ; count of evaluated work orders
 S XPDIDTOT=ENC("TOT") ; set total for status bar
 S ENC("UPD")=5  ; initial % required to update status bar
 ;
 S ENC("WOC")=0 ; count of work orders with status = complete
 S ENC("EHM")=0 ; count of missing equipment histories
 S ENC("DIF")=0 ; count of different equip hist vs w.o.
 ;
 K ^XTMP("EN7P65")
 S ^XTMP("EN7P65",0)=$$FMADD^XLFDT(DT,90)_U_DT
 ;
 ; loop thru work orders
 S ENWODA=0 F  S ENWODA=$O(^ENG(6920,ENWODA)) Q:'ENWODA  D 
 . S ENC("WO")=ENC("WO")+1
 . S ENC("%")=ENC("WO")*100/ENC("TOT") ; calculate % complete
 . ;
 . ; check if status bar should be updated
 . I ENC("%")>ENC("UPD"),ENC("%")<100 D
 . . D UPDATE^XPDID(ENC("WO")) ; update status bar
 . . S ENC("UPD")=ENC("UPD")+5 ; increase update criteria by 5%
 . ;
 . S ENEQDA=$P($G(^ENG(6920,ENWODA,3)),U,8) ; equip entry #
 . Q:ENEQDA'>0  ; not linked with equipment entry
 . S ENWODC=$P($G(^ENG(6920,ENWODA,5)),U,2) ; date complete
 . Q:ENWODC=""  ; not completed
 . Q:$P($G(^ENG(6920,ENWODA,4)),U,3)=5  ; disapproved
 . ; have found a completed work order for an equipment record
 . S ENC("WOC")=ENC("WOC")+1 ; count it
 . S ENWOX=$P($G(^ENG(6920,ENWODA,0)),U)
 . ;
 . ; check if equipment record exists
 . Q:'$D(^ENG(6914,ENEQDA,0))  ; equip must have been deleted or archived
 . ;
 . ; determine expected history value based on work order
 . S ENH=$$HIST(ENWODA)
 . ;
 . ; look for work order in the equipment history
 . S ENEQHDA=0
 . S ENI=0 F  S ENI=$O(^ENG(6914,ENEQDA,6,ENI)) Q:'ENI  D  Q:ENEQHDA
 . . S ENEQHX=$G(^ENG(6914,ENEQDA,6,ENI,0))
 . . I $P(ENEQHX,U,2)=ENWOX S ENEQHDA=ENI ; found it
 . I ENEQHDA'>0 D  Q  ; equipment hist missing
 . . ; add to equip hist
 . . S DA=ENWODA,ENINV=ENEQDA
 . . S ENTEC=$P($G(^ENG(6920,DA,2)),U,2)
 . . D W^ENEQHS
 . . ;
 . . S ENC("EHM")=ENC("EHM")+1
 . . S ^XTMP("EN7P65","ADD",ENWODA,ENEQDA)=ENH
 . ;
 . ; compare history with expected history and update if necessary
 . I $P(ENEQHX,U,3,7)'=$P(ENH,U,3,7) D  ; values differ
 . . ;
 . . S ^XTMP("EN7P65","UPD",ENEQDA,ENEQHDA)=ENWODA
 . . S ^XTMP("EN7P65","UPD",ENEQDA,ENEQHDA,"OLD")=ENEQHX
 . . F I=3:1:7 S $P(ENEQHX,U,I)=$P(ENH,U,I)
 . . S ^ENG(6914,ENEQDA,6,ENEQHDA,0)=ENEQHX
 . . ;
 . . S ENC("DIF")=ENC("DIF")+1
 . . S ^XTMP("EN7P65","UPD",ENEQDA,ENEQHDA,"NEW")=ENEQHX
 ;
 ; save counts
 S ^XTMP("EN7P65","UPD",0)=ENC("DIF")
 S ^XTMP("EN7P65","ADD",0)=ENC("EHM")
 ;
 D MES^XPDUTL("     Processed "_ENC("WOC")_" completed work orders.")
 D MES^XPDUTL("     "_ENC("EHM")_" missing equipment histories were added.")
 D MES^XPDUTL("     "_ENC("DIF")_" inaccurate equipment histories were fixed.")
 Q
 ;
HIST(DA) ; determine equipment hist value based on work order data
 ; input DA - work order internal entry #
 N ENACTN,ENDTCP,ENEMPL,ENH,ENHRS,ENINV,ENLABOR,ENMTL
 N ENODE,ENRET,ENSTAT,ENTEC,ENVEND,ENWORK,ENWOX,I,J,J1,K
 S ENRET=""
 ;
 I $D(^ENG(6920,DA,4)),$P(^(4),U,3)=5 Q ENRET ; disapproved work order
 S ENWOX=$P($G(^ENG(6920,DA,0)),U)
 S ENINV=$P($G(^ENG(6920,DA,3)),U,8)
 S ENTEC=$P($G(^ENG(6920,DA,2)),U,2)
 ;
 I ENTEC="" S ENEMPL=$S($E(ENWOX,1,3)="PM-":"STAFF",1:"NO ENTRY")
 E  S ENEMPL=$E($P($G(^ENG("EMP",ENTEC,0)),U),1,15)
 ;
 S ENODE=$G(^ENG(6920,DA,5))
 S ENDTCP=$P($P(ENODE,U,2),"."),ENHRS=$P(ENODE,U,3),ENMTL=$P(ENODE,U,4)
 S ENLABOR=$P(ENODE,U,6),ENSTAT=$P(ENODE,U,8),ENWORK=$P(ENODE,U,7)
 S ENACTN="XX"
 I $D(^ENG(6920,DA,8)) D
 . F I=0:0 S I=$O(^ENG(6920,DA,8,I)) Q:I'>0!($L(ENACTN)=8)  D
 .. S J=$P(^ENG(6920,DA,8,I,0),U)
 .. Q:'$D(^ENG(6920.1,J,0))  S J1=$P(^(0),U,2)
 .. I ENACTN="XX" S ENACTN=""
 .. S ENACTN=ENACTN_J1
 S ENVEND=$P($P($G(^ENG(6920,DA,4)),U,4),".")
 S ENRET=ENDTCP_"-"_ENACTN_U_ENWOX_U_ENSTAT_U_ENHRS_U_ENLABOR_U_ENMTL_U_ENVEND_U_ENEMPL_U_ENWORK
 Q ENRET
 ;
 ;ENXIP65
