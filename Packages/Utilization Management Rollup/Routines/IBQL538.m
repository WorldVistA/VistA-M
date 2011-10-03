IBQL538 ;LEB/MRY - IBQ EXTRACT DATA ; 6-JUN-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
ADMIT ; -- Extract Admission Review iformation
 ; -- input: IBTRN from ^ibq(538,ibtrn...
 ; -- output:  IB(array)=data
 ; .01:entry id,.02:site,.03:ssn,.04:admitting diagnosis,.05:enroll code
 ; .06:admitting phy,.07:attending phy,.08:resident phy,.09;admission
 ; .1:discharge,.11:ward,.12:treating specialty,.13:acute adm?
 ; 1.01:si from adm,1.02:is from adm,1.03:reasons from adm
 ; 1.04:provider interviewed?,1.05:adm influenced?,1.06:rollup type
 ; 1.07:service
 F IBFLD=.01:.01:.13,1.01:.01:1.07,"ACUTE ADMISSION" S IB(IBFLD)=""
ADMD S IBTRND=$G(^IBQ(538,IBTRN,0)),IBTRND1=$G(^(1))
 S IB(.01)=$P(IBTRND,"^"),IB(.02)=$P(IBTRND,"^",2),IB(.03)=$P(IBTRND,"^",3),IB(.04)=$P(IBTRND,"^",4),IB(.05)=$P(IBTRND,"^",5)
 S IB(.06)=$P(IBTRND,"^",6),IB(.07)=$P(IBTRND,"^",7),IB(.08)=$P(IBTRND,"^",8),IB(.09)=$P(IBTRND,"^",9)
 S IB(.1)=$P(IBTRND,"^",10),IB(.11)=$P(IBTRND,"^",11),IB(.12)=$P(IBTRND,"^",12),IB(.13)=$P(IBTRND,"^",13)
 S IB(1.01)=$P(IBTRND1,"^"),IB(1.02)=$P(IBTRND1,"^",2),IB(1.03)=$P(IBTRND1,"^",3),IB(1.04)=$P(IBTRND1,"^",4)
 S IB(1.05)=$P(IBTRND1,"^",5),IB(1.06)=$P(IBTRND1,"^",6),IB(1.07)=$P(IBTRND1,"^",7)
 I 'IB(1.03)!IB(.13) S IB("ACUTE ADMISSION")=1
 Q
 ;
STAY ; -- Extract Continued Stay Review information
 ; -- input: IBTRN, IBTRV  from ^ibq(538,ibtrn,13,ibtrv...
 ; -- output:  IB(array)=data
 ; 13.01:day, 13.02:is, 13.03:si, 13.04:d/s, 13.05:interviewed?
 ; 13.06:reasons, 13.07:treating specialty, 13.08:service
 F IBFLD=.01:.01:.08,"ACUTE STAY" S:IBFLD IB(13+IBFLD)="" S:'IBFLD IB(IBFLD)=""
STAYD S IBTRVD=$G(^IBQ(538,IBTRN,13,IBTRV,0))
 S IB(13.01)=$P(IBTRVD,"^",1),IB(13.02)=$P(IBTRVD,"^",2),IB(13.03)=$P(IBTRVD,"^",3),IB(13.04)=$P(IBTRVD,"^",4)
 S IB(13.05)=$P(IBTRVD,"^",5),IB(13.06)=$P(IBTRVD,"^",6),IB(13.07)=$P(IBTRVD,"^",7),IB(13.08)=$P(IBTRVD,"^",8)
 I 'IB(13.06) S IB("ACUTE STAY")=1
 Q
