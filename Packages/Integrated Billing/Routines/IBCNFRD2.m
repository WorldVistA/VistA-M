IBCNFRD2 ;WOIFO/KJS - Electronic Insurance Identification ;25-MAY-2011
 ;;2.0;INTEGRATED BILLING;**457**;21-MAR-94;Build 30
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;
 ; Electronic Insurance Indentification  Sending and Receiving AITC messages
 ;
 Q
 ;
BLDXML ;
 ;now create the XML file
 N XMLFILE,XMLHEAD,XMLCOL,SEQ,REC,HMSDIR,XMLX,DQUOTE,SQUOTE,AMP,GT,LT,SITE
 D INITXML
 D OPEN^%ZISH("XMLFILE",HMSDIR,XMLFILE,"W")
 Q:POP
 U IO
 D XMLSTART
 S SEQ=0
 F  S SEQ=$O(XMLCOL(SEQ)) Q:SEQ=""  D XMLCOL($P(XMLCOL(SEQ),U,2))
 W !,"<Row>"
 F  S SEQ=$O(XMLCOL(SEQ)) Q:SEQ=""  D XMLCELL($P(XMLCOL(SEQ),U,5),"String",$P(XMLCOL(SEQ),U,6))
 W !,"</Row>"
 S MSGID=0,IBCNT=0
 F  S MSGID=$O(^XTMP("IBCNFRD",MSGID)) Q:'MSGID  D
 . S IBREC=0
 . F  S IBREC=$O(^XTMP("IBCNFRD",MSGID,IBREC)) Q:'IBREC  D
 .. S IBCNT=IBCNT+1
 .. W !,"<Row>"
 .. S REC=^XTMP("IBCNFRD",MSGID,IBREC)
 .. S SEQ=0
 .. F  S SEQ=$O(XMLCOL(SEQ)) Q:SEQ=""  D
 ... N DATA,POS,SUB,DSUB
 ... S POS=$P(XMLCOL(SEQ),U)
 ... S DATA=$P(REC,U,+POS)
 ... I POS["@" S SUB=$P(POS,"@",2) S DSUB=SUB_"(.DATA)" D @DSUB
 ... D XMLCELL(DATA,$P(XMLCOL(SEQ),U,3),$P(XMLCOL(SEQ),U,4))
 .. W !,"</Row>"
 D XMLEND
 D CLOSE^%ZISH("XMLFILE")
 ;
 ; Send Email to IBCNF EII XML READY that Result file is ready
 N XMSUB,IBXMLMSG,XMY,XMTEXT,IBNOW,XMZ,XMDUZ,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMERR
 S XMSUB="HMS result XML file "_HMSDIR_XMLFILE_" is ready"
 S IBXMLMSG(1)="HMS result XML file "_HMSDIR_XMLFILE_" is ready to be retrieved"
 S XMTEXT="IBXMLMSG("
 S XMY("G.IBCNF EII XML READY")=""
 D ^XMD
 Q
 ;
POLDET(DATA) ;policy determination
 S DATA=$S(DATA="00/00/0000":"POLICY NOT FOUND",DATA="12/31/9999":"ACTIVE",1:"INACTIVE")
 Q
 ;
XMLCOL(WIDTH) ;
 W !,"<Column ss:StyleID=""s8"" ss:Width=""",WIDTH,"""/>"
 Q
 ;
XMLCELL(DATA,TYPE,STYLE) ;
 I TYPE="DateTime" D
 .;check for valid date and if it is valid format it in excel format
 .;otherwise, set the cell to a string type and use the original format
 .N %DT,X,Y,YR,MN,DA
 .S X=DATA
 .D ^%DT
 .I Y=-1 S TYPE="String" Q
 .S YR=$P(DATA,"/",3),MN=$P(DATA,"/"),DA=$P(DATA,"/",2)
 .;excel dates are invalid before 1/1/1900
 .I YR<1900 S TYPE="String" Q
 .S DATA=YR_"-"_MN_"-"_DA
 ;
 W !,"<Cell ss:StyleID=""",STYLE,"""><Data ss:Type=""",TYPE,""">",$$XML(DATA),"</Data></Cell>"
 Q
 ;
XML(DATA) ;
 N DATA2
 ;excel 2007 doesn't like escaped xml chars even though documentation says otherwise
 ;but CDATA syntax does work
 ;
 S DATA2="<![CDATA["_DATA_"]]>"
 Q DATA2
 ;
XMLSTART ;
 W "<?xml version=""1.0""?>"
 W !,"<?mso-application progid=""Excel.Sheet""?>"
 W !,"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"""
 W !,"xmlns:o=""urn:schemas-microsoft-com:office:office"""
 W !,"xmlns:x=""urn:schemas-microsoft-com:office:excel"""
 W !,"xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"""
 W !,"xmlns:html=""http://www.w3.org/TR/REC-html40"">"
 W !,"<Styles>"
 W !,"<Style ss:ID=""Default"" ss:Name=""Normal"">"
 W !,"<Alignment ss:Vertical=""Bottom""/>"
 W !,"<Borders/>"
 W !,"<Font ss:FontName=""Arial"" x:Family=""Swiss"" ss:Color=""#000000""/>"
 W !,"<Interior/>"
 W !,"<NumberFormat/>"
 W !,"<Protection/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s1"">"
 W !,"<NumberFormat ss:Format=""Short Date""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s2"">"
 W !,"<NumberFormat/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s3"">"
 W !,"<Alignment ss:Vertical=""Bottom"" ss:WrapText=""0""/>"
 W !,"<Borders>"
 W !,"<Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"</Borders>"
 W !,"<Font ss:FontName=""Arial"" x:Family=""Swiss"" ss:Size=""8""/>"
 W !,"<NumberFormat ss:Format=""Short Date""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s4"">"
 W !,"<Alignment ss:Vertical=""Bottom"" ss:WrapText=""0""/>"
 W !,"<Borders>"
 W !,"<Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"</Borders>"
 W !,"<Font ss:FontName=""Arial"" x:Family=""Swiss"" ss:Size=""8""/>"
 W !,"<NumberFormat ss:Format=""@""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s5"">"
 W !,"<Alignment ss:Vertical=""Bottom"" ss:WrapText=""0""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s6"">"
 W !,"<Alignment ss:Vertical=""Bottom"" ss:WrapText=""0""/>"
 W !,"<Borders>"
 W !,"<Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"</Borders>"
 W !,"<Font ss:FontName=""Arial"" x:Family=""Swiss"" ss:Size=""8"" ss:Color=""#FFFFFF"" ss:Bold=""1""/>"
 W !,"<Interior ss:Color=""#000000"" ss:Pattern=""Solid""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s7"">"
 W !,"<Alignment ss:Vertical=""Bottom"" ss:WrapText=""0""/>"
 W !,"<Borders>"
 W !,"<Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"</Borders>"
 W !,"<Font ss:FontName=""Arial"" x:Family=""Swiss"" ss:Size=""8"" ss:Color=""#FFFF00"" ss:Bold=""1""/>"
 W !,"<Interior ss:Color=""#000000"" ss:Pattern=""Solid""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s8"">"
 W !,"<Font ss:FontName=""Arial"" x:Family=""Swiss"" ss:Size=""8"" ss:Color=""#000000""/>"
 W !,"</Style>"
 W !,"</Styles>"
 W !,"<Worksheet ss:Name=""",$P(XMLFILE,"."),""">"
 W !,"<Table x:FullColumns=""1"" x:FullRows=""1"" ss:DefaultRowHeight=""11.25"">"
 Q
 ;
XMLEND ;
 W !,"</Table>"
 W !,"<WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">"
 W !,"<PageSetup>"
 W !,"<Header x:Data=""&amp;L&amp;D&amp;R&amp;&quot;Arial,Bold&quot;&amp;8HMS Insurance Identification Results""/>"
 W !,"<Footer x:Data=""&amp;F&amp;RPage &amp;P""/>"
 W !,"</PageSetup>"
 W !,"<FreezePanes/>"
 W !,"<FrozenNoSplit/>"
 W !,"<SplitHorizontal>1</SplitHorizontal>"
 W !,"<TopRowBottomPane>1</TopRowBottomPane>"
 W !,"</WorksheetOptions>"
 W !,"</Worksheet>"
 W !,"</Workbook>"
 Q
 ;
INITXML ;
 ;XMLCOL(N)=P^W^T^SC^H^SH
 ;N=column number in spreadsheet
 ;P=piece number from result file record
 ;W=width of column
 ;T=cell type
 ;SC=cell style
 ;H=HEADER
 ;SH=header style
 ;
 N COL
 S COL=0
 S COL=COL+1,XMLCOL(COL)="1^57^String^s4^Autonumber^s6"
 S COL=COL+1,XMLCOL(COL)="2^96^String^s4^Patient Name^s6"
 S COL=COL+1,XMLCOL(COL)="3^51.75^String^s4^Patient SSN^s6"
 S COL=COL+1,XMLCOL(COL)="4^52.5^DateTime^s3^Patient DOB^s6"
 S COL=COL+1,XMLCOL(COL)="5^52.5^String^s4^Patient Age^s6"
 S COL=COL+1,XMLCOL(COL)="70^87^String^s4^Pt. Rel. to Insured ID^s6"
 S COL=COL+1,XMLCOL(COL)="71^69^String^s4^Pat. ID^s6"
 S COL=COL+1,XMLCOL(COL)="6^186.75^String^s4^Carrier Name^s6"
 S COL=COL+1,XMLCOL(COL)="7^63^String^s4^Carrier Phone^s6"
 S COL=COL+1,XMLCOL(COL)="8^60.75^DateTime^s3^Effective Date^s6"
 S COL=COL+1,XMLCOL(COL)="9^75^String^s4^Insurance Active^s6"
 S COL=COL+1,XMLCOL(COL)="10^45.75^DateTime^s3^Thru Date^s6"
 S COL=COL+1,XMLCOL(COL)="11^80.25^String^s4^Group ID^s6"
 S COL=COL+1,XMLCOL(COL)="12^108^String^s4^Group Name^s6"
 S COL=COL+1,XMLCOL(COL)="13^105^String^s4^Carrier Address 1^s6"
 S COL=COL+1,XMLCOL(COL)="14^99.75^String^s4^Carrier Address 2^s6"
 S COL=COL+1,XMLCOL(COL)="15^75^String^s4^Carrier City^s6"
 S COL=COL+1,XMLCOL(COL)="16^57.75^String^s4^Carrier State^s6"
 S COL=COL+1,XMLCOL(COL)="17^49.5^String^s4^Carrier Zip^s6"
 S COL=COL+1,XMLCOL(COL)="18^105^String^s4^Out Patient Address 1^s6"
 S COL=COL+1,XMLCOL(COL)="19^99.75^String^s4^Out Patient Address 2^s6"
 S COL=COL+1,XMLCOL(COL)="20^75^String^s4^Out Patient City^s6"
 S COL=COL+1,XMLCOL(COL)="21^74.25^String^s4^Out Patient State^s6"
 S COL=COL+1,XMLCOL(COL)="22^65.25^String^s4^Out Patient Zip^s6"
 S COL=COL+1,XMLCOL(COL)="23^113.25^String^s4^Policy Holder Name^s6"
 S COL=COL+1,XMLCOL(COL)="24^48.75^DateTime^s3^Policy DOB^s6"
 S COL=COL+1,XMLCOL(COL)="25^69^String^s4^Policy Holder ID^s6"
 S COL=COL+1,XMLCOL(COL)="26^50.25^String^s4^Filing Limit^s6"
 S COL=COL+1,XMLCOL(COL)="65^96^String^s4^Coverage Type^s6"
 S COL=COL+1,XMLCOL(COL)="38^43.5^String^s4^Medicare^s6"
 S COL=COL+1,XMLCOL(COL)="39^30^String^s4^Part A^s6"
 S COL=COL+1,XMLCOL(COL)="40^29.25^String^s4^Part B^s6"
 S COL=COL+1,XMLCOL(COL)="41^53.25^String^s4^MC Primary^s6"
 S COL=COL+1,XMLCOL(COL)="42^77.25^DateTime^s3^MC Effective Date^s6"
 S COL=COL+1,XMLCOL(COL)="43^64.5^String^s4^MC Secondary^s6"
 S COL=COL+1,XMLCOL(COL)="44^66.75^String^s4^Medicare Supp^s6"
 S COL=COL+1,XMLCOL(COL)="45^38.25^String^s4^MC Plan^s6"
 S COL=COL+1,XMLCOL(COL)="46^61.5^String^s4^MC Carve Out^s6"
 S COL=COL+1,XMLCOL(COL)="47^39.75^String^s4^MC HMO^s6"
 S COL=COL+1,XMLCOL(COL)="48^57.75^String^s4^RX Coverage^s6"
 S COL=COL+1,XMLCOL(COL)="50^151.5^String^s4^RX Name^s6"
 S COL=COL+1,XMLCOL(COL)="51^120.75^String^s4^RX Address^s6"
 S COL=COL+1,XMLCOL(COL)="52^61.5^String^s4^RX City^s6"
 S COL=COL+1,XMLCOL(COL)="53^39^String^s4^RX State^s6"
 S COL=COL+1,XMLCOL(COL)="54^30.75^String^s4^RX Zip^s6"
 S COL=COL+1,XMLCOL(COL)="55^72.75^String^s4^Pre Certification^s6"
 S COL=COL+1,XMLCOL(COL)="56^69^String^s4^Pre Cert Phone^s6"
 S COL=COL+1,XMLCOL(COL)="57^83.25^String^s4^Pre Cert Contact^s6"
 S COL=COL+1,XMLCOL(COL)="58^45.75^String^s4^Bill Phone^s6"
 S COL=COL+1,XMLCOL(COL)="59^73.5^DateTime^s3^Verification Date^s6"
 S COL=COL+1,XMLCOL(COL)="60^83.25^String^s4^Verified By^s6"
 S COL=COL+1,XMLCOL(COL)="61^96.75^String^s4^Verification Complete^s6"
 S COL=COL+1,XMLCOL(COL)="62^40.5^String^s4^File ID^s6"
 S COL=COL+1,XMLCOL(COL)="67^53.25^String^s4^Bin Number^s6"
 S COL=COL+1,XMLCOL(COL)="68^57^String^s4^PCN Number^s6"
 S COL=COL+1,XMLCOL(COL)="69^50.25^String^s4^RX Phone^s6"
 S COL=COL+1,XMLCOL(COL)="10@POLDET^91.5^String^s4^Policy Determination^s6"
 S COL=COL+1,XMLCOL(COL)="73^51.75^String^s4^Terminator^s6"
 S SITE=$P($$SITE^VASITE(),U,3)
 S XMLFILE="VAXML"_SITE_".XML"
 S HMSDIR=IBCNFPAR(13.01)
 S DQUOTE="""",SQUOTE="'",AMP="&",LT="<",GT=">"
 S XMLX(DQUOTE)="&quot;"
 S XMLX(SQUOTE)="&pos;"
 S XMLX(AMP)="&amp;"
 S XMLX(LT)="&lt;"
 S XMLX(GT)="&gt;"
 Q
 ;
TEST ;
 ;
 D OPEN^%ZISH("TXTFILE","USER$:[SMITHK.HMS]","VA123T3.TXT","R")
 Q:POP
 N XMSUB,IBCSVMSG,XMY,XMTEXT,IBNOW,XMZ,XMDUZ,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMERR,CR,LF,MCNT,I,SEGS,RCNT
 S CR=$C(13),LF=$C(10)
 S SEQ=0,MCNT=0,RCNT=0
 F  D  Q:EOF
 .U IO
 .R REC:2
 .S EOF=$$STATUS^%ZISH
 .Q:EOF
 .S RCNT=RCNT+1
 .S SEQ=SEQ+1
 .I SEQ=1 S MCNT=MCNT+1,IBCSVMSG(SEQ)="2IBN"_$E("0000",1,4-$L(MCNT))_MCNT_" ABW."
 .S SEGS=$L(REC)\100 S:$L(REC)#100 SEGS=SEGS+1
 .F I=1:1:SEGS S SEQ=SEQ+1,IBCSVMSG(SEQ)=$E(REC,(I-1)*100+1,I*100)
 .I RCNT=100 D
 ..S SEQ=SEQ+1
 ..S IBCSVMSG(SEQ)="NNNN  "
 ..D TSEND
 ..K IBCSVMSG
 ..S SEQ=0,RCNT=0
 S SEQ=SEQ+1,IBCSVMSG(SEQ)="                                                                                              "
 S SEQ=SEQ+1,IBCSVMSG(SEQ)="                                                                                              "
 S SEQ=SEQ+1,IBCSVMSG(SEQ)="                                                                                              "
 S SEQ=SEQ+1,IBCSVMSG(SEQ)="                                                                       "
 S SEQ=SEQ+1,IBCSVMSG(SEQ)="### END OF FILE ### END OF FILE ###                                                          "
 S SEQ=SEQ+1,IBCSVMSG(SEQ)="NNNN  "
 D TSEND
 D CLOSE^%ZISH("TXTFILE")
 Q
 ;
TSEND ;
 N XMSUB,XMY,XMTEXT,XMZ,XMDUZ,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMERR
 S XMSUB="HMS result file"
 S XMTEXT="IBCSVMSG("
 S XMY("G.IBN")=""
 D ^XMD
 U 0 W !,XMZ
 Q
