RAHLBKVR ;HIRMFO/GJC-Bridge, Kurzweil compatible to HL7 v1.5 ;12/31/97  12:05
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ; Build the ^TMP("RARPT-REC" global when we
 ; receive the message from HL7.
 ; HLDA-ien of the record in ^HL(772, should be defined.
 K ^TMP("RARPT-REC",$J) S RASUB=HLDA
 I '$G(HLDUZ) S RAERR="Invalid Access Code" D XIT Q
 S ^TMP("RARPT-REC",$J,RASUB,"RADATE")=$$DT^XLFDT()
 S ^TMP("RARPT-REC",$J,RASUB,"VENDOR")="KURZWEIL"
 ;If OBR-32 exists use it as verifying phys even if HLDUZ has resident
 ;  or staff classif
 S CNT=2,SEGMNT=$G(^HL(772,RASUB,"IN",CNT,0))
PID ; Pick data off the 'PID' segment.
 I $P(SEGMNT,HLFS)="PID" D
 . S SEGMNT=$P(SEGMNT,HLFS,2,99999)
 . I $P($P(SEGMNT,HLFS,3),$E(HLECH))]"" D
 .. S ^TMP("RARPT-REC",$J,RASUB,"RADFN")=$P($P(SEGMNT,HLFS,3),$E(HLECH))
 .. Q
 . I $P(SEGMNT,HLFS,19)]"" D
 .. S ^TMP("RARPT-REC",$J,RASUB,"RASSN")=$P(SEGMNT,HLFS,19)
 .. Q
 . Q
 E  S RAERR="Missing PID segment" D XIT Q
 ; Save off E-Sig information (if it exists)
 S:$D(HLESIG) ^TMP("RARPT-REC",$J,RASUB,"RAESIG")=HLESIG
 ;
OBR ; Pick data off the 'OBR' segment.
 K SEGMNT F  S CNT=$O(^HL(772,RASUB,"IN",CNT)) Q:CNT=""  S SEGMNT=$G(^(CNT,0)) Q:$P(SEGMNT,HLFS)="OBR"  ; find the 'OBR' segment
 I $P($G(SEGMNT),HLFS)'="OBR" S RAERR="Missing OBR segment" D XIT Q
 S SEGMNT=$P(SEGMNT,HLFS,2,99999)
 I $P(SEGMNT,HLFS,4)]"" D
 . N RADTCN S RADTCN=$P(SEGMNT,HLFS,4)
 . S:$P($P(RADTCN,$E(HLECH)),"-")]"" ^TMP("RARPT-REC",$J,RASUB,"RADTI")=$P($P(RADTCN,$E(HLECH)),"-")
 . S:$P($P(RADTCN,$E(HLECH)),"-",2)]"" ^TMP("RARPT-REC",$J,RASUB,"RACNI")=$P($P(RADTCN,$E(HLECH)),"-",2)
 . S:$P(RADTCN,$E(HLECH),2)]"" ^TMP("RARPT-REC",$J,RASUB,"RALONGCN")=$P(RADTCN,$E(HLECH),2)
 . Q
 ; note: must use $D on hlesig, as it's alphanumeric
 S ^TMP("RARPT-REC",$J,RASUB,"RASTAT")=$S($D(HLESIG):"V",1:"P")
 I $P(SEGMNT,HLFS,16)']"" S RAERR="Missing Provider ID" D XIT Q
 S ^TMP("RARPT-REC",$J,RASUB,"RAVERF")=$S($D(HLESIG):HLDUZ,1:"")
 S ^TMP("RARPT-REC",$J,RASUB,"RATRANSCRIPT")=$G(HLDUZ)
 S ^TMP("RARPT-REC",$J,RASUB,"RASTAFF")=$S(+$P(SEGMNT,HLFS,32):+$P(SEGMNT,HLFS,32),1:$G(HLDUZ))
 S ^TMP("RARPT-REC",$J,RASUB,"RARESIDENT")=$S(+$P(SEGMNT,HLFS,33):+$P(SEGMNT,HLFS,33),1:"")
 S ^TMP("RARPT-REC",$J,RASUB,"RAWHOCHANGE")=$G(HLDUZ)
 ;
OBX ; Pick data off the 'OBX' segments
 K SEGMNT F  S CNT=$O(^HL(772,RASUB,"IN",CNT)) Q:CNT=""  S SEGMNT=$G(^(CNT,0)) D:$P(SEGMNT,HLFS)="OBX"  Q:$D(RAERR)
 . S SEGMNT=$P(SEGMNT,HLFS,2,9999)
 . I $P(SEGMNT,HLFS,3)']"" S RAERR="Missing Observation Identifier" Q
 . S OBXTYP=$P($P(SEGMNT,HLFS,3),$E(HLECH))
 . I "IDR"'[OBXTYP S RAERR="Invalid Observation Identifier" Q
 . D:OBXTYP="I" IMP D:OBXTYP="R" RPT D:OBXTYP="D" DIAG
 . Q
XIT ; Clean up environment, quit
 I $D(^TMP("RARPT-REC",$J,RASUB)),('$D(RAERR)) D EN1^RAHLO
 K ^TMP("RARPT-REC",$J,RASUB)
 ; Compile the 'ACK' segment
 I $D(RAERR) S X1=HLSDATA(1) K HLSDATA S HLSDATA(1)=X1,HLERR=RAERR
 S HLMTN="ACK",HLSDATA(2)="MSA"_HLFS_$S($D(HLERR):"AE",1:"AA")_HLFS_HLMID_$S($D(HLERR):HLFS_HLERR,1:"")
 D:$D(HLTRANS) EN1^HLTRANS K CNT,OBXTYPE
 K RADATE,RADCNT,RADTCN,RAERR,RAESIG,RAICNT,RARCNT,RASUB,RAVERF,SEGMNT
 K RATRANSC,RAPRIMAR
 Q
DIAG ; Save off Diagnostic Code data.
 S RADCNT=+$G(RADCNT)+1
 I $P(SEGMNT,HLFS,5)]"" D  ; strip off leading spaces, save Dx code
 . N DXSTR,X ; DXSTR=Dx code entered by user, X=char pos following space
 . S DXSTR=$P(SEGMNT,HLFS,5)
 . F  S X=$F(DXSTR," ") Q:X'=2  S DXSTR=$E(DXSTR,X,999)
 . S ^TMP("RARPT-REC",$J,RASUB,"RADX",RADCNT)=DXSTR
 . Q
 Q
IMP ; Save off Impression Text data.
 S RAICNT=+$G(RAICNT)+1
 S ^TMP("RARPT-REC",$J,RASUB,"RAIMP",RAICNT)=$P(SEGMNT,HLFS,5)
 Q
RPT ; Save off Report Text data.
 S RARCNT=+$G(RARCNT)+1
 S ^TMP("RARPT-REC",$J,RASUB,"RATXT",RARCNT)=$P(SEGMNT,HLFS,5)
 Q
