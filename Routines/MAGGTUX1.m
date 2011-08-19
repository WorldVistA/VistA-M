MAGGTUX1 ;WIOFO/GEK Imaging utility to track missing TYPE INDEX values.
 ;;3.0;IMAGING;**59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
REVIEW ;
 N CHK,FIX,MAGN
 S CHK=$D(^XTMP("MAGGTUXC"))
 S FIX=$D(^XTMP("MAGGTUX"))
 N EQ S $P(EQ,"=",78)=""
 W !,EQ
 I 'CHK,'FIX W !,"No reports to review." Q
 S X=$S(FIX:"F",1:"C")
 I CHK&FIX D
 . W !,"Review last Report of Checked or Fixed Index terms:  C/F   //F  :" R X:30
 I "fF"[$E(X) W !,"Starting Review of last Fixed Report:" S MAGN="MAGGTUX"
 E  W !,"Starting Review of last Checked Report:" S MAGN="MAGGTUXC"
 W !,"Summary of search for Images where TYPE INDEX = null"
 N I,PKG,BT,ICT,CT,J,JCT,TCT,TTCT
 S BT=0
 D 3
 ;
 W !,"Last Image IEN missing a Type Index : ",$P($G(^XTMP(MAGN,0,"NT")),"-")
 W ?41,$$FMTE^XLFDT($P($G(^XTMP(MAGN,0,"NT")),"-",2))
 W !,"Last Image IEN missing All Index : ",$P($G(^XTMP(MAGN,0,"NI")),"-")
 W ?41,$$FMTE^XLFDT($P($G(^XTMP(MAGN,0,"NI")),"-",2))
 W !,"------------------------------"
 S I="",TCT=0
 W !,"Different settings of invalid INDEX Node"
 W !,"Current Terms",?22,"Generated Terms",?50,"New Terms",!
 F  S I=$O(^XTMP(MAGN,"AAN40",I)) Q:I=""  D
 . S TCT=TCT+$G(^XTMP(MAGN,"AAN40",I))
 . W !,I,?20,^XTMP(MAGN,"AAN40",I),?65,"= ",TCT
 . S J="" F  S J=$O(^XTMP(MAGN,"AAN40",I,"CVT",J)) Q:J=""  D
 . . W !,I,?20,"+ ",J,?45,"= ",^XTMP(MAGN,"AAN40",I,"CVT",J)
 . Q
 ;
DISPLAY ; This is called after a CHECK or a FIX from MAGGTUX
 N A
 S A=$NA(^TMP($J,"MAGGTUX","RPT"))
 D BUILD(A)
 S I="" F  S I=$O(@A@(I)) Q:I=""  D MES^XPDUTL(^(I))
 Q
MAIL ; This will mail results to the MAG SERVER mail group.
 N A,MAGDT
 S MAGDT=$P($$FMTE^XLFDT($$NOW^XLFDT),"@",1)
 S A=$NA(^TMP($J,"MAGQ"))
 D BUILD(A)
 N XMSUB S XMSUB="Image Index Validate "_MAGDT_": Report"
 S @A@(1)=$$GET1^DIQ(200,$G(DUZ),.01)_"   "_$$GET1^DIQ(4,$G(DUZ(2)),.01)
 D MAILSHR^MAGQBUT1
 Q
BUILD(A) ;BUILD A TMP global of the report.
 N CT
 S CT=5 K @A
 S CT=CT+1,@A@(CT)="================================================================="
 S CT=CT+1,@A@(CT)="Start time                                    : "_$$FMTE^XLFDT($P(^XTMP(MAGN,0),"^",2))
 S CT=CT+1,@A@(CT)="End time                                      : "_$P($G(^XTMP(MAGN,0,"END")),"^",1)
 S CT=CT+1,@A@(CT)="Elapsed time                                  : "_$P($G(^XTMP(MAGN,0,"END")),"^",2)
 S CT=CT+1,@A@(CT)="Last Image IEN missing a Type Index           : "_$P($G(^XTMP(MAGN,0,"NT")),"-")_"  "_$$FMTE^XLFDT($P($G(^XTMP(MAGN,0,"NT")),"-",2))
 S CT=CT+1,@A@(CT)="Last Image IEN missing All Index              : "_$P($G(^XTMP(MAGN,0,"NI")),"-")_"  "_$$FMTE^XLFDT($P($G(^XTMP(MAGN,0,"NI")),"-",2))
 S CT=CT+1,@A@(CT)="Total Checked:                                  "_$G(^XTMP(MAGN,"AATCHK"))
 S CT=CT+1,@A@(CT)="   --   Entries Missing a Type Index    -- "
 S CT=CT+1,@A@(CT)="Total Study Groups & Single Images            : "_+$G(^XTMP(MAGN,"AANT"))
 S CT=CT+1,@A@(CT)="Total Group Images                            : "_$G(^XTMP(MAGN,"AAGRINT"))
 S CT=CT+1,@A@(CT)="   --   Entries Missing all Index Terms -- "
 S CT=CT+1,@A@(CT)="Total Study Groups & Single Images            : "_+$G(^XTMP(MAGN,"AANI"))
 S CT=CT+1,@A@(CT)="Total Group Images                            : "_$G(^XTMP(MAGN,"AAGRINI"))
 S CT=CT+1,@A@(CT)="   --   Other Index checks              -- "
 S CT=CT+1,@A@(CT)="  Total Origin Index fixes                    : "_$G(^XTMP(MAGN,"AAOFX"))
 S CT=CT+1,@A@(CT)="  CR -> CT fix                                : "_$G(^XTMP(MAGN,"AACRCT"))
 S CT=CT+1,@A@(CT)="      Total DataBase Changes                 =  "_+$G(^XTMP(MAGN,"AAFIX"))
 S CT=CT+1,@A@(CT)="                          "
 S CT=CT+1,@A@(CT)="Also : Information gathered during Check/Fix"
 S CT=CT+1,@A@(CT)=" - - - Generate Index Values and Merge  - - -  "
 S CT=CT+1,@A@(CT)="  The Merged proc/spec not valid. No change.)    "_$G(^XTMP(MAGN,"AANOMERG"))
 S CT=CT+1,@A@(CT)="  The Merged proc/spec was okay. Changed.        "_$G(^XTMP(MAGN,"AAOKMERG"))
 S CT=CT+1,@A@(CT)=" - - - other - - - "
 S CT=CT+1,@A@(CT)="  Total Groups of only 1 image     "_$G(^XTMP(MAGN,"AAGO1"))
 S CT=CT+1,@A@(CT)="  Total Groups of 0 images         "_$G(^XTMP(MAGN,"AAGO0"))
 S CT=CT+1,@A@(CT)="  Total Images w/No Patient        "_$G(^XTMP(MAGN,"AANOPAT"))
 S CT=CT+1,@A@(CT)="  Total Images w/No 0 node         "_$G(^XTMP(MAGN,"AANOZ"))
 S CT=CT+1,@A@(CT)="  Warnings: Generated Proc,Spec    "_$G(^XTMP(MAGN,"AAINVG"))
 S CT=CT+1,@A@(CT)="  Warnings: Entered   Proc,Spec    "_$G(^XTMP(MAGN,"AAINVO"))
 S IEN=$P(^XTMP(MAGN,0),"^",3)
 I +IEN D
 . S CT=CT+1,@A@(CT)=" "
 . S CT=CT+1,@A@(CT)="Last IEN Checked: "_IEN
 . S CT=CT+1,@A@(CT)="    Capture Date:     "_$$FMTE^XLFDT($P($G(^MAG(2005,IEN,2)),"^",1))
 . Q
 I IEN=0 D
 . S CT=CT+1,@A@(CT)=" "
 . S CT=CT+1,@A@(CT)="All Entries were checked"
 . Q
 S CT=CT+1,@A@(CT)=" "
 S CT=CT+1,@A@(CT)="For a summary of the last Check or Fix process"
 S CT=CT+1,@A@(CT)="Use the menu option: "
 S CT=CT+1,@A@(CT)="   ""REV    Review a Summary of the last Fix or Check process."""
 S CT=CT+1,@A@(CT)="================================================================="
 Q
 ;
3 ; called from above.  Display the Spec - Proc problems
 N MAIDX
 S MAIDX="MAIDXG"
 W !!,"Mismatch in the Generated Values of Specialty/SubSpec <-> Proc/Event",!
 D 31
 S MAIDX="MAIDXO"
 W !!,"Mismatch in the User entered Values of Specialty/SubSpec <-> Proc/Event",!
 D 31
 Q
31 ;
 N IT,IS,IP
 N I,SD,SUBO,I3,CT,J,MY
 S IT="" F  S IT=$O(^XTMP(MAGN,MAIDX,IT)) Q:IT=""  D
 . S IS="" F  S IS=$O(^XTMP(MAGN,MAIDX,IT,IS)) Q:IS=""  D
 . . S IP="" F  S IP=$O(^XTMP(MAGN,MAIDX,IT,IS,IP)) Q:IP=""  D
 . . . S CT=^(IP)
 . . . K MY D VALTUX1^MAGGTUX3(.MY,IT,IS,IP) W !,CT,"  "
 . . . S I="" F  S I=$O(MY(I)) Q:I=""  W ?7,MY(I),!
 . . . I $L($O(^MAG(2005.85,IP,1,"B",""))) W ?35,"Valid specs: "
 . . . S I3="" F  S I3=$O(^MAG(2005.85,IP,1,"B",I3)) Q:'I3  D
 . . . . W !,?35,$P(^MAG(2005.84,I3,0),"^")
 . . . . S SUBO=$P(^MAG(2005.84,I3,0),"^",3)
 . . . . I SUBO W " <",$P(^MAG(2005.84,SUBO,0),"^"),">"
 . . . . Q
 . . . K ^TMP($J,"MAGDCT")
 . . . S SD="" F  S SD=$O(^XTMP(MAGN,"MAIDSD",+IT,+IS,+IP,"SD",SD))  Q:SD=""  D
 . . . . S ^TMP($J,"MAGDCT",^XTMP(MAGN,"MAIDSD",+IT,+IS,+IP,"SD",SD))="Desc:    "_SD
 . . . S CT="" F J=1:1:5 S CT=$O(^TMP($J,"MAGDCT",CT),-1) Q:CT=""  W !,?7,CT,?15,"Desc:    ",^TMP($J,"MAGDCT",CT)
 . . . W !
 . . . Q
 . . Q
 . Q
 Q
