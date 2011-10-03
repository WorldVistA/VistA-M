DPTVPR ;alb/mjk - Patient File Specific Init Driver ; 3/26/93
 ;;5.3;Patient File;;Aug 13, 1993
 ;
EN ; -- main entry point
 S XQABT3=$H
 D H^DGUTL
 S DPTIME(104)=DGTIME D H^DGUTL S DPTIME(105)=DGTIME
 D EN^DPTV53PR
ENQ Q
