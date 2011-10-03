GMVUID ;HIOFO/FT-VUID-RELATED UTILITIES ;5/3/05  11:48
 ;;5.0;GEN. MED. REC. - VITALS;**8**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;  #2263 - XPAR calls     (supported)
 ;  #4631 - XTID calls     (supported)
 ; #10070 - ^XMD           (supported)
 ;  #4640 - ^HDISVF01      (supported)
 ;
EN(ERROR) ; Clean up existing file connections and gui templates
 ;
 I ERROR D QMAIL Q
 N FILE,OK
 S OK=1
 F FILE=120.51,120.52,120.53 I '$$SCREEN^HDISVF01(FILE) S OK=0
 Q:'OK
 D QUAL,CAT,TEMPS
 Q
QMAIL ; Queue mail message
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="MAIL^GMVUID",ZTDESC="GMRV VITALS VUID ERROR"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
MAIL ; Send mail message to installer that an error occurred
 N GMVMSG,XMDUZ,XMSUB,XMTEXT,XMY
 S XMY(DUZ)=""
 S XMDUZ=.5 ;message sender
 S XMSUB="ERROR IN VITALS VUID UPDATE"
 S GMVMSG(1)="An error occurred while updating the VUID data for the"
 S GMVMSG(2)="GEN. MED. REC. - VITALS package files. "
 S GMVMSG(3)=" "
 S GMVMSG(4)="Please log a Remedy ticket immediately. "
 S XMTEXT="GMVMSG("
 D ^XMD
 Q
