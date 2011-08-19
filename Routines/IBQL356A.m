IBQL356A ;LEB/MRY - UM ROLLUP - IBT DATA EXTRACTS CONT. ; 8-AUG-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
RESETC ; -- Reset IB(array) for Claims Tracking and misc. information
 ; -- reset ib(field #) variables array
 ; .01:entry id,.02:site,.03:ssn,.04:admitting diagnosis,.05:enroll code
 ; .06:admitting phy,.07:attending phy,.08:resident phy,.09;admission
 ; .1:discharge,.11:ward,.12:treating specialty,1.06:rollup type
 ; 1.07:service
 F IBFLD=.01:.01:.12,1.06,1.07 S IB(IBFLD)=""
 Q
RESETA ; -- Reset IB(array) for Admission Review information
 ; .13:acute adm?,1.01:si from adm,1.02:is from adm,1.03:reasons from adm
 ; 1.04:provider intviewed?,1.05:adm influenced?
 ; ACUTE ADMISSION:1 if acute; null if non-acute
 F IBFLD=.13,1.01:.01:1.05,"ACUTE ADMISSION" S IB(IBFLD)=""
 Q
RESETS ; -- Reset IB(array) for Stay information
 ; 13.01:day,13.02:is,13.03:si,13.04:d/s,13.05:interviewed?,13.06:reasons
 ; 13.07:treating specialty,13.08:service
 ; ACUTE STAY:1 if acute-null if non-acute
 F IBFLD=.01:.01:.08,"ACUTE STAY" S:IBFLD IB(13+IBFLD)="" S:'IBFLD IB(IBFLD)=""
 Q
