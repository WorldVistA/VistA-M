RALWKL3 ;HISC/GJC-Workload Reports By Functional Area ;9/23/96  09:00
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
CHK ; Does the data meet the sort criteria?
 S C=$P(RAP0,"^",4),C=$S(C="I":1,C="O":2,C="R":3,1:4)
 Q:'$P(RAP0,"^",RAPCE)  S RAFLD=$S($D(@("^"_RAFILE_"+$P(RAP0,""^"",RAPCE),0)")):$P(^(0),"^"),1:"Unknown")
 I 'RAINPUT Q:'$D(^TMP($J,"RAFLD",RAFLD))  ; not all and not a user selected entry
 S RAFLD=$E(RAFLD,1,30)
 I RAFILE="SC(" Q:C=1
 I (RAFILE="DIC(42,"!(RAFILE="DIC(42.4,")!(RAFILE="DIC(49,")) Q:13'[C
 F I=0:0 S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",I)) Q:I'>0  I $D(^(I,0)) S RAQI=+$G(^(0)) D EXTRA^RAUTL12(RAQI)
 Q:'$D(^RAMIS(71,+$P(RAP0,"^",2),0))  S RAPRI=$G(^(0)),RAPRC=$E($P(RAPRI,"^"),1,40) Q:'$D(^(2))  F I=0:0 S I=$O(^RAMIS(71,+$P(RAP0,"^",2),2,I)) Q:I'>0  I $D(^(I,0)) S RAZ=$G(^(0)),RAMJ=$S($D(^RAMIS(71.1,+RAZ,0)):^(0),1:"") D PRC^RALWKL
 Q:'$D(RAMIS(1))
 I J=1 S RAMIS=RAMIS(1),RAWT=RAWT(1),RAMUL=RAMUL(1),RAWT=RAWT*RAMUL,RANUM=RAMUL
 I J>1 S RANUM=1,RAWT=0,RAMIS=RAMIS(1) F J=1:1 Q:'$D(RAMIS(J))  S I=RAWT(J),RAMUL=RAMUL(J),RAWT=RAWT+(RAMUL*I)
 D STORE K RAMIS,RAWT,RAMUL,RAZ,RAMJ,RAMULP,RAMULPFL,RABILAT,RAOR,RAPORT
 Q
STORE ; Store off data into ^TMP global.
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1 Q:RAXIT
 I $D(RAOR) S A=25 D AUX^RALWKL
 I $D(RAPORT) S A=26 D AUX^RALWKL
 I $D(RAMULP) S A="MULP" D AUX^RALWKL
 ;----------- Tabulation over all divisions -----------------------------
 S X=$G(^TMP($J,"RA",RADIV))
 S $P(X,"^",C)=$P(X,"^",C)+RANUM,$P(X,"^",5)=$P(X,"^",5)+RAWT
 S ^TMP($J,"RA",RADIV)=X
 ;----------- Tabulation over all divisions/imaging types ---------------
 S X=$G(^TMP($J,"RA",RADIV,RAIMG))
 S $P(X,"^",C)=$P(X,"^",C)+RANUM,$P(X,"^",5)=$P(X,"^",5)+RAWT
 S ^TMP($J,"RA",RADIV,RAIMG)=X
 ;------------Tabulation over division/i-type/option parameter ----------
 I '$D(^TMP($J,"RA",RADIV,RAIMG,RAFLD))#2 D
 . S ^TMP($J,"RA",RADIV,RAIMG,RAFLD)="0^0^0^0^0"
 S X=$G(^TMP($J,"RA",RADIV,RAIMG,RAFLD))
 S $P(X,"^",C)=$P(X,"^",C)+RANUM,$P(X,"^",5)=$P(X,"^",5)+RAWT
 S ^TMP($J,"RA",RADIV,RAIMG,RAFLD)=X
 ;------------Tabulation over division/option parameter ----------
 ; ***** Note new '^TMP($J' subscript (RA1) *****
 I '$D(^TMP($J,"RA1",RADIV,RAFLD))#2 D
 . S ^TMP($J,"RA1",RADIV,RAFLD)="0^0^0^0^0"
 S X=$G(^TMP($J,"RA1",RADIV,RAFLD))
 S $P(X,"^",C)=$P(X,"^",C)+RANUM,$P(X,"^",5)=$P(X,"^",5)+RAWT
 S ^TMP($J,"RA1",RADIV,RAFLD)=X
 ;----------- Tabulation over division/i-types/option parameter/proc ----
 I '$D(^TMP($J,"RA",RADIV,RAIMG,RAFLD,RAMIS,RAPRC)) D
 . S ^TMP($J,"RA",RADIV,RAIMG,RAFLD,RAMIS,RAPRC)="0^0^0^0^0"
 S X=$G(^TMP($J,"RA",RADIV,RAIMG,RAFLD,RAMIS,RAPRC))
 S $P(X,"^",C)=$P(X,"^",C)+RANUM,$P(X,"^",5)=$P(X,"^",5)+RAWT
 S ^TMP($J,"RA",RADIV,RAIMG,RAFLD,RAMIS,RAPRC)=X
 Q
ALLNOTH() ; Do you want access to all entries in the file or just a subset
 ; of entries?
 ; 'RAPRIM' will be defined if accessing this subroutine through the
 ; Options: RA WKLRES (Resident Report) & RA WKLSTAFF (Staff Report)
 N RAINPUT K DIR,X,Y S DIR(0)="YA",DIR("B")="Yes"
 S DIR("A")="Do you wish to include all "_$S($G(RAPRIM)=1:"Primary ",1:"")_$G(RATITLE)_"s? "
 I $G(RATITLE)="Interpreting Staff" S DIR("A")="Do you wish to include all"_$S($G(RAPRIM)=1:" Primary",1:"")_" Interpreting Staff? "
 S DIR("?",1)="Enter 'Yes' to select all entries in the file."
 S DIR("?")="Enter 'No' to select a subset of entries in the file."
 W ! D ^DIR K DIR Q:$D(DIRUT) ""
 S RAINPUT=+Y K DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q RAINPUT
ONE(Z) ; Check if only one entry in the file.  (File specs passed in.)
 N RAXREF,RAZERO,X,X1,Y,Y1
 S RAXREF="^"_Z_"""B"",",RAZERO="^"_Z
 S X=$O(@(RAXREF_""""")")) Q:X']""
 S Y=$O(@(RAXREF_""""_X_""")")) Q:Y]""
 S X1=+$O(@(RAXREF_""""_X_""",0)")) Q:'X1
 S:Z="SC(" Y1=$P($G(@(RAZERO_X1_",0)")),"^")
 S:Z'="SC(" Y1=$P($G(@(RAZERO_X1_",0)")),"^")
 S ^TMP($J,"RAFLD",Y1,X1)="",RAINPUT=0
 Q
SELECT ; Select one-many-all entries from a specific file.
 Q:$D(^TMP($J,"RAFLD"))  ; Only one entry in the file
 N RADIC,RAUTIL S RADIC="^"_RAFILE,RADIC(0)="QEAMZ"
 S RADIC("A")="Select "_$G(RATITLE)_": "
 S RAUTIL="RAFLD",RAINPUT=$$ALLNOTH()
 S:RAINPUT="" RAXIT=1 Q:RAXIT
 D:'RAINPUT EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
 S RAXIT=RAQUIT K:RAXIT RAINPUT Q:RAXIT
 Q
