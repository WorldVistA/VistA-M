RAHLTCPB ; HIRMFO/REL,GJC,BNT,PAV - Rad/Nuc Med HL7 TCP/IP Bridge;05/21/99 ; 8/28/08 2:05pm
 ;;5.0;Radiology/Nuclear Medicine;**12,17,25,51,71,81,84,106**;Mar 16, 1998;Build 2
 ; 07/05/2006 BAY/KAM Remedy Call 124379 Eliminate unneeded ORM msgs
 ; 09/01/2006   Accomodate multiple ORC/OBR segments Patch 81
 ; 
 ;Integration Agreements
 ;----------------------
 ;INIT^HLFNC2(2161); GENACK^HLMA1(2165); $$DT^XLFDT(10103)
 ; 
EN1 ; Build the ^TMP("RARPT-REC" global when we receive the
 ; 07/05/2006 Remedy Call 124379 message from HL7. If RAHLTCPB is defined, do not broadcast ORM messages. As of the writing
 ; of patch 71, RAHLTCPB is referenced in RAHLTCPB, UPSTAT^RAUTL0, & UP2^RAUTL1 Generic provider: RADIOLOGY,OUTSIDE SERVICE
 N RATELE,RATELENM,RATELEPI,RATELEKN,RATELEDR,RATELEDF
 D TELE^RAHLRPTT ;Patch 84
 ;** branch to new HL7 logic when the HL7 version surpasses 2.3 **
 I HL("VER")>2.3,($T(^RAHLTCPX))'="" GOTO EN1^RAHLTCPX
 S RASUB=HL("MID"),RAHLTCPB=1 K RAERR
 ;**********************************************
 ;RACN is Counter - Indication that ORC segment present
 N RACN,II,L,RAPRSET,RARRR,XX,RAHLD,RARSDNT,RATRSCRP S (RACN,RAPRSET)=0 ; = Address where we go to store data...
 ;**********************************************
 K ^TMP("RARPT-HL7",$J) ; clean area that holds data from HL7
 K ^TMP("RARPT-REC",$J,RASUB) ; kill storage area for new HL7 message id
 S ^TMP("RARPT-REC",$J,RASUB,"RADATE")=$$DT^XLFDT()
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .I '$L(HLNODE),$L($G(HLNODE(1))) S HLNODE=HLNODE(1) K HLNODE(1) F J=2:1 Q:'$D(HLNODE(J))  S HLNODE(J-1)=HLNODE(J) K HLNODE(J)
 .S ^TMP("RARPT-HL7",$J,I)=HLNODE,J=0 F  S J=$O(HLNODE(J)) Q:'J  S ^TMP("RARPT-HL7",$J,I,J)=HLNODE(J)
 S CNT=2,SEGMNT=$G(^TMP("RARPT-HL7",$J,CNT))
 S:'$$GETSFLAG^RAHLRU($G(HL("SAN")),$G(HL("MTN")),$G(HL("ETN")),$G(HL("VER"))) RANOSEND=$G(HL("SAN"))
 S ^TMP("RARPT-REC",$J,RASUB,"VENDOR")=$G(HL("SAN"))
PID ; Pick data off the 'PID' segment.
 I $P(SEGMNT,HL("FS"))="PID" D
 . S SEGMNT=$P(SEGMNT,HL("FS"),2,99999)
 . I $P($P(SEGMNT,HL("FS"),3),$E(HL("ECH")))]"" D
 .. S (^TMP("RARPT-REC",$J,RASUB,"RADFN"),RADFN)=$P($P(SEGMNT,HL("FS"),3),$E(HL("ECH")))
 .. Q
 . I $P(SEGMNT,HL("FS"),19)]"" D
 .. S ^TMP("RARPT-REC",$J,RASUB,"RASSN")=$P(SEGMNT,HL("FS"),19)
 .. Q
 . Q
 E  S RAERR="Missing PID segment" D XIT Q
 I '(+$G(^TMP("RARPT-REC",$J,RASUB,"RADFN"))) D  Q
 .S RAERR="Invalid Patient ID"
 .D XIT
 ; Save off E-Sig information (if it exists)
 S:$D(HL("ESIG")) ^TMP("RARPT-REC",$J,RASUB,"RAESIG")=HL("ESIG")
 ;********************************
ORC ; Pick data off the 'ORC' segment.
 D
 .N CNT1 S CNT1=CNT,RARRR=""
