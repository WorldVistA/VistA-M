DG17201 ;BHM/RGY,ALS-Find and save all files pointing to religion and marital status files ;FEB 20,1998
 ;;5.3;Registration;**172**;Aug 13, 1993
CF ;
 NEW FILE,FIELD,CONV
 K ^TMP("DG11N13",$J)
 F CONV=11,13 F FILE=0:0 S FILE=$O(^DD(CONV,0,"PT",FILE)) Q:FILE=""  F FIELD=0:0 S FIELD=$O(^DD(CONV,0,"PT",FILE,FIELD)) Q:FIELD=""  D ADD(FILE,FIELD,CONV)
 D:$D(^TMP("DG11N13",$J)) CONVMSG
 K ^TMP("DG11N13",$J)
 Q
ADD(FILE,FIELD,TYPE) ;
 NEW PIECE,NODE,GLOB,GLLOC
 I FILE=""!(FIELD="") Q
 I FILE=390.2 Q
 D FIELD^DID(FILE,FIELD,"","GLOBAL SUBSCRIPT LOCATION","GLLOC")
 S PIECE=$P($G(GLLOC("GLOBAL SUBSCRIPT LOCATION")),";",2)
 I PIECE="" D CONVF(FILE,FIELD,"Unknown/Invalid pointer, DD("_CONV_",0,""PT"","_FILE_","_FIELD_").") Q
 S NODE=$P($G(GLLOC("GLOBAL SUBSCRIPT LOCATION")),";")
 I NODE="" D CONVF(FILE,FIELD,"Unknown/Invalid pointer, DD("_CONV_",0,""PT"","_FILE_","_FIELD_").") Q
 S GLOB=$P($$GET1^DID(FILE,"","","GLOBAL NAME"),U,2) I GLOB="" D NOCONV(FILE,FIELD) Q
 S EN=$$ADD^DG17202(390.1)
 S DIE="^XTMP(""DGTMP"",390.1,",DR="[DG172 NEW ENTRY]",DA=EN D ^DIE
 K DIE,DR,DA,EN,X
 K ^TMP("DIERR",$J)
 Q
NOCONV(FILE,FIELD) ;CONVERTING FILE 11 AND 13 NON-STANDARD ENTRIES
 N SUBX,SUB,PIECE,GLLOC,SUBFILE
 S SUB(0)=FILE_"^"_FIELD
 I '$D(^DD(FILE,0,"UP")) D CONVF(FILE,FIELD,"Unknown/Invalid pointer, DD("_CONV_",0,""PT"","_FILE_","_FIELD_").") Q
 I $D(^DD(FILE,0,"UP")) S SUB=1,SUBFILE=FILE F  S:$D(^DD(SUBFILE,0,"UP")) SUB(SUB)=^DD(SUBFILE,0,"UP"),SUBFILE=SUB(SUB),SUB=SUB+1 Q:'$D(^DD(SUBFILE,0,"UP"))
 S SUBX=$O(SUB(" "),-1) I SUBX>0 D CONVF(FILE,FIELD,"Cannot convert the "_$P(^DD(FILE,0),U)_" in the "_$$GET1^DID(SUB(SUBX),"","","NAME")_" File.",.SUB)
 Q
CONVF(FILE,FIELD,TXT,SUB) ;
 N X,LAST
 S ^TMP("DG11N13",$J,CONV,$O(^TMP("DG11N13",$J,CONV," "),-1)+1)=FILE_"^"_FIELD_"^"_TXT_"^"
 S LAST=$O(^TMP("DG11N13",$J,CONV," "),-1)
 I '$D(SUB) S ^TMP("DG11N13",$J,CONV,LAST)=^TMP("DG11N13",$J,CONV,LAST)_FILE
 I $D(SUB) S X=0,LAST=$O(^TMP("DG11N13",$J,CONV," "),-1) F X=$O(SUB(" "),-1):-1:0 S ^TMP("DG11N13",$J,CONV,LAST)=^TMP("DG11N13",$J,CONV,LAST)_$P(SUB(X),U)_"/"
 Q
CONVMSG ;send file 11 and 13 conversion problem message
 N HDR,DGX,SPACE,DGY,STRG,CONV
 S SPACE=""
 S DGY=1
 S STRG="        File 11 and 13 Conversion Problem list" D STRING(STRG,.DGY)
 S STRG=" " F X=1:1:2 D STRING(STRG,.DGY)
 F CONV=11,13 D
 .S STRG=$S(CONV=11:"MARITAL STATUS (#11) File Conversion Problems:",CONV=13:"RELIGION (#13) File Converion Problems:",1:"") D STRING(STRG,.DGY)
 .S STRG=" " F X=1:1:2 D STRING(STRG,.DGY)
 .I '$D(^TMP("DG11N13",$J,CONV)) S STRG="No problems" D STRING(STRG,.DGY) Q
 .D CONVHDR
 .S DGX=0 F  S DGX=$O(^TMP("DG11N13",$J,CONV,DGX)) Q:'DGX  D
 ..S STRG="",SPACE=""
 ..F X=1:1 S STRG=$S(X>1:SPACE,1:"")_$P($P(^TMP("DG11N13",$J,CONV,DGX),U,4),"/",X) Q:X=$L($P(^TMP("DG11N13",$J,CONV,DGX),U,4),"/")  D
 ...I X<$L($P(^TMP("DG11N13",$J,CONV,DGX),U,4),"/") D STRING(STRG,.DGY)
 ...S SPACE=SPACE_" "
 ..S SPACE="",STRG=STRG_"^"_$P(^TMP("DG11N13",$J,CONV,DGX),U,2)_"^"_$P(^TMP("DG11N13",$J,CONV,DGX),U,3) D STRING(STRG,.DGY)
 .S STRG=" " F X=1:1:2 D STRING(STRG,.DGY)
 D MAILMSG
 Q
CONVHDR ;
 S STRG="Pointer File/Subfile^Field^Problem Description" D STRING(STRG,.DGY)
 S STRG="-------------------------------------------------------------------" D STRING(STRG,.DGY)
 Q
STRING(STR,DGY) ;convert string into column display
 N RST ;result
 N X
 S RST=$P(STR,U)
 I $P($G(STR),U,2)="" S DGY(DGY)=RST,DGY=DGY+1 Q
 F X=$L(RST):1:25 S RST=RST_" "
 ;format field start column at 25
 S RST=RST_$P(STR,U,2)
 I $P($G(STR),U,3)="" S DGY(DGY)=RST,DGY=DGY+1 Q
 F X=$L(RST):1:35 S RST=RST_" "
 ;format problem description start each line at 35
 F  Q:($L(RST)+$L($P(STR,U,3)))<78  D
 .S RST=RST_$P(STR,U,3)
 .S STR="",$P(STR,U,3)=$E(RST,79,120)
 .S RST=$E(RST,1,78) S DGY(DGY)=RST,DGY=DGY+1
 .S RST="" F X=1:1:35 S RST=RST_" "
 .S RST=RST_$P(STR,U,3),$P(STR,U,3)=""
 S DGY(DGY)=RST,DGY=DGY+1
 Q
MAILMSG ;send problem message to user that started task
 S XMDUZ="DG*5.3*172",XMTEXT="DGY(",XMY(DUZ)="",XMSUB="File 11 and 13 Conversion Problems"
 N DIFROM D ^XMD K XMTEXT,XMY,XMSUB,XMDUZ,XMZ
 Q
