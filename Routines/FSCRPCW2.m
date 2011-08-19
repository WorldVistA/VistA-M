FSCRPCW2 ;SLC/STAFF-NOIS RPC Web Page Package ;7/23/98  16:49
 ;;1.1;NOIS;;Sep 06, 1998
 ;
PACK(PACK,CNT) ; from FSCRPCWP
 N ADDRESS,ID,LINE,NUM,PACKNAME,ZERO
 S ADDRESS=$P($G(^FSC("PARAM",1,1.8)),U,2)
 S PACKNAME=$P($G(^FSC("PACK",PACK,0)),U) I '$L(PACKNAME) Q
 D SET("{PACKAGE}",.CNT)
 D SET("pack"_PACK_".htm",.CNT)
 D SET("<HTML>",.CNT)
 D SET("<HEAD>",.CNT)
 D SET("<TITLE> NOIS "_PACKNAME_" Solution</TITLE>",.CNT)
 D SET("</HEAD>",.CNT)
 D SET("<BODY TEXT=""#000000"" BGCOLOR=""#FFFFFF"">",.CNT)
 D SET("<H1><CENTER>"_PACKNAME_" Solutions</CENTER></H1>",.CNT)
 S LINE="<a href="""_ADDRESS_"main.htm"">"_"Solution Index"_"</a>"
 D SET(LINE_"<BR>",.CNT)
 S PACKPAGE=$G(^FSC("PACK",PACK,1.8)) I $L(PACKPAGE) D
 .S LINE="<a href="""_PACKPAGE_""">"_PACKNAME_" Troubleshooting Page</a>"
 .D SET(LINE_"<BR>",.CNT)
 D SET("<HR>",.CNT)
 S ID=0 F  S ID=$O(^FSCD("WEB","C",PACK,ID)) Q:ID<1  D
 .S TITLE=$G(^FSCD("WEB",ID,1))
 .S LINE=TITLE ; add ahref
 .S LINE="<a href="""_ADDRESS_"p"_ID_".htm"">"_TITLE_"</a>"
 .D SET(LINE_"<BR>",.CNT)
 D SET("</BODY>",.CNT)
 D SET("</HTML>",.CNT)
 D SET("{{{}}}",.CNT)
 Q
 ;
SET(LINE,CNT) ;
 S CNT=CNT+1
 S ^TMP("FSCRPC",$J,"OUTPUT",CNT)=LINE
 Q
