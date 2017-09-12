IBY400PR ;ALB/ESG - Pre-Installation for IB patch 400 ;27-Aug-2007
 ;;2.0;INTEGRATED BILLING;**400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 D DELLOC      ; delete local output formatter overrides
 D DELOF       ; delete all output formatter data elements included in build
 D CLEARINS    ; clear fields 36/4.11 & 36/.14
 ;
 Q
 ;
CLEARINS ; clear fields 4.11 and .14 in file 36
 N DA,DIE,DIK,DR,IEN
 S DIE="^DIC(36,",DR="4.11///@;.14///@"
 D BMES^XPDUTL("Clearing fields 4.11 and .14 for all entries in file 36 ... ")
 ; check if fields have already been updated
 I $$GET1^DID(36,4.11,"","LABEL")="USE VAMC AS BILL PROV ON 1500" D MES^XPDUTL("   Already cleared - nothing to do.") Q
 S IEN=0 F  S IEN=$O(^DIC(36,IEN)) Q:'IEN  S DA=IEN D ^DIE
 S DIK="^DD(36,",DA=4.11,DA(1)=36 D ^DIK
 S DIK="^DD(36,",DA=.14,DA(1)=36 D ^DIK
 D DELIX^DDMOD(399,135,2)   ; remove the trigger from #135 (current payer) to #.19 (form type)
 D MES^XPDUTL("   Done.")
 Q
 ;
DELLOC ; archive and delete local output formatter overrides for entries included with this build
 NEW IBY,FORM,IBX2,NI6,NI7,LI6,LI7,IBTOVZ,DIK,DA,SITE,XMTO,XMDUZ,XMSUBJ,XMBODY,LN,W,MSG,XMINSTR,PARENT,FBU,FOUND,FLD
 S IBY="P400-LOFO"   ; patch 400 local output formatter overrides
 KILL ^TMP($J,IBY)
 S IBTOVZ=0
 S ^TMP($J,IBY,1)=0
 D BMES^XPDUTL("Analyzing/Removing local output formatter overrides ... ")
 ;
 S FORM=13   ; start here to skip over the normal national form types
 F  S FORM=$O(^IBE(353,FORM)) Q:'FORM  D
 . S IBX2=$G(^IBE(353,FORM,2))
 . I $P(IBX2,U,2)="S" Q       ; only deal with local overrides on printed forms or transmitted forms
 . I $P(IBX2,U,4) Q           ; don't mess with national form types (should not be any here anyway)
 . ;
 . ; check and remove code from local forms
 . S PARENT=$P(IBX2,U,5)                    ; national parent form#
 . I $F(".2.3.8.","."_PARENT_".") D
 .. S FBU=$P($G(^IBE(353,PARENT,2)),U,8)    ; local form being used 353,2.08 field
 .. I FBU'=FORM Q
 .. S FOUND=0 F FLD=50:1:55 I $$GET1^DIQ(353,FORM_",",FLD)'="" S FOUND=1 Q    ; look for local code
 .. I FOUND D FDISP(FORM)    ; local code found - display and delete the local form data
 .. Q
 . ;
 . ; Check local overrides one by one
 . S NI6=0 F  S NI6=$O(^IBA(364.6,"APAR",FORM,NI6)) Q:'NI6  D
 .. S NI7=$O(^IBA(364.7,"B",NI6,0)) Q:'NI7
 .. I $P(IBX2,U,2)="P",'$$INCLUDE(6,NI6),'$$INCLUDE(7,NI7) Q    ; print - not included with this build
 .. I $P(IBX2,U,2)="T",$F(".55.57.","."_NI6_".") Q              ; edi - local overrides are only allowed for these 2
 .. S LI6=0 F  S LI6=$O(^IBA(364.6,"APAR",FORM,NI6,LI6)) Q:'LI6  D
 ... S LI7=0 F  S LI7=$O(^IBA(364.7,"B",LI6,LI7)) Q:'LI7  D
 .... D DISP(LI6,LI7)    ; display/archive local override data before deletion
 .... S DIK="^IBA(364.7,",DA=LI7 D ^DIK
 .... Q
 ... S DIK="^IBA(364.6,",DA=LI6 D ^DIK
 ... Q
 .. Q
 . Q
 ;
 ; nothing found so get out
 I '$G(^TMP($J,IBY,1)) D MES^XPDUTL("   No local overrides deleted.") G DELLOCX
 ;
 ; Construct the message scratch global and update data
 K ^TMP($J,IBY,2)
 S SITE=$$SITE^VASITE
 S XMDUZ=DUZ
 S XMSUBJ="IB*2*400 Override Archive - "_$P(SITE,U,3)_" - "_$P(SITE,U,2)
 S XMSUBJ=$E(XMSUBJ,1,65)
 S LN=0
 S LN=LN+1,^TMP($J,IBY,2,LN)="VistA patch IB*2*400 override archive for the following site:"
 S LN=LN+1,^TMP($J,IBY,2,LN)=""
 S LN=LN+1,^TMP($J,IBY,2,LN)="        Name: "_$P(SITE,U,2)
 S LN=LN+1,^TMP($J,IBY,2,LN)="    Station#: "_$P(SITE,U,3)
 S LN=LN+1,^TMP($J,IBY,2,LN)="      Domain: "_$G(^XMB("NETNAME"))
 S LN=LN+1,^TMP($J,IBY,2,LN)="   Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT,"5ZPM")
 S LN=LN+1,^TMP($J,IBY,2,LN)=""
 S LN=LN+1,^TMP($J,IBY,2,LN)="The following local output formatter overrides have been deleted."
 S LN=LN+1,^TMP($J,IBY,2,LN)=""
 S LN=LN+1,^TMP($J,IBY,2,LN)="Total number of overrides deleted: "_IBTOVZ
 S LN=LN+1,^TMP($J,IBY,2,LN)=""
 S LN=LN+1,^TMP($J,IBY,2,LN)="-----------------------------------------------------------------------------------------------"
 S LN=LN+1,^TMP($J,IBY,2,LN)=""
 ;
 ; loop through the "1" area and add the counts and add these lines to the "2" area
 S W=0 F  S W=$O(^TMP($J,IBY,1,W)) Q:'W  D
 . S MSG=$G(^TMP($J,IBY,1,W))
 . I $E(MSG,1,8)="Removing" S MSG=$P(MSG,")",1)_" of "_IBTOVZ_"):"
 . S LN=LN+1,^TMP($J,IBY,2,LN)=MSG
 . Q
 ;
 S XMBODY=$NA(^TMP($J,IBY,2))
 S XMTO(DUZ)=""
 S XMTO("G.IB EDI")=""
 S XMTO("G.PATCHES")=""
 I $$PROD^XUPROD(1) D                  ; we only want to see production data
 . S XMTO("Eric.Gustafson@domain.ext")=""
 . S XMTO("Yan.Gurtovoy@domain.ext")=""
 . S XMTO("Mary.Simons@domain.ext")=""
 . S XMTO("Mary.Caulfield2@domain.ext")=""
 . Q
 ;
 S XMINSTR("FROM")="IB*2*400 Pre-Install"
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR)
 KILL ^TMP($J,IBY)
 ;