111 .K SEGMNT S CNT1=$O(^TMP("RARPT-HL7",$J,CNT1)) Q:CNT1=""  S SEGMNT=$G(^(CNT1))
 .I $P(SEGMNT,HL("FS"))="PV1" S CNT=CNT1 G 111
 .Q:$P(SEGMNT,HL("FS"))'="ORC"
 .S CNT=CNT1 Q:$P(SEGMNT,HL("FS"),2)'="CN"  ; find the 'ORC' segment
 .S RACN=RACN+1,RARRR="RARPT-REC-"_RACN
 ;********************************
OBR ; Pick data off the 'OBR' segment.
 I $L(RARRR) K ^TMP(RARRR,$J) M ^TMP(RARRR,$J)=^TMP("RARPT-REC",$J) ;Merge if OBR without Report
 S:'$L(RARRR) RARRR="RARPT-REC"
 K SEGMNT F  S CNT=$O(^TMP("RARPT-HL7",$J,CNT)) Q:CNT=""  S SEGMNT=$G(^(CNT)) Q:$P(SEGMNT,HL("FS"))="OBR"  ; find the 'OBR' segment
 I $P($G(SEGMNT),HL("FS"))'="OBR" S RAERR="Missing OBR segment" D XIT Q
 S SEGMNT=$P(SEGMNT,HL("FS"),2,99999) K RADTI,RACNI
 I $P(SEGMNT,HL("FS"),3)]"" D
 . N RADTCN S RADTCN=$P(SEGMNT,HL("FS"),3)
 . S:$P($P(RADTCN,$E(HL("ECH"))),"-")]"" (^TMP(RARRR,$J,RASUB,"RADTI"),RADTI)=$P($P(RADTCN,$E(HL("ECH"))),"-")
 . S:$P($P(RADTCN,$E(HL("ECH"))),"-",2)]"" (^TMP(RARRR,$J,RASUB,"RACNI"),RACNI)=$P($P(RADTCN,$E(HL("ECH"))),"-",2)
 . S:$P(RADTCN,$E(HL("ECH")),2)["&L" RADTCN=$TR(RADTCN,"&","^")
 . S:$P(RADTCN,$E(HL("ECH")),2)]"" ^TMP(RARRR,$J,RASUB,"RALONGCN")=$P(RADTCN,$E(HL("ECH")),2)
 . Q
 I $G(RADTI)'>0 S RAERR="Invalid exam registration timestamp" D XIT Q
 I $G(RACNI)'>0 S RAERR="Invalid exam record IEN" D XIT Q
 S RAHLD=$$PCEXTR^RAHLO4(CNT,SEGMNT,25,HL("FS")) K RAHL70
 I RAHLD="" S RAERR="Missing Report Status" D XIT Q
 ;P106
 I "^A^F^R^VAQ^"'[("^"_RAHLD_"^") D  D XIT Q
 .S RAERR="Invalid Report Status: "_RAHLD QUIT
 ;
 S ^TMP(RARRR,$J,RASUB,"RASTAT")=RAHLD
 G:$P(RARRR,"-",3) 112 S RAHLD=$$PCEXTR^RAHLO4(CNT,SEGMNT,32,HL("FS")) K RAHL70
 I RAHLD']"" S RAERR="Missing Provider ID" D XIT Q
 S RAVERF=RAHLD
 ; -----   Check the validity of the provider name   -----
 I '$D(^VA(200,"B",RAVERF)) D  ; check for a partial match in file 200
 . D VFIER^RAHLO3 ; if one partial match found, return the entry ien
 E  D  ; $D(^VA(200,"B",RAVERF)) true, get the entry ien
 . S RAVERF=$O(^VA(200,"B",RAVERF,0))
 . S:'RAVERF RAERR="Invalid Provider Name: "_RAHLD
 ; can't get resident info from medspeak
 S RAHLD=$$PCEXTR^RAHLO4(CNT,SEGMNT,33,HL("FS")),RARSDNT="" K RAHL70
 I RAHLD]"" D
 . S RARSDNT=$P(RAHLD,$E(HL("ECH"),4)) I '$D(^VA(200,+RARSDNT,0)) S RARSDNT=""
 S RAHLD="",RAHLD=$$PCEXTR^RAHLO4(CNT,SEGMNT,35,HL("FS")),RATRSCRP="" K RAHL70
 I RAHLD]"" D
 . S RATRSCRP=$P(RAHLD,$E(HL("ECH"),4)) I '$D(^VA(200,+RATRSCRP,0)) S RATRSCRP=""
 S ^TMP(RARRR,$J,RASUB,"RAVERF")=RAVERF
 S ^TMP(RARRR,$J,RASUB,"RATRANSCRIPT")=$S(RATRSCRP]"":RATRSCRP,RARSDNT]"":RARSDNT,1:RAVERF)
 S:$G(RARSDNT) ^TMP(RARRR,$J,RASUB,"RARESIDENT")=RARSDNT
 S ^TMP(RARRR,$J,RASUB,"RASTAFF")=RAVERF,^("RAWHOCHANGE")=RAVERF
 I $D(RAERR) D XIT Q
 D ESIG^RAHLO3
 ;
 ;If last OBR set provider info to all OBRs
 K XX F I=1:1:RACN S XX=RARRR_"-"_I D:$D(^TMP(XX,$J,RASUB))
 .N XXX M XXX=^TMP(XX,$J,RASUB),^TMP(XX,$J,RASUB)=^TMP(RARRR,$J,RASUB),^TMP(XX,$J,RASUB)=XXX
