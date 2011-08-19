TIULAB ; SLC/JER - Lab objects ;7/7/95  15:22
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
MAIN(DFN,EARLY,LATE,DISPLAY,NORM,TARGET,LINE) ; Control branching
 N GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSPNM,GMTSRB,GMTSSN,GMTSWARD,SEX
 N LRDFN,MAX,I,J,SMPL,TIUY,VADPT,VAIN
 K ^TMP("LRC",$J)
 I $G(NORM)']"" S NORM="ALL"
 I '$D(^DPT(DFN,"LR")) D NOLABS G LABX
 S LRDFN=+^DPT(DFN,"LR") I '$D(^LR(LRDFN)) D NOLABS G LABX
 S MAX=999,GMTS1=9999999-LATE,GMTS2=9999999-EARLY
 I +$G(DISPLAY) W !,"Gathering Laboratory Data."
 D ^GMTSLRCE
 I '$D(^TMP("LRC",$J)) D NOLABS G LABX
 D SORT($G(NORM))
 S (TIUY,SMPL)="" F  S SMPL=$O(^TMP("LRC",$J,NORM,SMPL)) Q:SMPL=""  D
 . S I=GMTS1 F  S I=$O(^TMP("LRC",$J,NORM,SMPL,I)) Q:+I'>0!(I>GMTS2)  D
 . . S J=0 F  S J=$O(^TMP("LRC",$J,NORM,SMPL,I,J)) Q:+J'>0  D LINE
 K ^TMP("LRC",$J)
LABX Q "~@"_$NA(@TARGET)
NOLABS ; Handles Case Where no Labs are found to satisfy criteria
 S LINE=$S(+$G(LINE):+$G(LINE),1:1),@TARGET@(LINE,0)="No data available"
 S LINE=+$G(LINE)+1,@TARGET@(LINE,0)=" "
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q
SORT(NFLAG) ; Sort ^TMP("LRC",$J, by reference flag
 N I,J,K,L I $G(NFLAG)']"" S NFLAG="ALL"
 S I=GMTS1 F  S I=$O(^TMP("LRC",$J,I)) Q:+I'>0!(I>GMTS2)  D
 . S J=0 F  S J=$O(^TMP("LRC",$J,I,J)) Q:+J'>0  D
 . . I NFLAG="ALL" S K="ALL"
 . . E  I $P(^TMP("LRC",$J,I,J),U,5)']"" S K="NORM"
 . . E  S K="ABNORM"
 . . S L=$P(^TMP("LRC",$J,I,J),U,2)
 . . I NFLAG="ALL"!(K=NFLAG) S ^TMP("LRC",$J,K,L,I,J)=^TMP("LRC",$J,I,J)
 . . K ^TMP("LRC",$J,I,J)
 Q
LINE ; Line-wrap with comma-dimited data
 N X,Y,TIUX
 S TIUX=$P($G(^TMP("LRC",$J,NORM,SMPL,I,J)),U,3,4)
 I $S($$HASNUM^TIULS($P(TIUX,U)):0,$L($P(TIUX,U))>5:1,$L($P(TIUX,U)," ")>1:1,1:0) D
 . S $P(TIUX,U)=$$MIXED^TIULS($P(TIUX,U))
 S $P(TIUX,U,2)=$TR($P(TIUX,U,2)," ",""),TIUX=$TR(TIUX,U," ")
 S TIUY=$$FILL^TIULS(TIUX,TIUY,79)
 I TIUY=TIUX S LINE=+$G(LINE)+1
 S @TARGET@(LINE,0)=TIUY
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 I +$G(DISPLAY) W "."
 Q