DELLOCX ;
 D MES^XPDUTL("   Done.")
 Q
 ;
FDISP(FORM) ; display local form code on screen and in install file
 ; Archive and display information before killing it
 ; FORM - local form# in file 353
 ;
 NEW LN,MSG,NODE,GG,FL
 S IBTOVZ=IBTOVZ+1           ; increment total number of deleted overrides
 ;
 S LN=0
 S LN=LN+1,MSG(LN)="Removing local output formatter override ("_IBTOVZ_"):"
 S LN=LN+1,MSG(LN)="  The following nodes have been killed for this local form."
 S LN=LN+1,MSG(LN)="  Form: "_$P($G(^IBE(353,FORM,0)),U,1)_" (ien "_FORM_")"
 S LN=LN+1,MSG(LN)=""
 F NODE="EXT","FPOST","FPRE","OUT","POST","PRE" I $D(^IBE(353,FORM,NODE)) D
 . S LN=LN+1,MSG(LN)="  "_$NA(^IBE(353,FORM,NODE))_" = "_$G(^IBE(353,FORM,NODE))
 . K ^IBE(353,FORM,NODE)
 . Q
 ;
 S LN=LN+1,MSG(LN)="-----------------------------------------------------------------------------------------------"
 S LN=LN+1,MSG(LN)=""
 ;
 ; update mailman message array
 S GG=+$G(^TMP($J,IBY,1))    ; last line# used in scratch global
 F FL=1:1:LN S GG=GG+1,^TMP($J,IBY,1,GG)=$G(MSG(FL)),^TMP($J,IBY,1)=GG
 ;
 D MES^XPDUTL(.MSG)          ; display on screen and save in Install file
FDISPX ;
 Q
 ;
