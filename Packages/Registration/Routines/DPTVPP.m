DPTVPP ;alb/mjk - Patient File Pre-Init Driver; 3/26/93
 ;;5.3;Patient File;;Aug 13, 1993
 ;
EN ; -- main entry point
 S XQABT1=$H
 D USER^DGVPP,VERS^DGVPP:$D(DIFQ),ROU^DGVPP:$D(DIFQ)
 I $D(DIFQ) D EN^DPTV53PP
 S XQABT2=$H
ENQ Q
