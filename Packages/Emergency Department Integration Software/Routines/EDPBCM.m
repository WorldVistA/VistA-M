EDPBCM ;SLC/KCM - Available color maps ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LOAD(AREA) ; Load Color Spec
 N I,TOKEN
 ;
 D READL^EDPBLK(AREA,"color",.TOKEN)  ; read color config -- LOCK
 D XML^EDPX("<colorToken>"_TOKEN_"</colorToken>")
 D XML^EDPX("<colorSpec>")
 S I=0 F  S I=$O(^EDPB(231.9,AREA,3,I)) Q:'I  D
 . D XML^EDPX(^EDPB(231.9,AREA,3,I,0))
 D XML^EDPX("</colorSpec>")
 D READU^EDPBLK(AREA,"color",.TOKEN)  ; read color config -- UNLOCK
 Q
SAVE(REQ) ; Save Configuration
 N X,WP,AREA,TOKEN,LOCKERR,DIERR
 S X="xml-",AREA=$G(REQ("area",1))
 I 'AREA D SAVERR^EDPX("fail","Missing area") Q
 ;
 S TOKEN=$G(REQ("colorToken",1))
 D SAVEL^EDPBLK(AREA,"color",.TOKEN,.LOCKERR)  ; save color config -- LOCK
 I $L(LOCKERR) D SAVERR^EDPX("collide",LOCKERR),LOAD(AREA) Q
 ;
 F  S X=$O(REQ(X)) Q:$E(X,1,4)'="xml-"  S WP(+$P(X,"-",2))=REQ(X,1)
 D WP^DIE(231.9,AREA_",",3,"","WP")
 D SAVEU^EDPBLK(AREA,"color",.TOKEN)           ; save color config -- UNLOCK
 ;
 I $D(DIERR) D SAVERR^EDPX("fail","save failed") Q
 D XML^EDPX("<save status='ok' />")
 D LOAD(AREA)  ; return updated list of colors
 D UPDLAST^EDPBCF(AREA) ; update last config date
 Q
COLORS ;; Available Color Maps
 D ENMAP("none"," ","none")  ; for no selection
 ;
 D ENMAP("stsAcuity","Status / Acuity","val")
 D CODES("status"),CODES("acuity"),EXMAP
 ;
 D ENMAP("status","Status","val")
 D CODES("status"),EXMAP
 ;
 D ENMAP("acuity","Acuity","val")
 D CODES("acuity"),EXMAP
 ;
 D ENMAP("bed","Room / Bed","bed")
 D ENMAP("md","Provider","staff")
 D ENMAP("res","Resident","staff")
 D ENMAP("rn","Nurse","staff")
 ;
 D ENMAP("labUrg","Urgency - Lab","val")
 D URG("labUrg"),EXMAP
 ;D ENMAP("medUrg","Urgency - Medications","val")
 ;D URG("medUrg"),EXMAP
 D ENMAP("radUrg","Urgency - Radiology","val")
 D URG("radUrg"),EXMAP
 ;
 D ENMAP("emins","Total Elapsed Minutes","rng")
 D ENMAP("lmins","Minutes at Location","rng")
 D ENMAP("minLab","Minutes for Lab Order","rng")
 ;D ENMAP("minMed","Minutes for Medication Order","rng")
 D ENMAP("minRad","Minutes for Imaging Order","rng")
 D ENMAP("minVer","Minutes for Unverified Order","rng")
 Q
ENMAP(ID,NM,TYP) ; create element for colormap
 N X,END
 S END="/" S:TYP="val" END=""
 S X("id")=ID
 S X("nm")=NM
 S X("type")=TYP
 D XML^EDPX($$XMLA^EDPX("colors",.X,END))
 Q
EXMAP ; create closing tag
 D XML^EDPX("</colors>")
 Q
CODES(NM) ; create map elements for a set of codes
 N CODESET,IEN
 ; bwf - placed $G around EDPSTA to pervent undefined - commented original line below
 S CODESET=$G(EDPSTA)_"."_NM
 ;S CODESET=EDPSTA_"."_NM
 ; bwf - end changes
 I '$D(^EDPB(233.2,"B",CODESET)) S CODESET="edp."_NM
 S IEN=$O(^EDPB(233.2,"B",CODESET,0))
 Q:'IEN
 ;
 N SEQ,CODE,DA
 S SEQ=0 F  S SEQ=$O(^EDPB(233.2,IEN,1,"B",SEQ)) Q:'SEQ  D
 . S DA=0 F  S DA=$O(^EDPB(233.2,IEN,1,"B",SEQ,DA)) Q:'DA  D
 . . S CODE=$P(^EDPB(233.2,IEN,1,DA,0),U,2)
 . . Q:'CODE
 . . D MAP(NM,CODE,$P(^EDPB(233.1,CODE,0),U,2))
 Q
URG(ATT) ; create map elements for standard urgencies
 D MAP(ATT,0,"No Orders")
 D MAP(ATT,1,"Active Orders")
 D MAP(ATT,2,"STAT Orders")
 Q
MAP(ATT,VAL,NM) ; create a single map element
 N X
 S X("att")="@"_ATT
 S X("val")=VAL
 S X("nm")=NM
 S X("clr")=0
 D XML^EDPX($$XMLA^EDPX("map",.X))
 Q
LIST ; Build selection list for color maps -- OBSOLETE?
 N I,X
 F I=1:1 S X=$P($T(MAPLST+I),";",3,99) Q:$E(X,1,5)="zzzzz"  D
 . S X("data")=$P(X,U,1),X("label")=$P(X,U,2)
 . D XML^EDPX($$XMLA^EDPX("colors",.X))
 Q
MAPLST ; list of available color maps
 ;;^ ^
 ;;stsAcuity^Status / Acuity
 ;;status^Status
 ;;acuity^Acuity
 ;;bed^Room / Bed
 ;;staff^Staff
 ;;labUrg^Urgency - Lab
 ;;radUrg^Urgency - Imaging
 ;;emins^Total Minutes
 ;;lmins^Minutes at Location
 ;;minLab^Minutes for Lab Order
 ;;minRad^Minutes for Imaging Order
 ;;minVer^Minutes for Unverified Order
 ;;zzzzz