DISP(LI6,LI7) ; display local override data on screen and in install file
 ; This is the output formatter local override which is being deleted.  Archive and display all information.
 ; LI6 - local ien to file 364.6
 ; LI7 - local ien to file 364.7
 ;
 NEW LD6,NI6,ND6,LD70,LD71,NI7,INS,LDC,MSG,Q,LN,FL,GG
 S LD6=$G(^IBA(364.6,LI6,0)),NI6=+$P(LD6,U,3),ND6=$G(^IBA(364.6,NI6,0))
 S LD70=$G(^IBA(364.7,LI7,0)),LD71=$G(^IBA(364.7,LI7,1))
 S NI7=+$O(^IBA(364.7,"B",NI6,0))
 S INS=""
 I +$P(LD70,U,5) S INS=$$INSCO^IBCNSC02(+$P(LD70,U,5))   ; ins co name and address
 I INS="" S INS="All"
 M LDC=^IBA(364.7,LI7,3)    ; 364.7 wp description
 S IBTOVZ=IBTOVZ+1          ; increment total number of deleted overrides
 ;
 S LN=0
 S LN=LN+1,MSG(LN)="Removing local output formatter override ("_IBTOVZ_"):"
 S LN=LN+1,MSG(LN)="  "_$$EXTERNAL^DILFD(364.6,.01,"",$P(LD6,U,1))
 ;
 ; display different data based on print or transmit form
 I $P(IBX2,U,2)="P" S MSG(LN)=MSG(LN)_", line "_$P(ND6,U,5)_", column "_$P(ND6,U,8)_", length="_$P(ND6,U,9)
 I $P(IBX2,U,2)="T" S MSG(LN)=MSG(LN)_", sequence "_$P(ND6,U,4)_", piece "_$P(ND6,U,8)_", length="_$P(ND6,U,9)
 ;
 S LN=LN+1,MSG(LN)="  Local 364.6: "_$P(LD6,U,10)_" (ien "_LI6_")"
 S LN=LN+1,MSG(LN)="  Nat'l 364.6: "_$P(ND6,U,10)_" (ien "_NI6_")"
 S LN=LN+1,MSG(LN)="  Local 364.7: ien "_LI7
 S LN=LN+1,MSG(LN)="  Nat'l 364.7: ien "_NI7
 S LN=LN+1,MSG(LN)="         Form: "_$$EXTERNAL^DILFD(364.6,.01,"",$P(LD6,U,1))_" (ien "_$P(LD6,U,1)_")"
 S LN=LN+1,MSG(LN)=" Data Element: "_$$EXTERNAL^DILFD(364.7,.03,"",$P(LD70,U,3))
 S LN=LN+1,MSG(LN)=" Ins. Company: "_$E(INS,1,53)
 I $L(INS)>53 S LN=LN+1,MSG(LN)=$J("",42)_$E(INS,54,200)
 S LN=LN+1,MSG(LN)="    Bill Type: "_$S($P(LD70,U,6)'="":$$EXTERNAL^DILFD(364.7,.06,"",$P(LD70,U,6)),1:"Both")
 I $P(LD6,U,11) S LN=LN+1,MSG(LN)="  Output Type: "_$$EXTERNAL^DILFD(364.6,.11,"",$P(LD6,U,11))
 S LN=LN+1,MSG(LN)="  Format Code: "
 I $L(LD71)<220 S MSG(LN)=MSG(LN)_LD71    ; smaller format code length
 E  S LN=LN+1,MSG(LN)=LD71                ; big length - put it on a line by itself
 S LN=LN+1,MSG(LN)="  Description: "_$G(LDC(1,0))
 S Q=1 F  S Q=$O(LDC(Q)) Q:'Q  S LN=LN+1,MSG(LN)="               "_$G(LDC(Q,0))
 S LN=LN+1,MSG(LN)="-----------------------------------------------------------------------------------------------"
 S LN=LN+1,MSG(LN)=""
 ;
 ; update mailman message array
 S GG=+$G(^TMP($J,IBY,1))    ; last line# used in scratch global
 F FL=1:1:LN S GG=GG+1,^TMP($J,IBY,1,GG)=$G(MSG(FL)),^TMP($J,IBY,1)=GG
 ;
 D MES^XPDUTL(.MSG)          ; display on screen and save in Install file
DISPX ;
 Q
 ;
DELOF ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning or obsolete entries
 ; in file 364.6.
 S DIK="^IBA(364.6,",TAG="DEL6+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.6,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning or obsolete entries
 ; in file 364.7.
 S DIK="^IBA(364.7,",TAG="DEL7+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.7,DA,0)) D ^DIK
 . Q
 ;
DELOFX ;
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if output formatter entry should be
 ; included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 ;
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
INCLUDEX ;
 Q OK
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;^85^96^195^230^
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^45^166^174^180^193^1501^1502^1504^1505^1506^1507^1509^1513^1560^1561^1562^1563^1564^
 ;;^1710^1724^1910^1911^1912^1913^1914^1915^1916^
 ;;^1917^1918^1919^1920^1921^1922^1923^1924^1925^1926^1927^1928^1929^1930^1931^1932^1933^1934^1935^1936^
 ;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^6^27^132^145^146^147^148^149^150^156^157^159^160^199^203^390^392^945^948^949^954^1015^1054^1055^1056^1057^1100^
 ;;^1173^1174^1177^1178^1200^1201^1202^1204^1205^1206^1207^1209^1213^1215^1216^1217^1218^1252^1253^1254^
 ;;^1255^1256^1257^1258^1259^1260^1261^1262^1263^1264^1266^1298^1302^1314^1315^1339^1346^1347^1348^1349^
 ;;^1350^1351^1352^1353^1354^1355^1356^1357^1358^1359^1360^1371^1407^1408^1409^1410^1411^1412^1413^1414^
 ;;^1415^1424^1610^1611^1612^1613^1614^1615^1616^1617^1618^1619^1620^1621^1622^1623^1624^1625^1626^1627^
 ;;^1628^1629^1630^1631^1632^1633^1634^1635^1636^
 ;
 ;
 ;-----------------------------------------------------------------------
DEL6 ; remove output formatter entries in file 364.6 (not re-added)
 ;
 ;;^1510^1511^1512^1848^1849^
 ;
 ;-----------------------------------------------------------------------
DEL7 ; remove output formatter entries in file 364.7 (not re-added)
 ;
 ;;^1210^1211^1212^1548^1549^
 ;
