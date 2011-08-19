MCNMDUP ;WISC/RMP,DAD-Duplicate "NM" node routine for Medicine ;4/22/96  12:19
 ;;2.3;Medicine;;09/13/1996
CHECK(COUNT) ;
 N X,XX,FILE,FIELD,ROOT,FROOT,HOLD,TEMP
 S COUNT=0
 F FILE=691.6,691.8,691.9,692,694,699,700 D
 . S X=$P(^DD(FILE,0),U)
 . I X'="FIELD" Q
 . S ROOT=$J(FILE,1,2),FROOT=FILE
 . F FIELD=0:0 S FIELD=$O(^DD(FILE,FIELD)) Q:'FIELD  D FIELD
 . Q
 I COUNT>0 D
 . F TEMP=1:1 S HOLD=$P($T(NOTE+TEMP),";;",2) Q:HOLD=""  W !,HOLD,!
 . Q
 Q  ;COUNT
FIELD S XX=+$P(^DD(FILE,FIELD,0),U,2)
 I XX D
 . D NMCHK(XX)
 . N FIELD,FILE,SFILE S (FILE,SFILE)=XX
 . F FIELD=0:0 S FIELD=$O(^DD(SFILE,FIELD)) Q:'FIELD  D FIELD
 . Q
 Q
NMCHK(NMFILE) ;
 N SUBNAME,XTRANAME
 S SUBNAME="",SUBNAME=$O(^DD(NMFILE,0,"NM",SUBNAME)) Q:SUBNAME=""
 S XTRANAME=$O(^DD(NMFILE,0,"NM",SUBNAME))
 I $L(XTRANAME)>0 D
 . W !,"Duplicate NM Node in file: ",NMFILE,$$MAINF(NMFILE)
 . S COUNT=COUNT+1
 . Q
 Q
MAINF(SFILE) ;
 Q $S(SFILE=FILE:"",1:" subfile of: "_FILE)
NOTE ;
 ;;The finding of duplicate "NM" nodes within the subfiles of
 ;;the above listed main files is a direct result of the some of
 ;;the reorganization which has occurred between versions of the
 ;;Medicine Package.
 ;;1) It is necessary at this time for you to record the main files
 ;;   listed above for FM Data Dictionary repairs.
 ;;2) From programmer mode enter FM and select DATA DICTIONARY UTILITIES.
 ;;3) Select the CHECK/FIX DD STRUCTURE option and submit each of the
 ;;4)Then restart the Medicine Installation from the ^MCARINS step.
 ;;
