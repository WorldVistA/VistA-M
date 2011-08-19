IBDFBKS ;ALB/CJM/AAS - Create form spec file for scanning ; 6-JUN-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25**;APR 24, 1997
 ;
SCAN(IBFORMID) ;
 ;
 Q:'$G(IBFORMID)
 N IBLC,PERPAGE,PAGE,ROW,COL,PAGESIZE,SCAN,ARY,X,Y,ROWHT,ROWWIDTH,CONVERT,COUNT,LINE,TAG,NAME,XOFFSET,YOFFSET,NODE,FID,TYPE,XBUBOS,YBUBOS,COUNT,YHANDOS,FIELD,IEN,QLFR,PRIORPAG,END,LN,FIELDS,IBDFILL,IBDBKGND,XYSMALL
 ;XOFFSET,YOFFSET are the page margins (in decipoints)
 ;XBUBOS,YBUBOS are the offsets within the col,row of the bubbles
 ;YHANDOS is the offset for a handprint field within the row
 ;
 I '$D(DT) D DT^DICRW
 I $D(^IBD(359.2,IBFORMID,0)),$D(^IBD(357.95,IBFORMID,0)) S DIK="^IBD(359.2,",DA=IBFORMID D ^DIK
 I '$D(DT) D DT^DICRW
 S IBLC=0
 D PARAM
 S CONVERT=.352778 ;for converting PCL decipoints to .1mm
 ; This number is actually 254/720 ... 254 PK points (.1 mm) = 1 inch
 ;                                     720 PCL5 decipoints = 1 inch
 ;     A PCL5 decipoint = .352778 PK points
 S SCAN="^TMP(""IBDF"",$J,""SCAN"",IBFORMID)"
 K @SCAN
 ;
 S FIELDS="^TMP(""IBDF"",$J,""FIELDS"")"
 K @FIELDS
 ;
 ;get form description
 S NODE=$G(^IBD(357.95,IBFORMID,0))
 Q:NODE=""
 S PERPAGE=$P(NODE,"^",10)
 ;determine sizes and offsets - in terms of PCL decipoints
 S XOFFSET=180 ; This is 1/4 inch ... .25*720 PCL decipoints
 S YOFFSET=360 ; This is 1/2 inch ... .5*720 PCL decipoints
 ; rowht = # of PCL decipoints/line in height
 ;   80 lines (133 Col) = 720/8 lines per inch)
 ;   72 lines (96 Col) = 720/7.2 lines per inch)
 ;   60 lines (80 Col) = 720/6 lines per inch)
 S ROWHT=$P(NODE,"^",10),ROWHT=$S(ROWHT>72:90,ROWHT>60:100.0005,1:120)
 S COLWIDTH=$P(NODE,"^",9)
 S XBUBOS=$S(COLWIDTH>96:.5,COLWIDTH>80:.75,1:1) ;leaves offset in terms of fraction of column width - must still convert to decipoints
 S YBUBOS=$S(COLWIDTH>96:65,COLWIDTH>80:75,1:85)
 ; colwidth = # of PCL decipoints/character in width
 ;   133 Col = 720/16.67 char per inch
 ;   96 Col = 720/12 char per inch
 ;   80 Col = 720/10 char per inch
 S COLWIDTH=$S(COLWIDTH>96:(720/16.67),COLWIDTH>80:60,1:72) ;converted to decipoints
 S XBUBOS=XBUBOS*COLWIDTH ;converted to decipoints
 S YHANDOS=$S(ROWHT=90:0,ROWHT=100.0005:15,1:30)
 ;
 ;get the list of scannable pages
 S IEN=0 F  S IEN=$O(^IBD(357.95,IBFORMID,3,IEN)) Q:'IEN  S NODE=$G(^IBD(357.95,IBFORMID,3,IEN,0)) S:$P(NODE,"^",2) PAGE(+NODE)=""
 ;
 ;
 S PAGE=0 F  S PAGE=$O(PAGE(PAGE)) Q:'PAGE  D
 .;
 .;list all the bubbles
 .S ROW=((PAGE-1)*PERPAGE)-1
 .S ARY="^IBD(357.95,""AC"","_IBFORMID_")"
 .F  S ROW=$O(@ARY@(ROW)) Q:ROW=""  D
 ..Q:(ROW\PERPAGE)+1'=PAGE
 ..S COL="" F  S COL=$O(@ARY@(ROW,COL)) Q:COL=""  S IEN=0 F  S IEN=$O(@ARY@(ROW,COL,IEN)) Q:'IEN  D
 ...S NODE=$G(^IBD(357.95,IBFORMID,1,IEN,0))
 ...Q:($P(NODE,"^",6)="")!(($P(NODE,"^",4)="")&($P(NODE,"^",8)=""))!('$P(NODE,"^",3))
 ...S NAME=$E($P(NODE,"^",5),1,17),QLFR=$P(NODE,"^",10)
 ...S TYPE=$P(NODE,"^",7)
 ...I (TYPE=0)!(TYPE=3) S:QLFR QLFR=$P($G(^IBD(357.98,QLFR,0)),"^",3)
 ...I (TYPE=1)!(TYPE=2) S:QLFR QLFR=$E($P($G(^IBD(357.98,QLFR,0)),"^"),1,12)
 ...I QLFR'="" S NAME=NAME_"("_QLFR_")"
 ...I QLFR="" S NAME=NAME_"-"
 ...S @SCAN@(PAGE,$P(NODE,"^",6),+$P(NODE,"^",7),COL,(ROW-((PAGE-1)*PERPAGE)),IEN)=$P(NODE,"^",3,12)
 ...S @SCAN@(PAGE,$P(NODE,"^",6))=NAME
 ...;
 .;
 .;list all the handprint fields
 .S ARY="^IBD(357.95,""AD"","_IBFORMID_")"
 .S ROW=((PAGE-1)*PERPAGE)-1
 .F  S ROW=$O(@ARY@(ROW)) Q:ROW=""  D
 ..Q:(ROW\PERPAGE)+1'=PAGE
 ..S COL="" F  S COL=$O(@ARY@(ROW,COL)) Q:COL=""  S IEN=0 F  S IEN=$O(@ARY@(ROW,COL,IEN)) Q:'IEN  D
 ...S NODE=$G(^IBD(357.95,IBFORMID,2,IEN,0))
 ...Q:($P(NODE,"^",8)="")!('$P(NODE,"^",4))!('$P(NODE,"^",15))
 ...S @SCAN@(PAGE,$P(NODE,"^",8),6,COL,(ROW-((PAGE-1)*PERPAGE)),IEN)=$P(NODE,"^",3,17),NAME=$E($P(NODE,"^",5),1,15)
 ...I $P(NODE,"^",17) S NAME=NAME_"("_$P($G(^IBE(359.1,$P(NODE,"^",17),0)),"^")_")"
 ...S @SCAN@(PAGE,$P(NODE,"^",8))=NAME
 ;
 ;make form description
 F COUNT=1:1 S LINE=$T(FORM+COUNT^IBDFBKS1),TAG=$P(LINE,";;"),LINE=$P(LINE,";;",2) Q:TAG["QUIT"  D
 .N PG
 .D BLDARY("")
 .I TAG["NAME" S IBDFSA(IBLC)=IBDFSA(IBLC)_"  NAME = ""ENCOUNTER FORM "_IBFORMID_""";" Q
 .I TAG["SITE" S IBDFSA(IBLC)=IBDFSA(IBLC)_"'VA SITE = "_$P($$SITE^VASITE,"^",2),LINE=""
 .I TAG["PGCK" S IBDFSA(IBLC)=IBDFSA(IBLC)_"  else if ("  D  Q
 ..S PG=$O(PAGE(0))
 ..S IBDFSA(IBLC)=IBDFSA(IBLC)_"(page!="_PG_")"
 ..F  S PG=$O(PAGE(PG)) Q:'PG  S IBDFSA(IBLC)=IBDFSA(IBLC)_"&&(page!="_PG_")"
 ..S IBDFSA(IBLC)=IBDFSA(IBLC)_"){"
 .S IBDFSA(IBLC)=IBDFSA(IBLC)_LINE
 .;D BLDARY(LINE)
 ;
 ;make fields
 S PAGE=0,FIELD=9,PRIORPG=$O(@SCAN@(0)),LN=0,BLN=0
 F  S PAGE=$O(@SCAN@(PAGE)) D:PRIORPG'=PAGE PRINTEND^IBDFBKS3 Q:'PAGE  S FID="" F  S FID=$O(@SCAN@(PAGE,FID)) Q:FID=""  S TYPE=$O(@SCAN@(PAGE,FID,"")) Q:TYPE=""  D
 .S NAME=$G(@SCAN@(PAGE,FID))
 .;
 .; -- 1 = EXACTLY ONE, 2 = AT MOST ONE (0 or 1)
 .I (TYPE=1)!(TYPE=2) S FIELD=FIELD+1,@FIELDS@(PAGE,FIELD)="" D
 ..I TYPE=1 S NAME=NAME_" (1 Required)"
 ..I TYPE=2 S NAME=NAME_" (1 Optional)"
 ..S NAME=$$NAME(NAME)
 ..D BUBBLE^IBDFBKS3 Q
 .;
 .I TYPE=6 D  Q
 ..N OLDNAME S OLDNAME=NAME
 ..S COL="" F  S COL=$O(@SCAN@(PAGE,FID,TYPE,COL)) Q:COL=""  S ROW="" F  S ROW=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW)) Q:ROW=""  S IEN=0 F  S IEN=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW,IEN)) Q:'IEN  D
 ...S NAME=$$NAME(OLDNAME)
 ...;S IBDLAST=0 I $O(@SCAN@(PAGE,FID,TYPE,COL,ROW))="",$O(@SCAN@(PAGE,FID,TYPE,COL))="",$O(@SCAN@(PAGE,FID,TYPE))="" S IBDLAST=1
 ...S NODE=$G(@SCAN@(PAGE,FID,6,COL,ROW,IEN)) D HANDPRNT^IBDFBKS2(IEN,NAME,PAGE,ROW,COL,$P(NODE,"^",1),$P(NODE,"^",4),$P(NODE,"^",13),$P(NODE,"^",15),$P(NODE,"^",2))
 .;
 .;0 = ANY NUMBER
 .;3 = AT LEAST ONE (1 or more)
 .I (TYPE=0)!(TYPE=3) D
 ..N OLDNAME
 ..;I TYPE=3 N FIRST,LAST S LAST=FIELD+1,LAST=""
 ..I TYPE=3 N FIRST,LAST S FIRST=FIELD+1,LAST=""
 ..S COL="" F  S COL=$O(@SCAN@(PAGE,FID,TYPE,COL)) Q:COL=""  S ROW="" F  S ROW=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW)) Q:ROW=""  S IEN=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW,0)) D:IEN
 ...S FIELD=FIELD+1,@FIELDS@(PAGE,FIELD)="",NODE=$G(@SCAN@(PAGE,FID,TYPE,COL,ROW,IEN))
 ...S (NAME,OLDNAME)=$G(@SCAN@(PAGE,FID))
 ...S NAME=$$NAME(NAME)
 ...I TYPE=3,$O(@SCAN@(PAGE,FID,TYPE,COL,ROW))="",($O(@SCAN@(PAGE,FID,TYPE,COL))="") S LAST=FIELD
 ...D BUBBLE^IBDFBKS3
 ;
END ; -- end of routine
 K @SCAN
 K @FIELDS
 K ^TMP("IBDF-NAME",$J)
 S ^IBD(359.2,IBFORMID,10,IBLC,0)=IBDFSA(IBLC)
 S ^IBD(359.2,IBFORMID,10,0)="^^"_IBLC_"^"_IBLC_"^"_DT_"^"
 Q
 ;
NAME(NAME) ;
 ; -- make sure name is unique
 N X
 I (TYPE=0)!(TYPE=3) S NAME=NAME_" "_$P(NODE,"^",6) I TYPE=3
 I TYPE=1,NAME'["Required" S NAME=NAME_" Required"
 S X=$G(^TMP("IBDF-NAME",$J,NAME))+1
 S ^TMP("IBDF-NAME",$J,NAME)=+X
 I X>1 S NAME=NAME_"  #"_X
 Q NAME
 ;
BLDARY(TEXT) ;
 ; -- builds the export array IBDFS(linecount) = text
 N DIC,DA,DINUM,X,Y,I,J,DLAYGO
 I IBLC=1 D
 .S DIC="^IBD(359.2,",DIC(0)="L",DLAYGO=359.2,(DINUM,X)=IBFORMID D FILE^DICN
 .Q
 ;
 I IBLC>0 D
 .S ^IBD(359.2,IBFORMID,10,IBLC,0)=IBDFSA(IBLC)
 .K IBDFSA(IBLC)
 .Q
 ;
 S IBLC=IBLC+1
 S IBDFSA(IBLC)=$G(TEXT)
 Q
 ;
WRITE(IBFORMID) ;
 N LINE S LINE=0
 S X=0 X ^%ZOSF("RM")
 F  S LINE=$O(^IBD(359.2,IBFORMID,10,LINE))  Q:'LINE  W !,$G(^IBD(359.2,IBFORMID,10,LINE,0))
 S X=80 X ^%ZOSF("RM")
 Q
 ;
PARAM ; -- get values from parameter file
 ;    ibdfill  := % fill required
 ;    ibdbkgnd := % background expected
 S IBDFILL=$P($G(^IBD(357.09,1,0)),"^",8) I IBDFILL="" S IBDFILL=20
 S IBDBKGND=$P($G(^IBD(357.09,1,0)),"^",9) I IBDBKGND="" S IBDBKGND=5
 S XYSMALL=$P(^IBD(357.09,1,0),"^",12) I XYSMALL'=+XYSMALL S XYSMALL=4
 Q
