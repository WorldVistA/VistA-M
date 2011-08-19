ORWRP4 ; slc/dcm - OE/RR HDR Report Extract Driver;9/21/05  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1997
HDR(ROOT,HANDLE,ID) ;Extract/Modify data from the HDR
 ;HANDLE=Remote Broker ID in ^XTMP(HANDLE,"D",
 ;ID=Report ID found in field .02 file 101.24
 N X,ORIFN,ORID,ORCNT,ORTN,ORENT,ORRTN
 S ROOT=""
 I $G(HANDLE)="" S ROOT(0)="-1^Bad Handle" Q
 I '$D(^XTMP(HANDLE)) S ROOT(0)="-1^Bad Handle" Q
 S ORID=$O(^ORD(101.24,"AC",ID,0))
 I $G(ORID)="" S ROOT(0)="-1^No ID match" Q
 S ORCNT=$O(^ORD(101.24,ORID,3,"C",9999),-1)
 I $G(ORCNT)="" S ROOT(0)="-1^No Columns for Report" Q
 S ORTN=$P(^ORD(101.24,ORID,4),"^",6),ORENT=$P(^(4),"^",7)
 I '$L(ORTN) S ROOT(0)="-1^No HDR Routine exists" Q
 S ORRTN=ORENT_"^"_ORTN
 I '$L($T(@ORRTN)) S ROOT(0)="-1^HDR Routine non-existant" Q
 D @ORRTN
 Q
COM(NODE,C)     ;Parse Comments
 Q:'NODE  Q:'$L($G(C))
 N I,J,P,D,B,DLIM,DLIM2,X
 S DLIM="\X0a\",DLIM2="|"
 F I=1:1:$L(C,DLIM) S B=$P(C,DLIM,I) F J=1:1:$L(B,DLIM2) S X=$P(B,DLIM2,J),D="" D
 . I $P(X," ")?8N.N1"-"4N S D=$$DATE^ORDVU($$SETDATE($P(X," "))),P=$P(X," ",2,99) D XSET(NODE_"^"_D_" "_P)
 . E  D XSET(NODE_"^"_X)
 Q
ESCP(C) ; De-escape text
 Q:'$L($G(C)) ""
 N HL,ORFS,ORCS,ORRS,ORES,ORSS
 S HL("FS")="^",HL("ECH")="~|\&"
 S ORFS=$G(HL("FS")),ORCS=$E($G(HL("ECH")),1),ORRS=$E($G(HL("ECH")),2),ORES=$E($G(HL("ECH")),3),ORSS=$E($G(HL("ECH")),4)
 Q $$REMESC(C)
REMESC(ORSTR)   ;
 ; Remove Escape Characters from HL7 Message Text
 ; Escape Sequence codes:
 ;     F = field separator (ORFS)
 ;     S = component separator (ORCS)
 ;     R = repitition separator (ORRS)
 ;     E = escape character (ORES)
 ;     T = subcomponent separator (ORSS)
 ; Hex codes:
 ;     Xdddd = Hex Character translated according to ISO 8859-1 character set (1st 255 characters - 8 bit)
 N ORC,ORREP,I1,I2,J1,J2,K,VAL
 F ORC="F","S","R","E","T" S ORREP(ORES_ORC_ORES)=$S(ORC="F":ORFS,ORC="S":ORCS,ORC="R":ORRS,ORC="E":ORES,ORC="T":ORSS)
 S ORREP("|")=" ",ORSTR=$$REPLACE^XLFSTR(ORSTR,.ORREP)
 F  S I1=$P(ORSTR,ORES_"X") Q:$L(I1)=$L(ORSTR)  D
 . S I2=$P(ORSTR,ORES_"X",2,99),J1=$P(I2,ORES)
 . Q:'$L(J1)
 . S J2=$P(I2,ORES,2,99),VAL=$$BASE^XLFUTL($$UP^XLFSTR(J1),16,10),K=$S(VAL>255:"?",1:$C(VAL)),ORSTR=I1_K_J2
 Q ORSTR
XSET(X) ;Setup Allergy & Outpatient RX nodes
 Q:'$D(X)
 S CNT=CNT+1,^TMP("ORXS1",$J,CNT)=$$ESCP(X)
 Q
SETDATE(X) ;Convert HDR Date to FM date
 Q:'$D(X) ""
 Q:'$L(X) ""
 N YEAR,DAY,MONTH,TIME,DOT
 S YEAR=$E(X,1,4)-1700,MONTH=$E(X,5,6),DAY=$E(X,7,8),TIME=$E(X,9,14),DOT="."
 I TIME="0000"!(TIME="") S DOT="",TIME=""
 S X=YEAR_MONTH_DAY_DOT_TIME
 Q X
