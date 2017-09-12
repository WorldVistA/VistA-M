RMPRCPI1 ;HIN/RVD-CPT MODIFIER BUILD ;01/31/00
 ;;3.0;PROSTHETICS;**41**;Feb 09, 1996
 W !,"**** Invalid Entry Point...."
 Q
BUILD ;
 F I=0:0 S I=$O(^RMPR(661.1,I)) Q:I'>0  D
 .I ($D(^RMPR(661.1,I,4))) S ^RMPR(661.1,"RMPR",$P(^RMPR(661.1,I,0),U,1),4)=$G(^RMPR(661.1,I,4))
 ;
 K I
 Q
POST ;populate CPT Modifier and Base wheelchair, to be used in Post install.
 K R4 S I=""
 F  S I=$O(^RMPR(661.1,"RMPR",I)) Q:I=""   D
 .S RMI=$O(^RMPR(661.1,"B",I,0))
 .S R4=$G(^RMPR(661.1,"RMPR",I,4))
 .I $D(R4),$G(RMI) S ^RMPR(661.1,RMI,4)=R4
 .K R4
 K R4,I,RMI,^RMPR(661.1,"RMPR")
 Q
 ;END
