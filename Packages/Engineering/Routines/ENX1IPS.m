ENX1IPS ;WIRMFO/SAB- POST-INIT ;10/29/97
 ;;7.0;ENGINEERING;**46**;Aug 17, 1993
 ;
 ; only do remaining steps during 1st install
 I $$PATCH^XPDUTL("EN*7.0*46") D BMES^XPDUTL("  Skipping Equipment updates step since patch was previously installed.") Q
 ;
 N ENAMT,ENDA,ENC,ENCSN,ENFUND,ENFUNDN,ENFUNDNI,ENGRP,ENSGL,ENSTA,ENT,ENX
 ;
 D BMES^XPDUTL("  Examining Equipment Inventory file...")
 K ^TMP($J)
 S ENDA=0 F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D
 . Q:+$$CHKFA^ENFAUTL(ENDA)'>0  ; ignore equipment not report to FAP
 . S ENSTA=$$GET1^DIQ(6914,ENDA_",",60)
 . S ENSGL=$$GET1^DIQ(6914,ENDA_",",38)
 . S ENFUND=$$GET1^DIQ(6914,ENDA_",",62)
 . I ENSTA=""!(ENSGL="")!(ENFUND="") D  Q
 . . S ENX="    ERROR: EQUIP. # "_ENDA_" is missing data (station, fund, or SGL)."
 . . D MES^XPDUTL(ENX)
 . I "1754"=ENSGL S ^TMP($J,"EN1754",ENSTA,ENFUND,ENDA)="" D
 . . ; check if ADPE
 . . S ENCSN=$$GET1^DIQ(6914,ENDA_",",18) Q:ENCSN=""
 . . S ENGRP=$$GROUP^ENFAVAL(ENCSN)
 . . S:"^7000^7020^7021^7025^7435^"[(U_ENGRP_U) ^TMP($J,"ENADP",ENDA)=""
 . I "^8129G^4138^6019^5014A1^"[(U_ENFUND_U) S:ENSGL="1754" ENSGL="1750" S ^TMP($J,"ENDF",ENSTA,ENFUND,ENSGL,ENDA)=""
 ;
 D BMES^XPDUTL("  Moving Trust Equipment from SGL 1754 to SGL 1750...")
 D:'$D(^TMP($J,"EN1754")) MES^XPDUTL("    None found. No action taken.")
 ; init grand totals
 K ENC,ENT S (ENC,ENT)=0
 ; loop thru stations in TMP
 S ENSTA="" F  S ENSTA=$O(^TMP($J,"EN1754",ENSTA)) Q:ENSTA=""  D
 . D MES^XPDUTL("    For Station "_ENSTA)
 . ; init station subtotals
 . S (ENC(ENSTA),ENT(ENSTA))=0
 . ; loop thru funds in station
 . S ENFUND="" F  S ENFUND=$O(^TMP($J,"EN1754",ENSTA,ENFUND)) Q:ENFUND=""  D
 . . ; init fund subtotals
 . . S (ENC(ENSTA,ENFUND),ENT(ENSTA,ENFUND))=0
 . . ; loop thru equipment in fund
 . . S ENDA=0 F  S ENDA=$O(^TMP($J,"EN1754",ENSTA,ENFUND,ENDA)) Q:'ENDA  D
 . . . ; move equipment
 . . . S ENX=$$XSGL^ENX1IPS1(ENDA)
 . . . I 'ENX D MES^XPDUTL("ERROR: Couldn't create the FAP Documents.")
 . . . S ENAMT=$P($G(^ENG(6914,ENDA,2)),U,3)
 . . . ; update fund totals
 . . . S ENC(ENSTA,ENFUND)=ENC(ENSTA,ENFUND)+1
 . . . S ENT(ENSTA,ENFUND)=ENT(ENSTA,ENFUND)+ENAMT
 . . . ; report action
 . . . S ENX="        Equip #: "_$$LJ^XLFSTR(ENDA,10)
 . . . S ENX=ENX_"  Fund: "_$$LJ^XLFSTR(ENFUND,6)
 . . . S ENX=ENX_"  Value: "_$J("$"_$FN(ENAMT,",",2),16)
 . . . D MES^XPDUTL(ENX)
 . . ; report fund subtotal
 . . S ENX="      Fund "_$$CJ^XLFSTR(ENFUND,6)_" Subtotal   "
 . . S ENX=ENX_"  Count: "_$J(ENC(ENSTA,ENFUND),3,0)
 . . S ENX=ENX_"  Value: "_$J("$"_$FN(ENT(ENSTA,ENFUND),",",2),16)
 . . D MES^XPDUTL(ENX)
 . . ; update station subtotals
 . . S ENC(ENSTA)=ENC(ENSTA)+ENC(ENSTA,ENFUND)
 . . S ENT(ENSTA)=ENT(ENSTA)+ENT(ENSTA,ENFUND)
 . ; report station subtotal
 . S ENX="    Station "_$$CJ^XLFSTR(ENSTA,5)_" Subtotal   "
 . S ENX=ENX_"  Count: "_$J(ENC(ENSTA),3,0)
 . S ENX=ENX_"  Value: "_$J("$"_$FN(ENT(ENSTA),",",2),16)
 . D MES^XPDUTL(ENX)
 . ; update grand totals
 . S ENC=ENC+ENC(ENSTA)
 . S ENT=ENT+ENT(ENSTA)
 ; report grand totals
 I ENC>0 D
 . S ENX="  Grand Total (All Stations) "
 . S ENX=ENX_"  Count: "_$J(ENC,3,0)
 . S ENX=ENX_"  Value: "_$J("$"_$FN(ENT,",",2),16)
 . D MES^XPDUTL(ENX)
 ;
 D BMES^XPDUTL("  Changing FUND of Equipment in Deactivated FUNDs...")
 D:'$D(^TMP($J,"ENDF")) MES^XPDUTL("    None found. No action taken.")
 ; init grand totals
 K ENC,ENT S (ENC,ENT)=0
 ; loop thru stations in TMP
 S ENSTA="" F  S ENSTA=$O(^TMP($J,"ENDF",ENSTA)) Q:ENSTA=""  D
 . D MES^XPDUTL("    For Station "_ENSTA)
 . ; init station subtotals
 . S (ENC(ENSTA),ENT(ENSTA))=0
 . ; loop thru funds in station
 . S ENFUND=""
 . F  S ENFUND=$O(^TMP($J,"ENDF",ENSTA,ENFUND)) Q:ENFUND=""  D
 . . ; init fund subtotals
 . . S (ENC(ENSTA,ENFUND),ENT(ENSTA,ENFUND))=0
 . . ; determine new fund
 . . S ENFUNDN=$S(ENFUND="8129G":"8129S",1:"AMAF")
 . . S ENFUNDNI=$O(^ENG(6914.6,"B",ENFUNDN,0))
 . . S ENX="      Moving equipment from "_ENFUND_" to "_ENFUNDN_" via FR"
 . . D MES^XPDUTL(ENX)
 . . I 'ENFUNDNI D MES^XPDUTL("ERROR: FUND "_ENFUNDN_" not in 6914.6!") Q
 . . ; loop thru SGLs in Fund
 . . S ENSGL=""
 . . F  S ENSGL=$O(^TMP($J,"ENDF",ENSTA,ENFUND,ENSGL)) Q:ENSGL=""  D
 . . . ; init sgl subtotal
 . . . S (ENC(ENSTA,ENFUND,ENSGL),ENT(ENSTA,ENFUND,ENSGL))=0
 . . . ; loop thru equipment in SGL
 . . . S ENDA=0
 . . . F  S ENDA=$O(^TMP($J,"ENDF",ENSTA,ENFUND,ENSGL,ENDA)) Q:'ENDA  D
 . . . . ; move equipment
 . . . . S ENX=$$XFUND^ENX1IPS1(ENDA,ENFUNDNI)
 . . . . I 'ENX D MES^XPDUTL("ERROR: Couldn't create the FR Document.")
 . . . . S ENAMT=$P($G(^ENG(6914,ENDA,2)),U,3)
 . . . . ; update SGL subtotals
 . . . . S ENC(ENSTA,ENFUND,ENSGL)=ENC(ENSTA,ENFUND,ENSGL)+1
 . . . . S ENT(ENSTA,ENFUND,ENSGL)=ENT(ENSTA,ENFUND,ENSGL)+ENAMT
 . . . . ; report action
 . . . . S ENX="          Equip #: "_$$LJ^XLFSTR(ENDA,10)
 . . . . S ENX=ENX_"  Fund: "_$$LJ^XLFSTR(ENFUND,6)
 . . . . S ENX=ENX_"  SGL: "_$$LJ^XLFSTR(ENSGL,4)
 . . . . S ENX=ENX_"  Value: "_$J("$"_$FN(ENAMT,",",2),16)
 . . . . D MES^XPDUTL(ENX)
 . . . ; report SGL subtotals
 . . . S ENX="        SGL "_ENSGL_" Subtotal                 "
 . . . S ENX=ENX_"  Count: "_$J(ENC(ENSTA,ENFUND,ENSGL),3,0)_"  Value: "
 . . . S ENX=ENX_$J("$"_$FN(ENT(ENSTA,ENFUND,ENSGL),",",2),16)
 . . . D MES^XPDUTL(ENX)
 . . . ; update fund subtotals
 . . . S ENC(ENSTA,ENFUND)=ENC(ENSTA,ENFUND)+ENC(ENSTA,ENFUND,ENSGL)
 . . . S ENT(ENSTA,ENFUND)=ENT(ENSTA,ENFUND)+ENT(ENSTA,ENFUND,ENSGL)
 . . ; report fund subtotal
 . . S ENX="      Fund "_$$CJ^XLFSTR(ENFUND,6)
 . . S ENX=ENX_" Subtotal                "
 . . S ENX=ENX_"  Count: "_$J(ENC(ENSTA,ENFUND),3,0)
 . . S ENX=ENX_"  Value: "_$J("$"_$FN(ENT(ENSTA,ENFUND),",",2),16)
 . . D MES^XPDUTL(ENX)
 . . ; update station totals
 . . S ENC(ENSTA)=ENC(ENSTA)+ENC(ENSTA,ENFUND)
 . . S ENT(ENSTA)=ENT(ENSTA)+ENT(ENSTA,ENFUND)
 . ; report station subtotals
 . S ENX="    Station "_$$CJ^XLFSTR(ENSTA,5)_" Subtotal                "
 . S ENX=ENX_"  Count: "_$J(ENC(ENSTA),3,0)
 . S ENX=ENX_"  Value: "_$J("$"_$FN(ENT(ENSTA),",",2),16)
 . D MES^XPDUTL(ENX)
 . ; update grand totals
 . S ENC=ENC+ENC(ENSTA),ENT=ENT+ENT(ENSTA)
 ; report grand totals
 I ENC>0 D
 . S ENX="  Grand Total (All Stations)              "
 . S ENX=ENX_"  Count: "_$J(ENC,3,0)
 . S ENX=ENX_"  Value: "_$J("$"_$FN(ENT,",",2),16)
 . D MES^XPDUTL(ENX)
 ;
 I '$D(^TMP($J,"ENADP")) D
 . D BMES^XPDUTL("  None of the Trust equipment that was moved from SGL 1754 to SGL 1750")
 . D MES^XPDUTL("  appears to be ADPE. No user action is required.")
 I $D(^TMP($J,"ENADP")) D
 . D BMES^XPDUTL("  Some of the Trust equipment that was moved from SGL 1754 to SGL 1750")
 . D MES^XPDUTL("  appears to be ADP equipment based on its category stock number (CSN).")
 . D MES^XPDUTL("  ADP equipment should be in SGL 1751 instead of 1750.")
 . D MES^XPDUTL("  You will need to manually update the SGL of this equipment using FD and")
 . D MES^XPDUTL("  FA Documents so that your local system, Fixed Assets, and FMS are updated.")
 . D MES^XPDUTL("    ADP Trust Equipment Currently in SGL 1750:")
 . S ENDA=0 F  S ENDA=$O(^TMP($J,"ENADP",ENDA)) Q:'ENDA  D
 . . S ENCSN=$$GET1^DIQ(6914,ENDA_",",18)
 . . S ENCSN("D")=$$GET1^DIQ(6914,ENDA_",","18:2")
 . . S ENX="      Equip #: "_ENDA_"  CSN: "_ENCSN_" ("_ENCSN("D")_")"
 . . D MES^XPDUTL(ENX)
 ;
 K ^TMP($J)
 Q
 ;
 ;ENX1IPS
