RTP311 ;ALB/JLU - ;Taken from RTP31 to bring its size down.
 ;;v 2.0;Record Tracking;;10/22/91 
HD W @IOF,!,"Record Pull List",$S(RTLIST="U":" [UPDATE ONLY]",RTLIST="N":" [NOT FILLABLE REQUESTS]",1:"")," - ",$P($P(RTAPL,"^"),";",2),?103,"Page    : ",RTPAGE,!,"[Institution : ",$P(^DIC(4,RTDV,0),"^"),"]",?103,"Run Date: ",Y
 W !,"[Sorted by: "
 W $S(RTSORT="C":"Clinic and Terminal Digits",RTSORT="A":"Clinic and Appointment Time",RTSORT="H":"Home Location and Terminal Digits",RTSORT="D":"Home Location,Clinic and Terminal Digits",$D(RTTDFL):"Terminal Digits",1:"Name"),"]"
 S Y=$E(RTDT,1,12) D D^DIQ W ?97,"Requested Date: ",Y
 W !!?5,"Name",!,?6,"SSN" W:RTSORT="T" "/Home Loc." W ?27,"Type",?33,"Request#",?42,"Status",?55,"Requestor",?72,"Time",?82,"Current Location",?105,"Other Requests for Record:" D LINE^RTUTL3
 ;;;W !!?5,"Name/SSN" W ?27,"Type",?33,"Request#",?42,"Status",?55,"Requestor",?72,"Time",?82,"Current Location",?105,"Other Requests for Record:" D LINE^RTUTL3
 Q
