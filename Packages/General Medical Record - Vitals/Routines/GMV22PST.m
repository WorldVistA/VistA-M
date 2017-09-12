GMV22PST ;HOIFO/FT-POST INSTALLATION FOR GMRV*5*22 ; 10/4/07 7:54am
 ;;5.0;GEN. MED. REC. - VITALS;**22**;Oct 31, 2002;Build 22
 ;
 ; This routine uses the following IAs:
 ; #2263  - XPAR calls                  (supported)
 ; #10141 - XPDUTL calls                (supported)
 ;
EN ; Main entry point
 D XPAR,DLL,STANDING,TEMPLATE,WEBLINK
 Q
XPAR ; Setup preliminary parameters. This subroutine is called during the
 ; KIDS installation process.
 ;
 ; Variables:
 ;  GMV:    [Private] Scratch
 ;  GMVGUI: [Private] Current version of GUI being installed
 ;  GMVLST: [Private] Scratch List
 ;
 ; NEW private variables
 N GMV,GMVGUI,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating system parameters.")
 ; Set current client version
 S GMVGUI="5.0.22.7"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV GUI VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 .D EN^XPAR("SYS","GMV GUI VERSION",$P(GMVLST(GMV),"^",1),0)
 .Q
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","GMV GUI VERSION","VITALS.EXE:"_GMVGUI,1)
 D EN^XPAR("SYS","GMV GUI VERSION","VITALSMANAGER.EXE:"_GMVGUI,1)
 Q
STANDING ; Disassociate STANDING qualifier from WEIGHT vital type
 N GMVCAT,GMVDA,GMVERR,GMVFDA,GMVIENS,GMVQUAL,GMVT
 D BMES^XPDUTL("Checking STANDING qualifier...")
 S GMVT=$O(^GMRD(120.51,"B","WEIGHT",0))
 Q:'GMVT
 S GMVQUAL=$O(^GMRD(120.52,"B","STANDING",0))
 Q:'GMVQUAL
 S GMVCAT=$O(^GMRD(120.53,"B","METHOD",0))
 Q:'GMVCAT
 I $D(^GMRD(120.52,GMVQUAL,1,"B",GMVT)) D
 .S GMVDA=$O(^GMRD(120.52,GMVQUAL,1,"B",GMVT,0))
 .Q:'GMVDA
 .N DA,DIK
 .S DA(1)=GMVQUAL,DA=GMVDA
 .S DIK="^GMRD(120.52,DA(1),1,"
 .D ^DIK
 .Q
 I $D(^GMRD(120.53,GMVCAT,1,"B",GMVT)) D
 .S GMVDA=$O(^GMRD(120.53,GMVCAT,1,"B",GMVT,0))
 .Q:'GMVDA
 .S GMVIENS=GMVDA_","_GMVCAT_","
 .S GMVFDA(120.531,GMVIENS,.07)="@"
 .D FILE^DIE("","GMVFDA","GMVERR")
 .;I
 .Q
 Q
TEMPLATE ; remove STANDING from template if used with WEIGHT and METHOD
 N GMV,GMV1,GMV2,GMVCQ,GMVDESC,GMVI,GMVJ,GMVLIST,GMVMETHD,GMVNEW,GMVNODE,GMVOLD,GMVORIG,GMVSTAND,GMVWT,GMVX,GMVY
 D BMES^XPDUTL("Checking input template definitions...")
 S GMVWT=$O(^GMRD(120.51,"C","WT",0))
 Q:'GMVWT
 S GMVMETHD=$O(^GMRD(120.53,"B","METHOD",0))
 Q:'GMVMETHD
 S GMVSTAND=$O(^GMRD(120.52,"B","STANDING",0))
 Q:'GMVSTAND
 K ^TMP($J)
 S GMVLIST=$NA(^TMP($J))
 D ENVAL^XPAR(.GMVLIST,"GMV TEMPLATE","","",1)
 Q:'$D(^TMP($J))
 S GMVCQ=GMVMETHD_","_GMVSTAND
 S GMV1="" ; ien;file
 F  S GMV1=$O(^TMP($J,GMV1)) Q:GMV1=""  D
 .S GMV2="" ;template name
 .F  S GMV2=$O(^TMP($J,GMV1,GMV2)) Q:GMV2=""  D
 ..S (GMVNODE,GMVORIG)=$G(^TMP($J,GMV1,GMV2))
 ..Q:GMVNODE=""
 ..Q:GMVNODE'[GMVCQ  ;ignore templates that don't matter
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
 ....I $P(GMVY,":",1)=GMVWT,GMVOLD=GMVCQ Q 
 ....S GMVNEW=GMVNEW_GMVOLD_"~"
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
 ..W !,GMVNODE
 ..W !,GMVORIG,!
 ..D EN^XPAR(GMV1,"GMV TEMPLATE",GMV2,GMVNODE,.GMVERR)
 ..Q
 .Q
 K ^TMP($J)
 Q
WEBLINK ; Update web link used by HELP menu
 ; Don't change weblink if site has replaced our weblink with something
 ; else (i.e., their own)
 N GMVNEW,GMVOLD
 S GMVOLD="http://vista.domain.ext/ClinicalSpecialties/vitals/"
 S GMVNEW="http://vista.domain.ext/ClinicalSpecialties/vitals/index.asp"
 D RPC^GMVPAR(.GMVX,"GETPAR","SYS","GMV WEBLINK") ;get current link
 I $G(^TMP($J,0))=GMVOLD D
 .D EN^XPAR("SYS","GMV WEBLINK",1,GMVNEW)
 .Q
 Q
DLL ;
 ; Variables:
 ;  GMV:    [Private] Scratch
 ;  GMVDLL: [Private] Current version of DLL being installed
 ;  GMVLST: [Private] Scratch List
 ;
 ; New private variables
 N GMV,GMVDLL,GMVLST
 ; Announce my intentions
 D BMES^XPDUTL("Updating DLL parameter.")
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.GMVLST,"SYS","GMV DLL VERSION")
 F GMV=0:0 S GMV=$O(GMVLST(GMV)) Q:'GMV  D
 .D EN^XPAR("SYS","GMV DLL VERSION",$P(GMVLST(GMV),"^",1),0)
 ; Add and/or activate current client versions
 S GMVDLL="GMV_VITALSVIEWENTER.DLL:v. 03/14/06 16:35" ;patch 3
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 S GMVDLL="GMV_VITALSVIEWENTER.DLL:v. 05/12/08 08:44" ;patch 22
 D EN^XPAR("SYS","GMV DLL VERSION",GMVDLL,1)
 Q
