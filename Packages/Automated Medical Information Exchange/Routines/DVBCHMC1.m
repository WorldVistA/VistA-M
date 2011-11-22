DVBCHMC1 ;ALB ISC/THM-TEXT FOR HEMATOLOGIC DISORDERS ; 12/9/90  11:16 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
PTXT F AW=0:1 S AX=$T(@TXT+AW) S AY=$P(AX,";;",2) W:AY="END" !! Q:AY="END"  W AY,!
 Q
 ;
TXT1 ;;   1.  Note whether disease is currently active or in remission -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;   2.  Note frequency of and average duration of acute attacks or sickling
 ;;       crises -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;   3.  Note level of physical activity the veteran is capable of between acute
 ;;       attacks/sickling crises and describe the state of general health between
 ;;       episodes -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;   4.  Note whether sickling crises have produced any permanent organ or joint
 ;;       impairment (e.g., splenic infarct or aseptic neurosis of femoral head)
 ;;       and whether splenectomy or joint replacement has been necessary -
 ;;END