QUAL ; Loop through the Qualifier entries in FILE 120.52:
 ; 1) If the QUALIFIER is not active, get rid of all VITAL TYPE (#1)
 ;    associations,
 ; 2) If the QUALIFIER is active and a VITAL TYPE is not active, get rid
 ;    of that VITAL TYPE association,
 ; 3) If the QUALIFIER and VITAL TYPE are active, but the CATEGORY 
 ;    (#.02 in subfile 120.521) is not, get rid of that subfile entry.
 ;
 N GMVNODE,GMVQUAL,GMVT
 S GMVQUAL=0
 F  S GMVQUAL=$O(^GMRD(120.52,GMVQUAL)) Q:'GMVQUAL  D
 .I $$ACTIVE(120.52,"",GMVQUAL_",","") D  Q  ;see #1 above
 ..S GMVT=0
 ..F  S GMVT=$O(^GMRD(120.52,GMVQUAL,1,GMVT)) Q:'GMVT  D
 ...D QUAL1(GMVQUAL,GMVT)
 ...Q
 ..Q
 .S GMVT=0
 .F  S GMVT=$O(^GMRD(120.52,GMVQUAL,1,GMVT)) Q:'GMVT  D
 ..S GMVNODE=$G(^GMRD(120.52,GMVQUAL,1,GMVT,0))
 ..S GMVTY=$$ACTIVE(120.51,"",+$P(GMVNODE,U)_",","")
 ..I GMVTY D
 ...D QUAL1(GMVQUAL,GMVT)
 ...Q
 ..I 'GMVTY D
 ...S GMVNODE=$G(^GMRD(120.52,GMVQUAL,1,GMVT,0))
 ...Q:GMVNODE=""
 ...I $$ACTIVE(120.53,"",$P(GMVNODE,U,2)_",","") D
 ....D QUAL1(GMVQUAL,GMVT)
 ....Q
 ...Q
 ..Q
 .Q
 Q
QUAL1(GMVX,GMVY) ; Delete a multiple entry (#1) in FILE 120.52
 N DA,DIK
 S DA(1)=GMVX,DA=GMVY,DIK="^GMRD(120.52,"_DA(1)_",1,"
 D ^DIK
 Q
CAT ; Loop through the Category entries in FILE 120.53:
 ; 1) If the CATEGORY is not active, get rid of all VITAL TYPE (#1)
 ;    associations,
 ; 2) If the CATEGORY is active and a VITAL TYPE is not active, get rid
 ;    of that VITAL TYPE association,
 ; 3) If the CATEGORY and VITAL TYPE are active, but the DEFAULT
 ;    QUALIFIER (#.07) is not, null out the DEFAULT QUALIFIER field.
 ;
 N GMVCAT,GMVNODE,GMVT,GMVTI,GMVTY
 S GMVCAT=0
 F  S GMVCAT=$O(^GMRD(120.53,GMVCAT)) Q:'GMVCAT  D
 .I $$ACTIVE(120.53,"",GMVCAT_",","") D  Q  ;see #1 sbove
 ..S GMVT=0
 ..F  S GMVT=$O(^GMRD(120.53,GMVCAT,1,GMVT)) Q:'GMVT  D
 ..D CAT1(GMVCAT,GMVT)
 ..Q
 .;The CATEGORY is active, but check if the VITAL TYPE is active.
 .S GMVT=0
 .F  S GMVT=$O(^GMRD(120.53,GMVCAT,1,GMVT)) Q:'GMVT  D
 ..S GMVTI=+$P($G(^GMRD(120.53,GMVCAT,1,GMVT,0)),U,1)
 ..S GMVTY=$$ACTIVE(120.51,"",GMVTI_",","")
 ..I GMVTY D  ;see #2 above
 ...D CAT1(GMVCAT,GMVT)
 ...Q
 ..I 'GMVTY D
 ...S GMVNODE=$G(^GMRD(120.53,GMVCAT,1,GMVT,0))
 ...Q:GMVNODE=""
 ...Q:$P(GMVNODE,U,7)=""
 ...I $$ACTIVE(120.52,"",$P(GMVNODE,U,7)_",","") D  ;see #3 above
 ....D CAT2(GMVCAT,GMVT)
 ....Q
 ...Q
 ..Q
 .Q
 Q
CAT1(GMVX,GMVY) ; Delete a multiple entry (#1) in FILE 120.53
 N DA,DIK
 S DA(1)=GMVX,DA=GMVY,DIK="^GMRD(120.53,"_DA(1)_",1,"
 D ^DIK
 Q
CAT2(GMVX,GMVY) ; Delete a default qualifier
 Q:'GMVX
 Q:'GMVY
 S $P(^GMRD(120.53,GMVX,1,GMVY,0),U,7)=""
 Q
ACTIVE(GMVFILE,GMVFLD,GMVIEN,GMVDATE) ; Calls the $$SCREEN^XTID API to get VUID status
 ; Input: GMVFILE - File number
 ;         GMVFLD - Field number
 ;         GMVIEN - IEN
 ;        GMVDATE - Date
 ; Output: 0 - Active
 ;         1 - Inactive 
 Q $$SCREEN^XTID(GMVFILE,GMVFLD,GMVIEN,GMVDATE)
 ;
GET(GMVFILE,GMVIEN,GMVREF) ; Calls the $$GETVUID^XTID API to get the VUID number
 ; GMVFILE - File number
 ; GMVIEN  - field #
 ; GMVREF  - value
 N GMVUID
 S GMVUID=$$GETVUID^XTID(GMVFILE,GMVIEN,GMVREF)
 Q $P(GMVUID,U,1)
 ;
TEMPS ; Clean up GUI templates definitions.
 ; If a qualifier is inactive, remove it and its category.
 N GMV,GMV1,GMV2,GMVDESC,GMVERR,GMVI,GMVJ,GMVLIST,GMVNEW,GMVNODE,GMVOLD,GMVORIG,GMVQUAL,GMVX,GMVY
 K ^TMP($J)
 S GMVLIST=$NA(^TMP($J))
 D ENVAL^XPAR(.GMVLIST,"GMV TEMPLATE","","",1)
 Q:'$D(^TMP($J))
 S GMV1="" ; ien;file
 F  S GMV1=$O(^TMP($J,GMV1)) Q:GMV1=""  D
 .S GMV2="" ;template name
 .F  S GMV2=$O(^TMP($J,GMV1,GMV2)) Q:GMV2=""  D
 ..S (GMVNODE,GMVORIG)=$G(^TMP($J,GMV1,GMV2))
 ..Q:GMVNODE=""
 ..S GMVDESC=$P(GMVNODE,"|",1) ;template description
 ..S GMVNODE=$P(GMVNODE,"|",2)
 ..K GMV ;array of vital types
 ..F GMVI=1:1 Q:$P(GMVNODE,";",GMVI)=""  S GMV(GMVI)=$P(GMVNODE,";",GMVI)
 ..S GMVI=0
 ..F  S GMVI=$O(GMV(GMVI)) Q:'GMVI  D
 ...S GMVX=GMV(GMVI)
 ...Q:GMVX=""
 ...S GMVY=$P(GMVX,":",1,2) ;vital ien:metric indicator
 ...S GMVX=$P(GMVX,":",3) ;~categories,qualifiers~
 ...Q:GMVX=""
 ...S GMVNEW=""
 ...F GMVJ=1:1 Q:$P(GMVX,"~",GMVJ)=""  D
 ....S GMVOLD=$P(GMVX,"~",GMVJ) ;each category & qualifier combo
 ....S GMVQUAL=$P(GMVOLD,",",2) ;qualifier
 ....I '$$ACTIVE(120.52,"",GMVQUAL_",",""),$$COMBO($P(GMVY,":",1),GMVQUAL,$P(GMVOLD,",",1)) S GMVNEW=GMVNEW_GMVOLD_"~" ;active qualifier & right combination of type, qualifier and category
 ...I $E(GMVNEW,$L(GMVNEW))="~" S GMVNEW=$E(GMVNEW,1,($L(GMVNEW)-1))
 ...S:GMVNEW]"" GMVNEW=GMVY_":"_GMVNEW
 ...S:GMVNEW="" GMVNEW=GMVY
 ...S GMV(GMVI)=GMVNEW
 ..S GMVI=0,GMVNODE=GMVDESC_"|"
 ..F  S GMVI=$O(GMV(GMVI)) Q:'GMVI  D
 ...S GMVNODE=GMVNODE_GMV(GMVI)_";"
 ...Q
 ..I $E(GMVNODE,$L(GMVNODE))=";" S GMVNODE=$E(GMVNODE,1,($L(GMVNODE)-1))
 ..I $E(GMVNODE,$L(GMVNODE))="|" S GMVNODE=$E(GMVNODE,1,($L(GMVNODE)-1))
 ..I GMVNODE=GMVORIG Q  ;no change in template
 ..D EN^XPAR(GMV1,"GMV TEMPLATE",GMV2,GMVNODE,.GMVERR)
 ..Q
 .Q
 K ^TMP($J)
 Q
COMBO(GMVTI,GMVQUALI,GMVCATI) ; Check if this combination is in the AA cross-
 ; reference of File 120.52
 ; Input:
 ;     GMVTI - File 120.51 ien
 ;  GMVQUALI - File 120.52 ien
 ;   GMVCATI - File 120.53 ien
 N GMVFLAG,GMVQUALE
 S GMVFLAG=0
 S GMVTI=+$G(GMVTI),GMVQUALI=+$G(GMVQUALI),GMVCATI=+$G(GMVCATI)
 I 'GMVTI!(GMVQUALI'>0)!(GMVCATI'>0) Q GMVFLAG
 S GMVQUALE=$P($G(^GMRD(120.52,GMVQUALI,0)),U,1)
 I GMVQUALE="" Q GMVFLAG
 I $D(^GMRD(120.52,"AA",GMVTI,GMVCATI,GMVQUALE,GMVQUALI)) S GMVFLAG=1
 Q GMVFLAG
 ;