112 I $D(RADTI),$D(RACNI),$D(RAPRSET(RADTI,RACNI)) K RAPRSET(RADTI,RACNI),^TMP(RARRR,$J) S RACN=RACN-1 G:$P(RARRR,"-",3) ORC M ^TMP(RARRR,$J)=^TMP("RARPT-REC-"_(RACN+1),$J) K ^TMP("RARPT-REC-"_(RACN+1),$J) G OBX
 I $D(RADTI),'$D(RAPRSET(RADTI)) D  ;Get array of printset for date...
 .N RAPRTSET,RACN,RASUB,CNT
 .K XX D EN2^RAUTL20(.XX) M:$D(XX) RAPRSET(RADTI)=XX K RAPRSET(RADTI,RACNI)
 ;
OBX ; Pick data off the 'OBX' segments
 K SEGMNT F  S CNT=$O(^TMP("RARPT-HL7",$J,CNT)) Q:CNT=""  S SEGMNT=$G(^(CNT)) D:$P(SEGMNT,HL("FS"))="OBX"  Q:$D(RAERR)  I $P(SEGMNT,HL("FS"))="ORC" S CNT=CNT-1 G ORC
 . S SEGMNT=$P(SEGMNT,HL("FS"),2,9999)
 . Q:SEGMNT?@("1"""_HL("FS")_"""."""_HL("FS")_"""")  ;Quit if OBX is something as:    OBX||||||||
 . I $P(SEGMNT,HL("FS"),3)']"" S RAERR="Missing Observation Identifier" Q
 . S OBXTYP=$P($P(SEGMNT,HL("FS"),3),$E(HL("ECH"))),OBXTYP=$E($P(OBXTYP,"&",2))
 . S OBX2CE=""
 . S:OBXTYP="" OBXTYP=" "
 . I OBXTYP=" "&($P(SEGMNT,HL("FS"),2)="CE") D
 . . I $P(SEGMNT,HL("FS"),5)=" " S OBXTYP="F" Q
 . . S OBX2CE=1,OBXTYP="D" Q
 . I "IDRF"'[OBXTYP S RAERR="Invalid Observation Identifier" Q
 . D RPT Q
XIT ; RACKYES  Indicates that Ack will be sent on the last OBR segment or at Error condition.
 N RACKYES
 I $D(RAERR) S RACKYES=1 D EN1^RAHLEXF,GENACK G XIT1
 I $D(^TMP("RARPT-REC",$J)) S:'RACN RACKYES=1 D  G:$D(RAERR) XIT1
 .N RACN D EN1^RAHLO I $D(RAERR) S RACKYES=1 D EN1^RAHLEXF,GENACK
 F II=1:1:RACN S RARRR="RARPT-REC-"_II D:$D(^TMP(RARRR,$J))  Q:$D(RAERR)
 .K ^TMP("RARPT-REC",$J) M ^TMP("RARPT-REC",$J)=^TMP(RARRR,$J) K ^TMP(RARRR,$J)
 .S RACKYES=(II=RACN) N II,RACN D EN1^RAHLO I $D(RAERR) S RACKYES=1 D EN1^RAHLEXF,GENACK
XIT1 K ^TMP("RARPT-REC",$J) ; kill storage area for current HL7 message id
 F II=1:1:RACN S RARRR="RARPT-REC-"_II K:$D(^TMP(RARRR,$J)) ^TMP(RARRR,$J)
 K ^TMP("RARPT-HL7",$J) ; clean up HL7 storage
 K CNT,OBXTYP,X1,LIN,RADATE,RADTCN,RAERR,RAESIG,RAHLD,RAHLTCPB,RANODE,RARCNT
 K RAVERF,RASUB,SEGMNT,RANOSEND,MSA1,OBX2CE,RADX,RADX1,RADX2,RADX3
 Q
RPT ; Save off Report Text data.
 N RAXADEDN
 S RAXADEDN=^TMP("RARPT-REC",$J,RASUB,"RASTAT")
 S RANODE=$S(OBXTYP="D":"RADX",OBXTYP="I":"RAIMP",1:"RATXT"),LIN=""
 I OBX2CE D  Q
 . S X=$P(SEGMNT,HL("FS"),5),RADX1=$P(X,$E(HL("ECH")))
 . S LIN=RADX1,L=999 D P2 S LIN=X
 . Q:X'["~"  F J=0:0 S J=$O(^TMP("RARPT-HL7",$J,CNT,J)) Q:'J  S X1=^(J),LIN=LIN_X1 Q
 . S RADX=LIN,RADX2=$P($P(RADX,"~",2),"^") S:RADX2]"" LIN=RADX2 D P2
 . S RADX3=$P($P(RADX,"~",3),"^") Q:RADX3']""  S LIN=RADX3 D P2 Q
 S X=$P(SEGMNT,HL("FS"),5)
 I X["\S\"!(X["\R\")!(X["\E\")!(X["\T\") D FORMAT
 I $G(RATELE),$D(RATELEKN),X[RATELEKN S X=$P(X,RATELEKN,2),RATELENM=$P(X,"-"),RATELEPI=$TR($P(X,"-",2)," ","") ;SFVAMC/DAD/9-7-2007/Comment out the quit Q  ;Patch 84
 D PAR
 F J=0:0 S J=$O(^TMP("RARPT-HL7",$J,CNT,J)) Q:'J  S X1=^(J),X=$E(X1,1,125) D PAR I $L(X1)>125 S X=$E(X1,126,999) D PAR
 I X=""!(LIN'="") S L=999 D P2
 Q
 ;
PAR ; Build text paragraph
 S LIN=LIN_X
P1 I $L(LIN)<80 Q
 F L=80:-1:1 Q:$E(LIN,L)=" "
 D P2 S LIN=$E(LIN,L+1,999) G P1
P2 ; Set node
 ; If Addendum and Report text is a space don't process
 I $P(SEGMNT,HL("FS"),1)=1,RAXADEDN="A",RANODE="RATXT",$E(LIN,1,L-1)=" " Q
 S RARCNT(OBXTYP)=$G(RARCNT(OBXTYP))+1
 S ^TMP("RARPT-REC",$J,RASUB,RANODE,RARCNT(OBXTYP))=$E(LIN,1,L-1)
 F I=1:1:RACN S RARRR="RARPT-REC-"_I S:$D(^TMP(RARRR,$J)) ^TMP(RARRR,$J,RASUB,RANODE,RARCNT(OBXTYP))=$E(LIN,1,L-1)
 Q
 ;
GENACK ; Compile the 'ACK' segment, generate the 'ACK' message.
 Q:'$G(RACKYES)
 S MSA1="AA"
 Q:$E($G(HL("SAN")),1,3)'="RA-"  ; Don't allow non RA namespaced interfaces
 I $D(RAERR) S MSA1=$S($G(HL("SAN"))="RA-PSCRIBE-TCP"!$G(RATELE):"AE",1:"AR")
 ; Added next line to support MedSpeak interface.  Must re-initialize
 ; FS and EC's before sending ACK.
 D:$G(HL("SAN"))="RA-CLIENT-TCP" INIT^HLFNC2("RA VOICE TCP SERVER RPT",.HL)
 S HLA("HLA",1)="MSA"_HL("FS")_MSA1_HL("FS")_HL("MID")_$S($D(RAERR):HL("FS")_RAERR,1:"")
 ; 06/22/2006 KAM CHANGED NEXT TWO LINES FOR RA*5*71
 S HLEID=HL("EID"),HLEIDS=HL("EIDS"),HLARYTYP="LM",HLFORMAT=1
 K HLRESLT D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT)
 Q
 ;
FORMAT ; Format report text for Escape Character delimited codes.
 S Y=X N T,Q
 I Y["\S\" S Q=$F(Y,"\S\"),T=Q-4,X=$E(Y,1,T)_$E(HL("ECH"))_$E(Y,Q,$L(X)),Y=X
 I Y["\R\" S Q=$F(Y,"\R\"),T=Q-4,X=$E(Y,1,T)_$E(HL("ECH"),2)_$E(Y,Q,$L(X)),Y=X
 I Y["\E\" S Q=$F(Y,"\E\"),T=Q-4,X=$E(Y,1,T)_$E(HL("ECH"),3)_$E(Y,Q,$L(X)),Y=X
 I Y["\T\" S Q=$F(Y,"\T\"),T=Q-4,X=$E(Y,1,T)_$E(HL("ECH"),4)_$E(Y,Q,$L(X)),Y=X
 I X["\S\"!(X["\R\")!(X["\E\")!(X["\T\") D FORMAT
 Q
 ;
